;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.4.0 Thu Feb 10 12:42:20 2011

;--------------------------------------------------------
	.module src/flash
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _dummy
	.globl _flash_write_page
	.globl _flash_write_byte
	.globl _read_manufacturer
	.globl _write
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
_write::
	.ds 2
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
;src/flash.c:32: const code void (*write)(void)  = (const void(code*)(void))0xFFF0;
;     genAssign
	mov	_write,#0xF0
	mov	(_write + 1),#0xFF
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
;Allocation info for local variables in function 'read_manufacturer'
;------------------------------------------------------------
;------------------------------------------------------------
;src/flash.c:37: unsigned char read_manufacturer(void)
;	-----------------------------------------
;	 function read_manufacturer
;	-----------------------------------------
_read_manufacturer:
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
;src/flash.c:39: EA=0;
;     genAssign
	clr	_EA
;src/flash.c:40: MAP_BOOT
;     genOr
	orl	_AUXR1,#0x20
;src/flash.c:45: _endasm;
;     genInline
;
	   mov r1,#0
	   mov dptr,#1
	   mov acc,#02
;src/flash.c:46: write();
;     genPCall
	mov	a,#00103$
	push	acc
	mov	a,#(00103$ >> 8)
	push	acc
	push	_write
	push	(_write + 1)
	ret
00103$:
;src/flash.c:48: _endasm;
;     genInline
;
;src/flash.c:49: UNMAP_BOOT
;     genAssign
	mov	r2,_AUXR1
;     genAnd
	mov	a,#0xDF
	anl	a,r2
	mov	_AUXR1,a
;src/flash.c:50: EA=1;
;     genAssign
	setb	_EA
;src/flash.c:52: return ACC;
;     genRet
	mov	dpl,_ACC
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'flash_write_byte'
;------------------------------------------------------------
;address                   Allocated to stack - offset -4
;value                     Allocated to registers r2 
;------------------------------------------------------------
;src/flash.c:55: unsigned char flash_write_byte(unsigned char value, unsigned int address)
;	-----------------------------------------
;	 function flash_write_byte
;	-----------------------------------------
_flash_write_byte:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
;src/flash.c:57: DPL = (unsigned char)address&0xFF;
;     genCast
	mov	a,_bp
	add	a,#0xfc
	mov	r0,a
	mov	_DPL,@r0
;src/flash.c:58: DPH = (unsigned char)(address >> 8)&0xFF;
;     genRightShift
;     genRightShiftLiteral
	mov	a,_bp
	add	a,#0xfc
;     genrshTwo
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r0,a
	mov	ar3,@r0
	mov	r4,#0x00
;     genCast
	mov	_DPH,r3
;src/flash.c:59: EA=0;
;     genAssign
	clr	_EA
;src/flash.c:61: MAP_BOOT
;     genOr
	orl	_AUXR1,#0x20
;src/flash.c:71: _endasm;
;     genInline
;
	   mov a,#dummyret$
	   push acc
	   mov a,#(dummyret$ >> 8)
	   push acc
	   push _write
	   push (_write + 1)
	   mov r1,#02
;src/flash.c:72: A=value;
;     genAssign
	mov	_A,r2
;src/flash.c:77: _endasm;
;     genInline
;
	   ret
dummyret$:
;src/flash.c:78: UNMAP_BOOT
;     genAssign
	mov	r2,_AUXR1
;     genAnd
	mov	a,#0xDF
	anl	a,r2
	mov	_AUXR1,a
;src/flash.c:79: EA=1;
;     genAssign
	setb	_EA
;src/flash.c:81: return ACC;
;     genRet
	mov	dpl,_ACC
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'flash_write_page'
;------------------------------------------------------------
;xram                      Allocated to stack - offset -4
;flash                     Allocated to stack - offset -6
;count                     Allocated to registers r2 
;------------------------------------------------------------
;src/flash.c:84: unsigned char flash_write_page(unsigned char count, unsigned int xram, unsigned int flash) critical
;	-----------------------------------------
;	 function flash_write_page
;	-----------------------------------------
_flash_write_page:
	push	_bp
	mov	_bp,sp
	setb	c
	jbc	ea,00103$
	clr	c
00103$:
	push	psw
;     genReceive
	mov	r2,dpl
;src/flash.c:87: DPL = (unsigned char)flash&0xFF;
;     genCast
	mov	a,_bp
	add	a,#0xfa
	mov	r0,a
	mov	_DPL,@r0
;src/flash.c:88: DPH = (unsigned char)(flash >> 8)&0xFF;
;     genRightShift
;     genRightShiftLiteral
	mov	a,_bp
	add	a,#0xfa
;     genrshTwo
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r0,a
	mov	ar3,@r0
	mov	r4,#0x00
;     genCast
	mov	_DPH,r3
;src/flash.c:89: SET_DPTR1
;     genOr
	orl	_AUXR1,#0x01
;src/flash.c:90: DPL = (unsigned char)xram&0xFF;
;     genCast
	mov	a,_bp
	add	a,#0xfc
	mov	r0,a
	mov	_DPL,@r0
;src/flash.c:91: DPH = (unsigned char)(xram >> 8)&0xFF;
;     genRightShift
;     genRightShiftLiteral
	mov	a,_bp
	add	a,#0xfc
;     genrshTwo
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r0,a
	mov	ar3,@r0
	mov	r4,#0x00
;     genCast
	mov	_DPH,r3
;src/flash.c:92: SET_DPTR0
;     genAssign
	mov	r3,_AUXR1
;     genAnd
	mov	a,#0xFE
	anl	a,r3
	mov	_AUXR1,a
;src/flash.c:94: MAP_BOOT
;     genOr
	orl	_AUXR1,#0x20
;src/flash.c:103: _endasm;
;     genInline
;
	   mov a,#dummyret_f$
	   push acc
	   mov a,#(dummyret_f$ >> 8)
	   push acc
	   push _write
	   push (_write + 1)
	   mov r1,#09
;src/flash.c:104: A=count;
;     genAssign
	mov	_A,r2
;src/flash.c:111: _endasm;
;     genInline
;
	   ret
dummyret_f$:
;src/flash.c:112: UNMAP_BOOT
;     genAssign
	mov	r2,_AUXR1
;     genAnd
	mov	a,#0xDF
	anl	a,r2
	mov	_AUXR1,a
;src/flash.c:115: return ACC;
;     genRet
	mov	dpl,_ACC
00101$:
	pop	psw
	mov	ea,c
	mov	sp,_bp
	pop	_bp
	ret
	.area CSEG    (CODE)
_dummy	=	0xfff0
	.area XINIT   (CODE)
