;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.4.0 Thu Feb 10 12:42:27 2011

;--------------------------------------------------------
	.module src/keypad
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _mappingTable
	.globl _read_zone_temp_4
	.globl _read_zone_temp_3
	.globl _read_zone_temp_2
	.globl _read_zone_temp_1
	.globl _find_mapping_code
	.globl _delay_counter
	.globl _blink_counter
	.globl _T2_count
	.globl _T1_count
	.globl _keypad_init
	.globl _keypad_pop_front
	.globl _keypad_check_front
	.globl _keypad_purge_buffer
	.globl _keypad_get_last_code
	.globl _timer0_interrupt
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
_T1_count::
	.ds 2
_T2_count::
	.ds 2
_blink_counter::
	.ds 1
_delay_counter::
	.ds 1
_timer0_interrupt_counter_1_1:
	.ds 1
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
_kb:
	.ds 3
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
;------------------------------------------------------------
;Allocation info for local variables in function 'timer0_interrupt'
;------------------------------------------------------------
;input_value               Allocated to registers r3 
;key_code                  Allocated to registers r4 
;empty                     Allocated to registers r2 
;counter                   Allocated with name '_timer0_interrupt_counter_1_1'
;------------------------------------------------------------
;src/keypad.c:347: static unsigned char counter = 0;
;     genAssign
	mov	_timer0_interrupt_counter_1_1,#0x00
;src/keypad.c:16: unsigned int T1_count=0;
;     genAssign
	clr	a
	mov	(_T1_count + 1),a
	mov	_T1_count,a
;src/keypad.c:17: unsigned int T2_count=0;
;     genAssign
	clr	a
	mov	(_T2_count + 1),a
	mov	_T2_count,a
;src/keypad.c:25: volatile unsigned char blink_counter = 0;
;     genAssign
	mov	_blink_counter,#0x00
;src/keypad.c:26: volatile unsigned char delay_counter = 0;
;     genAssign
	mov	_delay_counter,#0x00
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
;Allocation info for local variables in function 'find_mapping_code'
;------------------------------------------------------------
;scan_code                 Allocated to stack - offset 1
;result                    Allocated to registers r3 
;stop                      Allocated to stack - offset 2
;i                         Allocated to stack - offset 3
;------------------------------------------------------------
;src/keypad.c:54: unsigned char find_mapping_code(const unsigned char scan_code)
;	-----------------------------------------
;	 function find_mapping_code
;	-----------------------------------------
_find_mapping_code:
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
	inc	sp
	inc	sp
	inc	sp
;     genReceive
	push	acc
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	pop	acc
	mov	@r0,dpl
;src/keypad.c:56: unsigned char result = 0;
;     genAssign
	mov	r3,#0x00
;src/keypad.c:57: unsigned char stop = 0;
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,#0x00
;src/keypad.c:60: for (i=0; i<255, stop==0; i++)
;     genAssign
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	@r0,#0x00
00106$:
;     genCmpEq
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	cjne	@r0,#0x00,00117$
	sjmp	00118$
00117$:
	ljmp	00109$
00118$:
;src/keypad.c:62: if ( mappingTable[i].scan == scan_code )
;     genIpush
	push	ar3
;     genMult
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
;     genMultOneByte
	mov	a,@r0
	mov	b,#0x07
	mul	ab
;     genPlus
	add	a,#_mappingTable
	mov	r6,a
	mov	a,b
	addc	a,#(_mappingTable >> 8)
	mov	r7,a
;     genPointerGet
;     genCodePointerGet
	mov	dpl,r6
	mov	dph,r7
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r3,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r4,a
;     genCast
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	ar2,@r0
	mov	r5,#0x00
;     genCmpEq
	mov	a,r3
	cjne	a,ar2,00119$
	mov	a,r4
	cjne	a,ar5,00119$
	mov	a,#0x01
	sjmp	00120$
00119$:
	clr	a
00120$:
;     genIpop
	pop	ar3
;     genIfx
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00102$
00121$:
;src/keypad.c:64: result = mappingTable[i].normalized;
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r6 instead of ar6
	add     a,r6
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r7 instead of ar7
	addc    a,r7
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r4,a
;     genCast
	mov	ar3,r2
;src/keypad.c:65: stop = 1;
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,#0x01
00102$:
;src/keypad.c:68: if ( (mappingTable[i].scan == 0) && 
;     genMult
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
;     genMultOneByte
	mov	a,@r0
	mov	b,#0x07
	mul	ab
;     genPlus
	add	a,#_mappingTable
	mov	r2,a
	mov	a,b
	addc	a,#(_mappingTable >> 8)
	mov	r4,a
;     genPointerGet
;     genCodePointerGet
	mov	dpl,r2
	mov	dph,r4
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r5,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r6,a
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 198    optimized misc jump sequence
	cjne    r5,#0x00,00108$
	cjne    r6,#0x00,00108$
;00122$:
;       Peephole 200    removed redundant sjmp
00123$:
;src/keypad.c:69: (mappingTable[i].normalized == 0) )
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r4,a
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 198    optimized misc jump sequence
	cjne    r2,#0x00,00108$
	cjne    r4,#0x00,00108$
;00124$:
;       Peephole 200    removed redundant sjmp
00125$:
;src/keypad.c:71: stop = 1;
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,#0x01
;src/keypad.c:72: result = SCAN_ERROR;
;     genAssign
	mov	r3,#0x92
00108$:
;src/keypad.c:60: for (i=0; i<255, stop==0; i++)
;     genPlus
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
;     genPlusIncr
	inc	@r0
	ljmp	00106$
00109$:
;src/keypad.c:77: return result;
;     genRet
	mov	dpl,r3
00110$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'keypad_init'
;------------------------------------------------------------
;------------------------------------------------------------
;src/keypad.c:85: void keypad_init (void)
;	-----------------------------------------
;	 function keypad_init
;	-----------------------------------------
_keypad_init:
	push	_bp
	mov	_bp,sp
;src/keypad.c:87: kb.last_code = BUFFER_EMPTY;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_kb
	mov	a,#0x90
	movx	@dptr,a
;src/keypad.c:88: kb.status = BUFFER_EMPTY;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_kb + 0x0001)
	mov	a,#0x90
	movx	@dptr,a
;src/keypad.c:91: ENABLE_T0_INTERRUPT;
;     genAssign
	setb	_ET0
;src/keypad.c:92: KEYPAD_START;
;     genAssign
	setb	_TR0
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'keypad_pop_front'
;------------------------------------------------------------
;------------------------------------------------------------
;src/keypad.c:95: unsigned char keypad_pop_front(void)
;	-----------------------------------------
;	 function keypad_pop_front
;	-----------------------------------------
_keypad_pop_front:
	push	_bp
	mov	_bp,sp
;src/keypad.c:97: return kb.buffer;
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_kb + 0x0002)
	movx	a,@dptr
;     genRet
;       Peephole 244.c  loading dpl from a instead of r2
	mov	r2,a
	mov	dpl,a
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'keypad_check_front'
;------------------------------------------------------------
;------------------------------------------------------------
;src/keypad.c:100: unsigned char keypad_check_front(void)
;	-----------------------------------------
;	 function keypad_check_front
;	-----------------------------------------
_keypad_check_front:
	push	_bp
	mov	_bp,sp
;src/keypad.c:102: return kb.status;
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_kb + 0x0001)
	movx	a,@dptr
;     genRet
;       Peephole 244.c  loading dpl from a instead of r2
	mov	r2,a
	mov	dpl,a
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'keypad_purge_buffer'
;------------------------------------------------------------
;------------------------------------------------------------
;src/keypad.c:105: void keypad_purge_buffer(void)
;	-----------------------------------------
;	 function keypad_purge_buffer
;	-----------------------------------------
_keypad_purge_buffer:
	push	_bp
	mov	_bp,sp
;src/keypad.c:107: kb.status = BUFFER_EMPTY;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_kb + 0x0001)
	mov	a,#0x90
	movx	@dptr,a
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'keypad_get_last_code'
;------------------------------------------------------------
;------------------------------------------------------------
;src/keypad.c:110: unsigned char keypad_get_last_code(void)
;	-----------------------------------------
;	 function keypad_get_last_code
;	-----------------------------------------
_keypad_get_last_code:
	push	_bp
	mov	_bp,sp
;src/keypad.c:112: return kb.last_code;
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_kb
	movx	a,@dptr
;     genRet
;       Peephole 244.c  loading dpl from a instead of r2
	mov	r2,a
	mov	dpl,a
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'read_zone_temp_1'
;------------------------------------------------------------
;result                    Allocated to registers r2 r3 
;------------------------------------------------------------
;src/keypad.c:115: unsigned int read_zone_temp_1()
;	-----------------------------------------
;	 function read_zone_temp_1
;	-----------------------------------------
_read_zone_temp_1:
	push	_bp
	mov	_bp,sp
;src/keypad.c:117: unsigned int result = 0;
;     genAssign
	mov	r2,#0x00
;src/keypad.c:119: T1_count=0;
;     genAssign
;       Peephole 3.b    changed mov to clr
	clr     a
	mov     r3,a
	mov	(_T1_count + 1),a
	mov	_T1_count,a
;src/keypad.c:120: T2_count=0;
;     genAssign
	clr	a
	mov	(_T2_count + 1),a
	mov	_T2_count,a
;src/keypad.c:123: while( SENSOR_ZONE_1 )
00103$:
;     genIfx
;     genIfxJump
;       Peephole 111    removed ljmp by inverse jump logic
	jnb     _P1_4,00108$
00138$:
;src/keypad.c:125: if (++T2_count == 0x8000)
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00139$
	inc	(_T2_count + 1)
00139$:
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00103$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00103$
;00140$:     
;       Peephole 200    removed redundant sjmp
00141$:
;src/keypad.c:126: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
;src/keypad.c:130: while( !SENSOR_ZONE_1 )
00108$:
;     genIfx
;     genIfxJump
;       Peephole 112.a  removed ljmp by inverse jump logic
	jb      _P1_4,00110$
00142$:
;src/keypad.c:132: if (++T2_count == 0x8000)
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00143$
	inc	(_T2_count + 1)
00143$:
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00108$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00108$
;00144$:     
;       Peephole 200    removed redundant sjmp
00145$:
;src/keypad.c:133: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
00110$:
;src/keypad.c:136: T1_count=0;
;     genAssign
	clr	a
	mov	(_T1_count + 1),a
	mov	_T1_count,a
;src/keypad.c:137: T2_count=0;
;     genAssign
	clr	a
	mov	(_T2_count + 1),a
	mov	_T2_count,a
;src/keypad.c:140: while( SENSOR_ZONE_1 )
00113$:
;     genIfx
;     genIfxJump
;       Peephole 111    removed ljmp by inverse jump logic
	jnb     _P1_4,00118$
00146$:
;src/keypad.c:143: T1_count++;
;     genPlus
;     genPlusIncr
	inc	_T1_count
	clr	a
	cjne	a,_T1_count,00147$
	inc	(_T1_count + 1)
00147$:
;src/keypad.c:144: if (T1_count == 0x8000)
;     genCmpEq
	mov	a,_T1_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00113$
	mov     a,(_T1_count + 1)
	cjne    a,#0x80,00113$
;00148$:     
;       Peephole 200    removed redundant sjmp
00149$:
;src/keypad.c:145: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
;src/keypad.c:149: while( !SENSOR_ZONE_1 )
00118$:
;     genIfx
;     genIfxJump
;       Peephole 112.a  removed ljmp by inverse jump logic
	jb      _P1_4,00120$
00150$:
;src/keypad.c:151: T2_count++;
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00151$
	inc	(_T2_count + 1)
00151$:
;src/keypad.c:152: if (T2_count == 0x8000)
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00118$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00118$
;00152$:     
;       Peephole 200    removed redundant sjmp
00153$:
;src/keypad.c:153: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00123$
00120$:
;src/keypad.c:156: if (T2_count != 0)
;     genCmpEq
	mov	a,_T2_count
	jnz	00154$
	mov	a,(_T2_count + 1)
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00122$
00154$:
;src/keypad.c:164: result = (unsigned int)235L-((400L*T1_count)/T2_count);
;     genCast
	mov	r4,_T1_count
	mov	r5,(_T1_count + 1)
	mov	r6,#0x00
	mov	r7,#0x00
;     genAssign
	mov	__mullong_PARM_2,#0x90
	mov	(__mullong_PARM_2 + 1),#0x01
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
;     genCall
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r7
	lcall	__mullong
;     genCast
;     genCall
	mov     r4,dpl
	mov     r5,dph
	mov     r6,b
	mov     r7,a
	mov     __divslong_PARM_2,_T2_count
	mov     (__divslong_PARM_2 + 1),(_T2_count + 1)
	mov     (__divslong_PARM_2 + 2),#0x00
	mov     (__divslong_PARM_2 + 3),#0x00
;       Peephole 238.a  removed 4 redundant moves
	lcall	__divslong
	mov	r4,dpl
	mov	r5,dph
	mov	r6,b
	mov	r7,a
;     genMinus
	mov	a,#0xEB
	clr	c
;       Peephole 236.l  used r4 instead of ar4
	subb    a,r4
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r5 instead of ar5
	subb    a,r5
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r6 instead of ar6
	subb    a,r6
	mov	r6,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r7 instead of ar7
	subb    a,r7
	mov	r7,a
;     genCast
	mov	ar2,r4
	mov	ar3,r5
;src/keypad.c:165: result *= 10;
;     genAssign
	clr	a
	mov	(__mulint_PARM_2 + 1),a
	mov	__mulint_PARM_2,#0x0A
;     genCall
	mov	dpl,r2
	mov	dph,r3
	lcall	__mulint
	mov	r4,dpl
	mov	r5,dph
;     genAssign
	mov	ar2,r4
	mov	ar3,r5
00122$:
;src/keypad.c:168: return result;
;     genRet
	mov	dpl,r2
	mov	dph,r3
00123$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'read_zone_temp_2'
;------------------------------------------------------------
;result                    Allocated to registers r2 r3 
;------------------------------------------------------------
;src/keypad.c:171: unsigned int read_zone_temp_2()
;	-----------------------------------------
;	 function read_zone_temp_2
;	-----------------------------------------
_read_zone_temp_2:
	push	_bp
	mov	_bp,sp
;src/keypad.c:173: unsigned int result = 0;
;     genAssign
	mov	r2,#0x00
;src/keypad.c:175: T1_count=0;
;     genAssign
;       Peephole 3.b    changed mov to clr
	clr     a
	mov     r3,a
	mov	(_T1_count + 1),a
	mov	_T1_count,a
;src/keypad.c:176: T2_count=0;
;     genAssign
	clr	a
	mov	(_T2_count + 1),a
	mov	_T2_count,a
;src/keypad.c:179: while( SENSOR_ZONE_2 )
00103$:
;     genIfx
;     genIfxJump
;       Peephole 111    removed ljmp by inverse jump logic
	jnb     _P1_3,00108$
00138$:
;src/keypad.c:181: if (++T2_count == 0x8000)
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00139$
	inc	(_T2_count + 1)
00139$:
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00103$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00103$
;00140$:     
;       Peephole 200    removed redundant sjmp
00141$:
;src/keypad.c:182: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
;src/keypad.c:186: while( !SENSOR_ZONE_2 )
00108$:
;     genIfx
;     genIfxJump
;       Peephole 112.a  removed ljmp by inverse jump logic
	jb      _P1_3,00110$
00142$:
;src/keypad.c:188: if (++T2_count == 0x8000)
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00143$
	inc	(_T2_count + 1)
00143$:
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00108$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00108$
;00144$:     
;       Peephole 200    removed redundant sjmp
00145$:
;src/keypad.c:189: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
00110$:
;src/keypad.c:192: T1_count=0;
;     genAssign
	clr	a
	mov	(_T1_count + 1),a
	mov	_T1_count,a
;src/keypad.c:193: T2_count=0;
;     genAssign
	clr	a
	mov	(_T2_count + 1),a
	mov	_T2_count,a
;src/keypad.c:196: while( SENSOR_ZONE_2 )
00113$:
;     genIfx
;     genIfxJump
;       Peephole 111    removed ljmp by inverse jump logic
	jnb     _P1_3,00118$
00146$:
;src/keypad.c:199: T1_count++;
;     genPlus
;     genPlusIncr
	inc	_T1_count
	clr	a
	cjne	a,_T1_count,00147$
	inc	(_T1_count + 1)
00147$:
;src/keypad.c:200: if (T1_count == 0x8000)
;     genCmpEq
	mov	a,_T1_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00113$
	mov     a,(_T1_count + 1)
	cjne    a,#0x80,00113$
;00148$:     
;       Peephole 200    removed redundant sjmp
00149$:
;src/keypad.c:201: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
;src/keypad.c:205: while( !SENSOR_ZONE_2 )
00118$:
;     genIfx
;     genIfxJump
;       Peephole 112.a  removed ljmp by inverse jump logic
	jb      _P1_3,00120$
00150$:
;src/keypad.c:207: T2_count++;
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00151$
	inc	(_T2_count + 1)
00151$:
;src/keypad.c:208: if (T2_count == 0x8000)
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00118$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00118$
;00152$:     
;       Peephole 200    removed redundant sjmp
00153$:
;src/keypad.c:209: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00123$
00120$:
;src/keypad.c:212: if (T2_count != 0)
;     genCmpEq
	mov	a,_T2_count
	jnz	00154$
	mov	a,(_T2_count + 1)
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00122$
00154$:
;src/keypad.c:219: result = (unsigned int)235L-((400L*T1_count)/T2_count);
;     genCast
	mov	r4,_T1_count
	mov	r5,(_T1_count + 1)
	mov	r6,#0x00
	mov	r7,#0x00
;     genAssign
	mov	__mullong_PARM_2,#0x90
	mov	(__mullong_PARM_2 + 1),#0x01
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
;     genCall
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r7
	lcall	__mullong
;     genCast
;     genCall
	mov     r4,dpl
	mov     r5,dph
	mov     r6,b
	mov     r7,a
	mov     __divslong_PARM_2,_T2_count
	mov     (__divslong_PARM_2 + 1),(_T2_count + 1)
	mov     (__divslong_PARM_2 + 2),#0x00
	mov     (__divslong_PARM_2 + 3),#0x00
;       Peephole 238.a  removed 4 redundant moves
	lcall	__divslong
	mov	r4,dpl
	mov	r5,dph
	mov	r6,b
	mov	r7,a
;     genMinus
	mov	a,#0xEB
	clr	c
;       Peephole 236.l  used r4 instead of ar4
	subb    a,r4
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r5 instead of ar5
	subb    a,r5
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r6 instead of ar6
	subb    a,r6
	mov	r6,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r7 instead of ar7
	subb    a,r7
	mov	r7,a
;     genCast
	mov	ar2,r4
	mov	ar3,r5
;src/keypad.c:220: result *= 10;
;     genAssign
	clr	a
	mov	(__mulint_PARM_2 + 1),a
	mov	__mulint_PARM_2,#0x0A
;     genCall
	mov	dpl,r2
	mov	dph,r3
	lcall	__mulint
	mov	r4,dpl
	mov	r5,dph
;     genAssign
	mov	ar2,r4
	mov	ar3,r5
00122$:
;src/keypad.c:224: return result;
;     genRet
	mov	dpl,r2
	mov	dph,r3
00123$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'read_zone_temp_3'
;------------------------------------------------------------
;result                    Allocated to registers r2 r3 
;------------------------------------------------------------
;src/keypad.c:226: unsigned int read_zone_temp_3()
;	-----------------------------------------
;	 function read_zone_temp_3
;	-----------------------------------------
_read_zone_temp_3:
	push	_bp
	mov	_bp,sp
;src/keypad.c:228: unsigned int result = 0;
;     genAssign
	mov	r2,#0x00
;src/keypad.c:230: T1_count=0;
;     genAssign
;       Peephole 3.b    changed mov to clr
	clr     a
	mov     r3,a
	mov	(_T1_count + 1),a
	mov	_T1_count,a
;src/keypad.c:231: T2_count=0;
;     genAssign
	clr	a
	mov	(_T2_count + 1),a
	mov	_T2_count,a
;src/keypad.c:234: while( SENSOR_ZONE_3 )
00103$:
;     genIfx
;     genIfxJump
;       Peephole 111    removed ljmp by inverse jump logic
	jnb     _P1_2,00108$
00138$:
;src/keypad.c:236: if (++T2_count == 0x8000)
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00139$
	inc	(_T2_count + 1)
00139$:
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00103$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00103$
;00140$:     
;       Peephole 200    removed redundant sjmp
00141$:
;src/keypad.c:237: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
;src/keypad.c:241: while( !SENSOR_ZONE_3 )
00108$:
;     genIfx
;     genIfxJump
;       Peephole 112.a  removed ljmp by inverse jump logic
	jb      _P1_2,00110$
00142$:
;src/keypad.c:243: if (++T2_count == 0x8000)
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00143$
	inc	(_T2_count + 1)
00143$:
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00108$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00108$
;00144$:     
;       Peephole 200    removed redundant sjmp
00145$:
;src/keypad.c:244: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
00110$:
;src/keypad.c:247: T1_count=0;
;     genAssign
	clr	a
	mov	(_T1_count + 1),a
	mov	_T1_count,a
;src/keypad.c:248: T2_count=0;
;     genAssign
	clr	a
	mov	(_T2_count + 1),a
	mov	_T2_count,a
;src/keypad.c:251: while( SENSOR_ZONE_3 )
00113$:
;     genIfx
;     genIfxJump
;       Peephole 111    removed ljmp by inverse jump logic
	jnb     _P1_2,00118$
00146$:
;src/keypad.c:254: T1_count++;
;     genPlus
;     genPlusIncr
	inc	_T1_count
	clr	a
	cjne	a,_T1_count,00147$
	inc	(_T1_count + 1)
00147$:
;src/keypad.c:255: if (T1_count == 0x8000)
;     genCmpEq
	mov	a,_T1_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00113$
	mov     a,(_T1_count + 1)
	cjne    a,#0x80,00113$
;00148$:     
;       Peephole 200    removed redundant sjmp
00149$:
;src/keypad.c:256: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
;src/keypad.c:260: while( !SENSOR_ZONE_3 )
00118$:
;     genIfx
;     genIfxJump
;       Peephole 112.a  removed ljmp by inverse jump logic
	jb      _P1_2,00120$
00150$:
;src/keypad.c:262: T2_count++;
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00151$
	inc	(_T2_count + 1)
00151$:
;src/keypad.c:263: if (T2_count == 0x8000)
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00118$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00118$
;00152$:     
;       Peephole 200    removed redundant sjmp
00153$:
;src/keypad.c:264: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00123$
00120$:
;src/keypad.c:267: if (T2_count != 0)
;     genCmpEq
	mov	a,_T2_count
	jnz	00154$
	mov	a,(_T2_count + 1)
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00122$
00154$:
;src/keypad.c:274: result = (unsigned int)235L-((400L*T1_count)/T2_count);
;     genCast
	mov	r4,_T1_count
	mov	r5,(_T1_count + 1)
	mov	r6,#0x00
	mov	r7,#0x00
;     genAssign
	mov	__mullong_PARM_2,#0x90
	mov	(__mullong_PARM_2 + 1),#0x01
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
;     genCall
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r7
	lcall	__mullong
;     genCast
;     genCall
	mov     r4,dpl
	mov     r5,dph
	mov     r6,b
	mov     r7,a
	mov     __divslong_PARM_2,_T2_count
	mov     (__divslong_PARM_2 + 1),(_T2_count + 1)
	mov     (__divslong_PARM_2 + 2),#0x00
	mov     (__divslong_PARM_2 + 3),#0x00
;       Peephole 238.a  removed 4 redundant moves
	lcall	__divslong
	mov	r4,dpl
	mov	r5,dph
	mov	r6,b
	mov	r7,a
;     genMinus
	mov	a,#0xEB
	clr	c
;       Peephole 236.l  used r4 instead of ar4
	subb    a,r4
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r5 instead of ar5
	subb    a,r5
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r6 instead of ar6
	subb    a,r6
	mov	r6,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r7 instead of ar7
	subb    a,r7
	mov	r7,a
;     genCast
	mov	ar2,r4
	mov	ar3,r5
;src/keypad.c:275: result *= 10;
;     genAssign
	clr	a
	mov	(__mulint_PARM_2 + 1),a
	mov	__mulint_PARM_2,#0x0A
;     genCall
	mov	dpl,r2
	mov	dph,r3
	lcall	__mulint
	mov	r4,dpl
	mov	r5,dph
;     genAssign
	mov	ar2,r4
	mov	ar3,r5
00122$:
;src/keypad.c:279: return result;
;     genRet
	mov	dpl,r2
	mov	dph,r3
00123$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'read_zone_temp_4'
;------------------------------------------------------------
;result                    Allocated to registers r2 r3 
;------------------------------------------------------------
;src/keypad.c:281: unsigned int read_zone_temp_4()
;	-----------------------------------------
;	 function read_zone_temp_4
;	-----------------------------------------
_read_zone_temp_4:
	push	_bp
	mov	_bp,sp
;src/keypad.c:283: unsigned int result = 0;
;     genAssign
	mov	r2,#0x00
;src/keypad.c:285: T1_count=0;
;     genAssign
;       Peephole 3.b    changed mov to clr
	clr     a
	mov     r3,a
	mov	(_T1_count + 1),a
	mov	_T1_count,a
;src/keypad.c:286: T2_count=0;
;     genAssign
	clr	a
	mov	(_T2_count + 1),a
	mov	_T2_count,a
;src/keypad.c:289: while( SENSOR_ZONE_4 )
00103$:
;     genIfx
;     genIfxJump
;       Peephole 111    removed ljmp by inverse jump logic
	jnb     _P0_0,00108$
00138$:
;src/keypad.c:291: if (++T2_count == 0x8000)
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00139$
	inc	(_T2_count + 1)
00139$:
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00103$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00103$
;00140$:     
;       Peephole 200    removed redundant sjmp
00141$:
;src/keypad.c:292: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
;src/keypad.c:296: while( !SENSOR_ZONE_4 )
00108$:
;     genIfx
;     genIfxJump
;       Peephole 112.a  removed ljmp by inverse jump logic
	jb      _P0_0,00110$
00142$:
;src/keypad.c:298: if (++T2_count == 0x8000)
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00143$
	inc	(_T2_count + 1)
00143$:
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00108$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00108$
;00144$:     
;       Peephole 200    removed redundant sjmp
00145$:
;src/keypad.c:299: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
00110$:
;src/keypad.c:302: T1_count=0;
;     genAssign
	clr	a
	mov	(_T1_count + 1),a
	mov	_T1_count,a
;src/keypad.c:303: T2_count=0;
;     genAssign
	clr	a
	mov	(_T2_count + 1),a
	mov	_T2_count,a
;src/keypad.c:306: while( SENSOR_ZONE_4 )
00113$:
;     genIfx
;     genIfxJump
;       Peephole 111    removed ljmp by inverse jump logic
	jnb     _P0_0,00118$
00146$:
;src/keypad.c:309: T1_count++;
;     genPlus
;     genPlusIncr
	inc	_T1_count
	clr	a
	cjne	a,_T1_count,00147$
	inc	(_T1_count + 1)
00147$:
;src/keypad.c:310: if (T1_count == 0x8000)
;     genCmpEq
	mov	a,_T1_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00113$
	mov     a,(_T1_count + 1)
	cjne    a,#0x80,00113$
;00148$:     
;       Peephole 200    removed redundant sjmp
00149$:
;src/keypad.c:311: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
	ljmp	00123$
;src/keypad.c:315: while( !SENSOR_ZONE_4 )
00118$:
;     genIfx
;     genIfxJump
;       Peephole 112.a  removed ljmp by inverse jump logic
	jb      _P0_0,00120$
00150$:
;src/keypad.c:317: T2_count++;
;     genPlus
;     genPlusIncr
	inc	_T2_count
	clr	a
	cjne	a,_T2_count,00151$
	inc	(_T2_count + 1)
00151$:
;src/keypad.c:318: if (T2_count == 0x8000)
;     genCmpEq
	mov	a,_T2_count
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.a  optimized misc jump sequence
	jnz     00118$
	mov     a,(_T2_count + 1)
	cjne    a,#0x80,00118$
;00152$:     
;       Peephole 200    removed redundant sjmp
00153$:
;src/keypad.c:319: return 0;
;     genRet
;       Peephole 182.b  used 16 bit load of dptr
	mov     dptr,#0x0000
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00123$
00120$:
;src/keypad.c:322: if (T2_count != 0)
;     genCmpEq
	mov	a,_T2_count
	jnz	00154$
	mov	a,(_T2_count + 1)
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00122$
00154$:
;src/keypad.c:329: result = (unsigned int)235L-((400L*T1_count)/T2_count);
;     genCast
	mov	r4,_T1_count
	mov	r5,(_T1_count + 1)
	mov	r6,#0x00
	mov	r7,#0x00
;     genAssign
	mov	__mullong_PARM_2,#0x90
	mov	(__mullong_PARM_2 + 1),#0x01
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
;     genCall
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r7
	lcall	__mullong
;     genCast
;     genCall
	mov     r4,dpl
	mov     r5,dph
	mov     r6,b
	mov     r7,a
	mov     __divslong_PARM_2,_T2_count
	mov     (__divslong_PARM_2 + 1),(_T2_count + 1)
	mov     (__divslong_PARM_2 + 2),#0x00
	mov     (__divslong_PARM_2 + 3),#0x00
;       Peephole 238.a  removed 4 redundant moves
	lcall	__divslong
	mov	r4,dpl
	mov	r5,dph
	mov	r6,b
	mov	r7,a
;     genMinus
	mov	a,#0xEB
	clr	c
;       Peephole 236.l  used r4 instead of ar4
	subb    a,r4
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r5 instead of ar5
	subb    a,r5
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r6 instead of ar6
	subb    a,r6
	mov	r6,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.l  used r7 instead of ar7
	subb    a,r7
	mov	r7,a
;     genCast
	mov	ar2,r4
	mov	ar3,r5
;src/keypad.c:330: result *= 10;
;     genAssign
	clr	a
	mov	(__mulint_PARM_2 + 1),a
	mov	__mulint_PARM_2,#0x0A
;     genCall
	mov	dpl,r2
	mov	dph,r3
	lcall	__mulint
	mov	r4,dpl
	mov	r5,dph
;     genAssign
	mov	ar2,r4
	mov	ar3,r5
00122$:
;src/keypad.c:334: return result;
;     genRet
	mov	dpl,r2
	mov	dph,r3
00123$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'timer0_interrupt'
;------------------------------------------------------------
;input_value               Allocated to registers r3 
;key_code                  Allocated to registers r4 
;empty                     Allocated to registers r2 
;counter                   Allocated with name '_timer0_interrupt_counter_1_1'
;------------------------------------------------------------
;src/keypad.c:345: void timer0_interrupt(void) interrupt TF0_VECTOR using 0
;	-----------------------------------------
;	 function timer0_interrupt
;	-----------------------------------------
_timer0_interrupt:
	push	acc
	push	b
	push	dpl
	push	dph
	push	(0+2)
	push	(0+3)
	push	(0+4)
	push	(0+5)
	push	(0+6)
	push	(0+7)
	push	(0+0)
	push	(0+1)
	push	psw
	mov	psw,#0x00
	push	_bp
	mov	_bp,sp
;src/keypad.c:353: delay_counter++;
;     genPlus
;     genPlusIncr
	inc	_delay_counter
;src/keypad.c:354: if (delay_counter == 64)
;     genCmpEq
	mov	a,_delay_counter
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,#0x40,00102$
;00172$:
;       Peephole 200    removed redundant sjmp
00173$:
;src/keypad.c:356: system_data.temperatures[0] = read_zone_temp_1();
;     genCall
	lcall	_read_zone_temp_1
	mov	r2,dpl
	mov	r3,dph
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_data + 0x016c)
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
00102$:
;src/keypad.c:358: if (delay_counter == 128)
;     genCmpEq
	mov	a,_delay_counter
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,#0x80,00104$
;00174$:
;       Peephole 200    removed redundant sjmp
00175$:
;src/keypad.c:360: system_data.temperatures[1] = read_zone_temp_2();
;     genCall
	lcall	_read_zone_temp_2
	mov	r2,dpl
	mov	r3,dph
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_data + 0x016e)
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
00104$:
;src/keypad.c:362: if (delay_counter == 192)
;     genCmpEq
	mov	a,_delay_counter
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,#0xC0,00106$
;00176$:
;       Peephole 200    removed redundant sjmp
00177$:
;src/keypad.c:364: system_data.temperatures[2] = read_zone_temp_3();
;     genCall
	lcall	_read_zone_temp_3
	mov	r2,dpl
	mov	r3,dph
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_data + 0x0170)
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
00106$:
;src/keypad.c:366: if (delay_counter == 255)
;     genCmpEq
	mov	a,_delay_counter
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,#0xFF,00108$
;00178$:
;       Peephole 200    removed redundant sjmp
00179$:
;src/keypad.c:368: system_data.temperatures[3] = read_zone_temp_4();
;     genCall
	lcall	_read_zone_temp_4
	mov	r2,dpl
	mov	r3,dph
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_data + 0x0172)
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
00108$:
;src/keypad.c:371: if (blinking == TRUE)
;     genCmpEq
	mov	a,_blinking
	cjne	a,#0x01,00180$
	sjmp	00181$
00180$:
	ljmp	00118$
00181$:
;src/keypad.c:373: blink_counter++;
;     genPlus
;     genPlusIncr
	inc	_blink_counter
;src/keypad.c:374: if (blink_counter == 30)
;     genCmpEq
	mov	a,_blink_counter
	cjne	a,#0x1E,00182$
	sjmp	00183$
00182$:
	ljmp	00112$
00183$:
;src/keypad.c:376: lcd_goto_xy(current_blink_params->position, 0);
;     genAssign
	mov	r2,_current_blink_params
	mov	r3,(_current_blink_params + 1)
	mov	r4,(_current_blink_params + 2)
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,r2
	lcall	_lcd_goto_xy
	dec	sp
;src/keypad.c:377: lcd_put_string(current_blink_params->first_pattern_off);
;     genAssign
	mov	r2,_current_blink_params
	mov	r3,(_current_blink_params + 1)
	mov	r4,(_current_blink_params + 2)
;     genPlus
;     genPlusIncr
	mov	a,#0x04
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
	inc	dptr
	lcall	__gptrget
	mov	r4,a
;     genCall
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_lcd_put_string
;src/keypad.c:379: if (current_blink_params->lines > 1)
;     genAssign
	mov	r2,_current_blink_params
	mov	r3,(_current_blink_params + 1)
	mov	r4,(_current_blink_params + 2)
;     genPlus
	mov	a,#0x0D
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
;     genCmpGt
;     genCmp
	clr	c
;       Peephole 159    avoided xrl during execution
	mov  a,#(0x01 ^ 0x80)
	mov	b,r2
	xrl	b,#0x80
	subb	a,b
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00112$
00184$:
;src/keypad.c:381: lcd_goto_xy(current_blink_params->position, 2);
;     genAssign
	mov	r2,_current_blink_params
	mov	r3,(_current_blink_params + 1)
	mov	r4,(_current_blink_params + 2)
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
;     genIpush
	mov	a,#0x02
	push	acc
;     genCall
	mov	dpl,r2
	lcall	_lcd_goto_xy
	dec	sp
;src/keypad.c:382: lcd_put_string(current_blink_params->second_pattern_off);
;     genAssign
	mov	r2,_current_blink_params
	mov	r3,(_current_blink_params + 1)
	mov	r4,(_current_blink_params + 2)
;     genPlus
	mov	a,#0x0A
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
	inc	dptr
	lcall	__gptrget
	mov	r4,a
;     genCall
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_lcd_put_string
00112$:
;src/keypad.c:385: if (blink_counter == 60)
;     genCmpEq
	mov	a,_blink_counter
	cjne	a,#0x3C,00185$
	sjmp	00186$
00185$:
	ljmp	00118$
00186$:
;src/keypad.c:387: lcd_goto_xy(current_blink_params->position, 0);
;     genAssign
	mov	r2,_current_blink_params
	mov	r3,(_current_blink_params + 1)
	mov	r4,(_current_blink_params + 2)
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,r2
	lcall	_lcd_goto_xy
	dec	sp
;src/keypad.c:388: lcd_put_string(current_blink_params->first_pattern_on);
;     genAssign
	mov	r2,_current_blink_params
	mov	r3,(_current_blink_params + 1)
	mov	r4,(_current_blink_params + 2)
;     genPlus
;     genPlusIncr
	inc	r2
	cjne	r2,#0x00,00187$
	inc	r3
00187$:
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
	inc	dptr
	lcall	__gptrget
	mov	r4,a
;     genCall
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_lcd_put_string
;src/keypad.c:390: if (current_blink_params->lines > 1)
;     genAssign
	mov	r2,_current_blink_params
	mov	r3,(_current_blink_params + 1)
	mov	r4,(_current_blink_params + 2)
;     genPlus
	mov	a,#0x0D
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
;     genCmpGt
;     genCmp
	clr	c
;       Peephole 159    avoided xrl during execution
	mov  a,#(0x01 ^ 0x80)
	mov	b,r2
	xrl	b,#0x80
	subb	a,b
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00114$
00188$:
;src/keypad.c:392: lcd_goto_xy(current_blink_params->position, 1);
;     genAssign
	mov	r2,_current_blink_params
	mov	r3,(_current_blink_params + 1)
	mov	r4,(_current_blink_params + 2)
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
;     genIpush
	mov	a,#0x01
	push	acc
;     genCall
	mov	dpl,r2
	lcall	_lcd_goto_xy
	dec	sp
;src/keypad.c:393: lcd_put_string(current_blink_params->second_pattern_on);
;     genAssign
	mov	r2,_current_blink_params
	mov	r3,(_current_blink_params + 1)
	mov	r4,(_current_blink_params + 2)
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
	mov	r2,a
	inc	dptr
	lcall	__gptrget
	mov	r3,a
	inc	dptr
	lcall	__gptrget
	mov	r4,a
;     genCall
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_lcd_put_string
00114$:
;src/keypad.c:396: blink_counter = 0;
;     genAssign
	mov	_blink_counter,#0x00
00118$:
;src/keypad.c:400: if (counter++ >= 5)
;     genAssign
	mov	r2,_timer0_interrupt_counter_1_1
;     genPlus
;     genPlusIncr
	inc	_timer0_interrupt_counter_1_1
;     genCmpLt
;     genCmp
	cjne	r2,#0x05,00189$
00189$:
;     genIfxJump
	jnc	00190$
	ljmp	00147$
00190$:
;src/keypad.c:402: counter = 0;
;     genAssign
	mov	_timer0_interrupt_counter_1_1,#0x00
;src/keypad.c:403: empty = 0;
;     genAssign
	mov	r2,#0x00
;src/keypad.c:426: KSC1 = 0;
;     genAssign
	clr	_P0_5
;src/keypad.c:427: input_value = (KEYBOARD_PORT >> 1) & 0xF;
;     genRightShift
;     genRightShiftLiteral
;     genrshOne
	mov	a,_P0
	clr	c
	rrc	a
	mov	r3,a
;     genAnd
	anl	ar3,#0x0F
;src/keypad.c:428: if ( input_value != 0x0F ) 
;     genCmpEq
	cjne	r3,#0x0F,00191$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00124$
00191$:
;src/keypad.c:430: empty++;
;     genAssign
	mov	r2,#0x01
;src/keypad.c:431: input_value |= 0x10;
;     genOr
	orl	ar3,#0x10
;src/keypad.c:432: key_code = find_mapping_code(input_value);
;     genCall
	mov	dpl,r3
	push	ar2
	lcall	_find_mapping_code
	mov	r4,dpl
	pop	ar2
;     genAssign
;src/keypad.c:434: if (key_code != SCAN_ERROR)
;     genCmpEq
	cjne	r4,#0x92,00192$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00124$
00192$:
;src/keypad.c:436: if (key_code != kb.last_code)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_kb
	movx	a,@dptr
	mov	r5,a
;     genCmpEq
	mov	a,r4
	cjne	a,ar5,00193$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00124$
00193$:
;src/keypad.c:438: kb.buffer = key_code;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_kb + 0x0002)
	mov	a,r4
	movx	@dptr,a
;src/keypad.c:439: kb.last_code = key_code;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_kb
	mov	a,r4
	movx	@dptr,a
;src/keypad.c:440: kb.status = DATA_AVAILABLE;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_kb + 0x0001)
	mov	a,#0x91
	movx	@dptr,a
00124$:
;src/keypad.c:445: KSC1 = 1;
;     genAssign
	setb	_P0_5
;src/keypad.c:447: KSC2 = 0;
;     genAssign
	clr	_P0_6
;src/keypad.c:448: input_value = (KEYBOARD_PORT >> 1) & 0xF;
;     genRightShift
;     genRightShiftLiteral
;     genrshOne
	mov	a,_P0
	clr	c
	rrc	a
	mov	r5,a
;     genAnd
	mov	a,#0x0F
	anl	a,r5
	mov	r3,a
;src/keypad.c:449: if ( input_value != 0x0F ) 
;     genCmpEq
	cjne	r3,#0x0F,00194$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00130$
00194$:
;src/keypad.c:451: empty++;
;     genPlus
;     genPlusIncr
	inc	r2
;src/keypad.c:453: input_value |= 0x20;
;     genOr
	orl	ar3,#0x20
;src/keypad.c:454: key_code = find_mapping_code(input_value);
;     genCall
	mov	dpl,r3
	push	ar2
	lcall	_find_mapping_code
	mov	r5,dpl
	pop	ar2
;     genAssign
	mov	ar4,r5
;src/keypad.c:456: if (key_code != SCAN_ERROR)
;     genCmpEq
	cjne	r4,#0x92,00195$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00130$
00195$:
;src/keypad.c:458: if (key_code != kb.last_code)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_kb
	movx	a,@dptr
	mov	r5,a
;     genCmpEq
	mov	a,r4
	cjne	a,ar5,00196$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00130$
00196$:
;src/keypad.c:460: kb.buffer = key_code;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_kb + 0x0002)
	mov	a,r4
	movx	@dptr,a
;src/keypad.c:461: kb.last_code = key_code;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_kb
	mov	a,r4
	movx	@dptr,a
;src/keypad.c:462: kb.status = DATA_AVAILABLE;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_kb + 0x0001)
	mov	a,#0x91
	movx	@dptr,a
00130$:
;src/keypad.c:467: KSC2 = 1;
;     genAssign
	setb	_P0_6
;src/keypad.c:469: KSC3 = 0;
;     genAssign
	clr	_P0_7
;src/keypad.c:470: input_value = (KEYBOARD_PORT >> 1) & 0xF;
;     genRightShift
;     genRightShiftLiteral
;     genrshOne
	mov	a,_P0
	clr	c
	rrc	a
	mov	r5,a
;     genAnd
	mov	a,#0x0F
	anl	a,r5
	mov	r3,a
;src/keypad.c:471: if ( input_value != 0x0F ) 
;     genCmpEq
	cjne	r3,#0x0F,00197$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00136$
00197$:
;src/keypad.c:473: empty++;
;     genPlus
;     genPlusIncr
	inc	r2
;src/keypad.c:475: input_value |= 0x30;
;     genOr
	orl	ar3,#0x30
;src/keypad.c:476: key_code = find_mapping_code(input_value);
;     genCall
	mov	dpl,r3
	push	ar2
	lcall	_find_mapping_code
	mov	r5,dpl
	pop	ar2
;     genAssign
	mov	ar4,r5
;src/keypad.c:478: if (key_code != SCAN_ERROR)
;     genCmpEq
	cjne	r4,#0x92,00198$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00136$
00198$:
;src/keypad.c:480: if (key_code != kb.last_code)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_kb
	movx	a,@dptr
	mov	r5,a
;     genCmpEq
	mov	a,r4
	cjne	a,ar5,00199$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00136$
00199$:
;src/keypad.c:482: kb.buffer = key_code;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_kb + 0x0002)
	mov	a,r4
	movx	@dptr,a
;src/keypad.c:483: kb.last_code = key_code;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_kb
	mov	a,r4
	movx	@dptr,a
;src/keypad.c:484: kb.status = DATA_AVAILABLE;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_kb + 0x0001)
	mov	a,#0x91
	movx	@dptr,a
00136$:
;src/keypad.c:489: KSC3 = 1;
;     genAssign
	setb	_P0_7
;src/keypad.c:491: KSC4 = 0;
;     genAssign
	clr	_P3_7
;src/keypad.c:492: input_value = (KEYBOARD_PORT >> 1) & 0xF;
;     genRightShift
;     genRightShiftLiteral
;     genrshOne
	mov	a,_P0
	clr	c
	rrc	a
	mov	r5,a
;     genAnd
	mov	a,#0x0F
	anl	a,r5
	mov	r3,a
;src/keypad.c:493: if ( input_value != 0x0F ) 
;     genCmpEq
	cjne	r3,#0x0F,00200$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00142$
00200$:
;src/keypad.c:495: empty++;
;     genPlus
;     genPlusIncr
	inc	r2
;src/keypad.c:497: input_value |= 0x40;
;     genOr
	orl	ar3,#0x40
;src/keypad.c:498: key_code = find_mapping_code(input_value);
;     genCall
	mov	dpl,r3
	push	ar2
	lcall	_find_mapping_code
	mov	r3,dpl
	pop	ar2
;     genAssign
	mov	ar4,r3
;src/keypad.c:500: if (key_code != SCAN_ERROR)
;     genCmpEq
	cjne	r4,#0x92,00201$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00142$
00201$:
;src/keypad.c:502: if (key_code != kb.last_code)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_kb
	movx	a,@dptr
	mov	r3,a
;     genCmpEq
	mov	a,r4
	cjne	a,ar3,00202$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00142$
00202$:
;src/keypad.c:504: kb.buffer = key_code;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_kb + 0x0002)
	mov	a,r4
	movx	@dptr,a
;src/keypad.c:505: kb.last_code = key_code;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_kb
	mov	a,r4
	movx	@dptr,a
;src/keypad.c:506: kb.status = DATA_AVAILABLE;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_kb + 0x0001)
	mov	a,#0x91
	movx	@dptr,a
00142$:
;src/keypad.c:511: KSC4 = 1;
;     genAssign
	setb	_P3_7
;src/keypad.c:513: if (empty == 0)
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    r2,#0x00,00147$
;00203$:
;       Peephole 200    removed redundant sjmp
00204$:
;src/keypad.c:515: kb.last_code = BUFFER_EMPTY;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_kb
	mov	a,#0x90
	movx	@dptr,a
00147$:
	mov	sp,_bp
	pop	_bp
	pop	psw
	pop	(0+1)
	pop	(0+0)
	pop	(0+7)
	pop	(0+6)
	pop	(0+5)
	pop	(0+4)
	pop	(0+3)
	pop	(0+2)
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	reti
	.area CSEG    (CODE)
_mappingTable:
	.byte #0x3E,#0x00
	.byte #0x00,#0x00
	.byte _str_0,(_str_0 >> 8),#0x02
	.byte #0x47,#0x00
	.byte #0x01,#0x00
	.byte _str_1,(_str_1 >> 8),#0x02
	.byte #0x37,#0x00
	.byte #0x02,#0x00
	.byte _str_2,(_str_2 >> 8),#0x02
	.byte #0x27,#0x00
	.byte #0x03,#0x00
	.byte _str_3,(_str_3 >> 8),#0x02
	.byte #0x4B,#0x00
	.byte #0x04,#0x00
	.byte _str_4,(_str_4 >> 8),#0x02
	.byte #0x3B,#0x00
	.byte #0x05,#0x00
	.byte _str_5,(_str_5 >> 8),#0x02
	.byte #0x2B,#0x00
	.byte #0x06,#0x00
	.byte _str_6,(_str_6 >> 8),#0x02
	.byte #0x4D,#0x00
	.byte #0x07,#0x00
	.byte _str_7,(_str_7 >> 8),#0x02
	.byte #0x3D,#0x00
	.byte #0x08,#0x00
	.byte _str_8,(_str_8 >> 8),#0x02
	.byte #0x2D,#0x00
	.byte #0x09,#0x00
	.byte _str_9,(_str_9 >> 8),#0x02
	.byte #0x17,#0x00
	.byte #0x10,#0x00
	.byte _str_10,(_str_10 >> 8),#0x02
	.byte #0x1B,#0x00
	.byte #0x11,#0x00
	.byte _str_11,(_str_11 >> 8),#0x02
	.byte #0x4E,#0x00
	.byte #0x15,#0x00
	.byte _str_12,(_str_12 >> 8),#0x02
	.byte #0x2E,#0x00
	.byte #0x16,#0x00
	.byte _str_13,(_str_13 >> 8),#0x02
	.byte #0x1E,#0x00
	.byte #0x13,#0x00
	.byte _str_14,(_str_14 >> 8),#0x02
	.byte #0x1D,#0x00
	.byte #0x14,#0x00
	.byte _str_15,(_str_15 >> 8),#0x02
	.byte #0x00,#0x00
	.byte #0x00,#0x00
_str_0:
	.ascii "0"
	.db 0x00
_str_1:
	.ascii "1"
	.db 0x00
_str_2:
	.ascii "2"
	.db 0x00
_str_3:
	.ascii "3"
	.db 0x00
_str_4:
	.ascii "4"
	.db 0x00
_str_5:
	.ascii "5"
	.db 0x00
_str_6:
	.ascii "6"
	.db 0x00
_str_7:
	.ascii "7"
	.db 0x00
_str_8:
	.ascii "8"
	.db 0x00
_str_9:
	.ascii "9"
	.db 0x00
_str_10:
	.ascii "LEFT"
	.db 0x00
_str_11:
	.ascii "RIGHT"
	.db 0x00
_str_12:
	.ascii "*"
	.db 0x00
_str_13:
	.ascii "#"
	.db 0x00
_str_14:
	.ascii "CLEAR"
	.db 0x00
_str_15:
	.ascii "ENTER"
	.db 0x00
	.area XINIT   (CODE)
