head	1.1;
branch	1.1.1;
access;
symbols
	Ziomek_CD_22_06_2005:1.1.1.1
	Ardetem_shipment_22_06_2005:1.1.1.1
	ed20:1.1.1.1
	easydevices:1.1.1;
locks; strict;
comment	@ * @;


1.1
date	2004.06.19.21.48.16;	author tomasz;	state Exp;
branches
	1.1.1.1;
next	;

1.1.1.1
date	2004.06.19.21.48.16;	author tomasz;	state Exp;
branches;
next	;


desc
@@



1.1
log
@Initial revision
@
text
@
#include <reg51.h>
#include <stdio.h>
#include <setjmp.h>

extern void dummy_function();

///////////////////////////////////////////////////////////////////////////////
//
//                            Global variables
//
///////////////////////////////////////////////////////////////////////////////

jmp_buf env;

char timeout_counter;

char sensor_to_read;

unsigned int T1_count;

unsigned int T2_count;

long result;

char print_buffer[16];

///////////////////////////////////////////////////////////////////////////////
//
//                      Serial transmission service
//
///////////////////////////////////////////////////////////////////////////////

rs_init()
{   
   SCON = 0x52; // Serial port in mode 1
   TMOD = 0x20; // Timer1 configured as baudrate generator
   TCON = 0x69; // Baudrate = 9600
   TH1 =  0xFD;
}



///////////////////////////////////////////////////////////////////////////////
//
//                           TMP03 interface
//
///////////////////////////////////////////////////////////////////////////////

//sbit SENSOR_INPUT_0 = P1^2;
//sbit SENSOR_INPUT_1 = P1^3;
//sbit SENSOR_INPUT_2 = P1^4;
//sbit SENSOR_INPUT_3 = P1^5;

sbit SENSOR_INPUT_0 = P1^4;
sbit SENSOR_INPUT_1 = P1^5;
sbit SENSOR_INPUT_2 = P1^6;
sbit SENSOR_INPUT_3 = P1^7;

char ascii( char value )
{
   if (( value>=0 ) && ( value<10 ))
   {
      return value+=0x30;
   }

   return 0;
}





void ltoa( long value, char *string )
{
   char counter=0;
   int  hun;
   int  dig;
   int  rest;

   if ( value<0 )
   {
      string[0]='-';
      value*=-1;
      counter++;
   }

   hun=value/100;
   string[counter]=ascii(hun);
   counter++;

   dig=(value-(100*hun))/10;
   string[counter]=ascii(dig);
   counter++;

   rest=value-(100*hun)-(10*dig);
   string[counter]=ascii(rest);
   counter++;

   string[counter]=0;
}





void read_sensor0( void )
{
   T1_count=T2_count=0L;

   // waiting for end of previous "T1".
   while( SENSOR_INPUT_0 );

   // waiting for end of previous "T2".
   while( !SENSOR_INPUT_0 );

   // counting current "T1".
   while( SENSOR_INPUT_0 )
   {
      T1_count++;
   }

   // counting current "T2".
   while( !SENSOR_INPUT_0 )
   {
      T2_count++;
   }

   if ( T2_count!=0 )
   {
      result=235L-((400L*T1_count)/T2_count);
      print_buffer[1]='0';
      ltoa ( result, print_buffer+3 );
      puts ( print_buffer );
   }
   else
   {
      puts ("T0=###");
   }
}





void read_sensor1( void )
{
   T1_count=T2_count=0L;

   // waiting for end of previous "T1".
   while( SENSOR_INPUT_1 );

   // waiting for end of previous "T2".
   while( !SENSOR_INPUT_1 );

   // counting current "T1".
   while( SENSOR_INPUT_1 )
   {
      T1_count++;
   }

   // counting current "T2".
   while( !SENSOR_INPUT_1 )
   {
      T2_count++;
   }

   if ( T2_count!=0 )
   {
      result=235L-((400L*T1_count)/T2_count);
      print_buffer[1]='1';
      ltoa ( result, print_buffer+3 );
      puts ( print_buffer );
   }
   else
   {
      puts ("T0=###");
   }
}





void read_sensor2( void )
{
   T1_count=T2_count=0L;

   // waiting for end of previous "T1".
   while( SENSOR_INPUT_2 );

   // waiting for end of previous "T2".
   while( !SENSOR_INPUT_2 );

   // counting current "T1".
   while( SENSOR_INPUT_2 )
   {
      T1_count++;
   }

   // counting current "T2".
   while( !SENSOR_INPUT_2 )
   {
      T2_count++;
   }

   if ( T2_count!=0 )
   {
      result=235L-((400L*T1_count)/T2_count);
      print_buffer[1]='2';
      ltoa ( result, print_buffer+3 );
      puts ( print_buffer );
   }
   else
   {
      puts ("T0=###");
   }
}





void read_sensor3( void )
{
   T1_count=T2_count=0L;

   // waiting for end of previous "T1".
   while( SENSOR_INPUT_3 );

   // waiting for end of previous "T2".
   while( !SENSOR_INPUT_3 );

   // counting current "T1".
   while( SENSOR_INPUT_3 )
   {
      T1_count++;
   }

   // counting current "T2".
   while( !SENSOR_INPUT_3 )
   {
      T2_count++;
   }

   if ( T2_count!=0 )
   {
      result=235L-((400L*T1_count)/T2_count);
      print_buffer[1]='3';
      ltoa ( result, print_buffer+3 );
      puts ( print_buffer );
   }
   else
   {
      puts ("T0=###");
   }
}


///////////////////////////////////////////////////////////////////////////////
//
//                            Timer service
//
///////////////////////////////////////////////////////////////////////////////


timeout_timer_refresh()
{
   timeout_counter=54;
}



timeout_timer_init()
{   
   // Disable interrupt
   // from timer 0 temporary
   ET0=0;

   // Interrupt on level 0:
   PT0=0;

   // Timer0 in mode 1
   TMOD&=0xF0;
   TMOD|=0x01;

   // Interupt frequency 10 ms
   // at quarz 11,0592 MHz
   TL0=0x00;
   TH0=0xDC;

   timeout_counter=0;   

   // Enable Timer 0 interrupt
   ET0=1;

   // Start timer
   TR0=1;
}





void t0_int_srv() interrupt 1 using 0
{ 
   TH0=0xDC;

   if ( timeout_counter!=0 )
   {
      if ((--timeout_counter)==0)
      {
         longjmp( env, 1 );
      }
   }
}


///////////////////////////////////////////////////////////////////////////////



void main( void )
{
   EA=0;

   print_buffer[0]='T';
   print_buffer[2]='=';
   rs_init();
   timeout_timer_init();

   EA=1;

   sensor_to_read=0;

   if ( setjmp( env )!=0 )
   {
      dummy_function();
   }     

   timeout_timer_refresh();

   switch( sensor_to_read )
   {
      case 0:            
         sensor_to_read=1;
         read_sensor0();         
         break;
         
      case 1:
         sensor_to_read=2;
         read_sensor1();         
         break;
         
      case 2:
         sensor_to_read=3;
         read_sensor2();         
         break;

      case 3:
         sensor_to_read=0;
         read_sensor3();         
         break;

      default:
         sensor_to_read=0;
         break;
   }

   while(1);
}







@


1.1.1.1
log
@First import for new relases
@
text
@@
