;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.4.0 Thu Feb 10 12:42:19 2011

;--------------------------------------------------------
	.module src/rtc
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _monthDays
	.globl _day_full
	.globl _day
	.globl _month
	.globl _check_time
	.globl _rbyte_3w
	.globl _wbyte_3w
	.globl _reset_3w
	.globl _clear_time_struct
	.globl _ds1302_read_rtc
	.globl _ds1302_read_rtc_bcd
	.globl _ds1302_write_rtc
	.globl _bcd2bin
	.globl _local_gmtime
	.globl _local_mktime
	.globl _printf_asctime
	.globl _printf_short_asctime
	.globl _printf_date
	.globl _printf_weekday_short
	.globl _printf_day
	.globl _printf_time
	.globl _ds1302_write_memory
	.globl _ds1302_read_memory
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
;Allocation info for local variables in function 'reset_3w'
;------------------------------------------------------------
;------------------------------------------------------------
;src/rtc.c:76: void reset_3w()
;	-----------------------------------------
;	 function reset_3w
;	-----------------------------------------
_reset_3w:
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
;src/rtc.c:78: SCLK = 0;
;     genAssign
	clr	_P1_6
;src/rtc.c:79: RSTB = 0;
;     genAssign
	clr	_P1_7
;src/rtc.c:80: RSTB = 1;
;     genAssign
	setb	_P1_7
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wbyte_3w'
;------------------------------------------------------------
;W_Byte                    Allocated to registers r2 
;i                         Allocated to registers 
;temp                      Allocated to registers r2 
;------------------------------------------------------------
;src/rtc.c:83: void wbyte_3w(uchar W_Byte)
;	-----------------------------------------
;	 function wbyte_3w
;	-----------------------------------------
_wbyte_3w:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
;src/rtc.c:88: temp = W_Byte;
;     genAssign
;src/rtc.c:90: for(i = 0; i < 8; ++i)
;     genAssign
	mov	r3,#0x00
00103$:
;     genCmpLt
;     genCmp
	cjne	r3,#0x08,00112$
00112$:
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00107$
00113$:
;src/rtc.c:92: IO = 0;
;     genAssign
	clr	_P1_5
;src/rtc.c:93: if(temp & 0x01)
;     genAnd
	mov	a,r2
;     genIfxJump
;       Peephole 111    removed ljmp by inverse jump logic
	jnb     acc.0,00102$
00114$:
;src/rtc.c:95: IO = 1;	/* set port pin high to read data */
;     genAssign
	setb	_P1_5
00102$:
;src/rtc.c:97: SCLK = 0;
;     genAssign
	clr	_P1_6
;src/rtc.c:98: SCLK = 1;
;     genAssign
	setb	_P1_6
;src/rtc.c:99: temp >>= 1;
;     genRightShift
;     genRightShiftLiteral
;     genrshOne
	mov	a,r2
	clr	c
	rrc	a
	mov	r2,a
;src/rtc.c:90: for(i = 0; i < 8; ++i)
;     genPlus
;     genPlusIncr
	inc	r3
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00103$
00107$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'rbyte_3w'
;------------------------------------------------------------
;i                         Allocated to registers 
;R_Byte                    Allocated to registers r2 
;TmpByte                   Allocated to registers r4 
;------------------------------------------------------------
;src/rtc.c:103: uchar rbyte_3w()
;	-----------------------------------------
;	 function rbyte_3w
;	-----------------------------------------
_rbyte_3w:
	push	_bp
	mov	_bp,sp
;src/rtc.c:109: R_Byte = 0x00;
;     genAssign
	mov	r2,#0x00
;src/rtc.c:110: IO = 1;
;     genAssign
	setb	_P1_5
;src/rtc.c:111: for(i=0; i<8; ++i)
;     genAssign
	mov	r3,#0x00
00101$:
;     genCmpLt
;     genCmp
	cjne	r3,#0x08,00109$
00109$:
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00104$
00110$:
;src/rtc.c:113: SCLK = 1;
;     genAssign
	setb	_P1_6
;src/rtc.c:114: SCLK = 0;
;     genAssign
	clr	_P1_6
;src/rtc.c:115: TmpByte = (uchar)IO;
;     genAssign
	clr	a
	mov	c,_P1_5
	rlc	a
;src/rtc.c:116: TmpByte <<= 7;
;     genLeftShift
;     genLeftShiftLiteral
;     genlshOne
;       Peephole 105    removed redundant mov
	mov     r4,a
	rr	a
	anl	a,#0x80
	mov	r4,a
;src/rtc.c:117: R_Byte >>= 1;
;     genRightShift
;     genRightShiftLiteral
;     genrshOne
	mov	a,r2
	clr	c
	rrc	a
	mov	r2,a
;src/rtc.c:118: R_Byte |= TmpByte; 
;     genOr
	mov	a,r4
	orl	ar2,a
;src/rtc.c:111: for(i=0; i<8; ++i)
;     genPlus
;     genPlusIncr
	inc	r3
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00101$
00104$:
;src/rtc.c:120: return R_Byte;
;     genRet
	mov	dpl,r2
00105$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'clear_time_struct'
;------------------------------------------------------------
;tm_time                   Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;src/rtc.c:137: void clear_time_struct ( struct tm *tm_time )
;	-----------------------------------------
;	 function clear_time_struct
;	-----------------------------------------
_clear_time_struct:
	push	_bp
	mov	_bp,sp
;     genReceive
;src/rtc.c:139: tm_time->tm_sec = 0;
;     genPointerSet
;     genGenPointerSet
	mov     r2,dpl
	mov     r3,dph
	mov     r4,b
;       Peephole 238.d  removed 3 redundant moves
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
;src/rtc.c:140: tm_time->tm_min = 0;
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
;src/rtc.c:141: tm_time->tm_hour = 0;
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
;src/rtc.c:142: tm_time->tm_mday = 1;
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x01
	lcall	__gptrput
;src/rtc.c:143: tm_time->tm_mon = 0;
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
;src/rtc.c:144: tm_time->tm_wday = 1;
;     genPlus
	mov	a,#0x07
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x01
	lcall	__gptrput
;src/rtc.c:145: tm_time->tm_year = 0;
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
	inc	dptr
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ds1302_read_rtc'
;------------------------------------------------------------
;tm_time                   Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;src/rtc.c:148: void ds1302_read_rtc ( struct tm *tm_time )
;	-----------------------------------------
;	 function ds1302_read_rtc
;	-----------------------------------------
_ds1302_read_rtc:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;src/rtc.c:150: reset_3w();
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_reset_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:151: wbyte_3w(RTC_BURST|0x01);
;     genCall
	mov	dpl,#0xBF
	push	ar2
	push	ar3
	push	ar4
	lcall	_wbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:152: tm_time->tm_sec = bcd2bin(rbyte_3w()&0x7F);
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x7F
	mov	dpl,a
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_bcd2bin
	mov	r5,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__gptrput
;src/rtc.c:153: tm_time->tm_min = bcd2bin(rbyte_3w()&0x7F);
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x7F
	mov	dpl,a
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_bcd2bin
	mov	r0,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r0
	lcall	__gptrput
;src/rtc.c:154: tm_time->tm_hour = bcd2bin(rbyte_3w()&0x3F);
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x3F
	mov	dpl,a
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_bcd2bin
	mov	r0,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r0
	lcall	__gptrput
;src/rtc.c:155: tm_time->tm_mday = bcd2bin(rbyte_3w()&0x3F);
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x3F
	mov	dpl,a
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_bcd2bin
	mov	r0,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r0
	lcall	__gptrput
;src/rtc.c:156: tm_time->tm_mon = bcd2bin(rbyte_3w()&0x1F);
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x1F
	mov	dpl,a
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_bcd2bin
	mov	r0,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r0
	lcall	__gptrput
;src/rtc.c:157: tm_time->tm_wday = bcd2bin(rbyte_3w()&0x7);
;     genPlus
	mov	a,#0x07
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x07
	mov	dpl,a
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_bcd2bin
	mov	r0,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r0
	lcall	__gptrput
;src/rtc.c:158: tm_time->tm_year = bcd2bin(rbyte_3w());
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_rbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_bcd2bin
	mov	r5,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;     genCast
	mov	r6,#0x00
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	lcall	__gptrput
;src/rtc.c:160: rbyte_3w();
;     genCall
	lcall	_rbyte_3w
;src/rtc.c:161: reset_3w();
;     genCall
	lcall	_reset_3w
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ds1302_read_rtc_bcd'
;------------------------------------------------------------
;tm_time                   Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;src/rtc.c:164: void ds1302_read_rtc_bcd ( struct tm *tm_time )
;	-----------------------------------------
;	 function ds1302_read_rtc_bcd
;	-----------------------------------------
_ds1302_read_rtc_bcd:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;src/rtc.c:166: reset_3w();
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_reset_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:167: wbyte_3w(RTC_BURST|0x01);
;     genCall
	mov	dpl,#0xBF
	push	ar2
	push	ar3
	push	ar4
	lcall	_wbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:168: tm_time->tm_sec =  rbyte_3w()&0x7F;
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x7F
;     genPointerSet
;     genGenPointerSet
;       Peephole 191    removed redundant mov
	mov     r5,a
	mov     dpl,r2
	mov     dph,r3
	mov     b,r4
	lcall	__gptrput
;src/rtc.c:169: tm_time->tm_min =  rbyte_3w()&0x7F;
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x7F
;     genPointerSet
;     genGenPointerSet
;       Peephole 191    removed redundant mov
	mov     r0,a
	mov     dpl,r5
	mov     dph,r6
	mov     b,r7
	lcall	__gptrput
;src/rtc.c:170: tm_time->tm_hour = rbyte_3w()&0x3F;
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x3F
;     genPointerSet
;     genGenPointerSet
;       Peephole 191    removed redundant mov
	mov     r0,a
	mov     dpl,r5
	mov     dph,r6
	mov     b,r7
	lcall	__gptrput
;src/rtc.c:171: tm_time->tm_mday = rbyte_3w()&0x3F;
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x3F
;     genPointerSet
;     genGenPointerSet
;       Peephole 191    removed redundant mov
	mov     r0,a
	mov     dpl,r5
	mov     dph,r6
	mov     b,r7
	lcall	__gptrput
;src/rtc.c:172: tm_time->tm_mon =  rbyte_3w()&0x1F;
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x1F
;     genPointerSet
;     genGenPointerSet
;       Peephole 191    removed redundant mov
	mov     r0,a
	mov     dpl,r5
	mov     dph,r6
	mov     b,r7
	lcall	__gptrput
;src/rtc.c:173: tm_time->tm_wday = rbyte_3w()&0x7;
;     genPlus
	mov	a,#0x07
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_rbyte_3w
	mov	a,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genAnd
	anl	a,#0x07
;     genPointerSet
;     genGenPointerSet
;       Peephole 191    removed redundant mov
	mov     r0,a
	mov     dpl,r5
	mov     dph,r6
	mov     b,r7
	lcall	__gptrput
;src/rtc.c:174: tm_time->tm_year = rbyte_3w();
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_rbyte_3w
	mov	r5,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;     genCast
	mov	r6,#0x00
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	lcall	__gptrput
;src/rtc.c:176: rbyte_3w();
;     genCall
	lcall	_rbyte_3w
;src/rtc.c:177: reset_3w();
;     genCall
	lcall	_reset_3w
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ds1302_write_rtc'
;------------------------------------------------------------
;tm_time                   Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;src/rtc.c:180: void ds1302_write_rtc ( const struct tm *tm_time )
;	-----------------------------------------
;	 function ds1302_write_rtc
;	-----------------------------------------
_ds1302_write_rtc:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;src/rtc.c:182: reset_3w();
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_reset_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:183: wbyte_3w(RTC_CTRL);    // "Write Protect" flag reset:
;     genCall
	mov	dpl,#0x8E
	push	ar2
	push	ar3
	push	ar4
	lcall	_wbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:184: wbyte_3w(0x00);
;     genCall
	mov	dpl,#0x00
	push	ar2
	push	ar3
	push	ar4
	lcall	_wbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:185: reset_3w();
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_reset_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:186: wbyte_3w(RTC_BURST);  // Writing data in burst mode:
;     genCall
	mov	dpl,#0xBE
	push	ar2
	push	ar3
	push	ar4
	lcall	_wbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:187: wbyte_3w( tm_time->tm_sec );    // writing seconds:
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
;     genCall
;       Peephole 244.c  loading dpl from a instead of r5
	mov	r5,a
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_wbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:188: wbyte_3w( tm_time->tm_min );    // writing minutes:
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
;     genCall
;       Peephole 244.c  loading dpl from a instead of r5
	mov	r5,a
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_wbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:189: wbyte_3w( tm_time->tm_hour );   // writing hours:
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
;     genCall
;       Peephole 244.c  loading dpl from a instead of r5
	mov	r5,a
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_wbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:190: wbyte_3w( tm_time->tm_mday );   // writing day of the month:
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
;     genCall
;       Peephole 244.c  loading dpl from a instead of r5
	mov	r5,a
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_wbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:191: wbyte_3w( tm_time->tm_mon );    // writing month:
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
;     genCall
;       Peephole 244.c  loading dpl from a instead of r5
	mov	r5,a
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_wbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:192: wbyte_3w( tm_time->tm_wday );   // writing day of week:
;     genPlus
	mov	a,#0x07
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
;     genCall
;       Peephole 244.c  loading dpl from a instead of r5
	mov	r5,a
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_wbyte_3w
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:193: wbyte_3w( (unsigned char)(tm_time->tm_year&0xff) );   // writing year:
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	lcall	__gptrget
	mov	r3,a
;     genCast
	mov	dpl,r2
;     genCall
	lcall	_wbyte_3w
;src/rtc.c:194: wbyte_3w(0x80);                 // "Write Protect" flag set:
;     genCall
	mov	dpl,#0x80
	lcall	_wbyte_3w
;src/rtc.c:195: reset_3w();
;     genCall
	lcall	_reset_3w
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'bcd2bin'
;------------------------------------------------------------
;bcd                       Allocated to registers r2 
;retval                    Allocated to registers r3 
;------------------------------------------------------------
;src/rtc.c:198: unsigned char bcd2bin(unsigned char bcd)
;	-----------------------------------------
;	 function bcd2bin
;	-----------------------------------------
_bcd2bin:
	push	_bp
	mov	_bp,sp
;     genReceive
;src/rtc.c:201: retval = bcd>>4 & 0x0f;
;     genRightShift
;     genRightShiftLiteral
;     genrshOne
;       Peephole 244.a  moving first to a instead of r2
	mov	a,dpl
	mov	r2,a
	swap	a
;     genAnd
;src/rtc.c:202: retval *= 10;
;     genMult
;     genMultOneByte
;       Peephole 139    removed redundant mov
;       Peephole 183    avoided anl during execution
	anl     a,#(0x0f & 0x0F)
	mov     r3,a
	mov	b,#0x0A
	mul	ab
	mov	r3,a
;src/rtc.c:203: retval += bcd & 0x0f;
;     genAnd
	anl	ar2,#0x0F
;     genPlus
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
;src/rtc.c:204: return retval;
;     genRet
;       Peephole 244.c  loading dpl from a instead of r3
	mov	r3,a
	mov	dpl,a
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'check_time'
;------------------------------------------------------------
;timeptr                   Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;src/rtc.c:207: void check_time(struct tm *timeptr) 
;	-----------------------------------------
;	 function check_time
;	-----------------------------------------
_check_time:
	push	_bp
	mov	_bp,sp
;     genReceive
;src/rtc.c:211: if (timeptr->tm_sec<0) timeptr->tm_sec=0;
;     genPointerGet
;     genGenPointerGet
	mov     r2,dpl
	mov     r3,dph
	mov     r4,b
;       Peephole 238.d  removed 3 redundant moves
	lcall	__gptrget
	mov	r5,a
;     genCmpLt
;     genCmp
	cjne	r5,#0x00,00148$
00148$:
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00104$
00149$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00105$
00104$:
;src/rtc.c:212: else if (timeptr->tm_sec>59) timeptr->tm_sec=59;
;     genCmpGt
;     genCmp
	clr	c
	mov	a,#0x3B
	subb	a,r5
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00105$
00150$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,#0x3B
	lcall	__gptrput
00105$:
;src/rtc.c:213: if (timeptr->tm_min<0) timeptr->tm_min=0;
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
;     genCmpLt
;     genCmp
	cjne	r0,#0x00,00151$
00151$:
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00109$
00152$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00110$
00109$:
;src/rtc.c:214: else if (timeptr->tm_min>59) timeptr->tm_min=59;
;     genCmpGt
;     genCmp
	clr	c
	mov	a,#0x3B
	subb	a,r0
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00110$
00153$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x3B
	lcall	__gptrput
00110$:
;src/rtc.c:215: if (timeptr->tm_hour<0) timeptr->tm_hour=0;
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
;     genCmpLt
;     genCmp
	cjne	r0,#0x00,00154$
00154$:
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00114$
00155$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00115$
00114$:
;src/rtc.c:216: else if (timeptr->tm_hour>23) timeptr->tm_hour=23;
;     genCmpGt
;     genCmp
	clr	c
	mov	a,#0x17
	subb	a,r0
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00115$
00156$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x17
	lcall	__gptrput
00115$:
;src/rtc.c:217: if (timeptr->tm_wday<0) timeptr->tm_wday=0;
;     genPlus
	mov	a,#0x07
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
;     genCmpLt
;     genCmp
	cjne	r0,#0x00,00157$
00157$:
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00119$
00158$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00120$
00119$:
;src/rtc.c:218: else if (timeptr->tm_wday>7) timeptr->tm_wday=7;
;     genCmpGt
;     genCmp
	clr	c
	mov	a,#0x07
	subb	a,r0
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00120$
00159$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x07
	lcall	__gptrput
00120$:
;src/rtc.c:219: if (timeptr->tm_mday<1) timeptr->tm_mday=1;
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
;     genCmpLt
;     genCmp
	cjne	r0,#0x01,00160$
00160$:
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00124$
00161$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x01
	lcall	__gptrput
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00125$
00124$:
;src/rtc.c:220: else if (timeptr->tm_mday>31) timeptr->tm_mday=31;
;     genCmpGt
;     genCmp
	clr	c
	mov	a,#0x1F
	subb	a,r0
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00125$
00162$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x1F
	lcall	__gptrput
00125$:
;src/rtc.c:221: if (timeptr->tm_mon<0) timeptr->tm_mon=0;
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
;     genCmpLt
;     genCmp
	cjne	r0,#0x00,00163$
00163$:
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00129$
00164$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00130$
00129$:
;src/rtc.c:222: else if (timeptr->tm_mon>11) timeptr->tm_mon=11;
;     genCmpGt
;     genCmp
	clr	c
	mov	a,#0x0B
	subb	a,r0
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00130$
00165$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x0B
	lcall	__gptrput
00130$:
;src/rtc.c:223: if (timeptr->tm_year<0) timeptr->tm_year=0;
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	inc	dptr
	lcall	__gptrget
;     genCmpLt
;     genCmp
;       Peephole 105    removed redundant mov
	mov     r6,a
;     genIfxJump
;       Peephole 111    removed ljmp by inverse jump logic
	jnb     acc.7,00133$
00166$:
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
	inc	dptr
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
00133$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'local_gmtime'
;------------------------------------------------------------
;timep                     Allocated to registers r2 r3 r4 
;epoch                     Allocated to stack - offset 1
;year                      Allocated to registers 
;month                     Allocated to registers 
;monthLength               Allocated to registers r4 
;days                      Allocated to stack - offset 5
;------------------------------------------------------------
;src/rtc.c:228: void local_gmtime(time_t *timep) {
;	-----------------------------------------
;	 function local_gmtime
;	-----------------------------------------
_local_gmtime:
	push	_bp
	mov	_bp,sp
	mov	a,sp
	add	a,#0x08
	mov	sp,a
;     genReceive
;src/rtc.c:230: unsigned long epoch=*timep;
;     genPointerGet
;     genGenPointerGet
	mov     r2,dpl
	mov     r3,dph
	mov     r4,b
;       Peephole 238.d  removed 3 redundant moves
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	lcall	__gptrget
	mov	r3,a
	inc	dptr
	lcall	__gptrget
	mov	r4,a
	inc	dptr
	lcall	__gptrget
	mov	r5,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;src/rtc.c:235: system_time.tm_sec=epoch%60;
;     genAssign
	clr	a
	mov	(__modulong_PARM_2 + 3),a
	mov	(__modulong_PARM_2 + 2),a
	mov	(__modulong_PARM_2 + 1),a
	mov	__modulong_PARM_2,#0x3C
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	inc	r0
	mov	a,@r0
	lcall	__modulong
	mov	r6,dpl
	mov	r7,dph
	mov	r2,b
	mov	r3,a
;     genCast
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_system_time
	mov	a,r6
	movx	@dptr,a
;src/rtc.c:236: epoch/=60; // now it is minutes
;     genAssign
	clr	a
	mov	(__divulong_PARM_2 + 3),a
	mov	(__divulong_PARM_2 + 2),a
	mov	(__divulong_PARM_2 + 1),a
	mov	__divulong_PARM_2,#0x3C
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	inc	r0
	mov	a,@r0
	lcall	__divulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;src/rtc.c:237: system_time.tm_min=epoch%60;
;     genAssign
	clr	a
	mov	(__modulong_PARM_2 + 3),a
	mov	(__modulong_PARM_2 + 2),a
	mov	(__modulong_PARM_2 + 1),a
	mov	__modulong_PARM_2,#0x3C
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	inc	r0
	mov	a,@r0
	lcall	__modulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;     genCast
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0001)
	mov	a,r2
	movx	@dptr,a
;src/rtc.c:238: epoch/=60; // now it is hours
;     genAssign
	clr	a
	mov	(__divulong_PARM_2 + 3),a
	mov	(__divulong_PARM_2 + 2),a
	mov	(__divulong_PARM_2 + 1),a
	mov	__divulong_PARM_2,#0x3C
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	inc	r0
	mov	a,@r0
	lcall	__divulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;src/rtc.c:239: system_time.tm_hour=epoch%24;
;     genAssign
	clr	a
	mov	(__modulong_PARM_2 + 3),a
	mov	(__modulong_PARM_2 + 2),a
	mov	(__modulong_PARM_2 + 1),a
	mov	__modulong_PARM_2,#0x18
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	inc	r0
	mov	a,@r0
	lcall	__modulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;     genCast
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0002)
	mov	a,r2
	movx	@dptr,a
;src/rtc.c:240: epoch/=24; // now it is days
;     genAssign
	clr	a
	mov	(__divulong_PARM_2 + 3),a
	mov	(__divulong_PARM_2 + 2),a
	mov	(__divulong_PARM_2 + 1),a
	mov	__divulong_PARM_2,#0x18
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	inc	r0
	mov	a,@r0
	lcall	__divulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;src/rtc.c:241: system_time.tm_wday=(epoch+4)%7;
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x04
	add	a,@r0
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r3,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r5,a
;     genAssign
	clr	a
	mov	(__modulong_PARM_2 + 3),a
	mov	(__modulong_PARM_2 + 2),a
	mov	(__modulong_PARM_2 + 1),a
	mov	__modulong_PARM_2,#0x07
;     genCall
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__modulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;     genCast
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0007)
	mov	a,r2
	movx	@dptr,a
;src/rtc.c:244: days=0;
;     genAssign
	mov	a,_bp
	add	a,#0x05
;       Peephole 218    simplified clear (4bytes)
	mov     r0,a
	clr     a
	mov     @r0,a
	inc     r0
	mov     @r0,a
	inc     r0
	mov     @r0,a
	inc     r0
	mov     @r0,a
;src/rtc.c:245: while((days += (LEAP_YEAR(year) ? 366 : 365)) <= epoch) {
;     genAssign
	mov	r6,#0xB2
	mov	r7,#0x07
00101$:
;     genIpush
;     genAnd
	mov	a,#0x03
	anl	a,r6
	mov	r2,a
	mov	r3,#0x00
;     genCmpEq
;       Peephole 241.b  optimized compare
	clr     a
	cjne    r2,#0x00,00132$
	cjne    r3,#0x00,00132$
	inc     a
00132$:
00133$:
;     genIpop
;     genIfx
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00119$
00134$:
;     genAssign
	mov	r2,#0x6E
	mov	r3,#0x01
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00120$
00119$:
;     genAssign
	mov	r2,#0x6D
	mov	r3,#0x01
00120$:
;     genCast
	mov	a,r3
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	r5,a
;     genPlus
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
	add	a,@r0
	mov	r2,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	inc	r0
	addc	a,@r0
	mov	r3,a
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	inc	r0
	addc	a,@r0
	mov	r4,a
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
	inc	r0
	addc	a,@r0
	mov	r5,a
;     genAssign
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;     genCmpGt
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genCmp
	clr	c
	mov	a,@r0
	subb	a,r2
	inc	r0
	mov	a,@r0
	subb	a,r3
	inc	r0
	mov	a,@r0
	subb	a,r4
	inc	r0
	mov	a,@r0
	subb	a,r5
;     genIfxJump
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 160    removed sjmp by inverse jump logic
	jc      00103$
00135$:
;src/rtc.c:246: year++;
;     genPlus
;     genPlusIncr
	inc	r6
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 243    avoided branch to sjmp
	cjne    r6,#0x00,00101$
	inc     r7
00136$:
	sjmp    00101$      
00103$:
;src/rtc.c:248: system_time.tm_year=year-2000;
;     genMinus
	mov	a,r6
	add	a,#0x30
	mov	r2,a
	mov	a,r7
	addc	a,#0xf8
	mov	r3,a
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0005)
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;src/rtc.c:250: days -= LEAP_YEAR(year) ? 366 : 365;
;     genAnd
	anl	ar6,#0x03
	mov	r7,#0x00
;     genCmpEq
;       Peephole 241.b  optimized compare
	clr     a
	cjne    r6,#0x00,00137$
	cjne    r7,#0x00,00137$
	inc     a
00137$:
00138$:
;     genIfx
;       Peephole 105    removed redundant mov
	mov     r2,a
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00121$
00139$:
;     genAssign
	mov	r3,#0x6E
	mov	r4,#0x01
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00122$
00121$:
;     genAssign
	mov	r3,#0x6D
	mov	r4,#0x01
00122$:
;     genCast
	mov	a,r4
	rlc	a
	subb	a,acc
	mov	r5,a
	mov	r6,a
;     genMinus
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	a,@r0
	clr	c
;       Peephole 236.l  used r3 instead of ar3
	subb    a,r3
	mov	@r0,a
	inc	r0
	mov	a,@r0
;       Peephole 236.l  used r4 instead of ar4
	subb    a,r4
	mov	@r0,a
	inc	r0
	mov	a,@r0
;       Peephole 236.l  used r5 instead of ar5
	subb    a,r5
	mov	@r0,a
	inc	r0
	mov	a,@r0
;       Peephole 236.l  used r6 instead of ar6
	subb    a,r6
	mov	@r0,a
;src/rtc.c:251: epoch -= days; // now it is days in this year, starting at 0
;     genMinus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,_bp
	add	a,#0x05
	mov	r1,a
	mov	a,@r0
	clr	c
	subb	a,@r1
	mov	@r0,a
	inc	r0
	mov	a,@r0
	inc	r1
	subb	a,@r1
	mov	@r0,a
	inc	r0
	mov	a,@r0
	inc	r1
	subb	a,@r1
	mov	@r0,a
	inc	r0
	mov	a,@r0
	inc	r1
	subb	a,@r1
	mov	@r0,a
;src/rtc.c:252: system_time.tm_yday=epoch;
;     genCast
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0008)
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
;src/rtc.c:257: for (month=0; month<12; month++) {
;     genAssign
	mov	r3,#0x00
00113$:
;     genCmpLt
;     genCmp
	cjne	r3,#0x0C,00140$
00140$:
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00116$
00141$:
;src/rtc.c:258: if (month==1) { // februari
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    r3,#0x01,00108$
;00142$:
;       Peephole 200    removed redundant sjmp
00143$:
;src/rtc.c:259: if (LEAP_YEAR(year)) {
;     genIfx
	mov	a,r2
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00105$
00144$:
;src/rtc.c:260: monthLength=29;
;     genAssign
	mov	r4,#0x1D
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00109$
00105$:
;src/rtc.c:262: monthLength=28;
;     genAssign
	mov	r4,#0x1C
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00109$
00108$:
;src/rtc.c:265: monthLength = monthDays[month];
;     genPlus
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
;       Peephole 181    changed mov to clr
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
;       Peephole 186.d  optimized movc sequence
	mov     dptr,#_monthDays
	movc    a,@a+dptr
	mov	r5,a
;     genAssign
	mov	ar4,r5
00109$:
;src/rtc.c:268: if (epoch>=monthLength) {
;     genIpush
	push	ar2
;     genCast
	mov	ar5,r4
	mov	r6,#0x00
;     genCmpLt
;       Peephole 3.c    changed mov to clr
	clr     a
	mov     r7,a
	mov     r2,a
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genCmp
	clr	c
	mov	a,@r0
	subb	a,r5
	inc	r0
	mov	a,@r0
	subb	a,r6
	inc	r0
	mov	a,@r0
	subb	a,r7
	inc	r0
	mov	a,@r0
	subb	a,r2
	clr	a
	rlc	a
;     genIpop
	pop	ar2
;     genIfx
;     genIfxJump
;       Peephole 109    removed ljmp by inverse jump logic
	jnz     00116$
00145$:
;src/rtc.c:269: epoch-=monthLength;
;     genCast
	mov	r5,#0x00
;     genCast
	mov	a,r5
	rlc	a
	subb	a,acc
	mov	r6,a
	mov	r7,a
;     genMinus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,@r0
	clr	c
;       Peephole 236.l  used r4 instead of ar4
	subb    a,r4
	mov	@r0,a
	inc	r0
	mov	a,@r0
;       Peephole 236.l  used r5 instead of ar5
	subb    a,r5
	mov	@r0,a
	inc	r0
	mov	a,@r0
;       Peephole 236.l  used r6 instead of ar6
	subb    a,r6
	mov	@r0,a
	inc	r0
	mov	a,@r0
;       Peephole 236.l  used r7 instead of ar7
	subb    a,r7
	mov	@r0,a
;src/rtc.c:257: for (month=0; month<12; month++) {
;     genPlus
;     genPlusIncr
	inc	r3
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00113$
00116$:
;src/rtc.c:274: system_time.tm_mon=month;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0004)
	mov	a,r3
	movx	@dptr,a
;src/rtc.c:275: system_time.tm_mday=epoch+1;
;     genCast
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	ar2,@r0
;     genPlus
;     genPlusIncr
	inc	r2
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0003)
	mov	a,r2
	movx	@dptr,a
;src/rtc.c:277: system_time.tm_isdst=0;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x000a)
;       Peephole 181    changed mov to clr
	clr     a
	movx	@dptr,a
00117$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'local_mktime'
;------------------------------------------------------------
;add                       Allocated to stack - offset -4
;timeptr                   Allocated to stack - offset 1
;year                      Allocated to stack - offset 4
;month                     Allocated to stack - offset 6
;mday                      Allocated to stack - offset 7
;i                         Allocated to registers 
;seconds                   Allocated to stack - offset 8
;------------------------------------------------------------
;src/rtc.c:286: time_t local_mktime(struct tm *timeptr, unsigned int add) {
;	-----------------------------------------
;	 function local_mktime
;	-----------------------------------------
_local_mktime:
	push	_bp
	mov	_bp,sp
	mov	a,sp
	add	a,#0x0b
	mov	sp,a
;     genReceive
	push	acc
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	pop	acc
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
	inc	r0
	mov	@r0,b
;src/rtc.c:289: int year=timeptr->tm_year + add;
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,#0x05
	add	a,@r0
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r6,a
	inc	r0
	mov	ar7,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r5,a
	inc	dptr
	lcall	__gptrget
	mov	r6,a
;     genPlus
	mov	a,_bp
	add	a,#0xfc
	mov	r0,a
	mov	a,@r0
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r5,a
	inc	r0
	mov	a,@r0
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	r6,a
;     genAssign
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	@r0,ar5
	inc	r0
	mov	@r0,ar6
;src/rtc.c:290: char month=timeptr->tm_mon;
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x04
	add	a,@r0
	mov	r7,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r2,a
	inc	r0
	mov	ar3,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r7
	mov	dph,r2
	mov	b,r3
	lcall	__gptrget
	mov	r7,a
;     genAssign
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	@r0,ar7
;src/rtc.c:291: char mday = timeptr->tm_mday - 1;
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x03
	add	a,@r0
	mov	r3,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r4,a
	inc	r0
	mov	ar7,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r3
	mov	dph,r4
	mov	b,r7
	lcall	__gptrget
	mov	r3,a
;     genMinus
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
;     genMinusDec
	mov	a,r3
	dec	a
	mov	@r0,a
;src/rtc.c:295: check_time(timeptr);
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	_check_time
;src/rtc.c:298: seconds = (year-1970)*(YEAR);
;     genMinus
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	add	a,#0x4e
	mov	r4,a
	inc	r0
	mov	a,@r0
	addc	a,#0xf8
;     genCast
;       Peephole 105    removed redundant mov
	mov     r7,a
	rlc	a
	subb	a,acc
	mov	r3,a
	mov	r2,a
;     genAssign
	mov	__mullong_PARM_2,#0x80
	mov	(__mullong_PARM_2 + 1),#0x33
	mov	(__mullong_PARM_2 + 2),#0xE1
	mov	(__mullong_PARM_2 + 3),#0x01
;     genCall
	mov	dpl,r4
	mov	dph,r7
	mov	b,r3
	mov	a,r2
	lcall	__mullong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r7,a
;     genAssign
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar7
;src/rtc.c:301: for (i=1970; i<year; i++) 
;     genAssign
	mov	r5,#0xB2
	mov	r6,#0x07
00107$:
;     genCmpLt
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
;     genCmp
	clr	c
	mov	a,r5
	subb	a,@r0
	mov	a,r6
	xrl	a,#0x80
	inc	r0
	mov	b,@r0
	xrl	b,#0x80
	subb	a,b
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00123$
00124$:
;src/rtc.c:303: if (LEAP_YEAR(i)) 
;     genIpush
;     genAnd
	mov	a,#0x03
	anl	a,r5
	mov	r2,a
	mov	r3,#0x00
;     genCmpEq
;       Peephole 241.b  optimized compare
	clr     a
	cjne    r2,#0x00,00125$
	cjne    r3,#0x00,00125$
	inc     a
00125$:
00126$:
;     genIpop
;     genIfx
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00109$
00127$:
;src/rtc.c:305: seconds+= DAY;
;     genPlus
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
	mov	a,#0x80
	add	a,@r0
	mov	@r0,a
	mov	a,#0x51
	inc	r0
	addc	a,@r0
	mov	@r0,a
	mov	a,#0x01
	inc	r0
	addc	a,@r0
	mov	@r0,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	@r0,a
00109$:
;src/rtc.c:301: for (i=1970; i<year; i++) 
;     genPlus
;     genPlusIncr
	inc	r5
;src/rtc.c:310: for (i=0; i<month; i++) 
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 243    avoided branch to sjmp
	cjne    r5,#0x00,00107$
	inc     r6
00128$:
	sjmp    00107$      
00123$:
;     genAnd
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,#0x03
	anl	a,@r0
	mov	r5,a
	mov	r6,#0x00
;     genCmpEq
;       Peephole 241.b  optimized compare
	clr     a
	cjne    r5,#0x00,00129$
	cjne    r6,#0x00,00129$
	inc     a
00129$:
00130$:
	mov	r5,a
;     genAssign
	mov	r6,#0x00
	mov	r2,#0x00
00111$:
;     genCast
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	ar3,@r0
	mov	a,@r0
	rlc	a
	subb	a,acc
	mov	r4,a
;     genCmpLt
;     genCmp
	clr	c
	mov	a,r6
	subb	a,r3
	mov	a,r2
	xrl	a,#0x80
	mov	b,r4
	xrl	b,#0x80
	subb	a,b
;     genIfxJump
	jc	00131$
	ljmp	00114$
00131$:
;src/rtc.c:312: if (i==1 && LEAP_YEAR(year)) 
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 198    optimized misc jump sequence
	cjne    r6,#0x01,00104$
	cjne    r2,#0x00,00104$
;00132$:
;       Peephole 200    removed redundant sjmp
00133$:
;     genIfx
	mov	a,r5
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00104$
00134$:
;src/rtc.c:314: seconds+= DAY*29;
;     genPlus
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
	mov	a,#0x80
	add	a,@r0
	mov	@r0,a
	mov	a,#0x3B
	inc	r0
	addc	a,@r0
	mov	@r0,a
	mov	a,#0x26
	inc	r0
	addc	a,@r0
	mov	@r0,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	@r0,a
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00113$
00104$:
;src/rtc.c:318: seconds+= DAY*monthDays[i];
;     genIpush
	push	ar5
;     genPlus
;       Peephole 236.g  used r6 instead of ar6
	mov     a,r6
	add	a,#_monthDays
	mov	dpl,a
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
	addc	a,#(_monthDays >> 8)
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
;     genCast
;       Peephole 105    removed redundant mov
	mov     r3,a
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	r7,a
	mov	r5,a
;     genAssign
	mov	__mullong_PARM_2,#0x80
	mov	(__mullong_PARM_2 + 1),#0x51
	mov	(__mullong_PARM_2 + 2),#0x01
	mov	(__mullong_PARM_2 + 3),#0x00
;     genCall
	mov	dpl,r3
	mov	dph,r4
	mov	b,r7
	mov	a,r5
	push	ar2
	push	ar6
	lcall	__mullong
	mov	r3,dpl
	mov	r4,dph
	mov	r5,b
	mov	r7,a
	pop	ar6
	pop	ar2
;     genPlus
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	add	a,@r0
	mov	@r0,a
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	inc	r0
	addc	a,@r0
	mov	@r0,a
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
	inc	r0
	addc	a,@r0
	mov	@r0,a
;       Peephole 236.g  used r7 instead of ar7
	mov     a,r7
	inc	r0
	addc	a,@r0
	mov	@r0,a
;src/rtc.c:323: return seconds;
;     genIpop
	pop	ar5
;src/rtc.c:318: seconds+= DAY*monthDays[i];
00113$:
;src/rtc.c:310: for (i=0; i<month; i++) 
;     genPlus
;     genPlusIncr
	inc	r6
	cjne	r6,#0x00,00135$
	inc	r2
00135$:
	ljmp	00111$
00114$:
;src/rtc.c:322: seconds+= mday*DAY;
;     genCast
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
	mov	ar2,@r0
	mov	a,@r0
	rlc	a
	subb	a,acc
	mov	r3,a
	mov	r4,a
	mov	r5,a
;     genAssign
	mov	__mullong_PARM_2,#0x80
	mov	(__mullong_PARM_2 + 1),#0x51
	mov	(__mullong_PARM_2 + 2),#0x01
	mov	(__mullong_PARM_2 + 3),#0x00
;     genCall
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__mullong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;     genPlus
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
	add	a,@r0
	mov	@r0,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	inc	r0
	addc	a,@r0
	mov	@r0,a
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	inc	r0
	addc	a,@r0
	mov	@r0,a
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
	inc	r0
	addc	a,@r0
	mov	@r0,a
;src/rtc.c:323: return seconds;
;     genRet
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	inc	r0
	mov	a,@r0
00115$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'printf_asctime'
;------------------------------------------------------------
;timeptr                   Allocated to stack - offset 1
;sloc0                     Allocated to stack - offset 4
;sloc1                     Allocated to stack - offset 4
;sloc2                     Allocated to stack - offset 6
;sloc3                     Allocated to stack - offset 12
;------------------------------------------------------------
;src/rtc.c:327: void printf_asctime(struct tm *timeptr) 
;	-----------------------------------------
;	 function printf_asctime
;	-----------------------------------------
_printf_asctime:
	push	_bp
	mov	_bp,sp
	mov	a,sp
	add	a,#0x08
	mov	sp,a
;     genReceive
	push	acc
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	pop	acc
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
	inc	r0
	mov	@r0,b
;src/rtc.c:329: check_time(timeptr);
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	_check_time
;src/rtc.c:330: printf_fast("%04u ",(unsigned int)timeptr->tm_year+2000);
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,#0x05
	add	a,@r0
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r6,a
	inc	r0
	mov	ar7,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r5,a
	inc	dptr
	lcall	__gptrget
	mov	r6,a
;     genPlus
	mov	a,#0xD0
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r5,a
	mov	a,#0x07
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	r6,a
;     genIpush
	push	ar5
	push	ar6
;     genIpush
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;src/rtc.c:331: printf_fast((char code*)month[bcd2bin(timeptr->tm_mon)]);
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x04
	add	a,@r0
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r6,a
	inc	r0
	mov	ar7,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
;     genCall
;       Peephole 244.c  loading dpl from a instead of r5
	mov	r5,a
	mov	dpl,a
	lcall	_bcd2bin
	mov	a,dpl
;     genMult
;     genMultOneByte
;     genPlus
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
;       Peephole 186.e  optimized movc sequence (b, dptr differ)
	add	a,acc
	mov     b,a
	mov	dptr,#_month
	jnc	.+3
	inc	dph
	movc    a,@a+dptr
	mov     r5,a
	mov     a,b
	inc	a
	movc    a,@a+dptr
	mov	r6,a
;     genIpush
	push	ar5
	push	ar6
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
;src/rtc.c:336: (unsigned int)timeptr->tm_sec);
;     genPointerGet
;     genGenPointerGet
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r5,a
;     genCast
	mov	ar2,r5
	mov	r3,#0x00
;src/rtc.c:335: (unsigned int)timeptr->tm_min, 
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r5,a
	inc	r0
	mov	ar6,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	lcall	__gptrget
	mov	r7,a
;     genCast
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	@r0,ar7
	inc	r0
	mov	@r0,#0x00
;src/rtc.c:334: (unsigned int)timeptr->tm_hour, 
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x02
	add	a,@r0
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r5,a
	inc	r0
	mov	ar6,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	lcall	__gptrget
	mov	r4,a
;     genCast
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	@r0,ar4
	inc	r0
	mov	@r0,#0x00
;src/rtc.c:333: (unsigned int)timeptr->tm_mday, 
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x03
	add	a,@r0
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r7,a
	inc	r0
	mov	ar5,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r4
	mov	dph,r7
	mov	b,r5
	lcall	__gptrget
	mov	r4,a
;     genCast
	mov	r5,#0x00
;src/rtc.c:332: printf_fast("%02u %02u:%02u:%02u", 
;     genIpush
	push	ar2
	push	ar3
;     genIpush
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
;     genIpush
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
;     genIpush
	push	ar4
	push	ar5
;     genIpush
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
;src/rtc.c:337: printf_fast("   ");
;     genIpush
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
;src/rtc.c:338: printf_fast((char code*)day_full[bcd2bin(timeptr->tm_wday)]);
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,#0x07
	add	a,@r0
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r5,a
	inc	r0
	mov	ar6,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	lcall	__gptrget
;     genCall
;       Peephole 244.c  loading dpl from a instead of r4
	mov	r4,a
	mov	dpl,a
	lcall	_bcd2bin
	mov	a,dpl
;     genMult
;     genMultOneByte
;     genPlus
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
;       Peephole 186.e  optimized movc sequence (b, dptr differ)
	add	a,acc
	mov     b,a
	mov	dptr,#_day_full
	jnc	.+3
	inc	dph
	movc    a,@a+dptr
	mov     r4,a
	mov     a,b
	inc	a
	movc    a,@a+dptr
	mov	r5,a
;     genIpush
	push	ar4
	push	ar5
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'printf_short_asctime'
;------------------------------------------------------------
;timeptr                   Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;src/rtc.c:342: void printf_short_asctime(struct tm *timeptr) 
;	-----------------------------------------
;	 function printf_short_asctime
;	-----------------------------------------
_printf_short_asctime:
	push	_bp
	mov	_bp,sp
;     genReceive
;src/rtc.c:344: check_time(timeptr);
;     genCall
	mov     r2,dpl
	mov     r3,dph
	mov     r4,b
;       Peephole 238.d  removed 3 redundant moves
	push	ar2
	push	ar3
	push	ar4
	lcall	_check_time
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:346: printf_fast((char code*)day[bcd2bin(timeptr->tm_wday)]);
;     genPlus
	mov	a,#0x07
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
;     genCall
;       Peephole 244.c  loading dpl from a instead of r5
	mov	r5,a
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_bcd2bin
	mov	a,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;     genMult
;     genMultOneByte
;     genPlus
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
;       Peephole 186.e  optimized movc sequence (b, dptr differ)
	add	a,acc
	mov     b,a
	mov	dptr,#_day
	jnc	.+3
	inc	dph
	movc    a,@a+dptr
	mov     r5,a
	mov     a,b
	inc	a
	movc    a,@a+dptr
	mov	r6,a
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
	pop	ar4
	pop	ar3
	pop	ar2
;src/rtc.c:350: (unsigned int)timeptr->tm_min);
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r5,a
;     genCast
	mov	r6,#0x00
;src/rtc.c:349: (unsigned int)timeptr->tm_hour, 
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r7,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r0,a
	mov	ar1,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
;     genCast
	mov	r0,#0x00
;src/rtc.c:348: (unsigned int)timeptr->tm_mday, 
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
;     genCast
	mov	r3,#0x00
;src/rtc.c:347: printf_fast("%02u %02u:%02u", 
;     genIpush
	push	ar5
	push	ar6
;     genIpush
	push	ar7
	push	ar0
;     genIpush
	push	ar2
	push	ar3
;     genIpush
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'printf_date'
;------------------------------------------------------------
;timeptr                   Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;src/rtc.c:353: void printf_date(const struct tm *timeptr)
;	-----------------------------------------
;	 function printf_date
;	-----------------------------------------
_printf_date:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;src/rtc.c:358: (unsigned int)timeptr->tm_mday);
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r6,a
	mov	ar7,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r5,a
;     genCast
	mov	r6,#0x00
;src/rtc.c:357: (unsigned int)timeptr->tm_mon,
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r7,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r0,a
	mov	ar1,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
;     genCast
	mov	r0,#0x00
;src/rtc.c:356: (unsigned int)timeptr->tm_year,
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	lcall	__gptrget
	mov	r3,a
;src/rtc.c:355: printf_fast("%04u-%02u-%02u", 
;     genIpush
	push	ar5
	push	ar6
;     genIpush
	push	ar7
	push	ar0
;     genIpush
	push	ar2
	push	ar3
;     genIpush
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'printf_weekday_short'
;------------------------------------------------------------
;timeptr                   Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;src/rtc.c:361: void printf_weekday_short(const struct tm *timeptr)
;	-----------------------------------------
;	 function printf_weekday_short
;	-----------------------------------------
_printf_weekday_short:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;src/rtc.c:363: printf_fast((char code*)day[bcd2bin(timeptr->tm_wday)]);
;     genPlus
	mov	a,#0x07
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
;     genCall
;       Peephole 244.c  loading dpl from a instead of r2
	mov	r2,a
	mov	dpl,a
	lcall	_bcd2bin
	mov	a,dpl
;     genMult
;     genMultOneByte
;     genPlus
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
;       Peephole 186.e  optimized movc sequence (b, dptr differ)
	add	a,acc
	mov     b,a
	mov	dptr,#_day
	jnc	.+3
	inc	dph
	movc    a,@a+dptr
	mov     r2,a
	mov     a,b
	inc	a
	movc    a,@a+dptr
	mov	r3,a
;     genIpush
	push	ar2
	push	ar3
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'printf_day'
;------------------------------------------------------------
;day_number                Allocated to registers 
;------------------------------------------------------------
;src/rtc.c:366: void printf_day(const unsigned char day_number)
;	-----------------------------------------
;	 function printf_day
;	-----------------------------------------
_printf_day:
	push	_bp
	mov	_bp,sp
;     genReceive
;src/rtc.c:368: printf_fast((char code*)day[bcd2bin(day_number)]);
;     genCall
	lcall	_bcd2bin
	mov	a,dpl
;     genMult
;     genMultOneByte
;     genPlus
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
;       Peephole 186.e  optimized movc sequence (b, dptr differ)
	add	a,acc
	mov     b,a
	mov	dptr,#_day
	jnc	.+3
	inc	dph
	movc    a,@a+dptr
	mov     r2,a
	mov     a,b
	inc	a
	movc    a,@a+dptr
	mov	r3,a
;     genIpush
	push	ar2
	push	ar3
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'printf_time'
;------------------------------------------------------------
;timeptr                   Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;src/rtc.c:371: void printf_time(const struct tm *timeptr)
;	-----------------------------------------
;	 function printf_time
;	-----------------------------------------
_printf_time:
	push	_bp
	mov	_bp,sp
;     genReceive
;src/rtc.c:376: (unsigned int)timeptr->tm_sec);
;     genPointerGet
;     genGenPointerGet
	mov     r2,dpl
	mov     r3,dph
	mov     r4,b
;       Peephole 238.d  removed 3 redundant moves
	lcall	__gptrget
	mov	r5,a
;     genCast
	mov	r6,#0x00
;src/rtc.c:375: (unsigned int)timeptr->tm_min,
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r7,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r0,a
	mov	ar1,r4
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
;     genCast
	mov	r0,#0x00
;src/rtc.c:374: (unsigned int)timeptr->tm_hour,
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
;     genCast
	mov	r3,#0x00
;src/rtc.c:373: printf_fast("%02u:%02u:%02u", 
;     genIpush
	push	ar5
	push	ar6
;     genIpush
	push	ar7
	push	ar0
;     genIpush
	push	ar2
	push	ar3
;     genIpush
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ds1302_write_memory'
;------------------------------------------------------------
;number                    Allocated to stack - offset -3
;addr                      Allocated to registers r2 
;address                   Allocated to registers 
;------------------------------------------------------------
;src/rtc.c:407: void ds1302_write_memory(const unsigned char addr, const unsigned char number)
;	-----------------------------------------
;	 function ds1302_write_memory
;	-----------------------------------------
_ds1302_write_memory:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
;src/rtc.c:413: reset_3w();
;     genCall
	push	ar2
	lcall	_reset_3w
	pop	ar2
;src/rtc.c:414: wbyte_3w(RTC_CTRL);
;     genCall
	mov	dpl,#0x8E
	push	ar2
	lcall	_wbyte_3w
	pop	ar2
;src/rtc.c:415: wbyte_3w(0x00);
;     genCall
	mov	dpl,#0x00
	push	ar2
	lcall	_wbyte_3w
	pop	ar2
;src/rtc.c:416: reset_3w();
;     genCall
	push	ar2
	lcall	_reset_3w
	pop	ar2
;src/rtc.c:417: wbyte_3w((address<<1)|0xC0);
;     genLeftShift
;     genLeftShiftLiteral
;     genlshOne
	mov	a,r2
	add	a,acc
	mov	r2,a
;     genOr
	mov	a,#0xC0
	orl	a,r2
	mov	dpl,a
;     genCall
	lcall	_wbyte_3w
;src/rtc.c:418: wbyte_3w(number);
;     genCall
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
	mov	dpl,@r0
	lcall	_wbyte_3w
;src/rtc.c:419: reset_3w();
;     genCall
	lcall	_reset_3w
;src/rtc.c:420: wbyte_3w(RTC_CTRL);
;     genCall
	mov	dpl,#0x8E
	lcall	_wbyte_3w
;src/rtc.c:421: wbyte_3w(0x80);
;     genCall
	mov	dpl,#0x80
	lcall	_wbyte_3w
;src/rtc.c:422: reset_3w();
;     genCall
	lcall	_reset_3w
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ds1302_read_memory'
;------------------------------------------------------------
;addr                      Allocated to registers r2 
;result                    Allocated to registers r2 
;address                   Allocated to registers 
;------------------------------------------------------------
;src/rtc.c:433: unsigned char ds1302_read_memory( const unsigned char addr)
;	-----------------------------------------
;	 function ds1302_read_memory
;	-----------------------------------------
_ds1302_read_memory:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
;src/rtc.c:440: reset_3w();
;     genCall
	push	ar2
	lcall	_reset_3w
	pop	ar2
;src/rtc.c:441: wbyte_3w((address<<1)|0xC1);
;     genLeftShift
;     genLeftShiftLiteral
;     genlshOne
	mov	a,r2
	add	a,acc
	mov	r2,a
;     genOr
	mov	a,#0xC1
	orl	a,r2
	mov	dpl,a
;     genCall
	lcall	_wbyte_3w
;src/rtc.c:442: result = rbyte_3w();
;     genCall
	lcall	_rbyte_3w
	mov	r2,dpl
;     genAssign
;src/rtc.c:443: reset_3w();
;     genCall
	push	ar2
	lcall	_reset_3w
	pop	ar2
;src/rtc.c:444: return result;
;     genRet
	mov	dpl,r2
00101$:
	mov	sp,_bp
	pop	_bp
	ret
	.area CSEG    (CODE)
_month:
	.byte _str_6,(_str_6 >> 8)
	.byte _str_7,(_str_7 >> 8)
	.byte _str_8,(_str_8 >> 8)
	.byte _str_9,(_str_9 >> 8)
	.byte _str_10,(_str_10 >> 8)
	.byte _str_11,(_str_11 >> 8)
	.byte _str_12,(_str_12 >> 8)
	.byte _str_13,(_str_13 >> 8)
	.byte _str_14,(_str_14 >> 8)
	.byte _str_15,(_str_15 >> 8)
	.byte _str_16,(_str_16 >> 8)
	.byte _str_17,(_str_17 >> 8)
_day:
	.byte _str_18,(_str_18 >> 8)
	.byte _str_19,(_str_19 >> 8)
	.byte _str_20,(_str_20 >> 8)
	.byte _str_21,(_str_21 >> 8)
	.byte _str_22,(_str_22 >> 8)
	.byte _str_23,(_str_23 >> 8)
	.byte _str_24,(_str_24 >> 8)
	.byte _str_25,(_str_25 >> 8)
_day_full:
	.byte _str_26,(_str_26 >> 8)
	.byte _str_27,(_str_27 >> 8)
	.byte _str_28,(_str_28 >> 8)
	.byte _str_29,(_str_29 >> 8)
	.byte _str_30,(_str_30 >> 8)
	.byte _str_31,(_str_31 >> 8)
	.byte _str_32,(_str_32 >> 8)
	.byte _str_33,(_str_33 >> 8)
_monthDays:
	.db #0x1F
	.db #0x1C
	.db #0x1F
	.db #0x1E
	.db #0x1F
	.db #0x1E
	.db #0x1F
	.db #0x1F
	.db #0x1E
	.db #0x1F
	.db #0x1E
	.db #0x1F
__str_0:
	.ascii "%04u "
	.db 0x00
__str_1:
	.ascii "%02u %02u:%02u:%02u"
	.db 0x00
__str_2:
	.ascii "   "
	.db 0x00
__str_3:
	.ascii "%02u %02u:%02u"
	.db 0x00
__str_4:
	.ascii "%04u-%02u-%02u"
	.db 0x00
__str_5:
	.ascii "%02u:%02u:%02u"
	.db 0x00
_str_6:
	.ascii "Sty "
	.db 0x00
_str_7:
	.ascii "Lut "
	.db 0x00
_str_8:
	.ascii "Mar "
	.db 0x00
_str_9:
	.ascii "Kwi "
	.db 0x00
_str_10:
	.ascii "Maj "
	.db 0x00
_str_11:
	.ascii "Cze "
	.db 0x00
_str_12:
	.ascii "Lip "
	.db 0x00
_str_13:
	.ascii "Sie "
	.db 0x00
_str_14:
	.ascii "Wrz "
	.db 0x00
_str_15:
	.ascii "Paz "
	.db 0x00
_str_16:
	.ascii "Lis "
	.db 0x00
_str_17:
	.ascii "Gru "
	.db 0x00
_str_18:
	.ascii "Err"
	.db 0x00
_str_19:
	.ascii "Pon "
	.db 0x00
_str_20:
	.ascii "Wto "
	.db 0x00
_str_21:
	.ascii "Sro "
	.db 0x00
_str_22:
	.ascii "Czw "
	.db 0x00
_str_23:
	.ascii "Pia "
	.db 0x00
_str_24:
	.ascii "Sob "
	.db 0x00
_str_25:
	.ascii "Nie "
	.db 0x00
_str_26:
	.ascii "Error       "
	.db 0x00
_str_27:
	.ascii "Poniedzialek "
	.db 0x00
_str_28:
	.ascii "Wtorek      "
	.db 0x00
_str_29:
	.ascii "Sroda       "
	.db 0x00
_str_30:
	.ascii "Czwartek    "
	.db 0x00
_str_31:
	.ascii "Piatek      "
	.db 0x00
_str_32:
	.ascii "Sobota      "
	.db 0x00
_str_33:
	.ascii "Niedziela   "
	.db 0x00
	.area XINIT   (CODE)
