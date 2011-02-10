/**************************************************************************
 **                                                                        
 **  FILE : $Source$
 **                                                                        
 **  $Author: tomasz $                                                     
 **  $Log:$
 **************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "menu.h"
#include "lcd.h"
#include "global.h"
#include "keypad.h"
#include "flash.h"
#include "rtc.h"

#define STACK_SIZE 8
#define NO_LCD_X_OFFSET 0

typedef struct _Stack {
      unsigned char head;
      unsigned char tail;
      unsigned char buffer[STACK_SIZE]; 
} Stack;

Stack xdata stack;

volatile Blink_params * current_blink_params = NULL;
volatile BOOL blinking = TRUE;
unsigned char current_display_state = MAIN_STATE_ID;
unsigned char current_position = MAIN_STATE_POS;
unsigned char key_code = 0;
unsigned char enter_workloop;
unsigned int xdata battery_counter = 0;
unsigned char xdata update_flash = false;

SystemData xdata system_data;
struct tm xdata system_time;

unsigned long temp_long;

/**************************************************/
unsigned char ZONE_1_PREPARED = 0;
unsigned char ZONE_2_PREPARED = 0;
unsigned char ZONE_3_PREPARED = 0;
unsigned char ZONE_4_PREPARED = 0;
/**************************************************/

/***************************************************************************************/
/* Here we must be carefull with addressing. Flash data must fit in single 128 byte    */
/* page. If not data wont be programmed. SDCC doesn't allow to locate in FLASH !?      */
/***************************************************************************************/
#define ZERO_HOUR 0
#define FAKE_HOUR 123456

/*code SystemData flash_data = { { 3200,0,6400,0 },
                               {10,8,5,20},
                               {10,120,0},
                               {0,100,200,5},
                               {13,25,215},
                               {0,0,9999,0,1},
                               {2,FAKE_HOUR,1234},
                               {0,0,0,0,0,0},
                               {112,234,122,110,0000} };*/

typedef struct _zone_day {
      unsigned char zone;
      unsigned char day;
} ZoneDay;

#define WDAY_0    0
#define SATURDAY  5
#define SUNDAY    6

#define CHANNEL_DISABLED   0x0
#define CHANNEL_ENABLED    0x2
#define CHANNEL_FORCED_ON  0x4
#define CHANNEL_FORCED_OFF 0x8

ZoneDay code zone_day_map[] = {
   { 0, WDAY_0 },
   { 1, WDAY_0 },
   { 2, WDAY_0 },
   { 3, SATURDAY },
   { 4, SATURDAY },
   { 5, SATURDAY },
   { 6, SUNDAY },
   { 7, SUNDAY },
   { 8, SUNDAY },
   { 9, WDAY_0 },
   { 10, WDAY_0 },
   { 11, WDAY_0 },
   { 12, SATURDAY },
   { 13, SATURDAY },
   { 14, SATURDAY },
   { 15, SUNDAY },
   { 16, SUNDAY },
   { 17, SUNDAY },
   { 18, WDAY_0 },
   { 19, WDAY_0 },
   { 20, WDAY_0 },
   { 21, SATURDAY },
   { 22, SATURDAY },
   { 23, SATURDAY },
   { 24, SUNDAY },
   { 25, SUNDAY },
   { 26, SUNDAY },
   { 27, WDAY_0 },
   { 28, WDAY_0 },
   { 29, WDAY_0 },
   { 30, SATURDAY },
   { 31, SATURDAY },
   { 32, SATURDAY },
   { 33, SUNDAY },
   { 34, SUNDAY },
   { 35, SUNDAY }
};


code unsigned char * code dfp = FLASH_START_POINT;

typedef struct _Data_Display {
      unsigned char x;
      unsigned char y;
      unsigned char point;
      const char *width;
} Data_Display;

typedef struct _Min_Max_params {
      unsigned int min;
      unsigned int max;
} Min_Max_params;

typedef union _Blink_union {
      Blink_params *blink;
      Min_Max_params *min_max;
} Blink_union;

typedef struct _MenuItem {
      char previous;
      char next;
      Blink_union blink_union;
      Data_Display *display;
} MenuItem;

#define MAX_MENU_ITEMS 7

typedef struct _Menu {
      char *text;
      char max_pos;
      MenuItem item[MAX_MENU_ITEMS];
} Menu;

typedef enum _DateTimeDisplay {
   ASCTIME_FORMAT,
   DATE_FORMAT,
   TIME_FORMAT,
   ASCTIME_SHORT_FORMAT,
   WEEKDAY
} DateTimeDisplay;

typedef enum _Min_Max_enum {
   PULL_LEN = 0,
   STEPS,
   CLEAR_LEN,
   DELAY,
   PULL_SPEED,
   CLEAR_SPEED,
   INCH_SPEED,
   RAMP,
   ENABLE_ALARM,
   ROLL_SIZE,
   HOLO_OFFSET,
   HOLO_OVERRUN,
   HOLO_SPEED,
   PULL_RAMP_OFFSET,
   INITIAL_SPEED_OFFSET
} Min_Max_Enum;

Min_Max_params code minmax[] = {
   { 0, 9999},   /*PULL_LEN*/
   { 0, 99 },    /*STEPS*/
   { 0, 9999 },  /*CLEAR_LEN*/
   { 0, 2000 },  /*DELAY*/
   { 1, 10 },    /*PULL_SPEED*/
   { 1, 10 },    /*CLEAR_SPEED*/
   { 1, 10 },    /*INCH_SPEED*/
   { 1, 20 },    /*RAMP*/
   { 0, 99 },    /*ENABLE_ALARM*/
   { 0, 999 },   /*ROLL_SIZE*/
   { 0, 100 },   /*HOLO_OFFSET*/
   { 0, 200 },   /*HOLO_OVERRUN*/
   { 1, 10 },    /*HOLO_SPEED*/
   { 1, 99 },    /*PULL_RAMP_OFFSET*/
   { 160, 255 }  /*INITIAL_SPEED_OFFSET*/
};

#define NO_BLINK &bpr[0]

#define BLINK_1_LINE   1
#define BLINK_2_LINES  2

Blink_params code bpr[] = {
   { EMPTY, "", "","","", EMPTY },
   { 0, "Schody","      ","","",BLINK_1_LINE },
   { 7, "Parking","       ","","",BLINK_1_LINE},
   { 15, "Socjal","      ","","",BLINK_1_LINE},
   { 22, "Magazyn","       ","","",BLINK_1_LINE},
   { 35, "Zegar","     ","","",BLINK_1_LINE},
   { 33, "System","      ","Setup","     ",BLINK_2_LINES},
   // { 8, "Pull", "    ","","",BLINK_1_LINE},
   { 5, "Pon-Piatek", "          ","","",BLINK_1_LINE},
   { 17, "Sobota", "      ","","",BLINK_1_LINE},
   { 25, "Niedziela", "         ","","",BLINK_1_LINE},
   { 36, "WYJS", "    ","","",BLINK_1_LINE}, /* 10 */
   { 0, "Z1", "  ","","",BLINK_1_LINE},
   { 14, "Z2", "  ","","",BLINK_1_LINE},
   { 28, "Z3", "  ","","",BLINK_1_LINE},
   { 28, "Ramp", "    ","","",BLINK_1_LINE},
   { 36, "WYJS", "    ","","",BLINK_1_LINE},
   { 9, "Enable", "      ","","",BLINK_1_LINE},
   { 18, "Roll Size", "         ","","",BLINK_1_LINE},
   { 36, "WYJS", "    ","","",BLINK_1_LINE},
   { 8, "Impress", "       ","","",BLINK_1_LINE},
   { 17, "Foil used", "         ","","",BLINK_1_LINE}, /* 20 */
   { 29, "Reset", "     ","","",BLINK_1_LINE},
   { 36, "WYJS", "    ","","",BLINK_1_LINE},
   { 7, "Active", "      ","","",BLINK_1_LINE},
   { 14, "Offset", "      ","","",BLINK_1_LINE},
   { 21, "Overrun", "       ","","",BLINK_1_LINE}, 
   { 29, "Speed", "     ","","",BLINK_1_LINE},
   { 36, "WYJS", "    ","","",BLINK_1_LINE},
   { 28, "Delay", "     ","","",BLINK_1_LINE}, /* 28 */
   { 0, "Data", "    ","","",BLINK_1_LINE},    /* 29 */
   { 12, "Czas", "    ","","",BLINK_1_LINE},    /* 30 */
   { 25, "System", "      ","Maintenance","           ",BLINK_2_LINES},    /* 31 */
   { 0, "B&H", "   ","","",BLINK_1_LINE},    /* 32 */
   { 9, "Pull", "    ","","",BLINK_1_LINE},    /* 33 */
   { 15, "Ratio", "     ","","",BLINK_1_LINE},    /* 34 */
   { 22, "Holo", "    ","","",BLINK_1_LINE},    /* 35 */
   { 28, "Total", "     ","","",BLINK_1_LINE},  /* 36 */
   { 15, "Ramp", "    ","","",BLINK_1_LINE},    /* 37 */
   { 21, "Initial speed", "             ","","",BLINK_1_LINE},     /* 38 */
   { 5, "PM", "  ","","",BLINK_1_LINE},     /* 39 */
   { 8, "Activation", "          ","","",BLINK_1_LINE},     /* 40 */
   { 19, "Password", "        ","","",BLINK_1_LINE},     /* 41 */
   { 28, "Status", "      ","","",BLINK_1_LINE},     /* 42 */
   /*heater*/
   { 23, "Dzien", "     ","","",BLINK_1_LINE}     /* 43 */
};

#define NO_DISPLAY &dpl[0]

Data_Display code dpl[] = {
   { EMPTY, EMPTY, EMPTY, "" },
   { 8, 1, 3, "%04u" },
   { 15, 1, 0, "%02u" },
   { 21, 1, 3, "%04u" },
   { 9, 1, 0, "%02u" },
   { 15, 1, 0, "%02u" },
   { 22, 1, 0, "%02u" },
   { 28, 1, 0, "%02u" },
   { 9, 1, 0, "%02u" },
   { 18, 1, 0, "%03u" },
   { 8, 1, 0, "%07lu" }, /* 10 */
   { 17, 1, 0, "%04u"},
   { 29, 1, 0, "%03u"},
   { 7, 1, 0, "%01u" },
   { 14, 1, 2, "%03u" },
   { 21, 1, 2, "%03u" },
   { 29, 1, 0, "%02u" },
   { 7, 1, 0, "%02u" },
   { 14, 1, 2, "%03u" },
   { 21, 1, 2, "%03u" },
   { 35, 0, 3, "%04u" },   
   { 38, 0, 0, "%02u" }, /* 21 */
   { 37, 0, 0, "%03u" },
   { 37, 0, 0, "%01u" },
   { 37, 1, 0, "%01u" },
   { 36, 0, 2, "%03u" },
   { 28, 1, 0, "%04u" }, /* 26 */
   { 36, 0, 0, "%04u" },  /* 27 */
   { 0, 1, 0, "NONE" },   /* 28 */
   { 12, 1, 0, "NONE" },   /* 29 */
   { 22, 1, 0, "%01u" },
   { 15, 1, 0, "%01u" },
   { 0, 1, 0, "%01u" },
   { 9, 1, 3, "%04u" }, /*33*/
   { 37, 0, 0, "%01u" },  /*34*/
   { 30, 0, 0, "%04u-%02u-%02u" },   /* 35 */
   { 32, 0, 0, "%02u:%02u:%02u" },   /* 36 */
   { 28, 1, 0, "%08lu" },            /* 37 */
   { 28, 1, 0, "%08lu" },            /* 38 */
   { 21, 1, 0, "%03u"  },             /* 39 */
   { 8, 1, 0, "%04u-%02u-%02u" },  /* 40 */
   { 19, 1, 0, "%04u" },             /* 41 */
   { 30, 0, 0, "%04u-%02u-%02u" },  /* 42 */
   { 36, 0, 0, "%04u" }, /* 43 */
   { 36, 1, 0, "%04u" }, /* 44 */
   { 28, 1, 0, "%01u" }, /* 45 */
   //Heater starts here
   { 28, 1, 0, "NONE" },   /* 46 */
   { 0,  1, 2, "%03u" },  /*47 */
   { 7,  1, 2, "%03u" },  /*48 */
   { 15,  1, 2, "%03u" },  /*49 */
   { 22,  1, 2, "%03u" },  /*50 */
   { 23,  1, 2, "NONE" },  /*51 */
   { 37, 0, 0,  "NONE" },  /*52*/
   { 0, 1, 0,  "NONE" },  /*53*/
   { 14, 1, 0,  "NONE" },  /*54*/
   { 28, 1, 0,  "NONE" },  /*55*/
   { 16, 0, 0,  "NONE" }  /*56*/
};

// ZONE_1_INPUT_POS should point to zone[0] so offset is 18 !!!!
#define POS_2_ZONE_OFFSET 18

typedef enum _SubPositions_0 {
   MAIN_STATE_POS = 0,
   SCHODY_POS,
   PARKING_POS,
   SOCJALNE_POS,
   MAGAZYN_POS,
   SYSTEM_SETUP_POS,
   ZONE_1_SETUP_POS,
   ZONE_2_SETUP_POS,
   ZONE_3_SETUP_POS,
   ZONE_4_SETUP_POS,
   ZONE_5_SETUP_POS,
   ZONE_6_SETUP_POS,
   ZONE_7_SETUP_POS,
   ZONE_8_SETUP_POS,
   ZONE_9_SETUP_POS,
   ZONE_10_SETUP_POS,
   ZONE_11_SETUP_POS,
   ZONE_12_SETUP_POS,
   ZONE_1_INPUT_POS = 18,
   ZONE_2_INPUT_POS,
   ZONE_3_INPUT_POS,
   ZONE_4_INPUT_POS,
   ZONE_5_INPUT_POS,
   ZONE_6_INPUT_POS,
   ZONE_7_INPUT_POS,
   ZONE_8_INPUT_POS,
   ZONE_9_INPUT_POS,
   ZONE_10_INPUT_POS,
   ZONE_11_INPUT_POS,
   ZONE_12_INPUT_POS,
   ZONE_13_INPUT_POS,
   ZONE_14_INPUT_POS,
   ZONE_15_INPUT_POS,
   ZONE_16_INPUT_POS,
   ZONE_17_INPUT_POS,
   ZONE_18_INPUT_POS,
   ZONE_19_INPUT_POS,
   ZONE_20_INPUT_POS,
   ZONE_21_INPUT_POS,
   ZONE_22_INPUT_POS,
   ZONE_23_INPUT_POS,
   ZONE_24_INPUT_POS,
   ZONE_25_INPUT_POS,
   ZONE_26_INPUT_POS,
   ZONE_27_INPUT_POS,
   ZONE_28_INPUT_POS,
   ZONE_29_INPUT_POS,
   ZONE_30_INPUT_POS,
   ZONE_31_INPUT_POS,
   ZONE_32_INPUT_POS,
   ZONE_33_INPUT_POS,
   ZONE_34_INPUT_POS,
   ZONE_35_INPUT_POS,
   ZONE_36_INPUT_POS,
   DATE_SETUP_POS,
   TIME_SETUP_POS,
   BATTERY_LOW_POS,
   DAY_SETUP_POS,
   LATEST_DONT_REMOVE
} SubPositons_0;

const Menu code menu[] = {
   { /* MAIN_STATE_POS */
      "Schody Parking Socjal Magazyn      Zegar                                      ",
      5,
      { 
         { MAIN_STATE_ID, SCHODY_POS,      { &bpr[1] }, { &dpl[47] }   },
         { MAIN_STATE_ID, PARKING_POS,   { &bpr[2] }, { &dpl[48] }   },
         { MAIN_STATE_ID, SOCJALNE_POS,     { &bpr[3] }, { &dpl[49] }   },
         { MAIN_STATE_ID, MAGAZYN_POS,    { &bpr[4] }, { &dpl[50] }   },
         { MAIN_STATE_ID, SYSTEM_SETUP_POS,   { &bpr[5] }, { &dpl[46] }   },
      }
   },
   { /* SCHODY_POS */
      "Sch->Pon-Piatek  Sobota  Niedziela  WYJS",
      4,
      { 
         { MAIN_STATE_ID, ZONE_1_SETUP_POS, { &bpr[7] }, { NO_DISPLAY  } },
         { MAIN_STATE_ID, ZONE_2_SETUP_POS, { &bpr[8] }, { NO_DISPLAY  } },
         { MAIN_STATE_ID, ZONE_3_SETUP_POS, { &bpr[9] }, { NO_DISPLAY } },
         { MAIN_STATE_ID, EXIT_POS_ID, { &bpr[10] }, { NO_DISPLAY  } }
      }
   },
   { /* PARKING_POS */
      "Par->Pon-Piatek  Sobota  Niedziela  WYJS",
      4,
      { 
         { MAIN_STATE_ID, ZONE_4_SETUP_POS, { &bpr[7] }, { NO_DISPLAY  } },
         { MAIN_STATE_ID, ZONE_5_SETUP_POS, { &bpr[8] }, { NO_DISPLAY  } },
         { MAIN_STATE_ID, ZONE_6_SETUP_POS, { &bpr[9] }, { NO_DISPLAY } },
         { MAIN_STATE_ID, EXIT_POS_ID, { &bpr[10] }, { NO_DISPLAY  } }
      }
   },
   { /* SOCJALNE_POS */
      "Soc->Pon-Piatek  Sobota  Niedziela  WYJS",
      4,
      { 
         { MAIN_STATE_ID, ZONE_7_SETUP_POS, { &bpr[7] }, { NO_DISPLAY  } },
         { MAIN_STATE_ID, ZONE_8_SETUP_POS, { &bpr[8] }, { NO_DISPLAY  } },
         { MAIN_STATE_ID, ZONE_9_SETUP_POS, { &bpr[9] }, { NO_DISPLAY } },
         { MAIN_STATE_ID, EXIT_POS_ID, { &bpr[10] }, { NO_DISPLAY  } }
      }
   },
   { /* MAGAZYN_POS */
      "Mag->Pon-Piatek  Sobota  Niedziela  WYJS",
      4,
      { 
         { MAIN_STATE_ID, ZONE_10_SETUP_POS, { &bpr[7] }, { NO_DISPLAY  } },
         { MAIN_STATE_ID, ZONE_11_SETUP_POS, { &bpr[8] }, { NO_DISPLAY  } },
         { MAIN_STATE_ID, ZONE_12_SETUP_POS, { &bpr[9] }, { NO_DISPLAY } },
         { MAIN_STATE_ID, EXIT_POS_ID, { &bpr[10] }, { NO_DISPLAY  } }
      }
   },
   { /* SYSTEM_SETUP_POS */
      "Data        Czas       Dzien        WYJS",
      4,
      { 
         { MAIN_STATE_ID, DATE_SETUP_POS, { &bpr[29] }, { &dpl[28] }    },
         { MAIN_STATE_ID, TIME_SETUP_POS, { &bpr[30] }, { &dpl[29] }    },
         { MAIN_STATE_ID, DAY_SETUP_POS,  { &bpr[43] }, { &dpl[51] }    },
         { MAIN_STATE_ID, EXIT_POS_ID, { &bpr[27] }, { NO_DISPLAY}      }
      }
   },
   { /* ZONE_1_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { SCHODY_POS, ZONE_1_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { SCHODY_POS, ZONE_2_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { SCHODY_POS, ZONE_3_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { SCHODY_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_2_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { SCHODY_POS, ZONE_4_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { SCHODY_POS, ZONE_5_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { SCHODY_POS, ZONE_6_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { SCHODY_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_3_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { SCHODY_POS, ZONE_7_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { SCHODY_POS, ZONE_8_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { SCHODY_POS, ZONE_9_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { SCHODY_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_4_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { PARKING_POS, ZONE_10_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { PARKING_POS, ZONE_11_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { PARKING_POS, ZONE_12_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { SCHODY_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_5_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { PARKING_POS, ZONE_13_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { PARKING_POS, ZONE_14_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { PARKING_POS, ZONE_15_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { PARKING_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_6_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { PARKING_POS, ZONE_16_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { PARKING_POS, ZONE_17_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { PARKING_POS, ZONE_18_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { PARKING_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_7_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { SOCJALNE_POS, ZONE_19_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { SOCJALNE_POS, ZONE_20_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { SOCJALNE_POS, ZONE_21_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { SOCJALNE_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_8_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { SOCJALNE_POS, ZONE_22_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { SOCJALNE_POS, ZONE_23_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { SOCJALNE_POS, ZONE_24_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { SOCJALNE_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_9_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { SOCJALNE_POS, ZONE_25_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { SOCJALNE_POS, ZONE_26_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { SOCJALNE_POS, ZONE_27_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { SOCJALNE_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_10_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { MAGAZYN_POS, ZONE_28_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { MAGAZYN_POS, ZONE_29_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { MAGAZYN_POS, ZONE_30_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { MAGAZYN_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_11_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { MAGAZYN_POS, ZONE_31_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { MAGAZYN_POS, ZONE_32_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { MAGAZYN_POS, ZONE_33_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { MAGAZYN_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_12_SETUP_POS */
      "Z1 00C        Z2 00C        Z3 00C  WYJS",
      4,
      { 
         { MAGAZYN_POS, ZONE_34_INPUT_POS, { &bpr[11] }, { &dpl[53] }  },
         { MAGAZYN_POS, ZONE_35_INPUT_POS, { &bpr[12] }, { &dpl[54] } },
         { MAGAZYN_POS, ZONE_36_INPUT_POS, { &bpr[13] }, { &dpl[55] }  },
         { MAGAZYN_POS, EXIT_POS_ID, { &bpr[15] }, { NO_DISPLAY }  }
      }
   },
   { /* ZONE_1_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_1_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_2_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_1_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_3_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_1_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_4_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_2_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_5_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_2_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_6_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_2_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_7_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_3_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_8_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_3_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_9_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_3_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_10_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_4_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_11_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_4_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_12_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_4_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_13_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_5_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_14_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_5_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_15_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_5_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_16_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_6_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_17_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_6_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_18_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_6_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_19_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_7_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_20_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_7_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_21_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_7_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_22_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_8_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_23_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_8_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_24_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_8_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_25_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_9_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_26_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_9_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_27_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_9_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_28_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_10_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_29_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_10_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_30_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_10_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_31_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_11_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_32_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_11_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_33_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_11_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_34_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_12_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_35_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_12_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* ZONE_36_INPUT_POS */
      "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:**-**:** Temp:    **C",
      2,
      { 
         { ZONE_12_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[56] }}
      }
   },
   { /* DATE_SETUP_POS */
      "Current system DATE value   :              New value (YYYY-MM-DD)   : ****-**-**",
      2,
      { 
         { SYSTEM_SETUP_POS, EMPTY, { &minmax[DELAY] }, { &dpl[35] }}
      }
   },
   { /* TIME_SETUP_POS */
      "Current system TIME value   :                New value (HH:MM:SS)   :   **:**:**",
      2,
      { 
         { SYSTEM_SETUP_POS, EMPTY, { &minmax[DELAY] }, { &dpl[36] }}
      }
   },
   { /* BATTERY_LOW_POS */
      " BATERIA ROZLADOWANA !!! WYMIEN BATERIE          ENTER ZEBY KONTYNUOWAC  !",
      2,
      { 
         { MAIN_STATE_ID, EMPTY, { NO_BLINK }, { &dpl[34] }}
      }
   },
   { /* DAY_SETUP_POS */
      "Ustaw dzien tygodnia       Biezacy:     uzywajac strzalek             Nowy:  ***",
      2,
      { 
         { SYSTEM_SETUP_POS, EMPTY, { NO_BLINK }, { &dpl[52] }}
      }
   }
};

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */


void stack_push_back(const unsigned char push)
{
   stack.buffer[ stack.head++ ] = push;
   stack.head &= ( STACK_SIZE - 1 );
}

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */


unsigned char stack_pop_front(void)
{
   unsigned char retval = 0;

   if (stack.head != stack.tail) 
   {
      retval = stack.buffer[ --stack.head ];
      stack.head &= ( STACK_SIZE - 1 );
   }

   return retval;
}

void stack_purge(void)
{
   stack.head = 0;
   stack.tail = 0;
}

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */

void flash_init(void)
{
   unsigned char *flash = (unsigned char*)dfp;
   unsigned char *xram = (unsigned char*)system_data;
   unsigned int count;

   lcd_clear();
   if (*flash == 0xFF) // In the first run when flash memory is cleared we need to set default values
   {
      printf_fast("Programowanie pamieci: (   ) z (%d). Prosze czekac ...", SYSTEM_DATA_SIZE);
      for (count=0 ; count < SYSTEM_DATA_SIZE; count++)
      {
         flash_write_byte(0x0, (unsigned int)flash++);
         *xram++ = 0;
         lcd_goto_xy(24,0);
         printf_fast("%03u", count);
         SERVICE_WATCHDOG;
      }
   }
   else
   {
      lcd_goto_xy(0,0);
      printf_fast("Odczyt ustawien: (   ) z (%d). Prosze czekac ...", SYSTEM_DATA_SIZE);
      for (count=0 ; count < SYSTEM_DATA_SIZE; count++)
      {
         lcd_goto_xy(18,0);
         printf_fast("%03u", count);
         *xram++ = *flash++;
      }
   }
}

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */

void set_new_blink(void)
{
   BLINKING_OFF;

   lcd_goto_xy(current_blink_params->position, 0);
   lcd_put_string(current_blink_params->first_pattern_on);
   
   if (current_blink_params->lines > 1)
   {
      lcd_goto_xy(current_blink_params->position, 1);
      lcd_put_string(current_blink_params->second_pattern_on);
   }
   current_blink_params = menu[current_display_state].item[current_position].blink_union.blink;

   BLINKING_ON;
}

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */

/*
void display_stored_long(const unsigned long value, const char pos)
{
   Data_Display *display;
   
   display = menu[current_display_state].item[pos].display;
   lcd_goto_xy(display->x, display->y);
   printf_fast((char code*)display->width,value);
}

void display_stored_int(const unsigned int value, const char pos) 
{
   Data_Display *display;
   
   display = menu[current_display_state].item[pos].display;
   lcd_goto_xy(display->x, display->y);
   printf_fast((char code*)display->width,value);
}
*/

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */

void display_zone_setings(const char zone)
{
   Data_Display *display;
   unsigned char i;

   BLINKING_OFF;

   ds1302_read_rtc(&system_time);

   for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
   {
      display = menu[current_display_state].item[i].display;
      lcd_goto_xy(display->x, display->y);

      if (system_data.zone_settings[zone+i].start_time == 0)
      {
         printf_fast("WYLACZONE  ");
         lcd_goto_xy(display->x+3, 0);
         printf_fast("--");
      }
      else
      {
         local_gmtime(&system_data.zone_settings[zone+i].start_time);
         //local_gmtime(&system_data.zone_settings[zone].start_time);
         printf_fast("%02u:%02u", 
                     (unsigned int)system_time.tm_hour,
                     (unsigned int)system_time.tm_min);
      
         printf_fast("-");
         local_gmtime(&system_data.zone_settings[zone+i].stop_time);
         //local_gmtime(&system_data.zone_settings[zone].stop_time);
         
         printf_fast("%02u:%02u", 
                     (unsigned int)system_time.tm_hour,
                     (unsigned int)system_time.tm_min);
         
         lcd_goto_xy(display->x+3, 0);
         printf_fast("%02u",system_data.zone_settings[zone+i].temperature);
         //printf_fast("%02u",system_data.zone_settings[zone].temperature);
      }
   }
   BLINKING_ON;
}

void display_stored_time(const char pos, const char method, const char display_force)
{
   static unsigned char sec;
   Data_Display *display;
   ds1302_read_rtc(&system_time);

   if (sec != system_time.tm_sec || display_force == true)
   {
      sec = system_time.tm_sec;
      switch (method)
      {
         case ASCTIME_FORMAT:
            BLINKING_OFF;
            display = menu[current_display_state].item[pos].display;
            lcd_goto_xy(display->x, display->y);
            printf_asctime(&system_time);
            BLINKING_ON;
            break;

         case ASCTIME_SHORT_FORMAT:
            BLINKING_OFF;
            display = menu[current_display_state].item[pos].display;
            lcd_goto_xy(display->x, display->y);
            printf_short_asctime(&system_time);
            BLINKING_ON;
         break;

         case DATE_FORMAT:
            display = menu[current_display_state].item[current_position].display;
            lcd_goto_xy(display->x, display->y);
            printf_fast("%04u-%02u-%02u", 
                        (unsigned int)system_time.tm_year + 2000,
                        (unsigned int)system_time.tm_mon + 1,
                        (unsigned int)system_time.tm_mday);
            break;
            
         case TIME_FORMAT:
            display = menu[current_display_state].item[current_position].display;
            lcd_goto_xy(display->x, display->y);
            printf_fast("%02u:%02u:%02u", 
                        (unsigned int)system_time.tm_hour,
                        (unsigned int)system_time.tm_min,
                        (unsigned int)system_time.tm_sec);
         break;

         case WEEKDAY:
            display = menu[current_display_state].item[current_position].display;
            lcd_goto_xy(display->x, display->y);
            printf_weekday_short(&system_time);
            break;
      }
   }
}

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */

void display_stored_data(unsigned int *value, const char display_force)
{
   static unsigned char sec;
   unsigned int temp;
   unsigned char i;
   unsigned int j;
   Data_Display *display;

   ds1302_read_rtc(&system_time);

   if (sec != system_time.tm_sec || display_force == true)
   {
      BLINKING_OFF;
      sec = system_time.tm_sec;

      for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
      {
         display = menu[current_display_state].item[i].display;
         
         temp = *value;
         lcd_goto_xy(display->x, display->y);
         printf_fast((char code*)display->width,temp);
         
         if (display->point > 0)
         {       
            temp = *value;
            j = (unsigned int)(temp % 10);
            lcd_goto_xy(display->x+display->point, display->y);
            printf_fast(".%d",j);
         }
         value++;      
      }
      BLINKING_ON;
   }
}

void switch_zone(const char zone_no)
{
   switch(zone_no)
   {
      case 0:
         ZONE_1_OUTPUT = ZONE_1_PREPARED;
         break;
      case 1:
         ZONE_2_OUTPUT = ZONE_2_PREPARED;
         break;
      case 2:
         ZONE_3_OUTPUT = ZONE_3_PREPARED;
         break;
      case 3:
         ZONE_4_OUTPUT = ZONE_4_PREPARED;
         break;
   }
}

void switch_zone_prepare(const char zone_no, const bool value)
{
   switch(zone_no)
   {
      case 0:
         ZONE_1_PREPARED = value;
         break;
      case 1:
         ZONE_2_PREPARED = value;
         break;
      case 2:
         ZONE_3_PREPARED = value;
         break;
      case 3:
         ZONE_4_PREPARED = value;
         break;
   }
}

void display_enabled_channels(const char display_force)
{
   static unsigned char sec;
   unsigned char i;
   Data_Display *display;

   ds1302_read_rtc(&system_time);

   if (sec != system_time.tm_sec || display_force == true)
   {
      BLINKING_OFF;
      sec = system_time.tm_sec;
      for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
      {
         if ( i < NUMBER_OF_CHANNELS)
         {
            display = menu[current_display_state].item[i].display;
            
            lcd_goto_xy(display->x+4, display->y);
            switch(system_data.enabled[i])
            {
               case CHANNEL_ENABLED:
                  printf_fast("+");
                  //switch_zone(i, 1);
                  break;
               case CHANNEL_DISABLED:
                  printf_fast("-");
                  //switch_zone(i, 0);
                  break;
               case CHANNEL_FORCED_ON:
                  printf_fast("*");
                  switch_zone_prepare(i,1);
                  switch_zone(i);
                  break;
               case CHANNEL_FORCED_OFF:
                  printf_fast("#");
                  switch_zone_prepare(i,0);
                  switch_zone(i);
                  break;
            }
         }
      }
      BLINKING_ON;
   }
}
 

unsigned char is_day_matching(const char zone, const char wday)
{
   unsigned char config_day;
   unsigned char current_day;

   current_day = wday;
   if (wday < 6)
      current_day = 0;

   config_day = zone_day_map[zone].day;
   if(config_day == current_day)
      return true;
   else
      return false;
}

#define ZONES_COUNT 9
#define CHANNELS_COUNT 4

void control_workloop(void)
{
   unsigned char i,j=0;
   unsigned char offset=0;
   unsigned int result;
   unsigned char weekday;
   unsigned char histereza = 0;
   ds1302_read_rtc(&system_time);

   //minutes first - complicated due long type compiler bug   
   temp_long = system_time.tm_hour;
   temp_long *= 3600;
   result = system_time.tm_min * 60;
   temp_long += result;
   temp_long += system_time.tm_sec;

   for (j = 0; j<CHANNELS_COUNT; j++)
   {
      for (i = 0; i<ZONES_COUNT; i++)
      {
         if (system_data.enabled[j] == CHANNEL_ENABLED || system_data.enabled[j] == CHANNEL_DISABLED)
         {
            offset = j*ZONES_COUNT + i;
            weekday = is_day_matching(offset, system_time.tm_wday);
            if (weekday == true)
            {
               if (system_data.zone_settings[offset].start_time > 0)
               {
                  if (temp_long >= system_data.zone_settings[offset].start_time)
                  {
                     if(temp_long < system_data.zone_settings[offset].stop_time)
                     {
                        if (system_data.temperatures[j] < system_data.zone_settings[offset].temperature*10 - histereza)
                        {
                           system_data.enabled[j] = CHANNEL_ENABLED;
                           switch_zone_prepare(j, 1);
                           histereza = 0;
                        }
                        else if (system_data.temperatures[j] >= system_data.zone_settings[offset].temperature*10)
                        {
                           system_data.enabled[j] = CHANNEL_DISABLED;
                           switch_zone_prepare(j, 0);
                           histereza = 1;
                        }
                        // this channel is done - move to next channel
                        i=ZONES_COUNT;
                     }
                     else
                     {
                        system_data.enabled[j] = CHANNEL_DISABLED;
                        switch_zone_prepare(j, 0);
                     }
                  }
                  else
                  {
                     system_data.enabled[j] = CHANNEL_DISABLED;
                     switch_zone_prepare(j, 0);
                  }   
               }
               else
               {
                  system_data.enabled[j] = CHANNEL_DISABLED;
                  switch_zone_prepare(j, 0);
               }
            }
         }
      }
   }
   switch_zone(0);
   switch_zone(1);
   switch_zone(2);
   switch_zone(3);
}

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */

/*void check_force_keys(const unsigned char channel)
{
   unsigned char key_code;

   if (keypad_check_front() == DATA_AVAILABLE)
   {
      key_code = keypad_pop_front();
      
      switch (key_code)
      {
         case STAR:
            if(system_data.enabled[channel] != CHANNEL_FORCED_ON)
               system_data.enabled[channel] = CHANNEL_FORCED_ON;
            else
               system_data.enabled[channel] = CHANNEL_DISABLED;
            break;
            
         case SHARP:
            if(system_data.enabled[channel] != CHANNEL_FORCED_OFF)
               system_data.enabled[channel] = CHANNEL_FORCED_OFF;
            else
               system_data.enabled[channel] = CHANNEL_DISABLED;
            break;
      }
   }
}
*/
 
unsigned char check_external_events(void)
{
   unsigned char retval;
   retval = 0;

   if (current_display_state == SYSTEM_SETUP_POS)
   {
      display_stored_time(0,ASCTIME_FORMAT,false);
   }

   if (current_display_state == MAIN_STATE_POS)
   {
      display_stored_data((unsigned int*)system_data.temperatures,false);
      display_enabled_channels(false);
      display_stored_time(4,ASCTIME_SHORT_FORMAT,false);

      //check_force_keys(current_position);
   }

   if (current_display_state != DAY_SETUP_POS &&
       current_display_state != TIME_SETUP_POS &&
       current_display_state != DATE_SETUP_POS )
   {
      control_workloop();
   }

   return retval;
}

void menu_previous_position()
{
    current_display_state = menu[current_display_state].item[current_position].previous;
    current_position = stack_pop_front();
}



/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */


unsigned long reset_workloop(const unsigned long value)
{
   unsigned char exit = 0;
   unsigned int result;
   
   BLINKING_OFF;
   result = value;

   while(exit == 0)
   {
      /******************************************************************************/
      /* We also need to check if alarm is on or inch button pressed and so on      */
      /* Putting this on the end of while() would be better but then all hangs ?!!! */
      SERVICE_WATCHDOG;
      exit = check_external_events();
      if (exit == 0)
      {
         if (keypad_check_front() == DATA_AVAILABLE)
         {
            key_code = keypad_pop_front();
            //exit = check_extra_keys(key_code);

            switch (key_code)
            {
               case CLEAR:
                  result = value;
                  exit = 1;
                  break;
            }
            keypad_purge_buffer();
         }
      }
   }

   menu_previous_position();
   //   current_display_state = menu[current_display_state].item[current_position].previous;
   //current_position = stack_pop_front();
   ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);

   return result;
}

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */

void keypad_test_workloop()
{
   BLINKING_OFF;
   lcd_clear();
   printf_fast("Test klawiatury, nacisnij dowolny klawisz ...");

   while(1)
   {
      if (keypad_check_front() == DATA_AVAILABLE)
      {
         key_code = keypad_pop_front();
         lcd_goto_xy(0,0);
         printf_fast("Nacisnieto klawisz o kodzie: (%x)               ", key_code);
      }
      SERVICE_WATCHDOG;
   }
}

unsigned int weekday_worklop(const unsigned int value)
{
   Data_Display *display;
   unsigned char exit = 0;
   unsigned int result;
   
   BLINKING_OFF;
   result = value;

   display = menu[current_display_state].item[current_position].display;

   lcd_goto_xy(display->x, display->y+1);
   printf_day(value);

   while(exit == 0)
   {
      SERVICE_WATCHDOG;
      if (keypad_check_front() == DATA_AVAILABLE)
      {
         key_code = keypad_pop_front();
         if (exit == 1)
         {
            result = value;
         }
         
         switch (key_code)
         {
            case ENTER:
               exit = 1;
               break;
                  
            case CLEAR:
               result = value;
               exit = 1;
               break;
               
            case LEFT:
               if (++result > 7)
                  result = 1;
               lcd_goto_xy(display->x, display->y+1);
               printf_day(result);
               break;
               
            case RIGHT:
               if (result == 1)
                  result = 7;
               else 
                  result--;
               lcd_goto_xy(display->x, display->y+1);
               printf_day(result);
               break;
         }
         keypad_purge_buffer();
      }
   }

   ds1302_read_rtc_bcd(&system_time);
   system_time.tm_wday = result;
   ds1302_write_rtc(&system_time);
   
   menu_previous_position();
   ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);

   return result;
}


unsigned int read_keyboard_data_workloop(unsigned char size, const unsigned int value, const char point, const boolean isBCD)
{
   unsigned char count,j,exit;
   unsigned int result;

   count = 1;
   result = 0;

   while(count <= size)
   {
      SERVICE_WATCHDOG;
      /******************************************************************************/
      /* We also need to check if alarm is on or inch button pressed and so on      */
      /* Putting this on the end of while() would be better but then all hangs ?!!! */
      exit = check_external_events();
      if (exit == 0)
      {
         SERVICE_WATCHDOG;
         if (keypad_check_front() == DATA_AVAILABLE)
         {
            key_code = keypad_pop_front();
            //lcd_cursor_off();
            //            if (check_extra_keys(key_code) == 1)
            //{
            //  key_code = CLEAR;
            //}
            // lcd_cursor_on();
            
            if (key_code >=0 && key_code < 10)
            {
               if (count == point)
               {
                  printf_fast("%d.",key_code);
               }
               else
               {
                  printf_fast("%d", key_code);
               }
            
               if (isBCD == false)
               {
                  result *= 10;
                  result += key_code;
               }
               else 
               {
                  result <<= 4;
                  result |= key_code;
               }
               
               count++;
            }
            else
            {
               switch (key_code)
               {
                  case ENTER:
                     for (j=0; j<=(size-count);j++)
                     {
                        if (isBCD == false)
                        {
                           result *= 10;
                        }
                        else
                        {
                           result <<= 4;
                        }
                     }
                     count = size+1;
                     break;
                     
                  case CLEAR:
                     count = size+1;
                     result = value;
                     break;
               }
            }
            keypad_purge_buffer();
         }
      }
      else
      {
         result = value;
         count = size+1;
      }
   }

   return result;
}

void zone_workloop(const unsigned char zone)
{
   unsigned int result;
   unsigned char mins = 0;
   unsigned char hours = 0;
   unsigned char *flash = (unsigned char*)dfp;
   unsigned char *xram = (unsigned char*)system_data;
   unsigned char count;

   Data_Display *display;
   result = 0;

   BLINKING_OFF;

   display = menu[current_display_state].item[current_position].display;
   lcd_cursor_on();

   lcd_goto_xy(display->x, 0);
   local_gmtime(&system_data.zone_settings[zone].start_time);
   printf_fast("%02u:%02u", 
               (unsigned int)system_time.tm_hour,
               (unsigned int)system_time.tm_min);
   
   printf_fast("-");

   local_gmtime(&system_data.zone_settings[zone].stop_time);         
   printf_fast("%02u:%02u", 
               (unsigned int)system_time.tm_hour,
               (unsigned int)system_time.tm_min);
   
   lcd_goto_xy(display->x+21, 0);
   printf_fast("%02u",system_data.zone_settings[zone].temperature);

   lcd_goto_xy(display->x, display->y+1);
   result = read_keyboard_data_workloop(2,0x99,0,false);
   if (result != 0x99)
   {
      if (result <= 0x23)
      {
         hours = (unsigned char)result&0xff;
      }
   }
   else
   {
      lcd_goto_xy(display->x, display->y+1);
      local_gmtime(&system_data.zone_settings[zone].start_time);
      printf_fast("%02u", (unsigned int)system_time.tm_hour);

      hours = system_time.tm_hour;
   }

   lcd_goto_xy(display->x+3, display->y+1);
   result = read_keyboard_data_workloop(2,0x99,0,false);
   if (result != 0x99)
   {
      if (result <= 0x59)
      {
         mins = (unsigned char)result&0xff;
      }
   }
   else
   {
      lcd_goto_xy(display->x+3, display->y+1);
      local_gmtime(&system_data.zone_settings[zone].start_time);         
      printf_fast("%02u", (unsigned int)system_time.tm_min);

      mins = system_time.tm_min;
   }

   //minutes first - complicated due long type compiler bug   
   temp_long = hours;
   temp_long *= 3600;

   result = mins * 60;  
   temp_long += result;

   system_data.zone_settings[zone].start_time = temp_long;

   lcd_goto_xy(display->x+6, display->y+1);
   result = read_keyboard_data_workloop(2,0x99,0,false);
   if (result != 0x99)
   {
      if (result <= 0x23)
      {
         hours = (unsigned char)result&0xff;
      }
   }
   else
   {
      lcd_goto_xy(display->x+6, display->y+1);
      local_gmtime(&system_data.zone_settings[zone].stop_time);
      printf_fast("%02u", (unsigned int)system_time.tm_hour);

      hours = system_time.tm_hour;
   }

   lcd_goto_xy(display->x+9, display->y+1);
   result = read_keyboard_data_workloop(2,0x99,0,false);
   if (result != 0x99)
   {
      if (result <= 0x59)
      {
         mins = (unsigned char)result&0xff;
      }
   }
   else
   {
      lcd_goto_xy(display->x+9, display->y+1);
      local_gmtime(&system_data.zone_settings[zone].stop_time);
      printf_fast("%02u", (unsigned int)system_time.tm_min);

      mins = system_time.tm_min;
   }

   temp_long = hours;
   temp_long *= 3600;

   result = mins * 60;  
   temp_long += result;

   system_data.zone_settings[zone].stop_time = temp_long;

   //start time < stop time, jesli tak nie jest to wylaczamy ta strefe
   if (system_data.zone_settings[zone].start_time >= system_data.zone_settings[zone].stop_time)
   {
      system_data.zone_settings[zone].start_time = 0;
      system_data.zone_settings[zone].stop_time = 0;
   }

   lcd_goto_xy(display->x+21, display->y+1);
   result = read_keyboard_data_workloop(2,0x99,0,false);
   if (result != 0x99)
   {
      system_data.zone_settings[zone].temperature = result;
   }

   //
   // put data into flash memory
   //

   xram = &system_data.zone_settings[zone];
   flash = (unsigned char*)(dfp + zone*ZONE_SETTING_SIZE);
   for(count=0; count < ZONE_SETTING_SIZE; count++)
   {
      flash_write_byte(*xram++, (unsigned int)flash++);
      SERVICE_WATCHDOG;
   }

   lcd_cursor_off();
   menu_previous_position();
   ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
}

void time_workloop(void)
{
   unsigned int result;
   Data_Display *display;
   result = 0;

   BLINKING_OFF;

   display = menu[current_display_state].item[current_position].display;

   lcd_goto_xy(display->x, display->y+1);
   lcd_cursor_on();
   ds1302_read_rtc_bcd(&system_time);

   result = read_keyboard_data_workloop(2,system_time.tm_hour,0,true);
   if (result != system_time.tm_hour)
   {
      if (result <= 0x23)
      {
         system_time.tm_hour = (unsigned char)result&0xff;
      }
   }

   lcd_goto_xy(display->x+3, display->y+1);

   result = read_keyboard_data_workloop(2,system_time.tm_min,0,true);
   if (result != system_time.tm_min)
   {
      if (result <= 0x59)
      {
         system_time.tm_min = (unsigned char)result&0xff;
      }
   }

   lcd_goto_xy(display->x+6, display->y+1);

   result = read_keyboard_data_workloop(2,system_time.tm_sec,0,true);
   if (result != system_time.tm_sec)
   {
      if (result <= 0x59)
      {
         system_time.tm_sec = (unsigned char)result&0xff;
      }
   }

   ds1302_write_rtc(&system_time);

   lcd_cursor_off();
   menu_previous_position();
   //   current_display_state = menu[current_display_state].item[current_position].previous;
   //current_position = stack_pop_front();
   ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
}

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */

void date_workloop(const unsigned char isBCD)
{
   unsigned int result;
   unsigned char ib;
   Data_Display *display;
   result = 0;
   ib = isBCD;

   BLINKING_OFF;

   display = menu[current_display_state].item[current_position].display;

   lcd_goto_xy(display->x, display->y+1);
   lcd_cursor_on();

   ds1302_read_rtc_bcd(&system_time);

   result = read_keyboard_data_workloop(4,0x2004,0,true);
   if (result >= 0x2004)
   {
      system_time.tm_year = (unsigned char)(result & 0xff);
   }
   
   lcd_goto_xy(display->x+5, display->y+1);

   result = read_keyboard_data_workloop(2,system_time.tm_mon,0,false);
   //
   // We need to decrese month number to have this displayed successfully
   //
   if (result != system_time.tm_mon)
   {
      result--;
      system_time.tm_mon = (unsigned char)(result & 0xff);
   }

   lcd_goto_xy(display->x+8, display->y+1);

   result = read_keyboard_data_workloop(2,system_time.tm_mday,0,ib);
   if (result != system_time.tm_mday)
   {
      system_time.tm_mday = (unsigned char)(result & 0xff);
   }

   ds1302_write_rtc(&system_time);

   lcd_cursor_off();
   menu_previous_position();
   ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
}

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */


/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */

void workloop(void)
{
   unsigned char exit = 0;
   BLINKING_ON;

   while(exit == 0)
   {
      SERVICE_WATCHDOG;
      /******************************************************************************/
      /* We also need to check if alarm is on or inch button pressed and so on      */
      /* Putting this on the end of while() would be better but then all hangs ?!!! */
      exit = check_external_events();
      if (exit == 0)
      {
         if (keypad_check_front() == DATA_AVAILABLE)
         {
            key_code = keypad_pop_front();
            //exit = check_extra_keys(key_code);
            
            switch (key_code)
            {
               case ENTER:
                  if (menu[current_display_state].item[current_position].next == EXIT_POS_ID)
                  {
                     menu_previous_position();
                  }
                  else
                  {
                     current_display_state = menu[current_display_state].item[current_position].next;
                     stack_push_back(current_position);
                     current_position = 0;
                  }
                  ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
                  exit = 1;
                  break;
                  
               case CLEAR:
                  menu_previous_position();
                  ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
                  exit = 1;
                  break;
                  
               case RIGHT:
                  current_position++;
                  if (current_position == menu[current_display_state].max_pos)
                  {
                     current_position = 0;
                  }
                  set_new_blink();
                  break;
                  
               case LEFT:
                  current_position--;
                  if (current_position == 0xFF)
                  {
                     current_position = menu[current_display_state].max_pos - 1;
                  }
                  set_new_blink();
                  break;

               case STAR:
                  if (current_display_state == MAIN_STATE_POS)
                  {
                     if(system_data.enabled[current_position] != CHANNEL_FORCED_ON)
                        system_data.enabled[current_position] = CHANNEL_FORCED_ON;
                     else
                        system_data.enabled[current_position] = CHANNEL_DISABLED;
                  }
                  break;
                  
               case SHARP:
                  if (current_display_state == MAIN_STATE_POS)
                  {
                     if(system_data.enabled[current_position] != CHANNEL_FORCED_OFF)
                        system_data.enabled[current_position] = CHANNEL_FORCED_OFF;
                     else
                        system_data.enabled[current_position] = CHANNEL_DISABLED;
                  }
                  break;
            }
            keypad_purge_buffer();
         }
      }
   }
}

/**
 * Brief description. Full description.
 * @param .
 * @param .
 * @return .
 * @see
 */

void battery_test(void)
{
   BATT_TEST_PORT = 0;

   for ( ; battery_counter < 2000; battery_counter++ )
   {
      SERVICE_WATCHDOG;
   }

   if (BATT_FAIL_PORT == 0)
   {
      current_display_state = BATTERY_LOW_POS;
   }
   else
   {
      current_display_state = ds1302_read_memory(RTC_CURRENT_DISPLAY_STATE);
      
      if (current_display_state >= LATEST_DONT_REMOVE)
      {
         current_display_state = 0;
      }
   }

   BATT_TEST_PORT = 1; /* Also set by lcd driver before */
}

void clear_zones()
{
   char i=0;

   for(i=0; i<4; i++)
   {
      switch_zone_prepare(i,0);
      switch_zone(i);
   }
}


   
void main_program_workloop(void)
{
   battery_test();
   stack_purge();
   ENABLE_INTERRUPTS;

   //keypad_test_workloop();

   while (1)
   {
      enter_workloop = true;
      
      BLINKING_OFF;
      lcd_clear();
      lcd_put_string(menu[current_display_state].text);
      current_blink_params = menu[current_display_state].item[current_position].blink_union.blink;     

      switch (current_display_state)
      {
         case BATTERY_LOW_POS:
            reset_workloop(0);
            enter_workloop = false;
            break;

            /***************************************************/
            /* Schody Parking Socjalne Magazyn     Czas        */
            /***************************************************/
         case MAIN_STATE_POS:
            display_stored_data((unsigned int*)system_data.temperatures,true);
            display_enabled_channels(true);
            break;

         case ZONE_1_SETUP_POS:
            display_zone_setings(0);
            break;
         case ZONE_2_SETUP_POS:
            display_zone_setings(3);
            break;
         case ZONE_3_SETUP_POS:
            display_zone_setings(6);
            break;
         case ZONE_4_SETUP_POS:
            display_zone_setings(9);
            break;
         case ZONE_5_SETUP_POS:
            display_zone_setings(12);
            break;
         case ZONE_6_SETUP_POS:
            display_zone_setings(15);
            break;
         case ZONE_7_SETUP_POS:
            display_zone_setings(18);
            break;
         case ZONE_8_SETUP_POS:
            display_zone_setings(21);
            break;
         case ZONE_9_SETUP_POS:
            display_zone_setings(24);
            break;
         case ZONE_10_SETUP_POS:
            display_zone_setings(27);
            break;
         case ZONE_11_SETUP_POS:
            display_zone_setings(30);
            break;
         case ZONE_12_SETUP_POS:
            display_zone_setings(33);
            break;

         case ZONE_1_INPUT_POS:
         case ZONE_2_INPUT_POS:
         case ZONE_3_INPUT_POS:
         case ZONE_4_INPUT_POS:
         case ZONE_5_INPUT_POS:
         case ZONE_6_INPUT_POS:
         case ZONE_7_INPUT_POS:
         case ZONE_8_INPUT_POS:
         case ZONE_9_INPUT_POS:
         case ZONE_10_INPUT_POS:
         case ZONE_11_INPUT_POS:
         case ZONE_12_INPUT_POS:
         case ZONE_13_INPUT_POS:
         case ZONE_14_INPUT_POS:
         case ZONE_15_INPUT_POS:
         case ZONE_16_INPUT_POS:
         case ZONE_17_INPUT_POS:
         case ZONE_18_INPUT_POS:
         case ZONE_19_INPUT_POS:
         case ZONE_20_INPUT_POS:
         case ZONE_21_INPUT_POS:
         case ZONE_22_INPUT_POS:
         case ZONE_23_INPUT_POS:
         case ZONE_24_INPUT_POS:
         case ZONE_25_INPUT_POS:
         case ZONE_26_INPUT_POS:
         case ZONE_27_INPUT_POS:
         case ZONE_28_INPUT_POS:
         case ZONE_29_INPUT_POS:
         case ZONE_30_INPUT_POS:
         case ZONE_31_INPUT_POS:
         case ZONE_32_INPUT_POS:
         case ZONE_33_INPUT_POS:
         case ZONE_34_INPUT_POS:
         case ZONE_35_INPUT_POS:
         case ZONE_36_INPUT_POS:
            zone_workloop(current_display_state - POS_2_ZONE_OFFSET);
            enter_workloop = false;
            break;

        case DAY_SETUP_POS:
             display_stored_time(0, WEEKDAY,true);
             weekday_worklop(system_time.tm_wday);
             enter_workloop = false;
             break;

         case DATE_SETUP_POS:
            display_stored_time(0, DATE_FORMAT,true);
            date_workloop(true);
            enter_workloop = false;
            break;

         case TIME_SETUP_POS:
            display_stored_time(0, TIME_FORMAT,true);
            time_workloop();
            enter_workloop = false;
            break;
      }

      if (enter_workloop == true)
         workloop();
   }
}
