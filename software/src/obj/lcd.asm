;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.4.0 Thu Feb 10 12:42:26 2011

;--------------------------------------------------------
	.module src/lcd
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _enable
	.globl _lcd_delay
	.globl _lcd_goto_xy
	.globl _lcd_put
	.globl _lcd_clear
	.globl _lcd_home
	.globl _putchar
	.globl _lcd_put_string
	.globl _lcd_cursor_on
	.globl _lcd_cursor_off
	.globl _lcd_init
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
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area OSEG    (OVR,DATA)
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
; global & static initialisations
;--------------------------------------------------------
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_delay'
;------------------------------------------------------------
;delay                     Allocated to registers r2 r3 
;counter                   Allocated to registers 
;------------------------------------------------------------
;src/lcd.c:64: void lcd_delay ( int delay ) 
;	-----------------------------------------
;	 function lcd_delay
;	-----------------------------------------
_lcd_delay:
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
;     genReceive
	mov	r2,dpl
	mov	r3,dph
;src/lcd.c:66: int counter = 0;
;     genAssign
	mov	r4,#0x00
	mov	r5,#0x00
00101$:
;src/lcd.c:68: for ( ; counter < delay; counter++ )
;     genCmpLt
;     genCmp
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	xrl	a,#0x80
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00105$
00109$:
;src/lcd.c:70: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/lcd.c:68: for ( ; counter < delay; counter++ )
;     genPlus
;     genPlusIncr
;	tail increment optimized
	inc	r4
	cjne	r4,#0x00,00101$
	inc	r5
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00101$
00105$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'enable'
;------------------------------------------------------------
;------------------------------------------------------------
;src/lcd.c:74: void enable(void) 
;	-----------------------------------------
;	 function enable
;	-----------------------------------------
_enable:
	push	_bp
	mov	_bp,sp
;src/lcd.c:76: LCD_E_BIT = 1;
;     genAssign
	setb	_P2_4
;src/lcd.c:77: lcd_delay(ENABLE_DELAY);
;     genCall
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x012C
	lcall	_lcd_delay
;src/lcd.c:78: LCD_E_BIT = 0;
;     genAssign
	clr	_P2_4
;src/lcd.c:79: lcd_delay(ENABLE_DELAY);
;     genCall
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x012C
	lcall	_lcd_delay
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_goto_xy'
;------------------------------------------------------------
;y                         Allocated to stack - offset -3
;x                         Allocated to registers r2 
;------------------------------------------------------------
;src/lcd.c:82: void lcd_goto_xy (const char x, const char y) reentrant
;	-----------------------------------------
;	 function lcd_goto_xy
;	-----------------------------------------
_lcd_goto_xy:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
;src/lcd.c:84: if (y == 0)
;     genCmpEq
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    @r0,#0x00,00102$
;00107$:
;       Peephole 200    removed redundant sjmp
00108$:
;src/lcd.c:86: lcd_put_command(x+0x80);
;     genPlus
	mov	a,#0x80
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;     genIpush
	mov	a,#0x01
	push	acc
;     genCall
	lcall	_lcd_put
	dec	sp
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00104$
00102$:
;src/lcd.c:90: lcd_put_command(x+0x80+0x40);
;     genCast
	mov	a,r2
	rlc	a
	subb	a,acc
	mov	r3,a
;     genCast
;     genPlus
	mov	a,#0xC0
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;     genIpush
	mov	a,#0x01
	push	acc
;     genCall
	lcall	_lcd_put
	dec	sp
00104$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_put'
;------------------------------------------------------------
;command                   Allocated to stack - offset -3
;value                     Allocated to registers r2 
;------------------------------------------------------------
;src/lcd.c:94: void lcd_put ( char value, BOOL command ) reentrant
;	-----------------------------------------
;	 function lcd_put
;	-----------------------------------------
_lcd_put:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
;src/lcd.c:96: if ( command ) 
;     genIfx
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
	mov	a,@r0
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00102$
00107$:
;src/lcd.c:98: LCD_CTRL_PORT = (( value >> 4 ) & 0x0f ) | LCD_CTRL_PORT&0x80;
;     genRightShift
;     genSignedRightShift
;     genRightShiftLiteral
;     genrshOne
	mov	a,r2
	swap	a
	anl	a,#0x0f
	jnb	acc.3,00108$
	orl	a,#0xf0
00108$:
	mov	r3,a
;     genAnd
	anl	ar3,#0x0F
;     genAnd
	mov	a,#0x80
	anl	a,_P2
;     genOr
	orl	a,r3
	mov	_P2,a
;src/lcd.c:99: enable();
;     genCall
	push	ar2
	lcall	_enable
	pop	ar2
;src/lcd.c:100: LCD_CTRL_PORT = ( value & 0x0f ) | LCD_CTRL_PORT&0x80;
;     genAnd
	mov	a,#0x0F
	anl	a,r2
	mov	r3,a
;     genAnd
	mov	a,#0x80
	anl	a,_P2
;     genOr
	orl	a,r3
	mov	_P2,a
;src/lcd.c:101: enable();
;     genCall
	lcall	_enable
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00104$
00102$:
;src/lcd.c:105: LCD_CTRL_PORT = ( ( value >> 4 ) & 0x0f ) | LCD_RS_BIT_MASK | LCD_CTRL_PORT&0x80;
;     genRightShift
;     genSignedRightShift
;     genRightShiftLiteral
;     genrshOne
	mov	a,r2
	swap	a
	anl	a,#0x0f
	jnb	acc.3,00109$
	orl	a,#0xf0
00109$:
	mov	r3,a
;     genAnd
	mov	a,#0x0F
	anl	a,r3
;     genOr
	orl	a,#0x40
	mov	r3,a
;     genAnd
	mov	a,#0x80
	anl	a,_P2
;     genOr
	orl	a,r3
	mov	_P2,a
;src/lcd.c:106: enable();
;     genCall
	push	ar2
	lcall	_enable
	pop	ar2
;src/lcd.c:107: LCD_CTRL_PORT = ( value & 0x0f ) | LCD_RS_BIT_MASK | LCD_CTRL_PORT&0x80;
;     genAnd
	mov	a,#0x0F
	anl	a,r2
;     genOr
	orl	a,#0x40
	mov	r2,a
;     genAnd
	mov	a,#0x80
	anl	a,_P2
;     genOr
	orl	a,r2
	mov	_P2,a
;src/lcd.c:108: enable();
;     genCall
	lcall	_enable
;src/lcd.c:109: LCD_RS_BIT = 0;
;     genAssign
	clr	_P2_6
00104$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_clear'
;------------------------------------------------------------
;------------------------------------------------------------
;src/lcd.c:119: void lcd_clear ( void ) 
;	-----------------------------------------
;	 function lcd_clear
;	-----------------------------------------
_lcd_clear:
	push	_bp
	mov	_bp,sp
;src/lcd.c:121: lcd_put_command( LCD_CLEAR );
;     genIpush
	mov	a,#0x01
	push	acc
;     genCall
	mov	dpl,#0x01
	lcall	_lcd_put
	dec	sp
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_home'
;------------------------------------------------------------
;------------------------------------------------------------
;src/lcd.c:131: void lcd_home ( void ) 
;	-----------------------------------------
;	 function lcd_home
;	-----------------------------------------
_lcd_home:
	push	_bp
	mov	_bp,sp
;src/lcd.c:133: lcd_put_command( LCD_HOME );
;     genIpush
	mov	a,#0x01
	push	acc
;     genCall
	mov	dpl,#0x02
	lcall	_lcd_put
	dec	sp
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'putchar'
;------------------------------------------------------------
;c                         Allocated to registers 
;------------------------------------------------------------
;src/lcd.c:136: void putchar(char c) 
;	-----------------------------------------
;	 function putchar
;	-----------------------------------------
_putchar:
	push	_bp
	mov	_bp,sp
;     genReceive
;src/lcd.c:138: lcd_put_char(c);
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	lcall	_lcd_put
	dec	sp
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_put_string'
;------------------------------------------------------------
;value                     Allocated to registers r2 r3 r4 
;i                         Allocated to registers 
;------------------------------------------------------------
;src/lcd.c:141: void lcd_put_string(const char *value) reentrant
;	-----------------------------------------
;	 function lcd_put_string
;	-----------------------------------------
_lcd_put_string:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;src/lcd.c:145: for(i=0; i<strlen(value); i++)
;     genAssign
	mov	r5,#0x00
00101$:
;     genCall
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_strlen
	mov	r6,dpl
	mov	r7,dph
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genCast
	mov	ar0,r5
	mov	r1,#0x00
;     genCmpLt
;     genCmp
	clr	c
	mov	a,r0
	subb	a,r6
	mov	a,r1
	xrl	a,#0x80
	mov	b,r7
	xrl	b,#0x80
	subb	a,b
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00105$
00109$:
;src/lcd.c:147: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/lcd.c:148: lcd_put_char(value[i]);
;     genPlus
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r6,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r7,a
	mov	ar0,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	lcall	__gptrget
	mov	r6,a
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	push	ar5
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,r6
	lcall	_lcd_put
	dec	sp
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;src/lcd.c:145: for(i=0; i<strlen(value); i++)
;     genPlus
;     genPlusIncr
	inc	r5
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00101$
00105$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_cursor_on'
;------------------------------------------------------------
;------------------------------------------------------------
;src/lcd.c:152: void lcd_cursor_on(void)
;	-----------------------------------------
;	 function lcd_cursor_on
;	-----------------------------------------
_lcd_cursor_on:
	push	_bp
	mov	_bp,sp
;src/lcd.c:154: lcd_put_command( LCD_CONTROL_ON | LCD_DISPLAY_ON | LCD_CURSOR_ON | LCD_BLINK_ON );
;     genIpush
	mov	a,#0x01
	push	acc
;     genCall
	mov	dpl,#0x0F
	lcall	_lcd_put
	dec	sp
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_cursor_off'
;------------------------------------------------------------
;------------------------------------------------------------
;src/lcd.c:157: void lcd_cursor_off(void)
;	-----------------------------------------
;	 function lcd_cursor_off
;	-----------------------------------------
_lcd_cursor_off:
	push	_bp
	mov	_bp,sp
;src/lcd.c:159: lcd_put_command( LCD_CONTROL_ON | LCD_DISPLAY_ON );
;     genIpush
	mov	a,#0x01
	push	acc
;     genCall
	mov	dpl,#0x0C
	lcall	_lcd_put
	dec	sp
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_init'
;------------------------------------------------------------
;------------------------------------------------------------
;src/lcd.c:174: void lcd_init ( void ) 
;	-----------------------------------------
;	 function lcd_init
;	-----------------------------------------
_lcd_init:
	push	_bp
	mov	_bp,sp
;src/lcd.c:176: lcd_delay(ENABLE_DELAY_LONG);
;     genCall
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0BB8
	lcall	_lcd_delay
;src/lcd.c:177: LCD_CTRL_PORT = LCD_INIT_FOR_4_BITS;
;     genAssign
	mov	_P2,#0x03
;src/lcd.c:178: enable();
;     genCall
	lcall	_enable
;src/lcd.c:180: lcd_delay(ENABLE_DELAY_LONG);
;     genCall
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0BB8
	lcall	_lcd_delay
;src/lcd.c:181: LCD_CTRL_PORT = LCD_INIT_FOR_4_BITS;
;     genAssign
	mov	_P2,#0x03
;src/lcd.c:182: enable();
;     genCall
	lcall	_enable
;src/lcd.c:184: lcd_delay(ENABLE_DELAY_LONG);
;     genCall
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0BB8
	lcall	_lcd_delay
;src/lcd.c:185: LCD_CTRL_PORT = LCD_INIT_FOR_4_BITS;
;     genAssign
	mov	_P2,#0x03
;src/lcd.c:186: enable();
;     genCall
	lcall	_enable
;src/lcd.c:188: lcd_delay(ENABLE_DELAY_LONG);
;     genCall
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0BB8
	lcall	_lcd_delay
;src/lcd.c:189: LCD_CTRL_PORT = LCD_FUNCTION_SET; 
;     genAssign
	mov	_P2,#0x02
;src/lcd.c:190: enable();
;     genCall
	lcall	_enable
;src/lcd.c:192: lcd_delay(ENABLE_DELAY_LONG);
;     genCall
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0BB8
	lcall	_lcd_delay
;src/lcd.c:194: lcd_put_command( LCD_CONTROL_ON | LCD_DISPLAY_ON );
;     genIpush
	mov	a,#0x01
	push	acc
;     genCall
	mov	dpl,#0x0C
	lcall	_lcd_put
	dec	sp
;src/lcd.c:195: lcd_clear();
;     genCall
	lcall	_lcd_clear
;src/lcd.c:196: lcd_home();
;     genCall
	lcall	_lcd_home
;src/lcd.c:197: lcd_cursor_off();
;     genCall
	lcall	_lcd_cursor_off
;src/lcd.c:200: lcd_delay(10000);
;     genCall
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x2710
	lcall	_lcd_delay
00101$:
	mov	sp,_bp
	pop	_bp
	ret
	.area CSEG    (CODE)
	.area XINIT   (CODE)
