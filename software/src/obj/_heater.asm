;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.4.0 Thu Feb 10 12:42:18 2011

;--------------------------------------------------------
	.module src/_heater
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_P0	=	0x0080
_SP	=	0x0081
_DPL	=	0x0082
_DPH	=	0x0083
_PCON	=	0x0087
_TCON	=	0x0088
_TMOD	=	0x0089
_TL0	=	0x008a
_TL1	=	0x008b
_TH0	=	0x008c
_TH1	=	0x008d
_P1	=	0x0090
_SCON	=	0x0098
_SBUF	=	0x0099
_P2	=	0x00a0
_P3	=	0x00b0
_IP	=	0x00b8
_T2CON	=	0x00c8
_T2MOD	=	0x00c9
_RCAP2L	=	0x00ca
_RCAP2H	=	0x00cb
_TL2	=	0x00cc
_TH2	=	0x00cd
_PSW	=	0x00d0
_A	=	0x00e0
_WDTRST	=	0x00a6
_WDTPRG	=	0x00a7
_AUXR1	=	0x00a2
_AUXR	=	0x008e
_SADEN	=	0x00b9
_SADEN_1	=	0x00ba
_IPH	=	0x00b7
_IPH0	=	0x00b7
_IPL	=	0x00b8
_IPL0	=	0x00b8
_IE	=	0x00a8
_SADDR	=	0x00a9
_SADDR_1	=	0x00aa
_CCON	=	0x00d8
_CMOD	=	0x00d9
_CCAPM0	=	0x00da
_CCAPM1	=	0x00db
_CCAPM2	=	0x00dc
_CCAPM3	=	0x00dd
_CCAPM4	=	0x00de
_CL	=	0x00e9
_CCAP0L	=	0x00ea
_CCAP1L	=	0x00eb
_CCAP2L	=	0x00ec
_CCAP3L	=	0x00ed
_CCAP4L	=	0x00ee
_ACC	=	0x00e0
_B	=	0x00f0
_CH	=	0x00f9
_CCAP0H	=	0x00fa
_CCAP1H	=	0x00fb
_CCAP2H	=	0x00fc
_CCAP3H	=	0x00fd
_CCAP4H	=	0x00fe
_ICON	=	0x00ff
_CKSEL	=	0x0085
_OSCCON	=	0x0086
_FCON	=	0x00d1
_EECON	=	0x00d2
_EETIM	=	0x00d3
;--------------------------------------------------------
; special function bits 
;--------------------------------------------------------
_P0_0	=	0x0080
_P0_1	=	0x0081
_P0_2	=	0x0082
_P0_3	=	0x0083
_P0_4	=	0x0084
_P0_5	=	0x0085
_P0_6	=	0x0086
_P0_7	=	0x0087
_ENBOOT	=	0x00a7
_IT0	=	0x0088
_IE0	=	0x0089
_IT1	=	0x008a
_IE1	=	0x008b
_TR0	=	0x008c
_TF0	=	0x008d
_TR1	=	0x008e
_TF1	=	0x008f
_P1_0	=	0x0090
_P1_1	=	0x0091
_P1_2	=	0x0092
_P1_3	=	0x0093
_P1_4	=	0x0094
_P1_5	=	0x0095
_P1_6	=	0x0096
_P1_7	=	0x0097
_T2	=	0x0090
_T2EX	=	0x0091
_RI	=	0x0098
_TI	=	0x0099
_RB8	=	0x009a
_TB8	=	0x009b
_REN	=	0x009c
_SM2	=	0x009d
_SM1	=	0x009e
_SM0	=	0x009f
_P2_0	=	0x00a0
_P2_1	=	0x00a1
_P2_2	=	0x00a2
_P2_3	=	0x00a3
_P2_4	=	0x00a4
_P2_5	=	0x00a5
_P2_6	=	0x00a6
_P2_7	=	0x00a7
_P3_0	=	0x00b0
_P3_1	=	0x00b1
_P3_2	=	0x00b2
_P3_3	=	0x00b3
_P3_4	=	0x00b4
_P3_5	=	0x00b5
_P3_6	=	0x00b6
_P3_7	=	0x00b7
_RXD	=	0x00b0
_TXD	=	0x00b1
_INT0	=	0x00b2
_INT1	=	0x00b3
_T0	=	0x00b4
_T1	=	0x00b5
_WR	=	0x00b6
_RD	=	0x00b7
_PX0	=	0x00b8
_PT0	=	0x00b9
_PX1	=	0x00ba
_PT1	=	0x00bb
_PS	=	0x00bc
_PT2	=	0x00bd
_T2CON_0	=	0x00c8
_T2CON_1	=	0x00c9
_T2CON_2	=	0x00ca
_T2CON_3	=	0x00cb
_T2CON_4	=	0x00cc
_T2CON_5	=	0x00cd
_T2CON_6	=	0x00ce
_T2CON_7	=	0x00cf
_CP_RL2	=	0x00c8
_C_T2	=	0x00c9
_TR2	=	0x00ca
_EXEN2	=	0x00cb
_TCLK	=	0x00cc
_RCLK	=	0x00cd
_EXF2	=	0x00ce
_TF2	=	0x00cf
_P	=	0x00d0
_FL	=	0x00d1
_OV	=	0x00d2
_RS0	=	0x00d3
_RS1	=	0x00d4
_F0	=	0x00d5
_AC	=	0x00d6
_CY	=	0x00d7
_EA	=	0x00af
_EC	=	0x00ae
_ET2	=	0x00ad
_ES	=	0x00ac
_ET1	=	0x00ab
_EX1	=	0x00aa
_ET0	=	0x00a9
_EX0	=	0x00a8
_CF	=	0x00df
_CR	=	0x00de
_CCF4	=	0x00dc
_CCF3	=	0x00db
_CCF2	=	0x00da
_CCF1	=	0x00d9
_CCF0	=	0x00d8
;--------------------------------------------------------
; overlayable register banks 
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_EDRIVE_SOFTWARE_VERSION:
	.ds 3
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area OSEG    (OVR,DATA)
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG	(DATA)
__start__stack:
	.ds	1

;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area CSEG    (CODE)
__interrupt_vect:
	ljmp	__sdcc_gsinit_startup
	reti
	.ds	7
	ljmp	_timer0_interrupt
	.ds	5
	reti
	.ds	7
	reti
	.ds	7
	reti
	.ds	7
	reti
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
__sdcc_gsinit_startup:
	mov	sp,#__start__stack - 1
	lcall	__sdcc_external_startup
	mov	a,dpl
	jz	__sdcc_init_data
	ljmp	__sdcc_program_startup
__sdcc_init_data:
;	_mcs51_genXINIT() start
	mov	r1,#l_XINIT
	mov	a,r1
	orl	a,#(l_XINIT >> 8)
	jz	00003$
	mov	r2,#((l_XINIT+255) >> 8)
	mov	dptr,#s_XINIT
	mov	r0,#s_XISEG
	mov	p2,#(s_XISEG >> 8)
00001$:	clr	a
	movc	a,@a+dptr
	movx	@r0,a
	inc	dptr
	inc	r0
	cjne	r0,#0,00002$
	inc	p2
00002$:	djnz	r1,00001$
	djnz	r2,00001$
	mov	p2,#0xFF
00003$:
;	_mcs51_genXINIT() end
;	_mcs51_genRAMCLEAR() start
	mov	r0,#l_XSEG
	mov	a,r0
	orl	a,#(l_XSEG >> 8)
	jz	00005$
	mov	r1,#((l_XSEG + 255) >> 8)
	mov	dptr,#s_XSEG
	clr     a
00004$:	movx	@dptr,a
	inc	dptr
	djnz	r0,00004$
	djnz	r1,00004$
00005$:	mov	@r0,a
	djnz	r0,00005$
;	_mcs51_genRAMCLEAR() end
;src/_heater.c:22: static char* EDRIVE_SOFTWARE_VERSION = "Sterownik ogrzewania ver 1.0 $Id$";
;     genCast
	mov	_EDRIVE_SOFTWARE_VERSION,#__str_1
	mov	(_EDRIVE_SOFTWARE_VERSION + 1),#(__str_1 >> 8)
	mov	(_EDRIVE_SOFTWARE_VERSION + 2),#0x2
	.area GSFINAL (CODE)
	ljmp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
__sdcc_program_startup:
	lcall	_main
;	return from main will lock up
	sjmp .
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;pcon_status               Allocated to registers 
;------------------------------------------------------------
;src/_heater.c:24: void main (void)  
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	push	_bp
	mov	_bp,sp
;src/_heater.c:28: SET_MAX_WDT_DELAY;   // we would have 2s at 12MHz, so using 40MHz will give 0,5s delay which should be enough
;     genAssign
	mov	_WDTPRG,#0x07
;src/_heater.c:30: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/_heater.c:31: lcd_init();
;     genCall
	lcall	_lcd_init
;src/_heater.c:32: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/_heater.c:34: ENABLE_XRAM_1024;
;     genOr
	orl	_AUXR,#0x0C
;src/_heater.c:37: TMOD = 0x51;
;     genAssign
	mov	_TMOD,#0x51
;src/_heater.c:40: IPL0 |= TIMER1_PRIORITY_BIT;
;     genOr
	orl	_IPL0,#0x08
;src/_heater.c:41: IPH0 |= TIMER1_PRIORITY_BIT;
;     genOr
	orl	_IPH0,#0x08
;src/_heater.c:44: IPH0 |= PCA_PRIORITY_BIT;
;     genOr
	orl	_IPH0,#0x40
;src/_heater.c:46: IPL0 |= EXTERNAL1_PRIORITY_BIT;
;     genOr
	orl	_IPL0,#0x04
;src/_heater.c:47: IPH0 |= EXTERNAL1_PRIORITY_BIT;
;     genOr
	orl	_IPH0,#0x04
;src/_heater.c:50: IPH0 |= TIMER2_PRIORITY_BIT;
;     genOr
	orl	_IPH0,#0x20
;src/_heater.c:53: IPL0 |= TIMER0_PRIORITY_BIT;
;     genOr
	orl	_IPL0,#0x02
;src/_heater.c:56: lcd_put_string(EDRIVE_SOFTWARE_VERSION);
;     genCall
	mov	dpl,_EDRIVE_SOFTWARE_VERSION
	mov	dph,(_EDRIVE_SOFTWARE_VERSION + 1)
	mov	b,(_EDRIVE_SOFTWARE_VERSION + 2)
	lcall	_lcd_put_string
;src/_heater.c:57: lcd_put_string("System gotowy ");
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#__str_0
	mov	b,#0x02
	lcall	_lcd_put_string
;src/_heater.c:59: SET_MAX_WDT_DELAY;   // we would have 2s at 12MHz, so using 40MHz will give 0,5s delay which should be enough
;     genAssign
	mov	_WDTPRG,#0x07
;src/_heater.c:60: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/_heater.c:62: clear_zones();
;     genCall
	lcall	_clear_zones
;src/_heater.c:63: flash_init();
;     genCall
	lcall	_flash_init
;src/_heater.c:64: keypad_init();
;     genCall
	lcall	_keypad_init
;src/_heater.c:66: main_program_workloop();
;     genCall
	lcall	_main_program_workloop
00101$:
	mov	sp,_bp
	pop	_bp
	ret
	.area CSEG    (CODE)
__str_0:
	.ascii "System gotowy "
	.db 0x00
__str_1:
	.ascii "Sterownik ogrzewania ver 1.0 $Id$"
	.db 0x00
	.area XINIT   (CODE)
