;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.4.0 Thu Feb 10 12:42:24 2011

;--------------------------------------------------------
	.module src/menu
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _menu
	.globl _dpl
	.globl _bpr
	.globl _minmax
	.globl _dfp
	.globl _zone_day_map
	.globl _battery_test
	.globl _workloop
	.globl _date_workloop
	.globl _time_workloop
	.globl _zone_workloop
	.globl _read_keyboard_data_workloop
	.globl _weekday_worklop
	.globl _keypad_test_workloop
	.globl _reset_workloop
	.globl _check_external_events
	.globl _control_workloop
	.globl _is_day_matching
	.globl _display_enabled_channels
	.globl _switch_zone_prepare
	.globl _switch_zone
	.globl _display_stored_data
	.globl _display_stored_time
	.globl _display_zone_setings
	.globl _set_new_blink
	.globl _stack_purge
	.globl _stack_pop_front
	.globl _stack_push_back
	.globl _update_flash
	.globl _battery_counter
	.globl _system_time
	.globl _system_data
	.globl _stack
	.globl _ZONE_4_PREPARED
	.globl _ZONE_3_PREPARED
	.globl _ZONE_2_PREPARED
	.globl _ZONE_1_PREPARED
	.globl _temp_long
	.globl _enter_workloop
	.globl _key_code
	.globl _current_position
	.globl _current_display_state
	.globl _blinking
	.globl _current_blink_params
	.globl _flash_init
	.globl _menu_previous_position
	.globl _clear_zones
	.globl _main_program_workloop
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
_current_blink_params::
	.ds 3
_blinking::
	.ds 1
_current_display_state::
	.ds 1
_current_position::
	.ds 1
_key_code::
	.ds 1
_enter_workloop::
	.ds 1
_temp_long::
	.ds 4
_ZONE_1_PREPARED::
	.ds 1
_ZONE_2_PREPARED::
	.ds 1
_ZONE_3_PREPARED::
	.ds 1
_ZONE_4_PREPARED::
	.ds 1
_display_stored_time_sec_1_1:
	.ds 1
_display_stored_data_sec_1_1:
	.ds 1
_display_enabled_channels_sec_1_1:
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
_stack::
	.ds 10
_system_data::
	.ds 372
_system_time::
	.ds 12
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
_battery_counter::
	.ds 2
_update_flash::
	.ds 1
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;src/menu.c:30: volatile Blink_params * current_blink_params = NULL;
;     genAssign
	clr	a
	mov	(_current_blink_params + 2),a
	mov	(_current_blink_params + 1),a
	mov	_current_blink_params,a
;src/menu.c:31: volatile BOOL blinking = TRUE;
;     genAssign
	mov	_blinking,#0x01
;src/menu.c:32: unsigned char current_display_state = MAIN_STATE_ID;
;     genAssign
	mov	_current_display_state,#0x00
;src/menu.c:33: unsigned char current_position = MAIN_STATE_POS;
;     genAssign
	mov	_current_position,#0x00
;src/menu.c:34: unsigned char key_code = 0;
;     genAssign
	mov	_key_code,#0x00
;src/menu.c:45: unsigned char ZONE_1_PREPARED = 0;
;     genAssign
	mov	_ZONE_1_PREPARED,#0x00
;src/menu.c:46: unsigned char ZONE_2_PREPARED = 0;
;     genAssign
	mov	_ZONE_2_PREPARED,#0x00
;src/menu.c:47: unsigned char ZONE_3_PREPARED = 0;
;     genAssign
	mov	_ZONE_3_PREPARED,#0x00
;src/menu.c:48: unsigned char ZONE_4_PREPARED = 0;
;     genAssign
	mov	_ZONE_4_PREPARED,#0x00
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
;Allocation info for local variables in function 'stack_push_back'
;------------------------------------------------------------
;push                      Allocated to registers r2 
;------------------------------------------------------------
;src/menu.c:855: void stack_push_back(const unsigned char push)
;	-----------------------------------------
;	 function stack_push_back
;	-----------------------------------------
_stack_push_back:
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
;src/menu.c:857: stack.buffer[ stack.head++ ] = push;
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_stack
	movx	a,@dptr
	mov	r3,a
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
;     genPointerSet
;     genFarPointerSet
;       Peephole 100    removed redundant mov
	mov     r4,a
	mov     dptr,#_stack
	movx    @dptr,a
;     genCast
	mov	r5,#0x00
;     genPlus
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	add	a,#(_stack + 0x0002)
	mov	dpl,a
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
	addc	a,#((_stack + 0x0002) >> 8)
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
	mov	a,r2
	movx	@dptr,a
;src/menu.c:858: stack.head &= ( STACK_SIZE - 1 );
;     genAnd
	anl	ar4,#0x07
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_stack
	mov	a,r4
	movx	@dptr,a
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'stack_pop_front'
;------------------------------------------------------------
;retval                    Allocated to registers r2 
;------------------------------------------------------------
;src/menu.c:870: unsigned char stack_pop_front(void)
;	-----------------------------------------
;	 function stack_pop_front
;	-----------------------------------------
_stack_pop_front:
	push	_bp
	mov	_bp,sp
;src/menu.c:872: unsigned char retval = 0;
;     genAssign
	mov	r2,#0x00
;src/menu.c:874: if (stack.head != stack.tail) 
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_stack
	movx	a,@dptr
	mov	r3,a
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_stack + 0x0001)
	movx	a,@dptr
	mov	r4,a
;     genCmpEq
	mov	a,r3
	cjne	a,ar4,00106$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00102$
00106$:
;src/menu.c:876: retval = stack.buffer[ --stack.head ];
;     genMinus
;     genMinusDec
	dec	r3
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_stack
	mov	a,r3
	movx	@dptr,a
;     genCast
	mov	ar4,r3
	mov	r5,#0x00
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#(_stack + 0x0002)
	mov	dpl,a
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
	addc	a,#((_stack + 0x0002) >> 8)
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	movx	a,@dptr
	mov	r4,a
;     genAssign
	mov	ar2,r4
;src/menu.c:877: stack.head &= ( STACK_SIZE - 1 );
;     genAnd
	anl	ar3,#0x07
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_stack
	mov	a,r3
	movx	@dptr,a
00102$:
;src/menu.c:880: return retval;
;     genRet
	mov	dpl,r2
00103$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'stack_purge'
;------------------------------------------------------------
;------------------------------------------------------------
;src/menu.c:883: void stack_purge(void)
;	-----------------------------------------
;	 function stack_purge
;	-----------------------------------------
_stack_purge:
	push	_bp
	mov	_bp,sp
;src/menu.c:885: stack.head = 0;
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_stack
;       Peephole 181    changed mov to clr
;src/menu.c:886: stack.tail = 0;
;     genPointerSet
;     genFarPointerSet
;       Peephole 181    changed mov to clr
;       Peephole 219    removed redundant clear
	clr     a
	movx    @dptr,a
	mov     dptr,#(_stack + 0x0001)
	movx    @dptr,a
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'flash_init'
;------------------------------------------------------------
;flash                     Allocated to registers r2 r3 r4 
;xram                      Allocated to stack - offset 1
;count                     Allocated to stack - offset 4
;sloc0                     Allocated to stack - offset 6
;sloc1                     Allocated to stack - offset 9
;------------------------------------------------------------
;src/menu.c:897: void flash_init(void)
;	-----------------------------------------
;	 function flash_init
;	-----------------------------------------
_flash_init:
	push	_bp
	mov	_bp,sp
	mov	a,sp
	add	a,#0x0b
	mov	sp,a
;src/menu.c:899: unsigned char *flash = (unsigned char*)dfp;
;     genAssign
	mov	dptr,#_dfp
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
;     genCast
	mov	r4,#0x2
;src/menu.c:900: unsigned char *xram = (unsigned char*)system_data;
;     genCast
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,#_system_data
	inc	r0
	mov	@r0,#(_system_data >> 8)
	inc	r0
	mov	@r0,#0x1
;src/menu.c:903: lcd_clear();
;     genCall
	push	ar2
	push	ar3
	push	ar4
	lcall	_lcd_clear
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:904: if (*flash == 0xFF) // In the first run when flash memory is cleared we need to set default values
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
;     genCmpEq
	cjne	r5,#0xFF,00119$
	sjmp	00120$
00119$:
	ljmp	00102$
00120$:
;src/menu.c:906: printf_fast("Programowanie pamieci: (   ) z (%d). Prosze czekac ...", SYSTEM_DATA_SIZE);
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	mov	a,#0x74
	push	acc
	mov	a,#0x01
	push	acc
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
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:907: for (count=0 ; count < SYSTEM_DATA_SIZE; count++)
;     genAssign
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,_bp
	add	a,#0x06
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
;     genAssign
	mov	a,_bp
	add	a,#0x04
;       Peephole 216    simplified clear (2bytes)
	mov     r0,a
	clr     a
	mov     @r0,a
	inc     r0
	mov     @r0,a
00104$:
;     genCmpLt
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
;     genCmp
	clr	c
	mov	a,@r0
	subb	a,#0x74
	inc	r0
	mov	a,@r0
	subb	a,#0x01
;     genIfxJump
	jc	00121$
	ljmp	00112$
00121$:
;src/menu.c:909: flash_write_byte(0x0, (unsigned int)flash++);
;     genAssign
	mov	ar7,r2
	mov	ar5,r3
	mov	ar6,r4
;     genPlus
;     genPlusIncr
	inc	r2
	cjne	r2,#0x00,00122$
	inc	r3
00122$:
;     genCast
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	push	ar7
	push	ar5
;     genCall
	mov	dpl,#0x00
	lcall	_flash_write_byte
	dec	sp
	dec	sp
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:910: *xram++ = 0;
;     genPointerSet
;     genGenPointerSet
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
;       Peephole 181    changed mov to clr
	clr     a
	lcall	__gptrput
	inc	dptr
	dec	r0
	dec	r0
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
;src/menu.c:911: lcd_goto_xy(24,0);
;     genIpush
	push	ar2
	push	ar3
	push	ar4
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,#0x18
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:912: printf_fast("%03u", count);
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
;     genIpush
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:913: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/menu.c:907: for (count=0 ; count < SYSTEM_DATA_SIZE; count++)
;     genPlus
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	@r0,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	@r0,a
	ljmp	00104$
00102$:
;src/menu.c:918: lcd_goto_xy(0,0);
;     genIpush
	push	ar2
	push	ar3
	push	ar4
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,#0x00
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:919: printf_fast("Odczyt ustawien: (   ) z (%d). Prosze czekac ...", SYSTEM_DATA_SIZE);
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	mov	a,#0x74
	push	acc
	mov	a,#0x01
	push	acc
;     genIpush
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:920: for (count=0 ; count < SYSTEM_DATA_SIZE; count++)
;     genAssign
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	ar5,@r0
	inc	r0
	mov	ar6,@r0
	inc	r0
	mov	ar7,@r0
;     genAssign
	mov	r2,#0x00
	mov	r3,#0x00
00108$:
;     genCmpLt
;     genCmp
	clr	c
	mov	a,r2
	subb	a,#0x74
	mov	a,r3
	subb	a,#0x01
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00112$
00123$:
;src/menu.c:922: lcd_goto_xy(18,0);
;     genIpush
	push	ar2
	push	ar3
	push	ar5
	push	ar6
	push	ar7
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,#0x12
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar3
	pop	ar2
;src/menu.c:923: printf_fast("%03u", count);
;     genIpush
	push	ar2
	push	ar3
	push	ar5
	push	ar6
	push	ar7
	push	ar2
	push	ar3
;     genIpush
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar3
	pop	ar2
;src/menu.c:924: *xram++ = *flash++;
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r4,a
	inc	dptr
	dec	r0
	dec	r0
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
;     genPointerSet
;     genGenPointerSet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r4
	lcall	__gptrput
	inc	dptr
	mov	r5,dpl
	mov	r6,dph
;src/menu.c:920: for (count=0 ; count < SYSTEM_DATA_SIZE; count++)
;     genPlus
;     genPlusIncr
	inc	r2
	cjne	r2,#0x00,00124$
	inc	r3
00124$:
	ljmp	00108$
00112$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'set_new_blink'
;------------------------------------------------------------
;------------------------------------------------------------
;src/menu.c:937: void set_new_blink(void)
;	-----------------------------------------
;	 function set_new_blink
;	-----------------------------------------
_set_new_blink:
	push	_bp
	mov	_bp,sp
;src/menu.c:939: BLINKING_OFF;
;     genAssign
	mov	_blinking,#0x00
;src/menu.c:941: lcd_goto_xy(current_blink_params->position, 0);
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
;src/menu.c:942: lcd_put_string(current_blink_params->first_pattern_on);
;     genAssign
	mov	r2,_current_blink_params
	mov	r3,(_current_blink_params + 1)
	mov	r4,(_current_blink_params + 2)
;     genPlus
;     genPlusIncr
	inc	r2
	cjne	r2,#0x00,00106$
	inc	r3
00106$:
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
;src/menu.c:944: if (current_blink_params->lines > 1)
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
	jnc     00102$
00107$:
;src/menu.c:946: lcd_goto_xy(current_blink_params->position, 1);
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
;src/menu.c:947: lcd_put_string(current_blink_params->second_pattern_on);
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
00102$:
;src/menu.c:949: current_blink_params = menu[current_display_state].item[current_position].blink_union.blink;
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r2,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r3,a
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
;     genMult
;     genMultOneByte
	mov	a,_current_position
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
	mov	a,b
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	_current_blink_params,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_current_blink_params + 1),a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	(_current_blink_params + 2),a
;src/menu.c:951: BLINKING_ON;
;     genAssign
	mov	_blinking,#0x01
00103$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'display_zone_setings'
;------------------------------------------------------------
;zone                      Allocated to stack - offset 1
;display                   Allocated to stack - offset 2
;i                         Allocated to stack - offset 5
;------------------------------------------------------------
;src/menu.c:990: void display_zone_setings(const char zone)
;	-----------------------------------------
;	 function display_zone_setings
;	-----------------------------------------
_display_zone_setings:
	push	_bp
	mov	_bp,sp
	mov	a,sp
	add	a,#0x05
	mov	sp,a
;     genReceive
	push	acc
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	pop	acc
	mov	@r0,dpl
;src/menu.c:995: BLINKING_OFF;
;     genAssign
	mov	_blinking,#0x00
;src/menu.c:997: ds1302_read_rtc(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	lcall	_ds1302_read_rtc
;src/menu.c:999: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
;     genAssign
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	@r0,#0x00
00104$:
;     genIpush
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r4,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r5,a
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r4 instead of ar4
	add     a,r4
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
;     genCast
;       Peephole 105    removed redundant mov
	mov     r6,a
	rlc	a
	subb	a,acc
	mov	r7,a
;     genMinus
;     genMinusDec
	dec	r6
	cjne	r6,#0xff,00113$
	dec	r7
00113$:
;     genCast
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	ar2,@r0
	mov	r3,#0x00
;     genCmpLt
;     genCmp
	clr	c
	mov	a,r2
	subb	a,r6
	mov	a,r3
	xrl	a,#0x80
	mov	b,r7
	xrl	b,#0x80
	subb	a,b
;     genIpop
;     genIfx
;     genIfxJump
;       Peephole 129    jump optimization
	jc      00114$
	ljmp	00107$
00114$:
;src/menu.c:1001: display = menu[current_display_state].item[i].display;
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r4 instead of ar4
	add     a,r4
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	r5,a
;     genMult
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
;     genMultOneByte
	mov	a,@r0
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r4 instead of ar4
	add     a,r4
	mov	r4,a
	mov	a,b
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	r5,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r4 instead of ar4
	add     a,r4
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r3,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r4,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r5,a
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;src/menu.c:1002: lcd_goto_xy(display->x, display->y);
;     genPlus
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	r6,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r7,a
	inc	r0
	mov	ar2,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r6
	mov	dph,r7
	mov	b,r2
	lcall	__gptrget
	mov	r6,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r2,a
;     genIpush
	push	ar6
;     genCall
	mov	dpl,r2
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1004: if (system_data.zone_settings[zone+i].start_time == 0)
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,_bp
	add	a,#0x05
	mov	r1,a
	mov	a,@r1
	add	a,@r0
;     genMult
;     genMultOneByte
	clr	F0
	mov	b,#0x0a
	jnb	acc.7,00115$
	cpl	F0
	cpl	a
	inc	a
00115$:
	mul	ab
	jnb	F0,00116$
	cpl	a
	add	a,#1
	xch	a,b
	cpl	a
	addc	a,#0
	xch	a,b
00116$:
;     genPlus
	add	a,#_system_data
	mov	r2,a
	mov	a,b
	addc	a,#(_system_data >> 8)
	mov	r6,a
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 194    optimized misc jump sequence
	cjne    r2,#0x00,00102$
	cjne    r6,#0x00,00102$
	cjne    r7,#0x00,00102$
	cjne    r3,#0x00,00102$
;00117$:
;       Peephole 200    removed redundant sjmp
00118$:
;src/menu.c:1006: printf_fast("WYLACZONE  ");
;     genIpush
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
;src/menu.c:1007: lcd_goto_xy(display->x+3, 0);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r2,a
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1008: printf_fast("--");
;     genIpush
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
	ljmp	00106$
00102$:
;src/menu.c:1012: local_gmtime(&system_data.zone_settings[zone+i].start_time);
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,_bp
	add	a,#0x05
	mov	r1,a
	mov	a,@r1
	add	a,@r0
;     genMult
;     genMultOneByte
	clr	F0
	mov	b,#0x0a
	jnb	acc.7,00119$
	cpl	F0
	cpl	a
	inc	a
00119$:
	mul	ab
	jnb	F0,00120$
	cpl	a
	add	a,#1
	xch	a,b
	cpl	a
	addc	a,#0
	xch	a,b
00120$:
	mov	r2,a
	mov	r3,b
;     genPlus
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
	add	a,#_system_data
	mov	r4,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	r5,a
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r4 instead of ar4
	add     a,r4
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	r5,a
;     genCast
	mov	r6,#0x1
;     genCall
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	push	ar2
	push	ar3
	lcall	_local_gmtime
	pop	ar3
	pop	ar2
;src/menu.c:1016: (unsigned int)system_time.tm_min);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
	mov	r4,a
;     genCast
	mov	r5,#0x00
;src/menu.c:1015: (unsigned int)system_time.tm_hour,
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r6,a
;     genCast
	mov	r7,#0x00
;src/menu.c:1014: printf_fast("%02u:%02u", 
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	push	ar5
;     genIpush
	push	ar6
	push	ar7
;     genIpush
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar3
	pop	ar2
;src/menu.c:1018: printf_fast("-");
;     genIpush
	push	ar2
	push	ar3
	mov	a,#__str_6
	push	acc
	mov	a,#(__str_6 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
	pop	ar3
	pop	ar2
;src/menu.c:1019: local_gmtime(&system_data.zone_settings[zone+i].stop_time);
;     genPlus
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
	add	a,#_system_data
	mov	r4,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	r5,a
;     genPlus
	mov	a,#0x06
;       Peephole 236.a  used r4 instead of ar4
	add     a,r4
	mov	r4,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	r5,a
;     genCast
	mov	r6,#0x1
;     genCall
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	push	ar2
	push	ar3
	lcall	_local_gmtime
	pop	ar3
	pop	ar2
;src/menu.c:1024: (unsigned int)system_time.tm_min);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
	mov	r4,a
;     genCast
	mov	r5,#0x00
;src/menu.c:1023: (unsigned int)system_time.tm_hour,
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r6,a
;     genCast
	mov	r7,#0x00
;src/menu.c:1022: printf_fast("%02u:%02u", 
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	push	ar5
;     genIpush
	push	ar6
	push	ar7
;     genIpush
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar3
	pop	ar2
;src/menu.c:1026: lcd_goto_xy(display->x+3, 0);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r4,a
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r4 instead of ar4
	add     a,r4
	mov	dpl,a
;     genIpush
	push	ar2
	push	ar3
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar3
	pop	ar2
;src/menu.c:1027: printf_fast("%02u",system_data.zone_settings[zone+i].temperature);
;     genPlus
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
	add	a,#_system_data
	mov	dpl,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
;     genIpush
	push	ar2
	push	ar3
;     genIpush
	mov	a,#__str_7
	push	acc
	mov	a,#(__str_7 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
00106$:
;src/menu.c:999: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
;     genPlus
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
;     genPlusIncr
	inc	@r0
	ljmp	00104$
00107$:
;src/menu.c:1031: BLINKING_ON;
;     genAssign
	mov	_blinking,#0x01
00108$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'display_stored_time'
;------------------------------------------------------------
;method                    Allocated to stack - offset -3
;display_force             Allocated to stack - offset -4
;pos                       Allocated to registers r2 
;display                   Allocated to stack - offset 1
;sec                       Allocated with name '_display_stored_time_sec_1_1'
;------------------------------------------------------------
;src/menu.c:1034: void display_stored_time(const char pos, const char method, const char display_force)
;	-----------------------------------------
;	 function display_stored_time
;	-----------------------------------------
_display_stored_time:
	push	_bp
	mov	_bp,sp
	inc	sp
	inc	sp
	inc	sp
;     genReceive
	mov	r2,dpl
;src/menu.c:1038: ds1302_read_rtc(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	push	ar2
	lcall	_ds1302_read_rtc
	pop	ar2
;src/menu.c:1040: if (sec != system_time.tm_sec || display_force == true)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_system_time
	movx	a,@dptr
	mov	r3,a
;     genCmpEq
	mov	a,_display_stored_time_sec_1_1
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,ar3,00107$
;00115$:
;       Peephole 200    removed redundant sjmp
00116$:
;     genCmpEq
	mov	a,_bp
	add	a,#0xfc
	mov	r0,a
	cjne	@r0,#0x01,00117$
	sjmp	00118$
00117$:
	ljmp	00110$
00118$:
00107$:
;src/menu.c:1042: sec = system_time.tm_sec;
;     genAssign
	mov	_display_stored_time_sec_1_1,r3
;src/menu.c:1043: switch (method)
;     genCmpLt
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
;     genCmp
	mov	a,@r0
;     genIfxJump
	jnb	acc.7,00119$
	ljmp	00110$
00119$:
;     genCmpGt
;     genCmp
	clr	c
;       Peephole 159    avoided xrl during execution
	mov  a,#(0x04 ^ 0x80)
	mov	b,@r0
	xrl	b,#0x80
	subb	a,b
;     genIfxJump
	jnc	00120$
	ljmp	00110$
00120$:
;     genJumpTab
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
	mov	a,@r0
	add	a,acc
	add	a,@r0
	mov	dptr,#00121$
	jmp	@a+dptr
00121$:
	ljmp	00101$
	ljmp	00103$
	ljmp	00104$
	ljmp	00102$
	ljmp	00105$
;src/menu.c:1046: BLINKING_OFF;
00101$:
;     genAssign
	mov	_blinking,#0x00
;src/menu.c:1047: display = menu[current_display_state].item[pos].display;
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r3,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r4,a
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	r3,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genMult
;     genMultOneByte
	clr	F0
	mov	b,#0x08
	mov	a,r2
	jnb	acc.7,00122$
	cpl	F0
	cpl	a
	inc	a
00122$:
	mul	ab
	jnb	F0,00123$
	cpl	a
	add	a,#1
	xch	a,b
	cpl	a
	addc	a,#0
	xch	a,b
00123$:
;     genPlus
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	r3,a
	mov	a,b
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
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
	mov	r3,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r4,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r5,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;src/menu.c:1048: lcd_goto_xy(display->x, display->y);
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	r6,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r7,a
	inc	r0
	mov	ar3,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r6
	mov	dph,r7
	mov	b,r3
	lcall	__gptrget
	mov	r6,a
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
	mov	r3,a
;     genIpush
	push	ar6
;     genCall
	mov	dpl,r3
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1049: printf_asctime(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	lcall	_printf_asctime
;src/menu.c:1050: BLINKING_ON;
;     genAssign
	mov	_blinking,#0x01
;src/menu.c:1051: break;
	ljmp	00110$
;src/menu.c:1054: BLINKING_OFF;
00102$:
;     genAssign
	mov	_blinking,#0x00
;src/menu.c:1055: display = menu[current_display_state].item[pos].display;
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r3,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r4,a
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	r3,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genMult
;     genMultOneByte
	clr	F0
	mov	b,#0x08
	mov	a,r2
	jnb	acc.7,00124$
	cpl	F0
	cpl	a
	inc	a
00124$:
	mul	ab
	jnb	F0,00125$
	cpl	a
	add	a,#1
	xch	a,b
	cpl	a
	addc	a,#0
	xch	a,b
00125$:
;     genPlus
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	r3,a
	mov	a,b
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
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
	mov	r3,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r4,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
;src/menu.c:1056: lcd_goto_xy(display->x, display->y);
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r3,a
	inc	r0
	mov	ar4,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
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
	mov	r3,a
;     genIpush
	push	ar2
;     genCall
	mov	dpl,r3
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1057: printf_short_asctime(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	lcall	_printf_short_asctime
;src/menu.c:1058: BLINKING_ON;
;     genAssign
	mov	_blinking,#0x01
;src/menu.c:1059: break;
	ljmp	00110$
;src/menu.c:1062: display = menu[current_display_state].item[current_position].display;
00103$:
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r2,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r3,a
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
;     genMult
;     genMultOneByte
	mov	a,_current_position
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
	mov	a,b
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r4,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
;src/menu.c:1063: lcd_goto_xy(display->x, display->y);
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r3,a
	inc	r0
	mov	ar4,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
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
	mov	r3,a
;     genIpush
	push	ar2
;     genCall
	mov	dpl,r3
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1067: (unsigned int)system_time.tm_mday);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0003)
	movx	a,@dptr
	mov	r2,a
;     genCast
	mov	r3,#0x00
;src/menu.c:1066: (unsigned int)system_time.tm_mon + 1,
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0004)
	movx	a,@dptr
	mov	r4,a
;     genCast
	mov	r5,#0x00
;     genPlus
;     genPlusIncr
	inc	r4
	cjne	r4,#0x00,00126$
	inc	r5
00126$:
;src/menu.c:1065: (unsigned int)system_time.tm_year + 2000,
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0005)
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
;     genPlus
	mov	a,#0xD0
;       Peephole 236.a  used r6 instead of ar6
	add     a,r6
	mov	r6,a
	mov	a,#0x07
;       Peephole 236.b  used r7 instead of ar7
	addc    a,r7
	mov	r7,a
;src/menu.c:1064: printf_fast("%04u-%02u-%02u", 
;     genIpush
	push	ar2
	push	ar3
;     genIpush
	push	ar4
	push	ar5
;     genIpush
	push	ar6
	push	ar7
;     genIpush
	mov	a,#__str_8
	push	acc
	mov	a,#(__str_8 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
;src/menu.c:1068: break;
	ljmp	00110$
;src/menu.c:1071: display = menu[current_display_state].item[current_position].display;
00104$:
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r2,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r3,a
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
;     genMult
;     genMultOneByte
	mov	a,_current_position
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
	mov	a,b
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r4,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
;src/menu.c:1072: lcd_goto_xy(display->x, display->y);
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r3,a
	inc	r0
	mov	ar4,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
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
	mov	r3,a
;     genIpush
	push	ar2
;     genCall
	mov	dpl,r3
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1076: (unsigned int)system_time.tm_sec);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_system_time
	movx	a,@dptr
	mov	r2,a
;     genCast
	mov	r3,#0x00
;src/menu.c:1075: (unsigned int)system_time.tm_min,
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
	mov	r4,a
;     genCast
	mov	r5,#0x00
;src/menu.c:1074: (unsigned int)system_time.tm_hour,
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r6,a
;     genCast
	mov	r7,#0x00
;src/menu.c:1073: printf_fast("%02u:%02u:%02u", 
;     genIpush
	push	ar2
	push	ar3
;     genIpush
	push	ar4
	push	ar5
;     genIpush
	push	ar6
	push	ar7
;     genIpush
	mov	a,#__str_9
	push	acc
	mov	a,#(__str_9 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
;src/menu.c:1077: break;
	ljmp	00110$
;src/menu.c:1080: display = menu[current_display_state].item[current_position].display;
00105$:
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r2,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r3,a
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
;     genMult
;     genMultOneByte
	mov	a,_current_position
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
	mov	a,b
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r4,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
;src/menu.c:1081: lcd_goto_xy(display->x, display->y);
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r3,a
	inc	r0
	mov	ar4,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
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
	mov	r3,a
;     genIpush
	push	ar2
;     genCall
	mov	dpl,r3
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1082: printf_weekday_short(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	lcall	_printf_weekday_short
;src/menu.c:1084: }
00110$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'display_stored_data'
;------------------------------------------------------------
;display_force             Allocated to stack - offset -3
;value                     Allocated to registers r2 r3 r4 
;temp                      Allocated to stack - offset 1
;i                         Allocated to stack - offset 3
;j                         Allocated to stack - offset 4
;display                   Allocated to registers r5 r6 r7 
;sloc0                     Allocated to stack - offset 6
;sec                       Allocated with name '_display_stored_data_sec_1_1'
;------------------------------------------------------------
;src/menu.c:1096: void display_stored_data(unsigned int *value, const char display_force)
;	-----------------------------------------
;	 function display_stored_data
;	-----------------------------------------
_display_stored_data:
	push	_bp
	mov	_bp,sp
	mov	a,sp
	add	a,#0x06
	mov	sp,a
;     genReceive
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;src/menu.c:1104: ds1302_read_rtc(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	push	ar2
	push	ar3
	push	ar4
	lcall	_ds1302_read_rtc
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:1106: if (sec != system_time.tm_sec || display_force == true)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_system_time
	movx	a,@dptr
	mov	r5,a
;     genCmpEq
	mov	a,_display_stored_data_sec_1_1
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,ar5,00103$
;00116$:
;       Peephole 200    removed redundant sjmp
00117$:
;     genCmpEq
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
	cjne	@r0,#0x01,00118$
	sjmp	00119$
00118$:
	ljmp	00110$
00119$:
00103$:
;src/menu.c:1108: BLINKING_OFF;
;     genAssign
	mov	_blinking,#0x00
;src/menu.c:1109: sec = system_time.tm_sec;
;     genAssign
	mov	_display_stored_data_sec_1_1,r5
;src/menu.c:1111: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
;     genAssign
;     genAssign
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	@r0,#0x00
00106$:
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r6,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r7,a
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r6 instead of ar6
	add     a,r6
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r7 instead of ar7
	addc    a,r7
	mov	dph,a
;     genIpush
	push	ar2
	push	ar3
	push	ar4
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
;     genCast
;       Peephole 105    removed redundant mov
	mov     r2,a
	rlc	a
	subb	a,acc
	mov	r3,a
;     genMinus
;     genMinusDec
	dec	r2
	cjne	r2,#0xff,00120$
	dec	r3
00120$:
;     genCast
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	ar4,@r0
	mov	r5,#0x00
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
	clr	a
	rlc	a
;     genIpop
	pop	ar4
	pop	ar3
	pop	ar2
;     genIfx
;     genIfxJump
	jnz	00121$
	ljmp	00109$
00121$:
;src/menu.c:1113: display = menu[current_display_state].item[i].display;
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r6 instead of ar6
	add     a,r6
	mov	r6,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r7 instead of ar7
	addc    a,r7
	mov	r7,a
;     genMult
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
;     genMultOneByte
	mov	a,@r0
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r6 instead of ar6
	add     a,r6
	mov	r6,a
	mov	a,b
;       Peephole 236.b  used r7 instead of ar7
	addc    a,r7
	mov	r7,a
;     genPlus
	mov	a,#0x05
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
	mov	r5,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r6,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r7,a
;     genAssign
;src/menu.c:1115: temp = *value;
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	lcall	__gptrget
	mov	@r0,a
	inc	dptr
	lcall	__gptrget
	inc	r0
	mov	@r0,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;src/menu.c:1116: lcd_goto_xy(display->x, display->y);
;     genIpush
	push	ar2
	push	ar3
	push	ar4
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	r3,a
	mov	ar4,r7
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r3,a
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar2
;     genCall
	mov	dpl,r3
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:1117: printf_fast((char code*)display->width,temp);
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	r3,a
	mov	ar4,r7
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
;     genCast
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
;     genIpush
	push	ar2
	push	ar3
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:1119: if (display->point > 0)
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	r3,a
	mov	ar4,r7
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	lcall	__gptrget
	mov	@r0,a
;     genCmpGt
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
;     genCmp
	clr	c
;       Peephole 181    changed mov to clr
	clr     a
	subb	a,@r0
	clr	a
	rlc	a
;     genIpop
	pop	ar4
	pop	ar3
	pop	ar2
;     genIfx
;     genIfxJump
	jnz	00122$
	ljmp	00102$
00122$:
;src/menu.c:1121: temp = *value;
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	lcall	__gptrget
	mov	@r0,a
	inc	dptr
	lcall	__gptrget
	inc	r0
	mov	@r0,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;src/menu.c:1122: j = (unsigned int)(temp % 10);
;     genAssign
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	__moduint_PARM_2,#0x0A
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	__moduint
	push	acc
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	pop	acc
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:1123: lcd_goto_xy(display->x+display->point, display->y);
;     genIpush
	push	ar2
	push	ar3
	push	ar4
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	r3,a
	mov	ar4,r7
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r5,a
;     genPlus
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	a,@r0
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	dpl,a
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	push	ar2
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:1124: printf_fast(".%d",j);
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
;     genIpush
	mov	a,#__str_10
	push	acc
	mov	a,#(__str_10 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:1128: BLINKING_ON;
;     genIpop
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:1124: printf_fast(".%d",j);
00102$:
;src/menu.c:1126: value++;      
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
;src/menu.c:1111: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
;     genPlus
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
;     genPlusIncr
	inc	@r0
	ljmp	00106$
00109$:
;src/menu.c:1128: BLINKING_ON;
;     genAssign
	mov	_blinking,#0x01
00110$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'switch_zone'
;------------------------------------------------------------
;zone_no                   Allocated to registers r2 
;------------------------------------------------------------
;src/menu.c:1132: void switch_zone(const char zone_no)
;	-----------------------------------------
;	 function switch_zone
;	-----------------------------------------
_switch_zone:
	push	_bp
	mov	_bp,sp
;     genReceive
;src/menu.c:1134: switch(zone_no)
;     genCmpLt
;     genCmp
;       Peephole 244.a  moving first to a instead of r2
	mov	a,dpl
	mov	r2,a
;     genIfxJump
;       Peephole 112.a  removed ljmp by inverse jump logic
	jb      acc.7,00106$
00110$:
;     genCmpGt
;     genCmp
	clr	c
;       Peephole 159    avoided xrl during execution
	mov  a,#(0x03 ^ 0x80)
	mov	b,r2
	xrl	b,#0x80
	subb	a,b
;     genIfxJump
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 160    removed sjmp by inverse jump logic
	jc      00106$
00111$:
;     genJumpTab
	mov	a,r2
	add	a,acc
	add	a,r2
	mov	dptr,#00112$
	jmp	@a+dptr
00112$:
	ljmp	00101$
	ljmp	00102$
	ljmp	00103$
	ljmp	00104$
;src/menu.c:1137: ZONE_1_OUTPUT = ZONE_1_PREPARED;
00101$:
;     genAssign
	mov	a,_ZONE_1_PREPARED
	add	a,#0xff
	mov	_P3_5,c
;src/menu.c:1138: break;
;src/menu.c:1140: ZONE_2_OUTPUT = ZONE_2_PREPARED;
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00102$:
;     genAssign
	mov	a,_ZONE_2_PREPARED
	add	a,#0xff
	mov	_P3_2,c
;src/menu.c:1141: break;
;src/menu.c:1143: ZONE_3_OUTPUT = ZONE_3_PREPARED;
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00103$:
;     genAssign
	mov	a,_ZONE_3_PREPARED
	add	a,#0xff
	mov	_P3_3,c
;src/menu.c:1144: break;
;src/menu.c:1146: ZONE_4_OUTPUT = ZONE_4_PREPARED;
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00104$:
;     genAssign
	mov	a,_ZONE_4_PREPARED
	add	a,#0xff
	mov	_P1_0,c
;src/menu.c:1148: }
00106$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'switch_zone_prepare'
;------------------------------------------------------------
;value                     Allocated to stack - offset -3
;zone_no                   Allocated to registers r2 
;------------------------------------------------------------
;src/menu.c:1151: void switch_zone_prepare(const char zone_no, const bool value)
;	-----------------------------------------
;	 function switch_zone_prepare
;	-----------------------------------------
_switch_zone_prepare:
	push	_bp
	mov	_bp,sp
;     genReceive
;src/menu.c:1153: switch(zone_no)
;     genCmpLt
;     genCmp
;       Peephole 244.a  moving first to a instead of r2
	mov	a,dpl
	mov	r2,a
;     genIfxJump
;       Peephole 112.a  removed ljmp by inverse jump logic
	jb      acc.7,00106$
00110$:
;     genCmpGt
;     genCmp
	clr	c
;       Peephole 159    avoided xrl during execution
	mov  a,#(0x03 ^ 0x80)
	mov	b,r2
	xrl	b,#0x80
	subb	a,b
;     genIfxJump
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 160    removed sjmp by inverse jump logic
	jc      00106$
00111$:
;     genJumpTab
	mov	a,r2
	add	a,acc
	add	a,r2
	mov	dptr,#00112$
	jmp	@a+dptr
00112$:
	ljmp	00101$
	ljmp	00102$
	ljmp	00103$
	ljmp	00104$
;src/menu.c:1156: ZONE_1_PREPARED = value;
00101$:
;     genAssign
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
	mov	_ZONE_1_PREPARED,@r0
;src/menu.c:1157: break;
;src/menu.c:1159: ZONE_2_PREPARED = value;
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00102$:
;     genAssign
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
	mov	_ZONE_2_PREPARED,@r0
;src/menu.c:1160: break;
;src/menu.c:1162: ZONE_3_PREPARED = value;
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00103$:
;     genAssign
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
	mov	_ZONE_3_PREPARED,@r0
;src/menu.c:1163: break;
;src/menu.c:1165: ZONE_4_PREPARED = value;
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00104$:
;     genAssign
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
	mov	_ZONE_4_PREPARED,@r0
;src/menu.c:1167: }
00106$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'display_enabled_channels'
;------------------------------------------------------------
;display_force             Allocated to registers r2 
;i                         Allocated to stack - offset 1
;display                   Allocated to registers r2 r3 r4 
;sec                       Allocated with name '_display_enabled_channels_sec_1_1'
;------------------------------------------------------------
;src/menu.c:1170: void display_enabled_channels(const char display_force)
;	-----------------------------------------
;	 function display_enabled_channels
;	-----------------------------------------
_display_enabled_channels:
	push	_bp
	mov	_bp,sp
	inc	sp
;     genReceive
	mov	r2,dpl
;src/menu.c:1176: ds1302_read_rtc(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	push	ar2
	lcall	_ds1302_read_rtc
	pop	ar2
;src/menu.c:1178: if (sec != system_time.tm_sec || display_force == true)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_system_time
	movx	a,@dptr
	mov	r3,a
;     genCmpEq
	mov	a,_display_enabled_channels_sec_1_1
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,ar3,00108$
;00125$:
;       Peephole 200    removed redundant sjmp
00126$:
;     genCmpEq
	cjne	r2,#0x01,00127$
	sjmp	00128$
00127$:
	ljmp	00115$
00128$:
00108$:
;src/menu.c:1180: BLINKING_OFF;
;     genAssign
	mov	_blinking,#0x00
;src/menu.c:1181: sec = system_time.tm_sec;
;     genAssign
	mov	_display_enabled_channels_sec_1_1,r3
;src/menu.c:1182: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,#0x00
00111$:
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r3,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r4,a
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
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
;     genCast
;       Peephole 105    removed redundant mov
	mov     r5,a
	rlc	a
	subb	a,acc
	mov	r6,a
;     genMinus
;     genMinusDec
	dec	r5
	cjne	r5,#0xff,00129$
	dec	r6
00129$:
;     genCast
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	ar7,@r0
	mov	r2,#0x00
;     genCmpLt
;     genCmp
	clr	c
	mov	a,r7
	subb	a,r5
	mov	a,r2
	xrl	a,#0x80
	mov	b,r6
	xrl	b,#0x80
	subb	a,b
;     genIfxJump
	jc	00130$
	ljmp	00114$
00130$:
;src/menu.c:1184: if ( i < NUMBER_OF_CHANNELS)
;     genCmpLt
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genCmp
	cjne	@r0,#0x04,00131$
00131$:
;     genIfxJump
	jc	00132$
	ljmp	00113$
00132$:
;src/menu.c:1186: display = menu[current_display_state].item[i].display;
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	r3,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genMult
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genMultOneByte
	mov	a,@r0
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	r3,a
	mov	a,b
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
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
	mov	r3,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r4,a
;     genAssign
;src/menu.c:1188: lcd_goto_xy(display->x+4, display->y);
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
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;     genIpush
	push	ar5
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1189: switch(system_data.enabled[i])
;     genCast
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	ar2,@r0
	mov	r3,#0x00
;     genPlus
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	movx	a,@dptr
	mov	r2,a
;     genCmpEq
	cjne	r2,#0x00,00133$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00102$
00133$:
;     genCmpEq
	cjne	r2,#0x02,00134$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00101$
00134$:
;     genCmpEq
	cjne	r2,#0x04,00135$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00103$
00135$:
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;src/menu.c:1192: printf_fast("+");
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    r2,#0x08,00113$
	sjmp    00104$
;00136$:
00101$:
;     genIpush
	mov	a,#__str_11
	push	acc
	mov	a,#(__str_11 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
;src/menu.c:1194: break;
;src/menu.c:1196: printf_fast("-");
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00113$
00102$:
;     genIpush
	mov	a,#__str_6
	push	acc
	mov	a,#(__str_6 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
;src/menu.c:1198: break;
;src/menu.c:1200: printf_fast("*");
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00113$
00103$:
;     genIpush
	mov	a,#__str_12
	push	acc
	mov	a,#(__str_12 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
;src/menu.c:1201: switch_zone_prepare(i,1);
;     genIpush
	mov	a,#0x01
	push	acc
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	lcall	_switch_zone_prepare
	dec	sp
;src/menu.c:1202: switch_zone(i);
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	lcall	_switch_zone
;src/menu.c:1203: break;
;src/menu.c:1205: printf_fast("#");
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00113$
00104$:
;     genIpush
	mov	a,#__str_13
	push	acc
	mov	a,#(__str_13 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
;src/menu.c:1206: switch_zone_prepare(i,0);
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	lcall	_switch_zone_prepare
	dec	sp
;src/menu.c:1207: switch_zone(i);
;     genCall
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
	lcall	_switch_zone
;src/menu.c:1209: }
00113$:
;src/menu.c:1182: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	inc	@r0
	ljmp	00111$
00114$:
;src/menu.c:1212: BLINKING_ON;
;     genAssign
	mov	_blinking,#0x01
00115$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'is_day_matching'
;------------------------------------------------------------
;wday                      Allocated to stack - offset -3
;zone                      Allocated to registers r2 
;config_day                Allocated to registers r2 
;current_day               Allocated to registers r3 
;------------------------------------------------------------
;src/menu.c:1217: unsigned char is_day_matching(const char zone, const char wday)
;	-----------------------------------------
;	 function is_day_matching
;	-----------------------------------------
_is_day_matching:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
;src/menu.c:1222: current_day = wday;
;     genAssign
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
	mov	ar3,@r0
;     genAssign
;src/menu.c:1223: if (wday < 6)
;     genCmpLt
	mov	a,_bp
	add	a,#0xfd
	mov	r0,a
;     genCmp
	clr	c
	mov	a,@r0
	xrl	a,#0x80
	subb	a,#0x86
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00102$
00110$:
;src/menu.c:1224: current_day = 0;
;     genAssign
	mov	r3,#0x00
00102$:
;src/menu.c:1226: config_day = zone_day_map[zone].day;
;     genMult
;     genMultOneByte
	clr	F0
	mov	b,#0x02
	mov	a,r2
	jnb	acc.7,00111$
	cpl	F0
	cpl	a
	inc	a
00111$:
	mul	ab
	jnb	F0,00112$
	cpl	a
	add	a,#1
	xch	a,b
	cpl	a
	addc	a,#0
	xch	a,b
00112$:
;     genPlus
	add	a,#_zone_day_map
	mov	r2,a
	mov	a,b
	addc	a,#(_zone_day_map >> 8)
	mov	r4,a
;     genPlus
;     genPlusIncr
	mov	a,#0x01
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
;     genAssign
;src/menu.c:1227: if(config_day == current_day)
;     genCmpEq
;       Peephole 105    removed redundant mov
	mov     r2,a
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,ar3,00104$
;00113$:
;       Peephole 200    removed redundant sjmp
00114$:
;src/menu.c:1228: return true;
;     genRet
	mov	dpl,#0x01
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00104$:
;src/menu.c:1230: return false;
;     genRet
	mov	dpl,#0x00
00106$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'control_workloop'
;------------------------------------------------------------
;i                         Allocated to stack - offset 1
;j                         Allocated to stack - offset 2
;offset                    Allocated to registers r3 
;result                    Allocated to registers r3 r4 
;weekday                   Allocated to registers r2 
;histereza                 Allocated to stack - offset 3
;sloc0                     Allocated to stack - offset 4
;sloc1                     Allocated to stack - offset 6
;sloc2                     Allocated to stack - offset 8
;------------------------------------------------------------
;src/menu.c:1236: void control_workloop(void)
;	-----------------------------------------
;	 function control_workloop
;	-----------------------------------------
_control_workloop:
	push	_bp
	mov	_bp,sp
	mov	a,sp
	add	a,#0x0b
	mov	sp,a
;src/menu.c:1242: unsigned char histereza = 0;
;     genAssign
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	@r0,#0x00
;src/menu.c:1243: ds1302_read_rtc(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	lcall	_ds1302_read_rtc
;src/menu.c:1246: temp_long = system_time.tm_hour;
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r3,a
;     genCast
	mov	_temp_long,r3
	mov	(_temp_long + 1),#0x00
	mov	(_temp_long + 2),#0x00
	mov	(_temp_long + 3),#0x00
;src/menu.c:1247: temp_long *= 3600;
;     genAssign
	mov	__mullong_PARM_2,#0x10
	mov	(__mullong_PARM_2 + 1),#0x0E
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
;     genCall
	mov	dpl,_temp_long
	mov	dph,(_temp_long + 1)
	mov	b,(_temp_long + 2)
	mov	a,(_temp_long + 3)
	lcall	__mullong
	mov	_temp_long,dpl
	mov	(_temp_long + 1),dph
	mov	(_temp_long + 2),b
	mov	(_temp_long + 3),a
;src/menu.c:1248: result = system_time.tm_min * 60;
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
;     genMult
;     genMultOneByte
;       Peephole 105    removed redundant mov
	mov     r3,a
	mov	b,#0x3C
	mul	ab
	mov	r3,a
	mov	r4,b
;src/menu.c:1249: temp_long += result;
;     genCast
;     genPlus
;       Peephole 3.c    changed mov to clr
	clr     a
	mov     r5,a
	mov     r6,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	add	a,_temp_long
	mov	_temp_long,a
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	addc	a,(_temp_long + 1)
	mov	(_temp_long + 1),a
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
	addc	a,(_temp_long + 2)
	mov	(_temp_long + 2),a
;       Peephole 236.g  used r6 instead of ar6
	mov     a,r6
	addc	a,(_temp_long + 3)
	mov	(_temp_long + 3),a
;src/menu.c:1250: temp_long += system_time.tm_sec;
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_system_time
	movx	a,@dptr
	mov	r3,a
;     genCast
	mov	r4,#0x00
;     genCast
	mov	a,r4
	rlc	a
	subb	a,acc
	mov	r5,a
	mov	r6,a
;     genPlus
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	add	a,_temp_long
	mov	_temp_long,a
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	addc	a,(_temp_long + 1)
	mov	(_temp_long + 1),a
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
	addc	a,(_temp_long + 2)
	mov	(_temp_long + 2),a
;       Peephole 236.g  used r6 instead of ar6
	mov     a,r6
	addc	a,(_temp_long + 3)
	mov	(_temp_long + 3),a
;src/menu.c:1252: for (j = 0; j<CHANNELS_COUNT; j++)
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,#0x00
00124$:
;     genCmpLt
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
;     genCmp
	cjne	@r0,#0x04,00141$
00141$:
;     genIfxJump
	jc	00142$
	ljmp	00127$
00142$:
;src/menu.c:1254: for (i = 0; i<ZONES_COUNT; i++)
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,#0x00
;     genMult
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
;     genMultOneByte
	mov	a,@r0
	mov	b,#0x02
	mul	ab
	mov	r5,a
	mov	r6,b
;     genMult
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
;     genMultOneByte
	mov	a,@r0
	mov	b,#0x09
	mul	ab
	mov	r7,a
00120$:
;     genCmpLt
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genCmp
	cjne	@r0,#0x09,00143$
00143$:
;     genIfxJump
	jc	00144$
	ljmp	00126$
00144$:
;src/menu.c:1256: if (system_data.enabled[j] == CHANNEL_ENABLED || system_data.enabled[j] == CHANNEL_DISABLED)
;     genIpush
	push	ar7
;     genCast
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	a,_bp
	add	a,#0x04
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	inc	r1
	mov	@r1,#0x00
;     genPlus
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
	inc	r0
	mov	a,@r0
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	movx	a,@dptr
	mov	r7,a
;     genCmpEq
;       Peephole 241.c  optimized compare
	clr     a
	cjne    r7,#0x02,00145$
	inc     a
00145$:
00146$:
;     genIpop
	pop	ar7
;     genIfx
;     genIfxJump
;       Peephole 109    removed ljmp by inverse jump logic
	jnz     00117$
00147$:
;     genIpush
	push	ar7
;     genPlus
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
	inc	r0
	mov	a,@r0
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	movx	a,@dptr
	mov	r7,a
;     genCmpEq
;       Peephole 241.c  optimized compare
	clr     a
	cjne    r7,#0x00,00148$
	inc     a
00148$:
00149$:
;     genIpop
	pop	ar7
;     genIfx
;     genIfxJump
	jnz	00150$
	ljmp	00122$
00150$:
00117$:
;src/menu.c:1258: offset = j*ZONES_COUNT + i;
;     genIpush
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,@r0
;       Peephole 236.a  used r7 instead of ar7
	add     a,r7
	mov	r2,a
;     genAssign
	mov	ar3,r2
;src/menu.c:1259: weekday = is_day_matching(offset, system_time.tm_wday);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0007)
	movx	a,@dptr
	mov	r2,a
;     genIpush
	push	ar3
	push	ar5
	push	ar6
	push	ar7
	push	ar2
;     genCall
	mov	dpl,r3
	lcall	_is_day_matching
	mov	r2,dpl
	dec	sp
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar3
;     genAssign
;src/menu.c:1260: if (weekday == true)
;     genCmpEq
;       Peephole 241.c  optimized compare
	clr     a
	cjne    r2,#0x01,00151$
	inc     a
00151$:
00152$:
;     genIpop
;     genIfx
;     genIfxJump
	jnz	00153$
	ljmp	00122$
00153$:
;src/menu.c:1262: if (system_data.zone_settings[offset].start_time > 0)
;     genMult
;     genMultOneByte
	mov	a,r3
	mov	b,#0x0A
	mul	ab
;     genPlus
	push	acc
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	pop	acc
	add	a,#_system_data
	mov	@r0,a
	mov	a,b
	addc	a,#(_system_data >> 8)
	inc	r0
	mov	@r0,a
;     genPlus
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
;     genPlusIncr
	mov	a,#0x02
	add	a,@r0
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
	movx	a,@dptr
	mov	@r0,a
	inc	dptr
	movx	a,@dptr
	inc	r0
	mov	@r0,a
	inc	dptr
	movx	a,@dptr
	inc	r0
	mov	@r0,a
	inc	dptr
	movx	a,@dptr
	inc	r0
	mov	@r0,a
;     genIfx
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
	mov	a,@r0
	inc	r0
	orl	a,@r0
	inc	r0
	orl	a,@r0
	inc	r0
	orl	a,@r0
;     genIfxJump
	jnz	00154$
	ljmp	00113$
00154$:
;src/menu.c:1264: if (temp_long >= system_data.zone_settings[offset].start_time)
;     genCmpLt
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
;     genCmp
	clr	c
	mov	a,_temp_long
	subb	a,@r0
	mov	a,(_temp_long + 1)
	inc	r0
	subb	a,@r0
	mov	a,(_temp_long + 2)
	inc	r0
	subb	a,@r0
	mov	a,(_temp_long + 3)
	inc	r0
	subb	a,@r0
;     genIfxJump
	jnc	00155$
	ljmp	00110$
00155$:
;src/menu.c:1266: if(temp_long < system_data.zone_settings[offset].stop_time)
;     genIpush
	push	ar7
;     genPlus
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	a,#0x06
	add	a,@r0
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
;     genCmpLt
;     genCmp
	clr	c
	mov	a,_temp_long
	subb	a,r7
	mov	a,(_temp_long + 1)
	subb	a,r2
	mov	a,(_temp_long + 2)
	subb	a,r4
	mov	a,(_temp_long + 3)
	subb	a,r3
	clr	a
	rlc	a
;     genIpop
	pop	ar7
;     genIfx
;     genIfxJump
	jnz	00156$
	ljmp	00107$
00156$:
;src/menu.c:1268: if (system_data.temperatures[j] < system_data.zone_settings[offset].temperature*10 - histereza)
;     genIpush
	push	ar7
;     genPlus
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
	add	a,#(_system_data + 0x016c)
	mov	r2,a
;       Peephole 236.g  used r6 instead of ar6
	mov     a,r6
	addc	a,#((_system_data + 0x016c) >> 8)
	mov	r3,a
;     genPointerGet
;     genFarPointerGet
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
;     genAssign
	clr	a
	mov	(__mulint_PARM_2 + 1),a
	mov	__mulint_PARM_2,#0x0A
;     genCall
	mov	dpl,r4
	mov	dph,r7
	push	ar2
	push	ar3
	push	ar5
	push	ar6
	push	ar7
	lcall	__mulint
	push	acc
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
	pop	acc
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar3
	pop	ar2
;     genCast
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	ar4,@r0
	mov	r7,#0x00
;     genMinus
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
	mov	a,@r0
	clr	c
;       Peephole 236.l  used r4 instead of ar4
	subb    a,r4
	mov	r4,a
	inc	r0
	mov	a,@r0
;       Peephole 236.l  used r7 instead of ar7
	subb    a,r7
	mov	r7,a
;     genPointerGet
;     genFarPointerGet
	mov	dpl,r2
	mov	dph,r3
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
;     genCmpLt
;     genCmp
	clr	c
	mov	a,r2
	subb	a,r4
	mov	a,r3
	subb	a,r7
	clr	a
	rlc	a
;     genIpop
	pop	ar7
;     genIfx
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00104$
00157$:
;src/menu.c:1270: system_data.enabled[j] = CHANNEL_ENABLED;
;     genPlus
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
	inc	r0
	mov	a,@r0
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
	mov	a,#0x02
	movx	@dptr,a
;src/menu.c:1271: switch_zone_prepare(j, 1);
;     genIpush
	push	ar5
	push	ar6
	push	ar7
	mov	a,#0x01
	push	acc
;     genCall
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	dpl,@r0
	lcall	_switch_zone_prepare
	dec	sp
	pop	ar7
	pop	ar6
	pop	ar5
;src/menu.c:1272: histereza = 0;
;     genAssign
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	@r0,#0x00
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00105$
00104$:
;src/menu.c:1274: else if (system_data.temperatures[j] >= system_data.zone_settings[offset].temperature*10)
;     genPlus
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
	add	a,#(_system_data + 0x016c)
	mov	dpl,a
;       Peephole 236.g  used r6 instead of ar6
	mov     a,r6
	addc	a,#((_system_data + 0x016c) >> 8)
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
;     genCmpLt
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
;     genCmp
	clr	c
	mov	a,r2
	subb	a,@r0
	mov	a,r3
	inc	r0
	subb	a,@r0
;     genIfxJump
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 160    removed sjmp by inverse jump logic
	jc      00105$
00158$:
;src/menu.c:1276: system_data.enabled[j] = CHANNEL_DISABLED;
;     genPlus
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
	inc	r0
	mov	a,@r0
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
;       Peephole 181    changed mov to clr
	clr     a
	movx	@dptr,a
;src/menu.c:1277: switch_zone_prepare(j, 0);
;     genIpush
	push	ar5
	push	ar6
	push	ar7
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	dpl,@r0
	lcall	_switch_zone_prepare
	dec	sp
	pop	ar7
	pop	ar6
	pop	ar5
;src/menu.c:1278: histereza = 1;
;     genAssign
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	@r0,#0x01
00105$:
;src/menu.c:1281: i=ZONES_COUNT;
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,#0x09
	ljmp	00122$
00107$:
;src/menu.c:1285: system_data.enabled[j] = CHANNEL_DISABLED;
;     genPlus
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
	inc	r0
	mov	a,@r0
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
;       Peephole 181    changed mov to clr
	clr     a
	movx	@dptr,a
;src/menu.c:1286: switch_zone_prepare(j, 0);
;     genIpush
	push	ar5
	push	ar6
	push	ar7
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	dpl,@r0
	lcall	_switch_zone_prepare
	dec	sp
	pop	ar7
	pop	ar6
	pop	ar5
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00122$
00110$:
;src/menu.c:1291: system_data.enabled[j] = CHANNEL_DISABLED;
;     genPlus
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
	inc	r0
	mov	a,@r0
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
;       Peephole 181    changed mov to clr
	clr     a
	movx	@dptr,a
;src/menu.c:1292: switch_zone_prepare(j, 0);
;     genIpush
	push	ar5
	push	ar6
	push	ar7
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	dpl,@r0
	lcall	_switch_zone_prepare
	dec	sp
	pop	ar7
	pop	ar6
	pop	ar5
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00122$
00113$:
;src/menu.c:1297: system_data.enabled[j] = CHANNEL_DISABLED;
;     genPlus
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
	inc	r0
	mov	a,@r0
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
;       Peephole 181    changed mov to clr
	clr     a
	movx	@dptr,a
;src/menu.c:1298: switch_zone_prepare(j, 0);
;     genIpush
	push	ar5
	push	ar6
	push	ar7
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	dpl,@r0
	lcall	_switch_zone_prepare
	dec	sp
	pop	ar7
	pop	ar6
	pop	ar5
00122$:
;src/menu.c:1254: for (i = 0; i<ZONES_COUNT; i++)
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	inc	@r0
	ljmp	00120$
00126$:
;src/menu.c:1252: for (j = 0; j<CHANNELS_COUNT; j++)
;     genPlus
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
;     genPlusIncr
	inc	@r0
	ljmp	00124$
00127$:
;src/menu.c:1304: switch_zone(0);
;     genCall
	mov	dpl,#0x00
	lcall	_switch_zone
;src/menu.c:1305: switch_zone(1);
;     genCall
	mov	dpl,#0x01
	lcall	_switch_zone
;src/menu.c:1306: switch_zone(2);
;     genCall
	mov	dpl,#0x02
	lcall	_switch_zone
;src/menu.c:1307: switch_zone(3);
;     genCall
	mov	dpl,#0x03
	lcall	_switch_zone
00128$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'check_external_events'
;------------------------------------------------------------
;retval                    Allocated to registers 
;------------------------------------------------------------
;src/menu.c:1346: unsigned char check_external_events(void)
;	-----------------------------------------
;	 function check_external_events
;	-----------------------------------------
_check_external_events:
	push	_bp
	mov	_bp,sp
;src/menu.c:1351: if (current_display_state == SYSTEM_SETUP_POS)
;     genCmpEq
	mov	a,_current_display_state
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,#0x05,00102$
;00116$:
;       Peephole 200    removed redundant sjmp
00117$:
;src/menu.c:1353: display_stored_time(0,ASCTIME_FORMAT,false);
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,#0x00
	lcall	_display_stored_time
	dec	sp
	dec	sp
00102$:
;src/menu.c:1356: if (current_display_state == MAIN_STATE_POS)
;     genCmpEq
	mov	a,_current_display_state
;       Peephole 162    removed sjmp by inverse jump logic
	jz      00119$
00118$:
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00104$
00119$:
;src/menu.c:1358: display_stored_data((unsigned int*)system_data.temperatures,false);
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#(_system_data + 0x016c)
	mov	b,#0x01
	lcall	_display_stored_data
	dec	sp
;src/menu.c:1359: display_enabled_channels(false);
;     genCall
	mov	dpl,#0x00
	lcall	_display_enabled_channels
;src/menu.c:1360: display_stored_time(4,ASCTIME_SHORT_FORMAT,false);
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	mov	a,#0x03
	push	acc
;     genCall
	mov	dpl,#0x04
	lcall	_display_stored_time
	dec	sp
	dec	sp
00104$:
;src/menu.c:1365: if (current_display_state != DAY_SETUP_POS &&
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x39,00120$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00120$:
;src/menu.c:1366: current_display_state != TIME_SETUP_POS &&
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x37,00121$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00121$:
;src/menu.c:1367: current_display_state != DATE_SETUP_POS )
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x36,00122$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00122$:
;src/menu.c:1369: control_workloop();
;     genCall
	lcall	_control_workloop
00106$:
;src/menu.c:1372: return retval;
;     genRet
	mov	dpl,#0x00
00109$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'menu_previous_position'
;------------------------------------------------------------
;------------------------------------------------------------
;src/menu.c:1375: void menu_previous_position()
;	-----------------------------------------
;	 function menu_previous_position
;	-----------------------------------------
_menu_previous_position:
	push	_bp
	mov	_bp,sp
;src/menu.c:1377: current_display_state = menu[current_display_state].item[current_position].previous;
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r2,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r3,a
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
;     genMult
;     genMultOneByte
	mov	a,_current_position
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
	mov	a,b
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	_current_display_state,a
;src/menu.c:1378: current_position = stack_pop_front();
;     genCall
	lcall	_stack_pop_front
	mov	_current_position,dpl
00101$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'reset_workloop'
;------------------------------------------------------------
;value                     Allocated to registers r2 r3 r4 r5 
;exit                      Allocated to registers r6 
;result                    Allocated to registers r4 r5 
;------------------------------------------------------------
;src/menu.c:1392: unsigned long reset_workloop(const unsigned long value)
;	-----------------------------------------
;	 function reset_workloop
;	-----------------------------------------
_reset_workloop:
	push	_bp
	mov	_bp,sp
;     genReceive
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;src/menu.c:1394: unsigned char exit = 0;
;     genAssign
	mov	r6,#0x00
;src/menu.c:1397: BLINKING_OFF;
;     genAssign
	mov	_blinking,#0x00
;src/menu.c:1398: result = value;
;     genCast
;     genAssign
	mov	ar4,r2
	mov	ar5,r3
;src/menu.c:1400: while(exit == 0)
;     genAssign
00107$:
;     genCmpEq
	cjne	r6,#0x00,00117$
	sjmp	00118$
00117$:
	ljmp	00109$
00118$:
;src/menu.c:1405: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/menu.c:1406: exit = check_external_events();
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_check_external_events
	mov	r7,dpl
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genAssign
	mov	ar6,r7
;src/menu.c:1407: if (exit == 0)
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    r6,#0x00,00107$
;00119$:
;       Peephole 200    removed redundant sjmp
00120$:
;src/menu.c:1409: if (keypad_check_front() == DATA_AVAILABLE)
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_keypad_check_front
	mov	r7,dpl
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    r7,#0x91,00107$
;00121$:
;       Peephole 200    removed redundant sjmp
00122$:
;src/menu.c:1411: key_code = keypad_pop_front();
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_keypad_pop_front
	mov	_key_code,dpl
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:1414: switch (key_code)
;     genCmpEq
	mov	a,_key_code
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,#0x13,00102$
;00123$:
;       Peephole 200    removed redundant sjmp
00124$:
;src/menu.c:1417: result = value;
;     genAssign
	mov	ar4,r2
	mov	ar5,r3
;src/menu.c:1418: exit = 1;
;     genAssign
	mov	r6,#0x01
;src/menu.c:1420: }
00102$:
;src/menu.c:1421: keypad_purge_buffer();
;     genCall
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_keypad_purge_buffer
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	ljmp	00107$
00109$:
;src/menu.c:1426: menu_previous_position();
;     genCall
	push	ar4
	push	ar5
	lcall	_menu_previous_position
	pop	ar5
	pop	ar4
;src/menu.c:1429: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
;     genIpush
	push	ar4
	push	ar5
	push	_current_display_state
;     genCall
	mov	dpl,#0x00
	lcall	_ds1302_write_memory
	dec	sp
	pop	ar5
	pop	ar4
;src/menu.c:1431: return result;
;     genCast
	mov	r2,#0x00
	mov	r3,#0x00
;     genRet
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
00110$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'keypad_test_workloop'
;------------------------------------------------------------
;------------------------------------------------------------
;src/menu.c:1442: void keypad_test_workloop()
;	-----------------------------------------
;	 function keypad_test_workloop
;	-----------------------------------------
_keypad_test_workloop:
	push	_bp
	mov	_bp,sp
;src/menu.c:1444: BLINKING_OFF;
;     genAssign
	mov	_blinking,#0x00
;src/menu.c:1445: lcd_clear();
;     genCall
	lcall	_lcd_clear
;src/menu.c:1446: printf_fast("Test klawiatury, nacisnij dowolny klawisz ...");
;     genIpush
	mov	a,#__str_14
	push	acc
	mov	a,#(__str_14 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
;src/menu.c:1448: while(1)
00104$:
;src/menu.c:1450: if (keypad_check_front() == DATA_AVAILABLE)
;     genCall
	lcall	_keypad_check_front
	mov	r2,dpl
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    r2,#0x91,00102$
;00110$:
;       Peephole 200    removed redundant sjmp
00111$:
;src/menu.c:1452: key_code = keypad_pop_front();
;     genCall
	lcall	_keypad_pop_front
	mov	_key_code,dpl
;src/menu.c:1453: lcd_goto_xy(0,0);
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,#0x00
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1454: printf_fast("Nacisnieto klawisz o kodzie: (%x)               ", key_code);
;     genCast
	mov	r2,_key_code
	mov	r3,#0x00
;     genIpush
	push	ar2
	push	ar3
;     genIpush
	mov	a,#__str_15
	push	acc
	mov	a,#(__str_15 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
00102$:
;src/menu.c:1456: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00104$
00106$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'weekday_worklop'
;------------------------------------------------------------
;value                     Allocated to stack - offset 1
;display                   Allocated to stack - offset 3
;exit                      Allocated to stack - offset 6
;result                    Allocated to stack - offset 7
;------------------------------------------------------------
;src/menu.c:1460: unsigned int weekday_worklop(const unsigned int value)
;	-----------------------------------------
;	 function weekday_worklop
;	-----------------------------------------
_weekday_worklop:
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
;src/menu.c:1463: unsigned char exit = 0;
;     genAssign
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
;src/menu.c:1466: BLINKING_OFF;
;     genAssign
;src/menu.c:1467: result = value;
;     genAssign
;       Peephole 3.c    changed mov to clr
	clr     a
	mov     @r0,a
	mov     _blinking,a
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,_bp
	add	a,#0x07
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
;src/menu.c:1469: display = menu[current_display_state].item[current_position].display;
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r7,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r4,a
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r7 instead of ar7
	add     a,r7
	mov	r7,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genMult
;     genMultOneByte
	mov	a,_current_position
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r7 instead of ar7
	add     a,r7
	mov	r7,a
	mov	a,b
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r7 instead of ar7
	add     a,r7
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
	mov	r3,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r4,a
;     genAssign
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
;src/menu.c:1471: lcd_goto_xy(display->x, display->y+1);
;     genPlus
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	r3,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r5,a
	inc	r0
	mov	ar6,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r3
	mov	dph,r5
	mov	b,r6
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r3,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r5,a
;     genIpush
	push	ar3
;     genCall
	mov	dpl,r5
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1472: printf_day(value);
;     genCast
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	dpl,@r0
;     genCall
	lcall	_printf_day
;src/menu.c:1474: while(exit == 0)
;     genPlus
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	r3,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r5,a
	inc	r0
	mov	ar6,@r0
00115$:
;     genCmpEq
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	cjne	@r0,#0x00,00130$
	sjmp	00131$
00130$:
	ljmp	00117$
00131$:
;src/menu.c:1476: SERVICE_WATCHDOG;
;     genIpush
	push	ar3
	push	ar5
	push	ar6
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/menu.c:1477: if (keypad_check_front() == DATA_AVAILABLE)
;     genCall
	push	ar5
	push	ar6
	lcall	_keypad_check_front
	mov	r3,dpl
	pop	ar6
	pop	ar5
;     genCmpEq
;       Peephole 241.c  optimized compare
	clr     a
	cjne    r3,#0x91,00132$
	inc     a
00132$:
00133$:
;     genIpop
	pop	ar6
	pop	ar5
	pop	ar3
;     genIfx
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00115$
00134$:
;src/menu.c:1479: key_code = keypad_pop_front();
;     genCall
	push	ar3
	push	ar5
	push	ar6
	lcall	_keypad_pop_front
	mov	_key_code,dpl
	pop	ar6
	pop	ar5
	pop	ar3
;src/menu.c:1480: if (exit == 1)
;     genCmpEq
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    @r0,#0x01,00102$
;00135$:
;       Peephole 200    removed redundant sjmp
00136$:
;src/menu.c:1482: result = value;
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,_bp
	add	a,#0x07
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
00102$:
;src/menu.c:1485: switch (key_code)
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x10,00137$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00107$
00137$:
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x11,00138$
	ljmp	00111$
00138$:
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x13,00139$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00104$
00139$:
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x14,00140$
	sjmp	00141$
00140$:
	ljmp	00112$
00141$:
;src/menu.c:1488: exit = 1;
;     genAssign
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	@r0,#0x01
;src/menu.c:1489: break;
	ljmp	00112$
;src/menu.c:1492: result = value;
00104$:
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,_bp
	add	a,#0x07
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
;src/menu.c:1493: exit = 1;
;     genAssign
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	@r0,#0x01
;src/menu.c:1494: break;
	ljmp	00112$
;src/menu.c:1499: lcd_goto_xy(display->x, display->y+1);
00107$:
;src/menu.c:1497: if (++result > 7)
;     genPlus
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	@r0,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	@r0,a
;     genCmpGt
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
;     genCmp
	clr	c
	mov	a,#0x07
	subb	a,@r0
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	subb	a,@r0
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00106$
00142$:
;src/menu.c:1498: result = 1;
;     genAssign
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
	clr	a
	inc	r0
	mov	@r0,a
	dec	r0
	mov	@r0,#0x01
00106$:
;src/menu.c:1499: lcd_goto_xy(display->x, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r3
	mov	dph,r5
	mov	b,r6
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r2,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r4,a
;     genIpush
	push	ar3
	push	ar5
	push	ar6
	push	ar2
;     genCall
	mov	dpl,r4
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar6
	pop	ar5
	pop	ar3
;src/menu.c:1500: printf_day(result);
;     genCast
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
	mov	dpl,@r0
;     genCall
	push	ar3
	push	ar5
	push	ar6
	lcall	_printf_day
	pop	ar6
	pop	ar5
	pop	ar3
;src/menu.c:1501: break;
;src/menu.c:1507: result--;
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00112$
00111$:
;src/menu.c:1504: if (result == 1)
;     genCmpEq
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 197.c  optimized misc jump sequence
	cjne    @r0,#0x01,00109$
	inc     r0
	cjne    @r0,#0x00,00109$
;00143$:
;       Peephole 200    removed redundant sjmp
00144$:
;src/menu.c:1505: result = 7;
;     genAssign
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
	clr	a
	inc	r0
	mov	@r0,a
	dec	r0
	mov	@r0,#0x07
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00110$
00109$:
;src/menu.c:1507: result--;
;     genMinus
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
;     genMinusDec
	mov	a,@r0
	add	a,#0xff
	mov	@r0,a
	inc	r0
	mov	a,@r0
	addc	a,#0xff
	mov	@r0,a
00110$:
;src/menu.c:1508: lcd_goto_xy(display->x, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r3
	mov	dph,r5
	mov	b,r6
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r2,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r4,a
;     genIpush
	push	ar3
	push	ar5
	push	ar6
	push	ar2
;     genCall
	mov	dpl,r4
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar6
	pop	ar5
	pop	ar3
;src/menu.c:1509: printf_day(result);
;     genCast
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
	mov	dpl,@r0
;     genCall
	push	ar3
	push	ar5
	push	ar6
	lcall	_printf_day
	pop	ar6
	pop	ar5
	pop	ar3
;src/menu.c:1511: }
00112$:
;src/menu.c:1512: keypad_purge_buffer();
;     genCall
	push	ar3
	push	ar5
	push	ar6
	lcall	_keypad_purge_buffer
	pop	ar6
	pop	ar5
	pop	ar3
	ljmp	00115$
00117$:
;src/menu.c:1516: ds1302_read_rtc_bcd(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	lcall	_ds1302_read_rtc_bcd
;src/menu.c:1517: system_time.tm_wday = result;
;     genCast
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
	mov	ar2,@r0
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0007)
	mov	a,r2
	movx	@dptr,a
;src/menu.c:1518: ds1302_write_rtc(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	lcall	_ds1302_write_rtc
;src/menu.c:1520: menu_previous_position();
;     genCall
	lcall	_menu_previous_position
;src/menu.c:1521: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
;     genIpush
	push	_current_display_state
;     genCall
	mov	dpl,#0x00
	lcall	_ds1302_write_memory
	dec	sp
;src/menu.c:1523: return result;
;     genRet
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
00118$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'read_keyboard_data_workloop'
;------------------------------------------------------------
;value                     Allocated to stack - offset -4
;point                     Allocated to stack - offset -5
;isBCD                     Allocated to stack - offset -6
;size                      Allocated to registers r5 
;count                     Allocated to stack - offset 1
;j                         Allocated to stack - offset 2
;exit                      Allocated to registers r2 
;result                    Allocated to stack - offset 3
;sloc0                     Allocated to stack - offset 5
;sloc1                     Allocated to stack - offset 6
;------------------------------------------------------------
;src/menu.c:1527: unsigned int read_keyboard_data_workloop(unsigned char size, const unsigned int value, const char point, const boolean isBCD)
;	-----------------------------------------
;	 function read_keyboard_data_workloop
;	-----------------------------------------
_read_keyboard_data_workloop:
	push	_bp
	mov	_bp,sp
	mov	a,sp
	add	a,#0x06
	mov	sp,a
;     genReceive
	mov	r5,dpl
;src/menu.c:1532: count = 1;
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,#0x01
;src/menu.c:1533: result = 0;
;     genAssign
	mov	a,_bp
	add	a,#0x03
;       Peephole 216    simplified clear (2bytes)
	mov     r0,a
	clr     a
	mov     @r0,a
	inc     r0
	mov     @r0,a
;src/menu.c:1535: while(count <= size)
;     genCmpEq
	mov	a,_bp
	add	a,#0xfa
	mov	r0,a
;       Peephole 241.f  optimized compare
	clr     a
	cjne    @r0,#0x00,00144$
	inc     a
00144$:
00145$:
	mov	r6,a
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r7,a
;     genAssign
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	@r0,ar7
;     genAssign
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	@r0,ar7
00122$:
;     genCmpGt
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genCmp
	clr	c
	mov	a,r5
	subb	a,@r0
;     genIfxJump
	jnc	00146$
	ljmp	00124$
00146$:
;src/menu.c:1537: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/menu.c:1541: exit = check_external_events();
;     genCall
	push	ar5
	push	ar6
	push	ar7
	lcall	_check_external_events
	mov	r2,dpl
	pop	ar7
	pop	ar6
	pop	ar5
;     genAssign
;src/menu.c:1542: if (exit == 0)
;     genCmpEq
	cjne	r2,#0x00,00147$
	sjmp	00148$
00147$:
	ljmp	00120$
00148$:
;src/menu.c:1544: SERVICE_WATCHDOG;
;     genIpush
	push	ar7
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/menu.c:1545: if (keypad_check_front() == DATA_AVAILABLE)
;     genCall
	push	ar5
	push	ar6
	lcall	_keypad_check_front
	mov	r7,dpl
	pop	ar6
	pop	ar5
;     genCmpEq
;       Peephole 241.c  optimized compare
	clr     a
	cjne    r7,#0x91,00149$
	inc     a
00149$:
00150$:
;     genIpop
	pop	ar7
;     genIfx
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00122$
00151$:
;src/menu.c:1547: key_code = keypad_pop_front();
;     genCall
	push	ar5
	push	ar6
	push	ar7
	lcall	_keypad_pop_front
	mov	_key_code,dpl
	pop	ar7
	pop	ar6
	pop	ar5
;src/menu.c:1555: if (key_code >=0 && key_code < 10)
;     genCmpLt
;     genCmp
	clr	c
;     genIfxJump
	jnc	00152$
	ljmp	00114$
00152$:
;     genCmpLt
;     genCmp
	clr	c
	mov	a,_key_code
	subb	a,#0x0A
;     genIfxJump
	jc	00153$
	ljmp	00114$
00153$:
;src/menu.c:1557: if (count == point)
;     genCmpEq
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,_bp
	add	a,#0xfb
	mov	r1,a
	mov	b,@r0
	mov	a,@r1
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,b,00102$
;00154$:
;       Peephole 200    removed redundant sjmp
00155$:
;src/menu.c:1559: printf_fast("%d.",key_code);
;     genIpush
	push	ar7
;     genCast
	mov	r7,_key_code
	mov	r2,#0x00
;     genIpush
	push	ar5
	push	ar6
	push	ar7
	push	ar7
	push	ar2
;     genIpush
	mov	a,#__str_16
	push	acc
	mov	a,#(__str_16 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
;     genIpop
	pop	ar7
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00103$
00102$:
;src/menu.c:1563: printf_fast("%d", key_code);
;     genIpush
	push	ar7
;     genCast
	mov	r2,_key_code
	mov	r7,#0x00
;     genIpush
	push	ar5
	push	ar6
	push	ar7
	push	ar2
	push	ar7
;     genIpush
	mov	a,#__str_17
	push	acc
	mov	a,#(__str_17 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
;src/menu.c:1614: return result;
;     genIpop
	pop	ar7
;src/menu.c:1563: printf_fast("%d", key_code);
00103$:
;src/menu.c:1566: if (isBCD == false)
;     genIfx
	mov	a,r6
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00105$
00156$:
;src/menu.c:1568: result *= 10;
;     genIpush
	push	ar7
;     genAssign
	clr	a
	mov	(__mulint_PARM_2 + 1),a
	mov	__mulint_PARM_2,#0x0A
;     genCall
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	push	ar5
	push	ar6
	lcall	__mulint
	mov	r2,dpl
	mov	r7,dph
	pop	ar6
	pop	ar5
;     genAssign
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar7
;src/menu.c:1569: result += key_code;
;     genCast
	mov	r2,_key_code
	mov	r7,#0x00
;     genPlus
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
	add	a,@r0
	mov	@r0,a
;       Peephole 236.g  used r7 instead of ar7
	mov     a,r7
	inc	r0
	addc	a,@r0
	mov	@r0,a
;     genIpop
	pop	ar7
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00105$:
;src/menu.c:1573: result <<= 4;
;     genLeftShift
;     genLeftShiftLiteral
	mov	a,_bp
	add	a,#0x03
;     genlshTwo
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r0,a
	mov	a,@r0
	dec	r0
	swap	a
	anl	a,#0xf0
	xch	a,@r0
	swap	a
	xch	a,@r0
	xrl	a,@r0
	xch	a,@r0
	anl	a,#0xf0
	xch	a,@r0
	xrl	a,@r0
	inc	r0
	mov	@r0,a
;src/menu.c:1574: result |= key_code;
;     genCast
	mov	r2,_key_code
	mov	r3,#0x00
;     genOr
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	a,r2
	orl	a,@r0
	mov	@r0,a
	mov	a,r3
	inc	r0
	orl	a,@r0
	mov	@r0,a
00106$:
;src/menu.c:1577: count++;
;     genPlus
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genPlusIncr
	inc	@r0
	ljmp	00115$
00114$:
;src/menu.c:1581: switch (key_code)
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x13,00157$
	ljmp	00111$
00157$:
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x14,00158$
	sjmp	00159$
00158$:
	ljmp	00115$
00159$:
;src/menu.c:1584: for (j=0; j<=(size-count);j++)
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,#0x00
00125$:
;     genIpush
	push	ar7
;     genCast
	mov	ar3,r5
	mov	r7,#0x00
;     genCast
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	ar2,@r0
	mov	r4,#0x00
;     genMinus
	mov	a,r3
	clr	c
;       Peephole 236.l  used r2 instead of ar2
	subb    a,r2
	mov	r3,a
	mov	a,r7
;       Peephole 236.l  used r4 instead of ar4
	subb    a,r4
	mov	r7,a
;     genCast
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	ar2,@r0
	mov	r4,#0x00
;     genCmpGt
;     genCmp
	clr	c
	mov	a,r3
	subb	a,r2
	mov	a,r7
	xrl	a,#0x80
	mov	b,r4
	xrl	b,#0x80
	subb	a,b
	clr	a
	rlc	a
;     genIpop
	pop	ar7
;     genIfx
;     genIfxJump
;       Peephole 109    removed ljmp by inverse jump logic
	jnz     00128$
00160$:
;src/menu.c:1586: if (isBCD == false)
;     genIfx
	mov	a,r6
;     genIfxJump
;       Peephole 110    removed ljmp by inverse jump logic
	jz      00108$
00161$:
;src/menu.c:1588: result *= 10;
;     genAssign
	clr	a
	mov	(__mulint_PARM_2 + 1),a
	mov	__mulint_PARM_2,#0x0A
;     genCall
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	push	ar5
	push	ar6
	push	ar7
	lcall	__mulint
	mov	r2,dpl
	mov	r3,dph
	pop	ar7
	pop	ar6
	pop	ar5
;     genAssign
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00127$
00108$:
;src/menu.c:1592: result <<= 4;
;     genLeftShift
;     genLeftShiftLiteral
	mov	a,_bp
	add	a,#0x03
;     genlshTwo
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r0,a
	mov	a,@r0
	dec	r0
	swap	a
	anl	a,#0xf0
	xch	a,@r0
	swap	a
	xch	a,@r0
	xrl	a,@r0
	xch	a,@r0
	anl	a,#0xf0
	xch	a,@r0
	xrl	a,@r0
	inc	r0
	mov	@r0,a
00127$:
;src/menu.c:1584: for (j=0; j<=(size-count);j++)
;     genPlus
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
;     genPlusIncr
	inc	@r0
	ljmp	00125$
00128$:
;src/menu.c:1595: count = size+1;
;     genAssign
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
;       Peephole 212    reduced add sequence to inc
	mov     r1,_bp
	inc     r1
	mov	a,@r0
	mov	@r1,a
;src/menu.c:1596: break;
;src/menu.c:1599: count = size+1;
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00115$
00111$:
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar7
;src/menu.c:1600: result = value;
;     genAssign
	mov	a,_bp
	add	a,#0xfc
	mov	r0,a
	mov	a,_bp
	add	a,#0x03
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
;src/menu.c:1602: }
00115$:
;src/menu.c:1604: keypad_purge_buffer();
;     genCall
	push	ar5
	push	ar6
	push	ar7
	lcall	_keypad_purge_buffer
	pop	ar7
	pop	ar6
	pop	ar5
	ljmp	00122$
00120$:
;src/menu.c:1609: result = value;
;     genAssign
	mov	a,_bp
	add	a,#0xfc
	mov	r0,a
	mov	a,_bp
	add	a,#0x03
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
;src/menu.c:1610: count = size+1;
;     genAssign
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
;       Peephole 212    reduced add sequence to inc
	mov     r1,_bp
	inc     r1
	mov	a,@r0
	mov	@r1,a
	ljmp	00122$
00124$:
;src/menu.c:1614: return result;
;     genRet
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
00129$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'zone_workloop'
;------------------------------------------------------------
;zone                      Allocated to stack - offset 1
;result                    Allocated to stack - offset 2
;mins                      Allocated to stack - offset 4
;hours                     Allocated to stack - offset 5
;flash                     Allocated to registers r2 r3 r4 
;xram                      Allocated to stack - offset 6
;count                     Allocated to stack - offset 9
;display                   Allocated to stack - offset 10
;sloc0                     Allocated to stack - offset 16
;sloc1                     Allocated to stack - offset 13
;sloc2                     Allocated to stack - offset 16
;------------------------------------------------------------
;src/menu.c:1617: void zone_workloop(const unsigned char zone)
;	-----------------------------------------
;	 function zone_workloop
;	-----------------------------------------
_zone_workloop:
	push	_bp
	mov	_bp,sp
	mov	a,sp
	add	a,#0x11
	mov	sp,a
;     genReceive
	push	acc
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	pop	acc
	mov	@r0,dpl
;src/menu.c:1620: unsigned char mins = 0;
;     genAssign
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	@r0,#0x00
;src/menu.c:1621: unsigned char hours = 0;
;     genAssign
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
;src/menu.c:1629: BLINKING_OFF;
;     genAssign
;src/menu.c:1631: display = menu[current_display_state].item[current_position].display;
;     genMult
;     genMultOneByte
;       Peephole 3.c    changed mov to clr
	clr     a
	mov     @r0,a
	mov     _blinking,a
	mov     a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r5,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r6,a
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	r6,a
;     genMult
;     genMultOneByte
	mov	a,_current_position
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r5,a
	mov	a,b
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	r6,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r5,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r6,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r7,a
;     genAssign
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	@r0,ar5
	inc	r0
	mov	@r0,ar6
	inc	r0
	mov	@r0,ar7
;src/menu.c:1632: lcd_cursor_on();
;     genCall
	lcall	_lcd_cursor_on
;src/menu.c:1634: lcd_goto_xy(display->x, 0);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r4,a
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,r4
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1635: local_gmtime(&system_data.zone_settings[zone].start_time);
;     genMult
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genMultOneByte
	mov	a,@r0
	mov	b,#0x0A
	mul	ab
	mov	r4,a
	mov	r3,b
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#_system_data
	mov	r2,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	r5,a
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	r5,a
;     genCast
	mov	r6,#0x1
;     genCall
	mov	dpl,r2
	mov	dph,r5
	mov	b,r6
	push	ar3
	push	ar4
	lcall	_local_gmtime
	pop	ar4
	pop	ar3
;src/menu.c:1638: (unsigned int)system_time.tm_min);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
	mov	r2,a
;     genCast
	mov	r5,#0x00
;src/menu.c:1637: (unsigned int)system_time.tm_hour,
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r6,a
;     genCast
	mov	r7,#0x00
;src/menu.c:1636: printf_fast("%02u:%02u", 
;     genIpush
	push	ar3
	push	ar4
	push	ar2
	push	ar5
;     genIpush
	push	ar6
	push	ar7
;     genIpush
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar4
	pop	ar3
;src/menu.c:1640: printf_fast("-");
;     genIpush
	push	ar3
	push	ar4
	mov	a,#__str_6
	push	acc
	mov	a,#(__str_6 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	dec	sp
	dec	sp
	pop	ar4
	pop	ar3
;src/menu.c:1642: local_gmtime(&system_data.zone_settings[zone].stop_time);         
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#_system_data
	mov	r2,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	r5,a
;     genPlus
	mov	a,#0x06
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	r5,a
;     genCast
	mov	r6,#0x1
;     genCall
	mov	dpl,r2
	mov	dph,r5
	mov	b,r6
	push	ar3
	push	ar4
	lcall	_local_gmtime
	pop	ar4
	pop	ar3
;src/menu.c:1645: (unsigned int)system_time.tm_min);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
	mov	r2,a
;     genCast
	mov	r5,#0x00
;src/menu.c:1644: (unsigned int)system_time.tm_hour,
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r6,a
;     genCast
	mov	r7,#0x00
;src/menu.c:1643: printf_fast("%02u:%02u", 
;     genIpush
	push	ar3
	push	ar4
	push	ar2
	push	ar5
;     genIpush
	push	ar6
	push	ar7
;     genIpush
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar4
	pop	ar3
;src/menu.c:1647: lcd_goto_xy(display->x+21, 0);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r2,a
;     genPlus
	mov	a,#0x15
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;     genIpush
	push	ar3
	push	ar4
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
;src/menu.c:1648: printf_fast("%02u",system_data.zone_settings[zone].temperature);
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#_system_data
	mov	dpl,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
;     genIpush
	push	ar3
	push	ar4
	push	ar2
	push	ar5
;     genIpush
	mov	a,#__str_7
	push	acc
	mov	a,#(__str_7 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
;src/menu.c:1650: lcd_goto_xy(display->x, display->y+1);
;     genPlus
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	a,_bp
	add	a,#0x0d
	mov	r1,a
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	@r1,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	inc	r1
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0d
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r7,a
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r7 instead of ar7
	add     a,r7
	mov	r2,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r7,a
;     genIpush
	push	ar3
	push	ar4
	push	ar2
;     genCall
	mov	dpl,r7
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
;src/menu.c:1651: result = read_keyboard_data_workloop(2,0x99,0,false);
;     genIpush
	push	ar3
	push	ar4
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	mov	a,#0x99
	push	acc
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,#0x02
	lcall	_read_keyboard_data_workloop
	mov	r2,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar5
;src/menu.c:1652: if (result != 0x99)
;     genCmpEq
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	cjne	@r0,#0x99,00143$
	inc	r0
	cjne	@r0,#0x00,00143$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00104$
00143$:
;src/menu.c:1654: if (result <= 0x23)
;     genCmpGt
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
;     genCmp
	clr	c
	mov	a,#0x23
	subb	a,@r0
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	subb	a,@r0
;     genIfxJump
	jnc	00144$
	ljmp	00105$
00144$:
;src/menu.c:1656: hours = (unsigned char)result&0xff;
;     genCast
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	a,_bp
	add	a,#0x05
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	ljmp	00105$
00104$:
;src/menu.c:1661: lcd_goto_xy(display->x, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0d
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r5,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r6,a
;     genIpush
	push	ar3
	push	ar4
	push	ar5
;     genCall
	mov	dpl,r6
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
;src/menu.c:1662: local_gmtime(&system_data.zone_settings[zone].start_time);
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#_system_data
	mov	r5,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	r6,a
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	r6,a
;     genIpush
	push	ar4
	push	ar3
;     genCast
	mov	r3,#0x1
;     genCall
	mov	dpl,r5
	mov	dph,r6
	mov	b,r3
	push	ar3
	push	ar4
	lcall	_local_gmtime
	pop	ar4
	pop	ar3
;src/menu.c:1663: printf_fast("%02u", (unsigned int)system_time.tm_hour);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r3,a
;     genCast
	mov	r4,#0x00
;     genIpush
	push	ar3
	push	ar4
	push	ar3
	push	ar4
;     genIpush
	mov	a,#__str_7
	push	acc
	mov	a,#(__str_7 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
;src/menu.c:1665: hours = system_time.tm_hour;
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r3,a
;     genAssign
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	@r0,ar3
;src/menu.c:1767: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
;     genIpop
	pop	ar3
	pop	ar4
;src/menu.c:1665: hours = system_time.tm_hour;
00105$:
;src/menu.c:1668: lcd_goto_xy(display->x+3, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0d
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r5,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r6,a
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r6 instead of ar6
	add     a,r6
	mov	dpl,a
;     genIpush
	push	ar3
	push	ar4
	push	ar5
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
;src/menu.c:1669: result = read_keyboard_data_workloop(2,0x99,0,false);
;     genIpush
	push	ar3
	push	ar4
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	mov	a,#0x99
	push	acc
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,#0x02
	lcall	_read_keyboard_data_workloop
	mov	r5,dpl
	mov	r6,dph
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,ar5
	inc	r0
	mov	@r0,ar6
;src/menu.c:1670: if (result != 0x99)
;     genCmpEq
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	cjne	@r0,#0x99,00145$
	inc	r0
	cjne	@r0,#0x00,00145$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00109$
00145$:
;src/menu.c:1672: if (result <= 0x59)
;     genCmpGt
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
;     genCmp
	clr	c
	mov	a,#0x59
	subb	a,@r0
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	subb	a,@r0
;     genIfxJump
	jnc	00146$
	ljmp	00110$
00146$:
;src/menu.c:1674: mins = (unsigned char)result&0xff;
;     genCast
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	a,_bp
	add	a,#0x04
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	ljmp	00110$
00109$:
;src/menu.c:1679: lcd_goto_xy(display->x+3, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0d
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r5,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r6,a
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r6 instead of ar6
	add     a,r6
	mov	dpl,a
;     genIpush
	push	ar3
	push	ar4
	push	ar5
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
;src/menu.c:1680: local_gmtime(&system_data.zone_settings[zone].start_time);         
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#_system_data
	mov	r5,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	r6,a
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	r6,a
;     genIpush
	push	ar4
	push	ar3
;     genCast
	mov	r3,#0x1
;     genCall
	mov	dpl,r5
	mov	dph,r6
	mov	b,r3
	push	ar3
	push	ar4
	lcall	_local_gmtime
	pop	ar4
	pop	ar3
;src/menu.c:1681: printf_fast("%02u", (unsigned int)system_time.tm_min);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
	mov	r3,a
;     genCast
	mov	r4,#0x00
;     genIpush
	push	ar3
	push	ar4
	push	ar3
	push	ar4
;     genIpush
	mov	a,#__str_7
	push	acc
	mov	a,#(__str_7 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
;src/menu.c:1683: mins = system_time.tm_min;
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
	mov	r3,a
;     genAssign
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	@r0,ar3
;src/menu.c:1767: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
;     genIpop
	pop	ar3
	pop	ar4
;src/menu.c:1683: mins = system_time.tm_min;
00110$:
;src/menu.c:1687: temp_long = hours;
;     genCast
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	_temp_long,@r0
	mov	(_temp_long + 1),#0x00
	mov	(_temp_long + 2),#0x00
	mov	(_temp_long + 3),#0x00
;src/menu.c:1688: temp_long *= 3600;
;     genAssign
	mov	__mullong_PARM_2,#0x10
	mov	(__mullong_PARM_2 + 1),#0x0E
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
;     genCall
	mov	dpl,_temp_long
	mov	dph,(_temp_long + 1)
	mov	b,(_temp_long + 2)
	mov	a,(_temp_long + 3)
	push	ar3
	push	ar4
	lcall	__mullong
	mov	_temp_long,dpl
	mov	(_temp_long + 1),dph
	mov	(_temp_long + 2),b
	mov	(_temp_long + 3),a
	pop	ar4
	pop	ar3
;src/menu.c:1690: result = mins * 60;  
;     genMult
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,_bp
	add	a,#0x02
	mov	r1,a
;     genMultOneByte
	mov	a,@r0
	mov	b,#0x3C
	mul	ab
	mov	@r1,a
	inc	r1
	mov	@r1,b
;src/menu.c:1691: temp_long += result;
;     genCast
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	ar5,@r0
	inc	r0
	mov	ar6,@r0
;     genPlus
;       Peephole 3.c    changed mov to clr
	clr     a
	mov     r2,a
	mov     r7,a
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
	add	a,_temp_long
	mov	_temp_long,a
;       Peephole 236.g  used r6 instead of ar6
	mov     a,r6
	addc	a,(_temp_long + 1)
	mov	(_temp_long + 1),a
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
	addc	a,(_temp_long + 2)
	mov	(_temp_long + 2),a
;       Peephole 236.g  used r7 instead of ar7
	mov     a,r7
	addc	a,(_temp_long + 3)
	mov	(_temp_long + 3),a
;src/menu.c:1693: system_data.zone_settings[zone].start_time = temp_long;
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#_system_data
	mov	r2,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	r5,a
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
	mov	a,_temp_long
	movx	@dptr,a
	inc	dptr
	mov	a,(_temp_long + 1)
	movx	@dptr,a
	inc	dptr
	mov	a,(_temp_long + 2)
	movx	@dptr,a
	inc	dptr
	mov	a,(_temp_long + 3)
	movx	@dptr,a
;src/menu.c:1695: lcd_goto_xy(display->x+6, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0d
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r2,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r5,a
;     genPlus
	mov	a,#0x06
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	dpl,a
;     genIpush
	push	ar3
	push	ar4
	push	ar2
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
;src/menu.c:1696: result = read_keyboard_data_workloop(2,0x99,0,false);
;     genIpush
	push	ar3
	push	ar4
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	mov	a,#0x99
	push	acc
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,#0x02
	lcall	_read_keyboard_data_workloop
	mov	r2,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar5
;src/menu.c:1697: if (result != 0x99)
;     genCmpEq
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	cjne	@r0,#0x99,00147$
	inc	r0
	cjne	@r0,#0x00,00147$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00114$
00147$:
;src/menu.c:1699: if (result <= 0x23)
;     genCmpGt
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
;     genCmp
	clr	c
	mov	a,#0x23
	subb	a,@r0
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	subb	a,@r0
;     genIfxJump
	jnc	00148$
	ljmp	00115$
00148$:
;src/menu.c:1701: hours = (unsigned char)result&0xff;
;     genCast
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	a,_bp
	add	a,#0x05
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	ljmp	00115$
00114$:
;src/menu.c:1706: lcd_goto_xy(display->x+6, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0d
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r2,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r5,a
;     genPlus
	mov	a,#0x06
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	dpl,a
;     genIpush
	push	ar3
	push	ar4
	push	ar2
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
;src/menu.c:1707: local_gmtime(&system_data.zone_settings[zone].stop_time);
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#_system_data
	mov	r2,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	r5,a
;     genPlus
	mov	a,#0x06
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	r5,a
;     genCast
	mov	r6,#0x1
;     genCall
	mov	dpl,r2
	mov	dph,r5
	mov	b,r6
	push	ar3
	push	ar4
	lcall	_local_gmtime
	pop	ar4
	pop	ar3
;src/menu.c:1708: printf_fast("%02u", (unsigned int)system_time.tm_hour);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r2,a
;     genCast
	mov	r5,#0x00
;     genIpush
	push	ar3
	push	ar4
	push	ar2
	push	ar5
;     genIpush
	mov	a,#__str_7
	push	acc
	mov	a,#(__str_7 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
;src/menu.c:1710: hours = system_time.tm_hour;
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r2,a
;     genAssign
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	@r0,ar2
00115$:
;src/menu.c:1713: lcd_goto_xy(display->x+9, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0d
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r2,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r5,a
;     genPlus
	mov	a,#0x09
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	dpl,a
;     genIpush
	push	ar3
	push	ar4
	push	ar2
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
;src/menu.c:1714: result = read_keyboard_data_workloop(2,0x99,0,false);
;     genIpush
	push	ar3
	push	ar4
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	mov	a,#0x99
	push	acc
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,#0x02
	lcall	_read_keyboard_data_workloop
	mov	r2,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar5
;src/menu.c:1715: if (result != 0x99)
;     genCmpEq
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	cjne	@r0,#0x99,00149$
	inc	r0
	cjne	@r0,#0x00,00149$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00119$
00149$:
;src/menu.c:1717: if (result <= 0x59)
;     genCmpGt
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
;     genCmp
	clr	c
	mov	a,#0x59
	subb	a,@r0
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	subb	a,@r0
;     genIfxJump
	jnc	00150$
	ljmp	00120$
00150$:
;src/menu.c:1719: mins = (unsigned char)result&0xff;
;     genCast
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	a,_bp
	add	a,#0x04
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	ljmp	00120$
00119$:
;src/menu.c:1724: lcd_goto_xy(display->x+9, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0d
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r2,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r5,a
;     genPlus
	mov	a,#0x09
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	dpl,a
;     genIpush
	push	ar3
	push	ar4
	push	ar2
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
;src/menu.c:1725: local_gmtime(&system_data.zone_settings[zone].stop_time);
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#_system_data
	mov	r2,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	r5,a
;     genPlus
	mov	a,#0x06
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	r5,a
;     genCast
	mov	r6,#0x1
;     genCall
	mov	dpl,r2
	mov	dph,r5
	mov	b,r6
	push	ar3
	push	ar4
	lcall	_local_gmtime
	pop	ar4
	pop	ar3
;src/menu.c:1726: printf_fast("%02u", (unsigned int)system_time.tm_min);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
	mov	r2,a
;     genCast
	mov	r5,#0x00
;     genIpush
	push	ar3
	push	ar4
	push	ar2
	push	ar5
;     genIpush
	mov	a,#__str_7
	push	acc
	mov	a,#(__str_7 >> 8)
	push	acc
;     genCall
	lcall	_printf_fast
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
;src/menu.c:1728: mins = system_time.tm_min;
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
	mov	r2,a
;     genAssign
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	@r0,ar2
00120$:
;src/menu.c:1731: temp_long = hours;
;     genCast
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	_temp_long,@r0
	mov	(_temp_long + 1),#0x00
	mov	(_temp_long + 2),#0x00
	mov	(_temp_long + 3),#0x00
;src/menu.c:1732: temp_long *= 3600;
;     genAssign
	mov	__mullong_PARM_2,#0x10
	mov	(__mullong_PARM_2 + 1),#0x0E
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
;     genCall
	mov	dpl,_temp_long
	mov	dph,(_temp_long + 1)
	mov	b,(_temp_long + 2)
	mov	a,(_temp_long + 3)
	push	ar3
	push	ar4
	lcall	__mullong
	mov	_temp_long,dpl
	mov	(_temp_long + 1),dph
	mov	(_temp_long + 2),b
	mov	(_temp_long + 3),a
	pop	ar4
	pop	ar3
;src/menu.c:1734: result = mins * 60;  
;     genMult
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,_bp
	add	a,#0x02
	mov	r1,a
;     genMultOneByte
	mov	a,@r0
	mov	b,#0x3C
	mul	ab
	mov	@r1,a
	inc	r1
	mov	@r1,b
;src/menu.c:1735: temp_long += result;
;     genCast
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	ar2,@r0
	inc	r0
	mov	ar5,@r0
;     genPlus
;       Peephole 3.c    changed mov to clr
	clr     a
	mov     r6,a
	mov     r7,a
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
	add	a,_temp_long
	mov	_temp_long,a
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
	addc	a,(_temp_long + 1)
	mov	(_temp_long + 1),a
;       Peephole 236.g  used r6 instead of ar6
	mov     a,r6
	addc	a,(_temp_long + 2)
	mov	(_temp_long + 2),a
;       Peephole 236.g  used r7 instead of ar7
	mov     a,r7
	addc	a,(_temp_long + 3)
	mov	(_temp_long + 3),a
;src/menu.c:1737: system_data.zone_settings[zone].stop_time = temp_long;
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#_system_data
	mov	r2,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	r5,a
;     genPlus
	mov	a,#0x06
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r6,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	mov	r7,a
;     genPointerSet
;     genFarPointerSet
	mov	dpl,r6
	mov	dph,r7
	mov	a,_temp_long
	movx	@dptr,a
	inc	dptr
	mov	a,(_temp_long + 1)
	movx	@dptr,a
	inc	dptr
	mov	a,(_temp_long + 2)
	movx	@dptr,a
	inc	dptr
	mov	a,(_temp_long + 3)
	movx	@dptr,a
;src/menu.c:1740: if (system_data.zone_settings[zone].start_time >= system_data.zone_settings[zone].stop_time)
;     genPlus
	mov	a,_bp
	add	a,#0x10
	mov	r0,a
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	@r0,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r5 instead of ar5
	addc    a,r5
	inc	r0
	mov	@r0,a
;     genIpush
	push	ar4
	push	ar3
;     genPointerGet
;     genFarPointerGet
	mov	a,_bp
	add	a,#0x10
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
;     genCmpLt
;     genCmp
	clr	c
	mov	a,r3
	subb	a,_temp_long
	mov	a,r4
	subb	a,(_temp_long + 1)
	mov	a,r2
	subb	a,(_temp_long + 2)
	mov	a,r5
	subb	a,(_temp_long + 3)
	clr	a
	rlc	a
;     genIpop
	pop	ar3
	pop	ar4
;     genIfx
;     genIfxJump
;       Peephole 109    removed ljmp by inverse jump logic
	jnz     00122$
00151$:
;src/menu.c:1742: system_data.zone_settings[zone].start_time = 0;
;     genPointerSet
;     genFarPointerSet
	mov	a,_bp
	add	a,#0x10
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
;       Peephole 101    removed redundant mov
;       Peephole 181    changed mov to clr
;       Peephole 101    removed redundant mov
;       Peephole 181    changed mov to clr
;       Peephole 226    removed unnecessary clr
	clr     a
	movx    @dptr,a
	inc     dptr
	movx    @dptr,a
	inc     dptr
	movx    @dptr,a
	inc     dptr
	movx    @dptr,a
;src/menu.c:1743: system_data.zone_settings[zone].stop_time = 0;
;     genPointerSet
;     genFarPointerSet
	mov	dpl,r6
	mov	dph,r7
;       Peephole 101    removed redundant mov
;       Peephole 181    changed mov to clr
;       Peephole 101    removed redundant mov
;       Peephole 181    changed mov to clr
;       Peephole 226    removed unnecessary clr
	clr     a
	movx    @dptr,a
	inc     dptr
	movx    @dptr,a
	inc     dptr
	movx    @dptr,a
	inc     dptr
	movx    @dptr,a
00122$:
;src/menu.c:1746: lcd_goto_xy(display->x+21, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0d
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r2,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r5,a
;     genPlus
	mov	a,#0x15
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	dpl,a
;     genIpush
	push	ar3
	push	ar4
	push	ar2
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar4
	pop	ar3
;src/menu.c:1747: result = read_keyboard_data_workloop(2,0x99,0,false);
;     genIpush
	push	ar3
	push	ar4
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	mov	a,#0x99
	push	acc
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,#0x02
	lcall	_read_keyboard_data_workloop
	mov	r2,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar5
;src/menu.c:1748: if (result != 0x99)
;     genCmpEq
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	cjne	@r0,#0x99,00152$
	inc	r0
	cjne	@r0,#0x00,00152$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00124$
00152$:
;src/menu.c:1750: system_data.zone_settings[zone].temperature = result;
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#_system_data
	mov	dpl,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	a,@r0
	movx	@dptr,a
	inc	dptr
	inc	r0
	mov	a,@r0
	movx	@dptr,a
00124$:
;src/menu.c:1757: xram = &system_data.zone_settings[zone];
;     genPlus
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	add	a,#_system_data
	mov	r4,a
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	addc	a,#(_system_data >> 8)
	mov	r3,a
;     genCast
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,#0x1
;src/menu.c:1758: flash = (unsigned char*)(dfp + zone*ZONE_SETTING_SIZE);
;     genMult
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genMultOneByte
	mov	a,@r0
	mov	b,#0x0A
	mul	ab
	mov	r5,a
	mov	r6,b
;     genAssign
	mov	dptr,#_dfp
	clr	a
	movc	a,@a+dptr
	mov	r7,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r2,a
;     genPlus
;       Peephole 236.g  used r5 instead of ar5
	mov     a,r5
;       Peephole 236.a  used r7 instead of ar7
	add     a,r7
	mov	r5,a
;       Peephole 236.g  used r6 instead of ar6
	mov     a,r6
;       Peephole 236.b  used r2 instead of ar2
	addc    a,r2
	mov	r6,a
;     genCast
	mov	ar2,r5
	mov	ar3,r6
	mov	r4,#0x2
;src/menu.c:1759: for(count=0; count < ZONE_SETTING_SIZE; count++)
;     genAssign
;     genAssign
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	a,_bp
	add	a,#0x0d
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
;     genAssign
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	@r0,#0x00
00125$:
;     genCmpLt
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
;     genCmp
	cjne	@r0,#0x0A,00153$
00153$:
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00128$
00154$:
;src/menu.c:1761: flash_write_byte(*xram++, (unsigned int)flash++);
;     genAssign
	mov	ar6,r2
	mov	ar7,r3
	mov	ar5,r4
;     genPlus
;     genPlusIncr
	inc	r2
	cjne	r2,#0x00,00155$
	inc	r3
00155$:
;     genCast
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x0d
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r5,a
	inc	dptr
	dec	r0
	dec	r0
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
;     genIpush
	push	ar2
	push	ar3
	push	ar4
	push	ar6
	push	ar7
;     genCall
	mov	dpl,r5
	lcall	_flash_write_byte
	dec	sp
	dec	sp
	pop	ar4
	pop	ar3
	pop	ar2
;src/menu.c:1762: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/menu.c:1759: for(count=0; count < ZONE_SETTING_SIZE; count++)
;     genPlus
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
;     genPlusIncr
	inc	@r0
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00125$
00128$:
;src/menu.c:1765: lcd_cursor_off();
;     genCall
	lcall	_lcd_cursor_off
;src/menu.c:1766: menu_previous_position();
;     genCall
	lcall	_menu_previous_position
;src/menu.c:1767: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
;     genIpush
	push	_current_display_state
;     genCall
	mov	dpl,#0x00
	lcall	_ds1302_write_memory
	dec	sp
00129$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'time_workloop'
;------------------------------------------------------------
;result                    Allocated to stack - offset 1
;display                   Allocated to stack - offset 3
;------------------------------------------------------------
;src/menu.c:1770: void time_workloop(void)
;	-----------------------------------------
;	 function time_workloop
;	-----------------------------------------
_time_workloop:
	push	_bp
	mov	_bp,sp
	mov	a,sp
	add	a,#0x05
	mov	sp,a
;src/menu.c:1776: BLINKING_OFF;
;     genAssign
	mov	_blinking,#0x00
;src/menu.c:1778: display = menu[current_display_state].item[current_position].display;
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r2,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r3,a
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
;     genMult
;     genMultOneByte
	mov	a,_current_position
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
	mov	a,b
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r4,a
;     genAssign
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
;src/menu.c:1780: lcd_goto_xy(display->x, display->y+1);
;     genPlus
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
;     genPlusIncr
	mov	a,#0x01
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
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r5,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r6,a
;     genIpush
	push	ar5
;     genCall
	mov	dpl,r6
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1781: lcd_cursor_on();
;     genCall
	lcall	_lcd_cursor_on
;src/menu.c:1782: ds1302_read_rtc_bcd(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	lcall	_ds1302_read_rtc_bcd
;src/menu.c:1784: result = read_keyboard_data_workloop(2,system_time.tm_hour,0,true);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r5,a
;     genCast
	mov	r6,#0x00
;     genIpush
	mov	a,#0x01
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	push	ar5
	push	ar6
;     genCall
	mov	dpl,#0x02
	lcall	_read_keyboard_data_workloop
	mov	r5,dpl
	mov	r6,dph
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar5
	inc	r0
	mov	@r0,ar6
;src/menu.c:1785: if (result != system_time.tm_hour)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0002)
	movx	a,@dptr
	mov	r7,a
;     genCast
	mov	r5,#0x00
;     genCmpEq
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,@r0
	cjne	a,ar7,00121$
	inc	r0
	mov	a,@r0
	cjne	a,ar5,00121$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00104$
00121$:
;src/menu.c:1787: if (result <= 0x23)
;     genCmpGt
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genCmp
	clr	c
	mov	a,#0x23
	subb	a,@r0
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	subb	a,@r0
;     genIfxJump
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 160    removed sjmp by inverse jump logic
	jc      00104$
00122$:
;src/menu.c:1789: system_time.tm_hour = (unsigned char)result&0xff;
;     genCast
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	ar5,@r0
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0002)
	mov	a,r5
	movx	@dptr,a
00104$:
;src/menu.c:1793: lcd_goto_xy(display->x+3, display->y+1);
;     genPlus
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
;     genPlusIncr
	mov	a,#0x01
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
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r2,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r3,a
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	dpl,a
;     genIpush
	push	ar5
	push	ar6
	push	ar7
	push	ar2
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
	pop	ar7
	pop	ar6
	pop	ar5
;src/menu.c:1795: result = read_keyboard_data_workloop(2,system_time.tm_min,0,true);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
	mov	r2,a
;     genCast
	mov	r3,#0x00
;     genIpush
	push	ar5
	push	ar6
	push	ar7
	mov	a,#0x01
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	push	ar2
	push	ar3
;     genCall
	mov	dpl,#0x02
	lcall	_read_keyboard_data_workloop
	mov	r2,dpl
	mov	r3,dph
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
;src/menu.c:1796: if (result != system_time.tm_min)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0001)
	movx	a,@dptr
	mov	r2,a
;     genCast
	mov	r3,#0x00
;     genCmpEq
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,@r0
	cjne	a,ar2,00123$
	inc	r0
	mov	a,@r0
	cjne	a,ar3,00123$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00108$
00123$:
;src/menu.c:1798: if (result <= 0x59)
;     genCmpGt
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genCmp
	clr	c
	mov	a,#0x59
	subb	a,@r0
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	subb	a,@r0
;     genIfxJump
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 160    removed sjmp by inverse jump logic
	jc      00108$
00124$:
;src/menu.c:1800: system_time.tm_min = (unsigned char)result&0xff;
;     genCast
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	ar2,@r0
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0001)
	mov	a,r2
	movx	@dptr,a
00108$:
;src/menu.c:1804: lcd_goto_xy(display->x+6, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r5,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r2,a
;     genPlus
	mov	a,#0x06
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;     genIpush
	push	ar5
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1806: result = read_keyboard_data_workloop(2,system_time.tm_sec,0,true);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_system_time
	movx	a,@dptr
	mov	r2,a
;     genCast
	mov	r3,#0x00
;     genIpush
	mov	a,#0x01
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	push	ar2
	push	ar3
;     genCall
	mov	dpl,#0x02
	lcall	_read_keyboard_data_workloop
	mov	r2,dpl
	mov	r3,dph
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;     genAssign
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
;src/menu.c:1807: if (result != system_time.tm_sec)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#_system_time
	movx	a,@dptr
	mov	r2,a
;     genCast
	mov	r3,#0x00
;     genCmpEq
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,@r0
	cjne	a,ar2,00125$
	inc	r0
	mov	a,@r0
	cjne	a,ar3,00125$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00112$
00125$:
;src/menu.c:1809: if (result <= 0x59)
;     genCmpGt
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
;     genCmp
	clr	c
	mov	a,#0x59
	subb	a,@r0
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	subb	a,@r0
;     genIfxJump
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 160    removed sjmp by inverse jump logic
	jc      00112$
00126$:
;src/menu.c:1811: system_time.tm_sec = (unsigned char)result&0xff;
;     genCast
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	ar2,@r0
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#_system_time
	mov	a,r2
	movx	@dptr,a
00112$:
;src/menu.c:1815: ds1302_write_rtc(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	lcall	_ds1302_write_rtc
;src/menu.c:1817: lcd_cursor_off();
;     genCall
	lcall	_lcd_cursor_off
;src/menu.c:1818: menu_previous_position();
;     genCall
	lcall	_menu_previous_position
;src/menu.c:1821: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
;     genIpush
	push	_current_display_state
;     genCall
	mov	dpl,#0x00
	lcall	_ds1302_write_memory
	dec	sp
00113$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'date_workloop'
;------------------------------------------------------------
;isBCD                     Allocated to stack - offset 1
;result                    Allocated to registers r2 r6 
;ib                        Allocated to registers 
;display                   Allocated to stack - offset 2
;sloc0                     Allocated to stack - offset 8
;sloc1                     Allocated to stack - offset 5
;------------------------------------------------------------
;src/menu.c:1832: void date_workloop(const unsigned char isBCD)
;	-----------------------------------------
;	 function date_workloop
;	-----------------------------------------
_date_workloop:
	push	_bp
	mov	_bp,sp
	mov	a,sp
	add	a,#0x07
	mov	sp,a
;     genReceive
	push	acc
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	pop	acc
	mov	@r0,dpl
;src/menu.c:1840: BLINKING_OFF;
;     genAssign
	mov	_blinking,#0x00
;src/menu.c:1842: display = menu[current_display_state].item[current_position].display;
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r3,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r4,a
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	r3,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genMult
;     genMultOneByte
	mov	a,_current_position
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	r3,a
	mov	a,b
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
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
	mov	r3,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r4,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r5,a
;     genAssign
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;src/menu.c:1844: lcd_goto_xy(display->x, display->y+1);
;     genPlus
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	r6,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	mov	r7,a
	inc	r0
	mov	ar2,@r0
;     genPointerGet
;     genGenPointerGet
	mov	dpl,r6
	mov	dph,r7
	mov	b,r2
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r6,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r2,a
;     genIpush
	push	ar6
;     genCall
	mov	dpl,r2
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1845: lcd_cursor_on();
;     genCall
	lcall	_lcd_cursor_on
;src/menu.c:1847: ds1302_read_rtc_bcd(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	lcall	_ds1302_read_rtc_bcd
;src/menu.c:1849: result = read_keyboard_data_workloop(4,0x2004,0,true);
;     genIpush
	mov	a,#0x01
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	mov	a,#0x04
	push	acc
	mov	a,#0x20
	push	acc
;     genCall
	mov	dpl,#0x04
	lcall	_read_keyboard_data_workloop
	mov	r2,dpl
	mov	r6,dph
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;     genAssign
;src/menu.c:1850: if (result >= 0x2004)
;     genCmpLt
;     genCmp
	clr	c
	mov	a,r2
	subb	a,#0x04
	mov	a,r6
	subb	a,#0x20
;     genIfxJump
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 160    removed sjmp by inverse jump logic
	jc      00102$
00112$:
;src/menu.c:1852: system_time.tm_year = (unsigned char)(result & 0xff);
;     genCast
	mov	ar7,r2
;     genCast
	mov	r3,#0x00
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0005)
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
00102$:
;src/menu.c:1855: lcd_goto_xy(display->x+5, display->y+1);
;     genPlus
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	a,_bp
	add	a,#0x05
	mov	r1,a
;     genPlusIncr
	mov	a,#0x01
	add	a,@r0
	mov	@r1,a
;       Peephole 181    changed mov to clr
	clr     a
	inc	r0
	addc	a,@r0
	inc	r1
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r7,a
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r7 instead of ar7
	add     a,r7
	mov	r2,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r7,a
;     genPlus
	mov	a,#0x05
;       Peephole 236.a  used r7 instead of ar7
	add     a,r7
	mov	dpl,a
;     genIpush
	push	ar2
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1857: result = read_keyboard_data_workloop(2,system_time.tm_mon,0,false);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0004)
	movx	a,@dptr
	mov	r7,a
;     genCast
;     genIpush
;       Peephole 3.a    changed mov to clr
	clr     a
	mov     r3,a
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	push	ar7
	push	ar3
;     genCall
	mov	dpl,#0x02
	lcall	_read_keyboard_data_workloop
	mov	r3,dpl
	mov	r4,dph
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;     genAssign
	mov	ar2,r3
	mov	ar6,r4
;src/menu.c:1861: if (result != system_time.tm_mon)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0004)
	movx	a,@dptr
	mov	r3,a
;     genCast
	mov	r4,#0x00
;     genCmpEq
	mov	a,r2
	cjne	a,ar3,00113$
	mov	a,r6
	cjne	a,ar4,00113$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00104$
00113$:
;src/menu.c:1863: result--;
;     genMinus
;     genMinusDec
	dec	r2
	cjne	r2,#0xff,00114$
	dec	r6
00114$:
;src/menu.c:1864: system_time.tm_mon = (unsigned char)(result & 0xff);
;     genCast
	mov	ar3,r2
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0004)
	mov	a,r3
	movx	@dptr,a
00104$:
;src/menu.c:1867: lcd_goto_xy(display->x+8, display->y+1);
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
;     genPlus
;     genPlusIncr
;       Peephole 185    changed order of increment (acc incremented also!)
	inc     a
	mov     r3,a
;     genPointerGet
;     genGenPointerGet
	mov	a,_bp
	add	a,#0x02
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r4,a
;     genPlus
	mov	a,#0x08
;       Peephole 236.a  used r4 instead of ar4
	add     a,r4
	mov	dpl,a
;     genIpush
	push	ar3
;     genCall
	lcall	_lcd_goto_xy
	dec	sp
;src/menu.c:1869: result = read_keyboard_data_workloop(2,system_time.tm_mday,0,ib);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0003)
	movx	a,@dptr
	mov	r3,a
;     genCast
	mov	r4,#0x00
;     genIpush
;       Peephole 212    reduced add sequence to inc
	mov     r0,_bp
	inc     r0
	mov	a,@r0
	push	acc
;     genIpush
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genIpush
	push	ar3
	push	ar4
;     genCall
	mov	dpl,#0x02
	lcall	_read_keyboard_data_workloop
	mov	r3,dpl
	mov	r4,dph
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;     genAssign
	mov	ar2,r3
	mov	ar6,r4
;src/menu.c:1870: if (result != system_time.tm_mday)
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0003)
	movx	a,@dptr
	mov	r3,a
;     genCast
	mov	r4,#0x00
;     genCmpEq
	mov	a,r2
	cjne	a,ar3,00115$
	mov	a,r6
	cjne	a,ar4,00115$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00115$:
;src/menu.c:1872: system_time.tm_mday = (unsigned char)(result & 0xff);
;     genCast
;     genPointerSet
;     genFarPointerSet
	mov	dptr,#(_system_time + 0x0003)
	mov	a,r2
	movx	@dptr,a
00106$:
;src/menu.c:1875: ds1302_write_rtc(&system_time);
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#_system_time
	mov	b,#0x01
	lcall	_ds1302_write_rtc
;src/menu.c:1877: lcd_cursor_off();
;     genCall
	lcall	_lcd_cursor_off
;src/menu.c:1878: menu_previous_position();
;     genCall
	lcall	_menu_previous_position
;src/menu.c:1879: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
;     genIpush
	push	_current_display_state
;     genCall
	mov	dpl,#0x00
	lcall	_ds1302_write_memory
	dec	sp
00107$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'workloop'
;------------------------------------------------------------
;exit                      Allocated to registers r2 
;sloc0                     Allocated to stack - offset 2
;------------------------------------------------------------
;src/menu.c:1899: void workloop(void)
;	-----------------------------------------
;	 function workloop
;	-----------------------------------------
_workloop:
	push	_bp
	mov	_bp,sp
;src/menu.c:1901: unsigned char exit = 0;
;     genAssign
	mov	r2,#0x00
;src/menu.c:1902: BLINKING_ON;
;     genAssign
	mov	_blinking,#0x01
;src/menu.c:1904: while(exit == 0)
00129$:
;     genCmpEq
	cjne	r2,#0x00,00151$
	sjmp	00152$
00151$:
	ljmp	00132$
00152$:
;src/menu.c:1906: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/menu.c:1910: exit = check_external_events();
;     genCall
	lcall	_check_external_events
	mov	r3,dpl
;     genAssign
	mov	ar2,r3
;src/menu.c:1911: if (exit == 0)
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    r2,#0x00,00129$
;00153$:
;       Peephole 200    removed redundant sjmp
00154$:
;src/menu.c:1913: if (keypad_check_front() == DATA_AVAILABLE)
;     genCall
	push	ar2
	lcall	_keypad_check_front
	mov	r3,dpl
	pop	ar2
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    r3,#0x91,00129$
;00155$:
;       Peephole 200    removed redundant sjmp
00156$:
;src/menu.c:1915: key_code = keypad_pop_front();
;     genCall
	push	ar2
	lcall	_keypad_pop_front
	mov	_key_code,dpl
	pop	ar2
;src/menu.c:1918: switch (key_code)
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x10,00157$
	ljmp	00109$
00157$:
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x11,00158$
	ljmp	00106$
00158$:
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x13,00159$
	ljmp	00105$
00159$:
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x14,00160$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00104$
00160$:
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x15,00161$
	ljmp	00117$
00161$:
;     genCmpEq
	mov	a,_key_code
	cjne	a,#0x16,00162$
	ljmp	00123$
00162$:
	ljmp	00124$
;src/menu.c:1930: }
00104$:
;src/menu.c:1921: if (menu[current_display_state].item[current_position].next == EXIT_POS_ID)
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r3,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r4,a
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	r5,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r6,a
;     genMult
;     genMultOneByte
	mov	a,_current_position
	mov	b,#0x08
	mul	ab
	mov	r2,a
	mov	r7,b
;     genPlus
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	r5,a
;       Peephole 236.g  used r7 instead of ar7
	mov     a,r7
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	r6,a
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r5 instead of ar5
	add     a,r5
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r6 instead of ar6
	addc    a,r6
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r5,a
;     genCmpEq
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    r5,#0xFE,00102$
;00163$:
;       Peephole 200    removed redundant sjmp
00164$:
;src/menu.c:1923: menu_previous_position();
;     genCall
	lcall	_menu_previous_position
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00103$
00102$:
;src/menu.c:1927: current_display_state = menu[current_display_state].item[current_position].next;
;     genPlus
;     genPlusIncr
	mov	a,#0x04
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	r3,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genPlus
;       Peephole 236.g  used r2 instead of ar2
	mov     a,r2
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
	mov	r3,a
;       Peephole 236.g  used r7 instead of ar7
	mov     a,r7
;       Peephole 236.b  used r4 instead of ar4
	addc    a,r4
	mov	r4,a
;     genPlus
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
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
	mov	_current_display_state,a
;src/menu.c:1928: stack_push_back(current_position);
;     genCall
	mov	dpl,_current_position
	lcall	_stack_push_back
;src/menu.c:1929: current_position = 0;
;     genAssign
	mov	_current_position,#0x00
00103$:
;src/menu.c:1931: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
;     genIpush
	push	_current_display_state
;     genCall
	mov	dpl,#0x00
	lcall	_ds1302_write_memory
	dec	sp
;src/menu.c:1932: exit = 1;
;     genAssign
	mov	r2,#0x01
;src/menu.c:1933: break;
	ljmp	00124$
;src/menu.c:1936: menu_previous_position();
00105$:
;     genCall
	lcall	_menu_previous_position
;src/menu.c:1937: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
;     genIpush
	push	_current_display_state
;     genCall
	mov	dpl,#0x00
	lcall	_ds1302_write_memory
	dec	sp
;src/menu.c:1938: exit = 1;
;     genAssign
	mov	r2,#0x01
;src/menu.c:1939: break;
	ljmp	00124$
;src/menu.c:1942: current_position++;
00106$:
;     genPlus
;     genPlusIncr
	inc	_current_position
;src/menu.c:1943: if (current_position == menu[current_display_state].max_pos)
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r3,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r4,a
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
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
	mov	r3,a
;     genAssign
	mov	r4,_current_position
;     genCmpEq
	mov	a,r4
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,ar3,00108$
;00165$:
;       Peephole 200    removed redundant sjmp
00166$:
;src/menu.c:1945: current_position = 0;
;     genAssign
	mov	_current_position,#0x00
00108$:
;src/menu.c:1947: set_new_blink();
;     genCall
	push	ar2
	lcall	_set_new_blink
	pop	ar2
;src/menu.c:1948: break;
	ljmp	00124$
;src/menu.c:1951: current_position--;
00109$:
;     genMinus
;     genMinusDec
	dec	_current_position
;src/menu.c:1952: if (current_position == 0xFF)
;     genCmpEq
	mov	a,_current_position
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 199    optimized misc jump sequence
	cjne    a,#0xFF,00111$
;00167$:
;       Peephole 200    removed redundant sjmp
00168$:
;src/menu.c:1954: current_position = menu[current_display_state].max_pos - 1;
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r3,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r4,a
;     genPlus
;     genPlusIncr
	mov	a,#0x03
;       Peephole 236.a  used r3 instead of ar3
	add     a,r3
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
;     genMinus
;     genMinusDec
;       Peephole 105    removed redundant mov
	mov     r3,a
	dec	a
	mov	_current_position,a
00111$:
;src/menu.c:1956: set_new_blink();
;     genCall
	push	ar2
	lcall	_set_new_blink
	pop	ar2
;src/menu.c:1957: break;
	ljmp	00124$
;src/menu.c:1967: break;
00117$:
;src/menu.c:1960: if (current_display_state == MAIN_STATE_POS)
;     genCmpEq
	mov	a,_current_display_state
;       Peephole 162    removed sjmp by inverse jump logic
	jz      00170$
00169$:
	ljmp	00124$
00170$:
;src/menu.c:1962: if(system_data.enabled[current_position] != CHANNEL_FORCED_ON)
;     genCast
	mov	r3,_current_position
	mov	r4,#0x00
;     genPlus
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	movx	a,@dptr
	mov	r5,a
;     genCmpEq
	cjne	r5,#0x04,00171$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00113$
00171$:
;src/menu.c:1963: system_data.enabled[current_position] = CHANNEL_FORCED_ON;
;     genPlus
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
	mov	a,#0x04
	movx	@dptr,a
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00124$
00113$:
;src/menu.c:1965: system_data.enabled[current_position] = CHANNEL_DISABLED;
;     genPlus
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
;       Peephole 181    changed mov to clr
	clr     a
	movx	@dptr,a
;src/menu.c:1967: break;
;src/menu.c:1977: break;
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00124$
00123$:
;src/menu.c:1970: if (current_display_state == MAIN_STATE_POS)
;     genCmpEq
	mov	a,_current_display_state
;       Peephole 162    removed sjmp by inverse jump logic
	jz      00173$
00172$:
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00124$
00173$:
;src/menu.c:1972: if(system_data.enabled[current_position] != CHANNEL_FORCED_OFF)
;     genCast
	mov	r3,_current_position
	mov	r4,#0x00
;     genPlus
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerGet
;     genFarPointerGet
	movx	a,@dptr
	mov	r5,a
;     genCmpEq
	cjne	r5,#0x08,00174$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00119$
00174$:
;src/menu.c:1973: system_data.enabled[current_position] = CHANNEL_FORCED_OFF;
;     genPlus
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
	mov	a,#0x08
	movx	@dptr,a
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00124$
00119$:
;src/menu.c:1975: system_data.enabled[current_position] = CHANNEL_DISABLED;
;     genPlus
;       Peephole 236.g  used r3 instead of ar3
	mov     a,r3
	add	a,#(_system_data + 0x0168)
	mov	dpl,a
;       Peephole 236.g  used r4 instead of ar4
	mov     a,r4
	addc	a,#((_system_data + 0x0168) >> 8)
	mov	dph,a
;     genPointerSet
;     genFarPointerSet
;       Peephole 181    changed mov to clr
	clr     a
	movx	@dptr,a
;src/menu.c:1978: }
00124$:
;src/menu.c:1979: keypad_purge_buffer();
;     genCall
	push	ar2
	lcall	_keypad_purge_buffer
	pop	ar2
	ljmp	00129$
00132$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'battery_test'
;------------------------------------------------------------
;------------------------------------------------------------
;src/menu.c:1993: void battery_test(void)
;	-----------------------------------------
;	 function battery_test
;	-----------------------------------------
_battery_test:
	push	_bp
	mov	_bp,sp
;src/menu.c:1995: BATT_TEST_PORT = 0;
;     genAssign
	clr	_P2_7
00106$:
;src/menu.c:1997: for ( ; battery_counter < 2000; battery_counter++ )
;     genAssign
	mov	dptr,#_battery_counter
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
;     genCmpLt
;     genCmp
	clr	c
	mov	a,r2
	subb	a,#0xD0
	mov	a,r3
	subb	a,#0x07
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00109$
00116$:
;src/menu.c:1999: SERVICE_WATCHDOG;
;     genAssign
	mov	_WDTRST,#0x1E
;     genAssign
	mov	_WDTRST,#0xE1
;src/menu.c:1997: for ( ; battery_counter < 2000; battery_counter++ )
;     genPlus
	mov	dptr,#_battery_counter
;     genPlusIncr
	mov	a,#0x01
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	movx	@dptr,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	inc	dptr
	movx	@dptr,a
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00106$
00109$:
;     genIfx
;     genIfxJump
;       Peephole 112.a  removed ljmp by inverse jump logic
	jb      _P1_1,00104$
00117$:
;src/menu.c:2004: current_display_state = BATTERY_LOW_POS;
;     genAssign
	mov	_current_display_state,#0x38
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00105$
00104$:
;src/menu.c:2008: current_display_state = ds1302_read_memory(RTC_CURRENT_DISPLAY_STATE);
;     genCall
	mov	dpl,#0x00
	lcall	_ds1302_read_memory
	mov	_current_display_state,dpl
;src/menu.c:2010: if (current_display_state >= LATEST_DONT_REMOVE)
;     genCmpLt
;     genCmp
	clr	c
	mov	a,_current_display_state
	subb	a,#0x3A
;     genIfxJump
;       Peephole 112.b  changed ljmp to sjmp
;       Peephole 160    removed sjmp by inverse jump logic
	jc      00105$
00118$:
;src/menu.c:2012: current_display_state = 0;
;     genAssign
	mov	_current_display_state,#0x00
00105$:
;src/menu.c:2016: BATT_TEST_PORT = 1; /* Also set by lcd driver before */
;     genAssign
	setb	_P2_7
00110$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'clear_zones'
;------------------------------------------------------------
;i                         Allocated to registers 
;------------------------------------------------------------
;src/menu.c:2019: void clear_zones()
;	-----------------------------------------
;	 function clear_zones
;	-----------------------------------------
_clear_zones:
	push	_bp
	mov	_bp,sp
;src/menu.c:2023: for(i=0; i<4; i++)
;     genAssign
	mov	r2,#0x00
00101$:
;     genCmpLt
;     genCmp
	clr	c
	mov	a,r2
	xrl	a,#0x80
	subb	a,#0x84
;     genIfxJump
;       Peephole 108    removed ljmp by inverse jump logic
	jnc     00105$
00109$:
;src/menu.c:2025: switch_zone_prepare(i,0);
;     genIpush
	push	ar2
;       Peephole 181    changed mov to clr
	clr     a
	push	acc
;     genCall
	mov	dpl,r2
	lcall	_switch_zone_prepare
	dec	sp
	pop	ar2
;src/menu.c:2026: switch_zone(i);
;     genCall
	mov	dpl,r2
	push	ar2
	lcall	_switch_zone
	pop	ar2
;src/menu.c:2023: for(i=0; i<4; i++)
;     genPlus
;     genPlusIncr
	inc	r2
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00101$
00105$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main_program_workloop'
;------------------------------------------------------------
;------------------------------------------------------------
;src/menu.c:2032: void main_program_workloop(void)
;	-----------------------------------------
;	 function main_program_workloop
;	-----------------------------------------
_main_program_workloop:
	push	_bp
	mov	_bp,sp
;src/menu.c:2034: battery_test();
;     genCall
	lcall	_battery_test
;src/menu.c:2035: stack_purge();
;     genCall
	lcall	_stack_purge
;src/menu.c:2036: ENABLE_INTERRUPTS;
;     genAssign
	setb	_EA
;src/menu.c:2040: while (1)
00158$:
;src/menu.c:2042: enter_workloop = true;
;     genAssign
	mov	_enter_workloop,#0x01
;src/menu.c:2044: BLINKING_OFF;
;     genAssign
	mov	_blinking,#0x00
;src/menu.c:2045: lcd_clear();
;     genCall
	lcall	_lcd_clear
;src/menu.c:2046: lcd_put_string(menu[current_display_state].text);
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	dpl,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	r4,a
;     genCall
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_lcd_put_string
;src/menu.c:2047: current_blink_params = menu[current_display_state].item[current_position].blink_union.blink;     
;     genMult
;     genMultOneByte
	mov	a,_current_display_state
	mov	b,#0x3C
	mul	ab
;     genPlus
	add	a,#_menu
	mov	r2,a
	mov	a,b
	addc	a,#(_menu >> 8)
	mov	r3,a
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
;     genMult
;     genMultOneByte
	mov	a,_current_position
	mov	b,#0x08
	mul	ab
;     genPlus
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	r2,a
	mov	a,b
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	r3,a
;     genPlus
;     genPlusIncr
	mov	a,#0x02
;       Peephole 236.a  used r2 instead of ar2
	add     a,r2
	mov	dpl,a
;       Peephole 181    changed mov to clr
	clr     a
;       Peephole 236.b  used r3 instead of ar3
	addc    a,r3
	mov	dph,a
;     genPointerGet
;     genCodePointerGet
;       Peephole 181    changed mov to clr
	clr     a
	movc	a,@a+dptr
	mov	_current_blink_params,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_current_blink_params + 1),a
	mov	a,#0x02
	movc	a,@a+dptr
	mov	(_current_blink_params + 2),a
;src/menu.c:2049: switch (current_display_state)
;     genCmpEq
	mov	a,_current_display_state
	jnz	00217$
	ljmp	00102$
00217$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x06,00218$
	ljmp	00103$
00218$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x07,00219$
	ljmp	00104$
00219$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x08,00220$
	ljmp	00105$
00220$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x09,00221$
	ljmp	00106$
00221$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x0A,00222$
	ljmp	00107$
00222$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x0B,00223$
	ljmp	00108$
00223$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x0C,00224$
	ljmp	00109$
00224$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x0D,00225$
	ljmp	00110$
00225$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x0E,00226$
	ljmp	00111$
00226$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x0F,00227$
	ljmp	00112$
00227$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x10,00228$
	ljmp	00113$
00228$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x11,00229$
	ljmp	00114$
00229$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x12,00230$
	ljmp	00115$
00230$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x13,00231$
	ljmp	00115$
00231$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x14,00232$
	ljmp	00115$
00232$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x15,00233$
	ljmp	00115$
00233$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x16,00234$
	ljmp	00115$
00234$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x17,00235$
	ljmp	00115$
00235$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x18,00236$
	ljmp	00115$
00236$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x19,00237$
	ljmp	00115$
00237$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x1A,00238$
	ljmp	00115$
00238$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x1B,00239$
	ljmp	00115$
00239$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x1C,00240$
	ljmp	00115$
00240$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x1D,00241$
	ljmp	00115$
00241$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x1E,00242$
	ljmp	00115$
00242$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x1F,00243$
	ljmp	00115$
00243$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x20,00244$
	ljmp	00115$
00244$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x21,00245$
	ljmp	00115$
00245$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x22,00246$
	ljmp	00115$
00246$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x23,00247$
	ljmp	00115$
00247$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x24,00248$
	ljmp	00115$
00248$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x25,00249$
	ljmp	00115$
00249$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x26,00250$
	ljmp	00115$
00250$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x27,00251$
	ljmp	00115$
00251$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x28,00252$
	ljmp	00115$
00252$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x29,00253$
	ljmp	00115$
00253$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x2A,00254$
	ljmp	00115$
00254$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x2B,00255$
	ljmp	00115$
00255$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x2C,00256$
	ljmp	00115$
00256$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x2D,00257$
	ljmp	00115$
00257$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x2E,00258$
	ljmp	00115$
00258$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x2F,00259$
	ljmp	00115$
00259$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x30,00260$
	ljmp	00115$
00260$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x31,00261$
	ljmp	00115$
00261$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x32,00262$
	ljmp	00115$
00262$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x33,00263$
	ljmp	00115$
00263$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x34,00264$
	ljmp	00115$
00264$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x35,00265$
	ljmp	00115$
00265$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x36,00266$
	ljmp	00152$
00266$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x37,00267$
	ljmp	00153$
00267$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x38,00268$
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00101$
00268$:
;     genCmpEq
	mov	a,_current_display_state
	cjne	a,#0x39,00269$
	ljmp	00151$
00269$:
	ljmp	00154$
;src/menu.c:2052: reset_workloop(0);
00101$:
;     genCall
	mov	dpl,#0x00
;       Peephole 3.a    changed mov to clr
;       Peephole 3.b    changed mov to clr
	clr     a
	mov     dph,a
	mov     b,a
	lcall	_reset_workloop
;src/menu.c:2053: enter_workloop = false;
;     genAssign
	mov	_enter_workloop,#0x00
;src/menu.c:2054: break;
	ljmp	00154$
;src/menu.c:2060: display_stored_data((unsigned int*)system_data.temperatures,true);
00102$:
;     genIpush
	mov	a,#0x01
	push	acc
;     genCall
;       Peephole 182.a  used 16 bit load of DPTR
	mov     dptr,#(_system_data + 0x016c)
	mov	b,#0x01
	lcall	_display_stored_data
	dec	sp
;src/menu.c:2061: display_enabled_channels(true);
;     genCall
	mov	dpl,#0x01
	lcall	_display_enabled_channels
;src/menu.c:2062: break;
	ljmp	00154$
;src/menu.c:2065: display_zone_setings(0);
00103$:
;     genCall
	mov	dpl,#0x00
	lcall	_display_zone_setings
;src/menu.c:2066: break;
	ljmp	00154$
;src/menu.c:2068: display_zone_setings(3);
00104$:
;     genCall
	mov	dpl,#0x03
	lcall	_display_zone_setings
;src/menu.c:2069: break;
	ljmp	00154$
;src/menu.c:2071: display_zone_setings(6);
00105$:
;     genCall
	mov	dpl,#0x06
	lcall	_display_zone_setings
;src/menu.c:2072: break;
	ljmp	00154$
;src/menu.c:2074: display_zone_setings(9);
00106$:
;     genCall
	mov	dpl,#0x09
	lcall	_display_zone_setings
;src/menu.c:2075: break;
	ljmp	00154$
;src/menu.c:2077: display_zone_setings(12);
00107$:
;     genCall
	mov	dpl,#0x0C
	lcall	_display_zone_setings
;src/menu.c:2078: break;
	ljmp	00154$
;src/menu.c:2080: display_zone_setings(15);
00108$:
;     genCall
	mov	dpl,#0x0F
	lcall	_display_zone_setings
;src/menu.c:2081: break;
	ljmp	00154$
;src/menu.c:2083: display_zone_setings(18);
00109$:
;     genCall
	mov	dpl,#0x12
	lcall	_display_zone_setings
;src/menu.c:2084: break;
	ljmp	00154$
;src/menu.c:2086: display_zone_setings(21);
00110$:
;     genCall
	mov	dpl,#0x15
	lcall	_display_zone_setings
;src/menu.c:2087: break;
	ljmp	00154$
;src/menu.c:2089: display_zone_setings(24);
00111$:
;     genCall
	mov	dpl,#0x18
	lcall	_display_zone_setings
;src/menu.c:2090: break;
	ljmp	00154$
;src/menu.c:2092: display_zone_setings(27);
00112$:
;     genCall
	mov	dpl,#0x1B
	lcall	_display_zone_setings
;src/menu.c:2093: break;
	ljmp	00154$
;src/menu.c:2095: display_zone_setings(30);
00113$:
;     genCall
	mov	dpl,#0x1E
	lcall	_display_zone_setings
;src/menu.c:2096: break;
;src/menu.c:2098: display_zone_setings(33);
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00154$
00114$:
;     genCall
	mov	dpl,#0x21
	lcall	_display_zone_setings
;src/menu.c:2099: break;
;src/menu.c:2137: zone_workloop(current_display_state - POS_2_ZONE_OFFSET);
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00154$
00115$:
;     genMinus
	mov	a,_current_display_state
	add	a,#0xee
	mov	dpl,a
;     genCall
	lcall	_zone_workloop
;src/menu.c:2138: enter_workloop = false;
;     genAssign
	mov	_enter_workloop,#0x00
;src/menu.c:2139: break;
;src/menu.c:2142: display_stored_time(0, WEEKDAY,true);
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00154$
00151$:
;     genIpush
	mov	a,#0x01
	push	acc
;     genIpush
	mov	a,#0x04
	push	acc
;     genCall
	mov	dpl,#0x00
	lcall	_display_stored_time
	dec	sp
	dec	sp
;src/menu.c:2143: weekday_worklop(system_time.tm_wday);
;     genPointerGet
;     genFarPointerGet
	mov	dptr,#(_system_time + 0x0007)
	movx	a,@dptr
	mov	r2,a
;     genCast
	mov	r3,#0x00
;     genCall
	mov	dpl,r2
	mov	dph,r3
	lcall	_weekday_worklop
;src/menu.c:2144: enter_workloop = false;
;     genAssign
	mov	_enter_workloop,#0x00
;src/menu.c:2145: break;
;src/menu.c:2148: display_stored_time(0, DATE_FORMAT,true);
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00154$
00152$:
;     genIpush
	mov	a,#0x01
	push	acc
;     genIpush
	mov	a,#0x01
	push	acc
;     genCall
	mov	dpl,#0x00
	lcall	_display_stored_time
	dec	sp
	dec	sp
;src/menu.c:2149: date_workloop(true);
;     genCall
	mov	dpl,#0x01
	lcall	_date_workloop
;src/menu.c:2150: enter_workloop = false;
;     genAssign
	mov	_enter_workloop,#0x00
;src/menu.c:2151: break;
;src/menu.c:2154: display_stored_time(0, TIME_FORMAT,true);
;       Peephole 112.b  changed ljmp to sjmp
	sjmp    00154$
00153$:
;     genIpush
	mov	a,#0x01
	push	acc
;     genIpush
	mov	a,#0x02
	push	acc
;     genCall
	mov	dpl,#0x00
	lcall	_display_stored_time
	dec	sp
	dec	sp
;src/menu.c:2155: time_workloop();
;     genCall
	lcall	_time_workloop
;src/menu.c:2156: enter_workloop = false;
;     genAssign
	mov	_enter_workloop,#0x00
;src/menu.c:2158: }
00154$:
;src/menu.c:2160: if (enter_workloop == true)
;     genCmpEq
	mov	a,_enter_workloop
	cjne	a,#0x01,00270$
	sjmp	00271$
00270$:
	ljmp	00158$
00271$:
;src/menu.c:2161: workloop();
;     genCall
	lcall	_workloop
	ljmp	00158$
00160$:
	mov	sp,_bp
	pop	_bp
	ret
	.area CSEG    (CODE)
_zone_day_map:
	.db #0x00
	.db #0x00
	.db #0x01
	.db #0x00
	.db #0x02
	.db #0x00
	.db #0x03
	.db #0x05
	.db #0x04
	.db #0x05
	.db #0x05
	.db #0x05
	.db #0x06
	.db #0x06
	.db #0x07
	.db #0x06
	.db #0x08
	.db #0x06
	.db #0x09
	.db #0x00
	.db #0x0A
	.db #0x00
	.db #0x0B
	.db #0x00
	.db #0x0C
	.db #0x05
	.db #0x0D
	.db #0x05
	.db #0x0E
	.db #0x05
	.db #0x0F
	.db #0x06
	.db #0x10
	.db #0x06
	.db #0x11
	.db #0x06
	.db #0x12
	.db #0x00
	.db #0x13
	.db #0x00
	.db #0x14
	.db #0x00
	.db #0x15
	.db #0x05
	.db #0x16
	.db #0x05
	.db #0x17
	.db #0x05
	.db #0x18
	.db #0x06
	.db #0x19
	.db #0x06
	.db #0x1A
	.db #0x06
	.db #0x1B
	.db #0x00
	.db #0x1C
	.db #0x00
	.db #0x1D
	.db #0x00
	.db #0x1E
	.db #0x05
	.db #0x1F
	.db #0x05
	.db #0x20
	.db #0x05
	.db #0x21
	.db #0x06
	.db #0x22
	.db #0x06
	.db #0x23
	.db #0x06
_dfp:
	.byte #0x00,#0x7D
_minmax:
	.byte #0x00,#0x00
	.byte #0x0F,#0x27
	.byte #0x00,#0x00
	.byte #0x63,#0x00
	.byte #0x00,#0x00
	.byte #0x0F,#0x27
	.byte #0x00,#0x00
	.byte #0xD0,#0x07
	.byte #0x01,#0x00
	.byte #0x0A,#0x00
	.byte #0x01,#0x00
	.byte #0x0A,#0x00
	.byte #0x01,#0x00
	.byte #0x0A,#0x00
	.byte #0x01,#0x00
	.byte #0x14,#0x00
	.byte #0x00,#0x00
	.byte #0x63,#0x00
	.byte #0x00,#0x00
	.byte #0xE7,#0x03
	.byte #0x00,#0x00
	.byte #0x64,#0x00
	.byte #0x00,#0x00
	.byte #0xC8,#0x00
	.byte #0x01,#0x00
	.byte #0x0A,#0x00
	.byte #0x01,#0x00
	.byte #0x63,#0x00
	.byte #0xA0,#0x00
	.byte #0xFF,#0x00
_bpr:
	.db #0xFF
	.byte _str_18,(_str_18 >> 8),#0x02
	.byte _str_19,(_str_19 >> 8),#0x02
	.byte _str_20,(_str_20 >> 8),#0x02
	.byte _str_21,(_str_21 >> 8),#0x02
	.db #0xFF
	.db #0x00
	.byte _str_22,(_str_22 >> 8),#0x02
	.byte _str_23,(_str_23 >> 8),#0x02
	.byte _str_24,(_str_24 >> 8),#0x02
	.byte _str_25,(_str_25 >> 8),#0x02
	.db #0x01
	.db #0x07
	.byte _str_26,(_str_26 >> 8),#0x02
	.byte _str_27,(_str_27 >> 8),#0x02
	.byte _str_28,(_str_28 >> 8),#0x02
	.byte _str_29,(_str_29 >> 8),#0x02
	.db #0x01
	.db #0x0F
	.byte _str_30,(_str_30 >> 8),#0x02
	.byte _str_31,(_str_31 >> 8),#0x02
	.byte _str_32,(_str_32 >> 8),#0x02
	.byte _str_33,(_str_33 >> 8),#0x02
	.db #0x01
	.db #0x16
	.byte _str_34,(_str_34 >> 8),#0x02
	.byte _str_35,(_str_35 >> 8),#0x02
	.byte _str_36,(_str_36 >> 8),#0x02
	.byte _str_37,(_str_37 >> 8),#0x02
	.db #0x01
	.db #0x23
	.byte _str_38,(_str_38 >> 8),#0x02
	.byte _str_39,(_str_39 >> 8),#0x02
	.byte _str_40,(_str_40 >> 8),#0x02
	.byte _str_41,(_str_41 >> 8),#0x02
	.db #0x01
	.db #0x21
	.byte _str_42,(_str_42 >> 8),#0x02
	.byte _str_43,(_str_43 >> 8),#0x02
	.byte _str_44,(_str_44 >> 8),#0x02
	.byte _str_45,(_str_45 >> 8),#0x02
	.db #0x02
	.db #0x05
	.byte _str_46,(_str_46 >> 8),#0x02
	.byte _str_47,(_str_47 >> 8),#0x02
	.byte _str_48,(_str_48 >> 8),#0x02
	.byte _str_49,(_str_49 >> 8),#0x02
	.db #0x01
	.db #0x11
	.byte _str_50,(_str_50 >> 8),#0x02
	.byte _str_51,(_str_51 >> 8),#0x02
	.byte _str_52,(_str_52 >> 8),#0x02
	.byte _str_53,(_str_53 >> 8),#0x02
	.db #0x01
	.db #0x19
	.byte _str_54,(_str_54 >> 8),#0x02
	.byte _str_55,(_str_55 >> 8),#0x02
	.byte _str_56,(_str_56 >> 8),#0x02
	.byte _str_57,(_str_57 >> 8),#0x02
	.db #0x01
	.db #0x24
	.byte _str_58,(_str_58 >> 8),#0x02
	.byte _str_59,(_str_59 >> 8),#0x02
	.byte _str_60,(_str_60 >> 8),#0x02
	.byte _str_61,(_str_61 >> 8),#0x02
	.db #0x01
	.db #0x00
	.byte _str_62,(_str_62 >> 8),#0x02
	.byte _str_63,(_str_63 >> 8),#0x02
	.byte _str_64,(_str_64 >> 8),#0x02
	.byte _str_65,(_str_65 >> 8),#0x02
	.db #0x01
	.db #0x0E
	.byte _str_66,(_str_66 >> 8),#0x02
	.byte _str_67,(_str_67 >> 8),#0x02
	.byte _str_68,(_str_68 >> 8),#0x02
	.byte _str_69,(_str_69 >> 8),#0x02
	.db #0x01
	.db #0x1C
	.byte _str_70,(_str_70 >> 8),#0x02
	.byte _str_71,(_str_71 >> 8),#0x02
	.byte _str_72,(_str_72 >> 8),#0x02
	.byte _str_73,(_str_73 >> 8),#0x02
	.db #0x01
	.db #0x1C
	.byte _str_74,(_str_74 >> 8),#0x02
	.byte _str_75,(_str_75 >> 8),#0x02
	.byte _str_76,(_str_76 >> 8),#0x02
	.byte _str_77,(_str_77 >> 8),#0x02
	.db #0x01
	.db #0x24
	.byte _str_78,(_str_78 >> 8),#0x02
	.byte _str_79,(_str_79 >> 8),#0x02
	.byte _str_80,(_str_80 >> 8),#0x02
	.byte _str_81,(_str_81 >> 8),#0x02
	.db #0x01
	.db #0x09
	.byte _str_82,(_str_82 >> 8),#0x02
	.byte _str_83,(_str_83 >> 8),#0x02
	.byte _str_84,(_str_84 >> 8),#0x02
	.byte _str_85,(_str_85 >> 8),#0x02
	.db #0x01
	.db #0x12
	.byte _str_86,(_str_86 >> 8),#0x02
	.byte _str_87,(_str_87 >> 8),#0x02
	.byte _str_88,(_str_88 >> 8),#0x02
	.byte _str_89,(_str_89 >> 8),#0x02
	.db #0x01
	.db #0x24
	.byte _str_90,(_str_90 >> 8),#0x02
	.byte _str_91,(_str_91 >> 8),#0x02
	.byte _str_92,(_str_92 >> 8),#0x02
	.byte _str_93,(_str_93 >> 8),#0x02
	.db #0x01
	.db #0x08
	.byte _str_94,(_str_94 >> 8),#0x02
	.byte _str_95,(_str_95 >> 8),#0x02
	.byte _str_96,(_str_96 >> 8),#0x02
	.byte _str_97,(_str_97 >> 8),#0x02
	.db #0x01
	.db #0x11
	.byte _str_98,(_str_98 >> 8),#0x02
	.byte _str_99,(_str_99 >> 8),#0x02
	.byte _str_100,(_str_100 >> 8),#0x02
	.byte _str_101,(_str_101 >> 8),#0x02
	.db #0x01
	.db #0x1D
	.byte _str_102,(_str_102 >> 8),#0x02
	.byte _str_103,(_str_103 >> 8),#0x02
	.byte _str_104,(_str_104 >> 8),#0x02
	.byte _str_105,(_str_105 >> 8),#0x02
	.db #0x01
	.db #0x24
	.byte _str_106,(_str_106 >> 8),#0x02
	.byte _str_107,(_str_107 >> 8),#0x02
	.byte _str_108,(_str_108 >> 8),#0x02
	.byte _str_109,(_str_109 >> 8),#0x02
	.db #0x01
	.db #0x07
	.byte _str_110,(_str_110 >> 8),#0x02
	.byte _str_111,(_str_111 >> 8),#0x02
	.byte _str_112,(_str_112 >> 8),#0x02
	.byte _str_113,(_str_113 >> 8),#0x02
	.db #0x01
	.db #0x0E
	.byte _str_114,(_str_114 >> 8),#0x02
	.byte _str_115,(_str_115 >> 8),#0x02
	.byte _str_116,(_str_116 >> 8),#0x02
	.byte _str_117,(_str_117 >> 8),#0x02
	.db #0x01
	.db #0x15
	.byte _str_118,(_str_118 >> 8),#0x02
	.byte _str_119,(_str_119 >> 8),#0x02
	.byte _str_120,(_str_120 >> 8),#0x02
	.byte _str_121,(_str_121 >> 8),#0x02
	.db #0x01
	.db #0x1D
	.byte _str_122,(_str_122 >> 8),#0x02
	.byte _str_123,(_str_123 >> 8),#0x02
	.byte _str_124,(_str_124 >> 8),#0x02
	.byte _str_125,(_str_125 >> 8),#0x02
	.db #0x01
	.db #0x24
	.byte _str_126,(_str_126 >> 8),#0x02
	.byte _str_127,(_str_127 >> 8),#0x02
	.byte _str_128,(_str_128 >> 8),#0x02
	.byte _str_129,(_str_129 >> 8),#0x02
	.db #0x01
	.db #0x1C
	.byte _str_130,(_str_130 >> 8),#0x02
	.byte _str_131,(_str_131 >> 8),#0x02
	.byte _str_132,(_str_132 >> 8),#0x02
	.byte _str_133,(_str_133 >> 8),#0x02
	.db #0x01
	.db #0x00
	.byte _str_134,(_str_134 >> 8),#0x02
	.byte _str_135,(_str_135 >> 8),#0x02
	.byte _str_136,(_str_136 >> 8),#0x02
	.byte _str_137,(_str_137 >> 8),#0x02
	.db #0x01
	.db #0x0C
	.byte _str_138,(_str_138 >> 8),#0x02
	.byte _str_139,(_str_139 >> 8),#0x02
	.byte _str_140,(_str_140 >> 8),#0x02
	.byte _str_141,(_str_141 >> 8),#0x02
	.db #0x01
	.db #0x19
	.byte _str_142,(_str_142 >> 8),#0x02
	.byte _str_143,(_str_143 >> 8),#0x02
	.byte _str_144,(_str_144 >> 8),#0x02
	.byte _str_145,(_str_145 >> 8),#0x02
	.db #0x02
	.db #0x00
	.byte _str_146,(_str_146 >> 8),#0x02
	.byte _str_147,(_str_147 >> 8),#0x02
	.byte _str_148,(_str_148 >> 8),#0x02
	.byte _str_149,(_str_149 >> 8),#0x02
	.db #0x01
	.db #0x09
	.byte _str_150,(_str_150 >> 8),#0x02
	.byte _str_151,(_str_151 >> 8),#0x02
	.byte _str_152,(_str_152 >> 8),#0x02
	.byte _str_153,(_str_153 >> 8),#0x02
	.db #0x01
	.db #0x0F
	.byte _str_154,(_str_154 >> 8),#0x02
	.byte _str_155,(_str_155 >> 8),#0x02
	.byte _str_156,(_str_156 >> 8),#0x02
	.byte _str_157,(_str_157 >> 8),#0x02
	.db #0x01
	.db #0x16
	.byte _str_158,(_str_158 >> 8),#0x02
	.byte _str_159,(_str_159 >> 8),#0x02
	.byte _str_160,(_str_160 >> 8),#0x02
	.byte _str_161,(_str_161 >> 8),#0x02
	.db #0x01
	.db #0x1C
	.byte _str_162,(_str_162 >> 8),#0x02
	.byte _str_163,(_str_163 >> 8),#0x02
	.byte _str_164,(_str_164 >> 8),#0x02
	.byte _str_165,(_str_165 >> 8),#0x02
	.db #0x01
	.db #0x0F
	.byte _str_166,(_str_166 >> 8),#0x02
	.byte _str_167,(_str_167 >> 8),#0x02
	.byte _str_168,(_str_168 >> 8),#0x02
	.byte _str_169,(_str_169 >> 8),#0x02
	.db #0x01
	.db #0x15
	.byte _str_170,(_str_170 >> 8),#0x02
	.byte _str_171,(_str_171 >> 8),#0x02
	.byte _str_172,(_str_172 >> 8),#0x02
	.byte _str_173,(_str_173 >> 8),#0x02
	.db #0x01
	.db #0x05
	.byte _str_174,(_str_174 >> 8),#0x02
	.byte _str_175,(_str_175 >> 8),#0x02
	.byte _str_176,(_str_176 >> 8),#0x02
	.byte _str_177,(_str_177 >> 8),#0x02
	.db #0x01
	.db #0x08
	.byte _str_178,(_str_178 >> 8),#0x02
	.byte _str_179,(_str_179 >> 8),#0x02
	.byte _str_180,(_str_180 >> 8),#0x02
	.byte _str_181,(_str_181 >> 8),#0x02
	.db #0x01
	.db #0x13
	.byte _str_182,(_str_182 >> 8),#0x02
	.byte _str_183,(_str_183 >> 8),#0x02
	.byte _str_184,(_str_184 >> 8),#0x02
	.byte _str_185,(_str_185 >> 8),#0x02
	.db #0x01
	.db #0x1C
	.byte _str_186,(_str_186 >> 8),#0x02
	.byte _str_187,(_str_187 >> 8),#0x02
	.byte _str_188,(_str_188 >> 8),#0x02
	.byte _str_189,(_str_189 >> 8),#0x02
	.db #0x01
	.db #0x17
	.byte _str_190,(_str_190 >> 8),#0x02
	.byte _str_191,(_str_191 >> 8),#0x02
	.byte _str_192,(_str_192 >> 8),#0x02
	.byte _str_193,(_str_193 >> 8),#0x02
	.db #0x01
_dpl:
	.db #0xFF
	.db #0xFF
	.db #0xFF
	.byte _str_18,(_str_18 >> 8),#0x02
	.db #0x08
	.db #0x01
	.db #0x03
	.byte _str_194,(_str_194 >> 8),#0x02
	.db #0x0F
	.db #0x01
	.db #0x00
	.byte __str_7,(__str_7 >> 8),#0x02
	.db #0x15
	.db #0x01
	.db #0x03
	.byte _str_195,(_str_195 >> 8),#0x02
	.db #0x09
	.db #0x01
	.db #0x00
	.byte __str_7,(__str_7 >> 8),#0x02
	.db #0x0F
	.db #0x01
	.db #0x00
	.byte __str_7,(__str_7 >> 8),#0x02
	.db #0x16
	.db #0x01
	.db #0x00
	.byte __str_7,(__str_7 >> 8),#0x02
	.db #0x1C
	.db #0x01
	.db #0x00
	.byte __str_7,(__str_7 >> 8),#0x02
	.db #0x09
	.db #0x01
	.db #0x00
	.byte __str_7,(__str_7 >> 8),#0x02
	.db #0x12
	.db #0x01
	.db #0x00
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x08
	.db #0x01
	.db #0x00
	.byte _str_196,(_str_196 >> 8),#0x02
	.db #0x11
	.db #0x01
	.db #0x00
	.byte _str_197,(_str_197 >> 8),#0x02
	.db #0x1D
	.db #0x01
	.db #0x00
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x07
	.db #0x01
	.db #0x00
	.byte _str_198,(_str_198 >> 8),#0x02
	.db #0x0E
	.db #0x01
	.db #0x02
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x15
	.db #0x01
	.db #0x02
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x1D
	.db #0x01
	.db #0x00
	.byte __str_7,(__str_7 >> 8),#0x02
	.db #0x07
	.db #0x01
	.db #0x00
	.byte __str_7,(__str_7 >> 8),#0x02
	.db #0x0E
	.db #0x01
	.db #0x02
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x15
	.db #0x01
	.db #0x02
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x23
	.db #0x00
	.db #0x03
	.byte _str_199,(_str_199 >> 8),#0x02
	.db #0x26
	.db #0x00
	.db #0x00
	.byte __str_7,(__str_7 >> 8),#0x02
	.db #0x25
	.db #0x00
	.db #0x00
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x25
	.db #0x00
	.db #0x00
	.byte _str_200,(_str_200 >> 8),#0x02
	.db #0x25
	.db #0x01
	.db #0x00
	.byte _str_201,(_str_201 >> 8),#0x02
	.db #0x24
	.db #0x00
	.db #0x02
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x1C
	.db #0x01
	.db #0x00
	.byte _str_202,(_str_202 >> 8),#0x02
	.db #0x24
	.db #0x00
	.db #0x00
	.byte _str_203,(_str_203 >> 8),#0x02
	.db #0x00
	.db #0x01
	.db #0x00
	.byte _str_204,(_str_204 >> 8),#0x02
	.db #0x0C
	.db #0x01
	.db #0x00
	.byte _str_205,(_str_205 >> 8),#0x02
	.db #0x16
	.db #0x01
	.db #0x00
	.byte _str_206,(_str_206 >> 8),#0x02
	.db #0x0F
	.db #0x01
	.db #0x00
	.byte _str_207,(_str_207 >> 8),#0x02
	.db #0x00
	.db #0x01
	.db #0x00
	.byte _str_208,(_str_208 >> 8),#0x02
	.db #0x09
	.db #0x01
	.db #0x03
	.byte _str_209,(_str_209 >> 8),#0x02
	.db #0x25
	.db #0x00
	.db #0x00
	.byte _str_210,(_str_210 >> 8),#0x02
	.db #0x1E
	.db #0x00
	.db #0x00
	.byte __str_8,(__str_8 >> 8),#0x02
	.db #0x20
	.db #0x00
	.db #0x00
	.byte __str_9,(__str_9 >> 8),#0x02
	.db #0x1C
	.db #0x01
	.db #0x00
	.byte _str_211,(_str_211 >> 8),#0x02
	.db #0x1C
	.db #0x01
	.db #0x00
	.byte _str_212,(_str_212 >> 8),#0x02
	.db #0x15
	.db #0x01
	.db #0x00
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x08
	.db #0x01
	.db #0x00
	.byte __str_8,(__str_8 >> 8),#0x02
	.db #0x13
	.db #0x01
	.db #0x00
	.byte _str_213,(_str_213 >> 8),#0x02
	.db #0x1E
	.db #0x00
	.db #0x00
	.byte __str_8,(__str_8 >> 8),#0x02
	.db #0x24
	.db #0x00
	.db #0x00
	.byte _str_214,(_str_214 >> 8),#0x02
	.db #0x24
	.db #0x01
	.db #0x00
	.byte _str_215,(_str_215 >> 8),#0x02
	.db #0x1C
	.db #0x01
	.db #0x00
	.byte _str_216,(_str_216 >> 8),#0x02
	.db #0x1C
	.db #0x01
	.db #0x00
	.byte _str_217,(_str_217 >> 8),#0x02
	.db #0x00
	.db #0x01
	.db #0x02
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x07
	.db #0x01
	.db #0x02
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x0F
	.db #0x01
	.db #0x02
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x16
	.db #0x01
	.db #0x02
	.byte __str_1,(__str_1 >> 8),#0x02
	.db #0x17
	.db #0x01
	.db #0x02
	.byte _str_218,(_str_218 >> 8),#0x02
	.db #0x25
	.db #0x00
	.db #0x00
	.byte _str_219,(_str_219 >> 8),#0x02
	.db #0x00
	.db #0x01
	.db #0x00
	.byte _str_220,(_str_220 >> 8),#0x02
	.db #0x0E
	.db #0x01
	.db #0x00
	.byte _str_221,(_str_221 >> 8),#0x02
	.db #0x1C
	.db #0x01
	.db #0x00
	.byte _str_222,(_str_222 >> 8),#0x02
	.db #0x10
	.db #0x00
	.db #0x00
	.byte _str_223,(_str_223 >> 8),#0x02
_menu:
	.byte _str_224,(_str_224 >> 8),#0x02
	.db #0x05
	.db #0x00
	.db #0x01
	.byte (_bpr + 14),((_bpr + 14) >> 8),#0x02
	.byte (_dpl + 282),((_dpl + 282) >> 8),#0x02
	.db #0x00
	.db #0x02
	.byte (_bpr + 28),((_bpr + 28) >> 8),#0x02
	.byte (_dpl + 288),((_dpl + 288) >> 8),#0x02
	.db #0x00
	.db #0x03
	.byte (_bpr + 42),((_bpr + 42) >> 8),#0x02
	.byte (_dpl + 294),((_dpl + 294) >> 8),#0x02
	.db #0x00
	.db #0x04
	.byte (_bpr + 56),((_bpr + 56) >> 8),#0x02
	.byte (_dpl + 300),((_dpl + 300) >> 8),#0x02
	.db #0x00
	.db #0x05
	.byte (_bpr + 70),((_bpr + 70) >> 8),#0x02
	.byte (_dpl + 276),((_dpl + 276) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_225,(_str_225 >> 8),#0x02
	.db #0x04
	.db #0x00
	.db #0x06
	.byte (_bpr + 98),((_bpr + 98) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0x07
	.byte (_bpr + 112),((_bpr + 112) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0x08
	.byte (_bpr + 126),((_bpr + 126) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0xFE
	.byte (_bpr + 140),((_bpr + 140) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_226,(_str_226 >> 8),#0x02
	.db #0x04
	.db #0x00
	.db #0x09
	.byte (_bpr + 98),((_bpr + 98) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0x0A
	.byte (_bpr + 112),((_bpr + 112) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0x0B
	.byte (_bpr + 126),((_bpr + 126) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0xFE
	.byte (_bpr + 140),((_bpr + 140) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_227,(_str_227 >> 8),#0x02
	.db #0x04
	.db #0x00
	.db #0x0C
	.byte (_bpr + 98),((_bpr + 98) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0x0D
	.byte (_bpr + 112),((_bpr + 112) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0x0E
	.byte (_bpr + 126),((_bpr + 126) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0xFE
	.byte (_bpr + 140),((_bpr + 140) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_228,(_str_228 >> 8),#0x02
	.db #0x04
	.db #0x00
	.db #0x0F
	.byte (_bpr + 98),((_bpr + 98) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0x10
	.byte (_bpr + 112),((_bpr + 112) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0x11
	.byte (_bpr + 126),((_bpr + 126) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db #0x00
	.db #0xFE
	.byte (_bpr + 140),((_bpr + 140) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_229,(_str_229 >> 8),#0x02
	.db #0x04
	.db #0x00
	.db #0x36
	.byte (_bpr + 406),((_bpr + 406) >> 8),#0x02
	.byte (_dpl + 168),((_dpl + 168) >> 8),#0x02
	.db #0x00
	.db #0x37
	.byte (_bpr + 420),((_bpr + 420) >> 8),#0x02
	.byte (_dpl + 174),((_dpl + 174) >> 8),#0x02
	.db #0x00
	.db #0x39
	.byte (_bpr + 602),((_bpr + 602) >> 8),#0x02
	.byte (_dpl + 306),((_dpl + 306) >> 8),#0x02
	.db #0x00
	.db #0xFE
	.byte (_bpr + 378),((_bpr + 378) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_230,(_str_230 >> 8),#0x02
	.db #0x04
	.db #0x01
	.db #0x12
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x01
	.db #0x13
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x01
	.db #0x14
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x01
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_231,(_str_231 >> 8),#0x02
	.db #0x04
	.db #0x01
	.db #0x15
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x01
	.db #0x16
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x01
	.db #0x17
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x01
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_232,(_str_232 >> 8),#0x02
	.db #0x04
	.db #0x01
	.db #0x18
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x01
	.db #0x19
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x01
	.db #0x1A
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x01
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_233,(_str_233 >> 8),#0x02
	.db #0x04
	.db #0x02
	.db #0x1B
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x02
	.db #0x1C
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x02
	.db #0x1D
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x01
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_234,(_str_234 >> 8),#0x02
	.db #0x04
	.db #0x02
	.db #0x1E
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x02
	.db #0x1F
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x02
	.db #0x20
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x02
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_235,(_str_235 >> 8),#0x02
	.db #0x04
	.db #0x02
	.db #0x21
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x02
	.db #0x22
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x02
	.db #0x23
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x02
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_236,(_str_236 >> 8),#0x02
	.db #0x04
	.db #0x03
	.db #0x24
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x03
	.db #0x25
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x03
	.db #0x26
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x03
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_237,(_str_237 >> 8),#0x02
	.db #0x04
	.db #0x03
	.db #0x27
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x03
	.db #0x28
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x03
	.db #0x29
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x03
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_238,(_str_238 >> 8),#0x02
	.db #0x04
	.db #0x03
	.db #0x2A
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x03
	.db #0x2B
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x03
	.db #0x2C
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x03
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_239,(_str_239 >> 8),#0x02
	.db #0x04
	.db #0x04
	.db #0x2D
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x04
	.db #0x2E
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x04
	.db #0x2F
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x04
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_240,(_str_240 >> 8),#0x02
	.db #0x04
	.db #0x04
	.db #0x30
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x04
	.db #0x31
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x04
	.db #0x32
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x04
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_241,(_str_241 >> 8),#0x02
	.db #0x04
	.db #0x04
	.db #0x33
	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
	.db #0x04
	.db #0x34
	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
	.db #0x04
	.db #0x35
	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
	.db #0x04
	.db #0xFE
	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_242,(_str_242 >> 8),#0x02
	.db #0x02
	.db #0x06
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_243,(_str_243 >> 8),#0x02
	.db #0x02
	.db #0x06
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_244,(_str_244 >> 8),#0x02
	.db #0x02
	.db #0x06
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_245,(_str_245 >> 8),#0x02
	.db #0x02
	.db #0x07
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_246,(_str_246 >> 8),#0x02
	.db #0x02
	.db #0x07
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_247,(_str_247 >> 8),#0x02
	.db #0x02
	.db #0x07
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_248,(_str_248 >> 8),#0x02
	.db #0x02
	.db #0x08
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_249,(_str_249 >> 8),#0x02
	.db #0x02
	.db #0x08
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_250,(_str_250 >> 8),#0x02
	.db #0x02
	.db #0x08
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_251,(_str_251 >> 8),#0x02
	.db #0x02
	.db #0x09
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_252,(_str_252 >> 8),#0x02
	.db #0x02
	.db #0x09
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_253,(_str_253 >> 8),#0x02
	.db #0x02
	.db #0x09
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_254,(_str_254 >> 8),#0x02
	.db #0x02
	.db #0x0A
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_255,(_str_255 >> 8),#0x02
	.db #0x02
	.db #0x0A
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_256,(_str_256 >> 8),#0x02
	.db #0x02
	.db #0x0A
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_257,(_str_257 >> 8),#0x02
	.db #0x02
	.db #0x0B
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_258,(_str_258 >> 8),#0x02
	.db #0x02
	.db #0x0B
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_259,(_str_259 >> 8),#0x02
	.db #0x02
	.db #0x0B
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_260,(_str_260 >> 8),#0x02
	.db #0x02
	.db #0x0C
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_261,(_str_261 >> 8),#0x02
	.db #0x02
	.db #0x0C
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_262,(_str_262 >> 8),#0x02
	.db #0x02
	.db #0x0C
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_263,(_str_263 >> 8),#0x02
	.db #0x02
	.db #0x0D
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_264,(_str_264 >> 8),#0x02
	.db #0x02
	.db #0x0D
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_265,(_str_265 >> 8),#0x02
	.db #0x02
	.db #0x0D
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_266,(_str_266 >> 8),#0x02
	.db #0x02
	.db #0x0E
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_267,(_str_267 >> 8),#0x02
	.db #0x02
	.db #0x0E
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_268,(_str_268 >> 8),#0x02
	.db #0x02
	.db #0x0E
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_269,(_str_269 >> 8),#0x02
	.db #0x02
	.db #0x0F
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_270,(_str_270 >> 8),#0x02
	.db #0x02
	.db #0x0F
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_271,(_str_271 >> 8),#0x02
	.db #0x02
	.db #0x0F
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_272,(_str_272 >> 8),#0x02
	.db #0x02
	.db #0x10
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_273,(_str_273 >> 8),#0x02
	.db #0x02
	.db #0x10
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_274,(_str_274 >> 8),#0x02
	.db #0x02
	.db #0x10
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_275,(_str_275 >> 8),#0x02
	.db #0x02
	.db #0x11
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_276,(_str_276 >> 8),#0x02
	.db #0x02
	.db #0x11
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_277,(_str_277 >> 8),#0x02
	.db #0x02
	.db #0x11
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_278,(_str_278 >> 8),#0x02
	.db #0x02
	.db #0x05
	.db #0xFF
	.byte (_minmax + 12),((_minmax + 12) >> 8),#0x02
	.byte (_dpl + 210),((_dpl + 210) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_279,(_str_279 >> 8),#0x02
	.db #0x02
	.db #0x05
	.db #0xFF
	.byte (_minmax + 12),((_minmax + 12) >> 8),#0x02
	.byte (_dpl + 216),((_dpl + 216) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_280,(_str_280 >> 8),#0x02
	.db #0x02
	.db #0x00
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 204),((_dpl + 204) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.byte _str_281,(_str_281 >> 8),#0x02
	.db #0x02
	.db #0x05
	.db #0xFF
	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
	.byte (_dpl + 312),((_dpl + 312) >> 8),#0x02
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
__str_0:
	.ascii "Programowanie pamieci: (   ) z (%d). Prosze czekac ..."
	.db 0x00
__str_1:
	.ascii "%03u"
	.db 0x00
__str_2:
	.ascii "Odczyt ustawien: (   ) z (%d). Prosze czekac ..."
	.db 0x00
__str_3:
	.ascii "WYLACZONE  "
	.db 0x00
__str_4:
	.ascii "--"
	.db 0x00
__str_5:
	.ascii "%02u:%02u"
	.db 0x00
__str_6:
	.ascii "-"
	.db 0x00
__str_7:
	.ascii "%02u"
	.db 0x00
__str_8:
	.ascii "%04u-%02u-%02u"
	.db 0x00
__str_9:
	.ascii "%02u:%02u:%02u"
	.db 0x00
__str_10:
	.ascii ".%d"
	.db 0x00
__str_11:
	.ascii "+"
	.db 0x00
__str_12:
	.ascii "*"
	.db 0x00
__str_13:
	.ascii "#"
	.db 0x00
__str_14:
	.ascii "Test klawiatury, nacisnij dowolny klawisz ..."
	.db 0x00
__str_15:
	.ascii "Nacisnieto klawisz o kodzie: (%x)               "
	.db 0x00
__str_16:
	.ascii "%d."
	.db 0x00
__str_17:
	.ascii "%d"
	.db 0x00
_str_18:
	.db 0x00
_str_19:
	.db 0x00
_str_20:
	.db 0x00
_str_21:
	.db 0x00
_str_22:
	.ascii "Schody"
	.db 0x00
_str_23:
	.ascii "      "
	.db 0x00
_str_24:
	.db 0x00
_str_25:
	.db 0x00
_str_26:
	.ascii "Parking"
	.db 0x00
_str_27:
	.ascii "       "
	.db 0x00
_str_28:
	.db 0x00
_str_29:
	.db 0x00
_str_30:
	.ascii "Socjal"
	.db 0x00
_str_31:
	.ascii "      "
	.db 0x00
_str_32:
	.db 0x00
_str_33:
	.db 0x00
_str_34:
	.ascii "Magazyn"
	.db 0x00
_str_35:
	.ascii "       "
	.db 0x00
_str_36:
	.db 0x00
_str_37:
	.db 0x00
_str_38:
	.ascii "Zegar"
	.db 0x00
_str_39:
	.ascii "     "
	.db 0x00
_str_40:
	.db 0x00
_str_41:
	.db 0x00
_str_42:
	.ascii "System"
	.db 0x00
_str_43:
	.ascii "      "
	.db 0x00
_str_44:
	.ascii "Setup"
	.db 0x00
_str_45:
	.ascii "     "
	.db 0x00
_str_46:
	.ascii "Pon-Piatek"
	.db 0x00
_str_47:
	.ascii "          "
	.db 0x00
_str_48:
	.db 0x00
_str_49:
	.db 0x00
_str_50:
	.ascii "Sobota"
	.db 0x00
_str_51:
	.ascii "      "
	.db 0x00
_str_52:
	.db 0x00
_str_53:
	.db 0x00
_str_54:
	.ascii "Niedziela"
	.db 0x00
_str_55:
	.ascii "         "
	.db 0x00
_str_56:
	.db 0x00
_str_57:
	.db 0x00
_str_58:
	.ascii "WYJS"
	.db 0x00
_str_59:
	.ascii "    "
	.db 0x00
_str_60:
	.db 0x00
_str_61:
	.db 0x00
_str_62:
	.ascii "Z1"
	.db 0x00
_str_63:
	.ascii "  "
	.db 0x00
_str_64:
	.db 0x00
_str_65:
	.db 0x00
_str_66:
	.ascii "Z2"
	.db 0x00
_str_67:
	.ascii "  "
	.db 0x00
_str_68:
	.db 0x00
_str_69:
	.db 0x00
_str_70:
	.ascii "Z3"
	.db 0x00
_str_71:
	.ascii "  "
	.db 0x00
_str_72:
	.db 0x00
_str_73:
	.db 0x00
_str_74:
	.ascii "Ramp"
	.db 0x00
_str_75:
	.ascii "    "
	.db 0x00
_str_76:
	.db 0x00
_str_77:
	.db 0x00
_str_78:
	.ascii "WYJS"
	.db 0x00
_str_79:
	.ascii "    "
	.db 0x00
_str_80:
	.db 0x00
_str_81:
	.db 0x00
_str_82:
	.ascii "Enable"
	.db 0x00
_str_83:
	.ascii "      "
	.db 0x00
_str_84:
	.db 0x00
_str_85:
	.db 0x00
_str_86:
	.ascii "Roll Size"
	.db 0x00
_str_87:
	.ascii "         "
	.db 0x00
_str_88:
	.db 0x00
_str_89:
	.db 0x00
_str_90:
	.ascii "WYJS"
	.db 0x00
_str_91:
	.ascii "    "
	.db 0x00
_str_92:
	.db 0x00
_str_93:
	.db 0x00
_str_94:
	.ascii "Impress"
	.db 0x00
_str_95:
	.ascii "       "
	.db 0x00
_str_96:
	.db 0x00
_str_97:
	.db 0x00
_str_98:
	.ascii "Foil used"
	.db 0x00
_str_99:
	.ascii "         "
	.db 0x00
_str_100:
	.db 0x00
_str_101:
	.db 0x00
_str_102:
	.ascii "Reset"
	.db 0x00
_str_103:
	.ascii "     "
	.db 0x00
_str_104:
	.db 0x00
_str_105:
	.db 0x00
_str_106:
	.ascii "WYJS"
	.db 0x00
_str_107:
	.ascii "    "
	.db 0x00
_str_108:
	.db 0x00
_str_109:
	.db 0x00
_str_110:
	.ascii "Active"
	.db 0x00
_str_111:
	.ascii "      "
	.db 0x00
_str_112:
	.db 0x00
_str_113:
	.db 0x00
_str_114:
	.ascii "Offset"
	.db 0x00
_str_115:
	.ascii "      "
	.db 0x00
_str_116:
	.db 0x00
_str_117:
	.db 0x00
_str_118:
	.ascii "Overrun"
	.db 0x00
_str_119:
	.ascii "       "
	.db 0x00
_str_120:
	.db 0x00
_str_121:
	.db 0x00
_str_122:
	.ascii "Speed"
	.db 0x00
_str_123:
	.ascii "     "
	.db 0x00
_str_124:
	.db 0x00
_str_125:
	.db 0x00
_str_126:
	.ascii "WYJS"
	.db 0x00
_str_127:
	.ascii "    "
	.db 0x00
_str_128:
	.db 0x00
_str_129:
	.db 0x00
_str_130:
	.ascii "Delay"
	.db 0x00
_str_131:
	.ascii "     "
	.db 0x00
_str_132:
	.db 0x00
_str_133:
	.db 0x00
_str_134:
	.ascii "Data"
	.db 0x00
_str_135:
	.ascii "    "
	.db 0x00
_str_136:
	.db 0x00
_str_137:
	.db 0x00
_str_138:
	.ascii "Czas"
	.db 0x00
_str_139:
	.ascii "    "
	.db 0x00
_str_140:
	.db 0x00
_str_141:
	.db 0x00
_str_142:
	.ascii "System"
	.db 0x00
_str_143:
	.ascii "      "
	.db 0x00
_str_144:
	.ascii "Maintenance"
	.db 0x00
_str_145:
	.ascii "           "
	.db 0x00
_str_146:
	.ascii "B&H"
	.db 0x00
_str_147:
	.ascii "   "
	.db 0x00
_str_148:
	.db 0x00
_str_149:
	.db 0x00
_str_150:
	.ascii "Pull"
	.db 0x00
_str_151:
	.ascii "    "
	.db 0x00
_str_152:
	.db 0x00
_str_153:
	.db 0x00
_str_154:
	.ascii "Ratio"
	.db 0x00
_str_155:
	.ascii "     "
	.db 0x00
_str_156:
	.db 0x00
_str_157:
	.db 0x00
_str_158:
	.ascii "Holo"
	.db 0x00
_str_159:
	.ascii "    "
	.db 0x00
_str_160:
	.db 0x00
_str_161:
	.db 0x00
_str_162:
	.ascii "Total"
	.db 0x00
_str_163:
	.ascii "     "
	.db 0x00
_str_164:
	.db 0x00
_str_165:
	.db 0x00
_str_166:
	.ascii "Ramp"
	.db 0x00
_str_167:
	.ascii "    "
	.db 0x00
_str_168:
	.db 0x00
_str_169:
	.db 0x00
_str_170:
	.ascii "Initial speed"
	.db 0x00
_str_171:
	.ascii "             "
	.db 0x00
_str_172:
	.db 0x00
_str_173:
	.db 0x00
_str_174:
	.ascii "PM"
	.db 0x00
_str_175:
	.ascii "  "
	.db 0x00
_str_176:
	.db 0x00
_str_177:
	.db 0x00
_str_178:
	.ascii "Activation"
	.db 0x00
_str_179:
	.ascii "          "
	.db 0x00
_str_180:
	.db 0x00
_str_181:
	.db 0x00
_str_182:
	.ascii "Password"
	.db 0x00
_str_183:
	.ascii "        "
	.db 0x00
_str_184:
	.db 0x00
_str_185:
	.db 0x00
_str_186:
	.ascii "Status"
	.db 0x00
_str_187:
	.ascii "      "
	.db 0x00
_str_188:
	.db 0x00
_str_189:
	.db 0x00
_str_190:
	.ascii "Dzien"
	.db 0x00
_str_191:
	.ascii "     "
	.db 0x00
_str_192:
	.db 0x00
_str_193:
	.db 0x00
_str_194:
	.ascii "%04u"
	.db 0x00
_str_195:
	.ascii "%04u"
	.db 0x00
_str_196:
	.ascii "%07lu"
	.db 0x00
_str_197:
	.ascii "%04u"
	.db 0x00
_str_198:
	.ascii "%01u"
	.db 0x00
_str_199:
	.ascii "%04u"
	.db 0x00
_str_200:
	.ascii "%01u"
	.db 0x00
_str_201:
	.ascii "%01u"
	.db 0x00
_str_202:
	.ascii "%04u"
	.db 0x00
_str_203:
	.ascii "%04u"
	.db 0x00
_str_204:
	.ascii "NONE"
	.db 0x00
_str_205:
	.ascii "NONE"
	.db 0x00
_str_206:
	.ascii "%01u"
	.db 0x00
_str_207:
	.ascii "%01u"
	.db 0x00
_str_208:
	.ascii "%01u"
	.db 0x00
_str_209:
	.ascii "%04u"
	.db 0x00
_str_210:
	.ascii "%01u"
	.db 0x00
_str_211:
	.ascii "%08lu"
	.db 0x00
_str_212:
	.ascii "%08lu"
	.db 0x00
_str_213:
	.ascii "%04u"
	.db 0x00
_str_214:
	.ascii "%04u"
	.db 0x00
_str_215:
	.ascii "%04u"
	.db 0x00
_str_216:
	.ascii "%01u"
	.db 0x00
_str_217:
	.ascii "NONE"
	.db 0x00
_str_218:
	.ascii "NONE"
	.db 0x00
_str_219:
	.ascii "NONE"
	.db 0x00
_str_220:
	.ascii "NONE"
	.db 0x00
_str_221:
	.ascii "NONE"
	.db 0x00
_str_222:
	.ascii "NONE"
	.db 0x00
_str_223:
	.ascii "NONE"
	.db 0x00
_str_224:
	.ascii "Schody Parking Socjal Magazyn      Zegar                    "
	.ascii "                  "
	.db 0x00
_str_225:
	.ascii "Sch->Pon-Piatek  Sobota  Niedziela  WYJS"
	.db 0x00
_str_226:
	.ascii "Par->Pon-Piatek  Sobota  Niedziela  WYJS"
	.db 0x00
_str_227:
	.ascii "Soc->Pon-Piatek  Sobota  Niedziela  WYJS"
	.db 0x00
_str_228:
	.ascii "Mag->Pon-Piatek  Sobota  Niedziela  WYJS"
	.db 0x00
_str_229:
	.ascii "Data        Czas       Dzien        WYJS"
	.db 0x00
_str_230:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_231:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_232:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_233:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_234:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_235:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_236:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_237:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_238:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_239:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_240:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_241:
	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
	.db 0x00
_str_242:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_243:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_244:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_245:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_246:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_247:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_248:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_249:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_250:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_251:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_252:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_253:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_254:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_255:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_256:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_257:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_258:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_259:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_260:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_261:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_262:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_263:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_264:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_265:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_266:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_267:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_268:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_269:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_270:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_271:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_272:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_273:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_274:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_275:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_276:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_277:
	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
	.ascii "*-**:** Temp:    **C"
	.db 0x00
_str_278:
	.ascii "Current system DATE value   :              New value (YYYY-M"
	.ascii "M-DD)   : ****-**-**"
	.db 0x00
_str_279:
	.ascii "Current system TIME value   :                New value (HH:M"
	.ascii "M:SS)   :   **:**:**"
	.db 0x00
_str_280:
	.ascii " BATERIA ROZLADOWANA !!! WYMIEN BATERIE          ENTER ZEBY "
	.ascii "KONTYNUOWAC  !"
	.db 0x00
_str_281:
	.ascii "Ustaw dzien tygodnia       Biezacy:     uzywajac strzalek   "
	.ascii "          Nowy:  ***"
	.db 0x00
	.area XINIT   (CODE)
__xinit__battery_counter:
	.byte #0x00,#0x00
__xinit__update_flash:
	.db #0x00
