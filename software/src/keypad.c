/**************************************************************************
**                                                                        
**  FILE : $Source$
**                                                                        
**  $Author$                                                     
**  $Log$
**************************************************************************/

#include <stdio.h>
#include "89c51rd2.h"
#include "keypad.h"
#include "global.h"
#include "lcd.h"
#include "menu.h"

unsigned int T1_count=0;
unsigned int T2_count=0;
//unsigned long zone_long;

extern volatile Blink_params * current_blink_params;
extern volatile BOOL blinking;
extern SystemData xdata system_data;

volatile static struct _Key xdata kb;
volatile unsigned char blink_counter = 0;
volatile unsigned char delay_counter = 0;

typedef struct _MappingTable {
      unsigned int scan;
      unsigned int normalized;
      char *description;
};

const struct _MappingTable code mappingTable[] = {
   { 0x3e, 0, "0" },
   { 0x47, 1, "1" },
   { 0x37, 2, "2" },
   { 0x27, 3, "3" },
   { 0x4b, 4, "4" },
   { 0x3b, 5, "5" },
   { 0x2b, 6, "6" },
   { 0x4d, 7, "7" },
   { 0x3d, 8, "8" },
   { 0x2d, 9, "9" },
   { 0x17, LEFT, "LEFT" },
   { 0x1b, RIGHT, "RIGHT" },
   { 0x4e, STAR, "*" },
   { 0x2e, SHARP, "#" },
   { 0x1e, CLEAR, "CLEAR" },
   { 0x1d, ENTER, "ENTER" },
   { 0 , 0 }
};

unsigned char find_mapping_code(const unsigned char scan_code)
{
   unsigned char result = 0;
   unsigned char stop = 0;
   unsigned char i;

   for (i=0; i<255, stop==0; i++)
   {
      if ( mappingTable[i].scan == scan_code )
      {
         result = mappingTable[i].normalized;
         stop = 1;
      }

      if ( (mappingTable[i].scan == 0) && 
           (mappingTable[i].normalized == 0) )
      {
         stop = 1;
         result = SCAN_ERROR;
      }
   }

   //return scan_code;
   return result;
}

/**
 * Brief description.
 * We are using T0 as matrix keyboard decoder
 */

void keypad_init (void)
{
   kb.last_code = BUFFER_EMPTY;
   kb.status = BUFFER_EMPTY;

   //   TMOD &= 0xF1;
   ENABLE_T0_INTERRUPT;
   KEYPAD_START;
}

unsigned char keypad_pop_front(void)
{
   return kb.buffer;
}

unsigned char keypad_check_front(void)
{
   return kb.status;
}

void keypad_purge_buffer(void)
{
   kb.status = BUFFER_EMPTY;
}

unsigned char keypad_get_last_code(void)
{
   return kb.last_code;
}

unsigned int read_zone_temp_1()
{
   unsigned int result = 0;

   T1_count=0;
   T2_count=0;

   // waiting for end of previous "T1".
   while( SENSOR_ZONE_1 )
   {
     if (++T2_count == 0x8000)
        return 0;
   }

   // waiting for end of previous "T2".
   while( !SENSOR_ZONE_1 )
   {
      if (++T2_count == 0x8000)
         return 0;
   }

   T1_count=0;
   T2_count=0;
   
   // counting current "T1".
   while( SENSOR_ZONE_1 )
   {
      //SERVICE_WATCHDOG;
      T1_count++;
      if (T1_count == 0x8000)
         return 0;
   }
      
   // counting current "T2".
   while( !SENSOR_ZONE_1 )
   {
      T2_count++;
      if (T2_count == 0x8000)
         return 0;
   }
   
   if (T2_count != 0)
   {
      //zone_long = T1_count;
      //zone_long *= 4000;
      //zone_long /= T2_count;
      //zone_long = 2350 - zone_long;
      
      //      result = (unsigned int)zone_long;
      result = (unsigned int)235L-((400L*T1_count)/T2_count);
      result *= 10;
   }
      
   return result;
}

unsigned int read_zone_temp_2()
{
   unsigned int result = 0;

   T1_count=0;
   T2_count=0;

   // waiting for end of previous "T1".
   while( SENSOR_ZONE_2 )
   {
     if (++T2_count == 0x8000)
        return 0;
   }

   // waiting for end of previous "T2".
   while( !SENSOR_ZONE_2 )
   {
      if (++T2_count == 0x8000)
         return 0;
   }

   T1_count=0;
   T2_count=0;
   
   // counting current "T1".
   while( SENSOR_ZONE_2 )
   {
      //SERVICE_WATCHDOG;
      T1_count++;
      if (T1_count == 0x8000)
         return 0;
   }
      
   // counting current "T2".
   while( !SENSOR_ZONE_2 )
   {
      T2_count++;
      if (T2_count == 0x8000)
         return 0;
   }
   
   if (T2_count != 0)
   {
      //zone_long = T1_count;
      //zone_long *= 4000;
      //zone_long /= T2_count;
      //zone_long = 2350 - zone_long;
      
      result = (unsigned int)235L-((400L*T1_count)/T2_count);
      result *= 10;
      //      result = (unsigned int)zone_long;
   }
      
   return result;
}
unsigned int read_zone_temp_3()
{
   unsigned int result = 0;

   T1_count=0;
   T2_count=0;

   // waiting for end of previous "T1".
   while( SENSOR_ZONE_3 )
   {
     if (++T2_count == 0x8000)
        return 0;
   }

   // waiting for end of previous "T2".
   while( !SENSOR_ZONE_3 )
   {
      if (++T2_count == 0x8000)
         return 0;
   }

   T1_count=0;
   T2_count=0;
   
   // counting current "T1".
   while( SENSOR_ZONE_3 )
   {
      //SERVICE_WATCHDOG;
      T1_count++;
      if (T1_count == 0x8000)
         return 0;
   }
      
   // counting current "T2".
   while( !SENSOR_ZONE_3 )
   {
      T2_count++;
      if (T2_count == 0x8000)
         return 0;
   }
   
   if (T2_count != 0)
   {
      //zone_long = T1_count;
      //zone_long *= 4000;
      //zone_long /= T2_count;
      //zone_long = 2350 - zone_long;
      
      result = (unsigned int)235L-((400L*T1_count)/T2_count);
      result *= 10;
      //      result = (unsigned int)zone_long;
   }
      
   return result;
}
unsigned int read_zone_temp_4()
{
   unsigned int result = 0;

   T1_count=0;
   T2_count=0;

   // waiting for end of previous "T1".
   while( SENSOR_ZONE_4 )
   {
     if (++T2_count == 0x8000)
        return 0;
   }

   // waiting for end of previous "T2".
   while( !SENSOR_ZONE_4 )
   {
      if (++T2_count == 0x8000)
         return 0;
   }

   T1_count=0;
   T2_count=0;
   
   // counting current "T1".
   while( SENSOR_ZONE_4 )
   {
      //SERVICE_WATCHDOG;
      T1_count++;
      if (T1_count == 0x8000)
         return 0;
   }
      
   // counting current "T2".
   while( !SENSOR_ZONE_4 )
   {
      T2_count++;
      if (T2_count == 0x8000)
         return 0;
   }
   
   if (T2_count != 0)
   {
      // zone_long = T1_count;
      //zone_long *= 4000;
      //zone_long /= T2_count;
      //zone_long = 2350 - zone_long;
         
      result = (unsigned int)235L-((400L*T1_count)/T2_count);
      result *= 10;
      //      result = (unsigned int)zone_long;
   }
   
   return result;
}



/*
 * Brief description.
 * Assuming we are using X2 mode interrupt frequecny f=40MHz/12/2 = 6,66MHz
 * Timer expiration time in Mode 1 Exp = 1/6,66 * 65535 = 9,8 ms
 */

void timer0_interrupt(void) interrupt TF0_VECTOR using 0
{ 
   static unsigned char counter = 0;
   unsigned char input_value;
   unsigned char key_code;
   unsigned char empty;

   //read zone temperatures
   delay_counter++;
   if (delay_counter == 64)
   {
      system_data.temperatures[0] = read_zone_temp_1();
   }
   if (delay_counter == 128)
   {
      system_data.temperatures[1] = read_zone_temp_2();
   }
   if (delay_counter == 192)
   {
      system_data.temperatures[2] = read_zone_temp_3();
   }
   if (delay_counter == 255)
   {
      system_data.temperatures[3] = read_zone_temp_4();
   }

   if (blinking == TRUE)
   {
      blink_counter++;
      if (blink_counter == 30)
      {
         lcd_goto_xy(current_blink_params->position, 0);
         lcd_put_string(current_blink_params->first_pattern_off);
         
         if (current_blink_params->lines > 1)
         {
            lcd_goto_xy(current_blink_params->position, 2);
            lcd_put_string(current_blink_params->second_pattern_off);
         }
      }
      if (blink_counter == 60)
      {
         lcd_goto_xy(current_blink_params->position, 0);
         lcd_put_string(current_blink_params->first_pattern_on);
         
         if (current_blink_params->lines > 1)
         {
            lcd_goto_xy(current_blink_params->position, 1);
            lcd_put_string(current_blink_params->second_pattern_on);
         }
         
         blink_counter = 0;
      }
   }

   if (counter++ >= 5)
   {
      counter = 0;
      empty = 0;

      /*      KSC0 = 0;
      input_value = (KEYBOARD_PORT >> 1) & 0xF;
      if ( input_value != 0x0F ) 
      {
         empty++;
         
         key_code = find_mapping_code(input_value);
         
         if (key_code != SCAN_ERROR)
         {
            if (key_code != kb.last_code)
            {
               kb.buffer = key_code;
               kb.last_code = key_code;
               kb.status = DATA_AVAILABLE;
               //BUZZER_ON;
            }
         }
      }
      KSC0 = 1;*/
      
      KSC1 = 0;
      input_value = (KEYBOARD_PORT >> 1) & 0xF;
      if ( input_value != 0x0F ) 
      {
         empty++;
         input_value |= 0x10;
         key_code = find_mapping_code(input_value);
         
         if (key_code != SCAN_ERROR)
         {
            if (key_code != kb.last_code)
            {
               kb.buffer = key_code;
               kb.last_code = key_code;
               kb.status = DATA_AVAILABLE;
               //BUZZER_ON;
            }
         }
      }
      KSC1 = 1;
      
      KSC2 = 0;
      input_value = (KEYBOARD_PORT >> 1) & 0xF;
      if ( input_value != 0x0F ) 
      {
         empty++;
         
         input_value |= 0x20;
         key_code = find_mapping_code(input_value);
         
         if (key_code != SCAN_ERROR)
         {
            if (key_code != kb.last_code)
            {
               kb.buffer = key_code;
               kb.last_code = key_code;
               kb.status = DATA_AVAILABLE;
               //BUZZER_ON;
            }
         }
      }
      KSC2 = 1;
      
      KSC3 = 0;
      input_value = (KEYBOARD_PORT >> 1) & 0xF;
      if ( input_value != 0x0F ) 
      {
         empty++;
         
         input_value |= 0x30;
         key_code = find_mapping_code(input_value);
         
         if (key_code != SCAN_ERROR)
         {
            if (key_code != kb.last_code)
            {
               kb.buffer = key_code;
               kb.last_code = key_code;
               kb.status = DATA_AVAILABLE;
               //BUZZER_ON;
            }
         }
      }
      KSC3 = 1;
      
      KSC4 = 0;
      input_value = (KEYBOARD_PORT >> 1) & 0xF;
      if ( input_value != 0x0F ) 
      {
         empty++;
         
         input_value |= 0x40;
         key_code = find_mapping_code(input_value);
         
         if (key_code != SCAN_ERROR)
         {
            if (key_code != kb.last_code)
            {
               kb.buffer = key_code;
               kb.last_code = key_code;
               kb.status = DATA_AVAILABLE;
               //BUZZER_ON;
            }
         }
      }
      KSC4 = 1;
      
      if (empty == 0)
      {
         kb.last_code = BUFFER_EMPTY;
      }
   }
}
