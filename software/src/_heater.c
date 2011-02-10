/**************************************************************************
**                                                                        
**  FILE : $Source$
**                                                                        
**  $Author $                                                     
**  $Log $
**************************************************************************/

#include <stdio.h>
#include "89c51rd2.h"
#include "flash.h"
#include "global.h"
#include "lcd.h"
#include "serial.h"
#include "keypad.h"
#include "menu.h"
#include "rtc.h"

#define DEVICE_COLD_RESET     0x10
#define DEVICE_COLD_RESET_BIT 

static char* EDRIVE_SOFTWARE_VERSION = "Sterownik ogrzewania ver 1.0 $Id$";

void main (void)  
{
   unsigned char pcon_status = 0;

   SET_MAX_WDT_DELAY;   // we would have 2s at 12MHz, so using 40MHz will give 0,5s delay which should be enough

   SERVICE_WATCHDOG;
   lcd_init();
   SERVICE_WATCHDOG;

   ENABLE_XRAM_1024;

   // TMOD is set globally here for both timers
   TMOD = 0x51;
   //Interrupt priorities
   //Timer1 - the highest system priority (level 3)
   IPL0 |= TIMER1_PRIORITY_BIT;
   IPH0 |= TIMER1_PRIORITY_BIT;

   //   IPL0 |= PCA_PRIORITY_BIT;
   IPH0 |= PCA_PRIORITY_BIT;

   IPL0 |= EXTERNAL1_PRIORITY_BIT;
   IPH0 |= EXTERNAL1_PRIORITY_BIT;

   //Timer 2 (level 2)
   IPH0 |= TIMER2_PRIORITY_BIT;

   //Timer 0 (level 1)
   IPL0 |= TIMER0_PRIORITY_BIT;

   
   lcd_put_string(EDRIVE_SOFTWARE_VERSION);
   lcd_put_string("System gotowy ");

   SET_MAX_WDT_DELAY;   // we would have 2s at 12MHz, so using 40MHz will give 0,5s delay which should be enough
   SERVICE_WATCHDOG;

   clear_zones();
   flash_init();
   keypad_init();

   main_program_workloop();
}


