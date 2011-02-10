/**************************************************************************
**                                                                        
**  FILE : $Source$
**                                                                        
**  $Author$                                                     
**  $Log$
**************************************************************************/

#ifndef __GLOBAL_H__
#define __GLOBAL_H__

#include "89c51rd2.h"

#ifndef NULL
#define NULL  0
#endif

#define TRUE  1
#define FALSE 0
#define true  1
#define false 0

#define ASCII_OFFSET          0x30

#define ENABLE_XRAM_1024      AUXR |= 0x0C;

//
//Define this if X2 mode bit is set in the core
//
#define X2_MODE

typedef unsigned char BOOL;
typedef unsigned char bool;
typedef unsigned char boolean;

#define ENABLE_INTERRUPTS      EA=1
#define DISABLE_INTERRUPTS     EA=0
#define ENABLE_PCA_INTERRUPT   EC=1
#define DISABLE_PCA_INTERRUPT  EC=0
#define IS_PCA_ENABLED         EC==1
#define IS_PCA_DISABLED        EC==0
#define ENABLE_EXT_INTERRUPT   EX1=1
#define DISABLE_EXT_INTERRUPT  EX1=0
#define ENABLE_T1_INTERRUPT    ET1=1
#define DISABLE_T1_INTERRUPT   ET1=0
#define ENABLE_T0_INTERRUPT    ET0=1
#define DISABLE_T0_INTERRUPT   ET0=0
#define ENABLE_T2_INTERRUPT    ET2=1
#define DISABLE_T2_INTERRUPT   ET2=0
#define ENABLE_PULL_INTERRUPT  EX0=1
#define DISABLE_PULL_INTERRUPT EX0=0
#define ENABLE_HOLO_INTERRUPT  EX1=1
#define DISABLE_HOLO_INTERRUPT EX1=0
#define HOLO_NEGATIVE_TRIGGER  IT1=1
#define HOLO_LOW_LEVEL_TRIGGER IT1=0
#define IS_HOLO_ENABLED        EX1==1
#define IS_HOLO_DISABLED       EX1==0

#define ENABLE_RAMP_INTERRUPT  CCF1=1
#define DISABLE_RAMP_INTERRUPT CCF1=0

#define ENABLE_STEPPER         P1_2=0
#define DISABLE_STEPPER        P1_2=1
#define IS_STEPPER_ENABLED     P1_2==0
#define IS_STEPPER_DISABLED    P1_2==1

#define INCH_BUTTON_PRESSED    P1_0==0
#define INCH_BUTTON_RELEASED   P1_0==1

#define PCA_PRIORITY_BIT       0x40
#define TIMER2_PRIORITY_BIT    0x20
#define SERIAL_PRIRITY_BIT     0x10
#define TIMER1_PRIORITY_BIT    0x8
#define EXTERNAL1_PRIORITY_BIT 0x4
#define TIMER0_PRIORITY_BIT    0x2
#define EXTERNAL0_PRIORITY_BIT 0x1

#define TIMER_0_RUN            TR0=1
#define TIMER_0_STOP           TR0=0
#define TIMER_1_RUN            TR1=1
#define TIMER_1_STOP           TR1=0
#define TIMER_2_RUN            TR2=1
#define TIMER_2_STOP           TR2=0

#define BUZZER_ON              P3_6=0
#define BUZZER_OFF             P3_6=1

#define SERVICE_WATCHDOG       WDTRST=0x1e; WDTRST=0xe1;

#define SENSOR_ZONE_1        P1_4
#define SENSOR_ZONE_2        P1_3
#define SENSOR_ZONE_3        P1_2
#define SENSOR_ZONE_4        P0_0

#define ZONE_1_OUTPUT        P3_5
#define ZONE_2_OUTPUT        P3_2
#define ZONE_3_OUTPUT        P3_3
#define ZONE_4_OUTPUT        P1_0

#define BATT_TEST_PORT         P2_7
#define BATT_TEST_BIT_MASK     0x00 /* P2_7 */
#define BATT_FAIL_PORT         P1_1

#define SET_MAX_WDT_DELAY      WDTPRG=0x7

#define FLASH_START_POINT      0x7d00

typedef struct _ZoneSetting
{
      unsigned int temperature;
      unsigned long start_time;
      unsigned long stop_time;
} ZoneSetting;

#define SYSTEM_DATA_SIZE 372 /* 10 x NUMBER_OF_ZONES + 1 x NUMBER_OF_CHANNELS + 8(Temperatures)*/
#define ZONE_SETTING_SIZE 10
#define NUMBER_OF_ZONES 36
#define NUMBER_OF_CHANNELS 4

typedef struct _SystemData 
{
      ZoneSetting zone_settings[NUMBER_OF_ZONES];
      unsigned char enabled[NUMBER_OF_CHANNELS];
      unsigned int temperatures[NUMBER_OF_CHANNELS];
} SystemData;

#endif
