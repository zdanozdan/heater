                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.4.0 Thu Feb 10 12:42:24 2011
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module src/menu
                              7 	.optsdcc -mmcs51 --model-small
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _menu
                             13 	.globl _dpl
                             14 	.globl _bpr
                             15 	.globl _minmax
                             16 	.globl _dfp
                             17 	.globl _zone_day_map
                             18 	.globl _battery_test
                             19 	.globl _workloop
                             20 	.globl _date_workloop
                             21 	.globl _time_workloop
                             22 	.globl _zone_workloop
                             23 	.globl _read_keyboard_data_workloop
                             24 	.globl _weekday_worklop
                             25 	.globl _keypad_test_workloop
                             26 	.globl _reset_workloop
                             27 	.globl _check_external_events
                             28 	.globl _control_workloop
                             29 	.globl _is_day_matching
                             30 	.globl _display_enabled_channels
                             31 	.globl _switch_zone_prepare
                             32 	.globl _switch_zone
                             33 	.globl _display_stored_data
                             34 	.globl _display_stored_time
                             35 	.globl _display_zone_setings
                             36 	.globl _set_new_blink
                             37 	.globl _stack_purge
                             38 	.globl _stack_pop_front
                             39 	.globl _stack_push_back
                             40 	.globl _update_flash
                             41 	.globl _battery_counter
                             42 	.globl _system_time
                             43 	.globl _system_data
                             44 	.globl _stack
                             45 	.globl _ZONE_4_PREPARED
                             46 	.globl _ZONE_3_PREPARED
                             47 	.globl _ZONE_2_PREPARED
                             48 	.globl _ZONE_1_PREPARED
                             49 	.globl _temp_long
                             50 	.globl _enter_workloop
                             51 	.globl _key_code
                             52 	.globl _current_position
                             53 	.globl _current_display_state
                             54 	.globl _blinking
                             55 	.globl _current_blink_params
                             56 	.globl _flash_init
                             57 	.globl _menu_previous_position
                             58 	.globl _clear_zones
                             59 	.globl _main_program_workloop
                             60 ;--------------------------------------------------------
                             61 ; special function registers
                             62 ;--------------------------------------------------------
                    0080     63 _P0	=	0x0080
                    0081     64 _SP	=	0x0081
                    0082     65 _DPL	=	0x0082
                    0083     66 _DPH	=	0x0083
                    0087     67 _PCON	=	0x0087
                    0088     68 _TCON	=	0x0088
                    0089     69 _TMOD	=	0x0089
                    008A     70 _TL0	=	0x008a
                    008B     71 _TL1	=	0x008b
                    008C     72 _TH0	=	0x008c
                    008D     73 _TH1	=	0x008d
                    0090     74 _P1	=	0x0090
                    0098     75 _SCON	=	0x0098
                    0099     76 _SBUF	=	0x0099
                    00A0     77 _P2	=	0x00a0
                    00B0     78 _P3	=	0x00b0
                    00B8     79 _IP	=	0x00b8
                    00C8     80 _T2CON	=	0x00c8
                    00C9     81 _T2MOD	=	0x00c9
                    00CA     82 _RCAP2L	=	0x00ca
                    00CB     83 _RCAP2H	=	0x00cb
                    00CC     84 _TL2	=	0x00cc
                    00CD     85 _TH2	=	0x00cd
                    00D0     86 _PSW	=	0x00d0
                    00E0     87 _A	=	0x00e0
                    00A6     88 _WDTRST	=	0x00a6
                    00A7     89 _WDTPRG	=	0x00a7
                    00A2     90 _AUXR1	=	0x00a2
                    008E     91 _AUXR	=	0x008e
                    00B9     92 _SADEN	=	0x00b9
                    00BA     93 _SADEN_1	=	0x00ba
                    00B7     94 _IPH	=	0x00b7
                    00B7     95 _IPH0	=	0x00b7
                    00B8     96 _IPL	=	0x00b8
                    00B8     97 _IPL0	=	0x00b8
                    00A8     98 _IE	=	0x00a8
                    00A9     99 _SADDR	=	0x00a9
                    00AA    100 _SADDR_1	=	0x00aa
                    00D8    101 _CCON	=	0x00d8
                    00D9    102 _CMOD	=	0x00d9
                    00DA    103 _CCAPM0	=	0x00da
                    00DB    104 _CCAPM1	=	0x00db
                    00DC    105 _CCAPM2	=	0x00dc
                    00DD    106 _CCAPM3	=	0x00dd
                    00DE    107 _CCAPM4	=	0x00de
                    00E9    108 _CL	=	0x00e9
                    00EA    109 _CCAP0L	=	0x00ea
                    00EB    110 _CCAP1L	=	0x00eb
                    00EC    111 _CCAP2L	=	0x00ec
                    00ED    112 _CCAP3L	=	0x00ed
                    00EE    113 _CCAP4L	=	0x00ee
                    00E0    114 _ACC	=	0x00e0
                    00F0    115 _B	=	0x00f0
                    00F9    116 _CH	=	0x00f9
                    00FA    117 _CCAP0H	=	0x00fa
                    00FB    118 _CCAP1H	=	0x00fb
                    00FC    119 _CCAP2H	=	0x00fc
                    00FD    120 _CCAP3H	=	0x00fd
                    00FE    121 _CCAP4H	=	0x00fe
                    00FF    122 _ICON	=	0x00ff
                    0085    123 _CKSEL	=	0x0085
                    0086    124 _OSCCON	=	0x0086
                    00D1    125 _FCON	=	0x00d1
                    00D2    126 _EECON	=	0x00d2
                    00D3    127 _EETIM	=	0x00d3
                            128 ;--------------------------------------------------------
                            129 ; special function bits 
                            130 ;--------------------------------------------------------
                    0080    131 _P0_0	=	0x0080
                    0081    132 _P0_1	=	0x0081
                    0082    133 _P0_2	=	0x0082
                    0083    134 _P0_3	=	0x0083
                    0084    135 _P0_4	=	0x0084
                    0085    136 _P0_5	=	0x0085
                    0086    137 _P0_6	=	0x0086
                    0087    138 _P0_7	=	0x0087
                    00A7    139 _ENBOOT	=	0x00a7
                    0088    140 _IT0	=	0x0088
                    0089    141 _IE0	=	0x0089
                    008A    142 _IT1	=	0x008a
                    008B    143 _IE1	=	0x008b
                    008C    144 _TR0	=	0x008c
                    008D    145 _TF0	=	0x008d
                    008E    146 _TR1	=	0x008e
                    008F    147 _TF1	=	0x008f
                    0090    148 _P1_0	=	0x0090
                    0091    149 _P1_1	=	0x0091
                    0092    150 _P1_2	=	0x0092
                    0093    151 _P1_3	=	0x0093
                    0094    152 _P1_4	=	0x0094
                    0095    153 _P1_5	=	0x0095
                    0096    154 _P1_6	=	0x0096
                    0097    155 _P1_7	=	0x0097
                    0090    156 _T2	=	0x0090
                    0091    157 _T2EX	=	0x0091
                    0098    158 _RI	=	0x0098
                    0099    159 _TI	=	0x0099
                    009A    160 _RB8	=	0x009a
                    009B    161 _TB8	=	0x009b
                    009C    162 _REN	=	0x009c
                    009D    163 _SM2	=	0x009d
                    009E    164 _SM1	=	0x009e
                    009F    165 _SM0	=	0x009f
                    00A0    166 _P2_0	=	0x00a0
                    00A1    167 _P2_1	=	0x00a1
                    00A2    168 _P2_2	=	0x00a2
                    00A3    169 _P2_3	=	0x00a3
                    00A4    170 _P2_4	=	0x00a4
                    00A5    171 _P2_5	=	0x00a5
                    00A6    172 _P2_6	=	0x00a6
                    00A7    173 _P2_7	=	0x00a7
                    00B0    174 _P3_0	=	0x00b0
                    00B1    175 _P3_1	=	0x00b1
                    00B2    176 _P3_2	=	0x00b2
                    00B3    177 _P3_3	=	0x00b3
                    00B4    178 _P3_4	=	0x00b4
                    00B5    179 _P3_5	=	0x00b5
                    00B6    180 _P3_6	=	0x00b6
                    00B7    181 _P3_7	=	0x00b7
                    00B0    182 _RXD	=	0x00b0
                    00B1    183 _TXD	=	0x00b1
                    00B2    184 _INT0	=	0x00b2
                    00B3    185 _INT1	=	0x00b3
                    00B4    186 _T0	=	0x00b4
                    00B5    187 _T1	=	0x00b5
                    00B6    188 _WR	=	0x00b6
                    00B7    189 _RD	=	0x00b7
                    00B8    190 _PX0	=	0x00b8
                    00B9    191 _PT0	=	0x00b9
                    00BA    192 _PX1	=	0x00ba
                    00BB    193 _PT1	=	0x00bb
                    00BC    194 _PS	=	0x00bc
                    00BD    195 _PT2	=	0x00bd
                    00C8    196 _T2CON_0	=	0x00c8
                    00C9    197 _T2CON_1	=	0x00c9
                    00CA    198 _T2CON_2	=	0x00ca
                    00CB    199 _T2CON_3	=	0x00cb
                    00CC    200 _T2CON_4	=	0x00cc
                    00CD    201 _T2CON_5	=	0x00cd
                    00CE    202 _T2CON_6	=	0x00ce
                    00CF    203 _T2CON_7	=	0x00cf
                    00C8    204 _CP_RL2	=	0x00c8
                    00C9    205 _C_T2	=	0x00c9
                    00CA    206 _TR2	=	0x00ca
                    00CB    207 _EXEN2	=	0x00cb
                    00CC    208 _TCLK	=	0x00cc
                    00CD    209 _RCLK	=	0x00cd
                    00CE    210 _EXF2	=	0x00ce
                    00CF    211 _TF2	=	0x00cf
                    00D0    212 _P	=	0x00d0
                    00D1    213 _FL	=	0x00d1
                    00D2    214 _OV	=	0x00d2
                    00D3    215 _RS0	=	0x00d3
                    00D4    216 _RS1	=	0x00d4
                    00D5    217 _F0	=	0x00d5
                    00D6    218 _AC	=	0x00d6
                    00D7    219 _CY	=	0x00d7
                    00AF    220 _EA	=	0x00af
                    00AE    221 _EC	=	0x00ae
                    00AD    222 _ET2	=	0x00ad
                    00AC    223 _ES	=	0x00ac
                    00AB    224 _ET1	=	0x00ab
                    00AA    225 _EX1	=	0x00aa
                    00A9    226 _ET0	=	0x00a9
                    00A8    227 _EX0	=	0x00a8
                    00DF    228 _CF	=	0x00df
                    00DE    229 _CR	=	0x00de
                    00DC    230 _CCF4	=	0x00dc
                    00DB    231 _CCF3	=	0x00db
                    00DA    232 _CCF2	=	0x00da
                    00D9    233 _CCF1	=	0x00d9
                    00D8    234 _CCF0	=	0x00d8
                            235 ;--------------------------------------------------------
                            236 ; overlayable register banks 
                            237 ;--------------------------------------------------------
                            238 	.area REG_BANK_0	(REL,OVR,DATA)
   0000                     239 	.ds 8
                            240 ;--------------------------------------------------------
                            241 ; internal ram data
                            242 ;--------------------------------------------------------
                            243 	.area DSEG    (DATA)
   002D                     244 _current_blink_params::
   002D                     245 	.ds 3
   0030                     246 _blinking::
   0030                     247 	.ds 1
   0031                     248 _current_display_state::
   0031                     249 	.ds 1
   0032                     250 _current_position::
   0032                     251 	.ds 1
   0033                     252 _key_code::
   0033                     253 	.ds 1
   0034                     254 _enter_workloop::
   0034                     255 	.ds 1
   0035                     256 _temp_long::
   0035                     257 	.ds 4
   0039                     258 _ZONE_1_PREPARED::
   0039                     259 	.ds 1
   003A                     260 _ZONE_2_PREPARED::
   003A                     261 	.ds 1
   003B                     262 _ZONE_3_PREPARED::
   003B                     263 	.ds 1
   003C                     264 _ZONE_4_PREPARED::
   003C                     265 	.ds 1
   003D                     266 _display_stored_time_sec_1_1:
   003D                     267 	.ds 1
   003E                     268 _display_stored_data_sec_1_1:
   003E                     269 	.ds 1
   003F                     270 _display_enabled_channels_sec_1_1:
   003F                     271 	.ds 1
                            272 ;--------------------------------------------------------
                            273 ; overlayable items in internal ram 
                            274 ;--------------------------------------------------------
                            275 	.area OSEG    (OVR,DATA)
                            276 ;--------------------------------------------------------
                            277 ; indirectly addressable internal ram data
                            278 ;--------------------------------------------------------
                            279 	.area ISEG    (DATA)
                            280 ;--------------------------------------------------------
                            281 ; bit data
                            282 ;--------------------------------------------------------
                            283 	.area BSEG    (BIT)
                            284 ;--------------------------------------------------------
                            285 ; external ram data
                            286 ;--------------------------------------------------------
                            287 	.area XSEG    (XDATA)
   0003                     288 _stack::
   0003                     289 	.ds 10
   000D                     290 _system_data::
   000D                     291 	.ds 372
   0181                     292 _system_time::
   0181                     293 	.ds 12
                            294 ;--------------------------------------------------------
                            295 ; external initialized ram data
                            296 ;--------------------------------------------------------
                            297 	.area XISEG   (XDATA)
   018D                     298 _battery_counter::
   018D                     299 	.ds 2
   018F                     300 _update_flash::
   018F                     301 	.ds 1
                            302 ;--------------------------------------------------------
                            303 ; global & static initialisations
                            304 ;--------------------------------------------------------
                            305 	.area GSINIT  (CODE)
                            306 	.area GSFINAL (CODE)
                            307 	.area GSINIT  (CODE)
                            308 ;src/menu.c:30: volatile Blink_params * current_blink_params = NULL;
                            309 ;     genAssign
   772E E4                  310 	clr	a
   772F F5 2F               311 	mov	(_current_blink_params + 2),a
   7731 F5 2E               312 	mov	(_current_blink_params + 1),a
   7733 F5 2D               313 	mov	_current_blink_params,a
                            314 ;src/menu.c:31: volatile BOOL blinking = TRUE;
                            315 ;     genAssign
   7735 75 30 01            316 	mov	_blinking,#0x01
                            317 ;src/menu.c:32: unsigned char current_display_state = MAIN_STATE_ID;
                            318 ;     genAssign
   7738 75 31 00            319 	mov	_current_display_state,#0x00
                            320 ;src/menu.c:33: unsigned char current_position = MAIN_STATE_POS;
                            321 ;     genAssign
   773B 75 32 00            322 	mov	_current_position,#0x00
                            323 ;src/menu.c:34: unsigned char key_code = 0;
                            324 ;     genAssign
   773E 75 33 00            325 	mov	_key_code,#0x00
                            326 ;src/menu.c:45: unsigned char ZONE_1_PREPARED = 0;
                            327 ;     genAssign
   7741 75 39 00            328 	mov	_ZONE_1_PREPARED,#0x00
                            329 ;src/menu.c:46: unsigned char ZONE_2_PREPARED = 0;
                            330 ;     genAssign
   7744 75 3A 00            331 	mov	_ZONE_2_PREPARED,#0x00
                            332 ;src/menu.c:47: unsigned char ZONE_3_PREPARED = 0;
                            333 ;     genAssign
   7747 75 3B 00            334 	mov	_ZONE_3_PREPARED,#0x00
                            335 ;src/menu.c:48: unsigned char ZONE_4_PREPARED = 0;
                            336 ;     genAssign
   774A 75 3C 00            337 	mov	_ZONE_4_PREPARED,#0x00
                            338 ;--------------------------------------------------------
                            339 ; Home
                            340 ;--------------------------------------------------------
                            341 	.area HOME    (CODE)
                            342 	.area CSEG    (CODE)
                            343 ;--------------------------------------------------------
                            344 ; code
                            345 ;--------------------------------------------------------
                            346 	.area CSEG    (CODE)
                            347 ;------------------------------------------------------------
                            348 ;Allocation info for local variables in function 'stack_push_back'
                            349 ;------------------------------------------------------------
                            350 ;push                      Allocated to registers r2 
                            351 ;------------------------------------------------------------
                            352 ;src/menu.c:855: void stack_push_back(const unsigned char push)
                            353 ;	-----------------------------------------
                            354 ;	 function stack_push_back
                            355 ;	-----------------------------------------
   0CB8                     356 _stack_push_back:
                    0002    357 	ar2 = 0x02
                    0003    358 	ar3 = 0x03
                    0004    359 	ar4 = 0x04
                    0005    360 	ar5 = 0x05
                    0006    361 	ar6 = 0x06
                    0007    362 	ar7 = 0x07
                    0000    363 	ar0 = 0x00
                    0001    364 	ar1 = 0x01
   0CB8 C0 40               365 	push	_bp
   0CBA 85 81 40            366 	mov	_bp,sp
                            367 ;     genReceive
   0CBD AA 82               368 	mov	r2,dpl
                            369 ;src/menu.c:857: stack.buffer[ stack.head++ ] = push;
                            370 ;     genPointerGet
                            371 ;     genFarPointerGet
   0CBF 90 00 03            372 	mov	dptr,#_stack
   0CC2 E0                  373 	movx	a,@dptr
   0CC3 FB                  374 	mov	r3,a
                            375 ;     genPlus
                            376 ;     genPlusIncr
   0CC4 74 01               377 	mov	a,#0x01
                            378 ;       Peephole 236.a  used r3 instead of ar3
   0CC6 2B                  379 	add     a,r3
                            380 ;     genPointerSet
                            381 ;     genFarPointerSet
                            382 ;       Peephole 100    removed redundant mov
   0CC7 FC                  383 	mov     r4,a
   0CC8 90 00 03            384 	mov     dptr,#_stack
   0CCB F0                  385 	movx    @dptr,a
                            386 ;     genCast
   0CCC 7D 00               387 	mov	r5,#0x00
                            388 ;     genPlus
                            389 ;       Peephole 236.g  used r3 instead of ar3
   0CCE EB                  390 	mov     a,r3
   0CCF 24 05               391 	add	a,#(_stack + 0x0002)
   0CD1 F5 82               392 	mov	dpl,a
                            393 ;       Peephole 236.g  used r5 instead of ar5
   0CD3 ED                  394 	mov     a,r5
   0CD4 34 00               395 	addc	a,#((_stack + 0x0002) >> 8)
   0CD6 F5 83               396 	mov	dph,a
                            397 ;     genPointerSet
                            398 ;     genFarPointerSet
   0CD8 EA                  399 	mov	a,r2
   0CD9 F0                  400 	movx	@dptr,a
                            401 ;src/menu.c:858: stack.head &= ( STACK_SIZE - 1 );
                            402 ;     genAnd
   0CDA 53 04 07            403 	anl	ar4,#0x07
                            404 ;     genPointerSet
                            405 ;     genFarPointerSet
   0CDD 90 00 03            406 	mov	dptr,#_stack
   0CE0 EC                  407 	mov	a,r4
   0CE1 F0                  408 	movx	@dptr,a
   0CE2                     409 00101$:
   0CE2 85 40 81            410 	mov	sp,_bp
   0CE5 D0 40               411 	pop	_bp
   0CE7 22                  412 	ret
                            413 ;------------------------------------------------------------
                            414 ;Allocation info for local variables in function 'stack_pop_front'
                            415 ;------------------------------------------------------------
                            416 ;retval                    Allocated to registers r2 
                            417 ;------------------------------------------------------------
                            418 ;src/menu.c:870: unsigned char stack_pop_front(void)
                            419 ;	-----------------------------------------
                            420 ;	 function stack_pop_front
                            421 ;	-----------------------------------------
   0CE8                     422 _stack_pop_front:
   0CE8 C0 40               423 	push	_bp
   0CEA 85 81 40            424 	mov	_bp,sp
                            425 ;src/menu.c:872: unsigned char retval = 0;
                            426 ;     genAssign
   0CED 7A 00               427 	mov	r2,#0x00
                            428 ;src/menu.c:874: if (stack.head != stack.tail) 
                            429 ;     genPointerGet
                            430 ;     genFarPointerGet
   0CEF 90 00 03            431 	mov	dptr,#_stack
   0CF2 E0                  432 	movx	a,@dptr
   0CF3 FB                  433 	mov	r3,a
                            434 ;     genPointerGet
                            435 ;     genFarPointerGet
   0CF4 90 00 04            436 	mov	dptr,#(_stack + 0x0001)
   0CF7 E0                  437 	movx	a,@dptr
   0CF8 FC                  438 	mov	r4,a
                            439 ;     genCmpEq
   0CF9 EB                  440 	mov	a,r3
   0CFA B5 04 02            441 	cjne	a,ar4,00106$
                            442 ;       Peephole 112.b  changed ljmp to sjmp
   0CFD 80 20               443 	sjmp    00102$
   0CFF                     444 00106$:
                            445 ;src/menu.c:876: retval = stack.buffer[ --stack.head ];
                            446 ;     genMinus
                            447 ;     genMinusDec
   0CFF 1B                  448 	dec	r3
                            449 ;     genPointerSet
                            450 ;     genFarPointerSet
   0D00 90 00 03            451 	mov	dptr,#_stack
   0D03 EB                  452 	mov	a,r3
   0D04 F0                  453 	movx	@dptr,a
                            454 ;     genCast
   0D05 8B 04               455 	mov	ar4,r3
   0D07 7D 00               456 	mov	r5,#0x00
                            457 ;     genPlus
                            458 ;       Peephole 236.g  used r4 instead of ar4
   0D09 EC                  459 	mov     a,r4
   0D0A 24 05               460 	add	a,#(_stack + 0x0002)
   0D0C F5 82               461 	mov	dpl,a
                            462 ;       Peephole 236.g  used r5 instead of ar5
   0D0E ED                  463 	mov     a,r5
   0D0F 34 00               464 	addc	a,#((_stack + 0x0002) >> 8)
   0D11 F5 83               465 	mov	dph,a
                            466 ;     genPointerGet
                            467 ;     genFarPointerGet
   0D13 E0                  468 	movx	a,@dptr
   0D14 FC                  469 	mov	r4,a
                            470 ;     genAssign
   0D15 8C 02               471 	mov	ar2,r4
                            472 ;src/menu.c:877: stack.head &= ( STACK_SIZE - 1 );
                            473 ;     genAnd
   0D17 53 03 07            474 	anl	ar3,#0x07
                            475 ;     genPointerSet
                            476 ;     genFarPointerSet
   0D1A 90 00 03            477 	mov	dptr,#_stack
   0D1D EB                  478 	mov	a,r3
   0D1E F0                  479 	movx	@dptr,a
   0D1F                     480 00102$:
                            481 ;src/menu.c:880: return retval;
                            482 ;     genRet
   0D1F 8A 82               483 	mov	dpl,r2
   0D21                     484 00103$:
   0D21 85 40 81            485 	mov	sp,_bp
   0D24 D0 40               486 	pop	_bp
   0D26 22                  487 	ret
                            488 ;------------------------------------------------------------
                            489 ;Allocation info for local variables in function 'stack_purge'
                            490 ;------------------------------------------------------------
                            491 ;------------------------------------------------------------
                            492 ;src/menu.c:883: void stack_purge(void)
                            493 ;	-----------------------------------------
                            494 ;	 function stack_purge
                            495 ;	-----------------------------------------
   0D27                     496 _stack_purge:
   0D27 C0 40               497 	push	_bp
   0D29 85 81 40            498 	mov	_bp,sp
                            499 ;src/menu.c:885: stack.head = 0;
                            500 ;     genPointerSet
                            501 ;     genFarPointerSet
   0D2C 90 00 03            502 	mov	dptr,#_stack
                            503 ;       Peephole 181    changed mov to clr
                            504 ;src/menu.c:886: stack.tail = 0;
                            505 ;     genPointerSet
                            506 ;     genFarPointerSet
                            507 ;       Peephole 181    changed mov to clr
                            508 ;       Peephole 219    removed redundant clear
   0D2F E4                  509 	clr     a
   0D30 F0                  510 	movx    @dptr,a
   0D31 90 00 04            511 	mov     dptr,#(_stack + 0x0001)
   0D34 F0                  512 	movx    @dptr,a
   0D35                     513 00101$:
   0D35 85 40 81            514 	mov	sp,_bp
   0D38 D0 40               515 	pop	_bp
   0D3A 22                  516 	ret
                            517 ;------------------------------------------------------------
                            518 ;Allocation info for local variables in function 'flash_init'
                            519 ;------------------------------------------------------------
                            520 ;flash                     Allocated to registers r2 r3 r4 
                            521 ;xram                      Allocated to stack - offset 1
                            522 ;count                     Allocated to stack - offset 4
                            523 ;sloc0                     Allocated to stack - offset 6
                            524 ;sloc1                     Allocated to stack - offset 9
                            525 ;------------------------------------------------------------
                            526 ;src/menu.c:897: void flash_init(void)
                            527 ;	-----------------------------------------
                            528 ;	 function flash_init
                            529 ;	-----------------------------------------
   0D3B                     530 _flash_init:
   0D3B C0 40               531 	push	_bp
   0D3D 85 81 40            532 	mov	_bp,sp
   0D40 E5 81               533 	mov	a,sp
   0D42 24 0B               534 	add	a,#0x0b
   0D44 F5 81               535 	mov	sp,a
                            536 ;src/menu.c:899: unsigned char *flash = (unsigned char*)dfp;
                            537 ;     genAssign
   0D46 90 38 12            538 	mov	dptr,#_dfp
   0D49 E4                  539 	clr	a
   0D4A 93                  540 	movc	a,@a+dptr
   0D4B FA                  541 	mov	r2,a
   0D4C 74 01               542 	mov	a,#0x01
   0D4E 93                  543 	movc	a,@a+dptr
   0D4F FB                  544 	mov	r3,a
                            545 ;     genCast
   0D50 7C 02               546 	mov	r4,#0x2
                            547 ;src/menu.c:900: unsigned char *xram = (unsigned char*)system_data;
                            548 ;     genCast
                            549 ;       Peephole 212    reduced add sequence to inc
   0D52 A8 40               550 	mov     r0,_bp
   0D54 08                  551 	inc     r0
   0D55 76 0D               552 	mov	@r0,#_system_data
   0D57 08                  553 	inc	r0
   0D58 76 00               554 	mov	@r0,#(_system_data >> 8)
   0D5A 08                  555 	inc	r0
   0D5B 76 01               556 	mov	@r0,#0x1
                            557 ;src/menu.c:903: lcd_clear();
                            558 ;     genCall
   0D5D C0 02               559 	push	ar2
   0D5F C0 03               560 	push	ar3
   0D61 C0 04               561 	push	ar4
   0D63 12 0B 75            562 	lcall	_lcd_clear
   0D66 D0 04               563 	pop	ar4
   0D68 D0 03               564 	pop	ar3
   0D6A D0 02               565 	pop	ar2
                            566 ;src/menu.c:904: if (*flash == 0xFF) // In the first run when flash memory is cleared we need to set default values
                            567 ;     genPointerGet
                            568 ;     genGenPointerGet
   0D6C 8A 82               569 	mov	dpl,r2
   0D6E 8B 83               570 	mov	dph,r3
   0D70 8C F0               571 	mov	b,r4
   0D72 12 71 F5            572 	lcall	__gptrget
   0D75 FD                  573 	mov	r5,a
                            574 ;     genCmpEq
   0D76 BD FF 02            575 	cjne	r5,#0xFF,00119$
   0D79 80 03               576 	sjmp	00120$
   0D7B                     577 00119$:
   0D7B 02 0E 64            578 	ljmp	00102$
   0D7E                     579 00120$:
                            580 ;src/menu.c:906: printf_fast("Programowanie pamieci: (   ) z (%d). Prosze czekac ...", SYSTEM_DATA_SIZE);
                            581 ;     genIpush
   0D7E C0 02               582 	push	ar2
   0D80 C0 03               583 	push	ar3
   0D82 C0 04               584 	push	ar4
   0D84 74 74               585 	mov	a,#0x74
   0D86 C0 E0               586 	push	acc
   0D88 74 01               587 	mov	a,#0x01
   0D8A C0 E0               588 	push	acc
                            589 ;     genIpush
   0D8C 74 A6               590 	mov	a,#__str_0
   0D8E C0 E0               591 	push	acc
   0D90 74 49               592 	mov	a,#(__str_0 >> 8)
   0D92 C0 E0               593 	push	acc
                            594 ;     genCall
   0D94 12 72 21            595 	lcall	_printf_fast
   0D97 E5 81               596 	mov	a,sp
   0D99 24 FC               597 	add	a,#0xfc
   0D9B F5 81               598 	mov	sp,a
   0D9D D0 04               599 	pop	ar4
   0D9F D0 03               600 	pop	ar3
   0DA1 D0 02               601 	pop	ar2
                            602 ;src/menu.c:907: for (count=0 ; count < SYSTEM_DATA_SIZE; count++)
                            603 ;     genAssign
                            604 ;     genAssign
                            605 ;       Peephole 212    reduced add sequence to inc
   0DA3 A8 40               606 	mov     r0,_bp
   0DA5 08                  607 	inc     r0
   0DA6 E5 40               608 	mov	a,_bp
   0DA8 24 06               609 	add	a,#0x06
   0DAA F9                  610 	mov	r1,a
   0DAB E6                  611 	mov	a,@r0
   0DAC F7                  612 	mov	@r1,a
   0DAD 08                  613 	inc	r0
   0DAE 09                  614 	inc	r1
   0DAF E6                  615 	mov	a,@r0
   0DB0 F7                  616 	mov	@r1,a
   0DB1 08                  617 	inc	r0
   0DB2 09                  618 	inc	r1
   0DB3 E6                  619 	mov	a,@r0
   0DB4 F7                  620 	mov	@r1,a
                            621 ;     genAssign
   0DB5 E5 40               622 	mov	a,_bp
   0DB7 24 04               623 	add	a,#0x04
                            624 ;       Peephole 216    simplified clear (2bytes)
   0DB9 F8                  625 	mov     r0,a
   0DBA E4                  626 	clr     a
   0DBB F6                  627 	mov     @r0,a
   0DBC 08                  628 	inc     r0
   0DBD F6                  629 	mov     @r0,a
   0DBE                     630 00104$:
                            631 ;     genCmpLt
   0DBE E5 40               632 	mov	a,_bp
   0DC0 24 04               633 	add	a,#0x04
   0DC2 F8                  634 	mov	r0,a
                            635 ;     genCmp
   0DC3 C3                  636 	clr	c
   0DC4 E6                  637 	mov	a,@r0
   0DC5 94 74               638 	subb	a,#0x74
   0DC7 08                  639 	inc	r0
   0DC8 E6                  640 	mov	a,@r0
   0DC9 94 01               641 	subb	a,#0x01
                            642 ;     genIfxJump
   0DCB 40 03               643 	jc	00121$
   0DCD 02 0F 3D            644 	ljmp	00112$
   0DD0                     645 00121$:
                            646 ;src/menu.c:909: flash_write_byte(0x0, (unsigned int)flash++);
                            647 ;     genAssign
   0DD0 8A 07               648 	mov	ar7,r2
   0DD2 8B 05               649 	mov	ar5,r3
   0DD4 8C 06               650 	mov	ar6,r4
                            651 ;     genPlus
                            652 ;     genPlusIncr
   0DD6 0A                  653 	inc	r2
   0DD7 BA 00 01            654 	cjne	r2,#0x00,00122$
   0DDA 0B                  655 	inc	r3
   0DDB                     656 00122$:
                            657 ;     genCast
                            658 ;     genIpush
   0DDB C0 02               659 	push	ar2
   0DDD C0 03               660 	push	ar3
   0DDF C0 04               661 	push	ar4
   0DE1 C0 07               662 	push	ar7
   0DE3 C0 05               663 	push	ar5
                            664 ;     genCall
   0DE5 75 82 00            665 	mov	dpl,#0x00
   0DE8 12 00 F5            666 	lcall	_flash_write_byte
   0DEB 15 81               667 	dec	sp
   0DED 15 81               668 	dec	sp
   0DEF D0 04               669 	pop	ar4
   0DF1 D0 03               670 	pop	ar3
   0DF3 D0 02               671 	pop	ar2
                            672 ;src/menu.c:910: *xram++ = 0;
                            673 ;     genPointerSet
                            674 ;     genGenPointerSet
   0DF5 E5 40               675 	mov	a,_bp
   0DF7 24 06               676 	add	a,#0x06
   0DF9 F8                  677 	mov	r0,a
   0DFA 86 82               678 	mov	dpl,@r0
   0DFC 08                  679 	inc	r0
   0DFD 86 83               680 	mov	dph,@r0
   0DFF 08                  681 	inc	r0
   0E00 86 F0               682 	mov	b,@r0
                            683 ;       Peephole 181    changed mov to clr
   0E02 E4                  684 	clr     a
   0E03 12 70 71            685 	lcall	__gptrput
   0E06 A3                  686 	inc	dptr
   0E07 18                  687 	dec	r0
   0E08 18                  688 	dec	r0
   0E09 A6 82               689 	mov	@r0,dpl
   0E0B 08                  690 	inc	r0
   0E0C A6 83               691 	mov	@r0,dph
                            692 ;src/menu.c:911: lcd_goto_xy(24,0);
                            693 ;     genIpush
   0E0E C0 02               694 	push	ar2
   0E10 C0 03               695 	push	ar3
   0E12 C0 04               696 	push	ar4
                            697 ;       Peephole 181    changed mov to clr
   0E14 E4                  698 	clr     a
   0E15 C0 E0               699 	push	acc
                            700 ;     genCall
   0E17 75 82 18            701 	mov	dpl,#0x18
   0E1A 12 0A CD            702 	lcall	_lcd_goto_xy
   0E1D 15 81               703 	dec	sp
   0E1F D0 04               704 	pop	ar4
   0E21 D0 03               705 	pop	ar3
   0E23 D0 02               706 	pop	ar2
                            707 ;src/menu.c:912: printf_fast("%03u", count);
                            708 ;     genIpush
   0E25 C0 02               709 	push	ar2
   0E27 C0 03               710 	push	ar3
   0E29 C0 04               711 	push	ar4
   0E2B E5 40               712 	mov	a,_bp
   0E2D 24 04               713 	add	a,#0x04
   0E2F F8                  714 	mov	r0,a
   0E30 E6                  715 	mov	a,@r0
   0E31 C0 E0               716 	push	acc
   0E33 08                  717 	inc	r0
   0E34 E6                  718 	mov	a,@r0
   0E35 C0 E0               719 	push	acc
                            720 ;     genIpush
   0E37 74 DD               721 	mov	a,#__str_1
   0E39 C0 E0               722 	push	acc
   0E3B 74 49               723 	mov	a,#(__str_1 >> 8)
   0E3D C0 E0               724 	push	acc
                            725 ;     genCall
   0E3F 12 72 21            726 	lcall	_printf_fast
   0E42 E5 81               727 	mov	a,sp
   0E44 24 FC               728 	add	a,#0xfc
   0E46 F5 81               729 	mov	sp,a
   0E48 D0 04               730 	pop	ar4
   0E4A D0 03               731 	pop	ar3
   0E4C D0 02               732 	pop	ar2
                            733 ;src/menu.c:913: SERVICE_WATCHDOG;
                            734 ;     genAssign
   0E4E 75 A6 1E            735 	mov	_WDTRST,#0x1E
                            736 ;     genAssign
   0E51 75 A6 E1            737 	mov	_WDTRST,#0xE1
                            738 ;src/menu.c:907: for (count=0 ; count < SYSTEM_DATA_SIZE; count++)
                            739 ;     genPlus
   0E54 E5 40               740 	mov	a,_bp
   0E56 24 04               741 	add	a,#0x04
   0E58 F8                  742 	mov	r0,a
                            743 ;     genPlusIncr
   0E59 74 01               744 	mov	a,#0x01
   0E5B 26                  745 	add	a,@r0
   0E5C F6                  746 	mov	@r0,a
                            747 ;       Peephole 181    changed mov to clr
   0E5D E4                  748 	clr     a
   0E5E 08                  749 	inc	r0
   0E5F 36                  750 	addc	a,@r0
   0E60 F6                  751 	mov	@r0,a
   0E61 02 0D BE            752 	ljmp	00104$
   0E64                     753 00102$:
                            754 ;src/menu.c:918: lcd_goto_xy(0,0);
                            755 ;     genIpush
   0E64 C0 02               756 	push	ar2
   0E66 C0 03               757 	push	ar3
   0E68 C0 04               758 	push	ar4
                            759 ;       Peephole 181    changed mov to clr
   0E6A E4                  760 	clr     a
   0E6B C0 E0               761 	push	acc
                            762 ;     genCall
   0E6D 75 82 00            763 	mov	dpl,#0x00
   0E70 12 0A CD            764 	lcall	_lcd_goto_xy
   0E73 15 81               765 	dec	sp
   0E75 D0 04               766 	pop	ar4
   0E77 D0 03               767 	pop	ar3
   0E79 D0 02               768 	pop	ar2
                            769 ;src/menu.c:919: printf_fast("Odczyt ustawien: (   ) z (%d). Prosze czekac ...", SYSTEM_DATA_SIZE);
                            770 ;     genIpush
   0E7B C0 02               771 	push	ar2
   0E7D C0 03               772 	push	ar3
   0E7F C0 04               773 	push	ar4
   0E81 74 74               774 	mov	a,#0x74
   0E83 C0 E0               775 	push	acc
   0E85 74 01               776 	mov	a,#0x01
   0E87 C0 E0               777 	push	acc
                            778 ;     genIpush
   0E89 74 E2               779 	mov	a,#__str_2
   0E8B C0 E0               780 	push	acc
   0E8D 74 49               781 	mov	a,#(__str_2 >> 8)
   0E8F C0 E0               782 	push	acc
                            783 ;     genCall
   0E91 12 72 21            784 	lcall	_printf_fast
   0E94 E5 81               785 	mov	a,sp
   0E96 24 FC               786 	add	a,#0xfc
   0E98 F5 81               787 	mov	sp,a
   0E9A D0 04               788 	pop	ar4
   0E9C D0 03               789 	pop	ar3
   0E9E D0 02               790 	pop	ar2
                            791 ;src/menu.c:920: for (count=0 ; count < SYSTEM_DATA_SIZE; count++)
                            792 ;     genAssign
   0EA0 E5 40               793 	mov	a,_bp
   0EA2 24 09               794 	add	a,#0x09
   0EA4 F8                  795 	mov	r0,a
   0EA5 A6 02               796 	mov	@r0,ar2
   0EA7 08                  797 	inc	r0
   0EA8 A6 03               798 	mov	@r0,ar3
   0EAA 08                  799 	inc	r0
   0EAB A6 04               800 	mov	@r0,ar4
                            801 ;     genAssign
                            802 ;       Peephole 212    reduced add sequence to inc
   0EAD A8 40               803 	mov     r0,_bp
   0EAF 08                  804 	inc     r0
   0EB0 86 05               805 	mov	ar5,@r0
   0EB2 08                  806 	inc	r0
   0EB3 86 06               807 	mov	ar6,@r0
   0EB5 08                  808 	inc	r0
   0EB6 86 07               809 	mov	ar7,@r0
                            810 ;     genAssign
   0EB8 7A 00               811 	mov	r2,#0x00
   0EBA 7B 00               812 	mov	r3,#0x00
   0EBC                     813 00108$:
                            814 ;     genCmpLt
                            815 ;     genCmp
   0EBC C3                  816 	clr	c
   0EBD EA                  817 	mov	a,r2
   0EBE 94 74               818 	subb	a,#0x74
   0EC0 EB                  819 	mov	a,r3
   0EC1 94 01               820 	subb	a,#0x01
                            821 ;     genIfxJump
                            822 ;       Peephole 108    removed ljmp by inverse jump logic
   0EC3 50 78               823 	jnc     00112$
   0EC5                     824 00123$:
                            825 ;src/menu.c:922: lcd_goto_xy(18,0);
                            826 ;     genIpush
   0EC5 C0 02               827 	push	ar2
   0EC7 C0 03               828 	push	ar3
   0EC9 C0 05               829 	push	ar5
   0ECB C0 06               830 	push	ar6
   0ECD C0 07               831 	push	ar7
                            832 ;       Peephole 181    changed mov to clr
   0ECF E4                  833 	clr     a
   0ED0 C0 E0               834 	push	acc
                            835 ;     genCall
   0ED2 75 82 12            836 	mov	dpl,#0x12
   0ED5 12 0A CD            837 	lcall	_lcd_goto_xy
   0ED8 15 81               838 	dec	sp
   0EDA D0 07               839 	pop	ar7
   0EDC D0 06               840 	pop	ar6
   0EDE D0 05               841 	pop	ar5
   0EE0 D0 03               842 	pop	ar3
   0EE2 D0 02               843 	pop	ar2
                            844 ;src/menu.c:923: printf_fast("%03u", count);
                            845 ;     genIpush
   0EE4 C0 02               846 	push	ar2
   0EE6 C0 03               847 	push	ar3
   0EE8 C0 05               848 	push	ar5
   0EEA C0 06               849 	push	ar6
   0EEC C0 07               850 	push	ar7
   0EEE C0 02               851 	push	ar2
   0EF0 C0 03               852 	push	ar3
                            853 ;     genIpush
   0EF2 74 DD               854 	mov	a,#__str_1
   0EF4 C0 E0               855 	push	acc
   0EF6 74 49               856 	mov	a,#(__str_1 >> 8)
   0EF8 C0 E0               857 	push	acc
                            858 ;     genCall
   0EFA 12 72 21            859 	lcall	_printf_fast
   0EFD E5 81               860 	mov	a,sp
   0EFF 24 FC               861 	add	a,#0xfc
   0F01 F5 81               862 	mov	sp,a
   0F03 D0 07               863 	pop	ar7
   0F05 D0 06               864 	pop	ar6
   0F07 D0 05               865 	pop	ar5
   0F09 D0 03               866 	pop	ar3
   0F0B D0 02               867 	pop	ar2
                            868 ;src/menu.c:924: *xram++ = *flash++;
                            869 ;     genPointerGet
                            870 ;     genGenPointerGet
   0F0D E5 40               871 	mov	a,_bp
   0F0F 24 09               872 	add	a,#0x09
   0F11 F8                  873 	mov	r0,a
   0F12 86 82               874 	mov	dpl,@r0
   0F14 08                  875 	inc	r0
   0F15 86 83               876 	mov	dph,@r0
   0F17 08                  877 	inc	r0
   0F18 86 F0               878 	mov	b,@r0
   0F1A 12 71 F5            879 	lcall	__gptrget
   0F1D FC                  880 	mov	r4,a
   0F1E A3                  881 	inc	dptr
   0F1F 18                  882 	dec	r0
   0F20 18                  883 	dec	r0
   0F21 A6 82               884 	mov	@r0,dpl
   0F23 08                  885 	inc	r0
   0F24 A6 83               886 	mov	@r0,dph
                            887 ;     genPointerSet
                            888 ;     genGenPointerSet
   0F26 8D 82               889 	mov	dpl,r5
   0F28 8E 83               890 	mov	dph,r6
   0F2A 8F F0               891 	mov	b,r7
   0F2C EC                  892 	mov	a,r4
   0F2D 12 70 71            893 	lcall	__gptrput
   0F30 A3                  894 	inc	dptr
   0F31 AD 82               895 	mov	r5,dpl
   0F33 AE 83               896 	mov	r6,dph
                            897 ;src/menu.c:920: for (count=0 ; count < SYSTEM_DATA_SIZE; count++)
                            898 ;     genPlus
                            899 ;     genPlusIncr
   0F35 0A                  900 	inc	r2
   0F36 BA 00 01            901 	cjne	r2,#0x00,00124$
   0F39 0B                  902 	inc	r3
   0F3A                     903 00124$:
   0F3A 02 0E BC            904 	ljmp	00108$
   0F3D                     905 00112$:
   0F3D 85 40 81            906 	mov	sp,_bp
   0F40 D0 40               907 	pop	_bp
   0F42 22                  908 	ret
                            909 ;------------------------------------------------------------
                            910 ;Allocation info for local variables in function 'set_new_blink'
                            911 ;------------------------------------------------------------
                            912 ;------------------------------------------------------------
                            913 ;src/menu.c:937: void set_new_blink(void)
                            914 ;	-----------------------------------------
                            915 ;	 function set_new_blink
                            916 ;	-----------------------------------------
   0F43                     917 _set_new_blink:
   0F43 C0 40               918 	push	_bp
   0F45 85 81 40            919 	mov	_bp,sp
                            920 ;src/menu.c:939: BLINKING_OFF;
                            921 ;     genAssign
   0F48 75 30 00            922 	mov	_blinking,#0x00
                            923 ;src/menu.c:941: lcd_goto_xy(current_blink_params->position, 0);
                            924 ;     genAssign
   0F4B AA 2D               925 	mov	r2,_current_blink_params
   0F4D AB 2E               926 	mov	r3,(_current_blink_params + 1)
   0F4F AC 2F               927 	mov	r4,(_current_blink_params + 2)
                            928 ;     genPointerGet
                            929 ;     genGenPointerGet
   0F51 8A 82               930 	mov	dpl,r2
   0F53 8B 83               931 	mov	dph,r3
   0F55 8C F0               932 	mov	b,r4
   0F57 12 71 F5            933 	lcall	__gptrget
   0F5A FA                  934 	mov	r2,a
                            935 ;     genIpush
                            936 ;       Peephole 181    changed mov to clr
   0F5B E4                  937 	clr     a
   0F5C C0 E0               938 	push	acc
                            939 ;     genCall
   0F5E 8A 82               940 	mov	dpl,r2
   0F60 12 0A CD            941 	lcall	_lcd_goto_xy
   0F63 15 81               942 	dec	sp
                            943 ;src/menu.c:942: lcd_put_string(current_blink_params->first_pattern_on);
                            944 ;     genAssign
   0F65 AA 2D               945 	mov	r2,_current_blink_params
   0F67 AB 2E               946 	mov	r3,(_current_blink_params + 1)
   0F69 AC 2F               947 	mov	r4,(_current_blink_params + 2)
                            948 ;     genPlus
                            949 ;     genPlusIncr
   0F6B 0A                  950 	inc	r2
   0F6C BA 00 01            951 	cjne	r2,#0x00,00106$
   0F6F 0B                  952 	inc	r3
   0F70                     953 00106$:
                            954 ;     genPointerGet
                            955 ;     genGenPointerGet
   0F70 8A 82               956 	mov	dpl,r2
   0F72 8B 83               957 	mov	dph,r3
   0F74 8C F0               958 	mov	b,r4
   0F76 12 71 F5            959 	lcall	__gptrget
   0F79 FA                  960 	mov	r2,a
   0F7A A3                  961 	inc	dptr
   0F7B 12 71 F5            962 	lcall	__gptrget
   0F7E FB                  963 	mov	r3,a
   0F7F A3                  964 	inc	dptr
   0F80 12 71 F5            965 	lcall	__gptrget
   0F83 FC                  966 	mov	r4,a
                            967 ;     genCall
   0F84 8A 82               968 	mov	dpl,r2
   0F86 8B 83               969 	mov	dph,r3
   0F88 8C F0               970 	mov	b,r4
   0F8A 12 0B B6            971 	lcall	_lcd_put_string
                            972 ;src/menu.c:944: if (current_blink_params->lines > 1)
                            973 ;     genAssign
   0F8D AA 2D               974 	mov	r2,_current_blink_params
   0F8F AB 2E               975 	mov	r3,(_current_blink_params + 1)
   0F91 AC 2F               976 	mov	r4,(_current_blink_params + 2)
                            977 ;     genPlus
   0F93 74 0D               978 	mov	a,#0x0D
                            979 ;       Peephole 236.a  used r2 instead of ar2
   0F95 2A                  980 	add     a,r2
   0F96 FA                  981 	mov	r2,a
                            982 ;       Peephole 181    changed mov to clr
   0F97 E4                  983 	clr     a
                            984 ;       Peephole 236.b  used r3 instead of ar3
   0F98 3B                  985 	addc    a,r3
   0F99 FB                  986 	mov	r3,a
                            987 ;     genPointerGet
                            988 ;     genGenPointerGet
   0F9A 8A 82               989 	mov	dpl,r2
   0F9C 8B 83               990 	mov	dph,r3
   0F9E 8C F0               991 	mov	b,r4
   0FA0 12 71 F5            992 	lcall	__gptrget
   0FA3 FA                  993 	mov	r2,a
                            994 ;     genCmpGt
                            995 ;     genCmp
   0FA4 C3                  996 	clr	c
                            997 ;       Peephole 159    avoided xrl during execution
   0FA5 74 81               998 	mov  a,#(0x01 ^ 0x80)
   0FA7 8A F0               999 	mov	b,r2
   0FA9 63 F0 80           1000 	xrl	b,#0x80
   0FAC 95 F0              1001 	subb	a,b
                           1002 ;     genIfxJump
                           1003 ;       Peephole 108    removed ljmp by inverse jump logic
   0FAE 50 45              1004 	jnc     00102$
   0FB0                    1005 00107$:
                           1006 ;src/menu.c:946: lcd_goto_xy(current_blink_params->position, 1);
                           1007 ;     genAssign
   0FB0 AA 2D              1008 	mov	r2,_current_blink_params
   0FB2 AB 2E              1009 	mov	r3,(_current_blink_params + 1)
   0FB4 AC 2F              1010 	mov	r4,(_current_blink_params + 2)
                           1011 ;     genPointerGet
                           1012 ;     genGenPointerGet
   0FB6 8A 82              1013 	mov	dpl,r2
   0FB8 8B 83              1014 	mov	dph,r3
   0FBA 8C F0              1015 	mov	b,r4
   0FBC 12 71 F5           1016 	lcall	__gptrget
   0FBF FA                 1017 	mov	r2,a
                           1018 ;     genIpush
   0FC0 74 01              1019 	mov	a,#0x01
   0FC2 C0 E0              1020 	push	acc
                           1021 ;     genCall
   0FC4 8A 82              1022 	mov	dpl,r2
   0FC6 12 0A CD           1023 	lcall	_lcd_goto_xy
   0FC9 15 81              1024 	dec	sp
                           1025 ;src/menu.c:947: lcd_put_string(current_blink_params->second_pattern_on);
                           1026 ;     genAssign
   0FCB AA 2D              1027 	mov	r2,_current_blink_params
   0FCD AB 2E              1028 	mov	r3,(_current_blink_params + 1)
   0FCF AC 2F              1029 	mov	r4,(_current_blink_params + 2)
                           1030 ;     genPlus
   0FD1 74 07              1031 	mov	a,#0x07
                           1032 ;       Peephole 236.a  used r2 instead of ar2
   0FD3 2A                 1033 	add     a,r2
   0FD4 FA                 1034 	mov	r2,a
                           1035 ;       Peephole 181    changed mov to clr
   0FD5 E4                 1036 	clr     a
                           1037 ;       Peephole 236.b  used r3 instead of ar3
   0FD6 3B                 1038 	addc    a,r3
   0FD7 FB                 1039 	mov	r3,a
                           1040 ;     genPointerGet
                           1041 ;     genGenPointerGet
   0FD8 8A 82              1042 	mov	dpl,r2
   0FDA 8B 83              1043 	mov	dph,r3
   0FDC 8C F0              1044 	mov	b,r4
   0FDE 12 71 F5           1045 	lcall	__gptrget
   0FE1 FA                 1046 	mov	r2,a
   0FE2 A3                 1047 	inc	dptr
   0FE3 12 71 F5           1048 	lcall	__gptrget
   0FE6 FB                 1049 	mov	r3,a
   0FE7 A3                 1050 	inc	dptr
   0FE8 12 71 F5           1051 	lcall	__gptrget
   0FEB FC                 1052 	mov	r4,a
                           1053 ;     genCall
   0FEC 8A 82              1054 	mov	dpl,r2
   0FEE 8B 83              1055 	mov	dph,r3
   0FF0 8C F0              1056 	mov	b,r4
   0FF2 12 0B B6           1057 	lcall	_lcd_put_string
   0FF5                    1058 00102$:
                           1059 ;src/menu.c:949: current_blink_params = menu[current_display_state].item[current_position].blink_union.blink;
                           1060 ;     genMult
                           1061 ;     genMultOneByte
   0FF5 E5 31              1062 	mov	a,_current_display_state
   0FF7 75 F0 3C           1063 	mov	b,#0x3C
   0FFA A4                 1064 	mul	ab
                           1065 ;     genPlus
   0FFB 24 0E              1066 	add	a,#_menu
   0FFD FA                 1067 	mov	r2,a
   0FFE E5 F0              1068 	mov	a,b
   1000 34 3C              1069 	addc	a,#(_menu >> 8)
   1002 FB                 1070 	mov	r3,a
                           1071 ;     genPlus
                           1072 ;     genPlusIncr
   1003 74 04              1073 	mov	a,#0x04
                           1074 ;       Peephole 236.a  used r2 instead of ar2
   1005 2A                 1075 	add     a,r2
   1006 FA                 1076 	mov	r2,a
                           1077 ;       Peephole 181    changed mov to clr
   1007 E4                 1078 	clr     a
                           1079 ;       Peephole 236.b  used r3 instead of ar3
   1008 3B                 1080 	addc    a,r3
   1009 FB                 1081 	mov	r3,a
                           1082 ;     genMult
                           1083 ;     genMultOneByte
   100A E5 32              1084 	mov	a,_current_position
   100C 75 F0 08           1085 	mov	b,#0x08
   100F A4                 1086 	mul	ab
                           1087 ;     genPlus
                           1088 ;       Peephole 236.a  used r2 instead of ar2
   1010 2A                 1089 	add     a,r2
   1011 FA                 1090 	mov	r2,a
   1012 E5 F0              1091 	mov	a,b
                           1092 ;       Peephole 236.b  used r3 instead of ar3
   1014 3B                 1093 	addc    a,r3
   1015 FB                 1094 	mov	r3,a
                           1095 ;     genPlus
                           1096 ;     genPlusIncr
   1016 74 02              1097 	mov	a,#0x02
                           1098 ;       Peephole 236.a  used r2 instead of ar2
   1018 2A                 1099 	add     a,r2
   1019 F5 82              1100 	mov	dpl,a
                           1101 ;       Peephole 181    changed mov to clr
   101B E4                 1102 	clr     a
                           1103 ;       Peephole 236.b  used r3 instead of ar3
   101C 3B                 1104 	addc    a,r3
   101D F5 83              1105 	mov	dph,a
                           1106 ;     genPointerGet
                           1107 ;     genCodePointerGet
                           1108 ;       Peephole 181    changed mov to clr
   101F E4                 1109 	clr     a
   1020 93                 1110 	movc	a,@a+dptr
   1021 F5 2D              1111 	mov	_current_blink_params,a
   1023 74 01              1112 	mov	a,#0x01
   1025 93                 1113 	movc	a,@a+dptr
   1026 F5 2E              1114 	mov	(_current_blink_params + 1),a
   1028 74 02              1115 	mov	a,#0x02
   102A 93                 1116 	movc	a,@a+dptr
   102B F5 2F              1117 	mov	(_current_blink_params + 2),a
                           1118 ;src/menu.c:951: BLINKING_ON;
                           1119 ;     genAssign
   102D 75 30 01           1120 	mov	_blinking,#0x01
   1030                    1121 00103$:
   1030 85 40 81           1122 	mov	sp,_bp
   1033 D0 40              1123 	pop	_bp
   1035 22                 1124 	ret
                           1125 ;------------------------------------------------------------
                           1126 ;Allocation info for local variables in function 'display_zone_setings'
                           1127 ;------------------------------------------------------------
                           1128 ;zone                      Allocated to stack - offset 1
                           1129 ;display                   Allocated to stack - offset 2
                           1130 ;i                         Allocated to stack - offset 5
                           1131 ;------------------------------------------------------------
                           1132 ;src/menu.c:990: void display_zone_setings(const char zone)
                           1133 ;	-----------------------------------------
                           1134 ;	 function display_zone_setings
                           1135 ;	-----------------------------------------
   1036                    1136 _display_zone_setings:
   1036 C0 40              1137 	push	_bp
   1038 85 81 40           1138 	mov	_bp,sp
   103B E5 81              1139 	mov	a,sp
   103D 24 05              1140 	add	a,#0x05
   103F F5 81              1141 	mov	sp,a
                           1142 ;     genReceive
   1041 C0 E0              1143 	push	acc
                           1144 ;       Peephole 212    reduced add sequence to inc
   1043 A8 40              1145 	mov     r0,_bp
   1045 08                 1146 	inc     r0
   1046 D0 E0              1147 	pop	acc
   1048 A6 82              1148 	mov	@r0,dpl
                           1149 ;src/menu.c:995: BLINKING_OFF;
                           1150 ;     genAssign
   104A 75 30 00           1151 	mov	_blinking,#0x00
                           1152 ;src/menu.c:997: ds1302_read_rtc(&system_time);
                           1153 ;     genCall
                           1154 ;       Peephole 182.a  used 16 bit load of DPTR
   104D 90 01 81           1155 	mov     dptr,#_system_time
   1050 75 F0 01           1156 	mov	b,#0x01
   1053 12 5E A7           1157 	lcall	_ds1302_read_rtc
                           1158 ;src/menu.c:999: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
                           1159 ;     genAssign
   1056 E5 40              1160 	mov	a,_bp
   1058 24 05              1161 	add	a,#0x05
   105A F8                 1162 	mov	r0,a
   105B 76 00              1163 	mov	@r0,#0x00
   105D                    1164 00104$:
                           1165 ;     genIpush
                           1166 ;     genMult
                           1167 ;     genMultOneByte
   105D E5 31              1168 	mov	a,_current_display_state
   105F 75 F0 3C           1169 	mov	b,#0x3C
   1062 A4                 1170 	mul	ab
                           1171 ;     genPlus
   1063 24 0E              1172 	add	a,#_menu
   1065 FC                 1173 	mov	r4,a
   1066 E5 F0              1174 	mov	a,b
   1068 34 3C              1175 	addc	a,#(_menu >> 8)
   106A FD                 1176 	mov	r5,a
                           1177 ;     genPlus
                           1178 ;     genPlusIncr
   106B 74 03              1179 	mov	a,#0x03
                           1180 ;       Peephole 236.a  used r4 instead of ar4
   106D 2C                 1181 	add     a,r4
   106E F5 82              1182 	mov	dpl,a
                           1183 ;       Peephole 181    changed mov to clr
   1070 E4                 1184 	clr     a
                           1185 ;       Peephole 236.b  used r5 instead of ar5
   1071 3D                 1186 	addc    a,r5
   1072 F5 83              1187 	mov	dph,a
                           1188 ;     genPointerGet
                           1189 ;     genCodePointerGet
                           1190 ;       Peephole 181    changed mov to clr
   1074 E4                 1191 	clr     a
   1075 93                 1192 	movc	a,@a+dptr
                           1193 ;     genCast
                           1194 ;       Peephole 105    removed redundant mov
   1076 FE                 1195 	mov     r6,a
   1077 33                 1196 	rlc	a
   1078 95 E0              1197 	subb	a,acc
   107A FF                 1198 	mov	r7,a
                           1199 ;     genMinus
                           1200 ;     genMinusDec
   107B 1E                 1201 	dec	r6
   107C BE FF 01           1202 	cjne	r6,#0xff,00113$
   107F 1F                 1203 	dec	r7
   1080                    1204 00113$:
                           1205 ;     genCast
   1080 E5 40              1206 	mov	a,_bp
   1082 24 05              1207 	add	a,#0x05
   1084 F8                 1208 	mov	r0,a
   1085 86 02              1209 	mov	ar2,@r0
   1087 7B 00              1210 	mov	r3,#0x00
                           1211 ;     genCmpLt
                           1212 ;     genCmp
   1089 C3                 1213 	clr	c
   108A EA                 1214 	mov	a,r2
   108B 9E                 1215 	subb	a,r6
   108C EB                 1216 	mov	a,r3
   108D 64 80              1217 	xrl	a,#0x80
   108F 8F F0              1218 	mov	b,r7
   1091 63 F0 80           1219 	xrl	b,#0x80
   1094 95 F0              1220 	subb	a,b
                           1221 ;     genIpop
                           1222 ;     genIfx
                           1223 ;     genIfxJump
                           1224 ;       Peephole 129    jump optimization
   1096 40 03              1225 	jc      00114$
   1098 02 12 C5           1226 	ljmp	00107$
   109B                    1227 00114$:
                           1228 ;src/menu.c:1001: display = menu[current_display_state].item[i].display;
                           1229 ;     genPlus
                           1230 ;     genPlusIncr
   109B 74 04              1231 	mov	a,#0x04
                           1232 ;       Peephole 236.a  used r4 instead of ar4
   109D 2C                 1233 	add     a,r4
   109E FC                 1234 	mov	r4,a
                           1235 ;       Peephole 181    changed mov to clr
   109F E4                 1236 	clr     a
                           1237 ;       Peephole 236.b  used r5 instead of ar5
   10A0 3D                 1238 	addc    a,r5
   10A1 FD                 1239 	mov	r5,a
                           1240 ;     genMult
   10A2 E5 40              1241 	mov	a,_bp
   10A4 24 05              1242 	add	a,#0x05
   10A6 F8                 1243 	mov	r0,a
                           1244 ;     genMultOneByte
   10A7 E6                 1245 	mov	a,@r0
   10A8 75 F0 08           1246 	mov	b,#0x08
   10AB A4                 1247 	mul	ab
                           1248 ;     genPlus
                           1249 ;       Peephole 236.a  used r4 instead of ar4
   10AC 2C                 1250 	add     a,r4
   10AD FC                 1251 	mov	r4,a
   10AE E5 F0              1252 	mov	a,b
                           1253 ;       Peephole 236.b  used r5 instead of ar5
   10B0 3D                 1254 	addc    a,r5
   10B1 FD                 1255 	mov	r5,a
                           1256 ;     genPlus
   10B2 74 05              1257 	mov	a,#0x05
                           1258 ;       Peephole 236.a  used r4 instead of ar4
   10B4 2C                 1259 	add     a,r4
   10B5 F5 82              1260 	mov	dpl,a
                           1261 ;       Peephole 181    changed mov to clr
   10B7 E4                 1262 	clr     a
                           1263 ;       Peephole 236.b  used r5 instead of ar5
   10B8 3D                 1264 	addc    a,r5
   10B9 F5 83              1265 	mov	dph,a
                           1266 ;     genPointerGet
                           1267 ;     genCodePointerGet
                           1268 ;       Peephole 181    changed mov to clr
   10BB E4                 1269 	clr     a
   10BC 93                 1270 	movc	a,@a+dptr
   10BD FB                 1271 	mov	r3,a
   10BE 74 01              1272 	mov	a,#0x01
   10C0 93                 1273 	movc	a,@a+dptr
   10C1 FC                 1274 	mov	r4,a
   10C2 74 02              1275 	mov	a,#0x02
   10C4 93                 1276 	movc	a,@a+dptr
   10C5 FD                 1277 	mov	r5,a
                           1278 ;     genAssign
   10C6 E5 40              1279 	mov	a,_bp
   10C8 24 02              1280 	add	a,#0x02
   10CA F8                 1281 	mov	r0,a
   10CB A6 03              1282 	mov	@r0,ar3
   10CD 08                 1283 	inc	r0
   10CE A6 04              1284 	mov	@r0,ar4
   10D0 08                 1285 	inc	r0
   10D1 A6 05              1286 	mov	@r0,ar5
                           1287 ;src/menu.c:1002: lcd_goto_xy(display->x, display->y);
                           1288 ;     genPlus
   10D3 E5 40              1289 	mov	a,_bp
   10D5 24 02              1290 	add	a,#0x02
   10D7 F8                 1291 	mov	r0,a
                           1292 ;     genPlusIncr
   10D8 74 01              1293 	mov	a,#0x01
   10DA 26                 1294 	add	a,@r0
   10DB FE                 1295 	mov	r6,a
                           1296 ;       Peephole 181    changed mov to clr
   10DC E4                 1297 	clr     a
   10DD 08                 1298 	inc	r0
   10DE 36                 1299 	addc	a,@r0
   10DF FF                 1300 	mov	r7,a
   10E0 08                 1301 	inc	r0
   10E1 86 02              1302 	mov	ar2,@r0
                           1303 ;     genPointerGet
                           1304 ;     genGenPointerGet
   10E3 8E 82              1305 	mov	dpl,r6
   10E5 8F 83              1306 	mov	dph,r7
   10E7 8A F0              1307 	mov	b,r2
   10E9 12 71 F5           1308 	lcall	__gptrget
   10EC FE                 1309 	mov	r6,a
                           1310 ;     genPointerGet
                           1311 ;     genGenPointerGet
   10ED E5 40              1312 	mov	a,_bp
   10EF 24 02              1313 	add	a,#0x02
   10F1 F8                 1314 	mov	r0,a
   10F2 86 82              1315 	mov	dpl,@r0
   10F4 08                 1316 	inc	r0
   10F5 86 83              1317 	mov	dph,@r0
   10F7 08                 1318 	inc	r0
   10F8 86 F0              1319 	mov	b,@r0
   10FA 12 71 F5           1320 	lcall	__gptrget
   10FD FA                 1321 	mov	r2,a
                           1322 ;     genIpush
   10FE C0 06              1323 	push	ar6
                           1324 ;     genCall
   1100 8A 82              1325 	mov	dpl,r2
   1102 12 0A CD           1326 	lcall	_lcd_goto_xy
   1105 15 81              1327 	dec	sp
                           1328 ;src/menu.c:1004: if (system_data.zone_settings[zone+i].start_time == 0)
                           1329 ;     genPlus
                           1330 ;       Peephole 212    reduced add sequence to inc
   1107 A8 40              1331 	mov     r0,_bp
   1109 08                 1332 	inc     r0
   110A E5 40              1333 	mov	a,_bp
   110C 24 05              1334 	add	a,#0x05
   110E F9                 1335 	mov	r1,a
   110F E7                 1336 	mov	a,@r1
   1110 26                 1337 	add	a,@r0
                           1338 ;     genMult
                           1339 ;     genMultOneByte
   1111 C2 D5              1340 	clr	F0
   1113 75 F0 0A           1341 	mov	b,#0x0a
   1116 30 E7 04           1342 	jnb	acc.7,00115$
   1119 B2 D5              1343 	cpl	F0
   111B F4                 1344 	cpl	a
   111C 04                 1345 	inc	a
   111D                    1346 00115$:
   111D A4                 1347 	mul	ab
   111E 30 D5 0A           1348 	jnb	F0,00116$
   1121 F4                 1349 	cpl	a
   1122 24 01              1350 	add	a,#1
   1124 C5 F0              1351 	xch	a,b
   1126 F4                 1352 	cpl	a
   1127 34 00              1353 	addc	a,#0
   1129 C5 F0              1354 	xch	a,b
   112B                    1355 00116$:
                           1356 ;     genPlus
   112B 24 0D              1357 	add	a,#_system_data
   112D FA                 1358 	mov	r2,a
   112E E5 F0              1359 	mov	a,b
   1130 34 00              1360 	addc	a,#(_system_data >> 8)
   1132 FE                 1361 	mov	r6,a
                           1362 ;     genPlus
                           1363 ;     genPlusIncr
   1133 74 02              1364 	mov	a,#0x02
                           1365 ;       Peephole 236.a  used r2 instead of ar2
   1135 2A                 1366 	add     a,r2
   1136 F5 82              1367 	mov	dpl,a
                           1368 ;       Peephole 181    changed mov to clr
   1138 E4                 1369 	clr     a
                           1370 ;       Peephole 236.b  used r6 instead of ar6
   1139 3E                 1371 	addc    a,r6
   113A F5 83              1372 	mov	dph,a
                           1373 ;     genPointerGet
                           1374 ;     genFarPointerGet
   113C E0                 1375 	movx	a,@dptr
   113D FA                 1376 	mov	r2,a
   113E A3                 1377 	inc	dptr
   113F E0                 1378 	movx	a,@dptr
   1140 FE                 1379 	mov	r6,a
   1141 A3                 1380 	inc	dptr
   1142 E0                 1381 	movx	a,@dptr
   1143 FF                 1382 	mov	r7,a
   1144 A3                 1383 	inc	dptr
   1145 E0                 1384 	movx	a,@dptr
   1146 FB                 1385 	mov	r3,a
                           1386 ;     genCmpEq
                           1387 ;       Peephole 112.b  changed ljmp to sjmp
                           1388 ;       Peephole 194    optimized misc jump sequence
   1147 BA 00 48           1389 	cjne    r2,#0x00,00102$
   114A BE 00 45           1390 	cjne    r6,#0x00,00102$
   114D BF 00 42           1391 	cjne    r7,#0x00,00102$
   1150 BB 00 3F           1392 	cjne    r3,#0x00,00102$
                           1393 ;00117$:
                           1394 ;       Peephole 200    removed redundant sjmp
   1153                    1395 00118$:
                           1396 ;src/menu.c:1006: printf_fast("WYLACZONE  ");
                           1397 ;     genIpush
   1153 74 13              1398 	mov	a,#__str_3
   1155 C0 E0              1399 	push	acc
   1157 74 4A              1400 	mov	a,#(__str_3 >> 8)
   1159 C0 E0              1401 	push	acc
                           1402 ;     genCall
   115B 12 72 21           1403 	lcall	_printf_fast
   115E 15 81              1404 	dec	sp
   1160 15 81              1405 	dec	sp
                           1406 ;src/menu.c:1007: lcd_goto_xy(display->x+3, 0);
                           1407 ;     genPointerGet
                           1408 ;     genGenPointerGet
   1162 E5 40              1409 	mov	a,_bp
   1164 24 02              1410 	add	a,#0x02
   1166 F8                 1411 	mov	r0,a
   1167 86 82              1412 	mov	dpl,@r0
   1169 08                 1413 	inc	r0
   116A 86 83              1414 	mov	dph,@r0
   116C 08                 1415 	inc	r0
   116D 86 F0              1416 	mov	b,@r0
   116F 12 71 F5           1417 	lcall	__gptrget
   1172 FA                 1418 	mov	r2,a
                           1419 ;     genPlus
                           1420 ;     genPlusIncr
   1173 74 03              1421 	mov	a,#0x03
                           1422 ;       Peephole 236.a  used r2 instead of ar2
   1175 2A                 1423 	add     a,r2
   1176 F5 82              1424 	mov	dpl,a
                           1425 ;     genIpush
                           1426 ;       Peephole 181    changed mov to clr
   1178 E4                 1427 	clr     a
   1179 C0 E0              1428 	push	acc
                           1429 ;     genCall
   117B 12 0A CD           1430 	lcall	_lcd_goto_xy
   117E 15 81              1431 	dec	sp
                           1432 ;src/menu.c:1008: printf_fast("--");
                           1433 ;     genIpush
   1180 74 1F              1434 	mov	a,#__str_4
   1182 C0 E0              1435 	push	acc
   1184 74 4A              1436 	mov	a,#(__str_4 >> 8)
   1186 C0 E0              1437 	push	acc
                           1438 ;     genCall
   1188 12 72 21           1439 	lcall	_printf_fast
   118B 15 81              1440 	dec	sp
   118D 15 81              1441 	dec	sp
   118F 02 12 BC           1442 	ljmp	00106$
   1192                    1443 00102$:
                           1444 ;src/menu.c:1012: local_gmtime(&system_data.zone_settings[zone+i].start_time);
                           1445 ;     genPlus
                           1446 ;       Peephole 212    reduced add sequence to inc
   1192 A8 40              1447 	mov     r0,_bp
   1194 08                 1448 	inc     r0
   1195 E5 40              1449 	mov	a,_bp
   1197 24 05              1450 	add	a,#0x05
   1199 F9                 1451 	mov	r1,a
   119A E7                 1452 	mov	a,@r1
   119B 26                 1453 	add	a,@r0
                           1454 ;     genMult
                           1455 ;     genMultOneByte
   119C C2 D5              1456 	clr	F0
   119E 75 F0 0A           1457 	mov	b,#0x0a
   11A1 30 E7 04           1458 	jnb	acc.7,00119$
   11A4 B2 D5              1459 	cpl	F0
   11A6 F4                 1460 	cpl	a
   11A7 04                 1461 	inc	a
   11A8                    1462 00119$:
   11A8 A4                 1463 	mul	ab
   11A9 30 D5 0A           1464 	jnb	F0,00120$
   11AC F4                 1465 	cpl	a
   11AD 24 01              1466 	add	a,#1
   11AF C5 F0              1467 	xch	a,b
   11B1 F4                 1468 	cpl	a
   11B2 34 00              1469 	addc	a,#0
   11B4 C5 F0              1470 	xch	a,b
   11B6                    1471 00120$:
   11B6 FA                 1472 	mov	r2,a
   11B7 AB F0              1473 	mov	r3,b
                           1474 ;     genPlus
                           1475 ;       Peephole 236.g  used r2 instead of ar2
   11B9 EA                 1476 	mov     a,r2
   11BA 24 0D              1477 	add	a,#_system_data
   11BC FC                 1478 	mov	r4,a
                           1479 ;       Peephole 236.g  used r3 instead of ar3
   11BD EB                 1480 	mov     a,r3
   11BE 34 00              1481 	addc	a,#(_system_data >> 8)
   11C0 FD                 1482 	mov	r5,a
                           1483 ;     genPlus
                           1484 ;     genPlusIncr
   11C1 74 02              1485 	mov	a,#0x02
                           1486 ;       Peephole 236.a  used r4 instead of ar4
   11C3 2C                 1487 	add     a,r4
   11C4 FC                 1488 	mov	r4,a
                           1489 ;       Peephole 181    changed mov to clr
   11C5 E4                 1490 	clr     a
                           1491 ;       Peephole 236.b  used r5 instead of ar5
   11C6 3D                 1492 	addc    a,r5
   11C7 FD                 1493 	mov	r5,a
                           1494 ;     genCast
   11C8 7E 01              1495 	mov	r6,#0x1
                           1496 ;     genCall
   11CA 8C 82              1497 	mov	dpl,r4
   11CC 8D 83              1498 	mov	dph,r5
   11CE 8E F0              1499 	mov	b,r6
   11D0 C0 02              1500 	push	ar2
   11D2 C0 03              1501 	push	ar3
   11D4 12 65 34           1502 	lcall	_local_gmtime
   11D7 D0 03              1503 	pop	ar3
   11D9 D0 02              1504 	pop	ar2
                           1505 ;src/menu.c:1016: (unsigned int)system_time.tm_min);
                           1506 ;     genPointerGet
                           1507 ;     genFarPointerGet
   11DB 90 01 82           1508 	mov	dptr,#(_system_time + 0x0001)
   11DE E0                 1509 	movx	a,@dptr
   11DF FC                 1510 	mov	r4,a
                           1511 ;     genCast
   11E0 7D 00              1512 	mov	r5,#0x00
                           1513 ;src/menu.c:1015: (unsigned int)system_time.tm_hour,
                           1514 ;     genPointerGet
                           1515 ;     genFarPointerGet
   11E2 90 01 83           1516 	mov	dptr,#(_system_time + 0x0002)
   11E5 E0                 1517 	movx	a,@dptr
   11E6 FE                 1518 	mov	r6,a
                           1519 ;     genCast
   11E7 7F 00              1520 	mov	r7,#0x00
                           1521 ;src/menu.c:1014: printf_fast("%02u:%02u", 
                           1522 ;     genIpush
   11E9 C0 02              1523 	push	ar2
   11EB C0 03              1524 	push	ar3
   11ED C0 04              1525 	push	ar4
   11EF C0 05              1526 	push	ar5
                           1527 ;     genIpush
   11F1 C0 06              1528 	push	ar6
   11F3 C0 07              1529 	push	ar7
                           1530 ;     genIpush
   11F5 74 22              1531 	mov	a,#__str_5
   11F7 C0 E0              1532 	push	acc
   11F9 74 4A              1533 	mov	a,#(__str_5 >> 8)
   11FB C0 E0              1534 	push	acc
                           1535 ;     genCall
   11FD 12 72 21           1536 	lcall	_printf_fast
   1200 E5 81              1537 	mov	a,sp
   1202 24 FA              1538 	add	a,#0xfa
   1204 F5 81              1539 	mov	sp,a
   1206 D0 03              1540 	pop	ar3
   1208 D0 02              1541 	pop	ar2
                           1542 ;src/menu.c:1018: printf_fast("-");
                           1543 ;     genIpush
   120A C0 02              1544 	push	ar2
   120C C0 03              1545 	push	ar3
   120E 74 2C              1546 	mov	a,#__str_6
   1210 C0 E0              1547 	push	acc
   1212 74 4A              1548 	mov	a,#(__str_6 >> 8)
   1214 C0 E0              1549 	push	acc
                           1550 ;     genCall
   1216 12 72 21           1551 	lcall	_printf_fast
   1219 15 81              1552 	dec	sp
   121B 15 81              1553 	dec	sp
   121D D0 03              1554 	pop	ar3
   121F D0 02              1555 	pop	ar2
                           1556 ;src/menu.c:1019: local_gmtime(&system_data.zone_settings[zone+i].stop_time);
                           1557 ;     genPlus
                           1558 ;       Peephole 236.g  used r2 instead of ar2
   1221 EA                 1559 	mov     a,r2
   1222 24 0D              1560 	add	a,#_system_data
   1224 FC                 1561 	mov	r4,a
                           1562 ;       Peephole 236.g  used r3 instead of ar3
   1225 EB                 1563 	mov     a,r3
   1226 34 00              1564 	addc	a,#(_system_data >> 8)
   1228 FD                 1565 	mov	r5,a
                           1566 ;     genPlus
   1229 74 06              1567 	mov	a,#0x06
                           1568 ;       Peephole 236.a  used r4 instead of ar4
   122B 2C                 1569 	add     a,r4
   122C FC                 1570 	mov	r4,a
                           1571 ;       Peephole 181    changed mov to clr
   122D E4                 1572 	clr     a
                           1573 ;       Peephole 236.b  used r5 instead of ar5
   122E 3D                 1574 	addc    a,r5
   122F FD                 1575 	mov	r5,a
                           1576 ;     genCast
   1230 7E 01              1577 	mov	r6,#0x1
                           1578 ;     genCall
   1232 8C 82              1579 	mov	dpl,r4
   1234 8D 83              1580 	mov	dph,r5
   1236 8E F0              1581 	mov	b,r6
   1238 C0 02              1582 	push	ar2
   123A C0 03              1583 	push	ar3
   123C 12 65 34           1584 	lcall	_local_gmtime
   123F D0 03              1585 	pop	ar3
   1241 D0 02              1586 	pop	ar2
                           1587 ;src/menu.c:1024: (unsigned int)system_time.tm_min);
                           1588 ;     genPointerGet
                           1589 ;     genFarPointerGet
   1243 90 01 82           1590 	mov	dptr,#(_system_time + 0x0001)
   1246 E0                 1591 	movx	a,@dptr
   1247 FC                 1592 	mov	r4,a
                           1593 ;     genCast
   1248 7D 00              1594 	mov	r5,#0x00
                           1595 ;src/menu.c:1023: (unsigned int)system_time.tm_hour,
                           1596 ;     genPointerGet
                           1597 ;     genFarPointerGet
   124A 90 01 83           1598 	mov	dptr,#(_system_time + 0x0002)
   124D E0                 1599 	movx	a,@dptr
   124E FE                 1600 	mov	r6,a
                           1601 ;     genCast
   124F 7F 00              1602 	mov	r7,#0x00
                           1603 ;src/menu.c:1022: printf_fast("%02u:%02u", 
                           1604 ;     genIpush
   1251 C0 02              1605 	push	ar2
   1253 C0 03              1606 	push	ar3
   1255 C0 04              1607 	push	ar4
   1257 C0 05              1608 	push	ar5
                           1609 ;     genIpush
   1259 C0 06              1610 	push	ar6
   125B C0 07              1611 	push	ar7
                           1612 ;     genIpush
   125D 74 22              1613 	mov	a,#__str_5
   125F C0 E0              1614 	push	acc
   1261 74 4A              1615 	mov	a,#(__str_5 >> 8)
   1263 C0 E0              1616 	push	acc
                           1617 ;     genCall
   1265 12 72 21           1618 	lcall	_printf_fast
   1268 E5 81              1619 	mov	a,sp
   126A 24 FA              1620 	add	a,#0xfa
   126C F5 81              1621 	mov	sp,a
   126E D0 03              1622 	pop	ar3
   1270 D0 02              1623 	pop	ar2
                           1624 ;src/menu.c:1026: lcd_goto_xy(display->x+3, 0);
                           1625 ;     genPointerGet
                           1626 ;     genGenPointerGet
   1272 E5 40              1627 	mov	a,_bp
   1274 24 02              1628 	add	a,#0x02
   1276 F8                 1629 	mov	r0,a
   1277 86 82              1630 	mov	dpl,@r0
   1279 08                 1631 	inc	r0
   127A 86 83              1632 	mov	dph,@r0
   127C 08                 1633 	inc	r0
   127D 86 F0              1634 	mov	b,@r0
   127F 12 71 F5           1635 	lcall	__gptrget
   1282 FC                 1636 	mov	r4,a
                           1637 ;     genPlus
                           1638 ;     genPlusIncr
   1283 74 03              1639 	mov	a,#0x03
                           1640 ;       Peephole 236.a  used r4 instead of ar4
   1285 2C                 1641 	add     a,r4
   1286 F5 82              1642 	mov	dpl,a
                           1643 ;     genIpush
   1288 C0 02              1644 	push	ar2
   128A C0 03              1645 	push	ar3
                           1646 ;       Peephole 181    changed mov to clr
   128C E4                 1647 	clr     a
   128D C0 E0              1648 	push	acc
                           1649 ;     genCall
   128F 12 0A CD           1650 	lcall	_lcd_goto_xy
   1292 15 81              1651 	dec	sp
   1294 D0 03              1652 	pop	ar3
   1296 D0 02              1653 	pop	ar2
                           1654 ;src/menu.c:1027: printf_fast("%02u",system_data.zone_settings[zone+i].temperature);
                           1655 ;     genPlus
                           1656 ;       Peephole 236.g  used r2 instead of ar2
   1298 EA                 1657 	mov     a,r2
   1299 24 0D              1658 	add	a,#_system_data
   129B F5 82              1659 	mov	dpl,a
                           1660 ;       Peephole 236.g  used r3 instead of ar3
   129D EB                 1661 	mov     a,r3
   129E 34 00              1662 	addc	a,#(_system_data >> 8)
   12A0 F5 83              1663 	mov	dph,a
                           1664 ;     genPointerGet
                           1665 ;     genFarPointerGet
   12A2 E0                 1666 	movx	a,@dptr
   12A3 FA                 1667 	mov	r2,a
   12A4 A3                 1668 	inc	dptr
   12A5 E0                 1669 	movx	a,@dptr
   12A6 FB                 1670 	mov	r3,a
                           1671 ;     genIpush
   12A7 C0 02              1672 	push	ar2
   12A9 C0 03              1673 	push	ar3
                           1674 ;     genIpush
   12AB 74 2E              1675 	mov	a,#__str_7
   12AD C0 E0              1676 	push	acc
   12AF 74 4A              1677 	mov	a,#(__str_7 >> 8)
   12B1 C0 E0              1678 	push	acc
                           1679 ;     genCall
   12B3 12 72 21           1680 	lcall	_printf_fast
   12B6 E5 81              1681 	mov	a,sp
   12B8 24 FC              1682 	add	a,#0xfc
   12BA F5 81              1683 	mov	sp,a
   12BC                    1684 00106$:
                           1685 ;src/menu.c:999: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
                           1686 ;     genPlus
   12BC E5 40              1687 	mov	a,_bp
   12BE 24 05              1688 	add	a,#0x05
   12C0 F8                 1689 	mov	r0,a
                           1690 ;     genPlusIncr
   12C1 06                 1691 	inc	@r0
   12C2 02 10 5D           1692 	ljmp	00104$
   12C5                    1693 00107$:
                           1694 ;src/menu.c:1031: BLINKING_ON;
                           1695 ;     genAssign
   12C5 75 30 01           1696 	mov	_blinking,#0x01
   12C8                    1697 00108$:
   12C8 85 40 81           1698 	mov	sp,_bp
   12CB D0 40              1699 	pop	_bp
   12CD 22                 1700 	ret
                           1701 ;------------------------------------------------------------
                           1702 ;Allocation info for local variables in function 'display_stored_time'
                           1703 ;------------------------------------------------------------
                           1704 ;method                    Allocated to stack - offset -3
                           1705 ;display_force             Allocated to stack - offset -4
                           1706 ;pos                       Allocated to registers r2 
                           1707 ;display                   Allocated to stack - offset 1
                           1708 ;sec                       Allocated with name '_display_stored_time_sec_1_1'
                           1709 ;------------------------------------------------------------
                           1710 ;src/menu.c:1034: void display_stored_time(const char pos, const char method, const char display_force)
                           1711 ;	-----------------------------------------
                           1712 ;	 function display_stored_time
                           1713 ;	-----------------------------------------
   12CE                    1714 _display_stored_time:
   12CE C0 40              1715 	push	_bp
   12D0 85 81 40           1716 	mov	_bp,sp
   12D3 05 81              1717 	inc	sp
   12D5 05 81              1718 	inc	sp
   12D7 05 81              1719 	inc	sp
                           1720 ;     genReceive
   12D9 AA 82              1721 	mov	r2,dpl
                           1722 ;src/menu.c:1038: ds1302_read_rtc(&system_time);
                           1723 ;     genCall
                           1724 ;       Peephole 182.a  used 16 bit load of DPTR
   12DB 90 01 81           1725 	mov     dptr,#_system_time
   12DE 75 F0 01           1726 	mov	b,#0x01
   12E1 C0 02              1727 	push	ar2
   12E3 12 5E A7           1728 	lcall	_ds1302_read_rtc
   12E6 D0 02              1729 	pop	ar2
                           1730 ;src/menu.c:1040: if (sec != system_time.tm_sec || display_force == true)
                           1731 ;     genPointerGet
                           1732 ;     genFarPointerGet
   12E8 90 01 81           1733 	mov	dptr,#_system_time
   12EB E0                 1734 	movx	a,@dptr
   12EC FB                 1735 	mov	r3,a
                           1736 ;     genCmpEq
   12ED E5 3D              1737 	mov	a,_display_stored_time_sec_1_1
                           1738 ;       Peephole 112.b  changed ljmp to sjmp
                           1739 ;       Peephole 199    optimized misc jump sequence
   12EF B5 03 0D           1740 	cjne    a,ar3,00107$
                           1741 ;00115$:
                           1742 ;       Peephole 200    removed redundant sjmp
   12F2                    1743 00116$:
                           1744 ;     genCmpEq
   12F2 E5 40              1745 	mov	a,_bp
   12F4 24 FC              1746 	add	a,#0xfc
   12F6 F8                 1747 	mov	r0,a
   12F7 B6 01 02           1748 	cjne	@r0,#0x01,00117$
   12FA 80 03              1749 	sjmp	00118$
   12FC                    1750 00117$:
   12FC 02 16 37           1751 	ljmp	00110$
   12FF                    1752 00118$:
   12FF                    1753 00107$:
                           1754 ;src/menu.c:1042: sec = system_time.tm_sec;
                           1755 ;     genAssign
   12FF 8B 3D              1756 	mov	_display_stored_time_sec_1_1,r3
                           1757 ;src/menu.c:1043: switch (method)
                           1758 ;     genCmpLt
   1301 E5 40              1759 	mov	a,_bp
   1303 24 FD              1760 	add	a,#0xfd
   1305 F8                 1761 	mov	r0,a
                           1762 ;     genCmp
   1306 E6                 1763 	mov	a,@r0
                           1764 ;     genIfxJump
   1307 30 E7 03           1765 	jnb	acc.7,00119$
   130A 02 16 37           1766 	ljmp	00110$
   130D                    1767 00119$:
                           1768 ;     genCmpGt
                           1769 ;     genCmp
   130D C3                 1770 	clr	c
                           1771 ;       Peephole 159    avoided xrl during execution
   130E 74 84              1772 	mov  a,#(0x04 ^ 0x80)
   1310 86 F0              1773 	mov	b,@r0
   1312 63 F0 80           1774 	xrl	b,#0x80
   1315 95 F0              1775 	subb	a,b
                           1776 ;     genIfxJump
   1317 50 03              1777 	jnc	00120$
   1319 02 16 37           1778 	ljmp	00110$
   131C                    1779 00120$:
                           1780 ;     genJumpTab
   131C E5 40              1781 	mov	a,_bp
   131E 24 FD              1782 	add	a,#0xfd
   1320 F8                 1783 	mov	r0,a
   1321 E6                 1784 	mov	a,@r0
   1322 25 E0              1785 	add	a,acc
   1324 26                 1786 	add	a,@r0
   1325 90 13 29           1787 	mov	dptr,#00121$
   1328 73                 1788 	jmp	@a+dptr
   1329                    1789 00121$:
   1329 02 13 38           1790 	ljmp	00101$
   132C 02 14 66           1791 	ljmp	00103$
   132F 02 15 19           1792 	ljmp	00104$
   1332 02 13 CF           1793 	ljmp	00102$
   1335 02 15 BE           1794 	ljmp	00105$
                           1795 ;src/menu.c:1046: BLINKING_OFF;
   1338                    1796 00101$:
                           1797 ;     genAssign
   1338 75 30 00           1798 	mov	_blinking,#0x00
                           1799 ;src/menu.c:1047: display = menu[current_display_state].item[pos].display;
                           1800 ;     genMult
                           1801 ;     genMultOneByte
   133B E5 31              1802 	mov	a,_current_display_state
   133D 75 F0 3C           1803 	mov	b,#0x3C
   1340 A4                 1804 	mul	ab
                           1805 ;     genPlus
   1341 24 0E              1806 	add	a,#_menu
   1343 FB                 1807 	mov	r3,a
   1344 E5 F0              1808 	mov	a,b
   1346 34 3C              1809 	addc	a,#(_menu >> 8)
   1348 FC                 1810 	mov	r4,a
                           1811 ;     genPlus
                           1812 ;     genPlusIncr
   1349 74 04              1813 	mov	a,#0x04
                           1814 ;       Peephole 236.a  used r3 instead of ar3
   134B 2B                 1815 	add     a,r3
   134C FB                 1816 	mov	r3,a
                           1817 ;       Peephole 181    changed mov to clr
   134D E4                 1818 	clr     a
                           1819 ;       Peephole 236.b  used r4 instead of ar4
   134E 3C                 1820 	addc    a,r4
   134F FC                 1821 	mov	r4,a
                           1822 ;     genMult
                           1823 ;     genMultOneByte
   1350 C2 D5              1824 	clr	F0
   1352 75 F0 08           1825 	mov	b,#0x08
   1355 EA                 1826 	mov	a,r2
   1356 30 E7 04           1827 	jnb	acc.7,00122$
   1359 B2 D5              1828 	cpl	F0
   135B F4                 1829 	cpl	a
   135C 04                 1830 	inc	a
   135D                    1831 00122$:
   135D A4                 1832 	mul	ab
   135E 30 D5 0A           1833 	jnb	F0,00123$
   1361 F4                 1834 	cpl	a
   1362 24 01              1835 	add	a,#1
   1364 C5 F0              1836 	xch	a,b
   1366 F4                 1837 	cpl	a
   1367 34 00              1838 	addc	a,#0
   1369 C5 F0              1839 	xch	a,b
   136B                    1840 00123$:
                           1841 ;     genPlus
                           1842 ;       Peephole 236.a  used r3 instead of ar3
   136B 2B                 1843 	add     a,r3
   136C FB                 1844 	mov	r3,a
   136D E5 F0              1845 	mov	a,b
                           1846 ;       Peephole 236.b  used r4 instead of ar4
   136F 3C                 1847 	addc    a,r4
   1370 FC                 1848 	mov	r4,a
                           1849 ;     genPlus
   1371 74 05              1850 	mov	a,#0x05
                           1851 ;       Peephole 236.a  used r3 instead of ar3
   1373 2B                 1852 	add     a,r3
   1374 F5 82              1853 	mov	dpl,a
                           1854 ;       Peephole 181    changed mov to clr
   1376 E4                 1855 	clr     a
                           1856 ;       Peephole 236.b  used r4 instead of ar4
   1377 3C                 1857 	addc    a,r4
   1378 F5 83              1858 	mov	dph,a
                           1859 ;     genPointerGet
                           1860 ;     genCodePointerGet
                           1861 ;       Peephole 181    changed mov to clr
   137A E4                 1862 	clr     a
   137B 93                 1863 	movc	a,@a+dptr
   137C FB                 1864 	mov	r3,a
   137D 74 01              1865 	mov	a,#0x01
   137F 93                 1866 	movc	a,@a+dptr
   1380 FC                 1867 	mov	r4,a
   1381 74 02              1868 	mov	a,#0x02
   1383 93                 1869 	movc	a,@a+dptr
   1384 FD                 1870 	mov	r5,a
                           1871 ;     genAssign
                           1872 ;       Peephole 212    reduced add sequence to inc
   1385 A8 40              1873 	mov     r0,_bp
   1387 08                 1874 	inc     r0
   1388 A6 03              1875 	mov	@r0,ar3
   138A 08                 1876 	inc	r0
   138B A6 04              1877 	mov	@r0,ar4
   138D 08                 1878 	inc	r0
   138E A6 05              1879 	mov	@r0,ar5
                           1880 ;src/menu.c:1048: lcd_goto_xy(display->x, display->y);
                           1881 ;     genPlus
                           1882 ;       Peephole 212    reduced add sequence to inc
   1390 A8 40              1883 	mov     r0,_bp
   1392 08                 1884 	inc     r0
                           1885 ;     genPlusIncr
   1393 74 01              1886 	mov	a,#0x01
   1395 26                 1887 	add	a,@r0
   1396 FE                 1888 	mov	r6,a
                           1889 ;       Peephole 181    changed mov to clr
   1397 E4                 1890 	clr     a
   1398 08                 1891 	inc	r0
   1399 36                 1892 	addc	a,@r0
   139A FF                 1893 	mov	r7,a
   139B 08                 1894 	inc	r0
   139C 86 03              1895 	mov	ar3,@r0
                           1896 ;     genPointerGet
                           1897 ;     genGenPointerGet
   139E 8E 82              1898 	mov	dpl,r6
   13A0 8F 83              1899 	mov	dph,r7
   13A2 8B F0              1900 	mov	b,r3
   13A4 12 71 F5           1901 	lcall	__gptrget
   13A7 FE                 1902 	mov	r6,a
                           1903 ;     genPointerGet
                           1904 ;     genGenPointerGet
                           1905 ;       Peephole 212    reduced add sequence to inc
   13A8 A8 40              1906 	mov     r0,_bp
   13AA 08                 1907 	inc     r0
   13AB 86 82              1908 	mov	dpl,@r0
   13AD 08                 1909 	inc	r0
   13AE 86 83              1910 	mov	dph,@r0
   13B0 08                 1911 	inc	r0
   13B1 86 F0              1912 	mov	b,@r0
   13B3 12 71 F5           1913 	lcall	__gptrget
   13B6 FB                 1914 	mov	r3,a
                           1915 ;     genIpush
   13B7 C0 06              1916 	push	ar6
                           1917 ;     genCall
   13B9 8B 82              1918 	mov	dpl,r3
   13BB 12 0A CD           1919 	lcall	_lcd_goto_xy
   13BE 15 81              1920 	dec	sp
                           1921 ;src/menu.c:1049: printf_asctime(&system_time);
                           1922 ;     genCall
                           1923 ;       Peephole 182.a  used 16 bit load of DPTR
   13C0 90 01 81           1924 	mov     dptr,#_system_time
   13C3 75 F0 01           1925 	mov	b,#0x01
   13C6 12 6A 0E           1926 	lcall	_printf_asctime
                           1927 ;src/menu.c:1050: BLINKING_ON;
                           1928 ;     genAssign
   13C9 75 30 01           1929 	mov	_blinking,#0x01
                           1930 ;src/menu.c:1051: break;
   13CC 02 16 37           1931 	ljmp	00110$
                           1932 ;src/menu.c:1054: BLINKING_OFF;
   13CF                    1933 00102$:
                           1934 ;     genAssign
   13CF 75 30 00           1935 	mov	_blinking,#0x00
                           1936 ;src/menu.c:1055: display = menu[current_display_state].item[pos].display;
                           1937 ;     genMult
                           1938 ;     genMultOneByte
   13D2 E5 31              1939 	mov	a,_current_display_state
   13D4 75 F0 3C           1940 	mov	b,#0x3C
   13D7 A4                 1941 	mul	ab
                           1942 ;     genPlus
   13D8 24 0E              1943 	add	a,#_menu
   13DA FB                 1944 	mov	r3,a
   13DB E5 F0              1945 	mov	a,b
   13DD 34 3C              1946 	addc	a,#(_menu >> 8)
   13DF FC                 1947 	mov	r4,a
                           1948 ;     genPlus
                           1949 ;     genPlusIncr
   13E0 74 04              1950 	mov	a,#0x04
                           1951 ;       Peephole 236.a  used r3 instead of ar3
   13E2 2B                 1952 	add     a,r3
   13E3 FB                 1953 	mov	r3,a
                           1954 ;       Peephole 181    changed mov to clr
   13E4 E4                 1955 	clr     a
                           1956 ;       Peephole 236.b  used r4 instead of ar4
   13E5 3C                 1957 	addc    a,r4
   13E6 FC                 1958 	mov	r4,a
                           1959 ;     genMult
                           1960 ;     genMultOneByte
   13E7 C2 D5              1961 	clr	F0
   13E9 75 F0 08           1962 	mov	b,#0x08
   13EC EA                 1963 	mov	a,r2
   13ED 30 E7 04           1964 	jnb	acc.7,00124$
   13F0 B2 D5              1965 	cpl	F0
   13F2 F4                 1966 	cpl	a
   13F3 04                 1967 	inc	a
   13F4                    1968 00124$:
   13F4 A4                 1969 	mul	ab
   13F5 30 D5 0A           1970 	jnb	F0,00125$
   13F8 F4                 1971 	cpl	a
   13F9 24 01              1972 	add	a,#1
   13FB C5 F0              1973 	xch	a,b
   13FD F4                 1974 	cpl	a
   13FE 34 00              1975 	addc	a,#0
   1400 C5 F0              1976 	xch	a,b
   1402                    1977 00125$:
                           1978 ;     genPlus
                           1979 ;       Peephole 236.a  used r3 instead of ar3
   1402 2B                 1980 	add     a,r3
   1403 FB                 1981 	mov	r3,a
   1404 E5 F0              1982 	mov	a,b
                           1983 ;       Peephole 236.b  used r4 instead of ar4
   1406 3C                 1984 	addc    a,r4
   1407 FC                 1985 	mov	r4,a
                           1986 ;     genPlus
   1408 74 05              1987 	mov	a,#0x05
                           1988 ;       Peephole 236.a  used r3 instead of ar3
   140A 2B                 1989 	add     a,r3
   140B F5 82              1990 	mov	dpl,a
                           1991 ;       Peephole 181    changed mov to clr
   140D E4                 1992 	clr     a
                           1993 ;       Peephole 236.b  used r4 instead of ar4
   140E 3C                 1994 	addc    a,r4
   140F F5 83              1995 	mov	dph,a
                           1996 ;     genPointerGet
                           1997 ;     genCodePointerGet
                           1998 ;       Peephole 181    changed mov to clr
   1411 E4                 1999 	clr     a
   1412 93                 2000 	movc	a,@a+dptr
   1413 FA                 2001 	mov	r2,a
   1414 74 01              2002 	mov	a,#0x01
   1416 93                 2003 	movc	a,@a+dptr
   1417 FB                 2004 	mov	r3,a
   1418 74 02              2005 	mov	a,#0x02
   141A 93                 2006 	movc	a,@a+dptr
   141B FC                 2007 	mov	r4,a
                           2008 ;     genAssign
                           2009 ;       Peephole 212    reduced add sequence to inc
   141C A8 40              2010 	mov     r0,_bp
   141E 08                 2011 	inc     r0
   141F A6 02              2012 	mov	@r0,ar2
   1421 08                 2013 	inc	r0
   1422 A6 03              2014 	mov	@r0,ar3
   1424 08                 2015 	inc	r0
   1425 A6 04              2016 	mov	@r0,ar4
                           2017 ;src/menu.c:1056: lcd_goto_xy(display->x, display->y);
                           2018 ;     genPlus
                           2019 ;       Peephole 212    reduced add sequence to inc
   1427 A8 40              2020 	mov     r0,_bp
   1429 08                 2021 	inc     r0
                           2022 ;     genPlusIncr
   142A 74 01              2023 	mov	a,#0x01
   142C 26                 2024 	add	a,@r0
   142D FA                 2025 	mov	r2,a
                           2026 ;       Peephole 181    changed mov to clr
   142E E4                 2027 	clr     a
   142F 08                 2028 	inc	r0
   1430 36                 2029 	addc	a,@r0
   1431 FB                 2030 	mov	r3,a
   1432 08                 2031 	inc	r0
   1433 86 04              2032 	mov	ar4,@r0
                           2033 ;     genPointerGet
                           2034 ;     genGenPointerGet
   1435 8A 82              2035 	mov	dpl,r2
   1437 8B 83              2036 	mov	dph,r3
   1439 8C F0              2037 	mov	b,r4
   143B 12 71 F5           2038 	lcall	__gptrget
   143E FA                 2039 	mov	r2,a
                           2040 ;     genPointerGet
                           2041 ;     genGenPointerGet
                           2042 ;       Peephole 212    reduced add sequence to inc
   143F A8 40              2043 	mov     r0,_bp
   1441 08                 2044 	inc     r0
   1442 86 82              2045 	mov	dpl,@r0
   1444 08                 2046 	inc	r0
   1445 86 83              2047 	mov	dph,@r0
   1447 08                 2048 	inc	r0
   1448 86 F0              2049 	mov	b,@r0
   144A 12 71 F5           2050 	lcall	__gptrget
   144D FB                 2051 	mov	r3,a
                           2052 ;     genIpush
   144E C0 02              2053 	push	ar2
                           2054 ;     genCall
   1450 8B 82              2055 	mov	dpl,r3
   1452 12 0A CD           2056 	lcall	_lcd_goto_xy
   1455 15 81              2057 	dec	sp
                           2058 ;src/menu.c:1057: printf_short_asctime(&system_time);
                           2059 ;     genCall
                           2060 ;       Peephole 182.a  used 16 bit load of DPTR
   1457 90 01 81           2061 	mov     dptr,#_system_time
   145A 75 F0 01           2062 	mov	b,#0x01
   145D 12 6B 9F           2063 	lcall	_printf_short_asctime
                           2064 ;src/menu.c:1058: BLINKING_ON;
                           2065 ;     genAssign
   1460 75 30 01           2066 	mov	_blinking,#0x01
                           2067 ;src/menu.c:1059: break;
   1463 02 16 37           2068 	ljmp	00110$
                           2069 ;src/menu.c:1062: display = menu[current_display_state].item[current_position].display;
   1466                    2070 00103$:
                           2071 ;     genMult
                           2072 ;     genMultOneByte
   1466 E5 31              2073 	mov	a,_current_display_state
   1468 75 F0 3C           2074 	mov	b,#0x3C
   146B A4                 2075 	mul	ab
                           2076 ;     genPlus
   146C 24 0E              2077 	add	a,#_menu
   146E FA                 2078 	mov	r2,a
   146F E5 F0              2079 	mov	a,b
   1471 34 3C              2080 	addc	a,#(_menu >> 8)
   1473 FB                 2081 	mov	r3,a
                           2082 ;     genPlus
                           2083 ;     genPlusIncr
   1474 74 04              2084 	mov	a,#0x04
                           2085 ;       Peephole 236.a  used r2 instead of ar2
   1476 2A                 2086 	add     a,r2
   1477 FA                 2087 	mov	r2,a
                           2088 ;       Peephole 181    changed mov to clr
   1478 E4                 2089 	clr     a
                           2090 ;       Peephole 236.b  used r3 instead of ar3
   1479 3B                 2091 	addc    a,r3
   147A FB                 2092 	mov	r3,a
                           2093 ;     genMult
                           2094 ;     genMultOneByte
   147B E5 32              2095 	mov	a,_current_position
   147D 75 F0 08           2096 	mov	b,#0x08
   1480 A4                 2097 	mul	ab
                           2098 ;     genPlus
                           2099 ;       Peephole 236.a  used r2 instead of ar2
   1481 2A                 2100 	add     a,r2
   1482 FA                 2101 	mov	r2,a
   1483 E5 F0              2102 	mov	a,b
                           2103 ;       Peephole 236.b  used r3 instead of ar3
   1485 3B                 2104 	addc    a,r3
   1486 FB                 2105 	mov	r3,a
                           2106 ;     genPlus
   1487 74 05              2107 	mov	a,#0x05
                           2108 ;       Peephole 236.a  used r2 instead of ar2
   1489 2A                 2109 	add     a,r2
   148A F5 82              2110 	mov	dpl,a
                           2111 ;       Peephole 181    changed mov to clr
   148C E4                 2112 	clr     a
                           2113 ;       Peephole 236.b  used r3 instead of ar3
   148D 3B                 2114 	addc    a,r3
   148E F5 83              2115 	mov	dph,a
                           2116 ;     genPointerGet
                           2117 ;     genCodePointerGet
                           2118 ;       Peephole 181    changed mov to clr
   1490 E4                 2119 	clr     a
   1491 93                 2120 	movc	a,@a+dptr
   1492 FA                 2121 	mov	r2,a
   1493 74 01              2122 	mov	a,#0x01
   1495 93                 2123 	movc	a,@a+dptr
   1496 FB                 2124 	mov	r3,a
   1497 74 02              2125 	mov	a,#0x02
   1499 93                 2126 	movc	a,@a+dptr
   149A FC                 2127 	mov	r4,a
                           2128 ;     genAssign
                           2129 ;       Peephole 212    reduced add sequence to inc
   149B A8 40              2130 	mov     r0,_bp
   149D 08                 2131 	inc     r0
   149E A6 02              2132 	mov	@r0,ar2
   14A0 08                 2133 	inc	r0
   14A1 A6 03              2134 	mov	@r0,ar3
   14A3 08                 2135 	inc	r0
   14A4 A6 04              2136 	mov	@r0,ar4
                           2137 ;src/menu.c:1063: lcd_goto_xy(display->x, display->y);
                           2138 ;     genPlus
                           2139 ;       Peephole 212    reduced add sequence to inc
   14A6 A8 40              2140 	mov     r0,_bp
   14A8 08                 2141 	inc     r0
                           2142 ;     genPlusIncr
   14A9 74 01              2143 	mov	a,#0x01
   14AB 26                 2144 	add	a,@r0
   14AC FA                 2145 	mov	r2,a
                           2146 ;       Peephole 181    changed mov to clr
   14AD E4                 2147 	clr     a
   14AE 08                 2148 	inc	r0
   14AF 36                 2149 	addc	a,@r0
   14B0 FB                 2150 	mov	r3,a
   14B1 08                 2151 	inc	r0
   14B2 86 04              2152 	mov	ar4,@r0
                           2153 ;     genPointerGet
                           2154 ;     genGenPointerGet
   14B4 8A 82              2155 	mov	dpl,r2
   14B6 8B 83              2156 	mov	dph,r3
   14B8 8C F0              2157 	mov	b,r4
   14BA 12 71 F5           2158 	lcall	__gptrget
   14BD FA                 2159 	mov	r2,a
                           2160 ;     genPointerGet
                           2161 ;     genGenPointerGet
                           2162 ;       Peephole 212    reduced add sequence to inc
   14BE A8 40              2163 	mov     r0,_bp
   14C0 08                 2164 	inc     r0
   14C1 86 82              2165 	mov	dpl,@r0
   14C3 08                 2166 	inc	r0
   14C4 86 83              2167 	mov	dph,@r0
   14C6 08                 2168 	inc	r0
   14C7 86 F0              2169 	mov	b,@r0
   14C9 12 71 F5           2170 	lcall	__gptrget
   14CC FB                 2171 	mov	r3,a
                           2172 ;     genIpush
   14CD C0 02              2173 	push	ar2
                           2174 ;     genCall
   14CF 8B 82              2175 	mov	dpl,r3
   14D1 12 0A CD           2176 	lcall	_lcd_goto_xy
   14D4 15 81              2177 	dec	sp
                           2178 ;src/menu.c:1067: (unsigned int)system_time.tm_mday);
                           2179 ;     genPointerGet
                           2180 ;     genFarPointerGet
   14D6 90 01 84           2181 	mov	dptr,#(_system_time + 0x0003)
   14D9 E0                 2182 	movx	a,@dptr
   14DA FA                 2183 	mov	r2,a
                           2184 ;     genCast
   14DB 7B 00              2185 	mov	r3,#0x00
                           2186 ;src/menu.c:1066: (unsigned int)system_time.tm_mon + 1,
                           2187 ;     genPointerGet
                           2188 ;     genFarPointerGet
   14DD 90 01 85           2189 	mov	dptr,#(_system_time + 0x0004)
   14E0 E0                 2190 	movx	a,@dptr
   14E1 FC                 2191 	mov	r4,a
                           2192 ;     genCast
   14E2 7D 00              2193 	mov	r5,#0x00
                           2194 ;     genPlus
                           2195 ;     genPlusIncr
   14E4 0C                 2196 	inc	r4
   14E5 BC 00 01           2197 	cjne	r4,#0x00,00126$
   14E8 0D                 2198 	inc	r5
   14E9                    2199 00126$:
                           2200 ;src/menu.c:1065: (unsigned int)system_time.tm_year + 2000,
                           2201 ;     genPointerGet
                           2202 ;     genFarPointerGet
   14E9 90 01 86           2203 	mov	dptr,#(_system_time + 0x0005)
   14EC E0                 2204 	movx	a,@dptr
   14ED FE                 2205 	mov	r6,a
   14EE A3                 2206 	inc	dptr
   14EF E0                 2207 	movx	a,@dptr
   14F0 FF                 2208 	mov	r7,a
                           2209 ;     genPlus
   14F1 74 D0              2210 	mov	a,#0xD0
                           2211 ;       Peephole 236.a  used r6 instead of ar6
   14F3 2E                 2212 	add     a,r6
   14F4 FE                 2213 	mov	r6,a
   14F5 74 07              2214 	mov	a,#0x07
                           2215 ;       Peephole 236.b  used r7 instead of ar7
   14F7 3F                 2216 	addc    a,r7
   14F8 FF                 2217 	mov	r7,a
                           2218 ;src/menu.c:1064: printf_fast("%04u-%02u-%02u", 
                           2219 ;     genIpush
   14F9 C0 02              2220 	push	ar2
   14FB C0 03              2221 	push	ar3
                           2222 ;     genIpush
   14FD C0 04              2223 	push	ar4
   14FF C0 05              2224 	push	ar5
                           2225 ;     genIpush
   1501 C0 06              2226 	push	ar6
   1503 C0 07              2227 	push	ar7
                           2228 ;     genIpush
   1505 74 33              2229 	mov	a,#__str_8
   1507 C0 E0              2230 	push	acc
   1509 74 4A              2231 	mov	a,#(__str_8 >> 8)
   150B C0 E0              2232 	push	acc
                           2233 ;     genCall
   150D 12 72 21           2234 	lcall	_printf_fast
   1510 E5 81              2235 	mov	a,sp
   1512 24 F8              2236 	add	a,#0xf8
   1514 F5 81              2237 	mov	sp,a
                           2238 ;src/menu.c:1068: break;
   1516 02 16 37           2239 	ljmp	00110$
                           2240 ;src/menu.c:1071: display = menu[current_display_state].item[current_position].display;
   1519                    2241 00104$:
                           2242 ;     genMult
                           2243 ;     genMultOneByte
   1519 E5 31              2244 	mov	a,_current_display_state
   151B 75 F0 3C           2245 	mov	b,#0x3C
   151E A4                 2246 	mul	ab
                           2247 ;     genPlus
   151F 24 0E              2248 	add	a,#_menu
   1521 FA                 2249 	mov	r2,a
   1522 E5 F0              2250 	mov	a,b
   1524 34 3C              2251 	addc	a,#(_menu >> 8)
   1526 FB                 2252 	mov	r3,a
                           2253 ;     genPlus
                           2254 ;     genPlusIncr
   1527 74 04              2255 	mov	a,#0x04
                           2256 ;       Peephole 236.a  used r2 instead of ar2
   1529 2A                 2257 	add     a,r2
   152A FA                 2258 	mov	r2,a
                           2259 ;       Peephole 181    changed mov to clr
   152B E4                 2260 	clr     a
                           2261 ;       Peephole 236.b  used r3 instead of ar3
   152C 3B                 2262 	addc    a,r3
   152D FB                 2263 	mov	r3,a
                           2264 ;     genMult
                           2265 ;     genMultOneByte
   152E E5 32              2266 	mov	a,_current_position
   1530 75 F0 08           2267 	mov	b,#0x08
   1533 A4                 2268 	mul	ab
                           2269 ;     genPlus
                           2270 ;       Peephole 236.a  used r2 instead of ar2
   1534 2A                 2271 	add     a,r2
   1535 FA                 2272 	mov	r2,a
   1536 E5 F0              2273 	mov	a,b
                           2274 ;       Peephole 236.b  used r3 instead of ar3
   1538 3B                 2275 	addc    a,r3
   1539 FB                 2276 	mov	r3,a
                           2277 ;     genPlus
   153A 74 05              2278 	mov	a,#0x05
                           2279 ;       Peephole 236.a  used r2 instead of ar2
   153C 2A                 2280 	add     a,r2
   153D F5 82              2281 	mov	dpl,a
                           2282 ;       Peephole 181    changed mov to clr
   153F E4                 2283 	clr     a
                           2284 ;       Peephole 236.b  used r3 instead of ar3
   1540 3B                 2285 	addc    a,r3
   1541 F5 83              2286 	mov	dph,a
                           2287 ;     genPointerGet
                           2288 ;     genCodePointerGet
                           2289 ;       Peephole 181    changed mov to clr
   1543 E4                 2290 	clr     a
   1544 93                 2291 	movc	a,@a+dptr
   1545 FA                 2292 	mov	r2,a
   1546 74 01              2293 	mov	a,#0x01
   1548 93                 2294 	movc	a,@a+dptr
   1549 FB                 2295 	mov	r3,a
   154A 74 02              2296 	mov	a,#0x02
   154C 93                 2297 	movc	a,@a+dptr
   154D FC                 2298 	mov	r4,a
                           2299 ;     genAssign
                           2300 ;       Peephole 212    reduced add sequence to inc
   154E A8 40              2301 	mov     r0,_bp
   1550 08                 2302 	inc     r0
   1551 A6 02              2303 	mov	@r0,ar2
   1553 08                 2304 	inc	r0
   1554 A6 03              2305 	mov	@r0,ar3
   1556 08                 2306 	inc	r0
   1557 A6 04              2307 	mov	@r0,ar4
                           2308 ;src/menu.c:1072: lcd_goto_xy(display->x, display->y);
                           2309 ;     genPlus
                           2310 ;       Peephole 212    reduced add sequence to inc
   1559 A8 40              2311 	mov     r0,_bp
   155B 08                 2312 	inc     r0
                           2313 ;     genPlusIncr
   155C 74 01              2314 	mov	a,#0x01
   155E 26                 2315 	add	a,@r0
   155F FA                 2316 	mov	r2,a
                           2317 ;       Peephole 181    changed mov to clr
   1560 E4                 2318 	clr     a
   1561 08                 2319 	inc	r0
   1562 36                 2320 	addc	a,@r0
   1563 FB                 2321 	mov	r3,a
   1564 08                 2322 	inc	r0
   1565 86 04              2323 	mov	ar4,@r0
                           2324 ;     genPointerGet
                           2325 ;     genGenPointerGet
   1567 8A 82              2326 	mov	dpl,r2
   1569 8B 83              2327 	mov	dph,r3
   156B 8C F0              2328 	mov	b,r4
   156D 12 71 F5           2329 	lcall	__gptrget
   1570 FA                 2330 	mov	r2,a
                           2331 ;     genPointerGet
                           2332 ;     genGenPointerGet
                           2333 ;       Peephole 212    reduced add sequence to inc
   1571 A8 40              2334 	mov     r0,_bp
   1573 08                 2335 	inc     r0
   1574 86 82              2336 	mov	dpl,@r0
   1576 08                 2337 	inc	r0
   1577 86 83              2338 	mov	dph,@r0
   1579 08                 2339 	inc	r0
   157A 86 F0              2340 	mov	b,@r0
   157C 12 71 F5           2341 	lcall	__gptrget
   157F FB                 2342 	mov	r3,a
                           2343 ;     genIpush
   1580 C0 02              2344 	push	ar2
                           2345 ;     genCall
   1582 8B 82              2346 	mov	dpl,r3
   1584 12 0A CD           2347 	lcall	_lcd_goto_xy
   1587 15 81              2348 	dec	sp
                           2349 ;src/menu.c:1076: (unsigned int)system_time.tm_sec);
                           2350 ;     genPointerGet
                           2351 ;     genFarPointerGet
   1589 90 01 81           2352 	mov	dptr,#_system_time
   158C E0                 2353 	movx	a,@dptr
   158D FA                 2354 	mov	r2,a
                           2355 ;     genCast
   158E 7B 00              2356 	mov	r3,#0x00
                           2357 ;src/menu.c:1075: (unsigned int)system_time.tm_min,
                           2358 ;     genPointerGet
                           2359 ;     genFarPointerGet
   1590 90 01 82           2360 	mov	dptr,#(_system_time + 0x0001)
   1593 E0                 2361 	movx	a,@dptr
   1594 FC                 2362 	mov	r4,a
                           2363 ;     genCast
   1595 7D 00              2364 	mov	r5,#0x00
                           2365 ;src/menu.c:1074: (unsigned int)system_time.tm_hour,
                           2366 ;     genPointerGet
                           2367 ;     genFarPointerGet
   1597 90 01 83           2368 	mov	dptr,#(_system_time + 0x0002)
   159A E0                 2369 	movx	a,@dptr
   159B FE                 2370 	mov	r6,a
                           2371 ;     genCast
   159C 7F 00              2372 	mov	r7,#0x00
                           2373 ;src/menu.c:1073: printf_fast("%02u:%02u:%02u", 
                           2374 ;     genIpush
   159E C0 02              2375 	push	ar2
   15A0 C0 03              2376 	push	ar3
                           2377 ;     genIpush
   15A2 C0 04              2378 	push	ar4
   15A4 C0 05              2379 	push	ar5
                           2380 ;     genIpush
   15A6 C0 06              2381 	push	ar6
   15A8 C0 07              2382 	push	ar7
                           2383 ;     genIpush
   15AA 74 42              2384 	mov	a,#__str_9
   15AC C0 E0              2385 	push	acc
   15AE 74 4A              2386 	mov	a,#(__str_9 >> 8)
   15B0 C0 E0              2387 	push	acc
                           2388 ;     genCall
   15B2 12 72 21           2389 	lcall	_printf_fast
   15B5 E5 81              2390 	mov	a,sp
   15B7 24 F8              2391 	add	a,#0xf8
   15B9 F5 81              2392 	mov	sp,a
                           2393 ;src/menu.c:1077: break;
   15BB 02 16 37           2394 	ljmp	00110$
                           2395 ;src/menu.c:1080: display = menu[current_display_state].item[current_position].display;
   15BE                    2396 00105$:
                           2397 ;     genMult
                           2398 ;     genMultOneByte
   15BE E5 31              2399 	mov	a,_current_display_state
   15C0 75 F0 3C           2400 	mov	b,#0x3C
   15C3 A4                 2401 	mul	ab
                           2402 ;     genPlus
   15C4 24 0E              2403 	add	a,#_menu
   15C6 FA                 2404 	mov	r2,a
   15C7 E5 F0              2405 	mov	a,b
   15C9 34 3C              2406 	addc	a,#(_menu >> 8)
   15CB FB                 2407 	mov	r3,a
                           2408 ;     genPlus
                           2409 ;     genPlusIncr
   15CC 74 04              2410 	mov	a,#0x04
                           2411 ;       Peephole 236.a  used r2 instead of ar2
   15CE 2A                 2412 	add     a,r2
   15CF FA                 2413 	mov	r2,a
                           2414 ;       Peephole 181    changed mov to clr
   15D0 E4                 2415 	clr     a
                           2416 ;       Peephole 236.b  used r3 instead of ar3
   15D1 3B                 2417 	addc    a,r3
   15D2 FB                 2418 	mov	r3,a
                           2419 ;     genMult
                           2420 ;     genMultOneByte
   15D3 E5 32              2421 	mov	a,_current_position
   15D5 75 F0 08           2422 	mov	b,#0x08
   15D8 A4                 2423 	mul	ab
                           2424 ;     genPlus
                           2425 ;       Peephole 236.a  used r2 instead of ar2
   15D9 2A                 2426 	add     a,r2
   15DA FA                 2427 	mov	r2,a
   15DB E5 F0              2428 	mov	a,b
                           2429 ;       Peephole 236.b  used r3 instead of ar3
   15DD 3B                 2430 	addc    a,r3
   15DE FB                 2431 	mov	r3,a
                           2432 ;     genPlus
   15DF 74 05              2433 	mov	a,#0x05
                           2434 ;       Peephole 236.a  used r2 instead of ar2
   15E1 2A                 2435 	add     a,r2
   15E2 F5 82              2436 	mov	dpl,a
                           2437 ;       Peephole 181    changed mov to clr
   15E4 E4                 2438 	clr     a
                           2439 ;       Peephole 236.b  used r3 instead of ar3
   15E5 3B                 2440 	addc    a,r3
   15E6 F5 83              2441 	mov	dph,a
                           2442 ;     genPointerGet
                           2443 ;     genCodePointerGet
                           2444 ;       Peephole 181    changed mov to clr
   15E8 E4                 2445 	clr     a
   15E9 93                 2446 	movc	a,@a+dptr
   15EA FA                 2447 	mov	r2,a
   15EB 74 01              2448 	mov	a,#0x01
   15ED 93                 2449 	movc	a,@a+dptr
   15EE FB                 2450 	mov	r3,a
   15EF 74 02              2451 	mov	a,#0x02
   15F1 93                 2452 	movc	a,@a+dptr
   15F2 FC                 2453 	mov	r4,a
                           2454 ;     genAssign
                           2455 ;       Peephole 212    reduced add sequence to inc
   15F3 A8 40              2456 	mov     r0,_bp
   15F5 08                 2457 	inc     r0
   15F6 A6 02              2458 	mov	@r0,ar2
   15F8 08                 2459 	inc	r0
   15F9 A6 03              2460 	mov	@r0,ar3
   15FB 08                 2461 	inc	r0
   15FC A6 04              2462 	mov	@r0,ar4
                           2463 ;src/menu.c:1081: lcd_goto_xy(display->x, display->y);
                           2464 ;     genPlus
                           2465 ;       Peephole 212    reduced add sequence to inc
   15FE A8 40              2466 	mov     r0,_bp
   1600 08                 2467 	inc     r0
                           2468 ;     genPlusIncr
   1601 74 01              2469 	mov	a,#0x01
   1603 26                 2470 	add	a,@r0
   1604 FA                 2471 	mov	r2,a
                           2472 ;       Peephole 181    changed mov to clr
   1605 E4                 2473 	clr     a
   1606 08                 2474 	inc	r0
   1607 36                 2475 	addc	a,@r0
   1608 FB                 2476 	mov	r3,a
   1609 08                 2477 	inc	r0
   160A 86 04              2478 	mov	ar4,@r0
                           2479 ;     genPointerGet
                           2480 ;     genGenPointerGet
   160C 8A 82              2481 	mov	dpl,r2
   160E 8B 83              2482 	mov	dph,r3
   1610 8C F0              2483 	mov	b,r4
   1612 12 71 F5           2484 	lcall	__gptrget
   1615 FA                 2485 	mov	r2,a
                           2486 ;     genPointerGet
                           2487 ;     genGenPointerGet
                           2488 ;       Peephole 212    reduced add sequence to inc
   1616 A8 40              2489 	mov     r0,_bp
   1618 08                 2490 	inc     r0
   1619 86 82              2491 	mov	dpl,@r0
   161B 08                 2492 	inc	r0
   161C 86 83              2493 	mov	dph,@r0
   161E 08                 2494 	inc	r0
   161F 86 F0              2495 	mov	b,@r0
   1621 12 71 F5           2496 	lcall	__gptrget
   1624 FB                 2497 	mov	r3,a
                           2498 ;     genIpush
   1625 C0 02              2499 	push	ar2
                           2500 ;     genCall
   1627 8B 82              2501 	mov	dpl,r3
   1629 12 0A CD           2502 	lcall	_lcd_goto_xy
   162C 15 81              2503 	dec	sp
                           2504 ;src/menu.c:1082: printf_weekday_short(&system_time);
                           2505 ;     genCall
                           2506 ;       Peephole 182.a  used 16 bit load of DPTR
   162E 90 01 81           2507 	mov     dptr,#_system_time
   1631 75 F0 01           2508 	mov	b,#0x01
   1634 12 6C D6           2509 	lcall	_printf_weekday_short
                           2510 ;src/menu.c:1084: }
   1637                    2511 00110$:
   1637 85 40 81           2512 	mov	sp,_bp
   163A D0 40              2513 	pop	_bp
   163C 22                 2514 	ret
                           2515 ;------------------------------------------------------------
                           2516 ;Allocation info for local variables in function 'display_stored_data'
                           2517 ;------------------------------------------------------------
                           2518 ;display_force             Allocated to stack - offset -3
                           2519 ;value                     Allocated to registers r2 r3 r4 
                           2520 ;temp                      Allocated to stack - offset 1
                           2521 ;i                         Allocated to stack - offset 3
                           2522 ;j                         Allocated to stack - offset 4
                           2523 ;display                   Allocated to registers r5 r6 r7 
                           2524 ;sloc0                     Allocated to stack - offset 6
                           2525 ;sec                       Allocated with name '_display_stored_data_sec_1_1'
                           2526 ;------------------------------------------------------------
                           2527 ;src/menu.c:1096: void display_stored_data(unsigned int *value, const char display_force)
                           2528 ;	-----------------------------------------
                           2529 ;	 function display_stored_data
                           2530 ;	-----------------------------------------
   163D                    2531 _display_stored_data:
   163D C0 40              2532 	push	_bp
   163F 85 81 40           2533 	mov	_bp,sp
   1642 E5 81              2534 	mov	a,sp
   1644 24 06              2535 	add	a,#0x06
   1646 F5 81              2536 	mov	sp,a
                           2537 ;     genReceive
   1648 AA 82              2538 	mov	r2,dpl
   164A AB 83              2539 	mov	r3,dph
   164C AC F0              2540 	mov	r4,b
                           2541 ;src/menu.c:1104: ds1302_read_rtc(&system_time);
                           2542 ;     genCall
                           2543 ;       Peephole 182.a  used 16 bit load of DPTR
   164E 90 01 81           2544 	mov     dptr,#_system_time
   1651 75 F0 01           2545 	mov	b,#0x01
   1654 C0 02              2546 	push	ar2
   1656 C0 03              2547 	push	ar3
   1658 C0 04              2548 	push	ar4
   165A 12 5E A7           2549 	lcall	_ds1302_read_rtc
   165D D0 04              2550 	pop	ar4
   165F D0 03              2551 	pop	ar3
   1661 D0 02              2552 	pop	ar2
                           2553 ;src/menu.c:1106: if (sec != system_time.tm_sec || display_force == true)
                           2554 ;     genPointerGet
                           2555 ;     genFarPointerGet
   1663 90 01 81           2556 	mov	dptr,#_system_time
   1666 E0                 2557 	movx	a,@dptr
   1667 FD                 2558 	mov	r5,a
                           2559 ;     genCmpEq
   1668 E5 3E              2560 	mov	a,_display_stored_data_sec_1_1
                           2561 ;       Peephole 112.b  changed ljmp to sjmp
                           2562 ;       Peephole 199    optimized misc jump sequence
   166A B5 05 0D           2563 	cjne    a,ar5,00103$
                           2564 ;00116$:
                           2565 ;       Peephole 200    removed redundant sjmp
   166D                    2566 00117$:
                           2567 ;     genCmpEq
   166D E5 40              2568 	mov	a,_bp
   166F 24 FD              2569 	add	a,#0xfd
   1671 F8                 2570 	mov	r0,a
   1672 B6 01 02           2571 	cjne	@r0,#0x01,00118$
   1675 80 03              2572 	sjmp	00119$
   1677                    2573 00118$:
   1677 02 18 9E           2574 	ljmp	00110$
   167A                    2575 00119$:
   167A                    2576 00103$:
                           2577 ;src/menu.c:1108: BLINKING_OFF;
                           2578 ;     genAssign
   167A 75 30 00           2579 	mov	_blinking,#0x00
                           2580 ;src/menu.c:1109: sec = system_time.tm_sec;
                           2581 ;     genAssign
   167D 8D 3E              2582 	mov	_display_stored_data_sec_1_1,r5
                           2583 ;src/menu.c:1111: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
                           2584 ;     genAssign
                           2585 ;     genAssign
   167F E5 40              2586 	mov	a,_bp
   1681 24 03              2587 	add	a,#0x03
   1683 F8                 2588 	mov	r0,a
   1684 76 00              2589 	mov	@r0,#0x00
   1686                    2590 00106$:
                           2591 ;     genMult
                           2592 ;     genMultOneByte
   1686 E5 31              2593 	mov	a,_current_display_state
   1688 75 F0 3C           2594 	mov	b,#0x3C
   168B A4                 2595 	mul	ab
                           2596 ;     genPlus
   168C 24 0E              2597 	add	a,#_menu
   168E FE                 2598 	mov	r6,a
   168F E5 F0              2599 	mov	a,b
   1691 34 3C              2600 	addc	a,#(_menu >> 8)
   1693 FF                 2601 	mov	r7,a
                           2602 ;     genPlus
                           2603 ;     genPlusIncr
   1694 74 03              2604 	mov	a,#0x03
                           2605 ;       Peephole 236.a  used r6 instead of ar6
   1696 2E                 2606 	add     a,r6
   1697 F5 82              2607 	mov	dpl,a
                           2608 ;       Peephole 181    changed mov to clr
   1699 E4                 2609 	clr     a
                           2610 ;       Peephole 236.b  used r7 instead of ar7
   169A 3F                 2611 	addc    a,r7
   169B F5 83              2612 	mov	dph,a
                           2613 ;     genIpush
   169D C0 02              2614 	push	ar2
   169F C0 03              2615 	push	ar3
   16A1 C0 04              2616 	push	ar4
                           2617 ;     genPointerGet
                           2618 ;     genCodePointerGet
                           2619 ;       Peephole 181    changed mov to clr
   16A3 E4                 2620 	clr     a
   16A4 93                 2621 	movc	a,@a+dptr
                           2622 ;     genCast
                           2623 ;       Peephole 105    removed redundant mov
   16A5 FA                 2624 	mov     r2,a
   16A6 33                 2625 	rlc	a
   16A7 95 E0              2626 	subb	a,acc
   16A9 FB                 2627 	mov	r3,a
                           2628 ;     genMinus
                           2629 ;     genMinusDec
   16AA 1A                 2630 	dec	r2
   16AB BA FF 01           2631 	cjne	r2,#0xff,00120$
   16AE 1B                 2632 	dec	r3
   16AF                    2633 00120$:
                           2634 ;     genCast
   16AF E5 40              2635 	mov	a,_bp
   16B1 24 03              2636 	add	a,#0x03
   16B3 F8                 2637 	mov	r0,a
   16B4 86 04              2638 	mov	ar4,@r0
   16B6 7D 00              2639 	mov	r5,#0x00
                           2640 ;     genCmpLt
                           2641 ;     genCmp
   16B8 C3                 2642 	clr	c
   16B9 EC                 2643 	mov	a,r4
   16BA 9A                 2644 	subb	a,r2
   16BB ED                 2645 	mov	a,r5
   16BC 64 80              2646 	xrl	a,#0x80
   16BE 8B F0              2647 	mov	b,r3
   16C0 63 F0 80           2648 	xrl	b,#0x80
   16C3 95 F0              2649 	subb	a,b
   16C5 E4                 2650 	clr	a
   16C6 33                 2651 	rlc	a
                           2652 ;     genIpop
   16C7 D0 04              2653 	pop	ar4
   16C9 D0 03              2654 	pop	ar3
   16CB D0 02              2655 	pop	ar2
                           2656 ;     genIfx
                           2657 ;     genIfxJump
   16CD 70 03              2658 	jnz	00121$
   16CF 02 18 9B           2659 	ljmp	00109$
   16D2                    2660 00121$:
                           2661 ;src/menu.c:1113: display = menu[current_display_state].item[i].display;
                           2662 ;     genPlus
                           2663 ;     genPlusIncr
   16D2 74 04              2664 	mov	a,#0x04
                           2665 ;       Peephole 236.a  used r6 instead of ar6
   16D4 2E                 2666 	add     a,r6
   16D5 FE                 2667 	mov	r6,a
                           2668 ;       Peephole 181    changed mov to clr
   16D6 E4                 2669 	clr     a
                           2670 ;       Peephole 236.b  used r7 instead of ar7
   16D7 3F                 2671 	addc    a,r7
   16D8 FF                 2672 	mov	r7,a
                           2673 ;     genMult
   16D9 E5 40              2674 	mov	a,_bp
   16DB 24 03              2675 	add	a,#0x03
   16DD F8                 2676 	mov	r0,a
                           2677 ;     genMultOneByte
   16DE E6                 2678 	mov	a,@r0
   16DF 75 F0 08           2679 	mov	b,#0x08
   16E2 A4                 2680 	mul	ab
                           2681 ;     genPlus
                           2682 ;       Peephole 236.a  used r6 instead of ar6
   16E3 2E                 2683 	add     a,r6
   16E4 FE                 2684 	mov	r6,a
   16E5 E5 F0              2685 	mov	a,b
                           2686 ;       Peephole 236.b  used r7 instead of ar7
   16E7 3F                 2687 	addc    a,r7
   16E8 FF                 2688 	mov	r7,a
                           2689 ;     genPlus
   16E9 74 05              2690 	mov	a,#0x05
                           2691 ;       Peephole 236.a  used r6 instead of ar6
   16EB 2E                 2692 	add     a,r6
   16EC F5 82              2693 	mov	dpl,a
                           2694 ;       Peephole 181    changed mov to clr
   16EE E4                 2695 	clr     a
                           2696 ;       Peephole 236.b  used r7 instead of ar7
   16EF 3F                 2697 	addc    a,r7
   16F0 F5 83              2698 	mov	dph,a
                           2699 ;     genPointerGet
                           2700 ;     genCodePointerGet
                           2701 ;       Peephole 181    changed mov to clr
   16F2 E4                 2702 	clr     a
   16F3 93                 2703 	movc	a,@a+dptr
   16F4 FD                 2704 	mov	r5,a
   16F5 74 01              2705 	mov	a,#0x01
   16F7 93                 2706 	movc	a,@a+dptr
   16F8 FE                 2707 	mov	r6,a
   16F9 74 02              2708 	mov	a,#0x02
   16FB 93                 2709 	movc	a,@a+dptr
   16FC FF                 2710 	mov	r7,a
                           2711 ;     genAssign
                           2712 ;src/menu.c:1115: temp = *value;
                           2713 ;     genPointerGet
                           2714 ;     genGenPointerGet
   16FD 8A 82              2715 	mov	dpl,r2
   16FF 8B 83              2716 	mov	dph,r3
   1701 8C F0              2717 	mov	b,r4
                           2718 ;       Peephole 212    reduced add sequence to inc
   1703 A8 40              2719 	mov     r0,_bp
   1705 08                 2720 	inc     r0
   1706 12 71 F5           2721 	lcall	__gptrget
   1709 F6                 2722 	mov	@r0,a
   170A A3                 2723 	inc	dptr
   170B 12 71 F5           2724 	lcall	__gptrget
   170E 08                 2725 	inc	r0
   170F F6                 2726 	mov	@r0,a
                           2727 ;     genAssign
                           2728 ;       Peephole 212    reduced add sequence to inc
   1710 A8 40              2729 	mov     r0,_bp
   1712 08                 2730 	inc     r0
                           2731 ;src/menu.c:1116: lcd_goto_xy(display->x, display->y);
                           2732 ;     genIpush
   1713 C0 02              2733 	push	ar2
   1715 C0 03              2734 	push	ar3
   1717 C0 04              2735 	push	ar4
                           2736 ;     genPlus
                           2737 ;     genPlusIncr
   1719 74 01              2738 	mov	a,#0x01
                           2739 ;       Peephole 236.a  used r5 instead of ar5
   171B 2D                 2740 	add     a,r5
   171C FA                 2741 	mov	r2,a
                           2742 ;       Peephole 181    changed mov to clr
   171D E4                 2743 	clr     a
                           2744 ;       Peephole 236.b  used r6 instead of ar6
   171E 3E                 2745 	addc    a,r6
   171F FB                 2746 	mov	r3,a
   1720 8F 04              2747 	mov	ar4,r7
                           2748 ;     genPointerGet
                           2749 ;     genGenPointerGet
   1722 8A 82              2750 	mov	dpl,r2
   1724 8B 83              2751 	mov	dph,r3
   1726 8C F0              2752 	mov	b,r4
   1728 12 71 F5           2753 	lcall	__gptrget
   172B FA                 2754 	mov	r2,a
                           2755 ;     genPointerGet
                           2756 ;     genGenPointerGet
   172C 8D 82              2757 	mov	dpl,r5
   172E 8E 83              2758 	mov	dph,r6
   1730 8F F0              2759 	mov	b,r7
   1732 12 71 F5           2760 	lcall	__gptrget
   1735 FB                 2761 	mov	r3,a
                           2762 ;     genIpush
   1736 C0 02              2763 	push	ar2
   1738 C0 03              2764 	push	ar3
   173A C0 04              2765 	push	ar4
   173C C0 05              2766 	push	ar5
   173E C0 06              2767 	push	ar6
   1740 C0 07              2768 	push	ar7
   1742 C0 02              2769 	push	ar2
                           2770 ;     genCall
   1744 8B 82              2771 	mov	dpl,r3
   1746 12 0A CD           2772 	lcall	_lcd_goto_xy
   1749 15 81              2773 	dec	sp
   174B D0 07              2774 	pop	ar7
   174D D0 06              2775 	pop	ar6
   174F D0 05              2776 	pop	ar5
   1751 D0 04              2777 	pop	ar4
   1753 D0 03              2778 	pop	ar3
   1755 D0 02              2779 	pop	ar2
                           2780 ;src/menu.c:1117: printf_fast((char code*)display->width,temp);
                           2781 ;     genPlus
                           2782 ;     genPlusIncr
   1757 74 03              2783 	mov	a,#0x03
                           2784 ;       Peephole 236.a  used r5 instead of ar5
   1759 2D                 2785 	add     a,r5
   175A FA                 2786 	mov	r2,a
                           2787 ;       Peephole 181    changed mov to clr
   175B E4                 2788 	clr     a
                           2789 ;       Peephole 236.b  used r6 instead of ar6
   175C 3E                 2790 	addc    a,r6
   175D FB                 2791 	mov	r3,a
   175E 8F 04              2792 	mov	ar4,r7
                           2793 ;     genPointerGet
                           2794 ;     genGenPointerGet
   1760 8A 82              2795 	mov	dpl,r2
   1762 8B 83              2796 	mov	dph,r3
   1764 8C F0              2797 	mov	b,r4
   1766 12 71 F5           2798 	lcall	__gptrget
   1769 FA                 2799 	mov	r2,a
   176A A3                 2800 	inc	dptr
   176B 12 71 F5           2801 	lcall	__gptrget
   176E FB                 2802 	mov	r3,a
   176F A3                 2803 	inc	dptr
   1770 12 71 F5           2804 	lcall	__gptrget
   1773 FC                 2805 	mov	r4,a
                           2806 ;     genCast
                           2807 ;     genIpush
   1774 C0 02              2808 	push	ar2
   1776 C0 03              2809 	push	ar3
   1778 C0 04              2810 	push	ar4
   177A C0 05              2811 	push	ar5
   177C C0 06              2812 	push	ar6
   177E C0 07              2813 	push	ar7
                           2814 ;       Peephole 212    reduced add sequence to inc
   1780 A8 40              2815 	mov     r0,_bp
   1782 08                 2816 	inc     r0
   1783 E6                 2817 	mov	a,@r0
   1784 C0 E0              2818 	push	acc
   1786 08                 2819 	inc	r0
   1787 E6                 2820 	mov	a,@r0
   1788 C0 E0              2821 	push	acc
                           2822 ;     genIpush
   178A C0 02              2823 	push	ar2
   178C C0 03              2824 	push	ar3
                           2825 ;     genCall
   178E 12 72 21           2826 	lcall	_printf_fast
   1791 E5 81              2827 	mov	a,sp
   1793 24 FC              2828 	add	a,#0xfc
   1795 F5 81              2829 	mov	sp,a
   1797 D0 07              2830 	pop	ar7
   1799 D0 06              2831 	pop	ar6
   179B D0 05              2832 	pop	ar5
   179D D0 04              2833 	pop	ar4
   179F D0 03              2834 	pop	ar3
   17A1 D0 02              2835 	pop	ar2
                           2836 ;src/menu.c:1119: if (display->point > 0)
                           2837 ;     genPlus
                           2838 ;     genPlusIncr
   17A3 74 02              2839 	mov	a,#0x02
                           2840 ;       Peephole 236.a  used r5 instead of ar5
   17A5 2D                 2841 	add     a,r5
   17A6 FA                 2842 	mov	r2,a
                           2843 ;       Peephole 181    changed mov to clr
   17A7 E4                 2844 	clr     a
                           2845 ;       Peephole 236.b  used r6 instead of ar6
   17A8 3E                 2846 	addc    a,r6
   17A9 FB                 2847 	mov	r3,a
   17AA 8F 04              2848 	mov	ar4,r7
                           2849 ;     genPointerGet
                           2850 ;     genGenPointerGet
   17AC 8A 82              2851 	mov	dpl,r2
   17AE 8B 83              2852 	mov	dph,r3
   17B0 8C F0              2853 	mov	b,r4
   17B2 E5 40              2854 	mov	a,_bp
   17B4 24 06              2855 	add	a,#0x06
   17B6 F8                 2856 	mov	r0,a
   17B7 12 71 F5           2857 	lcall	__gptrget
   17BA F6                 2858 	mov	@r0,a
                           2859 ;     genCmpGt
   17BB E5 40              2860 	mov	a,_bp
   17BD 24 06              2861 	add	a,#0x06
   17BF F8                 2862 	mov	r0,a
                           2863 ;     genCmp
   17C0 C3                 2864 	clr	c
                           2865 ;       Peephole 181    changed mov to clr
   17C1 E4                 2866 	clr     a
   17C2 96                 2867 	subb	a,@r0
   17C3 E4                 2868 	clr	a
   17C4 33                 2869 	rlc	a
                           2870 ;     genIpop
   17C5 D0 04              2871 	pop	ar4
   17C7 D0 03              2872 	pop	ar3
   17C9 D0 02              2873 	pop	ar2
                           2874 ;     genIfx
                           2875 ;     genIfxJump
   17CB 70 03              2876 	jnz	00122$
   17CD 02 18 8B           2877 	ljmp	00102$
   17D0                    2878 00122$:
                           2879 ;src/menu.c:1121: temp = *value;
                           2880 ;     genPointerGet
                           2881 ;     genGenPointerGet
   17D0 8A 82              2882 	mov	dpl,r2
   17D2 8B 83              2883 	mov	dph,r3
   17D4 8C F0              2884 	mov	b,r4
                           2885 ;       Peephole 212    reduced add sequence to inc
   17D6 A8 40              2886 	mov     r0,_bp
   17D8 08                 2887 	inc     r0
   17D9 12 71 F5           2888 	lcall	__gptrget
   17DC F6                 2889 	mov	@r0,a
   17DD A3                 2890 	inc	dptr
   17DE 12 71 F5           2891 	lcall	__gptrget
   17E1 08                 2892 	inc	r0
   17E2 F6                 2893 	mov	@r0,a
                           2894 ;     genAssign
                           2895 ;       Peephole 212    reduced add sequence to inc
   17E3 A8 40              2896 	mov     r0,_bp
   17E5 08                 2897 	inc     r0
                           2898 ;src/menu.c:1122: j = (unsigned int)(temp % 10);
                           2899 ;     genAssign
   17E6 E4                 2900 	clr	a
   17E7 F5 43              2901 	mov	(__moduint_PARM_2 + 1),a
   17E9 75 42 0A           2902 	mov	__moduint_PARM_2,#0x0A
                           2903 ;     genCall
                           2904 ;       Peephole 212    reduced add sequence to inc
   17EC A8 40              2905 	mov     r0,_bp
   17EE 08                 2906 	inc     r0
   17EF 86 82              2907 	mov	dpl,@r0
   17F1 08                 2908 	inc	r0
   17F2 86 83              2909 	mov	dph,@r0
   17F4 C0 02              2910 	push	ar2
   17F6 C0 03              2911 	push	ar3
   17F8 C0 04              2912 	push	ar4
   17FA C0 05              2913 	push	ar5
   17FC C0 06              2914 	push	ar6
   17FE C0 07              2915 	push	ar7
   1800 12 71 2D           2916 	lcall	__moduint
   1803 C0 E0              2917 	push	acc
   1805 E5 40              2918 	mov	a,_bp
   1807 24 04              2919 	add	a,#0x04
   1809 F8                 2920 	mov	r0,a
   180A D0 E0              2921 	pop	acc
   180C A6 82              2922 	mov	@r0,dpl
   180E 08                 2923 	inc	r0
   180F A6 83              2924 	mov	@r0,dph
   1811 D0 07              2925 	pop	ar7
   1813 D0 06              2926 	pop	ar6
   1815 D0 05              2927 	pop	ar5
   1817 D0 04              2928 	pop	ar4
   1819 D0 03              2929 	pop	ar3
   181B D0 02              2930 	pop	ar2
                           2931 ;src/menu.c:1123: lcd_goto_xy(display->x+display->point, display->y);
                           2932 ;     genIpush
   181D C0 02              2933 	push	ar2
   181F C0 03              2934 	push	ar3
   1821 C0 04              2935 	push	ar4
                           2936 ;     genPlus
                           2937 ;     genPlusIncr
   1823 74 01              2938 	mov	a,#0x01
                           2939 ;       Peephole 236.a  used r5 instead of ar5
   1825 2D                 2940 	add     a,r5
   1826 FA                 2941 	mov	r2,a
                           2942 ;       Peephole 181    changed mov to clr
   1827 E4                 2943 	clr     a
                           2944 ;       Peephole 236.b  used r6 instead of ar6
   1828 3E                 2945 	addc    a,r6
   1829 FB                 2946 	mov	r3,a
   182A 8F 04              2947 	mov	ar4,r7
                           2948 ;     genPointerGet
                           2949 ;     genGenPointerGet
   182C 8A 82              2950 	mov	dpl,r2
   182E 8B 83              2951 	mov	dph,r3
   1830 8C F0              2952 	mov	b,r4
   1832 12 71 F5           2953 	lcall	__gptrget
   1835 FA                 2954 	mov	r2,a
                           2955 ;     genPointerGet
                           2956 ;     genGenPointerGet
   1836 8D 82              2957 	mov	dpl,r5
   1838 8E 83              2958 	mov	dph,r6
   183A 8F F0              2959 	mov	b,r7
   183C 12 71 F5           2960 	lcall	__gptrget
   183F FD                 2961 	mov	r5,a
                           2962 ;     genPlus
   1840 E5 40              2963 	mov	a,_bp
   1842 24 06              2964 	add	a,#0x06
   1844 F8                 2965 	mov	r0,a
   1845 E6                 2966 	mov	a,@r0
                           2967 ;       Peephole 236.a  used r5 instead of ar5
   1846 2D                 2968 	add     a,r5
   1847 F5 82              2969 	mov	dpl,a
                           2970 ;     genIpush
   1849 C0 02              2971 	push	ar2
   184B C0 03              2972 	push	ar3
   184D C0 04              2973 	push	ar4
   184F C0 02              2974 	push	ar2
                           2975 ;     genCall
   1851 12 0A CD           2976 	lcall	_lcd_goto_xy
   1854 15 81              2977 	dec	sp
   1856 D0 04              2978 	pop	ar4
   1858 D0 03              2979 	pop	ar3
   185A D0 02              2980 	pop	ar2
                           2981 ;src/menu.c:1124: printf_fast(".%d",j);
                           2982 ;     genIpush
   185C C0 02              2983 	push	ar2
   185E C0 03              2984 	push	ar3
   1860 C0 04              2985 	push	ar4
   1862 E5 40              2986 	mov	a,_bp
   1864 24 04              2987 	add	a,#0x04
   1866 F8                 2988 	mov	r0,a
   1867 E6                 2989 	mov	a,@r0
   1868 C0 E0              2990 	push	acc
   186A 08                 2991 	inc	r0
   186B E6                 2992 	mov	a,@r0
   186C C0 E0              2993 	push	acc
                           2994 ;     genIpush
   186E 74 51              2995 	mov	a,#__str_10
   1870 C0 E0              2996 	push	acc
   1872 74 4A              2997 	mov	a,#(__str_10 >> 8)
   1874 C0 E0              2998 	push	acc
                           2999 ;     genCall
   1876 12 72 21           3000 	lcall	_printf_fast
   1879 E5 81              3001 	mov	a,sp
   187B 24 FC              3002 	add	a,#0xfc
   187D F5 81              3003 	mov	sp,a
   187F D0 04              3004 	pop	ar4
   1881 D0 03              3005 	pop	ar3
   1883 D0 02              3006 	pop	ar2
                           3007 ;src/menu.c:1128: BLINKING_ON;
                           3008 ;     genIpop
   1885 D0 04              3009 	pop	ar4
   1887 D0 03              3010 	pop	ar3
   1889 D0 02              3011 	pop	ar2
                           3012 ;src/menu.c:1124: printf_fast(".%d",j);
   188B                    3013 00102$:
                           3014 ;src/menu.c:1126: value++;      
                           3015 ;     genPlus
                           3016 ;     genPlusIncr
   188B 74 02              3017 	mov	a,#0x02
                           3018 ;       Peephole 236.a  used r2 instead of ar2
   188D 2A                 3019 	add     a,r2
   188E FA                 3020 	mov	r2,a
                           3021 ;       Peephole 181    changed mov to clr
   188F E4                 3022 	clr     a
                           3023 ;       Peephole 236.b  used r3 instead of ar3
   1890 3B                 3024 	addc    a,r3
   1891 FB                 3025 	mov	r3,a
                           3026 ;src/menu.c:1111: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
                           3027 ;     genPlus
   1892 E5 40              3028 	mov	a,_bp
   1894 24 03              3029 	add	a,#0x03
   1896 F8                 3030 	mov	r0,a
                           3031 ;     genPlusIncr
   1897 06                 3032 	inc	@r0
   1898 02 16 86           3033 	ljmp	00106$
   189B                    3034 00109$:
                           3035 ;src/menu.c:1128: BLINKING_ON;
                           3036 ;     genAssign
   189B 75 30 01           3037 	mov	_blinking,#0x01
   189E                    3038 00110$:
   189E 85 40 81           3039 	mov	sp,_bp
   18A1 D0 40              3040 	pop	_bp
   18A3 22                 3041 	ret
                           3042 ;------------------------------------------------------------
                           3043 ;Allocation info for local variables in function 'switch_zone'
                           3044 ;------------------------------------------------------------
                           3045 ;zone_no                   Allocated to registers r2 
                           3046 ;------------------------------------------------------------
                           3047 ;src/menu.c:1132: void switch_zone(const char zone_no)
                           3048 ;	-----------------------------------------
                           3049 ;	 function switch_zone
                           3050 ;	-----------------------------------------
   18A4                    3051 _switch_zone:
   18A4 C0 40              3052 	push	_bp
   18A6 85 81 40           3053 	mov	_bp,sp
                           3054 ;     genReceive
                           3055 ;src/menu.c:1134: switch(zone_no)
                           3056 ;     genCmpLt
                           3057 ;     genCmp
                           3058 ;       Peephole 244.a  moving first to a instead of r2
   18A9 E5 82              3059 	mov	a,dpl
   18AB FA                 3060 	mov	r2,a
                           3061 ;     genIfxJump
                           3062 ;       Peephole 112.a  removed ljmp by inverse jump logic
   18AC 20 E7 3E           3063 	jb      acc.7,00106$
   18AF                    3064 00110$:
                           3065 ;     genCmpGt
                           3066 ;     genCmp
   18AF C3                 3067 	clr	c
                           3068 ;       Peephole 159    avoided xrl during execution
   18B0 74 83              3069 	mov  a,#(0x03 ^ 0x80)
   18B2 8A F0              3070 	mov	b,r2
   18B4 63 F0 80           3071 	xrl	b,#0x80
   18B7 95 F0              3072 	subb	a,b
                           3073 ;     genIfxJump
                           3074 ;       Peephole 112.b  changed ljmp to sjmp
                           3075 ;       Peephole 160    removed sjmp by inverse jump logic
   18B9 40 32              3076 	jc      00106$
   18BB                    3077 00111$:
                           3078 ;     genJumpTab
   18BB EA                 3079 	mov	a,r2
   18BC 25 E0              3080 	add	a,acc
   18BE 2A                 3081 	add	a,r2
   18BF 90 18 C3           3082 	mov	dptr,#00112$
   18C2 73                 3083 	jmp	@a+dptr
   18C3                    3084 00112$:
   18C3 02 18 CF           3085 	ljmp	00101$
   18C6 02 18 D7           3086 	ljmp	00102$
   18C9 02 18 DF           3087 	ljmp	00103$
   18CC 02 18 E7           3088 	ljmp	00104$
                           3089 ;src/menu.c:1137: ZONE_1_OUTPUT = ZONE_1_PREPARED;
   18CF                    3090 00101$:
                           3091 ;     genAssign
   18CF E5 39              3092 	mov	a,_ZONE_1_PREPARED
   18D1 24 FF              3093 	add	a,#0xff
   18D3 92 B5              3094 	mov	_P3_5,c
                           3095 ;src/menu.c:1138: break;
                           3096 ;src/menu.c:1140: ZONE_2_OUTPUT = ZONE_2_PREPARED;
                           3097 ;       Peephole 112.b  changed ljmp to sjmp
   18D5 80 16              3098 	sjmp    00106$
   18D7                    3099 00102$:
                           3100 ;     genAssign
   18D7 E5 3A              3101 	mov	a,_ZONE_2_PREPARED
   18D9 24 FF              3102 	add	a,#0xff
   18DB 92 B2              3103 	mov	_P3_2,c
                           3104 ;src/menu.c:1141: break;
                           3105 ;src/menu.c:1143: ZONE_3_OUTPUT = ZONE_3_PREPARED;
                           3106 ;       Peephole 112.b  changed ljmp to sjmp
   18DD 80 0E              3107 	sjmp    00106$
   18DF                    3108 00103$:
                           3109 ;     genAssign
   18DF E5 3B              3110 	mov	a,_ZONE_3_PREPARED
   18E1 24 FF              3111 	add	a,#0xff
   18E3 92 B3              3112 	mov	_P3_3,c
                           3113 ;src/menu.c:1144: break;
                           3114 ;src/menu.c:1146: ZONE_4_OUTPUT = ZONE_4_PREPARED;
                           3115 ;       Peephole 112.b  changed ljmp to sjmp
   18E5 80 06              3116 	sjmp    00106$
   18E7                    3117 00104$:
                           3118 ;     genAssign
   18E7 E5 3C              3119 	mov	a,_ZONE_4_PREPARED
   18E9 24 FF              3120 	add	a,#0xff
   18EB 92 90              3121 	mov	_P1_0,c
                           3122 ;src/menu.c:1148: }
   18ED                    3123 00106$:
   18ED 85 40 81           3124 	mov	sp,_bp
   18F0 D0 40              3125 	pop	_bp
   18F2 22                 3126 	ret
                           3127 ;------------------------------------------------------------
                           3128 ;Allocation info for local variables in function 'switch_zone_prepare'
                           3129 ;------------------------------------------------------------
                           3130 ;value                     Allocated to stack - offset -3
                           3131 ;zone_no                   Allocated to registers r2 
                           3132 ;------------------------------------------------------------
                           3133 ;src/menu.c:1151: void switch_zone_prepare(const char zone_no, const bool value)
                           3134 ;	-----------------------------------------
                           3135 ;	 function switch_zone_prepare
                           3136 ;	-----------------------------------------
   18F3                    3137 _switch_zone_prepare:
   18F3 C0 40              3138 	push	_bp
   18F5 85 81 40           3139 	mov	_bp,sp
                           3140 ;     genReceive
                           3141 ;src/menu.c:1153: switch(zone_no)
                           3142 ;     genCmpLt
                           3143 ;     genCmp
                           3144 ;       Peephole 244.a  moving first to a instead of r2
   18F8 E5 82              3145 	mov	a,dpl
   18FA FA                 3146 	mov	r2,a
                           3147 ;     genIfxJump
                           3148 ;       Peephole 112.a  removed ljmp by inverse jump logic
   18FB 20 E7 42           3149 	jb      acc.7,00106$
   18FE                    3150 00110$:
                           3151 ;     genCmpGt
                           3152 ;     genCmp
   18FE C3                 3153 	clr	c
                           3154 ;       Peephole 159    avoided xrl during execution
   18FF 74 83              3155 	mov  a,#(0x03 ^ 0x80)
   1901 8A F0              3156 	mov	b,r2
   1903 63 F0 80           3157 	xrl	b,#0x80
   1906 95 F0              3158 	subb	a,b
                           3159 ;     genIfxJump
                           3160 ;       Peephole 112.b  changed ljmp to sjmp
                           3161 ;       Peephole 160    removed sjmp by inverse jump logic
   1908 40 36              3162 	jc      00106$
   190A                    3163 00111$:
                           3164 ;     genJumpTab
   190A EA                 3165 	mov	a,r2
   190B 25 E0              3166 	add	a,acc
   190D 2A                 3167 	add	a,r2
   190E 90 19 12           3168 	mov	dptr,#00112$
   1911 73                 3169 	jmp	@a+dptr
   1912                    3170 00112$:
   1912 02 19 1E           3171 	ljmp	00101$
   1915 02 19 27           3172 	ljmp	00102$
   1918 02 19 30           3173 	ljmp	00103$
   191B 02 19 39           3174 	ljmp	00104$
                           3175 ;src/menu.c:1156: ZONE_1_PREPARED = value;
   191E                    3176 00101$:
                           3177 ;     genAssign
   191E E5 40              3178 	mov	a,_bp
   1920 24 FD              3179 	add	a,#0xfd
   1922 F8                 3180 	mov	r0,a
   1923 86 39              3181 	mov	_ZONE_1_PREPARED,@r0
                           3182 ;src/menu.c:1157: break;
                           3183 ;src/menu.c:1159: ZONE_2_PREPARED = value;
                           3184 ;       Peephole 112.b  changed ljmp to sjmp
   1925 80 19              3185 	sjmp    00106$
   1927                    3186 00102$:
                           3187 ;     genAssign
   1927 E5 40              3188 	mov	a,_bp
   1929 24 FD              3189 	add	a,#0xfd
   192B F8                 3190 	mov	r0,a
   192C 86 3A              3191 	mov	_ZONE_2_PREPARED,@r0
                           3192 ;src/menu.c:1160: break;
                           3193 ;src/menu.c:1162: ZONE_3_PREPARED = value;
                           3194 ;       Peephole 112.b  changed ljmp to sjmp
   192E 80 10              3195 	sjmp    00106$
   1930                    3196 00103$:
                           3197 ;     genAssign
   1930 E5 40              3198 	mov	a,_bp
   1932 24 FD              3199 	add	a,#0xfd
   1934 F8                 3200 	mov	r0,a
   1935 86 3B              3201 	mov	_ZONE_3_PREPARED,@r0
                           3202 ;src/menu.c:1163: break;
                           3203 ;src/menu.c:1165: ZONE_4_PREPARED = value;
                           3204 ;       Peephole 112.b  changed ljmp to sjmp
   1937 80 07              3205 	sjmp    00106$
   1939                    3206 00104$:
                           3207 ;     genAssign
   1939 E5 40              3208 	mov	a,_bp
   193B 24 FD              3209 	add	a,#0xfd
   193D F8                 3210 	mov	r0,a
   193E 86 3C              3211 	mov	_ZONE_4_PREPARED,@r0
                           3212 ;src/menu.c:1167: }
   1940                    3213 00106$:
   1940 85 40 81           3214 	mov	sp,_bp
   1943 D0 40              3215 	pop	_bp
   1945 22                 3216 	ret
                           3217 ;------------------------------------------------------------
                           3218 ;Allocation info for local variables in function 'display_enabled_channels'
                           3219 ;------------------------------------------------------------
                           3220 ;display_force             Allocated to registers r2 
                           3221 ;i                         Allocated to stack - offset 1
                           3222 ;display                   Allocated to registers r2 r3 r4 
                           3223 ;sec                       Allocated with name '_display_enabled_channels_sec_1_1'
                           3224 ;------------------------------------------------------------
                           3225 ;src/menu.c:1170: void display_enabled_channels(const char display_force)
                           3226 ;	-----------------------------------------
                           3227 ;	 function display_enabled_channels
                           3228 ;	-----------------------------------------
   1946                    3229 _display_enabled_channels:
   1946 C0 40              3230 	push	_bp
   1948 85 81 40           3231 	mov	_bp,sp
   194B 05 81              3232 	inc	sp
                           3233 ;     genReceive
   194D AA 82              3234 	mov	r2,dpl
                           3235 ;src/menu.c:1176: ds1302_read_rtc(&system_time);
                           3236 ;     genCall
                           3237 ;       Peephole 182.a  used 16 bit load of DPTR
   194F 90 01 81           3238 	mov     dptr,#_system_time
   1952 75 F0 01           3239 	mov	b,#0x01
   1955 C0 02              3240 	push	ar2
   1957 12 5E A7           3241 	lcall	_ds1302_read_rtc
   195A D0 02              3242 	pop	ar2
                           3243 ;src/menu.c:1178: if (sec != system_time.tm_sec || display_force == true)
                           3244 ;     genPointerGet
                           3245 ;     genFarPointerGet
   195C 90 01 81           3246 	mov	dptr,#_system_time
   195F E0                 3247 	movx	a,@dptr
   1960 FB                 3248 	mov	r3,a
                           3249 ;     genCmpEq
   1961 E5 3F              3250 	mov	a,_display_enabled_channels_sec_1_1
                           3251 ;       Peephole 112.b  changed ljmp to sjmp
                           3252 ;       Peephole 199    optimized misc jump sequence
   1963 B5 03 08           3253 	cjne    a,ar3,00108$
                           3254 ;00125$:
                           3255 ;       Peephole 200    removed redundant sjmp
   1966                    3256 00126$:
                           3257 ;     genCmpEq
   1966 BA 01 02           3258 	cjne	r2,#0x01,00127$
   1969 80 03              3259 	sjmp	00128$
   196B                    3260 00127$:
   196B 02 1A AF           3261 	ljmp	00115$
   196E                    3262 00128$:
   196E                    3263 00108$:
                           3264 ;src/menu.c:1180: BLINKING_OFF;
                           3265 ;     genAssign
   196E 75 30 00           3266 	mov	_blinking,#0x00
                           3267 ;src/menu.c:1181: sec = system_time.tm_sec;
                           3268 ;     genAssign
   1971 8B 3F              3269 	mov	_display_enabled_channels_sec_1_1,r3
                           3270 ;src/menu.c:1182: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
                           3271 ;     genAssign
                           3272 ;       Peephole 212    reduced add sequence to inc
   1973 A8 40              3273 	mov     r0,_bp
   1975 08                 3274 	inc     r0
   1976 76 00              3275 	mov	@r0,#0x00
   1978                    3276 00111$:
                           3277 ;     genMult
                           3278 ;     genMultOneByte
   1978 E5 31              3279 	mov	a,_current_display_state
   197A 75 F0 3C           3280 	mov	b,#0x3C
   197D A4                 3281 	mul	ab
                           3282 ;     genPlus
   197E 24 0E              3283 	add	a,#_menu
   1980 FB                 3284 	mov	r3,a
   1981 E5 F0              3285 	mov	a,b
   1983 34 3C              3286 	addc	a,#(_menu >> 8)
   1985 FC                 3287 	mov	r4,a
                           3288 ;     genPlus
                           3289 ;     genPlusIncr
   1986 74 03              3290 	mov	a,#0x03
                           3291 ;       Peephole 236.a  used r3 instead of ar3
   1988 2B                 3292 	add     a,r3
   1989 F5 82              3293 	mov	dpl,a
                           3294 ;       Peephole 181    changed mov to clr
   198B E4                 3295 	clr     a
                           3296 ;       Peephole 236.b  used r4 instead of ar4
   198C 3C                 3297 	addc    a,r4
   198D F5 83              3298 	mov	dph,a
                           3299 ;     genPointerGet
                           3300 ;     genCodePointerGet
                           3301 ;       Peephole 181    changed mov to clr
   198F E4                 3302 	clr     a
   1990 93                 3303 	movc	a,@a+dptr
                           3304 ;     genCast
                           3305 ;       Peephole 105    removed redundant mov
   1991 FD                 3306 	mov     r5,a
   1992 33                 3307 	rlc	a
   1993 95 E0              3308 	subb	a,acc
   1995 FE                 3309 	mov	r6,a
                           3310 ;     genMinus
                           3311 ;     genMinusDec
   1996 1D                 3312 	dec	r5
   1997 BD FF 01           3313 	cjne	r5,#0xff,00129$
   199A 1E                 3314 	dec	r6
   199B                    3315 00129$:
                           3316 ;     genCast
                           3317 ;       Peephole 212    reduced add sequence to inc
   199B A8 40              3318 	mov     r0,_bp
   199D 08                 3319 	inc     r0
   199E 86 07              3320 	mov	ar7,@r0
   19A0 7A 00              3321 	mov	r2,#0x00
                           3322 ;     genCmpLt
                           3323 ;     genCmp
   19A2 C3                 3324 	clr	c
   19A3 EF                 3325 	mov	a,r7
   19A4 9D                 3326 	subb	a,r5
   19A5 EA                 3327 	mov	a,r2
   19A6 64 80              3328 	xrl	a,#0x80
   19A8 8E F0              3329 	mov	b,r6
   19AA 63 F0 80           3330 	xrl	b,#0x80
   19AD 95 F0              3331 	subb	a,b
                           3332 ;     genIfxJump
   19AF 40 03              3333 	jc	00130$
   19B1 02 1A AC           3334 	ljmp	00114$
   19B4                    3335 00130$:
                           3336 ;src/menu.c:1184: if ( i < NUMBER_OF_CHANNELS)
                           3337 ;     genCmpLt
                           3338 ;       Peephole 212    reduced add sequence to inc
   19B4 A8 40              3339 	mov     r0,_bp
   19B6 08                 3340 	inc     r0
                           3341 ;     genCmp
   19B7 B6 04 00           3342 	cjne	@r0,#0x04,00131$
   19BA                    3343 00131$:
                           3344 ;     genIfxJump
   19BA 40 03              3345 	jc	00132$
   19BC 02 1A A5           3346 	ljmp	00113$
   19BF                    3347 00132$:
                           3348 ;src/menu.c:1186: display = menu[current_display_state].item[i].display;
                           3349 ;     genPlus
                           3350 ;     genPlusIncr
   19BF 74 04              3351 	mov	a,#0x04
                           3352 ;       Peephole 236.a  used r3 instead of ar3
   19C1 2B                 3353 	add     a,r3
   19C2 FB                 3354 	mov	r3,a
                           3355 ;       Peephole 181    changed mov to clr
   19C3 E4                 3356 	clr     a
                           3357 ;       Peephole 236.b  used r4 instead of ar4
   19C4 3C                 3358 	addc    a,r4
   19C5 FC                 3359 	mov	r4,a
                           3360 ;     genMult
                           3361 ;       Peephole 212    reduced add sequence to inc
   19C6 A8 40              3362 	mov     r0,_bp
   19C8 08                 3363 	inc     r0
                           3364 ;     genMultOneByte
   19C9 E6                 3365 	mov	a,@r0
   19CA 75 F0 08           3366 	mov	b,#0x08
   19CD A4                 3367 	mul	ab
                           3368 ;     genPlus
                           3369 ;       Peephole 236.a  used r3 instead of ar3
   19CE 2B                 3370 	add     a,r3
   19CF FB                 3371 	mov	r3,a
   19D0 E5 F0              3372 	mov	a,b
                           3373 ;       Peephole 236.b  used r4 instead of ar4
   19D2 3C                 3374 	addc    a,r4
   19D3 FC                 3375 	mov	r4,a
                           3376 ;     genPlus
   19D4 74 05              3377 	mov	a,#0x05
                           3378 ;       Peephole 236.a  used r3 instead of ar3
   19D6 2B                 3379 	add     a,r3
   19D7 F5 82              3380 	mov	dpl,a
                           3381 ;       Peephole 181    changed mov to clr
   19D9 E4                 3382 	clr     a
                           3383 ;       Peephole 236.b  used r4 instead of ar4
   19DA 3C                 3384 	addc    a,r4
   19DB F5 83              3385 	mov	dph,a
                           3386 ;     genPointerGet
                           3387 ;     genCodePointerGet
                           3388 ;       Peephole 181    changed mov to clr
   19DD E4                 3389 	clr     a
   19DE 93                 3390 	movc	a,@a+dptr
   19DF FA                 3391 	mov	r2,a
   19E0 74 01              3392 	mov	a,#0x01
   19E2 93                 3393 	movc	a,@a+dptr
   19E3 FB                 3394 	mov	r3,a
   19E4 74 02              3395 	mov	a,#0x02
   19E6 93                 3396 	movc	a,@a+dptr
   19E7 FC                 3397 	mov	r4,a
                           3398 ;     genAssign
                           3399 ;src/menu.c:1188: lcd_goto_xy(display->x+4, display->y);
                           3400 ;     genPlus
                           3401 ;     genPlusIncr
   19E8 74 01              3402 	mov	a,#0x01
                           3403 ;       Peephole 236.a  used r2 instead of ar2
   19EA 2A                 3404 	add     a,r2
   19EB FD                 3405 	mov	r5,a
                           3406 ;       Peephole 181    changed mov to clr
   19EC E4                 3407 	clr     a
                           3408 ;       Peephole 236.b  used r3 instead of ar3
   19ED 3B                 3409 	addc    a,r3
   19EE FE                 3410 	mov	r6,a
   19EF 8C 07              3411 	mov	ar7,r4
                           3412 ;     genPointerGet
                           3413 ;     genGenPointerGet
   19F1 8D 82              3414 	mov	dpl,r5
   19F3 8E 83              3415 	mov	dph,r6
   19F5 8F F0              3416 	mov	b,r7
   19F7 12 71 F5           3417 	lcall	__gptrget
   19FA FD                 3418 	mov	r5,a
                           3419 ;     genPointerGet
                           3420 ;     genGenPointerGet
   19FB 8A 82              3421 	mov	dpl,r2
   19FD 8B 83              3422 	mov	dph,r3
   19FF 8C F0              3423 	mov	b,r4
   1A01 12 71 F5           3424 	lcall	__gptrget
   1A04 FA                 3425 	mov	r2,a
                           3426 ;     genPlus
                           3427 ;     genPlusIncr
   1A05 74 04              3428 	mov	a,#0x04
                           3429 ;       Peephole 236.a  used r2 instead of ar2
   1A07 2A                 3430 	add     a,r2
   1A08 F5 82              3431 	mov	dpl,a
                           3432 ;     genIpush
   1A0A C0 05              3433 	push	ar5
                           3434 ;     genCall
   1A0C 12 0A CD           3435 	lcall	_lcd_goto_xy
   1A0F 15 81              3436 	dec	sp
                           3437 ;src/menu.c:1189: switch(system_data.enabled[i])
                           3438 ;     genCast
                           3439 ;       Peephole 212    reduced add sequence to inc
   1A11 A8 40              3440 	mov     r0,_bp
   1A13 08                 3441 	inc     r0
   1A14 86 02              3442 	mov	ar2,@r0
   1A16 7B 00              3443 	mov	r3,#0x00
                           3444 ;     genPlus
                           3445 ;       Peephole 236.g  used r2 instead of ar2
   1A18 EA                 3446 	mov     a,r2
   1A19 24 75              3447 	add	a,#(_system_data + 0x0168)
   1A1B F5 82              3448 	mov	dpl,a
                           3449 ;       Peephole 236.g  used r3 instead of ar3
   1A1D EB                 3450 	mov     a,r3
   1A1E 34 01              3451 	addc	a,#((_system_data + 0x0168) >> 8)
   1A20 F5 83              3452 	mov	dph,a
                           3453 ;     genPointerGet
                           3454 ;     genFarPointerGet
   1A22 E0                 3455 	movx	a,@dptr
   1A23 FA                 3456 	mov	r2,a
                           3457 ;     genCmpEq
   1A24 BA 00 02           3458 	cjne	r2,#0x00,00133$
                           3459 ;       Peephole 112.b  changed ljmp to sjmp
   1A27 80 20              3460 	sjmp    00102$
   1A29                    3461 00133$:
                           3462 ;     genCmpEq
   1A29 BA 02 02           3463 	cjne	r2,#0x02,00134$
                           3464 ;       Peephole 112.b  changed ljmp to sjmp
   1A2C 80 0A              3465 	sjmp    00101$
   1A2E                    3466 00134$:
                           3467 ;     genCmpEq
   1A2E BA 04 02           3468 	cjne	r2,#0x04,00135$
                           3469 ;       Peephole 112.b  changed ljmp to sjmp
   1A31 80 27              3470 	sjmp    00103$
   1A33                    3471 00135$:
                           3472 ;     genCmpEq
                           3473 ;       Peephole 112.b  changed ljmp to sjmp
                           3474 ;src/menu.c:1192: printf_fast("+");
                           3475 ;       Peephole 112.b  changed ljmp to sjmp
                           3476 ;       Peephole 199    optimized misc jump sequence
   1A33 BA 08 6F           3477 	cjne    r2,#0x08,00113$
   1A36 80 49              3478 	sjmp    00104$
                           3479 ;00136$:
   1A38                    3480 00101$:
                           3481 ;     genIpush
   1A38 74 55              3482 	mov	a,#__str_11
   1A3A C0 E0              3483 	push	acc
   1A3C 74 4A              3484 	mov	a,#(__str_11 >> 8)
   1A3E C0 E0              3485 	push	acc
                           3486 ;     genCall
   1A40 12 72 21           3487 	lcall	_printf_fast
   1A43 15 81              3488 	dec	sp
   1A45 15 81              3489 	dec	sp
                           3490 ;src/menu.c:1194: break;
                           3491 ;src/menu.c:1196: printf_fast("-");
                           3492 ;       Peephole 112.b  changed ljmp to sjmp
   1A47 80 5C              3493 	sjmp    00113$
   1A49                    3494 00102$:
                           3495 ;     genIpush
   1A49 74 2C              3496 	mov	a,#__str_6
   1A4B C0 E0              3497 	push	acc
   1A4D 74 4A              3498 	mov	a,#(__str_6 >> 8)
   1A4F C0 E0              3499 	push	acc
                           3500 ;     genCall
   1A51 12 72 21           3501 	lcall	_printf_fast
   1A54 15 81              3502 	dec	sp
   1A56 15 81              3503 	dec	sp
                           3504 ;src/menu.c:1198: break;
                           3505 ;src/menu.c:1200: printf_fast("*");
                           3506 ;       Peephole 112.b  changed ljmp to sjmp
   1A58 80 4B              3507 	sjmp    00113$
   1A5A                    3508 00103$:
                           3509 ;     genIpush
   1A5A 74 57              3510 	mov	a,#__str_12
   1A5C C0 E0              3511 	push	acc
   1A5E 74 4A              3512 	mov	a,#(__str_12 >> 8)
   1A60 C0 E0              3513 	push	acc
                           3514 ;     genCall
   1A62 12 72 21           3515 	lcall	_printf_fast
   1A65 15 81              3516 	dec	sp
   1A67 15 81              3517 	dec	sp
                           3518 ;src/menu.c:1201: switch_zone_prepare(i,1);
                           3519 ;     genIpush
   1A69 74 01              3520 	mov	a,#0x01
   1A6B C0 E0              3521 	push	acc
                           3522 ;     genCall
                           3523 ;       Peephole 212    reduced add sequence to inc
   1A6D A8 40              3524 	mov     r0,_bp
   1A6F 08                 3525 	inc     r0
   1A70 86 82              3526 	mov	dpl,@r0
   1A72 12 18 F3           3527 	lcall	_switch_zone_prepare
   1A75 15 81              3528 	dec	sp
                           3529 ;src/menu.c:1202: switch_zone(i);
                           3530 ;     genCall
                           3531 ;       Peephole 212    reduced add sequence to inc
   1A77 A8 40              3532 	mov     r0,_bp
   1A79 08                 3533 	inc     r0
   1A7A 86 82              3534 	mov	dpl,@r0
   1A7C 12 18 A4           3535 	lcall	_switch_zone
                           3536 ;src/menu.c:1203: break;
                           3537 ;src/menu.c:1205: printf_fast("#");
                           3538 ;       Peephole 112.b  changed ljmp to sjmp
   1A7F 80 24              3539 	sjmp    00113$
   1A81                    3540 00104$:
                           3541 ;     genIpush
   1A81 74 59              3542 	mov	a,#__str_13
   1A83 C0 E0              3543 	push	acc
   1A85 74 4A              3544 	mov	a,#(__str_13 >> 8)
   1A87 C0 E0              3545 	push	acc
                           3546 ;     genCall
   1A89 12 72 21           3547 	lcall	_printf_fast
   1A8C 15 81              3548 	dec	sp
   1A8E 15 81              3549 	dec	sp
                           3550 ;src/menu.c:1206: switch_zone_prepare(i,0);
                           3551 ;     genIpush
                           3552 ;       Peephole 181    changed mov to clr
   1A90 E4                 3553 	clr     a
   1A91 C0 E0              3554 	push	acc
                           3555 ;     genCall
                           3556 ;       Peephole 212    reduced add sequence to inc
   1A93 A8 40              3557 	mov     r0,_bp
   1A95 08                 3558 	inc     r0
   1A96 86 82              3559 	mov	dpl,@r0
   1A98 12 18 F3           3560 	lcall	_switch_zone_prepare
   1A9B 15 81              3561 	dec	sp
                           3562 ;src/menu.c:1207: switch_zone(i);
                           3563 ;     genCall
                           3564 ;       Peephole 212    reduced add sequence to inc
   1A9D A8 40              3565 	mov     r0,_bp
   1A9F 08                 3566 	inc     r0
   1AA0 86 82              3567 	mov	dpl,@r0
   1AA2 12 18 A4           3568 	lcall	_switch_zone
                           3569 ;src/menu.c:1209: }
   1AA5                    3570 00113$:
                           3571 ;src/menu.c:1182: for (i = 0; i< (menu[current_display_state].max_pos - 1); i++)
                           3572 ;     genPlus
                           3573 ;       Peephole 212    reduced add sequence to inc
   1AA5 A8 40              3574 	mov     r0,_bp
   1AA7 08                 3575 	inc     r0
                           3576 ;     genPlusIncr
   1AA8 06                 3577 	inc	@r0
   1AA9 02 19 78           3578 	ljmp	00111$
   1AAC                    3579 00114$:
                           3580 ;src/menu.c:1212: BLINKING_ON;
                           3581 ;     genAssign
   1AAC 75 30 01           3582 	mov	_blinking,#0x01
   1AAF                    3583 00115$:
   1AAF 85 40 81           3584 	mov	sp,_bp
   1AB2 D0 40              3585 	pop	_bp
   1AB4 22                 3586 	ret
                           3587 ;------------------------------------------------------------
                           3588 ;Allocation info for local variables in function 'is_day_matching'
                           3589 ;------------------------------------------------------------
                           3590 ;wday                      Allocated to stack - offset -3
                           3591 ;zone                      Allocated to registers r2 
                           3592 ;config_day                Allocated to registers r2 
                           3593 ;current_day               Allocated to registers r3 
                           3594 ;------------------------------------------------------------
                           3595 ;src/menu.c:1217: unsigned char is_day_matching(const char zone, const char wday)
                           3596 ;	-----------------------------------------
                           3597 ;	 function is_day_matching
                           3598 ;	-----------------------------------------
   1AB5                    3599 _is_day_matching:
   1AB5 C0 40              3600 	push	_bp
   1AB7 85 81 40           3601 	mov	_bp,sp
                           3602 ;     genReceive
   1ABA AA 82              3603 	mov	r2,dpl
                           3604 ;src/menu.c:1222: current_day = wday;
                           3605 ;     genAssign
   1ABC E5 40              3606 	mov	a,_bp
   1ABE 24 FD              3607 	add	a,#0xfd
   1AC0 F8                 3608 	mov	r0,a
   1AC1 86 03              3609 	mov	ar3,@r0
                           3610 ;     genAssign
                           3611 ;src/menu.c:1223: if (wday < 6)
                           3612 ;     genCmpLt
   1AC3 E5 40              3613 	mov	a,_bp
   1AC5 24 FD              3614 	add	a,#0xfd
   1AC7 F8                 3615 	mov	r0,a
                           3616 ;     genCmp
   1AC8 C3                 3617 	clr	c
   1AC9 E6                 3618 	mov	a,@r0
   1ACA 64 80              3619 	xrl	a,#0x80
   1ACC 94 86              3620 	subb	a,#0x86
                           3621 ;     genIfxJump
                           3622 ;       Peephole 108    removed ljmp by inverse jump logic
   1ACE 50 02              3623 	jnc     00102$
   1AD0                    3624 00110$:
                           3625 ;src/menu.c:1224: current_day = 0;
                           3626 ;     genAssign
   1AD0 7B 00              3627 	mov	r3,#0x00
   1AD2                    3628 00102$:
                           3629 ;src/menu.c:1226: config_day = zone_day_map[zone].day;
                           3630 ;     genMult
                           3631 ;     genMultOneByte
   1AD2 C2 D5              3632 	clr	F0
   1AD4 75 F0 02           3633 	mov	b,#0x02
   1AD7 EA                 3634 	mov	a,r2
   1AD8 30 E7 04           3635 	jnb	acc.7,00111$
   1ADB B2 D5              3636 	cpl	F0
   1ADD F4                 3637 	cpl	a
   1ADE 04                 3638 	inc	a
   1ADF                    3639 00111$:
   1ADF A4                 3640 	mul	ab
   1AE0 30 D5 0A           3641 	jnb	F0,00112$
   1AE3 F4                 3642 	cpl	a
   1AE4 24 01              3643 	add	a,#1
   1AE6 C5 F0              3644 	xch	a,b
   1AE8 F4                 3645 	cpl	a
   1AE9 34 00              3646 	addc	a,#0
   1AEB C5 F0              3647 	xch	a,b
   1AED                    3648 00112$:
                           3649 ;     genPlus
   1AED 24 CA              3650 	add	a,#_zone_day_map
   1AEF FA                 3651 	mov	r2,a
   1AF0 E5 F0              3652 	mov	a,b
   1AF2 34 37              3653 	addc	a,#(_zone_day_map >> 8)
   1AF4 FC                 3654 	mov	r4,a
                           3655 ;     genPlus
                           3656 ;     genPlusIncr
   1AF5 74 01              3657 	mov	a,#0x01
                           3658 ;       Peephole 236.a  used r2 instead of ar2
   1AF7 2A                 3659 	add     a,r2
   1AF8 F5 82              3660 	mov	dpl,a
                           3661 ;       Peephole 181    changed mov to clr
   1AFA E4                 3662 	clr     a
                           3663 ;       Peephole 236.b  used r4 instead of ar4
   1AFB 3C                 3664 	addc    a,r4
   1AFC F5 83              3665 	mov	dph,a
                           3666 ;     genPointerGet
                           3667 ;     genCodePointerGet
                           3668 ;       Peephole 181    changed mov to clr
   1AFE E4                 3669 	clr     a
   1AFF 93                 3670 	movc	a,@a+dptr
                           3671 ;     genAssign
                           3672 ;src/menu.c:1227: if(config_day == current_day)
                           3673 ;     genCmpEq
                           3674 ;       Peephole 105    removed redundant mov
   1B00 FA                 3675 	mov     r2,a
                           3676 ;       Peephole 112.b  changed ljmp to sjmp
                           3677 ;       Peephole 199    optimized misc jump sequence
   1B01 B5 03 05           3678 	cjne    a,ar3,00104$
                           3679 ;00113$:
                           3680 ;       Peephole 200    removed redundant sjmp
   1B04                    3681 00114$:
                           3682 ;src/menu.c:1228: return true;
                           3683 ;     genRet
   1B04 75 82 01           3684 	mov	dpl,#0x01
                           3685 ;       Peephole 112.b  changed ljmp to sjmp
   1B07 80 03              3686 	sjmp    00106$
   1B09                    3687 00104$:
                           3688 ;src/menu.c:1230: return false;
                           3689 ;     genRet
   1B09 75 82 00           3690 	mov	dpl,#0x00
   1B0C                    3691 00106$:
   1B0C 85 40 81           3692 	mov	sp,_bp
   1B0F D0 40              3693 	pop	_bp
   1B11 22                 3694 	ret
                           3695 ;------------------------------------------------------------
                           3696 ;Allocation info for local variables in function 'control_workloop'
                           3697 ;------------------------------------------------------------
                           3698 ;i                         Allocated to stack - offset 1
                           3699 ;j                         Allocated to stack - offset 2
                           3700 ;offset                    Allocated to registers r3 
                           3701 ;result                    Allocated to registers r3 r4 
                           3702 ;weekday                   Allocated to registers r2 
                           3703 ;histereza                 Allocated to stack - offset 3
                           3704 ;sloc0                     Allocated to stack - offset 4
                           3705 ;sloc1                     Allocated to stack - offset 6
                           3706 ;sloc2                     Allocated to stack - offset 8
                           3707 ;------------------------------------------------------------
                           3708 ;src/menu.c:1236: void control_workloop(void)
                           3709 ;	-----------------------------------------
                           3710 ;	 function control_workloop
                           3711 ;	-----------------------------------------
   1B12                    3712 _control_workloop:
   1B12 C0 40              3713 	push	_bp
   1B14 85 81 40           3714 	mov	_bp,sp
   1B17 E5 81              3715 	mov	a,sp
   1B19 24 0B              3716 	add	a,#0x0b
   1B1B F5 81              3717 	mov	sp,a
                           3718 ;src/menu.c:1242: unsigned char histereza = 0;
                           3719 ;     genAssign
   1B1D E5 40              3720 	mov	a,_bp
   1B1F 24 03              3721 	add	a,#0x03
   1B21 F8                 3722 	mov	r0,a
   1B22 76 00              3723 	mov	@r0,#0x00
                           3724 ;src/menu.c:1243: ds1302_read_rtc(&system_time);
                           3725 ;     genCall
                           3726 ;       Peephole 182.a  used 16 bit load of DPTR
   1B24 90 01 81           3727 	mov     dptr,#_system_time
   1B27 75 F0 01           3728 	mov	b,#0x01
   1B2A 12 5E A7           3729 	lcall	_ds1302_read_rtc
                           3730 ;src/menu.c:1246: temp_long = system_time.tm_hour;
                           3731 ;     genPointerGet
                           3732 ;     genFarPointerGet
   1B2D 90 01 83           3733 	mov	dptr,#(_system_time + 0x0002)
   1B30 E0                 3734 	movx	a,@dptr
   1B31 FB                 3735 	mov	r3,a
                           3736 ;     genCast
   1B32 8B 35              3737 	mov	_temp_long,r3
   1B34 75 36 00           3738 	mov	(_temp_long + 1),#0x00
   1B37 75 37 00           3739 	mov	(_temp_long + 2),#0x00
   1B3A 75 38 00           3740 	mov	(_temp_long + 3),#0x00
                           3741 ;src/menu.c:1247: temp_long *= 3600;
                           3742 ;     genAssign
   1B3D 75 42 10           3743 	mov	__mullong_PARM_2,#0x10
   1B40 75 43 0E           3744 	mov	(__mullong_PARM_2 + 1),#0x0E
   1B43 75 44 00           3745 	mov	(__mullong_PARM_2 + 2),#0x00
   1B46 75 45 00           3746 	mov	(__mullong_PARM_2 + 3),#0x00
                           3747 ;     genCall
   1B49 85 35 82           3748 	mov	dpl,_temp_long
   1B4C 85 36 83           3749 	mov	dph,(_temp_long + 1)
   1B4F 85 37 F0           3750 	mov	b,(_temp_long + 2)
   1B52 E5 38              3751 	mov	a,(_temp_long + 3)
   1B54 12 70 BF           3752 	lcall	__mullong
   1B57 85 82 35           3753 	mov	_temp_long,dpl
   1B5A 85 83 36           3754 	mov	(_temp_long + 1),dph
   1B5D 85 F0 37           3755 	mov	(_temp_long + 2),b
   1B60 F5 38              3756 	mov	(_temp_long + 3),a
                           3757 ;src/menu.c:1248: result = system_time.tm_min * 60;
                           3758 ;     genPointerGet
                           3759 ;     genFarPointerGet
   1B62 90 01 82           3760 	mov	dptr,#(_system_time + 0x0001)
   1B65 E0                 3761 	movx	a,@dptr
                           3762 ;     genMult
                           3763 ;     genMultOneByte
                           3764 ;       Peephole 105    removed redundant mov
   1B66 FB                 3765 	mov     r3,a
   1B67 75 F0 3C           3766 	mov	b,#0x3C
   1B6A A4                 3767 	mul	ab
   1B6B FB                 3768 	mov	r3,a
   1B6C AC F0              3769 	mov	r4,b
                           3770 ;src/menu.c:1249: temp_long += result;
                           3771 ;     genCast
                           3772 ;     genPlus
                           3773 ;       Peephole 3.c    changed mov to clr
   1B6E E4                 3774 	clr     a
   1B6F FD                 3775 	mov     r5,a
   1B70 FE                 3776 	mov     r6,a
                           3777 ;       Peephole 236.g  used r3 instead of ar3
   1B71 EB                 3778 	mov     a,r3
   1B72 25 35              3779 	add	a,_temp_long
   1B74 F5 35              3780 	mov	_temp_long,a
                           3781 ;       Peephole 236.g  used r4 instead of ar4
   1B76 EC                 3782 	mov     a,r4
   1B77 35 36              3783 	addc	a,(_temp_long + 1)
   1B79 F5 36              3784 	mov	(_temp_long + 1),a
                           3785 ;       Peephole 236.g  used r5 instead of ar5
   1B7B ED                 3786 	mov     a,r5
   1B7C 35 37              3787 	addc	a,(_temp_long + 2)
   1B7E F5 37              3788 	mov	(_temp_long + 2),a
                           3789 ;       Peephole 236.g  used r6 instead of ar6
   1B80 EE                 3790 	mov     a,r6
   1B81 35 38              3791 	addc	a,(_temp_long + 3)
   1B83 F5 38              3792 	mov	(_temp_long + 3),a
                           3793 ;src/menu.c:1250: temp_long += system_time.tm_sec;
                           3794 ;     genPointerGet
                           3795 ;     genFarPointerGet
   1B85 90 01 81           3796 	mov	dptr,#_system_time
   1B88 E0                 3797 	movx	a,@dptr
   1B89 FB                 3798 	mov	r3,a
                           3799 ;     genCast
   1B8A 7C 00              3800 	mov	r4,#0x00
                           3801 ;     genCast
   1B8C EC                 3802 	mov	a,r4
   1B8D 33                 3803 	rlc	a
   1B8E 95 E0              3804 	subb	a,acc
   1B90 FD                 3805 	mov	r5,a
   1B91 FE                 3806 	mov	r6,a
                           3807 ;     genPlus
                           3808 ;       Peephole 236.g  used r3 instead of ar3
   1B92 EB                 3809 	mov     a,r3
   1B93 25 35              3810 	add	a,_temp_long
   1B95 F5 35              3811 	mov	_temp_long,a
                           3812 ;       Peephole 236.g  used r4 instead of ar4
   1B97 EC                 3813 	mov     a,r4
   1B98 35 36              3814 	addc	a,(_temp_long + 1)
   1B9A F5 36              3815 	mov	(_temp_long + 1),a
                           3816 ;       Peephole 236.g  used r5 instead of ar5
   1B9C ED                 3817 	mov     a,r5
   1B9D 35 37              3818 	addc	a,(_temp_long + 2)
   1B9F F5 37              3819 	mov	(_temp_long + 2),a
                           3820 ;       Peephole 236.g  used r6 instead of ar6
   1BA1 EE                 3821 	mov     a,r6
   1BA2 35 38              3822 	addc	a,(_temp_long + 3)
   1BA4 F5 38              3823 	mov	(_temp_long + 3),a
                           3824 ;src/menu.c:1252: for (j = 0; j<CHANNELS_COUNT; j++)
                           3825 ;     genAssign
   1BA6 E5 40              3826 	mov	a,_bp
   1BA8 24 02              3827 	add	a,#0x02
   1BAA F8                 3828 	mov	r0,a
   1BAB 76 00              3829 	mov	@r0,#0x00
   1BAD                    3830 00124$:
                           3831 ;     genCmpLt
   1BAD E5 40              3832 	mov	a,_bp
   1BAF 24 02              3833 	add	a,#0x02
   1BB1 F8                 3834 	mov	r0,a
                           3835 ;     genCmp
   1BB2 B6 04 00           3836 	cjne	@r0,#0x04,00141$
   1BB5                    3837 00141$:
                           3838 ;     genIfxJump
   1BB5 40 03              3839 	jc	00142$
   1BB7 02 1E 93           3840 	ljmp	00127$
   1BBA                    3841 00142$:
                           3842 ;src/menu.c:1254: for (i = 0; i<ZONES_COUNT; i++)
                           3843 ;     genAssign
                           3844 ;       Peephole 212    reduced add sequence to inc
   1BBA A8 40              3845 	mov     r0,_bp
   1BBC 08                 3846 	inc     r0
   1BBD 76 00              3847 	mov	@r0,#0x00
                           3848 ;     genMult
   1BBF E5 40              3849 	mov	a,_bp
   1BC1 24 02              3850 	add	a,#0x02
   1BC3 F8                 3851 	mov	r0,a
                           3852 ;     genMultOneByte
   1BC4 E6                 3853 	mov	a,@r0
   1BC5 75 F0 02           3854 	mov	b,#0x02
   1BC8 A4                 3855 	mul	ab
   1BC9 FD                 3856 	mov	r5,a
   1BCA AE F0              3857 	mov	r6,b
                           3858 ;     genMult
   1BCC E5 40              3859 	mov	a,_bp
   1BCE 24 02              3860 	add	a,#0x02
   1BD0 F8                 3861 	mov	r0,a
                           3862 ;     genMultOneByte
   1BD1 E6                 3863 	mov	a,@r0
   1BD2 75 F0 09           3864 	mov	b,#0x09
   1BD5 A4                 3865 	mul	ab
   1BD6 FF                 3866 	mov	r7,a
   1BD7                    3867 00120$:
                           3868 ;     genCmpLt
                           3869 ;       Peephole 212    reduced add sequence to inc
   1BD7 A8 40              3870 	mov     r0,_bp
   1BD9 08                 3871 	inc     r0
                           3872 ;     genCmp
   1BDA B6 09 00           3873 	cjne	@r0,#0x09,00143$
   1BDD                    3874 00143$:
                           3875 ;     genIfxJump
   1BDD 40 03              3876 	jc	00144$
   1BDF 02 1E 8A           3877 	ljmp	00126$
   1BE2                    3878 00144$:
                           3879 ;src/menu.c:1256: if (system_data.enabled[j] == CHANNEL_ENABLED || system_data.enabled[j] == CHANNEL_DISABLED)
                           3880 ;     genIpush
   1BE2 C0 07              3881 	push	ar7
                           3882 ;     genCast
   1BE4 E5 40              3883 	mov	a,_bp
   1BE6 24 02              3884 	add	a,#0x02
   1BE8 F8                 3885 	mov	r0,a
   1BE9 E5 40              3886 	mov	a,_bp
   1BEB 24 04              3887 	add	a,#0x04
   1BED F9                 3888 	mov	r1,a
   1BEE E6                 3889 	mov	a,@r0
   1BEF F7                 3890 	mov	@r1,a
   1BF0 09                 3891 	inc	r1
   1BF1 77 00              3892 	mov	@r1,#0x00
                           3893 ;     genPlus
   1BF3 E5 40              3894 	mov	a,_bp
   1BF5 24 04              3895 	add	a,#0x04
   1BF7 F8                 3896 	mov	r0,a
   1BF8 E6                 3897 	mov	a,@r0
   1BF9 24 75              3898 	add	a,#(_system_data + 0x0168)
   1BFB F5 82              3899 	mov	dpl,a
   1BFD 08                 3900 	inc	r0
   1BFE E6                 3901 	mov	a,@r0
   1BFF 34 01              3902 	addc	a,#((_system_data + 0x0168) >> 8)
   1C01 F5 83              3903 	mov	dph,a
                           3904 ;     genPointerGet
                           3905 ;     genFarPointerGet
   1C03 E0                 3906 	movx	a,@dptr
   1C04 FF                 3907 	mov	r7,a
                           3908 ;     genCmpEq
                           3909 ;       Peephole 241.c  optimized compare
   1C05 E4                 3910 	clr     a
   1C06 BF 02 01           3911 	cjne    r7,#0x02,00145$
   1C09 04                 3912 	inc     a
   1C0A                    3913 00145$:
   1C0A                    3914 00146$:
                           3915 ;     genIpop
   1C0A D0 07              3916 	pop	ar7
                           3917 ;     genIfx
                           3918 ;     genIfxJump
                           3919 ;       Peephole 109    removed ljmp by inverse jump logic
   1C0C 70 20              3920 	jnz     00117$
   1C0E                    3921 00147$:
                           3922 ;     genIpush
   1C0E C0 07              3923 	push	ar7
                           3924 ;     genPlus
   1C10 E5 40              3925 	mov	a,_bp
   1C12 24 04              3926 	add	a,#0x04
   1C14 F8                 3927 	mov	r0,a
   1C15 E6                 3928 	mov	a,@r0
   1C16 24 75              3929 	add	a,#(_system_data + 0x0168)
   1C18 F5 82              3930 	mov	dpl,a
   1C1A 08                 3931 	inc	r0
   1C1B E6                 3932 	mov	a,@r0
   1C1C 34 01              3933 	addc	a,#((_system_data + 0x0168) >> 8)
   1C1E F5 83              3934 	mov	dph,a
                           3935 ;     genPointerGet
                           3936 ;     genFarPointerGet
   1C20 E0                 3937 	movx	a,@dptr
   1C21 FF                 3938 	mov	r7,a
                           3939 ;     genCmpEq
                           3940 ;       Peephole 241.c  optimized compare
   1C22 E4                 3941 	clr     a
   1C23 BF 00 01           3942 	cjne    r7,#0x00,00148$
   1C26 04                 3943 	inc     a
   1C27                    3944 00148$:
   1C27                    3945 00149$:
                           3946 ;     genIpop
   1C27 D0 07              3947 	pop	ar7
                           3948 ;     genIfx
                           3949 ;     genIfxJump
   1C29 70 03              3950 	jnz	00150$
   1C2B 02 1E 83           3951 	ljmp	00122$
   1C2E                    3952 00150$:
   1C2E                    3953 00117$:
                           3954 ;src/menu.c:1258: offset = j*ZONES_COUNT + i;
                           3955 ;     genIpush
                           3956 ;     genPlus
                           3957 ;       Peephole 212    reduced add sequence to inc
   1C2E A8 40              3958 	mov     r0,_bp
   1C30 08                 3959 	inc     r0
   1C31 E6                 3960 	mov	a,@r0
                           3961 ;       Peephole 236.a  used r7 instead of ar7
   1C32 2F                 3962 	add     a,r7
   1C33 FA                 3963 	mov	r2,a
                           3964 ;     genAssign
   1C34 8A 03              3965 	mov	ar3,r2
                           3966 ;src/menu.c:1259: weekday = is_day_matching(offset, system_time.tm_wday);
                           3967 ;     genPointerGet
                           3968 ;     genFarPointerGet
   1C36 90 01 88           3969 	mov	dptr,#(_system_time + 0x0007)
   1C39 E0                 3970 	movx	a,@dptr
   1C3A FA                 3971 	mov	r2,a
                           3972 ;     genIpush
   1C3B C0 03              3973 	push	ar3
   1C3D C0 05              3974 	push	ar5
   1C3F C0 06              3975 	push	ar6
   1C41 C0 07              3976 	push	ar7
   1C43 C0 02              3977 	push	ar2
                           3978 ;     genCall
   1C45 8B 82              3979 	mov	dpl,r3
   1C47 12 1A B5           3980 	lcall	_is_day_matching
   1C4A AA 82              3981 	mov	r2,dpl
   1C4C 15 81              3982 	dec	sp
   1C4E D0 07              3983 	pop	ar7
   1C50 D0 06              3984 	pop	ar6
   1C52 D0 05              3985 	pop	ar5
   1C54 D0 03              3986 	pop	ar3
                           3987 ;     genAssign
                           3988 ;src/menu.c:1260: if (weekday == true)
                           3989 ;     genCmpEq
                           3990 ;       Peephole 241.c  optimized compare
   1C56 E4                 3991 	clr     a
   1C57 BA 01 01           3992 	cjne    r2,#0x01,00151$
   1C5A 04                 3993 	inc     a
   1C5B                    3994 00151$:
   1C5B                    3995 00152$:
                           3996 ;     genIpop
                           3997 ;     genIfx
                           3998 ;     genIfxJump
   1C5B 70 03              3999 	jnz	00153$
   1C5D 02 1E 83           4000 	ljmp	00122$
   1C60                    4001 00153$:
                           4002 ;src/menu.c:1262: if (system_data.zone_settings[offset].start_time > 0)
                           4003 ;     genMult
                           4004 ;     genMultOneByte
   1C60 EB                 4005 	mov	a,r3
   1C61 75 F0 0A           4006 	mov	b,#0x0A
   1C64 A4                 4007 	mul	ab
                           4008 ;     genPlus
   1C65 C0 E0              4009 	push	acc
   1C67 E5 40              4010 	mov	a,_bp
   1C69 24 06              4011 	add	a,#0x06
   1C6B F8                 4012 	mov	r0,a
   1C6C D0 E0              4013 	pop	acc
   1C6E 24 0D              4014 	add	a,#_system_data
   1C70 F6                 4015 	mov	@r0,a
   1C71 E5 F0              4016 	mov	a,b
   1C73 34 00              4017 	addc	a,#(_system_data >> 8)
   1C75 08                 4018 	inc	r0
   1C76 F6                 4019 	mov	@r0,a
                           4020 ;     genPlus
   1C77 E5 40              4021 	mov	a,_bp
   1C79 24 06              4022 	add	a,#0x06
   1C7B F8                 4023 	mov	r0,a
                           4024 ;     genPlusIncr
   1C7C 74 02              4025 	mov	a,#0x02
   1C7E 26                 4026 	add	a,@r0
   1C7F F5 82              4027 	mov	dpl,a
                           4028 ;       Peephole 181    changed mov to clr
   1C81 E4                 4029 	clr     a
   1C82 08                 4030 	inc	r0
   1C83 36                 4031 	addc	a,@r0
   1C84 F5 83              4032 	mov	dph,a
                           4033 ;     genPointerGet
                           4034 ;     genFarPointerGet
   1C86 E5 40              4035 	mov	a,_bp
   1C88 24 08              4036 	add	a,#0x08
   1C8A F8                 4037 	mov	r0,a
   1C8B E0                 4038 	movx	a,@dptr
   1C8C F6                 4039 	mov	@r0,a
   1C8D A3                 4040 	inc	dptr
   1C8E E0                 4041 	movx	a,@dptr
   1C8F 08                 4042 	inc	r0
   1C90 F6                 4043 	mov	@r0,a
   1C91 A3                 4044 	inc	dptr
   1C92 E0                 4045 	movx	a,@dptr
   1C93 08                 4046 	inc	r0
   1C94 F6                 4047 	mov	@r0,a
   1C95 A3                 4048 	inc	dptr
   1C96 E0                 4049 	movx	a,@dptr
   1C97 08                 4050 	inc	r0
   1C98 F6                 4051 	mov	@r0,a
                           4052 ;     genIfx
   1C99 E5 40              4053 	mov	a,_bp
   1C9B 24 08              4054 	add	a,#0x08
   1C9D F8                 4055 	mov	r0,a
   1C9E E6                 4056 	mov	a,@r0
   1C9F 08                 4057 	inc	r0
   1CA0 46                 4058 	orl	a,@r0
   1CA1 08                 4059 	inc	r0
   1CA2 46                 4060 	orl	a,@r0
   1CA3 08                 4061 	inc	r0
   1CA4 46                 4062 	orl	a,@r0
                           4063 ;     genIfxJump
   1CA5 70 03              4064 	jnz	00154$
   1CA7 02 1E 56           4065 	ljmp	00113$
   1CAA                    4066 00154$:
                           4067 ;src/menu.c:1264: if (temp_long >= system_data.zone_settings[offset].start_time)
                           4068 ;     genCmpLt
   1CAA E5 40              4069 	mov	a,_bp
   1CAC 24 08              4070 	add	a,#0x08
   1CAE F8                 4071 	mov	r0,a
                           4072 ;     genCmp
   1CAF C3                 4073 	clr	c
   1CB0 E5 35              4074 	mov	a,_temp_long
   1CB2 96                 4075 	subb	a,@r0
   1CB3 E5 36              4076 	mov	a,(_temp_long + 1)
   1CB5 08                 4077 	inc	r0
   1CB6 96                 4078 	subb	a,@r0
   1CB7 E5 37              4079 	mov	a,(_temp_long + 2)
   1CB9 08                 4080 	inc	r0
   1CBA 96                 4081 	subb	a,@r0
   1CBB E5 38              4082 	mov	a,(_temp_long + 3)
   1CBD 08                 4083 	inc	r0
   1CBE 96                 4084 	subb	a,@r0
                           4085 ;     genIfxJump
   1CBF 50 03              4086 	jnc	00155$
   1CC1 02 1E 27           4087 	ljmp	00110$
   1CC4                    4088 00155$:
                           4089 ;src/menu.c:1266: if(temp_long < system_data.zone_settings[offset].stop_time)
                           4090 ;     genIpush
   1CC4 C0 07              4091 	push	ar7
                           4092 ;     genPlus
   1CC6 E5 40              4093 	mov	a,_bp
   1CC8 24 06              4094 	add	a,#0x06
   1CCA F8                 4095 	mov	r0,a
   1CCB 74 06              4096 	mov	a,#0x06
   1CCD 26                 4097 	add	a,@r0
   1CCE F5 82              4098 	mov	dpl,a
                           4099 ;       Peephole 181    changed mov to clr
   1CD0 E4                 4100 	clr     a
   1CD1 08                 4101 	inc	r0
   1CD2 36                 4102 	addc	a,@r0
   1CD3 F5 83              4103 	mov	dph,a
                           4104 ;     genPointerGet
                           4105 ;     genFarPointerGet
   1CD5 E0                 4106 	movx	a,@dptr
   1CD6 FF                 4107 	mov	r7,a
   1CD7 A3                 4108 	inc	dptr
   1CD8 E0                 4109 	movx	a,@dptr
   1CD9 FA                 4110 	mov	r2,a
   1CDA A3                 4111 	inc	dptr
   1CDB E0                 4112 	movx	a,@dptr
   1CDC FC                 4113 	mov	r4,a
   1CDD A3                 4114 	inc	dptr
   1CDE E0                 4115 	movx	a,@dptr
   1CDF FB                 4116 	mov	r3,a
                           4117 ;     genCmpLt
                           4118 ;     genCmp
   1CE0 C3                 4119 	clr	c
   1CE1 E5 35              4120 	mov	a,_temp_long
   1CE3 9F                 4121 	subb	a,r7
   1CE4 E5 36              4122 	mov	a,(_temp_long + 1)
   1CE6 9A                 4123 	subb	a,r2
   1CE7 E5 37              4124 	mov	a,(_temp_long + 2)
   1CE9 9C                 4125 	subb	a,r4
   1CEA E5 38              4126 	mov	a,(_temp_long + 3)
   1CEC 9B                 4127 	subb	a,r3
   1CED E4                 4128 	clr	a
   1CEE 33                 4129 	rlc	a
                           4130 ;     genIpop
   1CEF D0 07              4131 	pop	ar7
                           4132 ;     genIfx
                           4133 ;     genIfxJump
   1CF1 70 03              4134 	jnz	00156$
   1CF3 02 1D F8           4135 	ljmp	00107$
   1CF6                    4136 00156$:
                           4137 ;src/menu.c:1268: if (system_data.temperatures[j] < system_data.zone_settings[offset].temperature*10 - histereza)
                           4138 ;     genIpush
   1CF6 C0 07              4139 	push	ar7
                           4140 ;     genPlus
                           4141 ;       Peephole 236.g  used r5 instead of ar5
   1CF8 ED                 4142 	mov     a,r5
   1CF9 24 79              4143 	add	a,#(_system_data + 0x016c)
   1CFB FA                 4144 	mov	r2,a
                           4145 ;       Peephole 236.g  used r6 instead of ar6
   1CFC EE                 4146 	mov     a,r6
   1CFD 34 01              4147 	addc	a,#((_system_data + 0x016c) >> 8)
   1CFF FB                 4148 	mov	r3,a
                           4149 ;     genPointerGet
                           4150 ;     genFarPointerGet
   1D00 E5 40              4151 	mov	a,_bp
   1D02 24 06              4152 	add	a,#0x06
   1D04 F8                 4153 	mov	r0,a
   1D05 86 82              4154 	mov	dpl,@r0
   1D07 08                 4155 	inc	r0
   1D08 86 83              4156 	mov	dph,@r0
   1D0A E0                 4157 	movx	a,@dptr
   1D0B FC                 4158 	mov	r4,a
   1D0C A3                 4159 	inc	dptr
   1D0D E0                 4160 	movx	a,@dptr
   1D0E FF                 4161 	mov	r7,a
                           4162 ;     genAssign
   1D0F E4                 4163 	clr	a
   1D10 F5 43              4164 	mov	(__mulint_PARM_2 + 1),a
   1D12 75 42 0A           4165 	mov	__mulint_PARM_2,#0x0A
                           4166 ;     genCall
   1D15 8C 82              4167 	mov	dpl,r4
   1D17 8F 83              4168 	mov	dph,r7
   1D19 C0 02              4169 	push	ar2
   1D1B C0 03              4170 	push	ar3
   1D1D C0 05              4171 	push	ar5
   1D1F C0 06              4172 	push	ar6
   1D21 C0 07              4173 	push	ar7
   1D23 12 70 A2           4174 	lcall	__mulint
   1D26 C0 E0              4175 	push	acc
   1D28 E5 40              4176 	mov	a,_bp
   1D2A 24 08              4177 	add	a,#0x08
   1D2C F8                 4178 	mov	r0,a
   1D2D D0 E0              4179 	pop	acc
   1D2F A6 82              4180 	mov	@r0,dpl
   1D31 08                 4181 	inc	r0
   1D32 A6 83              4182 	mov	@r0,dph
   1D34 D0 07              4183 	pop	ar7
   1D36 D0 06              4184 	pop	ar6
   1D38 D0 05              4185 	pop	ar5
   1D3A D0 03              4186 	pop	ar3
   1D3C D0 02              4187 	pop	ar2
                           4188 ;     genCast
   1D3E E5 40              4189 	mov	a,_bp
   1D40 24 03              4190 	add	a,#0x03
   1D42 F8                 4191 	mov	r0,a
   1D43 86 04              4192 	mov	ar4,@r0
   1D45 7F 00              4193 	mov	r7,#0x00
                           4194 ;     genMinus
   1D47 E5 40              4195 	mov	a,_bp
   1D49 24 08              4196 	add	a,#0x08
   1D4B F8                 4197 	mov	r0,a
   1D4C E6                 4198 	mov	a,@r0
   1D4D C3                 4199 	clr	c
                           4200 ;       Peephole 236.l  used r4 instead of ar4
   1D4E 9C                 4201 	subb    a,r4
   1D4F FC                 4202 	mov	r4,a
   1D50 08                 4203 	inc	r0
   1D51 E6                 4204 	mov	a,@r0
                           4205 ;       Peephole 236.l  used r7 instead of ar7
   1D52 9F                 4206 	subb    a,r7
   1D53 FF                 4207 	mov	r7,a
                           4208 ;     genPointerGet
                           4209 ;     genFarPointerGet
   1D54 8A 82              4210 	mov	dpl,r2
   1D56 8B 83              4211 	mov	dph,r3
   1D58 E0                 4212 	movx	a,@dptr
   1D59 FA                 4213 	mov	r2,a
   1D5A A3                 4214 	inc	dptr
   1D5B E0                 4215 	movx	a,@dptr
   1D5C FB                 4216 	mov	r3,a
                           4217 ;     genCmpLt
                           4218 ;     genCmp
   1D5D C3                 4219 	clr	c
   1D5E EA                 4220 	mov	a,r2
   1D5F 9C                 4221 	subb	a,r4
   1D60 EB                 4222 	mov	a,r3
   1D61 9F                 4223 	subb	a,r7
   1D62 E4                 4224 	clr	a
   1D63 33                 4225 	rlc	a
                           4226 ;     genIpop
   1D64 D0 07              4227 	pop	ar7
                           4228 ;     genIfx
                           4229 ;     genIfxJump
                           4230 ;       Peephole 110    removed ljmp by inverse jump logic
   1D66 60 38              4231 	jz      00104$
   1D68                    4232 00157$:
                           4233 ;src/menu.c:1270: system_data.enabled[j] = CHANNEL_ENABLED;
                           4234 ;     genPlus
   1D68 E5 40              4235 	mov	a,_bp
   1D6A 24 04              4236 	add	a,#0x04
   1D6C F8                 4237 	mov	r0,a
   1D6D E6                 4238 	mov	a,@r0
   1D6E 24 75              4239 	add	a,#(_system_data + 0x0168)
   1D70 F5 82              4240 	mov	dpl,a
   1D72 08                 4241 	inc	r0
   1D73 E6                 4242 	mov	a,@r0
   1D74 34 01              4243 	addc	a,#((_system_data + 0x0168) >> 8)
   1D76 F5 83              4244 	mov	dph,a
                           4245 ;     genPointerSet
                           4246 ;     genFarPointerSet
   1D78 74 02              4247 	mov	a,#0x02
   1D7A F0                 4248 	movx	@dptr,a
                           4249 ;src/menu.c:1271: switch_zone_prepare(j, 1);
                           4250 ;     genIpush
   1D7B C0 05              4251 	push	ar5
   1D7D C0 06              4252 	push	ar6
   1D7F C0 07              4253 	push	ar7
   1D81 74 01              4254 	mov	a,#0x01
   1D83 C0 E0              4255 	push	acc
                           4256 ;     genCall
   1D85 E5 40              4257 	mov	a,_bp
   1D87 24 02              4258 	add	a,#0x02
   1D89 F8                 4259 	mov	r0,a
   1D8A 86 82              4260 	mov	dpl,@r0
   1D8C 12 18 F3           4261 	lcall	_switch_zone_prepare
   1D8F 15 81              4262 	dec	sp
   1D91 D0 07              4263 	pop	ar7
   1D93 D0 06              4264 	pop	ar6
   1D95 D0 05              4265 	pop	ar5
                           4266 ;src/menu.c:1272: histereza = 0;
                           4267 ;     genAssign
   1D97 E5 40              4268 	mov	a,_bp
   1D99 24 03              4269 	add	a,#0x03
   1D9B F8                 4270 	mov	r0,a
   1D9C 76 00              4271 	mov	@r0,#0x00
                           4272 ;       Peephole 112.b  changed ljmp to sjmp
   1D9E 80 50              4273 	sjmp    00105$
   1DA0                    4274 00104$:
                           4275 ;src/menu.c:1274: else if (system_data.temperatures[j] >= system_data.zone_settings[offset].temperature*10)
                           4276 ;     genPlus
                           4277 ;       Peephole 236.g  used r5 instead of ar5
   1DA0 ED                 4278 	mov     a,r5
   1DA1 24 79              4279 	add	a,#(_system_data + 0x016c)
   1DA3 F5 82              4280 	mov	dpl,a
                           4281 ;       Peephole 236.g  used r6 instead of ar6
   1DA5 EE                 4282 	mov     a,r6
   1DA6 34 01              4283 	addc	a,#((_system_data + 0x016c) >> 8)
   1DA8 F5 83              4284 	mov	dph,a
                           4285 ;     genPointerGet
                           4286 ;     genFarPointerGet
   1DAA E0                 4287 	movx	a,@dptr
   1DAB FA                 4288 	mov	r2,a
   1DAC A3                 4289 	inc	dptr
   1DAD E0                 4290 	movx	a,@dptr
   1DAE FB                 4291 	mov	r3,a
                           4292 ;     genCmpLt
   1DAF E5 40              4293 	mov	a,_bp
   1DB1 24 08              4294 	add	a,#0x08
   1DB3 F8                 4295 	mov	r0,a
                           4296 ;     genCmp
   1DB4 C3                 4297 	clr	c
   1DB5 EA                 4298 	mov	a,r2
   1DB6 96                 4299 	subb	a,@r0
   1DB7 EB                 4300 	mov	a,r3
   1DB8 08                 4301 	inc	r0
   1DB9 96                 4302 	subb	a,@r0
                           4303 ;     genIfxJump
                           4304 ;       Peephole 112.b  changed ljmp to sjmp
                           4305 ;       Peephole 160    removed sjmp by inverse jump logic
   1DBA 40 34              4306 	jc      00105$
   1DBC                    4307 00158$:
                           4308 ;src/menu.c:1276: system_data.enabled[j] = CHANNEL_DISABLED;
                           4309 ;     genPlus
   1DBC E5 40              4310 	mov	a,_bp
   1DBE 24 04              4311 	add	a,#0x04
   1DC0 F8                 4312 	mov	r0,a
   1DC1 E6                 4313 	mov	a,@r0
   1DC2 24 75              4314 	add	a,#(_system_data + 0x0168)
   1DC4 F5 82              4315 	mov	dpl,a
   1DC6 08                 4316 	inc	r0
   1DC7 E6                 4317 	mov	a,@r0
   1DC8 34 01              4318 	addc	a,#((_system_data + 0x0168) >> 8)
   1DCA F5 83              4319 	mov	dph,a
                           4320 ;     genPointerSet
                           4321 ;     genFarPointerSet
                           4322 ;       Peephole 181    changed mov to clr
   1DCC E4                 4323 	clr     a
   1DCD F0                 4324 	movx	@dptr,a
                           4325 ;src/menu.c:1277: switch_zone_prepare(j, 0);
                           4326 ;     genIpush
   1DCE C0 05              4327 	push	ar5
   1DD0 C0 06              4328 	push	ar6
   1DD2 C0 07              4329 	push	ar7
                           4330 ;       Peephole 181    changed mov to clr
   1DD4 E4                 4331 	clr     a
   1DD5 C0 E0              4332 	push	acc
                           4333 ;     genCall
   1DD7 E5 40              4334 	mov	a,_bp
   1DD9 24 02              4335 	add	a,#0x02
   1DDB F8                 4336 	mov	r0,a
   1DDC 86 82              4337 	mov	dpl,@r0
   1DDE 12 18 F3           4338 	lcall	_switch_zone_prepare
   1DE1 15 81              4339 	dec	sp
   1DE3 D0 07              4340 	pop	ar7
   1DE5 D0 06              4341 	pop	ar6
   1DE7 D0 05              4342 	pop	ar5
                           4343 ;src/menu.c:1278: histereza = 1;
                           4344 ;     genAssign
   1DE9 E5 40              4345 	mov	a,_bp
   1DEB 24 03              4346 	add	a,#0x03
   1DED F8                 4347 	mov	r0,a
   1DEE 76 01              4348 	mov	@r0,#0x01
   1DF0                    4349 00105$:
                           4350 ;src/menu.c:1281: i=ZONES_COUNT;
                           4351 ;     genAssign
                           4352 ;       Peephole 212    reduced add sequence to inc
   1DF0 A8 40              4353 	mov     r0,_bp
   1DF2 08                 4354 	inc     r0
   1DF3 76 09              4355 	mov	@r0,#0x09
   1DF5 02 1E 83           4356 	ljmp	00122$
   1DF8                    4357 00107$:
                           4358 ;src/menu.c:1285: system_data.enabled[j] = CHANNEL_DISABLED;
                           4359 ;     genPlus
   1DF8 E5 40              4360 	mov	a,_bp
   1DFA 24 04              4361 	add	a,#0x04
   1DFC F8                 4362 	mov	r0,a
   1DFD E6                 4363 	mov	a,@r0
   1DFE 24 75              4364 	add	a,#(_system_data + 0x0168)
   1E00 F5 82              4365 	mov	dpl,a
   1E02 08                 4366 	inc	r0
   1E03 E6                 4367 	mov	a,@r0
   1E04 34 01              4368 	addc	a,#((_system_data + 0x0168) >> 8)
   1E06 F5 83              4369 	mov	dph,a
                           4370 ;     genPointerSet
                           4371 ;     genFarPointerSet
                           4372 ;       Peephole 181    changed mov to clr
   1E08 E4                 4373 	clr     a
   1E09 F0                 4374 	movx	@dptr,a
                           4375 ;src/menu.c:1286: switch_zone_prepare(j, 0);
                           4376 ;     genIpush
   1E0A C0 05              4377 	push	ar5
   1E0C C0 06              4378 	push	ar6
   1E0E C0 07              4379 	push	ar7
                           4380 ;       Peephole 181    changed mov to clr
   1E10 E4                 4381 	clr     a
   1E11 C0 E0              4382 	push	acc
                           4383 ;     genCall
   1E13 E5 40              4384 	mov	a,_bp
   1E15 24 02              4385 	add	a,#0x02
   1E17 F8                 4386 	mov	r0,a
   1E18 86 82              4387 	mov	dpl,@r0
   1E1A 12 18 F3           4388 	lcall	_switch_zone_prepare
   1E1D 15 81              4389 	dec	sp
   1E1F D0 07              4390 	pop	ar7
   1E21 D0 06              4391 	pop	ar6
   1E23 D0 05              4392 	pop	ar5
                           4393 ;       Peephole 112.b  changed ljmp to sjmp
   1E25 80 5C              4394 	sjmp    00122$
   1E27                    4395 00110$:
                           4396 ;src/menu.c:1291: system_data.enabled[j] = CHANNEL_DISABLED;
                           4397 ;     genPlus
   1E27 E5 40              4398 	mov	a,_bp
   1E29 24 04              4399 	add	a,#0x04
   1E2B F8                 4400 	mov	r0,a
   1E2C E6                 4401 	mov	a,@r0
   1E2D 24 75              4402 	add	a,#(_system_data + 0x0168)
   1E2F F5 82              4403 	mov	dpl,a
   1E31 08                 4404 	inc	r0
   1E32 E6                 4405 	mov	a,@r0
   1E33 34 01              4406 	addc	a,#((_system_data + 0x0168) >> 8)
   1E35 F5 83              4407 	mov	dph,a
                           4408 ;     genPointerSet
                           4409 ;     genFarPointerSet
                           4410 ;       Peephole 181    changed mov to clr
   1E37 E4                 4411 	clr     a
   1E38 F0                 4412 	movx	@dptr,a
                           4413 ;src/menu.c:1292: switch_zone_prepare(j, 0);
                           4414 ;     genIpush
   1E39 C0 05              4415 	push	ar5
   1E3B C0 06              4416 	push	ar6
   1E3D C0 07              4417 	push	ar7
                           4418 ;       Peephole 181    changed mov to clr
   1E3F E4                 4419 	clr     a
   1E40 C0 E0              4420 	push	acc
                           4421 ;     genCall
   1E42 E5 40              4422 	mov	a,_bp
   1E44 24 02              4423 	add	a,#0x02
   1E46 F8                 4424 	mov	r0,a
   1E47 86 82              4425 	mov	dpl,@r0
   1E49 12 18 F3           4426 	lcall	_switch_zone_prepare
   1E4C 15 81              4427 	dec	sp
   1E4E D0 07              4428 	pop	ar7
   1E50 D0 06              4429 	pop	ar6
   1E52 D0 05              4430 	pop	ar5
                           4431 ;       Peephole 112.b  changed ljmp to sjmp
   1E54 80 2D              4432 	sjmp    00122$
   1E56                    4433 00113$:
                           4434 ;src/menu.c:1297: system_data.enabled[j] = CHANNEL_DISABLED;
                           4435 ;     genPlus
   1E56 E5 40              4436 	mov	a,_bp
   1E58 24 04              4437 	add	a,#0x04
   1E5A F8                 4438 	mov	r0,a
   1E5B E6                 4439 	mov	a,@r0
   1E5C 24 75              4440 	add	a,#(_system_data + 0x0168)
   1E5E F5 82              4441 	mov	dpl,a
   1E60 08                 4442 	inc	r0
   1E61 E6                 4443 	mov	a,@r0
   1E62 34 01              4444 	addc	a,#((_system_data + 0x0168) >> 8)
   1E64 F5 83              4445 	mov	dph,a
                           4446 ;     genPointerSet
                           4447 ;     genFarPointerSet
                           4448 ;       Peephole 181    changed mov to clr
   1E66 E4                 4449 	clr     a
   1E67 F0                 4450 	movx	@dptr,a
                           4451 ;src/menu.c:1298: switch_zone_prepare(j, 0);
                           4452 ;     genIpush
   1E68 C0 05              4453 	push	ar5
   1E6A C0 06              4454 	push	ar6
   1E6C C0 07              4455 	push	ar7
                           4456 ;       Peephole 181    changed mov to clr
   1E6E E4                 4457 	clr     a
   1E6F C0 E0              4458 	push	acc
                           4459 ;     genCall
   1E71 E5 40              4460 	mov	a,_bp
   1E73 24 02              4461 	add	a,#0x02
   1E75 F8                 4462 	mov	r0,a
   1E76 86 82              4463 	mov	dpl,@r0
   1E78 12 18 F3           4464 	lcall	_switch_zone_prepare
   1E7B 15 81              4465 	dec	sp
   1E7D D0 07              4466 	pop	ar7
   1E7F D0 06              4467 	pop	ar6
   1E81 D0 05              4468 	pop	ar5
   1E83                    4469 00122$:
                           4470 ;src/menu.c:1254: for (i = 0; i<ZONES_COUNT; i++)
                           4471 ;     genPlus
                           4472 ;       Peephole 212    reduced add sequence to inc
   1E83 A8 40              4473 	mov     r0,_bp
   1E85 08                 4474 	inc     r0
                           4475 ;     genPlusIncr
   1E86 06                 4476 	inc	@r0
   1E87 02 1B D7           4477 	ljmp	00120$
   1E8A                    4478 00126$:
                           4479 ;src/menu.c:1252: for (j = 0; j<CHANNELS_COUNT; j++)
                           4480 ;     genPlus
   1E8A E5 40              4481 	mov	a,_bp
   1E8C 24 02              4482 	add	a,#0x02
   1E8E F8                 4483 	mov	r0,a
                           4484 ;     genPlusIncr
   1E8F 06                 4485 	inc	@r0
   1E90 02 1B AD           4486 	ljmp	00124$
   1E93                    4487 00127$:
                           4488 ;src/menu.c:1304: switch_zone(0);
                           4489 ;     genCall
   1E93 75 82 00           4490 	mov	dpl,#0x00
   1E96 12 18 A4           4491 	lcall	_switch_zone
                           4492 ;src/menu.c:1305: switch_zone(1);
                           4493 ;     genCall
   1E99 75 82 01           4494 	mov	dpl,#0x01
   1E9C 12 18 A4           4495 	lcall	_switch_zone
                           4496 ;src/menu.c:1306: switch_zone(2);
                           4497 ;     genCall
   1E9F 75 82 02           4498 	mov	dpl,#0x02
   1EA2 12 18 A4           4499 	lcall	_switch_zone
                           4500 ;src/menu.c:1307: switch_zone(3);
                           4501 ;     genCall
   1EA5 75 82 03           4502 	mov	dpl,#0x03
   1EA8 12 18 A4           4503 	lcall	_switch_zone
   1EAB                    4504 00128$:
   1EAB 85 40 81           4505 	mov	sp,_bp
   1EAE D0 40              4506 	pop	_bp
   1EB0 22                 4507 	ret
                           4508 ;------------------------------------------------------------
                           4509 ;Allocation info for local variables in function 'check_external_events'
                           4510 ;------------------------------------------------------------
                           4511 ;retval                    Allocated to registers 
                           4512 ;------------------------------------------------------------
                           4513 ;src/menu.c:1346: unsigned char check_external_events(void)
                           4514 ;	-----------------------------------------
                           4515 ;	 function check_external_events
                           4516 ;	-----------------------------------------
   1EB1                    4517 _check_external_events:
   1EB1 C0 40              4518 	push	_bp
   1EB3 85 81 40           4519 	mov	_bp,sp
                           4520 ;src/menu.c:1351: if (current_display_state == SYSTEM_SETUP_POS)
                           4521 ;     genCmpEq
   1EB6 E5 31              4522 	mov	a,_current_display_state
                           4523 ;       Peephole 112.b  changed ljmp to sjmp
                           4524 ;       Peephole 199    optimized misc jump sequence
   1EB8 B4 05 10           4525 	cjne    a,#0x05,00102$
                           4526 ;00116$:
                           4527 ;       Peephole 200    removed redundant sjmp
   1EBB                    4528 00117$:
                           4529 ;src/menu.c:1353: display_stored_time(0,ASCTIME_FORMAT,false);
                           4530 ;     genIpush
                           4531 ;       Peephole 181    changed mov to clr
   1EBB E4                 4532 	clr     a
   1EBC C0 E0              4533 	push	acc
                           4534 ;     genIpush
                           4535 ;       Peephole 181    changed mov to clr
   1EBE E4                 4536 	clr     a
   1EBF C0 E0              4537 	push	acc
                           4538 ;     genCall
   1EC1 75 82 00           4539 	mov	dpl,#0x00
   1EC4 12 12 CE           4540 	lcall	_display_stored_time
   1EC7 15 81              4541 	dec	sp
   1EC9 15 81              4542 	dec	sp
   1ECB                    4543 00102$:
                           4544 ;src/menu.c:1356: if (current_display_state == MAIN_STATE_POS)
                           4545 ;     genCmpEq
   1ECB E5 31              4546 	mov	a,_current_display_state
                           4547 ;       Peephole 162    removed sjmp by inverse jump logic
   1ECD 60 02              4548 	jz      00119$
   1ECF                    4549 00118$:
                           4550 ;       Peephole 112.b  changed ljmp to sjmp
   1ECF 80 25              4551 	sjmp    00104$
   1ED1                    4552 00119$:
                           4553 ;src/menu.c:1358: display_stored_data((unsigned int*)system_data.temperatures,false);
                           4554 ;     genIpush
                           4555 ;       Peephole 181    changed mov to clr
   1ED1 E4                 4556 	clr     a
   1ED2 C0 E0              4557 	push	acc
                           4558 ;     genCall
                           4559 ;       Peephole 182.a  used 16 bit load of DPTR
   1ED4 90 01 79           4560 	mov     dptr,#(_system_data + 0x016c)
   1ED7 75 F0 01           4561 	mov	b,#0x01
   1EDA 12 16 3D           4562 	lcall	_display_stored_data
   1EDD 15 81              4563 	dec	sp
                           4564 ;src/menu.c:1359: display_enabled_channels(false);
                           4565 ;     genCall
   1EDF 75 82 00           4566 	mov	dpl,#0x00
   1EE2 12 19 46           4567 	lcall	_display_enabled_channels
                           4568 ;src/menu.c:1360: display_stored_time(4,ASCTIME_SHORT_FORMAT,false);
                           4569 ;     genIpush
                           4570 ;       Peephole 181    changed mov to clr
   1EE5 E4                 4571 	clr     a
   1EE6 C0 E0              4572 	push	acc
                           4573 ;     genIpush
   1EE8 74 03              4574 	mov	a,#0x03
   1EEA C0 E0              4575 	push	acc
                           4576 ;     genCall
   1EEC 75 82 04           4577 	mov	dpl,#0x04
   1EEF 12 12 CE           4578 	lcall	_display_stored_time
   1EF2 15 81              4579 	dec	sp
   1EF4 15 81              4580 	dec	sp
   1EF6                    4581 00104$:
                           4582 ;src/menu.c:1365: if (current_display_state != DAY_SETUP_POS &&
                           4583 ;     genCmpEq
   1EF6 E5 31              4584 	mov	a,_current_display_state
   1EF8 B4 39 02           4585 	cjne	a,#0x39,00120$
                           4586 ;       Peephole 112.b  changed ljmp to sjmp
   1EFB 80 11              4587 	sjmp    00106$
   1EFD                    4588 00120$:
                           4589 ;src/menu.c:1366: current_display_state != TIME_SETUP_POS &&
                           4590 ;     genCmpEq
   1EFD E5 31              4591 	mov	a,_current_display_state
   1EFF B4 37 02           4592 	cjne	a,#0x37,00121$
                           4593 ;       Peephole 112.b  changed ljmp to sjmp
   1F02 80 0A              4594 	sjmp    00106$
   1F04                    4595 00121$:
                           4596 ;src/menu.c:1367: current_display_state != DATE_SETUP_POS )
                           4597 ;     genCmpEq
   1F04 E5 31              4598 	mov	a,_current_display_state
   1F06 B4 36 02           4599 	cjne	a,#0x36,00122$
                           4600 ;       Peephole 112.b  changed ljmp to sjmp
   1F09 80 03              4601 	sjmp    00106$
   1F0B                    4602 00122$:
                           4603 ;src/menu.c:1369: control_workloop();
                           4604 ;     genCall
   1F0B 12 1B 12           4605 	lcall	_control_workloop
   1F0E                    4606 00106$:
                           4607 ;src/menu.c:1372: return retval;
                           4608 ;     genRet
   1F0E 75 82 00           4609 	mov	dpl,#0x00
   1F11                    4610 00109$:
   1F11 85 40 81           4611 	mov	sp,_bp
   1F14 D0 40              4612 	pop	_bp
   1F16 22                 4613 	ret
                           4614 ;------------------------------------------------------------
                           4615 ;Allocation info for local variables in function 'menu_previous_position'
                           4616 ;------------------------------------------------------------
                           4617 ;------------------------------------------------------------
                           4618 ;src/menu.c:1375: void menu_previous_position()
                           4619 ;	-----------------------------------------
                           4620 ;	 function menu_previous_position
                           4621 ;	-----------------------------------------
   1F17                    4622 _menu_previous_position:
   1F17 C0 40              4623 	push	_bp
   1F19 85 81 40           4624 	mov	_bp,sp
                           4625 ;src/menu.c:1377: current_display_state = menu[current_display_state].item[current_position].previous;
                           4626 ;     genMult
                           4627 ;     genMultOneByte
   1F1C E5 31              4628 	mov	a,_current_display_state
   1F1E 75 F0 3C           4629 	mov	b,#0x3C
   1F21 A4                 4630 	mul	ab
                           4631 ;     genPlus
   1F22 24 0E              4632 	add	a,#_menu
   1F24 FA                 4633 	mov	r2,a
   1F25 E5 F0              4634 	mov	a,b
   1F27 34 3C              4635 	addc	a,#(_menu >> 8)
   1F29 FB                 4636 	mov	r3,a
                           4637 ;     genPlus
                           4638 ;     genPlusIncr
   1F2A 74 04              4639 	mov	a,#0x04
                           4640 ;       Peephole 236.a  used r2 instead of ar2
   1F2C 2A                 4641 	add     a,r2
   1F2D FA                 4642 	mov	r2,a
                           4643 ;       Peephole 181    changed mov to clr
   1F2E E4                 4644 	clr     a
                           4645 ;       Peephole 236.b  used r3 instead of ar3
   1F2F 3B                 4646 	addc    a,r3
   1F30 FB                 4647 	mov	r3,a
                           4648 ;     genMult
                           4649 ;     genMultOneByte
   1F31 E5 32              4650 	mov	a,_current_position
   1F33 75 F0 08           4651 	mov	b,#0x08
   1F36 A4                 4652 	mul	ab
                           4653 ;     genPlus
                           4654 ;       Peephole 236.a  used r2 instead of ar2
   1F37 2A                 4655 	add     a,r2
   1F38 F5 82              4656 	mov	dpl,a
   1F3A E5 F0              4657 	mov	a,b
                           4658 ;       Peephole 236.b  used r3 instead of ar3
   1F3C 3B                 4659 	addc    a,r3
   1F3D F5 83              4660 	mov	dph,a
                           4661 ;     genPointerGet
                           4662 ;     genCodePointerGet
                           4663 ;       Peephole 181    changed mov to clr
   1F3F E4                 4664 	clr     a
   1F40 93                 4665 	movc	a,@a+dptr
   1F41 F5 31              4666 	mov	_current_display_state,a
                           4667 ;src/menu.c:1378: current_position = stack_pop_front();
                           4668 ;     genCall
   1F43 12 0C E8           4669 	lcall	_stack_pop_front
   1F46 85 82 32           4670 	mov	_current_position,dpl
   1F49                    4671 00101$:
   1F49 85 40 81           4672 	mov	sp,_bp
   1F4C D0 40              4673 	pop	_bp
   1F4E 22                 4674 	ret
                           4675 ;------------------------------------------------------------
                           4676 ;Allocation info for local variables in function 'reset_workloop'
                           4677 ;------------------------------------------------------------
                           4678 ;value                     Allocated to registers r2 r3 r4 r5 
                           4679 ;exit                      Allocated to registers r6 
                           4680 ;result                    Allocated to registers r4 r5 
                           4681 ;------------------------------------------------------------
                           4682 ;src/menu.c:1392: unsigned long reset_workloop(const unsigned long value)
                           4683 ;	-----------------------------------------
                           4684 ;	 function reset_workloop
                           4685 ;	-----------------------------------------
   1F4F                    4686 _reset_workloop:
   1F4F C0 40              4687 	push	_bp
   1F51 85 81 40           4688 	mov	_bp,sp
                           4689 ;     genReceive
   1F54 AA 82              4690 	mov	r2,dpl
   1F56 AB 83              4691 	mov	r3,dph
   1F58 AC F0              4692 	mov	r4,b
   1F5A FD                 4693 	mov	r5,a
                           4694 ;src/menu.c:1394: unsigned char exit = 0;
                           4695 ;     genAssign
   1F5B 7E 00              4696 	mov	r6,#0x00
                           4697 ;src/menu.c:1397: BLINKING_OFF;
                           4698 ;     genAssign
   1F5D 75 30 00           4699 	mov	_blinking,#0x00
                           4700 ;src/menu.c:1398: result = value;
                           4701 ;     genCast
                           4702 ;     genAssign
   1F60 8A 04              4703 	mov	ar4,r2
   1F62 8B 05              4704 	mov	ar5,r3
                           4705 ;src/menu.c:1400: while(exit == 0)
                           4706 ;     genAssign
   1F64                    4707 00107$:
                           4708 ;     genCmpEq
   1F64 BE 00 02           4709 	cjne	r6,#0x00,00117$
   1F67 80 03              4710 	sjmp	00118$
   1F69                    4711 00117$:
   1F69 02 1F E7           4712 	ljmp	00109$
   1F6C                    4713 00118$:
                           4714 ;src/menu.c:1405: SERVICE_WATCHDOG;
                           4715 ;     genAssign
   1F6C 75 A6 1E           4716 	mov	_WDTRST,#0x1E
                           4717 ;     genAssign
   1F6F 75 A6 E1           4718 	mov	_WDTRST,#0xE1
                           4719 ;src/menu.c:1406: exit = check_external_events();
                           4720 ;     genCall
   1F72 C0 02              4721 	push	ar2
   1F74 C0 03              4722 	push	ar3
   1F76 C0 04              4723 	push	ar4
   1F78 C0 05              4724 	push	ar5
   1F7A 12 1E B1           4725 	lcall	_check_external_events
   1F7D AF 82              4726 	mov	r7,dpl
   1F7F D0 05              4727 	pop	ar5
   1F81 D0 04              4728 	pop	ar4
   1F83 D0 03              4729 	pop	ar3
   1F85 D0 02              4730 	pop	ar2
                           4731 ;     genAssign
   1F87 8F 06              4732 	mov	ar6,r7
                           4733 ;src/menu.c:1407: if (exit == 0)
                           4734 ;     genCmpEq
                           4735 ;       Peephole 112.b  changed ljmp to sjmp
                           4736 ;       Peephole 199    optimized misc jump sequence
   1F89 BE 00 D8           4737 	cjne    r6,#0x00,00107$
                           4738 ;00119$:
                           4739 ;       Peephole 200    removed redundant sjmp
   1F8C                    4740 00120$:
                           4741 ;src/menu.c:1409: if (keypad_check_front() == DATA_AVAILABLE)
                           4742 ;     genCall
   1F8C C0 02              4743 	push	ar2
   1F8E C0 03              4744 	push	ar3
   1F90 C0 04              4745 	push	ar4
   1F92 C0 05              4746 	push	ar5
   1F94 C0 06              4747 	push	ar6
   1F96 12 02 9E           4748 	lcall	_keypad_check_front
   1F99 AF 82              4749 	mov	r7,dpl
   1F9B D0 06              4750 	pop	ar6
   1F9D D0 05              4751 	pop	ar5
   1F9F D0 04              4752 	pop	ar4
   1FA1 D0 03              4753 	pop	ar3
   1FA3 D0 02              4754 	pop	ar2
                           4755 ;     genCmpEq
                           4756 ;       Peephole 112.b  changed ljmp to sjmp
                           4757 ;       Peephole 199    optimized misc jump sequence
   1FA5 BF 91 BC           4758 	cjne    r7,#0x91,00107$
                           4759 ;00121$:
                           4760 ;       Peephole 200    removed redundant sjmp
   1FA8                    4761 00122$:
                           4762 ;src/menu.c:1411: key_code = keypad_pop_front();
                           4763 ;     genCall
   1FA8 C0 02              4764 	push	ar2
   1FAA C0 03              4765 	push	ar3
   1FAC C0 04              4766 	push	ar4
   1FAE C0 05              4767 	push	ar5
   1FB0 C0 06              4768 	push	ar6
   1FB2 12 02 8C           4769 	lcall	_keypad_pop_front
   1FB5 85 82 33           4770 	mov	_key_code,dpl
   1FB8 D0 06              4771 	pop	ar6
   1FBA D0 05              4772 	pop	ar5
   1FBC D0 04              4773 	pop	ar4
   1FBE D0 03              4774 	pop	ar3
   1FC0 D0 02              4775 	pop	ar2
                           4776 ;src/menu.c:1414: switch (key_code)
                           4777 ;     genCmpEq
   1FC2 E5 33              4778 	mov	a,_key_code
                           4779 ;       Peephole 112.b  changed ljmp to sjmp
                           4780 ;       Peephole 199    optimized misc jump sequence
   1FC4 B4 13 06           4781 	cjne    a,#0x13,00102$
                           4782 ;00123$:
                           4783 ;       Peephole 200    removed redundant sjmp
   1FC7                    4784 00124$:
                           4785 ;src/menu.c:1417: result = value;
                           4786 ;     genAssign
   1FC7 8A 04              4787 	mov	ar4,r2
   1FC9 8B 05              4788 	mov	ar5,r3
                           4789 ;src/menu.c:1418: exit = 1;
                           4790 ;     genAssign
   1FCB 7E 01              4791 	mov	r6,#0x01
                           4792 ;src/menu.c:1420: }
   1FCD                    4793 00102$:
                           4794 ;src/menu.c:1421: keypad_purge_buffer();
                           4795 ;     genCall
   1FCD C0 02              4796 	push	ar2
   1FCF C0 03              4797 	push	ar3
   1FD1 C0 04              4798 	push	ar4
   1FD3 C0 05              4799 	push	ar5
   1FD5 C0 06              4800 	push	ar6
   1FD7 12 02 B0           4801 	lcall	_keypad_purge_buffer
   1FDA D0 06              4802 	pop	ar6
   1FDC D0 05              4803 	pop	ar5
   1FDE D0 04              4804 	pop	ar4
   1FE0 D0 03              4805 	pop	ar3
   1FE2 D0 02              4806 	pop	ar2
   1FE4 02 1F 64           4807 	ljmp	00107$
   1FE7                    4808 00109$:
                           4809 ;src/menu.c:1426: menu_previous_position();
                           4810 ;     genCall
   1FE7 C0 04              4811 	push	ar4
   1FE9 C0 05              4812 	push	ar5
   1FEB 12 1F 17           4813 	lcall	_menu_previous_position
   1FEE D0 05              4814 	pop	ar5
   1FF0 D0 04              4815 	pop	ar4
                           4816 ;src/menu.c:1429: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
                           4817 ;     genIpush
   1FF2 C0 04              4818 	push	ar4
   1FF4 C0 05              4819 	push	ar5
   1FF6 C0 31              4820 	push	_current_display_state
                           4821 ;     genCall
   1FF8 75 82 00           4822 	mov	dpl,#0x00
   1FFB 12 6D A5           4823 	lcall	_ds1302_write_memory
   1FFE 15 81              4824 	dec	sp
   2000 D0 05              4825 	pop	ar5
   2002 D0 04              4826 	pop	ar4
                           4827 ;src/menu.c:1431: return result;
                           4828 ;     genCast
   2004 7A 00              4829 	mov	r2,#0x00
   2006 7B 00              4830 	mov	r3,#0x00
                           4831 ;     genRet
   2008 8C 82              4832 	mov	dpl,r4
   200A 8D 83              4833 	mov	dph,r5
   200C 8A F0              4834 	mov	b,r2
   200E EB                 4835 	mov	a,r3
   200F                    4836 00110$:
   200F 85 40 81           4837 	mov	sp,_bp
   2012 D0 40              4838 	pop	_bp
   2014 22                 4839 	ret
                           4840 ;------------------------------------------------------------
                           4841 ;Allocation info for local variables in function 'keypad_test_workloop'
                           4842 ;------------------------------------------------------------
                           4843 ;------------------------------------------------------------
                           4844 ;src/menu.c:1442: void keypad_test_workloop()
                           4845 ;	-----------------------------------------
                           4846 ;	 function keypad_test_workloop
                           4847 ;	-----------------------------------------
   2015                    4848 _keypad_test_workloop:
   2015 C0 40              4849 	push	_bp
   2017 85 81 40           4850 	mov	_bp,sp
                           4851 ;src/menu.c:1444: BLINKING_OFF;
                           4852 ;     genAssign
   201A 75 30 00           4853 	mov	_blinking,#0x00
                           4854 ;src/menu.c:1445: lcd_clear();
                           4855 ;     genCall
   201D 12 0B 75           4856 	lcall	_lcd_clear
                           4857 ;src/menu.c:1446: printf_fast("Test klawiatury, nacisnij dowolny klawisz ...");
                           4858 ;     genIpush
   2020 74 5B              4859 	mov	a,#__str_14
   2022 C0 E0              4860 	push	acc
   2024 74 4A              4861 	mov	a,#(__str_14 >> 8)
   2026 C0 E0              4862 	push	acc
                           4863 ;     genCall
   2028 12 72 21           4864 	lcall	_printf_fast
   202B 15 81              4865 	dec	sp
   202D 15 81              4866 	dec	sp
                           4867 ;src/menu.c:1448: while(1)
   202F                    4868 00104$:
                           4869 ;src/menu.c:1450: if (keypad_check_front() == DATA_AVAILABLE)
                           4870 ;     genCall
   202F 12 02 9E           4871 	lcall	_keypad_check_front
   2032 AA 82              4872 	mov	r2,dpl
                           4873 ;     genCmpEq
                           4874 ;       Peephole 112.b  changed ljmp to sjmp
                           4875 ;       Peephole 199    optimized misc jump sequence
   2034 BA 91 2A           4876 	cjne    r2,#0x91,00102$
                           4877 ;00110$:
                           4878 ;       Peephole 200    removed redundant sjmp
   2037                    4879 00111$:
                           4880 ;src/menu.c:1452: key_code = keypad_pop_front();
                           4881 ;     genCall
   2037 12 02 8C           4882 	lcall	_keypad_pop_front
   203A 85 82 33           4883 	mov	_key_code,dpl
                           4884 ;src/menu.c:1453: lcd_goto_xy(0,0);
                           4885 ;     genIpush
                           4886 ;       Peephole 181    changed mov to clr
   203D E4                 4887 	clr     a
   203E C0 E0              4888 	push	acc
                           4889 ;     genCall
   2040 75 82 00           4890 	mov	dpl,#0x00
   2043 12 0A CD           4891 	lcall	_lcd_goto_xy
   2046 15 81              4892 	dec	sp
                           4893 ;src/menu.c:1454: printf_fast("Nacisnieto klawisz o kodzie: (%x)               ", key_code);
                           4894 ;     genCast
   2048 AA 33              4895 	mov	r2,_key_code
   204A 7B 00              4896 	mov	r3,#0x00
                           4897 ;     genIpush
   204C C0 02              4898 	push	ar2
   204E C0 03              4899 	push	ar3
                           4900 ;     genIpush
   2050 74 89              4901 	mov	a,#__str_15
   2052 C0 E0              4902 	push	acc
   2054 74 4A              4903 	mov	a,#(__str_15 >> 8)
   2056 C0 E0              4904 	push	acc
                           4905 ;     genCall
   2058 12 72 21           4906 	lcall	_printf_fast
   205B E5 81              4907 	mov	a,sp
   205D 24 FC              4908 	add	a,#0xfc
   205F F5 81              4909 	mov	sp,a
   2061                    4910 00102$:
                           4911 ;src/menu.c:1456: SERVICE_WATCHDOG;
                           4912 ;     genAssign
   2061 75 A6 1E           4913 	mov	_WDTRST,#0x1E
                           4914 ;     genAssign
   2064 75 A6 E1           4915 	mov	_WDTRST,#0xE1
                           4916 ;       Peephole 112.b  changed ljmp to sjmp
   2067 80 C6              4917 	sjmp    00104$
   2069                    4918 00106$:
   2069 85 40 81           4919 	mov	sp,_bp
   206C D0 40              4920 	pop	_bp
   206E 22                 4921 	ret
                           4922 ;------------------------------------------------------------
                           4923 ;Allocation info for local variables in function 'weekday_worklop'
                           4924 ;------------------------------------------------------------
                           4925 ;value                     Allocated to stack - offset 1
                           4926 ;display                   Allocated to stack - offset 3
                           4927 ;exit                      Allocated to stack - offset 6
                           4928 ;result                    Allocated to stack - offset 7
                           4929 ;------------------------------------------------------------
                           4930 ;src/menu.c:1460: unsigned int weekday_worklop(const unsigned int value)
                           4931 ;	-----------------------------------------
                           4932 ;	 function weekday_worklop
                           4933 ;	-----------------------------------------
   206F                    4934 _weekday_worklop:
   206F C0 40              4935 	push	_bp
   2071 85 81 40           4936 	mov	_bp,sp
   2074 E5 81              4937 	mov	a,sp
   2076 24 08              4938 	add	a,#0x08
   2078 F5 81              4939 	mov	sp,a
                           4940 ;     genReceive
   207A C0 E0              4941 	push	acc
                           4942 ;       Peephole 212    reduced add sequence to inc
   207C A8 40              4943 	mov     r0,_bp
   207E 08                 4944 	inc     r0
   207F D0 E0              4945 	pop	acc
   2081 A6 82              4946 	mov	@r0,dpl
   2083 08                 4947 	inc	r0
   2084 A6 83              4948 	mov	@r0,dph
                           4949 ;src/menu.c:1463: unsigned char exit = 0;
                           4950 ;     genAssign
   2086 E5 40              4951 	mov	a,_bp
   2088 24 06              4952 	add	a,#0x06
   208A F8                 4953 	mov	r0,a
                           4954 ;src/menu.c:1466: BLINKING_OFF;
                           4955 ;     genAssign
                           4956 ;src/menu.c:1467: result = value;
                           4957 ;     genAssign
                           4958 ;       Peephole 3.c    changed mov to clr
   208B E4                 4959 	clr     a
   208C F6                 4960 	mov     @r0,a
   208D F5 30              4961 	mov     _blinking,a
                           4962 ;       Peephole 212    reduced add sequence to inc
   208F A8 40              4963 	mov     r0,_bp
   2091 08                 4964 	inc     r0
   2092 E5 40              4965 	mov	a,_bp
   2094 24 07              4966 	add	a,#0x07
   2096 F9                 4967 	mov	r1,a
   2097 E6                 4968 	mov	a,@r0
   2098 F7                 4969 	mov	@r1,a
   2099 08                 4970 	inc	r0
   209A 09                 4971 	inc	r1
   209B E6                 4972 	mov	a,@r0
   209C F7                 4973 	mov	@r1,a
                           4974 ;src/menu.c:1469: display = menu[current_display_state].item[current_position].display;
                           4975 ;     genMult
                           4976 ;     genMultOneByte
   209D E5 31              4977 	mov	a,_current_display_state
   209F 75 F0 3C           4978 	mov	b,#0x3C
   20A2 A4                 4979 	mul	ab
                           4980 ;     genPlus
   20A3 24 0E              4981 	add	a,#_menu
   20A5 FF                 4982 	mov	r7,a
   20A6 E5 F0              4983 	mov	a,b
   20A8 34 3C              4984 	addc	a,#(_menu >> 8)
   20AA FC                 4985 	mov	r4,a
                           4986 ;     genPlus
                           4987 ;     genPlusIncr
   20AB 74 04              4988 	mov	a,#0x04
                           4989 ;       Peephole 236.a  used r7 instead of ar7
   20AD 2F                 4990 	add     a,r7
   20AE FF                 4991 	mov	r7,a
                           4992 ;       Peephole 181    changed mov to clr
   20AF E4                 4993 	clr     a
                           4994 ;       Peephole 236.b  used r4 instead of ar4
   20B0 3C                 4995 	addc    a,r4
   20B1 FC                 4996 	mov	r4,a
                           4997 ;     genMult
                           4998 ;     genMultOneByte
   20B2 E5 32              4999 	mov	a,_current_position
   20B4 75 F0 08           5000 	mov	b,#0x08
   20B7 A4                 5001 	mul	ab
                           5002 ;     genPlus
                           5003 ;       Peephole 236.a  used r7 instead of ar7
   20B8 2F                 5004 	add     a,r7
   20B9 FF                 5005 	mov	r7,a
   20BA E5 F0              5006 	mov	a,b
                           5007 ;       Peephole 236.b  used r4 instead of ar4
   20BC 3C                 5008 	addc    a,r4
   20BD FC                 5009 	mov	r4,a
                           5010 ;     genPlus
   20BE 74 05              5011 	mov	a,#0x05
                           5012 ;       Peephole 236.a  used r7 instead of ar7
   20C0 2F                 5013 	add     a,r7
   20C1 F5 82              5014 	mov	dpl,a
                           5015 ;       Peephole 181    changed mov to clr
   20C3 E4                 5016 	clr     a
                           5017 ;       Peephole 236.b  used r4 instead of ar4
   20C4 3C                 5018 	addc    a,r4
   20C5 F5 83              5019 	mov	dph,a
                           5020 ;     genPointerGet
                           5021 ;     genCodePointerGet
                           5022 ;       Peephole 181    changed mov to clr
   20C7 E4                 5023 	clr     a
   20C8 93                 5024 	movc	a,@a+dptr
   20C9 FA                 5025 	mov	r2,a
   20CA 74 01              5026 	mov	a,#0x01
   20CC 93                 5027 	movc	a,@a+dptr
   20CD FB                 5028 	mov	r3,a
   20CE 74 02              5029 	mov	a,#0x02
   20D0 93                 5030 	movc	a,@a+dptr
   20D1 FC                 5031 	mov	r4,a
                           5032 ;     genAssign
   20D2 E5 40              5033 	mov	a,_bp
   20D4 24 03              5034 	add	a,#0x03
   20D6 F8                 5035 	mov	r0,a
   20D7 A6 02              5036 	mov	@r0,ar2
   20D9 08                 5037 	inc	r0
   20DA A6 03              5038 	mov	@r0,ar3
   20DC 08                 5039 	inc	r0
   20DD A6 04              5040 	mov	@r0,ar4
                           5041 ;src/menu.c:1471: lcd_goto_xy(display->x, display->y+1);
                           5042 ;     genPlus
   20DF E5 40              5043 	mov	a,_bp
   20E1 24 03              5044 	add	a,#0x03
   20E3 F8                 5045 	mov	r0,a
                           5046 ;     genPlusIncr
   20E4 74 01              5047 	mov	a,#0x01
   20E6 26                 5048 	add	a,@r0
   20E7 FB                 5049 	mov	r3,a
                           5050 ;       Peephole 181    changed mov to clr
   20E8 E4                 5051 	clr     a
   20E9 08                 5052 	inc	r0
   20EA 36                 5053 	addc	a,@r0
   20EB FD                 5054 	mov	r5,a
   20EC 08                 5055 	inc	r0
   20ED 86 06              5056 	mov	ar6,@r0
                           5057 ;     genPointerGet
                           5058 ;     genGenPointerGet
   20EF 8B 82              5059 	mov	dpl,r3
   20F1 8D 83              5060 	mov	dph,r5
   20F3 8E F0              5061 	mov	b,r6
   20F5 12 71 F5           5062 	lcall	__gptrget
                           5063 ;     genPlus
                           5064 ;     genPlusIncr
                           5065 ;       Peephole 185    changed order of increment (acc incremented also!)
   20F8 04                 5066 	inc     a
   20F9 FB                 5067 	mov     r3,a
                           5068 ;     genPointerGet
                           5069 ;     genGenPointerGet
   20FA E5 40              5070 	mov	a,_bp
   20FC 24 03              5071 	add	a,#0x03
   20FE F8                 5072 	mov	r0,a
   20FF 86 82              5073 	mov	dpl,@r0
   2101 08                 5074 	inc	r0
   2102 86 83              5075 	mov	dph,@r0
   2104 08                 5076 	inc	r0
   2105 86 F0              5077 	mov	b,@r0
   2107 12 71 F5           5078 	lcall	__gptrget
   210A FD                 5079 	mov	r5,a
                           5080 ;     genIpush
   210B C0 03              5081 	push	ar3
                           5082 ;     genCall
   210D 8D 82              5083 	mov	dpl,r5
   210F 12 0A CD           5084 	lcall	_lcd_goto_xy
   2112 15 81              5085 	dec	sp
                           5086 ;src/menu.c:1472: printf_day(value);
                           5087 ;     genCast
                           5088 ;       Peephole 212    reduced add sequence to inc
   2114 A8 40              5089 	mov     r0,_bp
   2116 08                 5090 	inc     r0
   2117 86 82              5091 	mov	dpl,@r0
                           5092 ;     genCall
   2119 12 6D 1C           5093 	lcall	_printf_day
                           5094 ;src/menu.c:1474: while(exit == 0)
                           5095 ;     genPlus
   211C E5 40              5096 	mov	a,_bp
   211E 24 03              5097 	add	a,#0x03
   2120 F8                 5098 	mov	r0,a
                           5099 ;     genPlusIncr
   2121 74 01              5100 	mov	a,#0x01
   2123 26                 5101 	add	a,@r0
   2124 FB                 5102 	mov	r3,a
                           5103 ;       Peephole 181    changed mov to clr
   2125 E4                 5104 	clr     a
   2126 08                 5105 	inc	r0
   2127 36                 5106 	addc	a,@r0
   2128 FD                 5107 	mov	r5,a
   2129 08                 5108 	inc	r0
   212A 86 06              5109 	mov	ar6,@r0
   212C                    5110 00115$:
                           5111 ;     genCmpEq
   212C E5 40              5112 	mov	a,_bp
   212E 24 06              5113 	add	a,#0x06
   2130 F8                 5114 	mov	r0,a
   2131 B6 00 02           5115 	cjne	@r0,#0x00,00130$
   2134 80 03              5116 	sjmp	00131$
   2136                    5117 00130$:
   2136 02 22 B8           5118 	ljmp	00117$
   2139                    5119 00131$:
                           5120 ;src/menu.c:1476: SERVICE_WATCHDOG;
                           5121 ;     genIpush
   2139 C0 03              5122 	push	ar3
   213B C0 05              5123 	push	ar5
   213D C0 06              5124 	push	ar6
                           5125 ;     genAssign
   213F 75 A6 1E           5126 	mov	_WDTRST,#0x1E
                           5127 ;     genAssign
   2142 75 A6 E1           5128 	mov	_WDTRST,#0xE1
                           5129 ;src/menu.c:1477: if (keypad_check_front() == DATA_AVAILABLE)
                           5130 ;     genCall
   2145 C0 05              5131 	push	ar5
   2147 C0 06              5132 	push	ar6
   2149 12 02 9E           5133 	lcall	_keypad_check_front
   214C AB 82              5134 	mov	r3,dpl
   214E D0 06              5135 	pop	ar6
   2150 D0 05              5136 	pop	ar5
                           5137 ;     genCmpEq
                           5138 ;       Peephole 241.c  optimized compare
   2152 E4                 5139 	clr     a
   2153 BB 91 01           5140 	cjne    r3,#0x91,00132$
   2156 04                 5141 	inc     a
   2157                    5142 00132$:
   2157                    5143 00133$:
                           5144 ;     genIpop
   2157 D0 06              5145 	pop	ar6
   2159 D0 05              5146 	pop	ar5
   215B D0 03              5147 	pop	ar3
                           5148 ;     genIfx
                           5149 ;     genIfxJump
                           5150 ;       Peephole 110    removed ljmp by inverse jump logic
   215D 60 CD              5151 	jz      00115$
   215F                    5152 00134$:
                           5153 ;src/menu.c:1479: key_code = keypad_pop_front();
                           5154 ;     genCall
   215F C0 03              5155 	push	ar3
   2161 C0 05              5156 	push	ar5
   2163 C0 06              5157 	push	ar6
   2165 12 02 8C           5158 	lcall	_keypad_pop_front
   2168 85 82 33           5159 	mov	_key_code,dpl
   216B D0 06              5160 	pop	ar6
   216D D0 05              5161 	pop	ar5
   216F D0 03              5162 	pop	ar3
                           5163 ;src/menu.c:1480: if (exit == 1)
                           5164 ;     genCmpEq
   2171 E5 40              5165 	mov	a,_bp
   2173 24 06              5166 	add	a,#0x06
   2175 F8                 5167 	mov	r0,a
                           5168 ;       Peephole 112.b  changed ljmp to sjmp
                           5169 ;       Peephole 199    optimized misc jump sequence
   2176 B6 01 0E           5170 	cjne    @r0,#0x01,00102$
                           5171 ;00135$:
                           5172 ;       Peephole 200    removed redundant sjmp
   2179                    5173 00136$:
                           5174 ;src/menu.c:1482: result = value;
                           5175 ;     genAssign
                           5176 ;       Peephole 212    reduced add sequence to inc
   2179 A8 40              5177 	mov     r0,_bp
   217B 08                 5178 	inc     r0
   217C E5 40              5179 	mov	a,_bp
   217E 24 07              5180 	add	a,#0x07
   2180 F9                 5181 	mov	r1,a
   2181 E6                 5182 	mov	a,@r0
   2182 F7                 5183 	mov	@r1,a
   2183 08                 5184 	inc	r0
   2184 09                 5185 	inc	r1
   2185 E6                 5186 	mov	a,@r0
   2186 F7                 5187 	mov	@r1,a
   2187                    5188 00102$:
                           5189 ;src/menu.c:1485: switch (key_code)
                           5190 ;     genCmpEq
   2187 E5 33              5191 	mov	a,_key_code
   2189 B4 10 02           5192 	cjne	a,#0x10,00137$
                           5193 ;       Peephole 112.b  changed ljmp to sjmp
   218C 80 3B              5194 	sjmp    00107$
   218E                    5195 00137$:
                           5196 ;     genCmpEq
   218E E5 33              5197 	mov	a,_key_code
   2190 B4 11 03           5198 	cjne	a,#0x11,00138$
   2193 02 22 38           5199 	ljmp	00111$
   2196                    5200 00138$:
                           5201 ;     genCmpEq
   2196 E5 33              5202 	mov	a,_key_code
   2198 B4 13 02           5203 	cjne	a,#0x13,00139$
                           5204 ;       Peephole 112.b  changed ljmp to sjmp
   219B 80 14              5205 	sjmp    00104$
   219D                    5206 00139$:
                           5207 ;     genCmpEq
   219D E5 33              5208 	mov	a,_key_code
   219F B4 14 02           5209 	cjne	a,#0x14,00140$
   21A2 80 03              5210 	sjmp	00141$
   21A4                    5211 00140$:
   21A4 02 22 A6           5212 	ljmp	00112$
   21A7                    5213 00141$:
                           5214 ;src/menu.c:1488: exit = 1;
                           5215 ;     genAssign
   21A7 E5 40              5216 	mov	a,_bp
   21A9 24 06              5217 	add	a,#0x06
   21AB F8                 5218 	mov	r0,a
   21AC 76 01              5219 	mov	@r0,#0x01
                           5220 ;src/menu.c:1489: break;
   21AE 02 22 A6           5221 	ljmp	00112$
                           5222 ;src/menu.c:1492: result = value;
   21B1                    5223 00104$:
                           5224 ;     genAssign
                           5225 ;       Peephole 212    reduced add sequence to inc
   21B1 A8 40              5226 	mov     r0,_bp
   21B3 08                 5227 	inc     r0
   21B4 E5 40              5228 	mov	a,_bp
   21B6 24 07              5229 	add	a,#0x07
   21B8 F9                 5230 	mov	r1,a
   21B9 E6                 5231 	mov	a,@r0
   21BA F7                 5232 	mov	@r1,a
   21BB 08                 5233 	inc	r0
   21BC 09                 5234 	inc	r1
   21BD E6                 5235 	mov	a,@r0
   21BE F7                 5236 	mov	@r1,a
                           5237 ;src/menu.c:1493: exit = 1;
                           5238 ;     genAssign
   21BF E5 40              5239 	mov	a,_bp
   21C1 24 06              5240 	add	a,#0x06
   21C3 F8                 5241 	mov	r0,a
   21C4 76 01              5242 	mov	@r0,#0x01
                           5243 ;src/menu.c:1494: break;
   21C6 02 22 A6           5244 	ljmp	00112$
                           5245 ;src/menu.c:1499: lcd_goto_xy(display->x, display->y+1);
   21C9                    5246 00107$:
                           5247 ;src/menu.c:1497: if (++result > 7)
                           5248 ;     genPlus
   21C9 E5 40              5249 	mov	a,_bp
   21CB 24 07              5250 	add	a,#0x07
   21CD F8                 5251 	mov	r0,a
                           5252 ;     genPlusIncr
   21CE 74 01              5253 	mov	a,#0x01
   21D0 26                 5254 	add	a,@r0
   21D1 F6                 5255 	mov	@r0,a
                           5256 ;       Peephole 181    changed mov to clr
   21D2 E4                 5257 	clr     a
   21D3 08                 5258 	inc	r0
   21D4 36                 5259 	addc	a,@r0
   21D5 F6                 5260 	mov	@r0,a
                           5261 ;     genCmpGt
   21D6 E5 40              5262 	mov	a,_bp
   21D8 24 07              5263 	add	a,#0x07
   21DA F8                 5264 	mov	r0,a
                           5265 ;     genCmp
   21DB C3                 5266 	clr	c
   21DC 74 07              5267 	mov	a,#0x07
   21DE 96                 5268 	subb	a,@r0
                           5269 ;       Peephole 181    changed mov to clr
   21DF E4                 5270 	clr     a
   21E0 08                 5271 	inc	r0
   21E1 96                 5272 	subb	a,@r0
                           5273 ;     genIfxJump
                           5274 ;       Peephole 108    removed ljmp by inverse jump logic
   21E2 50 0B              5275 	jnc     00106$
   21E4                    5276 00142$:
                           5277 ;src/menu.c:1498: result = 1;
                           5278 ;     genAssign
   21E4 E5 40              5279 	mov	a,_bp
   21E6 24 07              5280 	add	a,#0x07
   21E8 F8                 5281 	mov	r0,a
   21E9 E4                 5282 	clr	a
   21EA 08                 5283 	inc	r0
   21EB F6                 5284 	mov	@r0,a
   21EC 18                 5285 	dec	r0
   21ED 76 01              5286 	mov	@r0,#0x01
   21EF                    5287 00106$:
                           5288 ;src/menu.c:1499: lcd_goto_xy(display->x, display->y+1);
                           5289 ;     genPointerGet
                           5290 ;     genGenPointerGet
   21EF 8B 82              5291 	mov	dpl,r3
   21F1 8D 83              5292 	mov	dph,r5
   21F3 8E F0              5293 	mov	b,r6
   21F5 12 71 F5           5294 	lcall	__gptrget
                           5295 ;     genPlus
                           5296 ;     genPlusIncr
                           5297 ;       Peephole 185    changed order of increment (acc incremented also!)
   21F8 04                 5298 	inc     a
   21F9 FA                 5299 	mov     r2,a
                           5300 ;     genPointerGet
                           5301 ;     genGenPointerGet
   21FA E5 40              5302 	mov	a,_bp
   21FC 24 03              5303 	add	a,#0x03
   21FE F8                 5304 	mov	r0,a
   21FF 86 82              5305 	mov	dpl,@r0
   2201 08                 5306 	inc	r0
   2202 86 83              5307 	mov	dph,@r0
   2204 08                 5308 	inc	r0
   2205 86 F0              5309 	mov	b,@r0
   2207 12 71 F5           5310 	lcall	__gptrget
   220A FC                 5311 	mov	r4,a
                           5312 ;     genIpush
   220B C0 03              5313 	push	ar3
   220D C0 05              5314 	push	ar5
   220F C0 06              5315 	push	ar6
   2211 C0 02              5316 	push	ar2
                           5317 ;     genCall
   2213 8C 82              5318 	mov	dpl,r4
   2215 12 0A CD           5319 	lcall	_lcd_goto_xy
   2218 15 81              5320 	dec	sp
   221A D0 06              5321 	pop	ar6
   221C D0 05              5322 	pop	ar5
   221E D0 03              5323 	pop	ar3
                           5324 ;src/menu.c:1500: printf_day(result);
                           5325 ;     genCast
   2220 E5 40              5326 	mov	a,_bp
   2222 24 07              5327 	add	a,#0x07
   2224 F8                 5328 	mov	r0,a
   2225 86 82              5329 	mov	dpl,@r0
                           5330 ;     genCall
   2227 C0 03              5331 	push	ar3
   2229 C0 05              5332 	push	ar5
   222B C0 06              5333 	push	ar6
   222D 12 6D 1C           5334 	lcall	_printf_day
   2230 D0 06              5335 	pop	ar6
   2232 D0 05              5336 	pop	ar5
   2234 D0 03              5337 	pop	ar3
                           5338 ;src/menu.c:1501: break;
                           5339 ;src/menu.c:1507: result--;
                           5340 ;       Peephole 112.b  changed ljmp to sjmp
   2236 80 6E              5341 	sjmp    00112$
   2238                    5342 00111$:
                           5343 ;src/menu.c:1504: if (result == 1)
                           5344 ;     genCmpEq
   2238 E5 40              5345 	mov	a,_bp
   223A 24 07              5346 	add	a,#0x07
   223C F8                 5347 	mov	r0,a
                           5348 ;       Peephole 112.b  changed ljmp to sjmp
                           5349 ;       Peephole 197.c  optimized misc jump sequence
   223D B6 01 11           5350 	cjne    @r0,#0x01,00109$
   2240 08                 5351 	inc     r0
   2241 B6 00 0D           5352 	cjne    @r0,#0x00,00109$
                           5353 ;00143$:
                           5354 ;       Peephole 200    removed redundant sjmp
   2244                    5355 00144$:
                           5356 ;src/menu.c:1505: result = 7;
                           5357 ;     genAssign
   2244 E5 40              5358 	mov	a,_bp
   2246 24 07              5359 	add	a,#0x07
   2248 F8                 5360 	mov	r0,a
   2249 E4                 5361 	clr	a
   224A 08                 5362 	inc	r0
   224B F6                 5363 	mov	@r0,a
   224C 18                 5364 	dec	r0
   224D 76 07              5365 	mov	@r0,#0x07
                           5366 ;       Peephole 112.b  changed ljmp to sjmp
   224F 80 0E              5367 	sjmp    00110$
   2251                    5368 00109$:
                           5369 ;src/menu.c:1507: result--;
                           5370 ;     genMinus
   2251 E5 40              5371 	mov	a,_bp
   2253 24 07              5372 	add	a,#0x07
   2255 F8                 5373 	mov	r0,a
                           5374 ;     genMinusDec
   2256 E6                 5375 	mov	a,@r0
   2257 24 FF              5376 	add	a,#0xff
   2259 F6                 5377 	mov	@r0,a
   225A 08                 5378 	inc	r0
   225B E6                 5379 	mov	a,@r0
   225C 34 FF              5380 	addc	a,#0xff
   225E F6                 5381 	mov	@r0,a
   225F                    5382 00110$:
                           5383 ;src/menu.c:1508: lcd_goto_xy(display->x, display->y+1);
                           5384 ;     genPointerGet
                           5385 ;     genGenPointerGet
   225F 8B 82              5386 	mov	dpl,r3
   2261 8D 83              5387 	mov	dph,r5
   2263 8E F0              5388 	mov	b,r6
   2265 12 71 F5           5389 	lcall	__gptrget
                           5390 ;     genPlus
                           5391 ;     genPlusIncr
                           5392 ;       Peephole 185    changed order of increment (acc incremented also!)
   2268 04                 5393 	inc     a
   2269 FA                 5394 	mov     r2,a
                           5395 ;     genPointerGet
                           5396 ;     genGenPointerGet
   226A E5 40              5397 	mov	a,_bp
   226C 24 03              5398 	add	a,#0x03
   226E F8                 5399 	mov	r0,a
   226F 86 82              5400 	mov	dpl,@r0
   2271 08                 5401 	inc	r0
   2272 86 83              5402 	mov	dph,@r0
   2274 08                 5403 	inc	r0
   2275 86 F0              5404 	mov	b,@r0
   2277 12 71 F5           5405 	lcall	__gptrget
   227A FC                 5406 	mov	r4,a
                           5407 ;     genIpush
   227B C0 03              5408 	push	ar3
   227D C0 05              5409 	push	ar5
   227F C0 06              5410 	push	ar6
   2281 C0 02              5411 	push	ar2
                           5412 ;     genCall
   2283 8C 82              5413 	mov	dpl,r4
   2285 12 0A CD           5414 	lcall	_lcd_goto_xy
   2288 15 81              5415 	dec	sp
   228A D0 06              5416 	pop	ar6
   228C D0 05              5417 	pop	ar5
   228E D0 03              5418 	pop	ar3
                           5419 ;src/menu.c:1509: printf_day(result);
                           5420 ;     genCast
   2290 E5 40              5421 	mov	a,_bp
   2292 24 07              5422 	add	a,#0x07
   2294 F8                 5423 	mov	r0,a
   2295 86 82              5424 	mov	dpl,@r0
                           5425 ;     genCall
   2297 C0 03              5426 	push	ar3
   2299 C0 05              5427 	push	ar5
   229B C0 06              5428 	push	ar6
   229D 12 6D 1C           5429 	lcall	_printf_day
   22A0 D0 06              5430 	pop	ar6
   22A2 D0 05              5431 	pop	ar5
   22A4 D0 03              5432 	pop	ar3
                           5433 ;src/menu.c:1511: }
   22A6                    5434 00112$:
                           5435 ;src/menu.c:1512: keypad_purge_buffer();
                           5436 ;     genCall
   22A6 C0 03              5437 	push	ar3
   22A8 C0 05              5438 	push	ar5
   22AA C0 06              5439 	push	ar6
   22AC 12 02 B0           5440 	lcall	_keypad_purge_buffer
   22AF D0 06              5441 	pop	ar6
   22B1 D0 05              5442 	pop	ar5
   22B3 D0 03              5443 	pop	ar3
   22B5 02 21 2C           5444 	ljmp	00115$
   22B8                    5445 00117$:
                           5446 ;src/menu.c:1516: ds1302_read_rtc_bcd(&system_time);
                           5447 ;     genCall
                           5448 ;       Peephole 182.a  used 16 bit load of DPTR
   22B8 90 01 81           5449 	mov     dptr,#_system_time
   22BB 75 F0 01           5450 	mov	b,#0x01
   22BE 12 60 DC           5451 	lcall	_ds1302_read_rtc_bcd
                           5452 ;src/menu.c:1517: system_time.tm_wday = result;
                           5453 ;     genCast
   22C1 E5 40              5454 	mov	a,_bp
   22C3 24 07              5455 	add	a,#0x07
   22C5 F8                 5456 	mov	r0,a
   22C6 86 02              5457 	mov	ar2,@r0
                           5458 ;     genPointerSet
                           5459 ;     genFarPointerSet
   22C8 90 01 88           5460 	mov	dptr,#(_system_time + 0x0007)
   22CB EA                 5461 	mov	a,r2
   22CC F0                 5462 	movx	@dptr,a
                           5463 ;src/menu.c:1518: ds1302_write_rtc(&system_time);
                           5464 ;     genCall
                           5465 ;       Peephole 182.a  used 16 bit load of DPTR
   22CD 90 01 81           5466 	mov     dptr,#_system_time
   22D0 75 F0 01           5467 	mov	b,#0x01
   22D3 12 62 54           5468 	lcall	_ds1302_write_rtc
                           5469 ;src/menu.c:1520: menu_previous_position();
                           5470 ;     genCall
   22D6 12 1F 17           5471 	lcall	_menu_previous_position
                           5472 ;src/menu.c:1521: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
                           5473 ;     genIpush
   22D9 C0 31              5474 	push	_current_display_state
                           5475 ;     genCall
   22DB 75 82 00           5476 	mov	dpl,#0x00
   22DE 12 6D A5           5477 	lcall	_ds1302_write_memory
   22E1 15 81              5478 	dec	sp
                           5479 ;src/menu.c:1523: return result;
                           5480 ;     genRet
   22E3 E5 40              5481 	mov	a,_bp
   22E5 24 07              5482 	add	a,#0x07
   22E7 F8                 5483 	mov	r0,a
   22E8 86 82              5484 	mov	dpl,@r0
   22EA 08                 5485 	inc	r0
   22EB 86 83              5486 	mov	dph,@r0
   22ED                    5487 00118$:
   22ED 85 40 81           5488 	mov	sp,_bp
   22F0 D0 40              5489 	pop	_bp
   22F2 22                 5490 	ret
                           5491 ;------------------------------------------------------------
                           5492 ;Allocation info for local variables in function 'read_keyboard_data_workloop'
                           5493 ;------------------------------------------------------------
                           5494 ;value                     Allocated to stack - offset -4
                           5495 ;point                     Allocated to stack - offset -5
                           5496 ;isBCD                     Allocated to stack - offset -6
                           5497 ;size                      Allocated to registers r5 
                           5498 ;count                     Allocated to stack - offset 1
                           5499 ;j                         Allocated to stack - offset 2
                           5500 ;exit                      Allocated to registers r2 
                           5501 ;result                    Allocated to stack - offset 3
                           5502 ;sloc0                     Allocated to stack - offset 5
                           5503 ;sloc1                     Allocated to stack - offset 6
                           5504 ;------------------------------------------------------------
                           5505 ;src/menu.c:1527: unsigned int read_keyboard_data_workloop(unsigned char size, const unsigned int value, const char point, const boolean isBCD)
                           5506 ;	-----------------------------------------
                           5507 ;	 function read_keyboard_data_workloop
                           5508 ;	-----------------------------------------
   22F3                    5509 _read_keyboard_data_workloop:
   22F3 C0 40              5510 	push	_bp
   22F5 85 81 40           5511 	mov	_bp,sp
   22F8 E5 81              5512 	mov	a,sp
   22FA 24 06              5513 	add	a,#0x06
   22FC F5 81              5514 	mov	sp,a
                           5515 ;     genReceive
   22FE AD 82              5516 	mov	r5,dpl
                           5517 ;src/menu.c:1532: count = 1;
                           5518 ;     genAssign
                           5519 ;       Peephole 212    reduced add sequence to inc
   2300 A8 40              5520 	mov     r0,_bp
   2302 08                 5521 	inc     r0
   2303 76 01              5522 	mov	@r0,#0x01
                           5523 ;src/menu.c:1533: result = 0;
                           5524 ;     genAssign
   2305 E5 40              5525 	mov	a,_bp
   2307 24 03              5526 	add	a,#0x03
                           5527 ;       Peephole 216    simplified clear (2bytes)
   2309 F8                 5528 	mov     r0,a
   230A E4                 5529 	clr     a
   230B F6                 5530 	mov     @r0,a
   230C 08                 5531 	inc     r0
   230D F6                 5532 	mov     @r0,a
                           5533 ;src/menu.c:1535: while(count <= size)
                           5534 ;     genCmpEq
   230E E5 40              5535 	mov	a,_bp
   2310 24 FA              5536 	add	a,#0xfa
   2312 F8                 5537 	mov	r0,a
                           5538 ;       Peephole 241.f  optimized compare
   2313 E4                 5539 	clr     a
   2314 B6 00 01           5540 	cjne    @r0,#0x00,00144$
   2317 04                 5541 	inc     a
   2318                    5542 00144$:
   2318                    5543 00145$:
   2318 FE                 5544 	mov	r6,a
                           5545 ;     genPlus
                           5546 ;     genPlusIncr
   2319 74 01              5547 	mov	a,#0x01
                           5548 ;       Peephole 236.a  used r5 instead of ar5
   231B 2D                 5549 	add     a,r5
   231C FF                 5550 	mov	r7,a
                           5551 ;     genAssign
   231D E5 40              5552 	mov	a,_bp
   231F 24 05              5553 	add	a,#0x05
   2321 F8                 5554 	mov	r0,a
   2322 A6 07              5555 	mov	@r0,ar7
                           5556 ;     genAssign
   2324 E5 40              5557 	mov	a,_bp
   2326 24 06              5558 	add	a,#0x06
   2328 F8                 5559 	mov	r0,a
   2329 A6 07              5560 	mov	@r0,ar7
   232B                    5561 00122$:
                           5562 ;     genCmpGt
                           5563 ;       Peephole 212    reduced add sequence to inc
   232B A8 40              5564 	mov     r0,_bp
   232D 08                 5565 	inc     r0
                           5566 ;     genCmp
   232E C3                 5567 	clr	c
   232F ED                 5568 	mov	a,r5
   2330 96                 5569 	subb	a,@r0
                           5570 ;     genIfxJump
   2331 50 03              5571 	jnc	00146$
   2333 02 25 50           5572 	ljmp	00124$
   2336                    5573 00146$:
                           5574 ;src/menu.c:1537: SERVICE_WATCHDOG;
                           5575 ;     genAssign
   2336 75 A6 1E           5576 	mov	_WDTRST,#0x1E
                           5577 ;     genAssign
   2339 75 A6 E1           5578 	mov	_WDTRST,#0xE1
                           5579 ;src/menu.c:1541: exit = check_external_events();
                           5580 ;     genCall
   233C C0 05              5581 	push	ar5
   233E C0 06              5582 	push	ar6
   2340 C0 07              5583 	push	ar7
   2342 12 1E B1           5584 	lcall	_check_external_events
   2345 AA 82              5585 	mov	r2,dpl
   2347 D0 07              5586 	pop	ar7
   2349 D0 06              5587 	pop	ar6
   234B D0 05              5588 	pop	ar5
                           5589 ;     genAssign
                           5590 ;src/menu.c:1542: if (exit == 0)
                           5591 ;     genCmpEq
   234D BA 00 02           5592 	cjne	r2,#0x00,00147$
   2350 80 03              5593 	sjmp	00148$
   2352                    5594 00147$:
   2352 02 25 33           5595 	ljmp	00120$
   2355                    5596 00148$:
                           5597 ;src/menu.c:1544: SERVICE_WATCHDOG;
                           5598 ;     genIpush
   2355 C0 07              5599 	push	ar7
                           5600 ;     genAssign
   2357 75 A6 1E           5601 	mov	_WDTRST,#0x1E
                           5602 ;     genAssign
   235A 75 A6 E1           5603 	mov	_WDTRST,#0xE1
                           5604 ;src/menu.c:1545: if (keypad_check_front() == DATA_AVAILABLE)
                           5605 ;     genCall
   235D C0 05              5606 	push	ar5
   235F C0 06              5607 	push	ar6
   2361 12 02 9E           5608 	lcall	_keypad_check_front
   2364 AF 82              5609 	mov	r7,dpl
   2366 D0 06              5610 	pop	ar6
   2368 D0 05              5611 	pop	ar5
                           5612 ;     genCmpEq
                           5613 ;       Peephole 241.c  optimized compare
   236A E4                 5614 	clr     a
   236B BF 91 01           5615 	cjne    r7,#0x91,00149$
   236E 04                 5616 	inc     a
   236F                    5617 00149$:
   236F                    5618 00150$:
                           5619 ;     genIpop
   236F D0 07              5620 	pop	ar7
                           5621 ;     genIfx
                           5622 ;     genIfxJump
                           5623 ;       Peephole 110    removed ljmp by inverse jump logic
   2371 60 B8              5624 	jz      00122$
   2373                    5625 00151$:
                           5626 ;src/menu.c:1547: key_code = keypad_pop_front();
                           5627 ;     genCall
   2373 C0 05              5628 	push	ar5
   2375 C0 06              5629 	push	ar6
   2377 C0 07              5630 	push	ar7
   2379 12 02 8C           5631 	lcall	_keypad_pop_front
   237C 85 82 33           5632 	mov	_key_code,dpl
   237F D0 07              5633 	pop	ar7
   2381 D0 06              5634 	pop	ar6
   2383 D0 05              5635 	pop	ar5
                           5636 ;src/menu.c:1555: if (key_code >=0 && key_code < 10)
                           5637 ;     genCmpLt
                           5638 ;     genCmp
   2385 C3                 5639 	clr	c
                           5640 ;     genIfxJump
   2386 50 03              5641 	jnc	00152$
   2388 02 24 66           5642 	ljmp	00114$
   238B                    5643 00152$:
                           5644 ;     genCmpLt
                           5645 ;     genCmp
   238B C3                 5646 	clr	c
   238C E5 33              5647 	mov	a,_key_code
   238E 94 0A              5648 	subb	a,#0x0A
                           5649 ;     genIfxJump
   2390 40 03              5650 	jc	00153$
   2392 02 24 66           5651 	ljmp	00114$
   2395                    5652 00153$:
                           5653 ;src/menu.c:1557: if (count == point)
                           5654 ;     genCmpEq
                           5655 ;       Peephole 212    reduced add sequence to inc
   2395 A8 40              5656 	mov     r0,_bp
   2397 08                 5657 	inc     r0
   2398 E5 40              5658 	mov	a,_bp
   239A 24 FB              5659 	add	a,#0xfb
   239C F9                 5660 	mov	r1,a
   239D 86 F0              5661 	mov	b,@r0
   239F E7                 5662 	mov	a,@r1
                           5663 ;       Peephole 112.b  changed ljmp to sjmp
                           5664 ;       Peephole 199    optimized misc jump sequence
   23A0 B5 F0 2B           5665 	cjne    a,b,00102$
                           5666 ;00154$:
                           5667 ;       Peephole 200    removed redundant sjmp
   23A3                    5668 00155$:
                           5669 ;src/menu.c:1559: printf_fast("%d.",key_code);
                           5670 ;     genIpush
   23A3 C0 07              5671 	push	ar7
                           5672 ;     genCast
   23A5 AF 33              5673 	mov	r7,_key_code
   23A7 7A 00              5674 	mov	r2,#0x00
                           5675 ;     genIpush
   23A9 C0 05              5676 	push	ar5
   23AB C0 06              5677 	push	ar6
   23AD C0 07              5678 	push	ar7
   23AF C0 07              5679 	push	ar7
   23B1 C0 02              5680 	push	ar2
                           5681 ;     genIpush
   23B3 74 BA              5682 	mov	a,#__str_16
   23B5 C0 E0              5683 	push	acc
   23B7 74 4A              5684 	mov	a,#(__str_16 >> 8)
   23B9 C0 E0              5685 	push	acc
                           5686 ;     genCall
   23BB 12 72 21           5687 	lcall	_printf_fast
   23BE E5 81              5688 	mov	a,sp
   23C0 24 FC              5689 	add	a,#0xfc
   23C2 F5 81              5690 	mov	sp,a
   23C4 D0 07              5691 	pop	ar7
   23C6 D0 06              5692 	pop	ar6
   23C8 D0 05              5693 	pop	ar5
                           5694 ;     genIpop
   23CA D0 07              5695 	pop	ar7
                           5696 ;       Peephole 112.b  changed ljmp to sjmp
   23CC 80 29              5697 	sjmp    00103$
   23CE                    5698 00102$:
                           5699 ;src/menu.c:1563: printf_fast("%d", key_code);
                           5700 ;     genIpush
   23CE C0 07              5701 	push	ar7
                           5702 ;     genCast
   23D0 AA 33              5703 	mov	r2,_key_code
   23D2 7F 00              5704 	mov	r7,#0x00
                           5705 ;     genIpush
   23D4 C0 05              5706 	push	ar5
   23D6 C0 06              5707 	push	ar6
   23D8 C0 07              5708 	push	ar7
   23DA C0 02              5709 	push	ar2
   23DC C0 07              5710 	push	ar7
                           5711 ;     genIpush
   23DE 74 BE              5712 	mov	a,#__str_17
   23E0 C0 E0              5713 	push	acc
   23E2 74 4A              5714 	mov	a,#(__str_17 >> 8)
   23E4 C0 E0              5715 	push	acc
                           5716 ;     genCall
   23E6 12 72 21           5717 	lcall	_printf_fast
   23E9 E5 81              5718 	mov	a,sp
   23EB 24 FC              5719 	add	a,#0xfc
   23ED F5 81              5720 	mov	sp,a
   23EF D0 07              5721 	pop	ar7
   23F1 D0 06              5722 	pop	ar6
   23F3 D0 05              5723 	pop	ar5
                           5724 ;src/menu.c:1614: return result;
                           5725 ;     genIpop
   23F5 D0 07              5726 	pop	ar7
                           5727 ;src/menu.c:1563: printf_fast("%d", key_code);
   23F7                    5728 00103$:
                           5729 ;src/menu.c:1566: if (isBCD == false)
                           5730 ;     genIfx
   23F7 EE                 5731 	mov	a,r6
                           5732 ;     genIfxJump
                           5733 ;       Peephole 110    removed ljmp by inverse jump logic
   23F8 60 3F              5734 	jz      00105$
   23FA                    5735 00156$:
                           5736 ;src/menu.c:1568: result *= 10;
                           5737 ;     genIpush
   23FA C0 07              5738 	push	ar7
                           5739 ;     genAssign
   23FC E4                 5740 	clr	a
   23FD F5 43              5741 	mov	(__mulint_PARM_2 + 1),a
   23FF 75 42 0A           5742 	mov	__mulint_PARM_2,#0x0A
                           5743 ;     genCall
   2402 E5 40              5744 	mov	a,_bp
   2404 24 03              5745 	add	a,#0x03
   2406 F8                 5746 	mov	r0,a
   2407 86 82              5747 	mov	dpl,@r0
   2409 08                 5748 	inc	r0
   240A 86 83              5749 	mov	dph,@r0
   240C C0 05              5750 	push	ar5
   240E C0 06              5751 	push	ar6
   2410 12 70 A2           5752 	lcall	__mulint
   2413 AA 82              5753 	mov	r2,dpl
   2415 AF 83              5754 	mov	r7,dph
   2417 D0 06              5755 	pop	ar6
   2419 D0 05              5756 	pop	ar5
                           5757 ;     genAssign
   241B E5 40              5758 	mov	a,_bp
   241D 24 03              5759 	add	a,#0x03
   241F F8                 5760 	mov	r0,a
   2420 A6 02              5761 	mov	@r0,ar2
   2422 08                 5762 	inc	r0
   2423 A6 07              5763 	mov	@r0,ar7
                           5764 ;src/menu.c:1569: result += key_code;
                           5765 ;     genCast
   2425 AA 33              5766 	mov	r2,_key_code
   2427 7F 00              5767 	mov	r7,#0x00
                           5768 ;     genPlus
   2429 E5 40              5769 	mov	a,_bp
   242B 24 03              5770 	add	a,#0x03
   242D F8                 5771 	mov	r0,a
                           5772 ;       Peephole 236.g  used r2 instead of ar2
   242E EA                 5773 	mov     a,r2
   242F 26                 5774 	add	a,@r0
   2430 F6                 5775 	mov	@r0,a
                           5776 ;       Peephole 236.g  used r7 instead of ar7
   2431 EF                 5777 	mov     a,r7
   2432 08                 5778 	inc	r0
   2433 36                 5779 	addc	a,@r0
   2434 F6                 5780 	mov	@r0,a
                           5781 ;     genIpop
   2435 D0 07              5782 	pop	ar7
                           5783 ;       Peephole 112.b  changed ljmp to sjmp
   2437 80 26              5784 	sjmp    00106$
   2439                    5785 00105$:
                           5786 ;src/menu.c:1573: result <<= 4;
                           5787 ;     genLeftShift
                           5788 ;     genLeftShiftLiteral
   2439 E5 40              5789 	mov	a,_bp
   243B 24 03              5790 	add	a,#0x03
                           5791 ;     genlshTwo
                           5792 ;       Peephole 185    changed order of increment (acc incremented also!)
   243D 04                 5793 	inc     a
   243E F8                 5794 	mov     r0,a
   243F E6                 5795 	mov	a,@r0
   2440 18                 5796 	dec	r0
   2441 C4                 5797 	swap	a
   2442 54 F0              5798 	anl	a,#0xf0
   2444 C6                 5799 	xch	a,@r0
   2445 C4                 5800 	swap	a
   2446 C6                 5801 	xch	a,@r0
   2447 66                 5802 	xrl	a,@r0
   2448 C6                 5803 	xch	a,@r0
   2449 54 F0              5804 	anl	a,#0xf0
   244B C6                 5805 	xch	a,@r0
   244C 66                 5806 	xrl	a,@r0
   244D 08                 5807 	inc	r0
   244E F6                 5808 	mov	@r0,a
                           5809 ;src/menu.c:1574: result |= key_code;
                           5810 ;     genCast
   244F AA 33              5811 	mov	r2,_key_code
   2451 7B 00              5812 	mov	r3,#0x00
                           5813 ;     genOr
   2453 E5 40              5814 	mov	a,_bp
   2455 24 03              5815 	add	a,#0x03
   2457 F8                 5816 	mov	r0,a
   2458 EA                 5817 	mov	a,r2
   2459 46                 5818 	orl	a,@r0
   245A F6                 5819 	mov	@r0,a
   245B EB                 5820 	mov	a,r3
   245C 08                 5821 	inc	r0
   245D 46                 5822 	orl	a,@r0
   245E F6                 5823 	mov	@r0,a
   245F                    5824 00106$:
                           5825 ;src/menu.c:1577: count++;
                           5826 ;     genPlus
                           5827 ;       Peephole 212    reduced add sequence to inc
   245F A8 40              5828 	mov     r0,_bp
   2461 08                 5829 	inc     r0
                           5830 ;     genPlusIncr
   2462 06                 5831 	inc	@r0
   2463 02 25 21           5832 	ljmp	00115$
   2466                    5833 00114$:
                           5834 ;src/menu.c:1581: switch (key_code)
                           5835 ;     genCmpEq
   2466 E5 33              5836 	mov	a,_key_code
   2468 B4 13 03           5837 	cjne	a,#0x13,00157$
   246B 02 25 0C           5838 	ljmp	00111$
   246E                    5839 00157$:
                           5840 ;     genCmpEq
   246E E5 33              5841 	mov	a,_key_code
   2470 B4 14 02           5842 	cjne	a,#0x14,00158$
   2473 80 03              5843 	sjmp	00159$
   2475                    5844 00158$:
   2475 02 25 21           5845 	ljmp	00115$
   2478                    5846 00159$:
                           5847 ;src/menu.c:1584: for (j=0; j<=(size-count);j++)
                           5848 ;     genAssign
   2478 E5 40              5849 	mov	a,_bp
   247A 24 02              5850 	add	a,#0x02
   247C F8                 5851 	mov	r0,a
   247D 76 00              5852 	mov	@r0,#0x00
   247F                    5853 00125$:
                           5854 ;     genIpush
   247F C0 07              5855 	push	ar7
                           5856 ;     genCast
   2481 8D 03              5857 	mov	ar3,r5
   2483 7F 00              5858 	mov	r7,#0x00
                           5859 ;     genCast
                           5860 ;       Peephole 212    reduced add sequence to inc
   2485 A8 40              5861 	mov     r0,_bp
   2487 08                 5862 	inc     r0
   2488 86 02              5863 	mov	ar2,@r0
   248A 7C 00              5864 	mov	r4,#0x00
                           5865 ;     genMinus
   248C EB                 5866 	mov	a,r3
   248D C3                 5867 	clr	c
                           5868 ;       Peephole 236.l  used r2 instead of ar2
   248E 9A                 5869 	subb    a,r2
   248F FB                 5870 	mov	r3,a
   2490 EF                 5871 	mov	a,r7
                           5872 ;       Peephole 236.l  used r4 instead of ar4
   2491 9C                 5873 	subb    a,r4
   2492 FF                 5874 	mov	r7,a
                           5875 ;     genCast
   2493 E5 40              5876 	mov	a,_bp
   2495 24 02              5877 	add	a,#0x02
   2497 F8                 5878 	mov	r0,a
   2498 86 02              5879 	mov	ar2,@r0
   249A 7C 00              5880 	mov	r4,#0x00
                           5881 ;     genCmpGt
                           5882 ;     genCmp
   249C C3                 5883 	clr	c
   249D EB                 5884 	mov	a,r3
   249E 9A                 5885 	subb	a,r2
   249F EF                 5886 	mov	a,r7
   24A0 64 80              5887 	xrl	a,#0x80
   24A2 8C F0              5888 	mov	b,r4
   24A4 63 F0 80           5889 	xrl	b,#0x80
   24A7 95 F0              5890 	subb	a,b
   24A9 E4                 5891 	clr	a
   24AA 33                 5892 	rlc	a
                           5893 ;     genIpop
   24AB D0 07              5894 	pop	ar7
                           5895 ;     genIfx
                           5896 ;     genIfxJump
                           5897 ;       Peephole 109    removed ljmp by inverse jump logic
   24AD 70 51              5898 	jnz     00128$
   24AF                    5899 00160$:
                           5900 ;src/menu.c:1586: if (isBCD == false)
                           5901 ;     genIfx
   24AF EE                 5902 	mov	a,r6
                           5903 ;     genIfxJump
                           5904 ;       Peephole 110    removed ljmp by inverse jump logic
   24B0 60 2F              5905 	jz      00108$
   24B2                    5906 00161$:
                           5907 ;src/menu.c:1588: result *= 10;
                           5908 ;     genAssign
   24B2 E4                 5909 	clr	a
   24B3 F5 43              5910 	mov	(__mulint_PARM_2 + 1),a
   24B5 75 42 0A           5911 	mov	__mulint_PARM_2,#0x0A
                           5912 ;     genCall
   24B8 E5 40              5913 	mov	a,_bp
   24BA 24 03              5914 	add	a,#0x03
   24BC F8                 5915 	mov	r0,a
   24BD 86 82              5916 	mov	dpl,@r0
   24BF 08                 5917 	inc	r0
   24C0 86 83              5918 	mov	dph,@r0
   24C2 C0 05              5919 	push	ar5
   24C4 C0 06              5920 	push	ar6
   24C6 C0 07              5921 	push	ar7
   24C8 12 70 A2           5922 	lcall	__mulint
   24CB AA 82              5923 	mov	r2,dpl
   24CD AB 83              5924 	mov	r3,dph
   24CF D0 07              5925 	pop	ar7
   24D1 D0 06              5926 	pop	ar6
   24D3 D0 05              5927 	pop	ar5
                           5928 ;     genAssign
   24D5 E5 40              5929 	mov	a,_bp
   24D7 24 03              5930 	add	a,#0x03
   24D9 F8                 5931 	mov	r0,a
   24DA A6 02              5932 	mov	@r0,ar2
   24DC 08                 5933 	inc	r0
   24DD A6 03              5934 	mov	@r0,ar3
                           5935 ;       Peephole 112.b  changed ljmp to sjmp
   24DF 80 16              5936 	sjmp    00127$
   24E1                    5937 00108$:
                           5938 ;src/menu.c:1592: result <<= 4;
                           5939 ;     genLeftShift
                           5940 ;     genLeftShiftLiteral
   24E1 E5 40              5941 	mov	a,_bp
   24E3 24 03              5942 	add	a,#0x03
                           5943 ;     genlshTwo
                           5944 ;       Peephole 185    changed order of increment (acc incremented also!)
   24E5 04                 5945 	inc     a
   24E6 F8                 5946 	mov     r0,a
   24E7 E6                 5947 	mov	a,@r0
   24E8 18                 5948 	dec	r0
   24E9 C4                 5949 	swap	a
   24EA 54 F0              5950 	anl	a,#0xf0
   24EC C6                 5951 	xch	a,@r0
   24ED C4                 5952 	swap	a
   24EE C6                 5953 	xch	a,@r0
   24EF 66                 5954 	xrl	a,@r0
   24F0 C6                 5955 	xch	a,@r0
   24F1 54 F0              5956 	anl	a,#0xf0
   24F3 C6                 5957 	xch	a,@r0
   24F4 66                 5958 	xrl	a,@r0
   24F5 08                 5959 	inc	r0
   24F6 F6                 5960 	mov	@r0,a
   24F7                    5961 00127$:
                           5962 ;src/menu.c:1584: for (j=0; j<=(size-count);j++)
                           5963 ;     genPlus
   24F7 E5 40              5964 	mov	a,_bp
   24F9 24 02              5965 	add	a,#0x02
   24FB F8                 5966 	mov	r0,a
                           5967 ;     genPlusIncr
   24FC 06                 5968 	inc	@r0
   24FD 02 24 7F           5969 	ljmp	00125$
   2500                    5970 00128$:
                           5971 ;src/menu.c:1595: count = size+1;
                           5972 ;     genAssign
   2500 E5 40              5973 	mov	a,_bp
   2502 24 05              5974 	add	a,#0x05
   2504 F8                 5975 	mov	r0,a
                           5976 ;       Peephole 212    reduced add sequence to inc
   2505 A9 40              5977 	mov     r1,_bp
   2507 09                 5978 	inc     r1
   2508 E6                 5979 	mov	a,@r0
   2509 F7                 5980 	mov	@r1,a
                           5981 ;src/menu.c:1596: break;
                           5982 ;src/menu.c:1599: count = size+1;
                           5983 ;       Peephole 112.b  changed ljmp to sjmp
   250A 80 15              5984 	sjmp    00115$
   250C                    5985 00111$:
                           5986 ;     genAssign
                           5987 ;       Peephole 212    reduced add sequence to inc
   250C A8 40              5988 	mov     r0,_bp
   250E 08                 5989 	inc     r0
   250F A6 07              5990 	mov	@r0,ar7
                           5991 ;src/menu.c:1600: result = value;
                           5992 ;     genAssign
   2511 E5 40              5993 	mov	a,_bp
   2513 24 FC              5994 	add	a,#0xfc
   2515 F8                 5995 	mov	r0,a
   2516 E5 40              5996 	mov	a,_bp
   2518 24 03              5997 	add	a,#0x03
   251A F9                 5998 	mov	r1,a
   251B E6                 5999 	mov	a,@r0
   251C F7                 6000 	mov	@r1,a
   251D 08                 6001 	inc	r0
   251E 09                 6002 	inc	r1
   251F E6                 6003 	mov	a,@r0
   2520 F7                 6004 	mov	@r1,a
                           6005 ;src/menu.c:1602: }
   2521                    6006 00115$:
                           6007 ;src/menu.c:1604: keypad_purge_buffer();
                           6008 ;     genCall
   2521 C0 05              6009 	push	ar5
   2523 C0 06              6010 	push	ar6
   2525 C0 07              6011 	push	ar7
   2527 12 02 B0           6012 	lcall	_keypad_purge_buffer
   252A D0 07              6013 	pop	ar7
   252C D0 06              6014 	pop	ar6
   252E D0 05              6015 	pop	ar5
   2530 02 23 2B           6016 	ljmp	00122$
   2533                    6017 00120$:
                           6018 ;src/menu.c:1609: result = value;
                           6019 ;     genAssign
   2533 E5 40              6020 	mov	a,_bp
   2535 24 FC              6021 	add	a,#0xfc
   2537 F8                 6022 	mov	r0,a
   2538 E5 40              6023 	mov	a,_bp
   253A 24 03              6024 	add	a,#0x03
   253C F9                 6025 	mov	r1,a
   253D E6                 6026 	mov	a,@r0
   253E F7                 6027 	mov	@r1,a
   253F 08                 6028 	inc	r0
   2540 09                 6029 	inc	r1
   2541 E6                 6030 	mov	a,@r0
   2542 F7                 6031 	mov	@r1,a
                           6032 ;src/menu.c:1610: count = size+1;
                           6033 ;     genAssign
   2543 E5 40              6034 	mov	a,_bp
   2545 24 06              6035 	add	a,#0x06
   2547 F8                 6036 	mov	r0,a
                           6037 ;       Peephole 212    reduced add sequence to inc
   2548 A9 40              6038 	mov     r1,_bp
   254A 09                 6039 	inc     r1
   254B E6                 6040 	mov	a,@r0
   254C F7                 6041 	mov	@r1,a
   254D 02 23 2B           6042 	ljmp	00122$
   2550                    6043 00124$:
                           6044 ;src/menu.c:1614: return result;
                           6045 ;     genRet
   2550 E5 40              6046 	mov	a,_bp
   2552 24 03              6047 	add	a,#0x03
   2554 F8                 6048 	mov	r0,a
   2555 86 82              6049 	mov	dpl,@r0
   2557 08                 6050 	inc	r0
   2558 86 83              6051 	mov	dph,@r0
   255A                    6052 00129$:
   255A 85 40 81           6053 	mov	sp,_bp
   255D D0 40              6054 	pop	_bp
   255F 22                 6055 	ret
                           6056 ;------------------------------------------------------------
                           6057 ;Allocation info for local variables in function 'zone_workloop'
                           6058 ;------------------------------------------------------------
                           6059 ;zone                      Allocated to stack - offset 1
                           6060 ;result                    Allocated to stack - offset 2
                           6061 ;mins                      Allocated to stack - offset 4
                           6062 ;hours                     Allocated to stack - offset 5
                           6063 ;flash                     Allocated to registers r2 r3 r4 
                           6064 ;xram                      Allocated to stack - offset 6
                           6065 ;count                     Allocated to stack - offset 9
                           6066 ;display                   Allocated to stack - offset 10
                           6067 ;sloc0                     Allocated to stack - offset 16
                           6068 ;sloc1                     Allocated to stack - offset 13
                           6069 ;sloc2                     Allocated to stack - offset 16
                           6070 ;------------------------------------------------------------
                           6071 ;src/menu.c:1617: void zone_workloop(const unsigned char zone)
                           6072 ;	-----------------------------------------
                           6073 ;	 function zone_workloop
                           6074 ;	-----------------------------------------
   2560                    6075 _zone_workloop:
   2560 C0 40              6076 	push	_bp
   2562 85 81 40           6077 	mov	_bp,sp
   2565 E5 81              6078 	mov	a,sp
   2567 24 11              6079 	add	a,#0x11
   2569 F5 81              6080 	mov	sp,a
                           6081 ;     genReceive
   256B C0 E0              6082 	push	acc
                           6083 ;       Peephole 212    reduced add sequence to inc
   256D A8 40              6084 	mov     r0,_bp
   256F 08                 6085 	inc     r0
   2570 D0 E0              6086 	pop	acc
   2572 A6 82              6087 	mov	@r0,dpl
                           6088 ;src/menu.c:1620: unsigned char mins = 0;
                           6089 ;     genAssign
   2574 E5 40              6090 	mov	a,_bp
   2576 24 04              6091 	add	a,#0x04
   2578 F8                 6092 	mov	r0,a
   2579 76 00              6093 	mov	@r0,#0x00
                           6094 ;src/menu.c:1621: unsigned char hours = 0;
                           6095 ;     genAssign
   257B E5 40              6096 	mov	a,_bp
   257D 24 05              6097 	add	a,#0x05
   257F F8                 6098 	mov	r0,a
                           6099 ;src/menu.c:1629: BLINKING_OFF;
                           6100 ;     genAssign
                           6101 ;src/menu.c:1631: display = menu[current_display_state].item[current_position].display;
                           6102 ;     genMult
                           6103 ;     genMultOneByte
                           6104 ;       Peephole 3.c    changed mov to clr
   2580 E4                 6105 	clr     a
   2581 F6                 6106 	mov     @r0,a
   2582 F5 30              6107 	mov     _blinking,a
   2584 E5 31              6108 	mov     a,_current_display_state
   2586 75 F0 3C           6109 	mov	b,#0x3C
   2589 A4                 6110 	mul	ab
                           6111 ;     genPlus
   258A 24 0E              6112 	add	a,#_menu
   258C FD                 6113 	mov	r5,a
   258D E5 F0              6114 	mov	a,b
   258F 34 3C              6115 	addc	a,#(_menu >> 8)
   2591 FE                 6116 	mov	r6,a
                           6117 ;     genPlus
                           6118 ;     genPlusIncr
   2592 74 04              6119 	mov	a,#0x04
                           6120 ;       Peephole 236.a  used r5 instead of ar5
   2594 2D                 6121 	add     a,r5
   2595 FD                 6122 	mov	r5,a
                           6123 ;       Peephole 181    changed mov to clr
   2596 E4                 6124 	clr     a
                           6125 ;       Peephole 236.b  used r6 instead of ar6
   2597 3E                 6126 	addc    a,r6
   2598 FE                 6127 	mov	r6,a
                           6128 ;     genMult
                           6129 ;     genMultOneByte
   2599 E5 32              6130 	mov	a,_current_position
   259B 75 F0 08           6131 	mov	b,#0x08
   259E A4                 6132 	mul	ab
                           6133 ;     genPlus
                           6134 ;       Peephole 236.a  used r5 instead of ar5
   259F 2D                 6135 	add     a,r5
   25A0 FD                 6136 	mov	r5,a
   25A1 E5 F0              6137 	mov	a,b
                           6138 ;       Peephole 236.b  used r6 instead of ar6
   25A3 3E                 6139 	addc    a,r6
   25A4 FE                 6140 	mov	r6,a
                           6141 ;     genPlus
   25A5 74 05              6142 	mov	a,#0x05
                           6143 ;       Peephole 236.a  used r5 instead of ar5
   25A7 2D                 6144 	add     a,r5
   25A8 F5 82              6145 	mov	dpl,a
                           6146 ;       Peephole 181    changed mov to clr
   25AA E4                 6147 	clr     a
                           6148 ;       Peephole 236.b  used r6 instead of ar6
   25AB 3E                 6149 	addc    a,r6
   25AC F5 83              6150 	mov	dph,a
                           6151 ;     genPointerGet
                           6152 ;     genCodePointerGet
                           6153 ;       Peephole 181    changed mov to clr
   25AE E4                 6154 	clr     a
   25AF 93                 6155 	movc	a,@a+dptr
   25B0 FD                 6156 	mov	r5,a
   25B1 74 01              6157 	mov	a,#0x01
   25B3 93                 6158 	movc	a,@a+dptr
   25B4 FE                 6159 	mov	r6,a
   25B5 74 02              6160 	mov	a,#0x02
   25B7 93                 6161 	movc	a,@a+dptr
   25B8 FF                 6162 	mov	r7,a
                           6163 ;     genAssign
   25B9 E5 40              6164 	mov	a,_bp
   25BB 24 0A              6165 	add	a,#0x0a
   25BD F8                 6166 	mov	r0,a
   25BE A6 05              6167 	mov	@r0,ar5
   25C0 08                 6168 	inc	r0
   25C1 A6 06              6169 	mov	@r0,ar6
   25C3 08                 6170 	inc	r0
   25C4 A6 07              6171 	mov	@r0,ar7
                           6172 ;src/menu.c:1632: lcd_cursor_on();
                           6173 ;     genCall
   25C6 12 0C 2E           6174 	lcall	_lcd_cursor_on
                           6175 ;src/menu.c:1634: lcd_goto_xy(display->x, 0);
                           6176 ;     genPointerGet
                           6177 ;     genGenPointerGet
   25C9 E5 40              6178 	mov	a,_bp
   25CB 24 0A              6179 	add	a,#0x0a
   25CD F8                 6180 	mov	r0,a
   25CE 86 82              6181 	mov	dpl,@r0
   25D0 08                 6182 	inc	r0
   25D1 86 83              6183 	mov	dph,@r0
   25D3 08                 6184 	inc	r0
   25D4 86 F0              6185 	mov	b,@r0
   25D6 12 71 F5           6186 	lcall	__gptrget
   25D9 FC                 6187 	mov	r4,a
                           6188 ;     genIpush
                           6189 ;       Peephole 181    changed mov to clr
   25DA E4                 6190 	clr     a
   25DB C0 E0              6191 	push	acc
                           6192 ;     genCall
   25DD 8C 82              6193 	mov	dpl,r4
   25DF 12 0A CD           6194 	lcall	_lcd_goto_xy
   25E2 15 81              6195 	dec	sp
                           6196 ;src/menu.c:1635: local_gmtime(&system_data.zone_settings[zone].start_time);
                           6197 ;     genMult
                           6198 ;       Peephole 212    reduced add sequence to inc
   25E4 A8 40              6199 	mov     r0,_bp
   25E6 08                 6200 	inc     r0
                           6201 ;     genMultOneByte
   25E7 E6                 6202 	mov	a,@r0
   25E8 75 F0 0A           6203 	mov	b,#0x0A
   25EB A4                 6204 	mul	ab
   25EC FC                 6205 	mov	r4,a
   25ED AB F0              6206 	mov	r3,b
                           6207 ;     genPlus
                           6208 ;       Peephole 236.g  used r4 instead of ar4
   25EF EC                 6209 	mov     a,r4
   25F0 24 0D              6210 	add	a,#_system_data
   25F2 FA                 6211 	mov	r2,a
                           6212 ;       Peephole 236.g  used r3 instead of ar3
   25F3 EB                 6213 	mov     a,r3
   25F4 34 00              6214 	addc	a,#(_system_data >> 8)
   25F6 FD                 6215 	mov	r5,a
                           6216 ;     genPlus
                           6217 ;     genPlusIncr
   25F7 74 02              6218 	mov	a,#0x02
                           6219 ;       Peephole 236.a  used r2 instead of ar2
   25F9 2A                 6220 	add     a,r2
   25FA FA                 6221 	mov	r2,a
                           6222 ;       Peephole 181    changed mov to clr
   25FB E4                 6223 	clr     a
                           6224 ;       Peephole 236.b  used r5 instead of ar5
   25FC 3D                 6225 	addc    a,r5
   25FD FD                 6226 	mov	r5,a
                           6227 ;     genCast
   25FE 7E 01              6228 	mov	r6,#0x1
                           6229 ;     genCall
   2600 8A 82              6230 	mov	dpl,r2
   2602 8D 83              6231 	mov	dph,r5
   2604 8E F0              6232 	mov	b,r6
   2606 C0 03              6233 	push	ar3
   2608 C0 04              6234 	push	ar4
   260A 12 65 34           6235 	lcall	_local_gmtime
   260D D0 04              6236 	pop	ar4
   260F D0 03              6237 	pop	ar3
                           6238 ;src/menu.c:1638: (unsigned int)system_time.tm_min);
                           6239 ;     genPointerGet
                           6240 ;     genFarPointerGet
   2611 90 01 82           6241 	mov	dptr,#(_system_time + 0x0001)
   2614 E0                 6242 	movx	a,@dptr
   2615 FA                 6243 	mov	r2,a
                           6244 ;     genCast
   2616 7D 00              6245 	mov	r5,#0x00
                           6246 ;src/menu.c:1637: (unsigned int)system_time.tm_hour,
                           6247 ;     genPointerGet
                           6248 ;     genFarPointerGet
   2618 90 01 83           6249 	mov	dptr,#(_system_time + 0x0002)
   261B E0                 6250 	movx	a,@dptr
   261C FE                 6251 	mov	r6,a
                           6252 ;     genCast
   261D 7F 00              6253 	mov	r7,#0x00
                           6254 ;src/menu.c:1636: printf_fast("%02u:%02u", 
                           6255 ;     genIpush
   261F C0 03              6256 	push	ar3
   2621 C0 04              6257 	push	ar4
   2623 C0 02              6258 	push	ar2
   2625 C0 05              6259 	push	ar5
                           6260 ;     genIpush
   2627 C0 06              6261 	push	ar6
   2629 C0 07              6262 	push	ar7
                           6263 ;     genIpush
   262B 74 22              6264 	mov	a,#__str_5
   262D C0 E0              6265 	push	acc
   262F 74 4A              6266 	mov	a,#(__str_5 >> 8)
   2631 C0 E0              6267 	push	acc
                           6268 ;     genCall
   2633 12 72 21           6269 	lcall	_printf_fast
   2636 E5 81              6270 	mov	a,sp
   2638 24 FA              6271 	add	a,#0xfa
   263A F5 81              6272 	mov	sp,a
   263C D0 04              6273 	pop	ar4
   263E D0 03              6274 	pop	ar3
                           6275 ;src/menu.c:1640: printf_fast("-");
                           6276 ;     genIpush
   2640 C0 03              6277 	push	ar3
   2642 C0 04              6278 	push	ar4
   2644 74 2C              6279 	mov	a,#__str_6
   2646 C0 E0              6280 	push	acc
   2648 74 4A              6281 	mov	a,#(__str_6 >> 8)
   264A C0 E0              6282 	push	acc
                           6283 ;     genCall
   264C 12 72 21           6284 	lcall	_printf_fast
   264F 15 81              6285 	dec	sp
   2651 15 81              6286 	dec	sp
   2653 D0 04              6287 	pop	ar4
   2655 D0 03              6288 	pop	ar3
                           6289 ;src/menu.c:1642: local_gmtime(&system_data.zone_settings[zone].stop_time);         
                           6290 ;     genPlus
                           6291 ;       Peephole 236.g  used r4 instead of ar4
   2657 EC                 6292 	mov     a,r4
   2658 24 0D              6293 	add	a,#_system_data
   265A FA                 6294 	mov	r2,a
                           6295 ;       Peephole 236.g  used r3 instead of ar3
   265B EB                 6296 	mov     a,r3
   265C 34 00              6297 	addc	a,#(_system_data >> 8)
   265E FD                 6298 	mov	r5,a
                           6299 ;     genPlus
   265F 74 06              6300 	mov	a,#0x06
                           6301 ;       Peephole 236.a  used r2 instead of ar2
   2661 2A                 6302 	add     a,r2
   2662 FA                 6303 	mov	r2,a
                           6304 ;       Peephole 181    changed mov to clr
   2663 E4                 6305 	clr     a
                           6306 ;       Peephole 236.b  used r5 instead of ar5
   2664 3D                 6307 	addc    a,r5
   2665 FD                 6308 	mov	r5,a
                           6309 ;     genCast
   2666 7E 01              6310 	mov	r6,#0x1
                           6311 ;     genCall
   2668 8A 82              6312 	mov	dpl,r2
   266A 8D 83              6313 	mov	dph,r5
   266C 8E F0              6314 	mov	b,r6
   266E C0 03              6315 	push	ar3
   2670 C0 04              6316 	push	ar4
   2672 12 65 34           6317 	lcall	_local_gmtime
   2675 D0 04              6318 	pop	ar4
   2677 D0 03              6319 	pop	ar3
                           6320 ;src/menu.c:1645: (unsigned int)system_time.tm_min);
                           6321 ;     genPointerGet
                           6322 ;     genFarPointerGet
   2679 90 01 82           6323 	mov	dptr,#(_system_time + 0x0001)
   267C E0                 6324 	movx	a,@dptr
   267D FA                 6325 	mov	r2,a
                           6326 ;     genCast
   267E 7D 00              6327 	mov	r5,#0x00
                           6328 ;src/menu.c:1644: (unsigned int)system_time.tm_hour,
                           6329 ;     genPointerGet
                           6330 ;     genFarPointerGet
   2680 90 01 83           6331 	mov	dptr,#(_system_time + 0x0002)
   2683 E0                 6332 	movx	a,@dptr
   2684 FE                 6333 	mov	r6,a
                           6334 ;     genCast
   2685 7F 00              6335 	mov	r7,#0x00
                           6336 ;src/menu.c:1643: printf_fast("%02u:%02u", 
                           6337 ;     genIpush
   2687 C0 03              6338 	push	ar3
   2689 C0 04              6339 	push	ar4
   268B C0 02              6340 	push	ar2
   268D C0 05              6341 	push	ar5
                           6342 ;     genIpush
   268F C0 06              6343 	push	ar6
   2691 C0 07              6344 	push	ar7
                           6345 ;     genIpush
   2693 74 22              6346 	mov	a,#__str_5
   2695 C0 E0              6347 	push	acc
   2697 74 4A              6348 	mov	a,#(__str_5 >> 8)
   2699 C0 E0              6349 	push	acc
                           6350 ;     genCall
   269B 12 72 21           6351 	lcall	_printf_fast
   269E E5 81              6352 	mov	a,sp
   26A0 24 FA              6353 	add	a,#0xfa
   26A2 F5 81              6354 	mov	sp,a
   26A4 D0 04              6355 	pop	ar4
   26A6 D0 03              6356 	pop	ar3
                           6357 ;src/menu.c:1647: lcd_goto_xy(display->x+21, 0);
                           6358 ;     genPointerGet
                           6359 ;     genGenPointerGet
   26A8 E5 40              6360 	mov	a,_bp
   26AA 24 0A              6361 	add	a,#0x0a
   26AC F8                 6362 	mov	r0,a
   26AD 86 82              6363 	mov	dpl,@r0
   26AF 08                 6364 	inc	r0
   26B0 86 83              6365 	mov	dph,@r0
   26B2 08                 6366 	inc	r0
   26B3 86 F0              6367 	mov	b,@r0
   26B5 12 71 F5           6368 	lcall	__gptrget
   26B8 FA                 6369 	mov	r2,a
                           6370 ;     genPlus
   26B9 74 15              6371 	mov	a,#0x15
                           6372 ;       Peephole 236.a  used r2 instead of ar2
   26BB 2A                 6373 	add     a,r2
   26BC F5 82              6374 	mov	dpl,a
                           6375 ;     genIpush
   26BE C0 03              6376 	push	ar3
   26C0 C0 04              6377 	push	ar4
                           6378 ;       Peephole 181    changed mov to clr
   26C2 E4                 6379 	clr     a
   26C3 C0 E0              6380 	push	acc
                           6381 ;     genCall
   26C5 12 0A CD           6382 	lcall	_lcd_goto_xy
   26C8 15 81              6383 	dec	sp
   26CA D0 04              6384 	pop	ar4
   26CC D0 03              6385 	pop	ar3
                           6386 ;src/menu.c:1648: printf_fast("%02u",system_data.zone_settings[zone].temperature);
                           6387 ;     genPlus
                           6388 ;       Peephole 236.g  used r4 instead of ar4
   26CE EC                 6389 	mov     a,r4
   26CF 24 0D              6390 	add	a,#_system_data
   26D1 F5 82              6391 	mov	dpl,a
                           6392 ;       Peephole 236.g  used r3 instead of ar3
   26D3 EB                 6393 	mov     a,r3
   26D4 34 00              6394 	addc	a,#(_system_data >> 8)
   26D6 F5 83              6395 	mov	dph,a
                           6396 ;     genPointerGet
                           6397 ;     genFarPointerGet
   26D8 E0                 6398 	movx	a,@dptr
   26D9 FA                 6399 	mov	r2,a
   26DA A3                 6400 	inc	dptr
   26DB E0                 6401 	movx	a,@dptr
   26DC FD                 6402 	mov	r5,a
                           6403 ;     genIpush
   26DD C0 03              6404 	push	ar3
   26DF C0 04              6405 	push	ar4
   26E1 C0 02              6406 	push	ar2
   26E3 C0 05              6407 	push	ar5
                           6408 ;     genIpush
   26E5 74 2E              6409 	mov	a,#__str_7
   26E7 C0 E0              6410 	push	acc
   26E9 74 4A              6411 	mov	a,#(__str_7 >> 8)
   26EB C0 E0              6412 	push	acc
                           6413 ;     genCall
   26ED 12 72 21           6414 	lcall	_printf_fast
   26F0 E5 81              6415 	mov	a,sp
   26F2 24 FC              6416 	add	a,#0xfc
   26F4 F5 81              6417 	mov	sp,a
   26F6 D0 04              6418 	pop	ar4
   26F8 D0 03              6419 	pop	ar3
                           6420 ;src/menu.c:1650: lcd_goto_xy(display->x, display->y+1);
                           6421 ;     genPlus
   26FA E5 40              6422 	mov	a,_bp
   26FC 24 0A              6423 	add	a,#0x0a
   26FE F8                 6424 	mov	r0,a
   26FF E5 40              6425 	mov	a,_bp
   2701 24 0D              6426 	add	a,#0x0d
   2703 F9                 6427 	mov	r1,a
                           6428 ;     genPlusIncr
   2704 74 01              6429 	mov	a,#0x01
   2706 26                 6430 	add	a,@r0
   2707 F7                 6431 	mov	@r1,a
                           6432 ;       Peephole 181    changed mov to clr
   2708 E4                 6433 	clr     a
   2709 08                 6434 	inc	r0
   270A 36                 6435 	addc	a,@r0
   270B 09                 6436 	inc	r1
   270C F7                 6437 	mov	@r1,a
   270D 08                 6438 	inc	r0
   270E 09                 6439 	inc	r1
   270F E6                 6440 	mov	a,@r0
   2710 F7                 6441 	mov	@r1,a
                           6442 ;     genPointerGet
                           6443 ;     genGenPointerGet
   2711 E5 40              6444 	mov	a,_bp
   2713 24 0D              6445 	add	a,#0x0d
   2715 F8                 6446 	mov	r0,a
   2716 86 82              6447 	mov	dpl,@r0
   2718 08                 6448 	inc	r0
   2719 86 83              6449 	mov	dph,@r0
   271B 08                 6450 	inc	r0
   271C 86 F0              6451 	mov	b,@r0
   271E 12 71 F5           6452 	lcall	__gptrget
   2721 FF                 6453 	mov	r7,a
                           6454 ;     genPlus
                           6455 ;     genPlusIncr
   2722 74 01              6456 	mov	a,#0x01
                           6457 ;       Peephole 236.a  used r7 instead of ar7
   2724 2F                 6458 	add     a,r7
   2725 FA                 6459 	mov	r2,a
                           6460 ;     genPointerGet
                           6461 ;     genGenPointerGet
   2726 E5 40              6462 	mov	a,_bp
   2728 24 0A              6463 	add	a,#0x0a
   272A F8                 6464 	mov	r0,a
   272B 86 82              6465 	mov	dpl,@r0
   272D 08                 6466 	inc	r0
   272E 86 83              6467 	mov	dph,@r0
   2730 08                 6468 	inc	r0
   2731 86 F0              6469 	mov	b,@r0
   2733 12 71 F5           6470 	lcall	__gptrget
   2736 FF                 6471 	mov	r7,a
                           6472 ;     genIpush
   2737 C0 03              6473 	push	ar3
   2739 C0 04              6474 	push	ar4
   273B C0 02              6475 	push	ar2
                           6476 ;     genCall
   273D 8F 82              6477 	mov	dpl,r7
   273F 12 0A CD           6478 	lcall	_lcd_goto_xy
   2742 15 81              6479 	dec	sp
   2744 D0 04              6480 	pop	ar4
   2746 D0 03              6481 	pop	ar3
                           6482 ;src/menu.c:1651: result = read_keyboard_data_workloop(2,0x99,0,false);
                           6483 ;     genIpush
   2748 C0 03              6484 	push	ar3
   274A C0 04              6485 	push	ar4
                           6486 ;       Peephole 181    changed mov to clr
   274C E4                 6487 	clr     a
   274D C0 E0              6488 	push	acc
                           6489 ;     genIpush
                           6490 ;       Peephole 181    changed mov to clr
   274F E4                 6491 	clr     a
   2750 C0 E0              6492 	push	acc
                           6493 ;     genIpush
   2752 74 99              6494 	mov	a,#0x99
   2754 C0 E0              6495 	push	acc
                           6496 ;       Peephole 181    changed mov to clr
   2756 E4                 6497 	clr     a
   2757 C0 E0              6498 	push	acc
                           6499 ;     genCall
   2759 75 82 02           6500 	mov	dpl,#0x02
   275C 12 22 F3           6501 	lcall	_read_keyboard_data_workloop
   275F AA 82              6502 	mov	r2,dpl
   2761 AD 83              6503 	mov	r5,dph
   2763 E5 81              6504 	mov	a,sp
   2765 24 FC              6505 	add	a,#0xfc
   2767 F5 81              6506 	mov	sp,a
   2769 D0 04              6507 	pop	ar4
   276B D0 03              6508 	pop	ar3
                           6509 ;     genAssign
   276D E5 40              6510 	mov	a,_bp
   276F 24 02              6511 	add	a,#0x02
   2771 F8                 6512 	mov	r0,a
   2772 A6 02              6513 	mov	@r0,ar2
   2774 08                 6514 	inc	r0
   2775 A6 05              6515 	mov	@r0,ar5
                           6516 ;src/menu.c:1652: if (result != 0x99)
                           6517 ;     genCmpEq
   2777 E5 40              6518 	mov	a,_bp
   2779 24 02              6519 	add	a,#0x02
   277B F8                 6520 	mov	r0,a
   277C B6 99 06           6521 	cjne	@r0,#0x99,00143$
   277F 08                 6522 	inc	r0
   2780 B6 00 02           6523 	cjne	@r0,#0x00,00143$
                           6524 ;       Peephole 112.b  changed ljmp to sjmp
   2783 80 20              6525 	sjmp    00104$
   2785                    6526 00143$:
                           6527 ;src/menu.c:1654: if (result <= 0x23)
                           6528 ;     genCmpGt
   2785 E5 40              6529 	mov	a,_bp
   2787 24 02              6530 	add	a,#0x02
   2789 F8                 6531 	mov	r0,a
                           6532 ;     genCmp
   278A C3                 6533 	clr	c
   278B 74 23              6534 	mov	a,#0x23
   278D 96                 6535 	subb	a,@r0
                           6536 ;       Peephole 181    changed mov to clr
   278E E4                 6537 	clr     a
   278F 08                 6538 	inc	r0
   2790 96                 6539 	subb	a,@r0
                           6540 ;     genIfxJump
   2791 50 03              6541 	jnc	00144$
   2793 02 28 33           6542 	ljmp	00105$
   2796                    6543 00144$:
                           6544 ;src/menu.c:1656: hours = (unsigned char)result&0xff;
                           6545 ;     genCast
   2796 E5 40              6546 	mov	a,_bp
   2798 24 02              6547 	add	a,#0x02
   279A F8                 6548 	mov	r0,a
   279B E5 40              6549 	mov	a,_bp
   279D 24 05              6550 	add	a,#0x05
   279F F9                 6551 	mov	r1,a
   27A0 E6                 6552 	mov	a,@r0
   27A1 F7                 6553 	mov	@r1,a
   27A2 02 28 33           6554 	ljmp	00105$
   27A5                    6555 00104$:
                           6556 ;src/menu.c:1661: lcd_goto_xy(display->x, display->y+1);
                           6557 ;     genPointerGet
                           6558 ;     genGenPointerGet
   27A5 E5 40              6559 	mov	a,_bp
   27A7 24 0D              6560 	add	a,#0x0d
   27A9 F8                 6561 	mov	r0,a
   27AA 86 82              6562 	mov	dpl,@r0
   27AC 08                 6563 	inc	r0
   27AD 86 83              6564 	mov	dph,@r0
   27AF 08                 6565 	inc	r0
   27B0 86 F0              6566 	mov	b,@r0
   27B2 12 71 F5           6567 	lcall	__gptrget
                           6568 ;     genPlus
                           6569 ;     genPlusIncr
                           6570 ;       Peephole 185    changed order of increment (acc incremented also!)
   27B5 04                 6571 	inc     a
   27B6 FD                 6572 	mov     r5,a
                           6573 ;     genPointerGet
                           6574 ;     genGenPointerGet
   27B7 E5 40              6575 	mov	a,_bp
   27B9 24 0A              6576 	add	a,#0x0a
   27BB F8                 6577 	mov	r0,a
   27BC 86 82              6578 	mov	dpl,@r0
   27BE 08                 6579 	inc	r0
   27BF 86 83              6580 	mov	dph,@r0
   27C1 08                 6581 	inc	r0
   27C2 86 F0              6582 	mov	b,@r0
   27C4 12 71 F5           6583 	lcall	__gptrget
   27C7 FE                 6584 	mov	r6,a
                           6585 ;     genIpush
   27C8 C0 03              6586 	push	ar3
   27CA C0 04              6587 	push	ar4
   27CC C0 05              6588 	push	ar5
                           6589 ;     genCall
   27CE 8E 82              6590 	mov	dpl,r6
   27D0 12 0A CD           6591 	lcall	_lcd_goto_xy
   27D3 15 81              6592 	dec	sp
   27D5 D0 04              6593 	pop	ar4
   27D7 D0 03              6594 	pop	ar3
                           6595 ;src/menu.c:1662: local_gmtime(&system_data.zone_settings[zone].start_time);
                           6596 ;     genPlus
                           6597 ;       Peephole 236.g  used r4 instead of ar4
   27D9 EC                 6598 	mov     a,r4
   27DA 24 0D              6599 	add	a,#_system_data
   27DC FD                 6600 	mov	r5,a
                           6601 ;       Peephole 236.g  used r3 instead of ar3
   27DD EB                 6602 	mov     a,r3
   27DE 34 00              6603 	addc	a,#(_system_data >> 8)
   27E0 FE                 6604 	mov	r6,a
                           6605 ;     genPlus
                           6606 ;     genPlusIncr
   27E1 74 02              6607 	mov	a,#0x02
                           6608 ;       Peephole 236.a  used r5 instead of ar5
   27E3 2D                 6609 	add     a,r5
   27E4 FD                 6610 	mov	r5,a
                           6611 ;       Peephole 181    changed mov to clr
   27E5 E4                 6612 	clr     a
                           6613 ;       Peephole 236.b  used r6 instead of ar6
   27E6 3E                 6614 	addc    a,r6
   27E7 FE                 6615 	mov	r6,a
                           6616 ;     genIpush
   27E8 C0 04              6617 	push	ar4
   27EA C0 03              6618 	push	ar3
                           6619 ;     genCast
   27EC 7B 01              6620 	mov	r3,#0x1
                           6621 ;     genCall
   27EE 8D 82              6622 	mov	dpl,r5
   27F0 8E 83              6623 	mov	dph,r6
   27F2 8B F0              6624 	mov	b,r3
   27F4 C0 03              6625 	push	ar3
   27F6 C0 04              6626 	push	ar4
   27F8 12 65 34           6627 	lcall	_local_gmtime
   27FB D0 04              6628 	pop	ar4
   27FD D0 03              6629 	pop	ar3
                           6630 ;src/menu.c:1663: printf_fast("%02u", (unsigned int)system_time.tm_hour);
                           6631 ;     genPointerGet
                           6632 ;     genFarPointerGet
   27FF 90 01 83           6633 	mov	dptr,#(_system_time + 0x0002)
   2802 E0                 6634 	movx	a,@dptr
   2803 FB                 6635 	mov	r3,a
                           6636 ;     genCast
   2804 7C 00              6637 	mov	r4,#0x00
                           6638 ;     genIpush
   2806 C0 03              6639 	push	ar3
   2808 C0 04              6640 	push	ar4
   280A C0 03              6641 	push	ar3
   280C C0 04              6642 	push	ar4
                           6643 ;     genIpush
   280E 74 2E              6644 	mov	a,#__str_7
   2810 C0 E0              6645 	push	acc
   2812 74 4A              6646 	mov	a,#(__str_7 >> 8)
   2814 C0 E0              6647 	push	acc
                           6648 ;     genCall
   2816 12 72 21           6649 	lcall	_printf_fast
   2819 E5 81              6650 	mov	a,sp
   281B 24 FC              6651 	add	a,#0xfc
   281D F5 81              6652 	mov	sp,a
   281F D0 04              6653 	pop	ar4
   2821 D0 03              6654 	pop	ar3
                           6655 ;src/menu.c:1665: hours = system_time.tm_hour;
                           6656 ;     genPointerGet
                           6657 ;     genFarPointerGet
   2823 90 01 83           6658 	mov	dptr,#(_system_time + 0x0002)
   2826 E0                 6659 	movx	a,@dptr
   2827 FB                 6660 	mov	r3,a
                           6661 ;     genAssign
   2828 E5 40              6662 	mov	a,_bp
   282A 24 05              6663 	add	a,#0x05
   282C F8                 6664 	mov	r0,a
   282D A6 03              6665 	mov	@r0,ar3
                           6666 ;src/menu.c:1767: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
                           6667 ;     genIpop
   282F D0 03              6668 	pop	ar3
   2831 D0 04              6669 	pop	ar4
                           6670 ;src/menu.c:1665: hours = system_time.tm_hour;
   2833                    6671 00105$:
                           6672 ;src/menu.c:1668: lcd_goto_xy(display->x+3, display->y+1);
                           6673 ;     genPointerGet
                           6674 ;     genGenPointerGet
   2833 E5 40              6675 	mov	a,_bp
   2835 24 0D              6676 	add	a,#0x0d
   2837 F8                 6677 	mov	r0,a
   2838 86 82              6678 	mov	dpl,@r0
   283A 08                 6679 	inc	r0
   283B 86 83              6680 	mov	dph,@r0
   283D 08                 6681 	inc	r0
   283E 86 F0              6682 	mov	b,@r0
   2840 12 71 F5           6683 	lcall	__gptrget
                           6684 ;     genPlus
                           6685 ;     genPlusIncr
                           6686 ;       Peephole 185    changed order of increment (acc incremented also!)
   2843 04                 6687 	inc     a
   2844 FD                 6688 	mov     r5,a
                           6689 ;     genPointerGet
                           6690 ;     genGenPointerGet
   2845 E5 40              6691 	mov	a,_bp
   2847 24 0A              6692 	add	a,#0x0a
   2849 F8                 6693 	mov	r0,a
   284A 86 82              6694 	mov	dpl,@r0
   284C 08                 6695 	inc	r0
   284D 86 83              6696 	mov	dph,@r0
   284F 08                 6697 	inc	r0
   2850 86 F0              6698 	mov	b,@r0
   2852 12 71 F5           6699 	lcall	__gptrget
   2855 FE                 6700 	mov	r6,a
                           6701 ;     genPlus
                           6702 ;     genPlusIncr
   2856 74 03              6703 	mov	a,#0x03
                           6704 ;       Peephole 236.a  used r6 instead of ar6
   2858 2E                 6705 	add     a,r6
   2859 F5 82              6706 	mov	dpl,a
                           6707 ;     genIpush
   285B C0 03              6708 	push	ar3
   285D C0 04              6709 	push	ar4
   285F C0 05              6710 	push	ar5
                           6711 ;     genCall
   2861 12 0A CD           6712 	lcall	_lcd_goto_xy
   2864 15 81              6713 	dec	sp
   2866 D0 04              6714 	pop	ar4
   2868 D0 03              6715 	pop	ar3
                           6716 ;src/menu.c:1669: result = read_keyboard_data_workloop(2,0x99,0,false);
                           6717 ;     genIpush
   286A C0 03              6718 	push	ar3
   286C C0 04              6719 	push	ar4
                           6720 ;       Peephole 181    changed mov to clr
   286E E4                 6721 	clr     a
   286F C0 E0              6722 	push	acc
                           6723 ;     genIpush
                           6724 ;       Peephole 181    changed mov to clr
   2871 E4                 6725 	clr     a
   2872 C0 E0              6726 	push	acc
                           6727 ;     genIpush
   2874 74 99              6728 	mov	a,#0x99
   2876 C0 E0              6729 	push	acc
                           6730 ;       Peephole 181    changed mov to clr
   2878 E4                 6731 	clr     a
   2879 C0 E0              6732 	push	acc
                           6733 ;     genCall
   287B 75 82 02           6734 	mov	dpl,#0x02
   287E 12 22 F3           6735 	lcall	_read_keyboard_data_workloop
   2881 AD 82              6736 	mov	r5,dpl
   2883 AE 83              6737 	mov	r6,dph
   2885 E5 81              6738 	mov	a,sp
   2887 24 FC              6739 	add	a,#0xfc
   2889 F5 81              6740 	mov	sp,a
   288B D0 04              6741 	pop	ar4
   288D D0 03              6742 	pop	ar3
                           6743 ;     genAssign
   288F E5 40              6744 	mov	a,_bp
   2891 24 02              6745 	add	a,#0x02
   2893 F8                 6746 	mov	r0,a
   2894 A6 05              6747 	mov	@r0,ar5
   2896 08                 6748 	inc	r0
   2897 A6 06              6749 	mov	@r0,ar6
                           6750 ;src/menu.c:1670: if (result != 0x99)
                           6751 ;     genCmpEq
   2899 E5 40              6752 	mov	a,_bp
   289B 24 02              6753 	add	a,#0x02
   289D F8                 6754 	mov	r0,a
   289E B6 99 06           6755 	cjne	@r0,#0x99,00145$
   28A1 08                 6756 	inc	r0
   28A2 B6 00 02           6757 	cjne	@r0,#0x00,00145$
                           6758 ;       Peephole 112.b  changed ljmp to sjmp
   28A5 80 20              6759 	sjmp    00109$
   28A7                    6760 00145$:
                           6761 ;src/menu.c:1672: if (result <= 0x59)
                           6762 ;     genCmpGt
   28A7 E5 40              6763 	mov	a,_bp
   28A9 24 02              6764 	add	a,#0x02
   28AB F8                 6765 	mov	r0,a
                           6766 ;     genCmp
   28AC C3                 6767 	clr	c
   28AD 74 59              6768 	mov	a,#0x59
   28AF 96                 6769 	subb	a,@r0
                           6770 ;       Peephole 181    changed mov to clr
   28B0 E4                 6771 	clr     a
   28B1 08                 6772 	inc	r0
   28B2 96                 6773 	subb	a,@r0
                           6774 ;     genIfxJump
   28B3 50 03              6775 	jnc	00146$
   28B5 02 29 58           6776 	ljmp	00110$
   28B8                    6777 00146$:
                           6778 ;src/menu.c:1674: mins = (unsigned char)result&0xff;
                           6779 ;     genCast
   28B8 E5 40              6780 	mov	a,_bp
   28BA 24 02              6781 	add	a,#0x02
   28BC F8                 6782 	mov	r0,a
   28BD E5 40              6783 	mov	a,_bp
   28BF 24 04              6784 	add	a,#0x04
   28C1 F9                 6785 	mov	r1,a
   28C2 E6                 6786 	mov	a,@r0
   28C3 F7                 6787 	mov	@r1,a
   28C4 02 29 58           6788 	ljmp	00110$
   28C7                    6789 00109$:
                           6790 ;src/menu.c:1679: lcd_goto_xy(display->x+3, display->y+1);
                           6791 ;     genPointerGet
                           6792 ;     genGenPointerGet
   28C7 E5 40              6793 	mov	a,_bp
   28C9 24 0D              6794 	add	a,#0x0d
   28CB F8                 6795 	mov	r0,a
   28CC 86 82              6796 	mov	dpl,@r0
   28CE 08                 6797 	inc	r0
   28CF 86 83              6798 	mov	dph,@r0
   28D1 08                 6799 	inc	r0
   28D2 86 F0              6800 	mov	b,@r0
   28D4 12 71 F5           6801 	lcall	__gptrget
                           6802 ;     genPlus
                           6803 ;     genPlusIncr
                           6804 ;       Peephole 185    changed order of increment (acc incremented also!)
   28D7 04                 6805 	inc     a
   28D8 FD                 6806 	mov     r5,a
                           6807 ;     genPointerGet
                           6808 ;     genGenPointerGet
   28D9 E5 40              6809 	mov	a,_bp
   28DB 24 0A              6810 	add	a,#0x0a
   28DD F8                 6811 	mov	r0,a
   28DE 86 82              6812 	mov	dpl,@r0
   28E0 08                 6813 	inc	r0
   28E1 86 83              6814 	mov	dph,@r0
   28E3 08                 6815 	inc	r0
   28E4 86 F0              6816 	mov	b,@r0
   28E6 12 71 F5           6817 	lcall	__gptrget
   28E9 FE                 6818 	mov	r6,a
                           6819 ;     genPlus
                           6820 ;     genPlusIncr
   28EA 74 03              6821 	mov	a,#0x03
                           6822 ;       Peephole 236.a  used r6 instead of ar6
   28EC 2E                 6823 	add     a,r6
   28ED F5 82              6824 	mov	dpl,a
                           6825 ;     genIpush
   28EF C0 03              6826 	push	ar3
   28F1 C0 04              6827 	push	ar4
   28F3 C0 05              6828 	push	ar5
                           6829 ;     genCall
   28F5 12 0A CD           6830 	lcall	_lcd_goto_xy
   28F8 15 81              6831 	dec	sp
   28FA D0 04              6832 	pop	ar4
   28FC D0 03              6833 	pop	ar3
                           6834 ;src/menu.c:1680: local_gmtime(&system_data.zone_settings[zone].start_time);         
                           6835 ;     genPlus
                           6836 ;       Peephole 236.g  used r4 instead of ar4
   28FE EC                 6837 	mov     a,r4
   28FF 24 0D              6838 	add	a,#_system_data
   2901 FD                 6839 	mov	r5,a
                           6840 ;       Peephole 236.g  used r3 instead of ar3
   2902 EB                 6841 	mov     a,r3
   2903 34 00              6842 	addc	a,#(_system_data >> 8)
   2905 FE                 6843 	mov	r6,a
                           6844 ;     genPlus
                           6845 ;     genPlusIncr
   2906 74 02              6846 	mov	a,#0x02
                           6847 ;       Peephole 236.a  used r5 instead of ar5
   2908 2D                 6848 	add     a,r5
   2909 FD                 6849 	mov	r5,a
                           6850 ;       Peephole 181    changed mov to clr
   290A E4                 6851 	clr     a
                           6852 ;       Peephole 236.b  used r6 instead of ar6
   290B 3E                 6853 	addc    a,r6
   290C FE                 6854 	mov	r6,a
                           6855 ;     genIpush
   290D C0 04              6856 	push	ar4
   290F C0 03              6857 	push	ar3
                           6858 ;     genCast
   2911 7B 01              6859 	mov	r3,#0x1
                           6860 ;     genCall
   2913 8D 82              6861 	mov	dpl,r5
   2915 8E 83              6862 	mov	dph,r6
   2917 8B F0              6863 	mov	b,r3
   2919 C0 03              6864 	push	ar3
   291B C0 04              6865 	push	ar4
   291D 12 65 34           6866 	lcall	_local_gmtime
   2920 D0 04              6867 	pop	ar4
   2922 D0 03              6868 	pop	ar3
                           6869 ;src/menu.c:1681: printf_fast("%02u", (unsigned int)system_time.tm_min);
                           6870 ;     genPointerGet
                           6871 ;     genFarPointerGet
   2924 90 01 82           6872 	mov	dptr,#(_system_time + 0x0001)
   2927 E0                 6873 	movx	a,@dptr
   2928 FB                 6874 	mov	r3,a
                           6875 ;     genCast
   2929 7C 00              6876 	mov	r4,#0x00
                           6877 ;     genIpush
   292B C0 03              6878 	push	ar3
   292D C0 04              6879 	push	ar4
   292F C0 03              6880 	push	ar3
   2931 C0 04              6881 	push	ar4
                           6882 ;     genIpush
   2933 74 2E              6883 	mov	a,#__str_7
   2935 C0 E0              6884 	push	acc
   2937 74 4A              6885 	mov	a,#(__str_7 >> 8)
   2939 C0 E0              6886 	push	acc
                           6887 ;     genCall
   293B 12 72 21           6888 	lcall	_printf_fast
   293E E5 81              6889 	mov	a,sp
   2940 24 FC              6890 	add	a,#0xfc
   2942 F5 81              6891 	mov	sp,a
   2944 D0 04              6892 	pop	ar4
   2946 D0 03              6893 	pop	ar3
                           6894 ;src/menu.c:1683: mins = system_time.tm_min;
                           6895 ;     genPointerGet
                           6896 ;     genFarPointerGet
   2948 90 01 82           6897 	mov	dptr,#(_system_time + 0x0001)
   294B E0                 6898 	movx	a,@dptr
   294C FB                 6899 	mov	r3,a
                           6900 ;     genAssign
   294D E5 40              6901 	mov	a,_bp
   294F 24 04              6902 	add	a,#0x04
   2951 F8                 6903 	mov	r0,a
   2952 A6 03              6904 	mov	@r0,ar3
                           6905 ;src/menu.c:1767: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
                           6906 ;     genIpop
   2954 D0 03              6907 	pop	ar3
   2956 D0 04              6908 	pop	ar4
                           6909 ;src/menu.c:1683: mins = system_time.tm_min;
   2958                    6910 00110$:
                           6911 ;src/menu.c:1687: temp_long = hours;
                           6912 ;     genCast
   2958 E5 40              6913 	mov	a,_bp
   295A 24 05              6914 	add	a,#0x05
   295C F8                 6915 	mov	r0,a
   295D 86 35              6916 	mov	_temp_long,@r0
   295F 75 36 00           6917 	mov	(_temp_long + 1),#0x00
   2962 75 37 00           6918 	mov	(_temp_long + 2),#0x00
   2965 75 38 00           6919 	mov	(_temp_long + 3),#0x00
                           6920 ;src/menu.c:1688: temp_long *= 3600;
                           6921 ;     genAssign
   2968 75 42 10           6922 	mov	__mullong_PARM_2,#0x10
   296B 75 43 0E           6923 	mov	(__mullong_PARM_2 + 1),#0x0E
   296E 75 44 00           6924 	mov	(__mullong_PARM_2 + 2),#0x00
   2971 75 45 00           6925 	mov	(__mullong_PARM_2 + 3),#0x00
                           6926 ;     genCall
   2974 85 35 82           6927 	mov	dpl,_temp_long
   2977 85 36 83           6928 	mov	dph,(_temp_long + 1)
   297A 85 37 F0           6929 	mov	b,(_temp_long + 2)
   297D E5 38              6930 	mov	a,(_temp_long + 3)
   297F C0 03              6931 	push	ar3
   2981 C0 04              6932 	push	ar4
   2983 12 70 BF           6933 	lcall	__mullong
   2986 85 82 35           6934 	mov	_temp_long,dpl
   2989 85 83 36           6935 	mov	(_temp_long + 1),dph
   298C 85 F0 37           6936 	mov	(_temp_long + 2),b
   298F F5 38              6937 	mov	(_temp_long + 3),a
   2991 D0 04              6938 	pop	ar4
   2993 D0 03              6939 	pop	ar3
                           6940 ;src/menu.c:1690: result = mins * 60;  
                           6941 ;     genMult
   2995 E5 40              6942 	mov	a,_bp
   2997 24 04              6943 	add	a,#0x04
   2999 F8                 6944 	mov	r0,a
   299A E5 40              6945 	mov	a,_bp
   299C 24 02              6946 	add	a,#0x02
   299E F9                 6947 	mov	r1,a
                           6948 ;     genMultOneByte
   299F E6                 6949 	mov	a,@r0
   29A0 75 F0 3C           6950 	mov	b,#0x3C
   29A3 A4                 6951 	mul	ab
   29A4 F7                 6952 	mov	@r1,a
   29A5 09                 6953 	inc	r1
   29A6 A7 F0              6954 	mov	@r1,b
                           6955 ;src/menu.c:1691: temp_long += result;
                           6956 ;     genCast
   29A8 E5 40              6957 	mov	a,_bp
   29AA 24 02              6958 	add	a,#0x02
   29AC F8                 6959 	mov	r0,a
   29AD 86 05              6960 	mov	ar5,@r0
   29AF 08                 6961 	inc	r0
   29B0 86 06              6962 	mov	ar6,@r0
                           6963 ;     genPlus
                           6964 ;       Peephole 3.c    changed mov to clr
   29B2 E4                 6965 	clr     a
   29B3 FA                 6966 	mov     r2,a
   29B4 FF                 6967 	mov     r7,a
                           6968 ;       Peephole 236.g  used r5 instead of ar5
   29B5 ED                 6969 	mov     a,r5
   29B6 25 35              6970 	add	a,_temp_long
   29B8 F5 35              6971 	mov	_temp_long,a
                           6972 ;       Peephole 236.g  used r6 instead of ar6
   29BA EE                 6973 	mov     a,r6
   29BB 35 36              6974 	addc	a,(_temp_long + 1)
   29BD F5 36              6975 	mov	(_temp_long + 1),a
                           6976 ;       Peephole 236.g  used r2 instead of ar2
   29BF EA                 6977 	mov     a,r2
   29C0 35 37              6978 	addc	a,(_temp_long + 2)
   29C2 F5 37              6979 	mov	(_temp_long + 2),a
                           6980 ;       Peephole 236.g  used r7 instead of ar7
   29C4 EF                 6981 	mov     a,r7
   29C5 35 38              6982 	addc	a,(_temp_long + 3)
   29C7 F5 38              6983 	mov	(_temp_long + 3),a
                           6984 ;src/menu.c:1693: system_data.zone_settings[zone].start_time = temp_long;
                           6985 ;     genPlus
                           6986 ;       Peephole 236.g  used r4 instead of ar4
   29C9 EC                 6987 	mov     a,r4
   29CA 24 0D              6988 	add	a,#_system_data
   29CC FA                 6989 	mov	r2,a
                           6990 ;       Peephole 236.g  used r3 instead of ar3
   29CD EB                 6991 	mov     a,r3
   29CE 34 00              6992 	addc	a,#(_system_data >> 8)
   29D0 FD                 6993 	mov	r5,a
                           6994 ;     genPlus
                           6995 ;     genPlusIncr
   29D1 74 02              6996 	mov	a,#0x02
                           6997 ;       Peephole 236.a  used r2 instead of ar2
   29D3 2A                 6998 	add     a,r2
   29D4 F5 82              6999 	mov	dpl,a
                           7000 ;       Peephole 181    changed mov to clr
   29D6 E4                 7001 	clr     a
                           7002 ;       Peephole 236.b  used r5 instead of ar5
   29D7 3D                 7003 	addc    a,r5
   29D8 F5 83              7004 	mov	dph,a
                           7005 ;     genPointerSet
                           7006 ;     genFarPointerSet
   29DA E5 35              7007 	mov	a,_temp_long
   29DC F0                 7008 	movx	@dptr,a
   29DD A3                 7009 	inc	dptr
   29DE E5 36              7010 	mov	a,(_temp_long + 1)
   29E0 F0                 7011 	movx	@dptr,a
   29E1 A3                 7012 	inc	dptr
   29E2 E5 37              7013 	mov	a,(_temp_long + 2)
   29E4 F0                 7014 	movx	@dptr,a
   29E5 A3                 7015 	inc	dptr
   29E6 E5 38              7016 	mov	a,(_temp_long + 3)
   29E8 F0                 7017 	movx	@dptr,a
                           7018 ;src/menu.c:1695: lcd_goto_xy(display->x+6, display->y+1);
                           7019 ;     genPointerGet
                           7020 ;     genGenPointerGet
   29E9 E5 40              7021 	mov	a,_bp
   29EB 24 0D              7022 	add	a,#0x0d
   29ED F8                 7023 	mov	r0,a
   29EE 86 82              7024 	mov	dpl,@r0
   29F0 08                 7025 	inc	r0
   29F1 86 83              7026 	mov	dph,@r0
   29F3 08                 7027 	inc	r0
   29F4 86 F0              7028 	mov	b,@r0
   29F6 12 71 F5           7029 	lcall	__gptrget
                           7030 ;     genPlus
                           7031 ;     genPlusIncr
                           7032 ;       Peephole 185    changed order of increment (acc incremented also!)
   29F9 04                 7033 	inc     a
   29FA FA                 7034 	mov     r2,a
                           7035 ;     genPointerGet
                           7036 ;     genGenPointerGet
   29FB E5 40              7037 	mov	a,_bp
   29FD 24 0A              7038 	add	a,#0x0a
   29FF F8                 7039 	mov	r0,a
   2A00 86 82              7040 	mov	dpl,@r0
   2A02 08                 7041 	inc	r0
   2A03 86 83              7042 	mov	dph,@r0
   2A05 08                 7043 	inc	r0
   2A06 86 F0              7044 	mov	b,@r0
   2A08 12 71 F5           7045 	lcall	__gptrget
   2A0B FD                 7046 	mov	r5,a
                           7047 ;     genPlus
   2A0C 74 06              7048 	mov	a,#0x06
                           7049 ;       Peephole 236.a  used r5 instead of ar5
   2A0E 2D                 7050 	add     a,r5
   2A0F F5 82              7051 	mov	dpl,a
                           7052 ;     genIpush
   2A11 C0 03              7053 	push	ar3
   2A13 C0 04              7054 	push	ar4
   2A15 C0 02              7055 	push	ar2
                           7056 ;     genCall
   2A17 12 0A CD           7057 	lcall	_lcd_goto_xy
   2A1A 15 81              7058 	dec	sp
   2A1C D0 04              7059 	pop	ar4
   2A1E D0 03              7060 	pop	ar3
                           7061 ;src/menu.c:1696: result = read_keyboard_data_workloop(2,0x99,0,false);
                           7062 ;     genIpush
   2A20 C0 03              7063 	push	ar3
   2A22 C0 04              7064 	push	ar4
                           7065 ;       Peephole 181    changed mov to clr
   2A24 E4                 7066 	clr     a
   2A25 C0 E0              7067 	push	acc
                           7068 ;     genIpush
                           7069 ;       Peephole 181    changed mov to clr
   2A27 E4                 7070 	clr     a
   2A28 C0 E0              7071 	push	acc
                           7072 ;     genIpush
   2A2A 74 99              7073 	mov	a,#0x99
   2A2C C0 E0              7074 	push	acc
                           7075 ;       Peephole 181    changed mov to clr
   2A2E E4                 7076 	clr     a
   2A2F C0 E0              7077 	push	acc
                           7078 ;     genCall
   2A31 75 82 02           7079 	mov	dpl,#0x02
   2A34 12 22 F3           7080 	lcall	_read_keyboard_data_workloop
   2A37 AA 82              7081 	mov	r2,dpl
   2A39 AD 83              7082 	mov	r5,dph
   2A3B E5 81              7083 	mov	a,sp
   2A3D 24 FC              7084 	add	a,#0xfc
   2A3F F5 81              7085 	mov	sp,a
   2A41 D0 04              7086 	pop	ar4
   2A43 D0 03              7087 	pop	ar3
                           7088 ;     genAssign
   2A45 E5 40              7089 	mov	a,_bp
   2A47 24 02              7090 	add	a,#0x02
   2A49 F8                 7091 	mov	r0,a
   2A4A A6 02              7092 	mov	@r0,ar2
   2A4C 08                 7093 	inc	r0
   2A4D A6 05              7094 	mov	@r0,ar5
                           7095 ;src/menu.c:1697: if (result != 0x99)
                           7096 ;     genCmpEq
   2A4F E5 40              7097 	mov	a,_bp
   2A51 24 02              7098 	add	a,#0x02
   2A53 F8                 7099 	mov	r0,a
   2A54 B6 99 06           7100 	cjne	@r0,#0x99,00147$
   2A57 08                 7101 	inc	r0
   2A58 B6 00 02           7102 	cjne	@r0,#0x00,00147$
                           7103 ;       Peephole 112.b  changed ljmp to sjmp
   2A5B 80 20              7104 	sjmp    00114$
   2A5D                    7105 00147$:
                           7106 ;src/menu.c:1699: if (result <= 0x23)
                           7107 ;     genCmpGt
   2A5D E5 40              7108 	mov	a,_bp
   2A5F 24 02              7109 	add	a,#0x02
   2A61 F8                 7110 	mov	r0,a
                           7111 ;     genCmp
   2A62 C3                 7112 	clr	c
   2A63 74 23              7113 	mov	a,#0x23
   2A65 96                 7114 	subb	a,@r0
                           7115 ;       Peephole 181    changed mov to clr
   2A66 E4                 7116 	clr     a
   2A67 08                 7117 	inc	r0
   2A68 96                 7118 	subb	a,@r0
                           7119 ;     genIfxJump
   2A69 50 03              7120 	jnc	00148$
   2A6B 02 2B 06           7121 	ljmp	00115$
   2A6E                    7122 00148$:
                           7123 ;src/menu.c:1701: hours = (unsigned char)result&0xff;
                           7124 ;     genCast
   2A6E E5 40              7125 	mov	a,_bp
   2A70 24 02              7126 	add	a,#0x02
   2A72 F8                 7127 	mov	r0,a
   2A73 E5 40              7128 	mov	a,_bp
   2A75 24 05              7129 	add	a,#0x05
   2A77 F9                 7130 	mov	r1,a
   2A78 E6                 7131 	mov	a,@r0
   2A79 F7                 7132 	mov	@r1,a
   2A7A 02 2B 06           7133 	ljmp	00115$
   2A7D                    7134 00114$:
                           7135 ;src/menu.c:1706: lcd_goto_xy(display->x+6, display->y+1);
                           7136 ;     genPointerGet
                           7137 ;     genGenPointerGet
   2A7D E5 40              7138 	mov	a,_bp
   2A7F 24 0D              7139 	add	a,#0x0d
   2A81 F8                 7140 	mov	r0,a
   2A82 86 82              7141 	mov	dpl,@r0
   2A84 08                 7142 	inc	r0
   2A85 86 83              7143 	mov	dph,@r0
   2A87 08                 7144 	inc	r0
   2A88 86 F0              7145 	mov	b,@r0
   2A8A 12 71 F5           7146 	lcall	__gptrget
                           7147 ;     genPlus
                           7148 ;     genPlusIncr
                           7149 ;       Peephole 185    changed order of increment (acc incremented also!)
   2A8D 04                 7150 	inc     a
   2A8E FA                 7151 	mov     r2,a
                           7152 ;     genPointerGet
                           7153 ;     genGenPointerGet
   2A8F E5 40              7154 	mov	a,_bp
   2A91 24 0A              7155 	add	a,#0x0a
   2A93 F8                 7156 	mov	r0,a
   2A94 86 82              7157 	mov	dpl,@r0
   2A96 08                 7158 	inc	r0
   2A97 86 83              7159 	mov	dph,@r0
   2A99 08                 7160 	inc	r0
   2A9A 86 F0              7161 	mov	b,@r0
   2A9C 12 71 F5           7162 	lcall	__gptrget
   2A9F FD                 7163 	mov	r5,a
                           7164 ;     genPlus
   2AA0 74 06              7165 	mov	a,#0x06
                           7166 ;       Peephole 236.a  used r5 instead of ar5
   2AA2 2D                 7167 	add     a,r5
   2AA3 F5 82              7168 	mov	dpl,a
                           7169 ;     genIpush
   2AA5 C0 03              7170 	push	ar3
   2AA7 C0 04              7171 	push	ar4
   2AA9 C0 02              7172 	push	ar2
                           7173 ;     genCall
   2AAB 12 0A CD           7174 	lcall	_lcd_goto_xy
   2AAE 15 81              7175 	dec	sp
   2AB0 D0 04              7176 	pop	ar4
   2AB2 D0 03              7177 	pop	ar3
                           7178 ;src/menu.c:1707: local_gmtime(&system_data.zone_settings[zone].stop_time);
                           7179 ;     genPlus
                           7180 ;       Peephole 236.g  used r4 instead of ar4
   2AB4 EC                 7181 	mov     a,r4
   2AB5 24 0D              7182 	add	a,#_system_data
   2AB7 FA                 7183 	mov	r2,a
                           7184 ;       Peephole 236.g  used r3 instead of ar3
   2AB8 EB                 7185 	mov     a,r3
   2AB9 34 00              7186 	addc	a,#(_system_data >> 8)
   2ABB FD                 7187 	mov	r5,a
                           7188 ;     genPlus
   2ABC 74 06              7189 	mov	a,#0x06
                           7190 ;       Peephole 236.a  used r2 instead of ar2
   2ABE 2A                 7191 	add     a,r2
   2ABF FA                 7192 	mov	r2,a
                           7193 ;       Peephole 181    changed mov to clr
   2AC0 E4                 7194 	clr     a
                           7195 ;       Peephole 236.b  used r5 instead of ar5
   2AC1 3D                 7196 	addc    a,r5
   2AC2 FD                 7197 	mov	r5,a
                           7198 ;     genCast
   2AC3 7E 01              7199 	mov	r6,#0x1
                           7200 ;     genCall
   2AC5 8A 82              7201 	mov	dpl,r2
   2AC7 8D 83              7202 	mov	dph,r5
   2AC9 8E F0              7203 	mov	b,r6
   2ACB C0 03              7204 	push	ar3
   2ACD C0 04              7205 	push	ar4
   2ACF 12 65 34           7206 	lcall	_local_gmtime
   2AD2 D0 04              7207 	pop	ar4
   2AD4 D0 03              7208 	pop	ar3
                           7209 ;src/menu.c:1708: printf_fast("%02u", (unsigned int)system_time.tm_hour);
                           7210 ;     genPointerGet
                           7211 ;     genFarPointerGet
   2AD6 90 01 83           7212 	mov	dptr,#(_system_time + 0x0002)
   2AD9 E0                 7213 	movx	a,@dptr
   2ADA FA                 7214 	mov	r2,a
                           7215 ;     genCast
   2ADB 7D 00              7216 	mov	r5,#0x00
                           7217 ;     genIpush
   2ADD C0 03              7218 	push	ar3
   2ADF C0 04              7219 	push	ar4
   2AE1 C0 02              7220 	push	ar2
   2AE3 C0 05              7221 	push	ar5
                           7222 ;     genIpush
   2AE5 74 2E              7223 	mov	a,#__str_7
   2AE7 C0 E0              7224 	push	acc
   2AE9 74 4A              7225 	mov	a,#(__str_7 >> 8)
   2AEB C0 E0              7226 	push	acc
                           7227 ;     genCall
   2AED 12 72 21           7228 	lcall	_printf_fast
   2AF0 E5 81              7229 	mov	a,sp
   2AF2 24 FC              7230 	add	a,#0xfc
   2AF4 F5 81              7231 	mov	sp,a
   2AF6 D0 04              7232 	pop	ar4
   2AF8 D0 03              7233 	pop	ar3
                           7234 ;src/menu.c:1710: hours = system_time.tm_hour;
                           7235 ;     genPointerGet
                           7236 ;     genFarPointerGet
   2AFA 90 01 83           7237 	mov	dptr,#(_system_time + 0x0002)
   2AFD E0                 7238 	movx	a,@dptr
   2AFE FA                 7239 	mov	r2,a
                           7240 ;     genAssign
   2AFF E5 40              7241 	mov	a,_bp
   2B01 24 05              7242 	add	a,#0x05
   2B03 F8                 7243 	mov	r0,a
   2B04 A6 02              7244 	mov	@r0,ar2
   2B06                    7245 00115$:
                           7246 ;src/menu.c:1713: lcd_goto_xy(display->x+9, display->y+1);
                           7247 ;     genPointerGet
                           7248 ;     genGenPointerGet
   2B06 E5 40              7249 	mov	a,_bp
   2B08 24 0D              7250 	add	a,#0x0d
   2B0A F8                 7251 	mov	r0,a
   2B0B 86 82              7252 	mov	dpl,@r0
   2B0D 08                 7253 	inc	r0
   2B0E 86 83              7254 	mov	dph,@r0
   2B10 08                 7255 	inc	r0
   2B11 86 F0              7256 	mov	b,@r0
   2B13 12 71 F5           7257 	lcall	__gptrget
                           7258 ;     genPlus
                           7259 ;     genPlusIncr
                           7260 ;       Peephole 185    changed order of increment (acc incremented also!)
   2B16 04                 7261 	inc     a
   2B17 FA                 7262 	mov     r2,a
                           7263 ;     genPointerGet
                           7264 ;     genGenPointerGet
   2B18 E5 40              7265 	mov	a,_bp
   2B1A 24 0A              7266 	add	a,#0x0a
   2B1C F8                 7267 	mov	r0,a
   2B1D 86 82              7268 	mov	dpl,@r0
   2B1F 08                 7269 	inc	r0
   2B20 86 83              7270 	mov	dph,@r0
   2B22 08                 7271 	inc	r0
   2B23 86 F0              7272 	mov	b,@r0
   2B25 12 71 F5           7273 	lcall	__gptrget
   2B28 FD                 7274 	mov	r5,a
                           7275 ;     genPlus
   2B29 74 09              7276 	mov	a,#0x09
                           7277 ;       Peephole 236.a  used r5 instead of ar5
   2B2B 2D                 7278 	add     a,r5
   2B2C F5 82              7279 	mov	dpl,a
                           7280 ;     genIpush
   2B2E C0 03              7281 	push	ar3
   2B30 C0 04              7282 	push	ar4
   2B32 C0 02              7283 	push	ar2
                           7284 ;     genCall
   2B34 12 0A CD           7285 	lcall	_lcd_goto_xy
   2B37 15 81              7286 	dec	sp
   2B39 D0 04              7287 	pop	ar4
   2B3B D0 03              7288 	pop	ar3
                           7289 ;src/menu.c:1714: result = read_keyboard_data_workloop(2,0x99,0,false);
                           7290 ;     genIpush
   2B3D C0 03              7291 	push	ar3
   2B3F C0 04              7292 	push	ar4
                           7293 ;       Peephole 181    changed mov to clr
   2B41 E4                 7294 	clr     a
   2B42 C0 E0              7295 	push	acc
                           7296 ;     genIpush
                           7297 ;       Peephole 181    changed mov to clr
   2B44 E4                 7298 	clr     a
   2B45 C0 E0              7299 	push	acc
                           7300 ;     genIpush
   2B47 74 99              7301 	mov	a,#0x99
   2B49 C0 E0              7302 	push	acc
                           7303 ;       Peephole 181    changed mov to clr
   2B4B E4                 7304 	clr     a
   2B4C C0 E0              7305 	push	acc
                           7306 ;     genCall
   2B4E 75 82 02           7307 	mov	dpl,#0x02
   2B51 12 22 F3           7308 	lcall	_read_keyboard_data_workloop
   2B54 AA 82              7309 	mov	r2,dpl
   2B56 AD 83              7310 	mov	r5,dph
   2B58 E5 81              7311 	mov	a,sp
   2B5A 24 FC              7312 	add	a,#0xfc
   2B5C F5 81              7313 	mov	sp,a
   2B5E D0 04              7314 	pop	ar4
   2B60 D0 03              7315 	pop	ar3
                           7316 ;     genAssign
   2B62 E5 40              7317 	mov	a,_bp
   2B64 24 02              7318 	add	a,#0x02
   2B66 F8                 7319 	mov	r0,a
   2B67 A6 02              7320 	mov	@r0,ar2
   2B69 08                 7321 	inc	r0
   2B6A A6 05              7322 	mov	@r0,ar5
                           7323 ;src/menu.c:1715: if (result != 0x99)
                           7324 ;     genCmpEq
   2B6C E5 40              7325 	mov	a,_bp
   2B6E 24 02              7326 	add	a,#0x02
   2B70 F8                 7327 	mov	r0,a
   2B71 B6 99 06           7328 	cjne	@r0,#0x99,00149$
   2B74 08                 7329 	inc	r0
   2B75 B6 00 02           7330 	cjne	@r0,#0x00,00149$
                           7331 ;       Peephole 112.b  changed ljmp to sjmp
   2B78 80 20              7332 	sjmp    00119$
   2B7A                    7333 00149$:
                           7334 ;src/menu.c:1717: if (result <= 0x59)
                           7335 ;     genCmpGt
   2B7A E5 40              7336 	mov	a,_bp
   2B7C 24 02              7337 	add	a,#0x02
   2B7E F8                 7338 	mov	r0,a
                           7339 ;     genCmp
   2B7F C3                 7340 	clr	c
   2B80 74 59              7341 	mov	a,#0x59
   2B82 96                 7342 	subb	a,@r0
                           7343 ;       Peephole 181    changed mov to clr
   2B83 E4                 7344 	clr     a
   2B84 08                 7345 	inc	r0
   2B85 96                 7346 	subb	a,@r0
                           7347 ;     genIfxJump
   2B86 50 03              7348 	jnc	00150$
   2B88 02 2C 23           7349 	ljmp	00120$
   2B8B                    7350 00150$:
                           7351 ;src/menu.c:1719: mins = (unsigned char)result&0xff;
                           7352 ;     genCast
   2B8B E5 40              7353 	mov	a,_bp
   2B8D 24 02              7354 	add	a,#0x02
   2B8F F8                 7355 	mov	r0,a
   2B90 E5 40              7356 	mov	a,_bp
   2B92 24 04              7357 	add	a,#0x04
   2B94 F9                 7358 	mov	r1,a
   2B95 E6                 7359 	mov	a,@r0
   2B96 F7                 7360 	mov	@r1,a
   2B97 02 2C 23           7361 	ljmp	00120$
   2B9A                    7362 00119$:
                           7363 ;src/menu.c:1724: lcd_goto_xy(display->x+9, display->y+1);
                           7364 ;     genPointerGet
                           7365 ;     genGenPointerGet
   2B9A E5 40              7366 	mov	a,_bp
   2B9C 24 0D              7367 	add	a,#0x0d
   2B9E F8                 7368 	mov	r0,a
   2B9F 86 82              7369 	mov	dpl,@r0
   2BA1 08                 7370 	inc	r0
   2BA2 86 83              7371 	mov	dph,@r0
   2BA4 08                 7372 	inc	r0
   2BA5 86 F0              7373 	mov	b,@r0
   2BA7 12 71 F5           7374 	lcall	__gptrget
                           7375 ;     genPlus
                           7376 ;     genPlusIncr
                           7377 ;       Peephole 185    changed order of increment (acc incremented also!)
   2BAA 04                 7378 	inc     a
   2BAB FA                 7379 	mov     r2,a
                           7380 ;     genPointerGet
                           7381 ;     genGenPointerGet
   2BAC E5 40              7382 	mov	a,_bp
   2BAE 24 0A              7383 	add	a,#0x0a
   2BB0 F8                 7384 	mov	r0,a
   2BB1 86 82              7385 	mov	dpl,@r0
   2BB3 08                 7386 	inc	r0
   2BB4 86 83              7387 	mov	dph,@r0
   2BB6 08                 7388 	inc	r0
   2BB7 86 F0              7389 	mov	b,@r0
   2BB9 12 71 F5           7390 	lcall	__gptrget
   2BBC FD                 7391 	mov	r5,a
                           7392 ;     genPlus
   2BBD 74 09              7393 	mov	a,#0x09
                           7394 ;       Peephole 236.a  used r5 instead of ar5
   2BBF 2D                 7395 	add     a,r5
   2BC0 F5 82              7396 	mov	dpl,a
                           7397 ;     genIpush
   2BC2 C0 03              7398 	push	ar3
   2BC4 C0 04              7399 	push	ar4
   2BC6 C0 02              7400 	push	ar2
                           7401 ;     genCall
   2BC8 12 0A CD           7402 	lcall	_lcd_goto_xy
   2BCB 15 81              7403 	dec	sp
   2BCD D0 04              7404 	pop	ar4
   2BCF D0 03              7405 	pop	ar3
                           7406 ;src/menu.c:1725: local_gmtime(&system_data.zone_settings[zone].stop_time);
                           7407 ;     genPlus
                           7408 ;       Peephole 236.g  used r4 instead of ar4
   2BD1 EC                 7409 	mov     a,r4
   2BD2 24 0D              7410 	add	a,#_system_data
   2BD4 FA                 7411 	mov	r2,a
                           7412 ;       Peephole 236.g  used r3 instead of ar3
   2BD5 EB                 7413 	mov     a,r3
   2BD6 34 00              7414 	addc	a,#(_system_data >> 8)
   2BD8 FD                 7415 	mov	r5,a
                           7416 ;     genPlus
   2BD9 74 06              7417 	mov	a,#0x06
                           7418 ;       Peephole 236.a  used r2 instead of ar2
   2BDB 2A                 7419 	add     a,r2
   2BDC FA                 7420 	mov	r2,a
                           7421 ;       Peephole 181    changed mov to clr
   2BDD E4                 7422 	clr     a
                           7423 ;       Peephole 236.b  used r5 instead of ar5
   2BDE 3D                 7424 	addc    a,r5
   2BDF FD                 7425 	mov	r5,a
                           7426 ;     genCast
   2BE0 7E 01              7427 	mov	r6,#0x1
                           7428 ;     genCall
   2BE2 8A 82              7429 	mov	dpl,r2
   2BE4 8D 83              7430 	mov	dph,r5
   2BE6 8E F0              7431 	mov	b,r6
   2BE8 C0 03              7432 	push	ar3
   2BEA C0 04              7433 	push	ar4
   2BEC 12 65 34           7434 	lcall	_local_gmtime
   2BEF D0 04              7435 	pop	ar4
   2BF1 D0 03              7436 	pop	ar3
                           7437 ;src/menu.c:1726: printf_fast("%02u", (unsigned int)system_time.tm_min);
                           7438 ;     genPointerGet
                           7439 ;     genFarPointerGet
   2BF3 90 01 82           7440 	mov	dptr,#(_system_time + 0x0001)
   2BF6 E0                 7441 	movx	a,@dptr
   2BF7 FA                 7442 	mov	r2,a
                           7443 ;     genCast
   2BF8 7D 00              7444 	mov	r5,#0x00
                           7445 ;     genIpush
   2BFA C0 03              7446 	push	ar3
   2BFC C0 04              7447 	push	ar4
   2BFE C0 02              7448 	push	ar2
   2C00 C0 05              7449 	push	ar5
                           7450 ;     genIpush
   2C02 74 2E              7451 	mov	a,#__str_7
   2C04 C0 E0              7452 	push	acc
   2C06 74 4A              7453 	mov	a,#(__str_7 >> 8)
   2C08 C0 E0              7454 	push	acc
                           7455 ;     genCall
   2C0A 12 72 21           7456 	lcall	_printf_fast
   2C0D E5 81              7457 	mov	a,sp
   2C0F 24 FC              7458 	add	a,#0xfc
   2C11 F5 81              7459 	mov	sp,a
   2C13 D0 04              7460 	pop	ar4
   2C15 D0 03              7461 	pop	ar3
                           7462 ;src/menu.c:1728: mins = system_time.tm_min;
                           7463 ;     genPointerGet
                           7464 ;     genFarPointerGet
   2C17 90 01 82           7465 	mov	dptr,#(_system_time + 0x0001)
   2C1A E0                 7466 	movx	a,@dptr
   2C1B FA                 7467 	mov	r2,a
                           7468 ;     genAssign
   2C1C E5 40              7469 	mov	a,_bp
   2C1E 24 04              7470 	add	a,#0x04
   2C20 F8                 7471 	mov	r0,a
   2C21 A6 02              7472 	mov	@r0,ar2
   2C23                    7473 00120$:
                           7474 ;src/menu.c:1731: temp_long = hours;
                           7475 ;     genCast
   2C23 E5 40              7476 	mov	a,_bp
   2C25 24 05              7477 	add	a,#0x05
   2C27 F8                 7478 	mov	r0,a
   2C28 86 35              7479 	mov	_temp_long,@r0
   2C2A 75 36 00           7480 	mov	(_temp_long + 1),#0x00
   2C2D 75 37 00           7481 	mov	(_temp_long + 2),#0x00
   2C30 75 38 00           7482 	mov	(_temp_long + 3),#0x00
                           7483 ;src/menu.c:1732: temp_long *= 3600;
                           7484 ;     genAssign
   2C33 75 42 10           7485 	mov	__mullong_PARM_2,#0x10
   2C36 75 43 0E           7486 	mov	(__mullong_PARM_2 + 1),#0x0E
   2C39 75 44 00           7487 	mov	(__mullong_PARM_2 + 2),#0x00
   2C3C 75 45 00           7488 	mov	(__mullong_PARM_2 + 3),#0x00
                           7489 ;     genCall
   2C3F 85 35 82           7490 	mov	dpl,_temp_long
   2C42 85 36 83           7491 	mov	dph,(_temp_long + 1)
   2C45 85 37 F0           7492 	mov	b,(_temp_long + 2)
   2C48 E5 38              7493 	mov	a,(_temp_long + 3)
   2C4A C0 03              7494 	push	ar3
   2C4C C0 04              7495 	push	ar4
   2C4E 12 70 BF           7496 	lcall	__mullong
   2C51 85 82 35           7497 	mov	_temp_long,dpl
   2C54 85 83 36           7498 	mov	(_temp_long + 1),dph
   2C57 85 F0 37           7499 	mov	(_temp_long + 2),b
   2C5A F5 38              7500 	mov	(_temp_long + 3),a
   2C5C D0 04              7501 	pop	ar4
   2C5E D0 03              7502 	pop	ar3
                           7503 ;src/menu.c:1734: result = mins * 60;  
                           7504 ;     genMult
   2C60 E5 40              7505 	mov	a,_bp
   2C62 24 04              7506 	add	a,#0x04
   2C64 F8                 7507 	mov	r0,a
   2C65 E5 40              7508 	mov	a,_bp
   2C67 24 02              7509 	add	a,#0x02
   2C69 F9                 7510 	mov	r1,a
                           7511 ;     genMultOneByte
   2C6A E6                 7512 	mov	a,@r0
   2C6B 75 F0 3C           7513 	mov	b,#0x3C
   2C6E A4                 7514 	mul	ab
   2C6F F7                 7515 	mov	@r1,a
   2C70 09                 7516 	inc	r1
   2C71 A7 F0              7517 	mov	@r1,b
                           7518 ;src/menu.c:1735: temp_long += result;
                           7519 ;     genCast
   2C73 E5 40              7520 	mov	a,_bp
   2C75 24 02              7521 	add	a,#0x02
   2C77 F8                 7522 	mov	r0,a
   2C78 86 02              7523 	mov	ar2,@r0
   2C7A 08                 7524 	inc	r0
   2C7B 86 05              7525 	mov	ar5,@r0
                           7526 ;     genPlus
                           7527 ;       Peephole 3.c    changed mov to clr
   2C7D E4                 7528 	clr     a
   2C7E FE                 7529 	mov     r6,a
   2C7F FF                 7530 	mov     r7,a
                           7531 ;       Peephole 236.g  used r2 instead of ar2
   2C80 EA                 7532 	mov     a,r2
   2C81 25 35              7533 	add	a,_temp_long
   2C83 F5 35              7534 	mov	_temp_long,a
                           7535 ;       Peephole 236.g  used r5 instead of ar5
   2C85 ED                 7536 	mov     a,r5
   2C86 35 36              7537 	addc	a,(_temp_long + 1)
   2C88 F5 36              7538 	mov	(_temp_long + 1),a
                           7539 ;       Peephole 236.g  used r6 instead of ar6
   2C8A EE                 7540 	mov     a,r6
   2C8B 35 37              7541 	addc	a,(_temp_long + 2)
   2C8D F5 37              7542 	mov	(_temp_long + 2),a
                           7543 ;       Peephole 236.g  used r7 instead of ar7
   2C8F EF                 7544 	mov     a,r7
   2C90 35 38              7545 	addc	a,(_temp_long + 3)
   2C92 F5 38              7546 	mov	(_temp_long + 3),a
                           7547 ;src/menu.c:1737: system_data.zone_settings[zone].stop_time = temp_long;
                           7548 ;     genPlus
                           7549 ;       Peephole 236.g  used r4 instead of ar4
   2C94 EC                 7550 	mov     a,r4
   2C95 24 0D              7551 	add	a,#_system_data
   2C97 FA                 7552 	mov	r2,a
                           7553 ;       Peephole 236.g  used r3 instead of ar3
   2C98 EB                 7554 	mov     a,r3
   2C99 34 00              7555 	addc	a,#(_system_data >> 8)
   2C9B FD                 7556 	mov	r5,a
                           7557 ;     genPlus
   2C9C 74 06              7558 	mov	a,#0x06
                           7559 ;       Peephole 236.a  used r2 instead of ar2
   2C9E 2A                 7560 	add     a,r2
   2C9F FE                 7561 	mov	r6,a
                           7562 ;       Peephole 181    changed mov to clr
   2CA0 E4                 7563 	clr     a
                           7564 ;       Peephole 236.b  used r5 instead of ar5
   2CA1 3D                 7565 	addc    a,r5
   2CA2 FF                 7566 	mov	r7,a
                           7567 ;     genPointerSet
                           7568 ;     genFarPointerSet
   2CA3 8E 82              7569 	mov	dpl,r6
   2CA5 8F 83              7570 	mov	dph,r7
   2CA7 E5 35              7571 	mov	a,_temp_long
   2CA9 F0                 7572 	movx	@dptr,a
   2CAA A3                 7573 	inc	dptr
   2CAB E5 36              7574 	mov	a,(_temp_long + 1)
   2CAD F0                 7575 	movx	@dptr,a
   2CAE A3                 7576 	inc	dptr
   2CAF E5 37              7577 	mov	a,(_temp_long + 2)
   2CB1 F0                 7578 	movx	@dptr,a
   2CB2 A3                 7579 	inc	dptr
   2CB3 E5 38              7580 	mov	a,(_temp_long + 3)
   2CB5 F0                 7581 	movx	@dptr,a
                           7582 ;src/menu.c:1740: if (system_data.zone_settings[zone].start_time >= system_data.zone_settings[zone].stop_time)
                           7583 ;     genPlus
   2CB6 E5 40              7584 	mov	a,_bp
   2CB8 24 10              7585 	add	a,#0x10
   2CBA F8                 7586 	mov	r0,a
                           7587 ;     genPlusIncr
   2CBB 74 02              7588 	mov	a,#0x02
                           7589 ;       Peephole 236.a  used r2 instead of ar2
   2CBD 2A                 7590 	add     a,r2
   2CBE F6                 7591 	mov	@r0,a
                           7592 ;       Peephole 181    changed mov to clr
   2CBF E4                 7593 	clr     a
                           7594 ;       Peephole 236.b  used r5 instead of ar5
   2CC0 3D                 7595 	addc    a,r5
   2CC1 08                 7596 	inc	r0
   2CC2 F6                 7597 	mov	@r0,a
                           7598 ;     genIpush
   2CC3 C0 04              7599 	push	ar4
   2CC5 C0 03              7600 	push	ar3
                           7601 ;     genPointerGet
                           7602 ;     genFarPointerGet
   2CC7 E5 40              7603 	mov	a,_bp
   2CC9 24 10              7604 	add	a,#0x10
   2CCB F8                 7605 	mov	r0,a
   2CCC 86 82              7606 	mov	dpl,@r0
   2CCE 08                 7607 	inc	r0
   2CCF 86 83              7608 	mov	dph,@r0
   2CD1 E0                 7609 	movx	a,@dptr
   2CD2 FB                 7610 	mov	r3,a
   2CD3 A3                 7611 	inc	dptr
   2CD4 E0                 7612 	movx	a,@dptr
   2CD5 FC                 7613 	mov	r4,a
   2CD6 A3                 7614 	inc	dptr
   2CD7 E0                 7615 	movx	a,@dptr
   2CD8 FA                 7616 	mov	r2,a
   2CD9 A3                 7617 	inc	dptr
   2CDA E0                 7618 	movx	a,@dptr
   2CDB FD                 7619 	mov	r5,a
                           7620 ;     genCmpLt
                           7621 ;     genCmp
   2CDC C3                 7622 	clr	c
   2CDD EB                 7623 	mov	a,r3
   2CDE 95 35              7624 	subb	a,_temp_long
   2CE0 EC                 7625 	mov	a,r4
   2CE1 95 36              7626 	subb	a,(_temp_long + 1)
   2CE3 EA                 7627 	mov	a,r2
   2CE4 95 37              7628 	subb	a,(_temp_long + 2)
   2CE6 ED                 7629 	mov	a,r5
   2CE7 95 38              7630 	subb	a,(_temp_long + 3)
   2CE9 E4                 7631 	clr	a
   2CEA 33                 7632 	rlc	a
                           7633 ;     genIpop
   2CEB D0 03              7634 	pop	ar3
   2CED D0 04              7635 	pop	ar4
                           7636 ;     genIfx
                           7637 ;     genIfxJump
                           7638 ;       Peephole 109    removed ljmp by inverse jump logic
   2CEF 70 1E              7639 	jnz     00122$
   2CF1                    7640 00151$:
                           7641 ;src/menu.c:1742: system_data.zone_settings[zone].start_time = 0;
                           7642 ;     genPointerSet
                           7643 ;     genFarPointerSet
   2CF1 E5 40              7644 	mov	a,_bp
   2CF3 24 10              7645 	add	a,#0x10
   2CF5 F8                 7646 	mov	r0,a
   2CF6 86 82              7647 	mov	dpl,@r0
   2CF8 08                 7648 	inc	r0
   2CF9 86 83              7649 	mov	dph,@r0
                           7650 ;       Peephole 101    removed redundant mov
                           7651 ;       Peephole 181    changed mov to clr
                           7652 ;       Peephole 101    removed redundant mov
                           7653 ;       Peephole 181    changed mov to clr
                           7654 ;       Peephole 226    removed unnecessary clr
   2CFB E4                 7655 	clr     a
   2CFC F0                 7656 	movx    @dptr,a
   2CFD A3                 7657 	inc     dptr
   2CFE F0                 7658 	movx    @dptr,a
   2CFF A3                 7659 	inc     dptr
   2D00 F0                 7660 	movx    @dptr,a
   2D01 A3                 7661 	inc     dptr
   2D02 F0                 7662 	movx    @dptr,a
                           7663 ;src/menu.c:1743: system_data.zone_settings[zone].stop_time = 0;
                           7664 ;     genPointerSet
                           7665 ;     genFarPointerSet
   2D03 8E 82              7666 	mov	dpl,r6
   2D05 8F 83              7667 	mov	dph,r7
                           7668 ;       Peephole 101    removed redundant mov
                           7669 ;       Peephole 181    changed mov to clr
                           7670 ;       Peephole 101    removed redundant mov
                           7671 ;       Peephole 181    changed mov to clr
                           7672 ;       Peephole 226    removed unnecessary clr
   2D07 E4                 7673 	clr     a
   2D08 F0                 7674 	movx    @dptr,a
   2D09 A3                 7675 	inc     dptr
   2D0A F0                 7676 	movx    @dptr,a
   2D0B A3                 7677 	inc     dptr
   2D0C F0                 7678 	movx    @dptr,a
   2D0D A3                 7679 	inc     dptr
   2D0E F0                 7680 	movx    @dptr,a
   2D0F                    7681 00122$:
                           7682 ;src/menu.c:1746: lcd_goto_xy(display->x+21, display->y+1);
                           7683 ;     genPointerGet
                           7684 ;     genGenPointerGet
   2D0F E5 40              7685 	mov	a,_bp
   2D11 24 0D              7686 	add	a,#0x0d
   2D13 F8                 7687 	mov	r0,a
   2D14 86 82              7688 	mov	dpl,@r0
   2D16 08                 7689 	inc	r0
   2D17 86 83              7690 	mov	dph,@r0
   2D19 08                 7691 	inc	r0
   2D1A 86 F0              7692 	mov	b,@r0
   2D1C 12 71 F5           7693 	lcall	__gptrget
                           7694 ;     genPlus
                           7695 ;     genPlusIncr
                           7696 ;       Peephole 185    changed order of increment (acc incremented also!)
   2D1F 04                 7697 	inc     a
   2D20 FA                 7698 	mov     r2,a
                           7699 ;     genPointerGet
                           7700 ;     genGenPointerGet
   2D21 E5 40              7701 	mov	a,_bp
   2D23 24 0A              7702 	add	a,#0x0a
   2D25 F8                 7703 	mov	r0,a
   2D26 86 82              7704 	mov	dpl,@r0
   2D28 08                 7705 	inc	r0
   2D29 86 83              7706 	mov	dph,@r0
   2D2B 08                 7707 	inc	r0
   2D2C 86 F0              7708 	mov	b,@r0
   2D2E 12 71 F5           7709 	lcall	__gptrget
   2D31 FD                 7710 	mov	r5,a
                           7711 ;     genPlus
   2D32 74 15              7712 	mov	a,#0x15
                           7713 ;       Peephole 236.a  used r5 instead of ar5
   2D34 2D                 7714 	add     a,r5
   2D35 F5 82              7715 	mov	dpl,a
                           7716 ;     genIpush
   2D37 C0 03              7717 	push	ar3
   2D39 C0 04              7718 	push	ar4
   2D3B C0 02              7719 	push	ar2
                           7720 ;     genCall
   2D3D 12 0A CD           7721 	lcall	_lcd_goto_xy
   2D40 15 81              7722 	dec	sp
   2D42 D0 04              7723 	pop	ar4
   2D44 D0 03              7724 	pop	ar3
                           7725 ;src/menu.c:1747: result = read_keyboard_data_workloop(2,0x99,0,false);
                           7726 ;     genIpush
   2D46 C0 03              7727 	push	ar3
   2D48 C0 04              7728 	push	ar4
                           7729 ;       Peephole 181    changed mov to clr
   2D4A E4                 7730 	clr     a
   2D4B C0 E0              7731 	push	acc
                           7732 ;     genIpush
                           7733 ;       Peephole 181    changed mov to clr
   2D4D E4                 7734 	clr     a
   2D4E C0 E0              7735 	push	acc
                           7736 ;     genIpush
   2D50 74 99              7737 	mov	a,#0x99
   2D52 C0 E0              7738 	push	acc
                           7739 ;       Peephole 181    changed mov to clr
   2D54 E4                 7740 	clr     a
   2D55 C0 E0              7741 	push	acc
                           7742 ;     genCall
   2D57 75 82 02           7743 	mov	dpl,#0x02
   2D5A 12 22 F3           7744 	lcall	_read_keyboard_data_workloop
   2D5D AA 82              7745 	mov	r2,dpl
   2D5F AD 83              7746 	mov	r5,dph
   2D61 E5 81              7747 	mov	a,sp
   2D63 24 FC              7748 	add	a,#0xfc
   2D65 F5 81              7749 	mov	sp,a
   2D67 D0 04              7750 	pop	ar4
   2D69 D0 03              7751 	pop	ar3
                           7752 ;     genAssign
   2D6B E5 40              7753 	mov	a,_bp
   2D6D 24 02              7754 	add	a,#0x02
   2D6F F8                 7755 	mov	r0,a
   2D70 A6 02              7756 	mov	@r0,ar2
   2D72 08                 7757 	inc	r0
   2D73 A6 05              7758 	mov	@r0,ar5
                           7759 ;src/menu.c:1748: if (result != 0x99)
                           7760 ;     genCmpEq
   2D75 E5 40              7761 	mov	a,_bp
   2D77 24 02              7762 	add	a,#0x02
   2D79 F8                 7763 	mov	r0,a
   2D7A B6 99 06           7764 	cjne	@r0,#0x99,00152$
   2D7D 08                 7765 	inc	r0
   2D7E B6 00 02           7766 	cjne	@r0,#0x00,00152$
                           7767 ;       Peephole 112.b  changed ljmp to sjmp
   2D81 80 15              7768 	sjmp    00124$
   2D83                    7769 00152$:
                           7770 ;src/menu.c:1750: system_data.zone_settings[zone].temperature = result;
                           7771 ;     genPlus
                           7772 ;       Peephole 236.g  used r4 instead of ar4
   2D83 EC                 7773 	mov     a,r4
   2D84 24 0D              7774 	add	a,#_system_data
   2D86 F5 82              7775 	mov	dpl,a
                           7776 ;       Peephole 236.g  used r3 instead of ar3
   2D88 EB                 7777 	mov     a,r3
   2D89 34 00              7778 	addc	a,#(_system_data >> 8)
   2D8B F5 83              7779 	mov	dph,a
                           7780 ;     genPointerSet
                           7781 ;     genFarPointerSet
   2D8D E5 40              7782 	mov	a,_bp
   2D8F 24 02              7783 	add	a,#0x02
   2D91 F8                 7784 	mov	r0,a
   2D92 E6                 7785 	mov	a,@r0
   2D93 F0                 7786 	movx	@dptr,a
   2D94 A3                 7787 	inc	dptr
   2D95 08                 7788 	inc	r0
   2D96 E6                 7789 	mov	a,@r0
   2D97 F0                 7790 	movx	@dptr,a
   2D98                    7791 00124$:
                           7792 ;src/menu.c:1757: xram = &system_data.zone_settings[zone];
                           7793 ;     genPlus
                           7794 ;       Peephole 236.g  used r4 instead of ar4
   2D98 EC                 7795 	mov     a,r4
   2D99 24 0D              7796 	add	a,#_system_data
   2D9B FC                 7797 	mov	r4,a
                           7798 ;       Peephole 236.g  used r3 instead of ar3
   2D9C EB                 7799 	mov     a,r3
   2D9D 34 00              7800 	addc	a,#(_system_data >> 8)
   2D9F FB                 7801 	mov	r3,a
                           7802 ;     genCast
   2DA0 E5 40              7803 	mov	a,_bp
   2DA2 24 06              7804 	add	a,#0x06
   2DA4 F8                 7805 	mov	r0,a
   2DA5 A6 04              7806 	mov	@r0,ar4
   2DA7 08                 7807 	inc	r0
   2DA8 A6 03              7808 	mov	@r0,ar3
   2DAA 08                 7809 	inc	r0
   2DAB 76 01              7810 	mov	@r0,#0x1
                           7811 ;src/menu.c:1758: flash = (unsigned char*)(dfp + zone*ZONE_SETTING_SIZE);
                           7812 ;     genMult
                           7813 ;       Peephole 212    reduced add sequence to inc
   2DAD A8 40              7814 	mov     r0,_bp
   2DAF 08                 7815 	inc     r0
                           7816 ;     genMultOneByte
   2DB0 E6                 7817 	mov	a,@r0
   2DB1 75 F0 0A           7818 	mov	b,#0x0A
   2DB4 A4                 7819 	mul	ab
   2DB5 FD                 7820 	mov	r5,a
   2DB6 AE F0              7821 	mov	r6,b
                           7822 ;     genAssign
   2DB8 90 38 12           7823 	mov	dptr,#_dfp
   2DBB E4                 7824 	clr	a
   2DBC 93                 7825 	movc	a,@a+dptr
   2DBD FF                 7826 	mov	r7,a
   2DBE 74 01              7827 	mov	a,#0x01
   2DC0 93                 7828 	movc	a,@a+dptr
   2DC1 FA                 7829 	mov	r2,a
                           7830 ;     genPlus
                           7831 ;       Peephole 236.g  used r5 instead of ar5
   2DC2 ED                 7832 	mov     a,r5
                           7833 ;       Peephole 236.a  used r7 instead of ar7
   2DC3 2F                 7834 	add     a,r7
   2DC4 FD                 7835 	mov	r5,a
                           7836 ;       Peephole 236.g  used r6 instead of ar6
   2DC5 EE                 7837 	mov     a,r6
                           7838 ;       Peephole 236.b  used r2 instead of ar2
   2DC6 3A                 7839 	addc    a,r2
   2DC7 FE                 7840 	mov	r6,a
                           7841 ;     genCast
   2DC8 8D 02              7842 	mov	ar2,r5
   2DCA 8E 03              7843 	mov	ar3,r6
   2DCC 7C 02              7844 	mov	r4,#0x2
                           7845 ;src/menu.c:1759: for(count=0; count < ZONE_SETTING_SIZE; count++)
                           7846 ;     genAssign
                           7847 ;     genAssign
   2DCE E5 40              7848 	mov	a,_bp
   2DD0 24 06              7849 	add	a,#0x06
   2DD2 F8                 7850 	mov	r0,a
   2DD3 E5 40              7851 	mov	a,_bp
   2DD5 24 0D              7852 	add	a,#0x0d
   2DD7 F9                 7853 	mov	r1,a
   2DD8 E6                 7854 	mov	a,@r0
   2DD9 F7                 7855 	mov	@r1,a
   2DDA 08                 7856 	inc	r0
   2DDB 09                 7857 	inc	r1
   2DDC E6                 7858 	mov	a,@r0
   2DDD F7                 7859 	mov	@r1,a
   2DDE 08                 7860 	inc	r0
   2DDF 09                 7861 	inc	r1
   2DE0 E6                 7862 	mov	a,@r0
   2DE1 F7                 7863 	mov	@r1,a
                           7864 ;     genAssign
   2DE2 E5 40              7865 	mov	a,_bp
   2DE4 24 09              7866 	add	a,#0x09
   2DE6 F8                 7867 	mov	r0,a
   2DE7 76 00              7868 	mov	@r0,#0x00
   2DE9                    7869 00125$:
                           7870 ;     genCmpLt
   2DE9 E5 40              7871 	mov	a,_bp
   2DEB 24 09              7872 	add	a,#0x09
   2DED F8                 7873 	mov	r0,a
                           7874 ;     genCmp
   2DEE B6 0A 00           7875 	cjne	@r0,#0x0A,00153$
   2DF1                    7876 00153$:
                           7877 ;     genIfxJump
                           7878 ;       Peephole 108    removed ljmp by inverse jump logic
   2DF1 50 4B              7879 	jnc     00128$
   2DF3                    7880 00154$:
                           7881 ;src/menu.c:1761: flash_write_byte(*xram++, (unsigned int)flash++);
                           7882 ;     genAssign
   2DF3 8A 06              7883 	mov	ar6,r2
   2DF5 8B 07              7884 	mov	ar7,r3
   2DF7 8C 05              7885 	mov	ar5,r4
                           7886 ;     genPlus
                           7887 ;     genPlusIncr
   2DF9 0A                 7888 	inc	r2
   2DFA BA 00 01           7889 	cjne	r2,#0x00,00155$
   2DFD 0B                 7890 	inc	r3
   2DFE                    7891 00155$:
                           7892 ;     genCast
                           7893 ;     genPointerGet
                           7894 ;     genGenPointerGet
   2DFE E5 40              7895 	mov	a,_bp
   2E00 24 0D              7896 	add	a,#0x0d
   2E02 F8                 7897 	mov	r0,a
   2E03 86 82              7898 	mov	dpl,@r0
   2E05 08                 7899 	inc	r0
   2E06 86 83              7900 	mov	dph,@r0
   2E08 08                 7901 	inc	r0
   2E09 86 F0              7902 	mov	b,@r0
   2E0B 12 71 F5           7903 	lcall	__gptrget
   2E0E FD                 7904 	mov	r5,a
   2E0F A3                 7905 	inc	dptr
   2E10 18                 7906 	dec	r0
   2E11 18                 7907 	dec	r0
   2E12 A6 82              7908 	mov	@r0,dpl
   2E14 08                 7909 	inc	r0
   2E15 A6 83              7910 	mov	@r0,dph
                           7911 ;     genIpush
   2E17 C0 02              7912 	push	ar2
   2E19 C0 03              7913 	push	ar3
   2E1B C0 04              7914 	push	ar4
   2E1D C0 06              7915 	push	ar6
   2E1F C0 07              7916 	push	ar7
                           7917 ;     genCall
   2E21 8D 82              7918 	mov	dpl,r5
   2E23 12 00 F5           7919 	lcall	_flash_write_byte
   2E26 15 81              7920 	dec	sp
   2E28 15 81              7921 	dec	sp
   2E2A D0 04              7922 	pop	ar4
   2E2C D0 03              7923 	pop	ar3
   2E2E D0 02              7924 	pop	ar2
                           7925 ;src/menu.c:1762: SERVICE_WATCHDOG;
                           7926 ;     genAssign
   2E30 75 A6 1E           7927 	mov	_WDTRST,#0x1E
                           7928 ;     genAssign
   2E33 75 A6 E1           7929 	mov	_WDTRST,#0xE1
                           7930 ;src/menu.c:1759: for(count=0; count < ZONE_SETTING_SIZE; count++)
                           7931 ;     genPlus
   2E36 E5 40              7932 	mov	a,_bp
   2E38 24 09              7933 	add	a,#0x09
   2E3A F8                 7934 	mov	r0,a
                           7935 ;     genPlusIncr
   2E3B 06                 7936 	inc	@r0
                           7937 ;       Peephole 112.b  changed ljmp to sjmp
   2E3C 80 AB              7938 	sjmp    00125$
   2E3E                    7939 00128$:
                           7940 ;src/menu.c:1765: lcd_cursor_off();
                           7941 ;     genCall
   2E3E 12 0C 45           7942 	lcall	_lcd_cursor_off
                           7943 ;src/menu.c:1766: menu_previous_position();
                           7944 ;     genCall
   2E41 12 1F 17           7945 	lcall	_menu_previous_position
                           7946 ;src/menu.c:1767: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
                           7947 ;     genIpush
   2E44 C0 31              7948 	push	_current_display_state
                           7949 ;     genCall
   2E46 75 82 00           7950 	mov	dpl,#0x00
   2E49 12 6D A5           7951 	lcall	_ds1302_write_memory
   2E4C 15 81              7952 	dec	sp
   2E4E                    7953 00129$:
   2E4E 85 40 81           7954 	mov	sp,_bp
   2E51 D0 40              7955 	pop	_bp
   2E53 22                 7956 	ret
                           7957 ;------------------------------------------------------------
                           7958 ;Allocation info for local variables in function 'time_workloop'
                           7959 ;------------------------------------------------------------
                           7960 ;result                    Allocated to stack - offset 1
                           7961 ;display                   Allocated to stack - offset 3
                           7962 ;------------------------------------------------------------
                           7963 ;src/menu.c:1770: void time_workloop(void)
                           7964 ;	-----------------------------------------
                           7965 ;	 function time_workloop
                           7966 ;	-----------------------------------------
   2E54                    7967 _time_workloop:
   2E54 C0 40              7968 	push	_bp
   2E56 85 81 40           7969 	mov	_bp,sp
   2E59 E5 81              7970 	mov	a,sp
   2E5B 24 05              7971 	add	a,#0x05
   2E5D F5 81              7972 	mov	sp,a
                           7973 ;src/menu.c:1776: BLINKING_OFF;
                           7974 ;     genAssign
   2E5F 75 30 00           7975 	mov	_blinking,#0x00
                           7976 ;src/menu.c:1778: display = menu[current_display_state].item[current_position].display;
                           7977 ;     genMult
                           7978 ;     genMultOneByte
   2E62 E5 31              7979 	mov	a,_current_display_state
   2E64 75 F0 3C           7980 	mov	b,#0x3C
   2E67 A4                 7981 	mul	ab
                           7982 ;     genPlus
   2E68 24 0E              7983 	add	a,#_menu
   2E6A FA                 7984 	mov	r2,a
   2E6B E5 F0              7985 	mov	a,b
   2E6D 34 3C              7986 	addc	a,#(_menu >> 8)
   2E6F FB                 7987 	mov	r3,a
                           7988 ;     genPlus
                           7989 ;     genPlusIncr
   2E70 74 04              7990 	mov	a,#0x04
                           7991 ;       Peephole 236.a  used r2 instead of ar2
   2E72 2A                 7992 	add     a,r2
   2E73 FA                 7993 	mov	r2,a
                           7994 ;       Peephole 181    changed mov to clr
   2E74 E4                 7995 	clr     a
                           7996 ;       Peephole 236.b  used r3 instead of ar3
   2E75 3B                 7997 	addc    a,r3
   2E76 FB                 7998 	mov	r3,a
                           7999 ;     genMult
                           8000 ;     genMultOneByte
   2E77 E5 32              8001 	mov	a,_current_position
   2E79 75 F0 08           8002 	mov	b,#0x08
   2E7C A4                 8003 	mul	ab
                           8004 ;     genPlus
                           8005 ;       Peephole 236.a  used r2 instead of ar2
   2E7D 2A                 8006 	add     a,r2
   2E7E FA                 8007 	mov	r2,a
   2E7F E5 F0              8008 	mov	a,b
                           8009 ;       Peephole 236.b  used r3 instead of ar3
   2E81 3B                 8010 	addc    a,r3
   2E82 FB                 8011 	mov	r3,a
                           8012 ;     genPlus
   2E83 74 05              8013 	mov	a,#0x05
                           8014 ;       Peephole 236.a  used r2 instead of ar2
   2E85 2A                 8015 	add     a,r2
   2E86 F5 82              8016 	mov	dpl,a
                           8017 ;       Peephole 181    changed mov to clr
   2E88 E4                 8018 	clr     a
                           8019 ;       Peephole 236.b  used r3 instead of ar3
   2E89 3B                 8020 	addc    a,r3
   2E8A F5 83              8021 	mov	dph,a
                           8022 ;     genPointerGet
                           8023 ;     genCodePointerGet
                           8024 ;       Peephole 181    changed mov to clr
   2E8C E4                 8025 	clr     a
   2E8D 93                 8026 	movc	a,@a+dptr
   2E8E FA                 8027 	mov	r2,a
   2E8F 74 01              8028 	mov	a,#0x01
   2E91 93                 8029 	movc	a,@a+dptr
   2E92 FB                 8030 	mov	r3,a
   2E93 74 02              8031 	mov	a,#0x02
   2E95 93                 8032 	movc	a,@a+dptr
   2E96 FC                 8033 	mov	r4,a
                           8034 ;     genAssign
   2E97 E5 40              8035 	mov	a,_bp
   2E99 24 03              8036 	add	a,#0x03
   2E9B F8                 8037 	mov	r0,a
   2E9C A6 02              8038 	mov	@r0,ar2
   2E9E 08                 8039 	inc	r0
   2E9F A6 03              8040 	mov	@r0,ar3
   2EA1 08                 8041 	inc	r0
   2EA2 A6 04              8042 	mov	@r0,ar4
                           8043 ;src/menu.c:1780: lcd_goto_xy(display->x, display->y+1);
                           8044 ;     genPlus
   2EA4 E5 40              8045 	mov	a,_bp
   2EA6 24 03              8046 	add	a,#0x03
   2EA8 F8                 8047 	mov	r0,a
                           8048 ;     genPlusIncr
   2EA9 74 01              8049 	mov	a,#0x01
   2EAB 26                 8050 	add	a,@r0
   2EAC FD                 8051 	mov	r5,a
                           8052 ;       Peephole 181    changed mov to clr
   2EAD E4                 8053 	clr     a
   2EAE 08                 8054 	inc	r0
   2EAF 36                 8055 	addc	a,@r0
   2EB0 FE                 8056 	mov	r6,a
   2EB1 08                 8057 	inc	r0
   2EB2 86 07              8058 	mov	ar7,@r0
                           8059 ;     genPointerGet
                           8060 ;     genGenPointerGet
   2EB4 8D 82              8061 	mov	dpl,r5
   2EB6 8E 83              8062 	mov	dph,r6
   2EB8 8F F0              8063 	mov	b,r7
   2EBA 12 71 F5           8064 	lcall	__gptrget
                           8065 ;     genPlus
                           8066 ;     genPlusIncr
                           8067 ;       Peephole 185    changed order of increment (acc incremented also!)
   2EBD 04                 8068 	inc     a
   2EBE FD                 8069 	mov     r5,a
                           8070 ;     genPointerGet
                           8071 ;     genGenPointerGet
   2EBF E5 40              8072 	mov	a,_bp
   2EC1 24 03              8073 	add	a,#0x03
   2EC3 F8                 8074 	mov	r0,a
   2EC4 86 82              8075 	mov	dpl,@r0
   2EC6 08                 8076 	inc	r0
   2EC7 86 83              8077 	mov	dph,@r0
   2EC9 08                 8078 	inc	r0
   2ECA 86 F0              8079 	mov	b,@r0
   2ECC 12 71 F5           8080 	lcall	__gptrget
   2ECF FE                 8081 	mov	r6,a
                           8082 ;     genIpush
   2ED0 C0 05              8083 	push	ar5
                           8084 ;     genCall
   2ED2 8E 82              8085 	mov	dpl,r6
   2ED4 12 0A CD           8086 	lcall	_lcd_goto_xy
   2ED7 15 81              8087 	dec	sp
                           8088 ;src/menu.c:1781: lcd_cursor_on();
                           8089 ;     genCall
   2ED9 12 0C 2E           8090 	lcall	_lcd_cursor_on
                           8091 ;src/menu.c:1782: ds1302_read_rtc_bcd(&system_time);
                           8092 ;     genCall
                           8093 ;       Peephole 182.a  used 16 bit load of DPTR
   2EDC 90 01 81           8094 	mov     dptr,#_system_time
   2EDF 75 F0 01           8095 	mov	b,#0x01
   2EE2 12 60 DC           8096 	lcall	_ds1302_read_rtc_bcd
                           8097 ;src/menu.c:1784: result = read_keyboard_data_workloop(2,system_time.tm_hour,0,true);
                           8098 ;     genPointerGet
                           8099 ;     genFarPointerGet
   2EE5 90 01 83           8100 	mov	dptr,#(_system_time + 0x0002)
   2EE8 E0                 8101 	movx	a,@dptr
   2EE9 FD                 8102 	mov	r5,a
                           8103 ;     genCast
   2EEA 7E 00              8104 	mov	r6,#0x00
                           8105 ;     genIpush
   2EEC 74 01              8106 	mov	a,#0x01
   2EEE C0 E0              8107 	push	acc
                           8108 ;     genIpush
                           8109 ;       Peephole 181    changed mov to clr
   2EF0 E4                 8110 	clr     a
   2EF1 C0 E0              8111 	push	acc
                           8112 ;     genIpush
   2EF3 C0 05              8113 	push	ar5
   2EF5 C0 06              8114 	push	ar6
                           8115 ;     genCall
   2EF7 75 82 02           8116 	mov	dpl,#0x02
   2EFA 12 22 F3           8117 	lcall	_read_keyboard_data_workloop
   2EFD AD 82              8118 	mov	r5,dpl
   2EFF AE 83              8119 	mov	r6,dph
   2F01 E5 81              8120 	mov	a,sp
   2F03 24 FC              8121 	add	a,#0xfc
   2F05 F5 81              8122 	mov	sp,a
                           8123 ;     genAssign
                           8124 ;       Peephole 212    reduced add sequence to inc
   2F07 A8 40              8125 	mov     r0,_bp
   2F09 08                 8126 	inc     r0
   2F0A A6 05              8127 	mov	@r0,ar5
   2F0C 08                 8128 	inc	r0
   2F0D A6 06              8129 	mov	@r0,ar6
                           8130 ;src/menu.c:1785: if (result != system_time.tm_hour)
                           8131 ;     genPointerGet
                           8132 ;     genFarPointerGet
   2F0F 90 01 83           8133 	mov	dptr,#(_system_time + 0x0002)
   2F12 E0                 8134 	movx	a,@dptr
   2F13 FF                 8135 	mov	r7,a
                           8136 ;     genCast
   2F14 7D 00              8137 	mov	r5,#0x00
                           8138 ;     genCmpEq
                           8139 ;       Peephole 212    reduced add sequence to inc
   2F16 A8 40              8140 	mov     r0,_bp
   2F18 08                 8141 	inc     r0
   2F19 E6                 8142 	mov	a,@r0
   2F1A B5 07 07           8143 	cjne	a,ar7,00121$
   2F1D 08                 8144 	inc	r0
   2F1E E6                 8145 	mov	a,@r0
   2F1F B5 05 02           8146 	cjne	a,ar5,00121$
                           8147 ;       Peephole 112.b  changed ljmp to sjmp
   2F22 80 16              8148 	sjmp    00104$
   2F24                    8149 00121$:
                           8150 ;src/menu.c:1787: if (result <= 0x23)
                           8151 ;     genCmpGt
                           8152 ;       Peephole 212    reduced add sequence to inc
   2F24 A8 40              8153 	mov     r0,_bp
   2F26 08                 8154 	inc     r0
                           8155 ;     genCmp
   2F27 C3                 8156 	clr	c
   2F28 74 23              8157 	mov	a,#0x23
   2F2A 96                 8158 	subb	a,@r0
                           8159 ;       Peephole 181    changed mov to clr
   2F2B E4                 8160 	clr     a
   2F2C 08                 8161 	inc	r0
   2F2D 96                 8162 	subb	a,@r0
                           8163 ;     genIfxJump
                           8164 ;       Peephole 112.b  changed ljmp to sjmp
                           8165 ;       Peephole 160    removed sjmp by inverse jump logic
   2F2E 40 0A              8166 	jc      00104$
   2F30                    8167 00122$:
                           8168 ;src/menu.c:1789: system_time.tm_hour = (unsigned char)result&0xff;
                           8169 ;     genCast
                           8170 ;       Peephole 212    reduced add sequence to inc
   2F30 A8 40              8171 	mov     r0,_bp
   2F32 08                 8172 	inc     r0
   2F33 86 05              8173 	mov	ar5,@r0
                           8174 ;     genPointerSet
                           8175 ;     genFarPointerSet
   2F35 90 01 83           8176 	mov	dptr,#(_system_time + 0x0002)
   2F38 ED                 8177 	mov	a,r5
   2F39 F0                 8178 	movx	@dptr,a
   2F3A                    8179 00104$:
                           8180 ;src/menu.c:1793: lcd_goto_xy(display->x+3, display->y+1);
                           8181 ;     genPlus
   2F3A E5 40              8182 	mov	a,_bp
   2F3C 24 03              8183 	add	a,#0x03
   2F3E F8                 8184 	mov	r0,a
                           8185 ;     genPlusIncr
   2F3F 74 01              8186 	mov	a,#0x01
   2F41 26                 8187 	add	a,@r0
   2F42 FD                 8188 	mov	r5,a
                           8189 ;       Peephole 181    changed mov to clr
   2F43 E4                 8190 	clr     a
   2F44 08                 8191 	inc	r0
   2F45 36                 8192 	addc	a,@r0
   2F46 FE                 8193 	mov	r6,a
   2F47 08                 8194 	inc	r0
   2F48 86 07              8195 	mov	ar7,@r0
                           8196 ;     genPointerGet
                           8197 ;     genGenPointerGet
   2F4A 8D 82              8198 	mov	dpl,r5
   2F4C 8E 83              8199 	mov	dph,r6
   2F4E 8F F0              8200 	mov	b,r7
   2F50 12 71 F5           8201 	lcall	__gptrget
                           8202 ;     genPlus
                           8203 ;     genPlusIncr
                           8204 ;       Peephole 185    changed order of increment (acc incremented also!)
   2F53 04                 8205 	inc     a
   2F54 FA                 8206 	mov     r2,a
                           8207 ;     genPointerGet
                           8208 ;     genGenPointerGet
   2F55 E5 40              8209 	mov	a,_bp
   2F57 24 03              8210 	add	a,#0x03
   2F59 F8                 8211 	mov	r0,a
   2F5A 86 82              8212 	mov	dpl,@r0
   2F5C 08                 8213 	inc	r0
   2F5D 86 83              8214 	mov	dph,@r0
   2F5F 08                 8215 	inc	r0
   2F60 86 F0              8216 	mov	b,@r0
   2F62 12 71 F5           8217 	lcall	__gptrget
   2F65 FB                 8218 	mov	r3,a
                           8219 ;     genPlus
                           8220 ;     genPlusIncr
   2F66 74 03              8221 	mov	a,#0x03
                           8222 ;       Peephole 236.a  used r3 instead of ar3
   2F68 2B                 8223 	add     a,r3
   2F69 F5 82              8224 	mov	dpl,a
                           8225 ;     genIpush
   2F6B C0 05              8226 	push	ar5
   2F6D C0 06              8227 	push	ar6
   2F6F C0 07              8228 	push	ar7
   2F71 C0 02              8229 	push	ar2
                           8230 ;     genCall
   2F73 12 0A CD           8231 	lcall	_lcd_goto_xy
   2F76 15 81              8232 	dec	sp
   2F78 D0 07              8233 	pop	ar7
   2F7A D0 06              8234 	pop	ar6
   2F7C D0 05              8235 	pop	ar5
                           8236 ;src/menu.c:1795: result = read_keyboard_data_workloop(2,system_time.tm_min,0,true);
                           8237 ;     genPointerGet
                           8238 ;     genFarPointerGet
   2F7E 90 01 82           8239 	mov	dptr,#(_system_time + 0x0001)
   2F81 E0                 8240 	movx	a,@dptr
   2F82 FA                 8241 	mov	r2,a
                           8242 ;     genCast
   2F83 7B 00              8243 	mov	r3,#0x00
                           8244 ;     genIpush
   2F85 C0 05              8245 	push	ar5
   2F87 C0 06              8246 	push	ar6
   2F89 C0 07              8247 	push	ar7
   2F8B 74 01              8248 	mov	a,#0x01
   2F8D C0 E0              8249 	push	acc
                           8250 ;     genIpush
                           8251 ;       Peephole 181    changed mov to clr
   2F8F E4                 8252 	clr     a
   2F90 C0 E0              8253 	push	acc
                           8254 ;     genIpush
   2F92 C0 02              8255 	push	ar2
   2F94 C0 03              8256 	push	ar3
                           8257 ;     genCall
   2F96 75 82 02           8258 	mov	dpl,#0x02
   2F99 12 22 F3           8259 	lcall	_read_keyboard_data_workloop
   2F9C AA 82              8260 	mov	r2,dpl
   2F9E AB 83              8261 	mov	r3,dph
   2FA0 E5 81              8262 	mov	a,sp
   2FA2 24 FC              8263 	add	a,#0xfc
   2FA4 F5 81              8264 	mov	sp,a
   2FA6 D0 07              8265 	pop	ar7
   2FA8 D0 06              8266 	pop	ar6
   2FAA D0 05              8267 	pop	ar5
                           8268 ;     genAssign
                           8269 ;       Peephole 212    reduced add sequence to inc
   2FAC A8 40              8270 	mov     r0,_bp
   2FAE 08                 8271 	inc     r0
   2FAF A6 02              8272 	mov	@r0,ar2
   2FB1 08                 8273 	inc	r0
   2FB2 A6 03              8274 	mov	@r0,ar3
                           8275 ;src/menu.c:1796: if (result != system_time.tm_min)
                           8276 ;     genPointerGet
                           8277 ;     genFarPointerGet
   2FB4 90 01 82           8278 	mov	dptr,#(_system_time + 0x0001)
   2FB7 E0                 8279 	movx	a,@dptr
   2FB8 FA                 8280 	mov	r2,a
                           8281 ;     genCast
   2FB9 7B 00              8282 	mov	r3,#0x00
                           8283 ;     genCmpEq
                           8284 ;       Peephole 212    reduced add sequence to inc
   2FBB A8 40              8285 	mov     r0,_bp
   2FBD 08                 8286 	inc     r0
   2FBE E6                 8287 	mov	a,@r0
   2FBF B5 02 07           8288 	cjne	a,ar2,00123$
   2FC2 08                 8289 	inc	r0
   2FC3 E6                 8290 	mov	a,@r0
   2FC4 B5 03 02           8291 	cjne	a,ar3,00123$
                           8292 ;       Peephole 112.b  changed ljmp to sjmp
   2FC7 80 16              8293 	sjmp    00108$
   2FC9                    8294 00123$:
                           8295 ;src/menu.c:1798: if (result <= 0x59)
                           8296 ;     genCmpGt
                           8297 ;       Peephole 212    reduced add sequence to inc
   2FC9 A8 40              8298 	mov     r0,_bp
   2FCB 08                 8299 	inc     r0
                           8300 ;     genCmp
   2FCC C3                 8301 	clr	c
   2FCD 74 59              8302 	mov	a,#0x59
   2FCF 96                 8303 	subb	a,@r0
                           8304 ;       Peephole 181    changed mov to clr
   2FD0 E4                 8305 	clr     a
   2FD1 08                 8306 	inc	r0
   2FD2 96                 8307 	subb	a,@r0
                           8308 ;     genIfxJump
                           8309 ;       Peephole 112.b  changed ljmp to sjmp
                           8310 ;       Peephole 160    removed sjmp by inverse jump logic
   2FD3 40 0A              8311 	jc      00108$
   2FD5                    8312 00124$:
                           8313 ;src/menu.c:1800: system_time.tm_min = (unsigned char)result&0xff;
                           8314 ;     genCast
                           8315 ;       Peephole 212    reduced add sequence to inc
   2FD5 A8 40              8316 	mov     r0,_bp
   2FD7 08                 8317 	inc     r0
   2FD8 86 02              8318 	mov	ar2,@r0
                           8319 ;     genPointerSet
                           8320 ;     genFarPointerSet
   2FDA 90 01 82           8321 	mov	dptr,#(_system_time + 0x0001)
   2FDD EA                 8322 	mov	a,r2
   2FDE F0                 8323 	movx	@dptr,a
   2FDF                    8324 00108$:
                           8325 ;src/menu.c:1804: lcd_goto_xy(display->x+6, display->y+1);
                           8326 ;     genPointerGet
                           8327 ;     genGenPointerGet
   2FDF 8D 82              8328 	mov	dpl,r5
   2FE1 8E 83              8329 	mov	dph,r6
   2FE3 8F F0              8330 	mov	b,r7
   2FE5 12 71 F5           8331 	lcall	__gptrget
                           8332 ;     genPlus
                           8333 ;     genPlusIncr
                           8334 ;       Peephole 185    changed order of increment (acc incremented also!)
   2FE8 04                 8335 	inc     a
   2FE9 FD                 8336 	mov     r5,a
                           8337 ;     genPointerGet
                           8338 ;     genGenPointerGet
   2FEA E5 40              8339 	mov	a,_bp
   2FEC 24 03              8340 	add	a,#0x03
   2FEE F8                 8341 	mov	r0,a
   2FEF 86 82              8342 	mov	dpl,@r0
   2FF1 08                 8343 	inc	r0
   2FF2 86 83              8344 	mov	dph,@r0
   2FF4 08                 8345 	inc	r0
   2FF5 86 F0              8346 	mov	b,@r0
   2FF7 12 71 F5           8347 	lcall	__gptrget
   2FFA FA                 8348 	mov	r2,a
                           8349 ;     genPlus
   2FFB 74 06              8350 	mov	a,#0x06
                           8351 ;       Peephole 236.a  used r2 instead of ar2
   2FFD 2A                 8352 	add     a,r2
   2FFE F5 82              8353 	mov	dpl,a
                           8354 ;     genIpush
   3000 C0 05              8355 	push	ar5
                           8356 ;     genCall
   3002 12 0A CD           8357 	lcall	_lcd_goto_xy
   3005 15 81              8358 	dec	sp
                           8359 ;src/menu.c:1806: result = read_keyboard_data_workloop(2,system_time.tm_sec,0,true);
                           8360 ;     genPointerGet
                           8361 ;     genFarPointerGet
   3007 90 01 81           8362 	mov	dptr,#_system_time
   300A E0                 8363 	movx	a,@dptr
   300B FA                 8364 	mov	r2,a
                           8365 ;     genCast
   300C 7B 00              8366 	mov	r3,#0x00
                           8367 ;     genIpush
   300E 74 01              8368 	mov	a,#0x01
   3010 C0 E0              8369 	push	acc
                           8370 ;     genIpush
                           8371 ;       Peephole 181    changed mov to clr
   3012 E4                 8372 	clr     a
   3013 C0 E0              8373 	push	acc
                           8374 ;     genIpush
   3015 C0 02              8375 	push	ar2
   3017 C0 03              8376 	push	ar3
                           8377 ;     genCall
   3019 75 82 02           8378 	mov	dpl,#0x02
   301C 12 22 F3           8379 	lcall	_read_keyboard_data_workloop
   301F AA 82              8380 	mov	r2,dpl
   3021 AB 83              8381 	mov	r3,dph
   3023 E5 81              8382 	mov	a,sp
   3025 24 FC              8383 	add	a,#0xfc
   3027 F5 81              8384 	mov	sp,a
                           8385 ;     genAssign
                           8386 ;       Peephole 212    reduced add sequence to inc
   3029 A8 40              8387 	mov     r0,_bp
   302B 08                 8388 	inc     r0
   302C A6 02              8389 	mov	@r0,ar2
   302E 08                 8390 	inc	r0
   302F A6 03              8391 	mov	@r0,ar3
                           8392 ;src/menu.c:1807: if (result != system_time.tm_sec)
                           8393 ;     genPointerGet
                           8394 ;     genFarPointerGet
   3031 90 01 81           8395 	mov	dptr,#_system_time
   3034 E0                 8396 	movx	a,@dptr
   3035 FA                 8397 	mov	r2,a
                           8398 ;     genCast
   3036 7B 00              8399 	mov	r3,#0x00
                           8400 ;     genCmpEq
                           8401 ;       Peephole 212    reduced add sequence to inc
   3038 A8 40              8402 	mov     r0,_bp
   303A 08                 8403 	inc     r0
   303B E6                 8404 	mov	a,@r0
   303C B5 02 07           8405 	cjne	a,ar2,00125$
   303F 08                 8406 	inc	r0
   3040 E6                 8407 	mov	a,@r0
   3041 B5 03 02           8408 	cjne	a,ar3,00125$
                           8409 ;       Peephole 112.b  changed ljmp to sjmp
   3044 80 16              8410 	sjmp    00112$
   3046                    8411 00125$:
                           8412 ;src/menu.c:1809: if (result <= 0x59)
                           8413 ;     genCmpGt
                           8414 ;       Peephole 212    reduced add sequence to inc
   3046 A8 40              8415 	mov     r0,_bp
   3048 08                 8416 	inc     r0
                           8417 ;     genCmp
   3049 C3                 8418 	clr	c
   304A 74 59              8419 	mov	a,#0x59
   304C 96                 8420 	subb	a,@r0
                           8421 ;       Peephole 181    changed mov to clr
   304D E4                 8422 	clr     a
   304E 08                 8423 	inc	r0
   304F 96                 8424 	subb	a,@r0
                           8425 ;     genIfxJump
                           8426 ;       Peephole 112.b  changed ljmp to sjmp
                           8427 ;       Peephole 160    removed sjmp by inverse jump logic
   3050 40 0A              8428 	jc      00112$
   3052                    8429 00126$:
                           8430 ;src/menu.c:1811: system_time.tm_sec = (unsigned char)result&0xff;
                           8431 ;     genCast
                           8432 ;       Peephole 212    reduced add sequence to inc
   3052 A8 40              8433 	mov     r0,_bp
   3054 08                 8434 	inc     r0
   3055 86 02              8435 	mov	ar2,@r0
                           8436 ;     genPointerSet
                           8437 ;     genFarPointerSet
   3057 90 01 81           8438 	mov	dptr,#_system_time
   305A EA                 8439 	mov	a,r2
   305B F0                 8440 	movx	@dptr,a
   305C                    8441 00112$:
                           8442 ;src/menu.c:1815: ds1302_write_rtc(&system_time);
                           8443 ;     genCall
                           8444 ;       Peephole 182.a  used 16 bit load of DPTR
   305C 90 01 81           8445 	mov     dptr,#_system_time
   305F 75 F0 01           8446 	mov	b,#0x01
   3062 12 62 54           8447 	lcall	_ds1302_write_rtc
                           8448 ;src/menu.c:1817: lcd_cursor_off();
                           8449 ;     genCall
   3065 12 0C 45           8450 	lcall	_lcd_cursor_off
                           8451 ;src/menu.c:1818: menu_previous_position();
                           8452 ;     genCall
   3068 12 1F 17           8453 	lcall	_menu_previous_position
                           8454 ;src/menu.c:1821: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
                           8455 ;     genIpush
   306B C0 31              8456 	push	_current_display_state
                           8457 ;     genCall
   306D 75 82 00           8458 	mov	dpl,#0x00
   3070 12 6D A5           8459 	lcall	_ds1302_write_memory
   3073 15 81              8460 	dec	sp
   3075                    8461 00113$:
   3075 85 40 81           8462 	mov	sp,_bp
   3078 D0 40              8463 	pop	_bp
   307A 22                 8464 	ret
                           8465 ;------------------------------------------------------------
                           8466 ;Allocation info for local variables in function 'date_workloop'
                           8467 ;------------------------------------------------------------
                           8468 ;isBCD                     Allocated to stack - offset 1
                           8469 ;result                    Allocated to registers r2 r6 
                           8470 ;ib                        Allocated to registers 
                           8471 ;display                   Allocated to stack - offset 2
                           8472 ;sloc0                     Allocated to stack - offset 8
                           8473 ;sloc1                     Allocated to stack - offset 5
                           8474 ;------------------------------------------------------------
                           8475 ;src/menu.c:1832: void date_workloop(const unsigned char isBCD)
                           8476 ;	-----------------------------------------
                           8477 ;	 function date_workloop
                           8478 ;	-----------------------------------------
   307B                    8479 _date_workloop:
   307B C0 40              8480 	push	_bp
   307D 85 81 40           8481 	mov	_bp,sp
   3080 E5 81              8482 	mov	a,sp
   3082 24 07              8483 	add	a,#0x07
   3084 F5 81              8484 	mov	sp,a
                           8485 ;     genReceive
   3086 C0 E0              8486 	push	acc
                           8487 ;       Peephole 212    reduced add sequence to inc
   3088 A8 40              8488 	mov     r0,_bp
   308A 08                 8489 	inc     r0
   308B D0 E0              8490 	pop	acc
   308D A6 82              8491 	mov	@r0,dpl
                           8492 ;src/menu.c:1840: BLINKING_OFF;
                           8493 ;     genAssign
   308F 75 30 00           8494 	mov	_blinking,#0x00
                           8495 ;src/menu.c:1842: display = menu[current_display_state].item[current_position].display;
                           8496 ;     genMult
                           8497 ;     genMultOneByte
   3092 E5 31              8498 	mov	a,_current_display_state
   3094 75 F0 3C           8499 	mov	b,#0x3C
   3097 A4                 8500 	mul	ab
                           8501 ;     genPlus
   3098 24 0E              8502 	add	a,#_menu
   309A FB                 8503 	mov	r3,a
   309B E5 F0              8504 	mov	a,b
   309D 34 3C              8505 	addc	a,#(_menu >> 8)
   309F FC                 8506 	mov	r4,a
                           8507 ;     genPlus
                           8508 ;     genPlusIncr
   30A0 74 04              8509 	mov	a,#0x04
                           8510 ;       Peephole 236.a  used r3 instead of ar3
   30A2 2B                 8511 	add     a,r3
   30A3 FB                 8512 	mov	r3,a
                           8513 ;       Peephole 181    changed mov to clr
   30A4 E4                 8514 	clr     a
                           8515 ;       Peephole 236.b  used r4 instead of ar4
   30A5 3C                 8516 	addc    a,r4
   30A6 FC                 8517 	mov	r4,a
                           8518 ;     genMult
                           8519 ;     genMultOneByte
   30A7 E5 32              8520 	mov	a,_current_position
   30A9 75 F0 08           8521 	mov	b,#0x08
   30AC A4                 8522 	mul	ab
                           8523 ;     genPlus
                           8524 ;       Peephole 236.a  used r3 instead of ar3
   30AD 2B                 8525 	add     a,r3
   30AE FB                 8526 	mov	r3,a
   30AF E5 F0              8527 	mov	a,b
                           8528 ;       Peephole 236.b  used r4 instead of ar4
   30B1 3C                 8529 	addc    a,r4
   30B2 FC                 8530 	mov	r4,a
                           8531 ;     genPlus
   30B3 74 05              8532 	mov	a,#0x05
                           8533 ;       Peephole 236.a  used r3 instead of ar3
   30B5 2B                 8534 	add     a,r3
   30B6 F5 82              8535 	mov	dpl,a
                           8536 ;       Peephole 181    changed mov to clr
   30B8 E4                 8537 	clr     a
                           8538 ;       Peephole 236.b  used r4 instead of ar4
   30B9 3C                 8539 	addc    a,r4
   30BA F5 83              8540 	mov	dph,a
                           8541 ;     genPointerGet
                           8542 ;     genCodePointerGet
                           8543 ;       Peephole 181    changed mov to clr
   30BC E4                 8544 	clr     a
   30BD 93                 8545 	movc	a,@a+dptr
   30BE FB                 8546 	mov	r3,a
   30BF 74 01              8547 	mov	a,#0x01
   30C1 93                 8548 	movc	a,@a+dptr
   30C2 FC                 8549 	mov	r4,a
   30C3 74 02              8550 	mov	a,#0x02
   30C5 93                 8551 	movc	a,@a+dptr
   30C6 FD                 8552 	mov	r5,a
                           8553 ;     genAssign
   30C7 E5 40              8554 	mov	a,_bp
   30C9 24 02              8555 	add	a,#0x02
   30CB F8                 8556 	mov	r0,a
   30CC A6 03              8557 	mov	@r0,ar3
   30CE 08                 8558 	inc	r0
   30CF A6 04              8559 	mov	@r0,ar4
   30D1 08                 8560 	inc	r0
   30D2 A6 05              8561 	mov	@r0,ar5
                           8562 ;src/menu.c:1844: lcd_goto_xy(display->x, display->y+1);
                           8563 ;     genPlus
   30D4 E5 40              8564 	mov	a,_bp
   30D6 24 02              8565 	add	a,#0x02
   30D8 F8                 8566 	mov	r0,a
                           8567 ;     genPlusIncr
   30D9 74 01              8568 	mov	a,#0x01
   30DB 26                 8569 	add	a,@r0
   30DC FE                 8570 	mov	r6,a
                           8571 ;       Peephole 181    changed mov to clr
   30DD E4                 8572 	clr     a
   30DE 08                 8573 	inc	r0
   30DF 36                 8574 	addc	a,@r0
   30E0 FF                 8575 	mov	r7,a
   30E1 08                 8576 	inc	r0
   30E2 86 02              8577 	mov	ar2,@r0
                           8578 ;     genPointerGet
                           8579 ;     genGenPointerGet
   30E4 8E 82              8580 	mov	dpl,r6
   30E6 8F 83              8581 	mov	dph,r7
   30E8 8A F0              8582 	mov	b,r2
   30EA 12 71 F5           8583 	lcall	__gptrget
                           8584 ;     genPlus
                           8585 ;     genPlusIncr
                           8586 ;       Peephole 185    changed order of increment (acc incremented also!)
   30ED 04                 8587 	inc     a
   30EE FE                 8588 	mov     r6,a
                           8589 ;     genPointerGet
                           8590 ;     genGenPointerGet
   30EF E5 40              8591 	mov	a,_bp
   30F1 24 02              8592 	add	a,#0x02
   30F3 F8                 8593 	mov	r0,a
   30F4 86 82              8594 	mov	dpl,@r0
   30F6 08                 8595 	inc	r0
   30F7 86 83              8596 	mov	dph,@r0
   30F9 08                 8597 	inc	r0
   30FA 86 F0              8598 	mov	b,@r0
   30FC 12 71 F5           8599 	lcall	__gptrget
   30FF FA                 8600 	mov	r2,a
                           8601 ;     genIpush
   3100 C0 06              8602 	push	ar6
                           8603 ;     genCall
   3102 8A 82              8604 	mov	dpl,r2
   3104 12 0A CD           8605 	lcall	_lcd_goto_xy
   3107 15 81              8606 	dec	sp
                           8607 ;src/menu.c:1845: lcd_cursor_on();
                           8608 ;     genCall
   3109 12 0C 2E           8609 	lcall	_lcd_cursor_on
                           8610 ;src/menu.c:1847: ds1302_read_rtc_bcd(&system_time);
                           8611 ;     genCall
                           8612 ;       Peephole 182.a  used 16 bit load of DPTR
   310C 90 01 81           8613 	mov     dptr,#_system_time
   310F 75 F0 01           8614 	mov	b,#0x01
   3112 12 60 DC           8615 	lcall	_ds1302_read_rtc_bcd
                           8616 ;src/menu.c:1849: result = read_keyboard_data_workloop(4,0x2004,0,true);
                           8617 ;     genIpush
   3115 74 01              8618 	mov	a,#0x01
   3117 C0 E0              8619 	push	acc
                           8620 ;     genIpush
                           8621 ;       Peephole 181    changed mov to clr
   3119 E4                 8622 	clr     a
   311A C0 E0              8623 	push	acc
                           8624 ;     genIpush
   311C 74 04              8625 	mov	a,#0x04
   311E C0 E0              8626 	push	acc
   3120 74 20              8627 	mov	a,#0x20
   3122 C0 E0              8628 	push	acc
                           8629 ;     genCall
   3124 75 82 04           8630 	mov	dpl,#0x04
   3127 12 22 F3           8631 	lcall	_read_keyboard_data_workloop
   312A AA 82              8632 	mov	r2,dpl
   312C AE 83              8633 	mov	r6,dph
   312E E5 81              8634 	mov	a,sp
   3130 24 FC              8635 	add	a,#0xfc
   3132 F5 81              8636 	mov	sp,a
                           8637 ;     genAssign
                           8638 ;src/menu.c:1850: if (result >= 0x2004)
                           8639 ;     genCmpLt
                           8640 ;     genCmp
   3134 C3                 8641 	clr	c
   3135 EA                 8642 	mov	a,r2
   3136 94 04              8643 	subb	a,#0x04
   3138 EE                 8644 	mov	a,r6
   3139 94 20              8645 	subb	a,#0x20
                           8646 ;     genIfxJump
                           8647 ;       Peephole 112.b  changed ljmp to sjmp
                           8648 ;       Peephole 160    removed sjmp by inverse jump logic
   313B 40 0C              8649 	jc      00102$
   313D                    8650 00112$:
                           8651 ;src/menu.c:1852: system_time.tm_year = (unsigned char)(result & 0xff);
                           8652 ;     genCast
   313D 8A 07              8653 	mov	ar7,r2
                           8654 ;     genCast
   313F 7B 00              8655 	mov	r3,#0x00
                           8656 ;     genPointerSet
                           8657 ;     genFarPointerSet
   3141 90 01 86           8658 	mov	dptr,#(_system_time + 0x0005)
   3144 EF                 8659 	mov	a,r7
   3145 F0                 8660 	movx	@dptr,a
   3146 A3                 8661 	inc	dptr
   3147 EB                 8662 	mov	a,r3
   3148 F0                 8663 	movx	@dptr,a
   3149                    8664 00102$:
                           8665 ;src/menu.c:1855: lcd_goto_xy(display->x+5, display->y+1);
                           8666 ;     genPlus
   3149 E5 40              8667 	mov	a,_bp
   314B 24 02              8668 	add	a,#0x02
   314D F8                 8669 	mov	r0,a
   314E E5 40              8670 	mov	a,_bp
   3150 24 05              8671 	add	a,#0x05
   3152 F9                 8672 	mov	r1,a
                           8673 ;     genPlusIncr
   3153 74 01              8674 	mov	a,#0x01
   3155 26                 8675 	add	a,@r0
   3156 F7                 8676 	mov	@r1,a
                           8677 ;       Peephole 181    changed mov to clr
   3157 E4                 8678 	clr     a
   3158 08                 8679 	inc	r0
   3159 36                 8680 	addc	a,@r0
   315A 09                 8681 	inc	r1
   315B F7                 8682 	mov	@r1,a
   315C 08                 8683 	inc	r0
   315D 09                 8684 	inc	r1
   315E E6                 8685 	mov	a,@r0
   315F F7                 8686 	mov	@r1,a
                           8687 ;     genPointerGet
                           8688 ;     genGenPointerGet
   3160 E5 40              8689 	mov	a,_bp
   3162 24 05              8690 	add	a,#0x05
   3164 F8                 8691 	mov	r0,a
   3165 86 82              8692 	mov	dpl,@r0
   3167 08                 8693 	inc	r0
   3168 86 83              8694 	mov	dph,@r0
   316A 08                 8695 	inc	r0
   316B 86 F0              8696 	mov	b,@r0
   316D 12 71 F5           8697 	lcall	__gptrget
   3170 FF                 8698 	mov	r7,a
                           8699 ;     genPlus
                           8700 ;     genPlusIncr
   3171 74 01              8701 	mov	a,#0x01
                           8702 ;       Peephole 236.a  used r7 instead of ar7
   3173 2F                 8703 	add     a,r7
   3174 FA                 8704 	mov	r2,a
                           8705 ;     genPointerGet
                           8706 ;     genGenPointerGet
   3175 E5 40              8707 	mov	a,_bp
   3177 24 02              8708 	add	a,#0x02
   3179 F8                 8709 	mov	r0,a
   317A 86 82              8710 	mov	dpl,@r0
   317C 08                 8711 	inc	r0
   317D 86 83              8712 	mov	dph,@r0
   317F 08                 8713 	inc	r0
   3180 86 F0              8714 	mov	b,@r0
   3182 12 71 F5           8715 	lcall	__gptrget
   3185 FF                 8716 	mov	r7,a
                           8717 ;     genPlus
   3186 74 05              8718 	mov	a,#0x05
                           8719 ;       Peephole 236.a  used r7 instead of ar7
   3188 2F                 8720 	add     a,r7
   3189 F5 82              8721 	mov	dpl,a
                           8722 ;     genIpush
   318B C0 02              8723 	push	ar2
                           8724 ;     genCall
   318D 12 0A CD           8725 	lcall	_lcd_goto_xy
   3190 15 81              8726 	dec	sp
                           8727 ;src/menu.c:1857: result = read_keyboard_data_workloop(2,system_time.tm_mon,0,false);
                           8728 ;     genPointerGet
                           8729 ;     genFarPointerGet
   3192 90 01 85           8730 	mov	dptr,#(_system_time + 0x0004)
   3195 E0                 8731 	movx	a,@dptr
   3196 FF                 8732 	mov	r7,a
                           8733 ;     genCast
                           8734 ;     genIpush
                           8735 ;       Peephole 3.a    changed mov to clr
   3197 E4                 8736 	clr     a
   3198 FB                 8737 	mov     r3,a
   3199 C0 E0              8738 	push	acc
                           8739 ;     genIpush
                           8740 ;       Peephole 181    changed mov to clr
   319B E4                 8741 	clr     a
   319C C0 E0              8742 	push	acc
                           8743 ;     genIpush
   319E C0 07              8744 	push	ar7
   31A0 C0 03              8745 	push	ar3
                           8746 ;     genCall
   31A2 75 82 02           8747 	mov	dpl,#0x02
   31A5 12 22 F3           8748 	lcall	_read_keyboard_data_workloop
   31A8 AB 82              8749 	mov	r3,dpl
   31AA AC 83              8750 	mov	r4,dph
   31AC E5 81              8751 	mov	a,sp
   31AE 24 FC              8752 	add	a,#0xfc
   31B0 F5 81              8753 	mov	sp,a
                           8754 ;     genAssign
   31B2 8B 02              8755 	mov	ar2,r3
   31B4 8C 06              8756 	mov	ar6,r4
                           8757 ;src/menu.c:1861: if (result != system_time.tm_mon)
                           8758 ;     genPointerGet
                           8759 ;     genFarPointerGet
   31B6 90 01 85           8760 	mov	dptr,#(_system_time + 0x0004)
   31B9 E0                 8761 	movx	a,@dptr
   31BA FB                 8762 	mov	r3,a
                           8763 ;     genCast
   31BB 7C 00              8764 	mov	r4,#0x00
                           8765 ;     genCmpEq
   31BD EA                 8766 	mov	a,r2
   31BE B5 03 06           8767 	cjne	a,ar3,00113$
   31C1 EE                 8768 	mov	a,r6
   31C2 B5 04 02           8769 	cjne	a,ar4,00113$
                           8770 ;       Peephole 112.b  changed ljmp to sjmp
   31C5 80 0C              8771 	sjmp    00104$
   31C7                    8772 00113$:
                           8773 ;src/menu.c:1863: result--;
                           8774 ;     genMinus
                           8775 ;     genMinusDec
   31C7 1A                 8776 	dec	r2
   31C8 BA FF 01           8777 	cjne	r2,#0xff,00114$
   31CB 1E                 8778 	dec	r6
   31CC                    8779 00114$:
                           8780 ;src/menu.c:1864: system_time.tm_mon = (unsigned char)(result & 0xff);
                           8781 ;     genCast
   31CC 8A 03              8782 	mov	ar3,r2
                           8783 ;     genPointerSet
                           8784 ;     genFarPointerSet
   31CE 90 01 85           8785 	mov	dptr,#(_system_time + 0x0004)
   31D1 EB                 8786 	mov	a,r3
   31D2 F0                 8787 	movx	@dptr,a
   31D3                    8788 00104$:
                           8789 ;src/menu.c:1867: lcd_goto_xy(display->x+8, display->y+1);
                           8790 ;     genPointerGet
                           8791 ;     genGenPointerGet
   31D3 E5 40              8792 	mov	a,_bp
   31D5 24 05              8793 	add	a,#0x05
   31D7 F8                 8794 	mov	r0,a
   31D8 86 82              8795 	mov	dpl,@r0
   31DA 08                 8796 	inc	r0
   31DB 86 83              8797 	mov	dph,@r0
   31DD 08                 8798 	inc	r0
   31DE 86 F0              8799 	mov	b,@r0
   31E0 12 71 F5           8800 	lcall	__gptrget
                           8801 ;     genPlus
                           8802 ;     genPlusIncr
                           8803 ;       Peephole 185    changed order of increment (acc incremented also!)
   31E3 04                 8804 	inc     a
   31E4 FB                 8805 	mov     r3,a
                           8806 ;     genPointerGet
                           8807 ;     genGenPointerGet
   31E5 E5 40              8808 	mov	a,_bp
   31E7 24 02              8809 	add	a,#0x02
   31E9 F8                 8810 	mov	r0,a
   31EA 86 82              8811 	mov	dpl,@r0
   31EC 08                 8812 	inc	r0
   31ED 86 83              8813 	mov	dph,@r0
   31EF 08                 8814 	inc	r0
   31F0 86 F0              8815 	mov	b,@r0
   31F2 12 71 F5           8816 	lcall	__gptrget
   31F5 FC                 8817 	mov	r4,a
                           8818 ;     genPlus
   31F6 74 08              8819 	mov	a,#0x08
                           8820 ;       Peephole 236.a  used r4 instead of ar4
   31F8 2C                 8821 	add     a,r4
   31F9 F5 82              8822 	mov	dpl,a
                           8823 ;     genIpush
   31FB C0 03              8824 	push	ar3
                           8825 ;     genCall
   31FD 12 0A CD           8826 	lcall	_lcd_goto_xy
   3200 15 81              8827 	dec	sp
                           8828 ;src/menu.c:1869: result = read_keyboard_data_workloop(2,system_time.tm_mday,0,ib);
                           8829 ;     genPointerGet
                           8830 ;     genFarPointerGet
   3202 90 01 84           8831 	mov	dptr,#(_system_time + 0x0003)
   3205 E0                 8832 	movx	a,@dptr
   3206 FB                 8833 	mov	r3,a
                           8834 ;     genCast
   3207 7C 00              8835 	mov	r4,#0x00
                           8836 ;     genIpush
                           8837 ;       Peephole 212    reduced add sequence to inc
   3209 A8 40              8838 	mov     r0,_bp
   320B 08                 8839 	inc     r0
   320C E6                 8840 	mov	a,@r0
   320D C0 E0              8841 	push	acc
                           8842 ;     genIpush
                           8843 ;       Peephole 181    changed mov to clr
   320F E4                 8844 	clr     a
   3210 C0 E0              8845 	push	acc
                           8846 ;     genIpush
   3212 C0 03              8847 	push	ar3
   3214 C0 04              8848 	push	ar4
                           8849 ;     genCall
   3216 75 82 02           8850 	mov	dpl,#0x02
   3219 12 22 F3           8851 	lcall	_read_keyboard_data_workloop
   321C AB 82              8852 	mov	r3,dpl
   321E AC 83              8853 	mov	r4,dph
   3220 E5 81              8854 	mov	a,sp
   3222 24 FC              8855 	add	a,#0xfc
   3224 F5 81              8856 	mov	sp,a
                           8857 ;     genAssign
   3226 8B 02              8858 	mov	ar2,r3
   3228 8C 06              8859 	mov	ar6,r4
                           8860 ;src/menu.c:1870: if (result != system_time.tm_mday)
                           8861 ;     genPointerGet
                           8862 ;     genFarPointerGet
   322A 90 01 84           8863 	mov	dptr,#(_system_time + 0x0003)
   322D E0                 8864 	movx	a,@dptr
   322E FB                 8865 	mov	r3,a
                           8866 ;     genCast
   322F 7C 00              8867 	mov	r4,#0x00
                           8868 ;     genCmpEq
   3231 EA                 8869 	mov	a,r2
   3232 B5 03 06           8870 	cjne	a,ar3,00115$
   3235 EE                 8871 	mov	a,r6
   3236 B5 04 02           8872 	cjne	a,ar4,00115$
                           8873 ;       Peephole 112.b  changed ljmp to sjmp
   3239 80 05              8874 	sjmp    00106$
   323B                    8875 00115$:
                           8876 ;src/menu.c:1872: system_time.tm_mday = (unsigned char)(result & 0xff);
                           8877 ;     genCast
                           8878 ;     genPointerSet
                           8879 ;     genFarPointerSet
   323B 90 01 84           8880 	mov	dptr,#(_system_time + 0x0003)
   323E EA                 8881 	mov	a,r2
   323F F0                 8882 	movx	@dptr,a
   3240                    8883 00106$:
                           8884 ;src/menu.c:1875: ds1302_write_rtc(&system_time);
                           8885 ;     genCall
                           8886 ;       Peephole 182.a  used 16 bit load of DPTR
   3240 90 01 81           8887 	mov     dptr,#_system_time
   3243 75 F0 01           8888 	mov	b,#0x01
   3246 12 62 54           8889 	lcall	_ds1302_write_rtc
                           8890 ;src/menu.c:1877: lcd_cursor_off();
                           8891 ;     genCall
   3249 12 0C 45           8892 	lcall	_lcd_cursor_off
                           8893 ;src/menu.c:1878: menu_previous_position();
                           8894 ;     genCall
   324C 12 1F 17           8895 	lcall	_menu_previous_position
                           8896 ;src/menu.c:1879: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
                           8897 ;     genIpush
   324F C0 31              8898 	push	_current_display_state
                           8899 ;     genCall
   3251 75 82 00           8900 	mov	dpl,#0x00
   3254 12 6D A5           8901 	lcall	_ds1302_write_memory
   3257 15 81              8902 	dec	sp
   3259                    8903 00107$:
   3259 85 40 81           8904 	mov	sp,_bp
   325C D0 40              8905 	pop	_bp
   325E 22                 8906 	ret
                           8907 ;------------------------------------------------------------
                           8908 ;Allocation info for local variables in function 'workloop'
                           8909 ;------------------------------------------------------------
                           8910 ;exit                      Allocated to registers r2 
                           8911 ;sloc0                     Allocated to stack - offset 2
                           8912 ;------------------------------------------------------------
                           8913 ;src/menu.c:1899: void workloop(void)
                           8914 ;	-----------------------------------------
                           8915 ;	 function workloop
                           8916 ;	-----------------------------------------
   325F                    8917 _workloop:
   325F C0 40              8918 	push	_bp
   3261 85 81 40           8919 	mov	_bp,sp
                           8920 ;src/menu.c:1901: unsigned char exit = 0;
                           8921 ;     genAssign
   3264 7A 00              8922 	mov	r2,#0x00
                           8923 ;src/menu.c:1902: BLINKING_ON;
                           8924 ;     genAssign
   3266 75 30 01           8925 	mov	_blinking,#0x01
                           8926 ;src/menu.c:1904: while(exit == 0)
   3269                    8927 00129$:
                           8928 ;     genCmpEq
   3269 BA 00 02           8929 	cjne	r2,#0x00,00151$
   326C 80 03              8930 	sjmp	00152$
   326E                    8931 00151$:
   326E 02 34 1B           8932 	ljmp	00132$
   3271                    8933 00152$:
                           8934 ;src/menu.c:1906: SERVICE_WATCHDOG;
                           8935 ;     genAssign
   3271 75 A6 1E           8936 	mov	_WDTRST,#0x1E
                           8937 ;     genAssign
   3274 75 A6 E1           8938 	mov	_WDTRST,#0xE1
                           8939 ;src/menu.c:1910: exit = check_external_events();
                           8940 ;     genCall
   3277 12 1E B1           8941 	lcall	_check_external_events
   327A AB 82              8942 	mov	r3,dpl
                           8943 ;     genAssign
   327C 8B 02              8944 	mov	ar2,r3
                           8945 ;src/menu.c:1911: if (exit == 0)
                           8946 ;     genCmpEq
                           8947 ;       Peephole 112.b  changed ljmp to sjmp
                           8948 ;       Peephole 199    optimized misc jump sequence
   327E BA 00 E8           8949 	cjne    r2,#0x00,00129$
                           8950 ;00153$:
                           8951 ;       Peephole 200    removed redundant sjmp
   3281                    8952 00154$:
                           8953 ;src/menu.c:1913: if (keypad_check_front() == DATA_AVAILABLE)
                           8954 ;     genCall
   3281 C0 02              8955 	push	ar2
   3283 12 02 9E           8956 	lcall	_keypad_check_front
   3286 AB 82              8957 	mov	r3,dpl
   3288 D0 02              8958 	pop	ar2
                           8959 ;     genCmpEq
                           8960 ;       Peephole 112.b  changed ljmp to sjmp
                           8961 ;       Peephole 199    optimized misc jump sequence
   328A BB 91 DC           8962 	cjne    r3,#0x91,00129$
                           8963 ;00155$:
                           8964 ;       Peephole 200    removed redundant sjmp
   328D                    8965 00156$:
                           8966 ;src/menu.c:1915: key_code = keypad_pop_front();
                           8967 ;     genCall
   328D C0 02              8968 	push	ar2
   328F 12 02 8C           8969 	lcall	_keypad_pop_front
   3292 85 82 33           8970 	mov	_key_code,dpl
   3295 D0 02              8971 	pop	ar2
                           8972 ;src/menu.c:1918: switch (key_code)
                           8973 ;     genCmpEq
   3297 E5 33              8974 	mov	a,_key_code
   3299 B4 10 03           8975 	cjne	a,#0x10,00157$
   329C 02 33 74           8976 	ljmp	00109$
   329F                    8977 00157$:
                           8978 ;     genCmpEq
   329F E5 33              8979 	mov	a,_key_code
   32A1 B4 11 03           8980 	cjne	a,#0x11,00158$
   32A4 02 33 45           8981 	ljmp	00106$
   32A7                    8982 00158$:
                           8983 ;     genCmpEq
   32A7 E5 33              8984 	mov	a,_key_code
   32A9 B4 13 03           8985 	cjne	a,#0x13,00159$
   32AC 02 33 33           8986 	ljmp	00105$
   32AF                    8987 00159$:
                           8988 ;     genCmpEq
   32AF E5 33              8989 	mov	a,_key_code
   32B1 B4 14 02           8990 	cjne	a,#0x14,00160$
                           8991 ;       Peephole 112.b  changed ljmp to sjmp
   32B4 80 13              8992 	sjmp    00104$
   32B6                    8993 00160$:
                           8994 ;     genCmpEq
   32B6 E5 33              8995 	mov	a,_key_code
   32B8 B4 15 03           8996 	cjne	a,#0x15,00161$
   32BB 02 33 A2           8997 	ljmp	00117$
   32BE                    8998 00161$:
                           8999 ;     genCmpEq
   32BE E5 33              9000 	mov	a,_key_code
   32C0 B4 16 03           9001 	cjne	a,#0x16,00162$
   32C3 02 33 DB           9002 	ljmp	00123$
   32C6                    9003 00162$:
   32C6 02 34 11           9004 	ljmp	00124$
                           9005 ;src/menu.c:1930: }
   32C9                    9006 00104$:
                           9007 ;src/menu.c:1921: if (menu[current_display_state].item[current_position].next == EXIT_POS_ID)
                           9008 ;     genMult
                           9009 ;     genMultOneByte
   32C9 E5 31              9010 	mov	a,_current_display_state
   32CB 75 F0 3C           9011 	mov	b,#0x3C
   32CE A4                 9012 	mul	ab
                           9013 ;     genPlus
   32CF 24 0E              9014 	add	a,#_menu
   32D1 FB                 9015 	mov	r3,a
   32D2 E5 F0              9016 	mov	a,b
   32D4 34 3C              9017 	addc	a,#(_menu >> 8)
   32D6 FC                 9018 	mov	r4,a
                           9019 ;     genPlus
                           9020 ;     genPlusIncr
   32D7 74 04              9021 	mov	a,#0x04
                           9022 ;       Peephole 236.a  used r3 instead of ar3
   32D9 2B                 9023 	add     a,r3
   32DA FD                 9024 	mov	r5,a
                           9025 ;       Peephole 181    changed mov to clr
   32DB E4                 9026 	clr     a
                           9027 ;       Peephole 236.b  used r4 instead of ar4
   32DC 3C                 9028 	addc    a,r4
   32DD FE                 9029 	mov	r6,a
                           9030 ;     genMult
                           9031 ;     genMultOneByte
   32DE E5 32              9032 	mov	a,_current_position
   32E0 75 F0 08           9033 	mov	b,#0x08
   32E3 A4                 9034 	mul	ab
   32E4 FA                 9035 	mov	r2,a
   32E5 AF F0              9036 	mov	r7,b
                           9037 ;     genPlus
                           9038 ;       Peephole 236.g  used r2 instead of ar2
   32E7 EA                 9039 	mov     a,r2
                           9040 ;       Peephole 236.a  used r5 instead of ar5
   32E8 2D                 9041 	add     a,r5
   32E9 FD                 9042 	mov	r5,a
                           9043 ;       Peephole 236.g  used r7 instead of ar7
   32EA EF                 9044 	mov     a,r7
                           9045 ;       Peephole 236.b  used r6 instead of ar6
   32EB 3E                 9046 	addc    a,r6
   32EC FE                 9047 	mov	r6,a
                           9048 ;     genPlus
                           9049 ;     genPlusIncr
   32ED 74 01              9050 	mov	a,#0x01
                           9051 ;       Peephole 236.a  used r5 instead of ar5
   32EF 2D                 9052 	add     a,r5
   32F0 F5 82              9053 	mov	dpl,a
                           9054 ;       Peephole 181    changed mov to clr
   32F2 E4                 9055 	clr     a
                           9056 ;       Peephole 236.b  used r6 instead of ar6
   32F3 3E                 9057 	addc    a,r6
   32F4 F5 83              9058 	mov	dph,a
                           9059 ;     genPointerGet
                           9060 ;     genCodePointerGet
                           9061 ;       Peephole 181    changed mov to clr
   32F6 E4                 9062 	clr     a
   32F7 93                 9063 	movc	a,@a+dptr
   32F8 FD                 9064 	mov	r5,a
                           9065 ;     genCmpEq
                           9066 ;       Peephole 112.b  changed ljmp to sjmp
                           9067 ;       Peephole 199    optimized misc jump sequence
   32F9 BD FE 05           9068 	cjne    r5,#0xFE,00102$
                           9069 ;00163$:
                           9070 ;       Peephole 200    removed redundant sjmp
   32FC                    9071 00164$:
                           9072 ;src/menu.c:1923: menu_previous_position();
                           9073 ;     genCall
   32FC 12 1F 17           9074 	lcall	_menu_previous_position
                           9075 ;       Peephole 112.b  changed ljmp to sjmp
   32FF 80 23              9076 	sjmp    00103$
   3301                    9077 00102$:
                           9078 ;src/menu.c:1927: current_display_state = menu[current_display_state].item[current_position].next;
                           9079 ;     genPlus
                           9080 ;     genPlusIncr
   3301 74 04              9081 	mov	a,#0x04
                           9082 ;       Peephole 236.a  used r3 instead of ar3
   3303 2B                 9083 	add     a,r3
   3304 FB                 9084 	mov	r3,a
                           9085 ;       Peephole 181    changed mov to clr
   3305 E4                 9086 	clr     a
                           9087 ;       Peephole 236.b  used r4 instead of ar4
   3306 3C                 9088 	addc    a,r4
   3307 FC                 9089 	mov	r4,a
                           9090 ;     genPlus
                           9091 ;       Peephole 236.g  used r2 instead of ar2
   3308 EA                 9092 	mov     a,r2
                           9093 ;       Peephole 236.a  used r3 instead of ar3
   3309 2B                 9094 	add     a,r3
   330A FB                 9095 	mov	r3,a
                           9096 ;       Peephole 236.g  used r7 instead of ar7
   330B EF                 9097 	mov     a,r7
                           9098 ;       Peephole 236.b  used r4 instead of ar4
   330C 3C                 9099 	addc    a,r4
   330D FC                 9100 	mov	r4,a
                           9101 ;     genPlus
                           9102 ;     genPlusIncr
   330E 74 01              9103 	mov	a,#0x01
                           9104 ;       Peephole 236.a  used r3 instead of ar3
   3310 2B                 9105 	add     a,r3
   3311 F5 82              9106 	mov	dpl,a
                           9107 ;       Peephole 181    changed mov to clr
   3313 E4                 9108 	clr     a
                           9109 ;       Peephole 236.b  used r4 instead of ar4
   3314 3C                 9110 	addc    a,r4
   3315 F5 83              9111 	mov	dph,a
                           9112 ;     genPointerGet
                           9113 ;     genCodePointerGet
                           9114 ;       Peephole 181    changed mov to clr
   3317 E4                 9115 	clr     a
   3318 93                 9116 	movc	a,@a+dptr
   3319 F5 31              9117 	mov	_current_display_state,a
                           9118 ;src/menu.c:1928: stack_push_back(current_position);
                           9119 ;     genCall
   331B 85 32 82           9120 	mov	dpl,_current_position
   331E 12 0C B8           9121 	lcall	_stack_push_back
                           9122 ;src/menu.c:1929: current_position = 0;
                           9123 ;     genAssign
   3321 75 32 00           9124 	mov	_current_position,#0x00
   3324                    9125 00103$:
                           9126 ;src/menu.c:1931: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
                           9127 ;     genIpush
   3324 C0 31              9128 	push	_current_display_state
                           9129 ;     genCall
   3326 75 82 00           9130 	mov	dpl,#0x00
   3329 12 6D A5           9131 	lcall	_ds1302_write_memory
   332C 15 81              9132 	dec	sp
                           9133 ;src/menu.c:1932: exit = 1;
                           9134 ;     genAssign
   332E 7A 01              9135 	mov	r2,#0x01
                           9136 ;src/menu.c:1933: break;
   3330 02 34 11           9137 	ljmp	00124$
                           9138 ;src/menu.c:1936: menu_previous_position();
   3333                    9139 00105$:
                           9140 ;     genCall
   3333 12 1F 17           9141 	lcall	_menu_previous_position
                           9142 ;src/menu.c:1937: ds1302_write_memory(RTC_CURRENT_DISPLAY_STATE,current_display_state);
                           9143 ;     genIpush
   3336 C0 31              9144 	push	_current_display_state
                           9145 ;     genCall
   3338 75 82 00           9146 	mov	dpl,#0x00
   333B 12 6D A5           9147 	lcall	_ds1302_write_memory
   333E 15 81              9148 	dec	sp
                           9149 ;src/menu.c:1938: exit = 1;
                           9150 ;     genAssign
   3340 7A 01              9151 	mov	r2,#0x01
                           9152 ;src/menu.c:1939: break;
   3342 02 34 11           9153 	ljmp	00124$
                           9154 ;src/menu.c:1942: current_position++;
   3345                    9155 00106$:
                           9156 ;     genPlus
                           9157 ;     genPlusIncr
   3345 05 32              9158 	inc	_current_position
                           9159 ;src/menu.c:1943: if (current_position == menu[current_display_state].max_pos)
                           9160 ;     genMult
                           9161 ;     genMultOneByte
   3347 E5 31              9162 	mov	a,_current_display_state
   3349 75 F0 3C           9163 	mov	b,#0x3C
   334C A4                 9164 	mul	ab
                           9165 ;     genPlus
   334D 24 0E              9166 	add	a,#_menu
   334F FB                 9167 	mov	r3,a
   3350 E5 F0              9168 	mov	a,b
   3352 34 3C              9169 	addc	a,#(_menu >> 8)
   3354 FC                 9170 	mov	r4,a
                           9171 ;     genPlus
                           9172 ;     genPlusIncr
   3355 74 03              9173 	mov	a,#0x03
                           9174 ;       Peephole 236.a  used r3 instead of ar3
   3357 2B                 9175 	add     a,r3
   3358 F5 82              9176 	mov	dpl,a
                           9177 ;       Peephole 181    changed mov to clr
   335A E4                 9178 	clr     a
                           9179 ;       Peephole 236.b  used r4 instead of ar4
   335B 3C                 9180 	addc    a,r4
   335C F5 83              9181 	mov	dph,a
                           9182 ;     genPointerGet
                           9183 ;     genCodePointerGet
                           9184 ;       Peephole 181    changed mov to clr
   335E E4                 9185 	clr     a
   335F 93                 9186 	movc	a,@a+dptr
   3360 FB                 9187 	mov	r3,a
                           9188 ;     genAssign
   3361 AC 32              9189 	mov	r4,_current_position
                           9190 ;     genCmpEq
   3363 EC                 9191 	mov	a,r4
                           9192 ;       Peephole 112.b  changed ljmp to sjmp
                           9193 ;       Peephole 199    optimized misc jump sequence
   3364 B5 03 03           9194 	cjne    a,ar3,00108$
                           9195 ;00165$:
                           9196 ;       Peephole 200    removed redundant sjmp
   3367                    9197 00166$:
                           9198 ;src/menu.c:1945: current_position = 0;
                           9199 ;     genAssign
   3367 75 32 00           9200 	mov	_current_position,#0x00
   336A                    9201 00108$:
                           9202 ;src/menu.c:1947: set_new_blink();
                           9203 ;     genCall
   336A C0 02              9204 	push	ar2
   336C 12 0F 43           9205 	lcall	_set_new_blink
   336F D0 02              9206 	pop	ar2
                           9207 ;src/menu.c:1948: break;
   3371 02 34 11           9208 	ljmp	00124$
                           9209 ;src/menu.c:1951: current_position--;
   3374                    9210 00109$:
                           9211 ;     genMinus
                           9212 ;     genMinusDec
   3374 15 32              9213 	dec	_current_position
                           9214 ;src/menu.c:1952: if (current_position == 0xFF)
                           9215 ;     genCmpEq
   3376 E5 32              9216 	mov	a,_current_position
                           9217 ;       Peephole 112.b  changed ljmp to sjmp
                           9218 ;       Peephole 199    optimized misc jump sequence
   3378 B4 FF 1D           9219 	cjne    a,#0xFF,00111$
                           9220 ;00167$:
                           9221 ;       Peephole 200    removed redundant sjmp
   337B                    9222 00168$:
                           9223 ;src/menu.c:1954: current_position = menu[current_display_state].max_pos - 1;
                           9224 ;     genMult
                           9225 ;     genMultOneByte
   337B E5 31              9226 	mov	a,_current_display_state
   337D 75 F0 3C           9227 	mov	b,#0x3C
   3380 A4                 9228 	mul	ab
                           9229 ;     genPlus
   3381 24 0E              9230 	add	a,#_menu
   3383 FB                 9231 	mov	r3,a
   3384 E5 F0              9232 	mov	a,b
   3386 34 3C              9233 	addc	a,#(_menu >> 8)
   3388 FC                 9234 	mov	r4,a
                           9235 ;     genPlus
                           9236 ;     genPlusIncr
   3389 74 03              9237 	mov	a,#0x03
                           9238 ;       Peephole 236.a  used r3 instead of ar3
   338B 2B                 9239 	add     a,r3
   338C F5 82              9240 	mov	dpl,a
                           9241 ;       Peephole 181    changed mov to clr
   338E E4                 9242 	clr     a
                           9243 ;       Peephole 236.b  used r4 instead of ar4
   338F 3C                 9244 	addc    a,r4
   3390 F5 83              9245 	mov	dph,a
                           9246 ;     genPointerGet
                           9247 ;     genCodePointerGet
                           9248 ;       Peephole 181    changed mov to clr
   3392 E4                 9249 	clr     a
   3393 93                 9250 	movc	a,@a+dptr
                           9251 ;     genMinus
                           9252 ;     genMinusDec
                           9253 ;       Peephole 105    removed redundant mov
   3394 FB                 9254 	mov     r3,a
   3395 14                 9255 	dec	a
   3396 F5 32              9256 	mov	_current_position,a
   3398                    9257 00111$:
                           9258 ;src/menu.c:1956: set_new_blink();
                           9259 ;     genCall
   3398 C0 02              9260 	push	ar2
   339A 12 0F 43           9261 	lcall	_set_new_blink
   339D D0 02              9262 	pop	ar2
                           9263 ;src/menu.c:1957: break;
   339F 02 34 11           9264 	ljmp	00124$
                           9265 ;src/menu.c:1967: break;
   33A2                    9266 00117$:
                           9267 ;src/menu.c:1960: if (current_display_state == MAIN_STATE_POS)
                           9268 ;     genCmpEq
   33A2 E5 31              9269 	mov	a,_current_display_state
                           9270 ;       Peephole 162    removed sjmp by inverse jump logic
   33A4 60 03              9271 	jz      00170$
   33A6                    9272 00169$:
   33A6 02 34 11           9273 	ljmp	00124$
   33A9                    9274 00170$:
                           9275 ;src/menu.c:1962: if(system_data.enabled[current_position] != CHANNEL_FORCED_ON)
                           9276 ;     genCast
   33A9 AB 32              9277 	mov	r3,_current_position
   33AB 7C 00              9278 	mov	r4,#0x00
                           9279 ;     genPlus
                           9280 ;       Peephole 236.g  used r3 instead of ar3
   33AD EB                 9281 	mov     a,r3
   33AE 24 75              9282 	add	a,#(_system_data + 0x0168)
   33B0 F5 82              9283 	mov	dpl,a
                           9284 ;       Peephole 236.g  used r4 instead of ar4
   33B2 EC                 9285 	mov     a,r4
   33B3 34 01              9286 	addc	a,#((_system_data + 0x0168) >> 8)
   33B5 F5 83              9287 	mov	dph,a
                           9288 ;     genPointerGet
                           9289 ;     genFarPointerGet
   33B7 E0                 9290 	movx	a,@dptr
   33B8 FD                 9291 	mov	r5,a
                           9292 ;     genCmpEq
   33B9 BD 04 02           9293 	cjne	r5,#0x04,00171$
                           9294 ;       Peephole 112.b  changed ljmp to sjmp
   33BC 80 0F              9295 	sjmp    00113$
   33BE                    9296 00171$:
                           9297 ;src/menu.c:1963: system_data.enabled[current_position] = CHANNEL_FORCED_ON;
                           9298 ;     genPlus
                           9299 ;       Peephole 236.g  used r3 instead of ar3
   33BE EB                 9300 	mov     a,r3
   33BF 24 75              9301 	add	a,#(_system_data + 0x0168)
   33C1 F5 82              9302 	mov	dpl,a
                           9303 ;       Peephole 236.g  used r4 instead of ar4
   33C3 EC                 9304 	mov     a,r4
   33C4 34 01              9305 	addc	a,#((_system_data + 0x0168) >> 8)
   33C6 F5 83              9306 	mov	dph,a
                           9307 ;     genPointerSet
                           9308 ;     genFarPointerSet
   33C8 74 04              9309 	mov	a,#0x04
   33CA F0                 9310 	movx	@dptr,a
                           9311 ;       Peephole 112.b  changed ljmp to sjmp
   33CB 80 44              9312 	sjmp    00124$
   33CD                    9313 00113$:
                           9314 ;src/menu.c:1965: system_data.enabled[current_position] = CHANNEL_DISABLED;
                           9315 ;     genPlus
                           9316 ;       Peephole 236.g  used r3 instead of ar3
   33CD EB                 9317 	mov     a,r3
   33CE 24 75              9318 	add	a,#(_system_data + 0x0168)
   33D0 F5 82              9319 	mov	dpl,a
                           9320 ;       Peephole 236.g  used r4 instead of ar4
   33D2 EC                 9321 	mov     a,r4
   33D3 34 01              9322 	addc	a,#((_system_data + 0x0168) >> 8)
   33D5 F5 83              9323 	mov	dph,a
                           9324 ;     genPointerSet
                           9325 ;     genFarPointerSet
                           9326 ;       Peephole 181    changed mov to clr
   33D7 E4                 9327 	clr     a
   33D8 F0                 9328 	movx	@dptr,a
                           9329 ;src/menu.c:1967: break;
                           9330 ;src/menu.c:1977: break;
                           9331 ;       Peephole 112.b  changed ljmp to sjmp
   33D9 80 36              9332 	sjmp    00124$
   33DB                    9333 00123$:
                           9334 ;src/menu.c:1970: if (current_display_state == MAIN_STATE_POS)
                           9335 ;     genCmpEq
   33DB E5 31              9336 	mov	a,_current_display_state
                           9337 ;       Peephole 162    removed sjmp by inverse jump logic
   33DD 60 02              9338 	jz      00173$
   33DF                    9339 00172$:
                           9340 ;       Peephole 112.b  changed ljmp to sjmp
   33DF 80 30              9341 	sjmp    00124$
   33E1                    9342 00173$:
                           9343 ;src/menu.c:1972: if(system_data.enabled[current_position] != CHANNEL_FORCED_OFF)
                           9344 ;     genCast
   33E1 AB 32              9345 	mov	r3,_current_position
   33E3 7C 00              9346 	mov	r4,#0x00
                           9347 ;     genPlus
                           9348 ;       Peephole 236.g  used r3 instead of ar3
   33E5 EB                 9349 	mov     a,r3
   33E6 24 75              9350 	add	a,#(_system_data + 0x0168)
   33E8 F5 82              9351 	mov	dpl,a
                           9352 ;       Peephole 236.g  used r4 instead of ar4
   33EA EC                 9353 	mov     a,r4
   33EB 34 01              9354 	addc	a,#((_system_data + 0x0168) >> 8)
   33ED F5 83              9355 	mov	dph,a
                           9356 ;     genPointerGet
                           9357 ;     genFarPointerGet
   33EF E0                 9358 	movx	a,@dptr
   33F0 FD                 9359 	mov	r5,a
                           9360 ;     genCmpEq
   33F1 BD 08 02           9361 	cjne	r5,#0x08,00174$
                           9362 ;       Peephole 112.b  changed ljmp to sjmp
   33F4 80 0F              9363 	sjmp    00119$
   33F6                    9364 00174$:
                           9365 ;src/menu.c:1973: system_data.enabled[current_position] = CHANNEL_FORCED_OFF;
                           9366 ;     genPlus
                           9367 ;       Peephole 236.g  used r3 instead of ar3
   33F6 EB                 9368 	mov     a,r3
   33F7 24 75              9369 	add	a,#(_system_data + 0x0168)
   33F9 F5 82              9370 	mov	dpl,a
                           9371 ;       Peephole 236.g  used r4 instead of ar4
   33FB EC                 9372 	mov     a,r4
   33FC 34 01              9373 	addc	a,#((_system_data + 0x0168) >> 8)
   33FE F5 83              9374 	mov	dph,a
                           9375 ;     genPointerSet
                           9376 ;     genFarPointerSet
   3400 74 08              9377 	mov	a,#0x08
   3402 F0                 9378 	movx	@dptr,a
                           9379 ;       Peephole 112.b  changed ljmp to sjmp
   3403 80 0C              9380 	sjmp    00124$
   3405                    9381 00119$:
                           9382 ;src/menu.c:1975: system_data.enabled[current_position] = CHANNEL_DISABLED;
                           9383 ;     genPlus
                           9384 ;       Peephole 236.g  used r3 instead of ar3
   3405 EB                 9385 	mov     a,r3
   3406 24 75              9386 	add	a,#(_system_data + 0x0168)
   3408 F5 82              9387 	mov	dpl,a
                           9388 ;       Peephole 236.g  used r4 instead of ar4
   340A EC                 9389 	mov     a,r4
   340B 34 01              9390 	addc	a,#((_system_data + 0x0168) >> 8)
   340D F5 83              9391 	mov	dph,a
                           9392 ;     genPointerSet
                           9393 ;     genFarPointerSet
                           9394 ;       Peephole 181    changed mov to clr
   340F E4                 9395 	clr     a
   3410 F0                 9396 	movx	@dptr,a
                           9397 ;src/menu.c:1978: }
   3411                    9398 00124$:
                           9399 ;src/menu.c:1979: keypad_purge_buffer();
                           9400 ;     genCall
   3411 C0 02              9401 	push	ar2
   3413 12 02 B0           9402 	lcall	_keypad_purge_buffer
   3416 D0 02              9403 	pop	ar2
   3418 02 32 69           9404 	ljmp	00129$
   341B                    9405 00132$:
   341B 85 40 81           9406 	mov	sp,_bp
   341E D0 40              9407 	pop	_bp
   3420 22                 9408 	ret
                           9409 ;------------------------------------------------------------
                           9410 ;Allocation info for local variables in function 'battery_test'
                           9411 ;------------------------------------------------------------
                           9412 ;------------------------------------------------------------
                           9413 ;src/menu.c:1993: void battery_test(void)
                           9414 ;	-----------------------------------------
                           9415 ;	 function battery_test
                           9416 ;	-----------------------------------------
   3421                    9417 _battery_test:
   3421 C0 40              9418 	push	_bp
   3423 85 81 40           9419 	mov	_bp,sp
                           9420 ;src/menu.c:1995: BATT_TEST_PORT = 0;
                           9421 ;     genAssign
   3426 C2 A7              9422 	clr	_P2_7
   3428                    9423 00106$:
                           9424 ;src/menu.c:1997: for ( ; battery_counter < 2000; battery_counter++ )
                           9425 ;     genAssign
   3428 90 01 8D           9426 	mov	dptr,#_battery_counter
   342B E0                 9427 	movx	a,@dptr
   342C FA                 9428 	mov	r2,a
   342D A3                 9429 	inc	dptr
   342E E0                 9430 	movx	a,@dptr
   342F FB                 9431 	mov	r3,a
                           9432 ;     genCmpLt
                           9433 ;     genCmp
   3430 C3                 9434 	clr	c
   3431 EA                 9435 	mov	a,r2
   3432 94 D0              9436 	subb	a,#0xD0
   3434 EB                 9437 	mov	a,r3
   3435 94 07              9438 	subb	a,#0x07
                           9439 ;     genIfxJump
                           9440 ;       Peephole 108    removed ljmp by inverse jump logic
   3437 50 13              9441 	jnc     00109$
   3439                    9442 00116$:
                           9443 ;src/menu.c:1999: SERVICE_WATCHDOG;
                           9444 ;     genAssign
   3439 75 A6 1E           9445 	mov	_WDTRST,#0x1E
                           9446 ;     genAssign
   343C 75 A6 E1           9447 	mov	_WDTRST,#0xE1
                           9448 ;src/menu.c:1997: for ( ; battery_counter < 2000; battery_counter++ )
                           9449 ;     genPlus
   343F 90 01 8D           9450 	mov	dptr,#_battery_counter
                           9451 ;     genPlusIncr
   3442 74 01              9452 	mov	a,#0x01
                           9453 ;       Peephole 236.a  used r2 instead of ar2
   3444 2A                 9454 	add     a,r2
   3445 F0                 9455 	movx	@dptr,a
                           9456 ;       Peephole 181    changed mov to clr
   3446 E4                 9457 	clr     a
                           9458 ;       Peephole 236.b  used r3 instead of ar3
   3447 3B                 9459 	addc    a,r3
   3448 A3                 9460 	inc	dptr
   3449 F0                 9461 	movx	@dptr,a
                           9462 ;       Peephole 112.b  changed ljmp to sjmp
   344A 80 DC              9463 	sjmp    00106$
   344C                    9464 00109$:
                           9465 ;     genIfx
                           9466 ;     genIfxJump
                           9467 ;       Peephole 112.a  removed ljmp by inverse jump logic
   344C 20 91 05           9468 	jb      _P1_1,00104$
   344F                    9469 00117$:
                           9470 ;src/menu.c:2004: current_display_state = BATTERY_LOW_POS;
                           9471 ;     genAssign
   344F 75 31 38           9472 	mov	_current_display_state,#0x38
                           9473 ;       Peephole 112.b  changed ljmp to sjmp
   3452 80 13              9474 	sjmp    00105$
   3454                    9475 00104$:
                           9476 ;src/menu.c:2008: current_display_state = ds1302_read_memory(RTC_CURRENT_DISPLAY_STATE);
                           9477 ;     genCall
   3454 75 82 00           9478 	mov	dpl,#0x00
   3457 12 6D FC           9479 	lcall	_ds1302_read_memory
   345A 85 82 31           9480 	mov	_current_display_state,dpl
                           9481 ;src/menu.c:2010: if (current_display_state >= LATEST_DONT_REMOVE)
                           9482 ;     genCmpLt
                           9483 ;     genCmp
   345D C3                 9484 	clr	c
   345E E5 31              9485 	mov	a,_current_display_state
   3460 94 3A              9486 	subb	a,#0x3A
                           9487 ;     genIfxJump
                           9488 ;       Peephole 112.b  changed ljmp to sjmp
                           9489 ;       Peephole 160    removed sjmp by inverse jump logic
   3462 40 03              9490 	jc      00105$
   3464                    9491 00118$:
                           9492 ;src/menu.c:2012: current_display_state = 0;
                           9493 ;     genAssign
   3464 75 31 00           9494 	mov	_current_display_state,#0x00
   3467                    9495 00105$:
                           9496 ;src/menu.c:2016: BATT_TEST_PORT = 1; /* Also set by lcd driver before */
                           9497 ;     genAssign
   3467 D2 A7              9498 	setb	_P2_7
   3469                    9499 00110$:
   3469 85 40 81           9500 	mov	sp,_bp
   346C D0 40              9501 	pop	_bp
   346E 22                 9502 	ret
                           9503 ;------------------------------------------------------------
                           9504 ;Allocation info for local variables in function 'clear_zones'
                           9505 ;------------------------------------------------------------
                           9506 ;i                         Allocated to registers 
                           9507 ;------------------------------------------------------------
                           9508 ;src/menu.c:2019: void clear_zones()
                           9509 ;	-----------------------------------------
                           9510 ;	 function clear_zones
                           9511 ;	-----------------------------------------
   346F                    9512 _clear_zones:
   346F C0 40              9513 	push	_bp
   3471 85 81 40           9514 	mov	_bp,sp
                           9515 ;src/menu.c:2023: for(i=0; i<4; i++)
                           9516 ;     genAssign
   3474 7A 00              9517 	mov	r2,#0x00
   3476                    9518 00101$:
                           9519 ;     genCmpLt
                           9520 ;     genCmp
   3476 C3                 9521 	clr	c
   3477 EA                 9522 	mov	a,r2
   3478 64 80              9523 	xrl	a,#0x80
   347A 94 84              9524 	subb	a,#0x84
                           9525 ;     genIfxJump
                           9526 ;       Peephole 108    removed ljmp by inverse jump logic
   347C 50 1A              9527 	jnc     00105$
   347E                    9528 00109$:
                           9529 ;src/menu.c:2025: switch_zone_prepare(i,0);
                           9530 ;     genIpush
   347E C0 02              9531 	push	ar2
                           9532 ;       Peephole 181    changed mov to clr
   3480 E4                 9533 	clr     a
   3481 C0 E0              9534 	push	acc
                           9535 ;     genCall
   3483 8A 82              9536 	mov	dpl,r2
   3485 12 18 F3           9537 	lcall	_switch_zone_prepare
   3488 15 81              9538 	dec	sp
   348A D0 02              9539 	pop	ar2
                           9540 ;src/menu.c:2026: switch_zone(i);
                           9541 ;     genCall
   348C 8A 82              9542 	mov	dpl,r2
   348E C0 02              9543 	push	ar2
   3490 12 18 A4           9544 	lcall	_switch_zone
   3493 D0 02              9545 	pop	ar2
                           9546 ;src/menu.c:2023: for(i=0; i<4; i++)
                           9547 ;     genPlus
                           9548 ;     genPlusIncr
   3495 0A                 9549 	inc	r2
                           9550 ;       Peephole 112.b  changed ljmp to sjmp
   3496 80 DE              9551 	sjmp    00101$
   3498                    9552 00105$:
   3498 85 40 81           9553 	mov	sp,_bp
   349B D0 40              9554 	pop	_bp
   349D 22                 9555 	ret
                           9556 ;------------------------------------------------------------
                           9557 ;Allocation info for local variables in function 'main_program_workloop'
                           9558 ;------------------------------------------------------------
                           9559 ;------------------------------------------------------------
                           9560 ;src/menu.c:2032: void main_program_workloop(void)
                           9561 ;	-----------------------------------------
                           9562 ;	 function main_program_workloop
                           9563 ;	-----------------------------------------
   349E                    9564 _main_program_workloop:
   349E C0 40              9565 	push	_bp
   34A0 85 81 40           9566 	mov	_bp,sp
                           9567 ;src/menu.c:2034: battery_test();
                           9568 ;     genCall
   34A3 12 34 21           9569 	lcall	_battery_test
                           9570 ;src/menu.c:2035: stack_purge();
                           9571 ;     genCall
   34A6 12 0D 27           9572 	lcall	_stack_purge
                           9573 ;src/menu.c:2036: ENABLE_INTERRUPTS;
                           9574 ;     genAssign
   34A9 D2 AF              9575 	setb	_EA
                           9576 ;src/menu.c:2040: while (1)
   34AB                    9577 00158$:
                           9578 ;src/menu.c:2042: enter_workloop = true;
                           9579 ;     genAssign
   34AB 75 34 01           9580 	mov	_enter_workloop,#0x01
                           9581 ;src/menu.c:2044: BLINKING_OFF;
                           9582 ;     genAssign
   34AE 75 30 00           9583 	mov	_blinking,#0x00
                           9584 ;src/menu.c:2045: lcd_clear();
                           9585 ;     genCall
   34B1 12 0B 75           9586 	lcall	_lcd_clear
                           9587 ;src/menu.c:2046: lcd_put_string(menu[current_display_state].text);
                           9588 ;     genMult
                           9589 ;     genMultOneByte
   34B4 E5 31              9590 	mov	a,_current_display_state
   34B6 75 F0 3C           9591 	mov	b,#0x3C
   34B9 A4                 9592 	mul	ab
                           9593 ;     genPlus
   34BA 24 0E              9594 	add	a,#_menu
   34BC F5 82              9595 	mov	dpl,a
   34BE E5 F0              9596 	mov	a,b
   34C0 34 3C              9597 	addc	a,#(_menu >> 8)
   34C2 F5 83              9598 	mov	dph,a
                           9599 ;     genPointerGet
                           9600 ;     genCodePointerGet
                           9601 ;       Peephole 181    changed mov to clr
   34C4 E4                 9602 	clr     a
   34C5 93                 9603 	movc	a,@a+dptr
   34C6 FA                 9604 	mov	r2,a
   34C7 74 01              9605 	mov	a,#0x01
   34C9 93                 9606 	movc	a,@a+dptr
   34CA FB                 9607 	mov	r3,a
   34CB 74 02              9608 	mov	a,#0x02
   34CD 93                 9609 	movc	a,@a+dptr
   34CE FC                 9610 	mov	r4,a
                           9611 ;     genCall
   34CF 8A 82              9612 	mov	dpl,r2
   34D1 8B 83              9613 	mov	dph,r3
   34D3 8C F0              9614 	mov	b,r4
   34D5 12 0B B6           9615 	lcall	_lcd_put_string
                           9616 ;src/menu.c:2047: current_blink_params = menu[current_display_state].item[current_position].blink_union.blink;     
                           9617 ;     genMult
                           9618 ;     genMultOneByte
   34D8 E5 31              9619 	mov	a,_current_display_state
   34DA 75 F0 3C           9620 	mov	b,#0x3C
   34DD A4                 9621 	mul	ab
                           9622 ;     genPlus
   34DE 24 0E              9623 	add	a,#_menu
   34E0 FA                 9624 	mov	r2,a
   34E1 E5 F0              9625 	mov	a,b
   34E3 34 3C              9626 	addc	a,#(_menu >> 8)
   34E5 FB                 9627 	mov	r3,a
                           9628 ;     genPlus
                           9629 ;     genPlusIncr
   34E6 74 04              9630 	mov	a,#0x04
                           9631 ;       Peephole 236.a  used r2 instead of ar2
   34E8 2A                 9632 	add     a,r2
   34E9 FA                 9633 	mov	r2,a
                           9634 ;       Peephole 181    changed mov to clr
   34EA E4                 9635 	clr     a
                           9636 ;       Peephole 236.b  used r3 instead of ar3
   34EB 3B                 9637 	addc    a,r3
   34EC FB                 9638 	mov	r3,a
                           9639 ;     genMult
                           9640 ;     genMultOneByte
   34ED E5 32              9641 	mov	a,_current_position
   34EF 75 F0 08           9642 	mov	b,#0x08
   34F2 A4                 9643 	mul	ab
                           9644 ;     genPlus
                           9645 ;       Peephole 236.a  used r2 instead of ar2
   34F3 2A                 9646 	add     a,r2
   34F4 FA                 9647 	mov	r2,a
   34F5 E5 F0              9648 	mov	a,b
                           9649 ;       Peephole 236.b  used r3 instead of ar3
   34F7 3B                 9650 	addc    a,r3
   34F8 FB                 9651 	mov	r3,a
                           9652 ;     genPlus
                           9653 ;     genPlusIncr
   34F9 74 02              9654 	mov	a,#0x02
                           9655 ;       Peephole 236.a  used r2 instead of ar2
   34FB 2A                 9656 	add     a,r2
   34FC F5 82              9657 	mov	dpl,a
                           9658 ;       Peephole 181    changed mov to clr
   34FE E4                 9659 	clr     a
                           9660 ;       Peephole 236.b  used r3 instead of ar3
   34FF 3B                 9661 	addc    a,r3
   3500 F5 83              9662 	mov	dph,a
                           9663 ;     genPointerGet
                           9664 ;     genCodePointerGet
                           9665 ;       Peephole 181    changed mov to clr
   3502 E4                 9666 	clr     a
   3503 93                 9667 	movc	a,@a+dptr
   3504 F5 2D              9668 	mov	_current_blink_params,a
   3506 74 01              9669 	mov	a,#0x01
   3508 93                 9670 	movc	a,@a+dptr
   3509 F5 2E              9671 	mov	(_current_blink_params + 1),a
   350B 74 02              9672 	mov	a,#0x02
   350D 93                 9673 	movc	a,@a+dptr
   350E F5 2F              9674 	mov	(_current_blink_params + 2),a
                           9675 ;src/menu.c:2049: switch (current_display_state)
                           9676 ;     genCmpEq
   3510 E5 31              9677 	mov	a,_current_display_state
   3512 70 03              9678 	jnz	00217$
   3514 02 36 CA           9679 	ljmp	00102$
   3517                    9680 00217$:
                           9681 ;     genCmpEq
   3517 E5 31              9682 	mov	a,_current_display_state
   3519 B4 06 03           9683 	cjne	a,#0x06,00218$
   351C 02 36 E2           9684 	ljmp	00103$
   351F                    9685 00218$:
                           9686 ;     genCmpEq
   351F E5 31              9687 	mov	a,_current_display_state
   3521 B4 07 03           9688 	cjne	a,#0x07,00219$
   3524 02 36 EB           9689 	ljmp	00104$
   3527                    9690 00219$:
                           9691 ;     genCmpEq
   3527 E5 31              9692 	mov	a,_current_display_state
   3529 B4 08 03           9693 	cjne	a,#0x08,00220$
   352C 02 36 F4           9694 	ljmp	00105$
   352F                    9695 00220$:
                           9696 ;     genCmpEq
   352F E5 31              9697 	mov	a,_current_display_state
   3531 B4 09 03           9698 	cjne	a,#0x09,00221$
   3534 02 36 FD           9699 	ljmp	00106$
   3537                    9700 00221$:
                           9701 ;     genCmpEq
   3537 E5 31              9702 	mov	a,_current_display_state
   3539 B4 0A 03           9703 	cjne	a,#0x0A,00222$
   353C 02 37 06           9704 	ljmp	00107$
   353F                    9705 00222$:
                           9706 ;     genCmpEq
   353F E5 31              9707 	mov	a,_current_display_state
   3541 B4 0B 03           9708 	cjne	a,#0x0B,00223$
   3544 02 37 0F           9709 	ljmp	00108$
   3547                    9710 00223$:
                           9711 ;     genCmpEq
   3547 E5 31              9712 	mov	a,_current_display_state
   3549 B4 0C 03           9713 	cjne	a,#0x0C,00224$
   354C 02 37 18           9714 	ljmp	00109$
   354F                    9715 00224$:
                           9716 ;     genCmpEq
   354F E5 31              9717 	mov	a,_current_display_state
   3551 B4 0D 03           9718 	cjne	a,#0x0D,00225$
   3554 02 37 21           9719 	ljmp	00110$
   3557                    9720 00225$:
                           9721 ;     genCmpEq
   3557 E5 31              9722 	mov	a,_current_display_state
   3559 B4 0E 03           9723 	cjne	a,#0x0E,00226$
   355C 02 37 2A           9724 	ljmp	00111$
   355F                    9725 00226$:
                           9726 ;     genCmpEq
   355F E5 31              9727 	mov	a,_current_display_state
   3561 B4 0F 03           9728 	cjne	a,#0x0F,00227$
   3564 02 37 33           9729 	ljmp	00112$
   3567                    9730 00227$:
                           9731 ;     genCmpEq
   3567 E5 31              9732 	mov	a,_current_display_state
   3569 B4 10 03           9733 	cjne	a,#0x10,00228$
   356C 02 37 3C           9734 	ljmp	00113$
   356F                    9735 00228$:
                           9736 ;     genCmpEq
   356F E5 31              9737 	mov	a,_current_display_state
   3571 B4 11 03           9738 	cjne	a,#0x11,00229$
   3574 02 37 44           9739 	ljmp	00114$
   3577                    9740 00229$:
                           9741 ;     genCmpEq
   3577 E5 31              9742 	mov	a,_current_display_state
   3579 B4 12 03           9743 	cjne	a,#0x12,00230$
   357C 02 37 4C           9744 	ljmp	00115$
   357F                    9745 00230$:
                           9746 ;     genCmpEq
   357F E5 31              9747 	mov	a,_current_display_state
   3581 B4 13 03           9748 	cjne	a,#0x13,00231$
   3584 02 37 4C           9749 	ljmp	00115$
   3587                    9750 00231$:
                           9751 ;     genCmpEq
   3587 E5 31              9752 	mov	a,_current_display_state
   3589 B4 14 03           9753 	cjne	a,#0x14,00232$
   358C 02 37 4C           9754 	ljmp	00115$
   358F                    9755 00232$:
                           9756 ;     genCmpEq
   358F E5 31              9757 	mov	a,_current_display_state
   3591 B4 15 03           9758 	cjne	a,#0x15,00233$
   3594 02 37 4C           9759 	ljmp	00115$
   3597                    9760 00233$:
                           9761 ;     genCmpEq
   3597 E5 31              9762 	mov	a,_current_display_state
   3599 B4 16 03           9763 	cjne	a,#0x16,00234$
   359C 02 37 4C           9764 	ljmp	00115$
   359F                    9765 00234$:
                           9766 ;     genCmpEq
   359F E5 31              9767 	mov	a,_current_display_state
   35A1 B4 17 03           9768 	cjne	a,#0x17,00235$
   35A4 02 37 4C           9769 	ljmp	00115$
   35A7                    9770 00235$:
                           9771 ;     genCmpEq
   35A7 E5 31              9772 	mov	a,_current_display_state
   35A9 B4 18 03           9773 	cjne	a,#0x18,00236$
   35AC 02 37 4C           9774 	ljmp	00115$
   35AF                    9775 00236$:
                           9776 ;     genCmpEq
   35AF E5 31              9777 	mov	a,_current_display_state
   35B1 B4 19 03           9778 	cjne	a,#0x19,00237$
   35B4 02 37 4C           9779 	ljmp	00115$
   35B7                    9780 00237$:
                           9781 ;     genCmpEq
   35B7 E5 31              9782 	mov	a,_current_display_state
   35B9 B4 1A 03           9783 	cjne	a,#0x1A,00238$
   35BC 02 37 4C           9784 	ljmp	00115$
   35BF                    9785 00238$:
                           9786 ;     genCmpEq
   35BF E5 31              9787 	mov	a,_current_display_state
   35C1 B4 1B 03           9788 	cjne	a,#0x1B,00239$
   35C4 02 37 4C           9789 	ljmp	00115$
   35C7                    9790 00239$:
                           9791 ;     genCmpEq
   35C7 E5 31              9792 	mov	a,_current_display_state
   35C9 B4 1C 03           9793 	cjne	a,#0x1C,00240$
   35CC 02 37 4C           9794 	ljmp	00115$
   35CF                    9795 00240$:
                           9796 ;     genCmpEq
   35CF E5 31              9797 	mov	a,_current_display_state
   35D1 B4 1D 03           9798 	cjne	a,#0x1D,00241$
   35D4 02 37 4C           9799 	ljmp	00115$
   35D7                    9800 00241$:
                           9801 ;     genCmpEq
   35D7 E5 31              9802 	mov	a,_current_display_state
   35D9 B4 1E 03           9803 	cjne	a,#0x1E,00242$
   35DC 02 37 4C           9804 	ljmp	00115$
   35DF                    9805 00242$:
                           9806 ;     genCmpEq
   35DF E5 31              9807 	mov	a,_current_display_state
   35E1 B4 1F 03           9808 	cjne	a,#0x1F,00243$
   35E4 02 37 4C           9809 	ljmp	00115$
   35E7                    9810 00243$:
                           9811 ;     genCmpEq
   35E7 E5 31              9812 	mov	a,_current_display_state
   35E9 B4 20 03           9813 	cjne	a,#0x20,00244$
   35EC 02 37 4C           9814 	ljmp	00115$
   35EF                    9815 00244$:
                           9816 ;     genCmpEq
   35EF E5 31              9817 	mov	a,_current_display_state
   35F1 B4 21 03           9818 	cjne	a,#0x21,00245$
   35F4 02 37 4C           9819 	ljmp	00115$
   35F7                    9820 00245$:
                           9821 ;     genCmpEq
   35F7 E5 31              9822 	mov	a,_current_display_state
   35F9 B4 22 03           9823 	cjne	a,#0x22,00246$
   35FC 02 37 4C           9824 	ljmp	00115$
   35FF                    9825 00246$:
                           9826 ;     genCmpEq
   35FF E5 31              9827 	mov	a,_current_display_state
   3601 B4 23 03           9828 	cjne	a,#0x23,00247$
   3604 02 37 4C           9829 	ljmp	00115$
   3607                    9830 00247$:
                           9831 ;     genCmpEq
   3607 E5 31              9832 	mov	a,_current_display_state
   3609 B4 24 03           9833 	cjne	a,#0x24,00248$
   360C 02 37 4C           9834 	ljmp	00115$
   360F                    9835 00248$:
                           9836 ;     genCmpEq
   360F E5 31              9837 	mov	a,_current_display_state
   3611 B4 25 03           9838 	cjne	a,#0x25,00249$
   3614 02 37 4C           9839 	ljmp	00115$
   3617                    9840 00249$:
                           9841 ;     genCmpEq
   3617 E5 31              9842 	mov	a,_current_display_state
   3619 B4 26 03           9843 	cjne	a,#0x26,00250$
   361C 02 37 4C           9844 	ljmp	00115$
   361F                    9845 00250$:
                           9846 ;     genCmpEq
   361F E5 31              9847 	mov	a,_current_display_state
   3621 B4 27 03           9848 	cjne	a,#0x27,00251$
   3624 02 37 4C           9849 	ljmp	00115$
   3627                    9850 00251$:
                           9851 ;     genCmpEq
   3627 E5 31              9852 	mov	a,_current_display_state
   3629 B4 28 03           9853 	cjne	a,#0x28,00252$
   362C 02 37 4C           9854 	ljmp	00115$
   362F                    9855 00252$:
                           9856 ;     genCmpEq
   362F E5 31              9857 	mov	a,_current_display_state
   3631 B4 29 03           9858 	cjne	a,#0x29,00253$
   3634 02 37 4C           9859 	ljmp	00115$
   3637                    9860 00253$:
                           9861 ;     genCmpEq
   3637 E5 31              9862 	mov	a,_current_display_state
   3639 B4 2A 03           9863 	cjne	a,#0x2A,00254$
   363C 02 37 4C           9864 	ljmp	00115$
   363F                    9865 00254$:
                           9866 ;     genCmpEq
   363F E5 31              9867 	mov	a,_current_display_state
   3641 B4 2B 03           9868 	cjne	a,#0x2B,00255$
   3644 02 37 4C           9869 	ljmp	00115$
   3647                    9870 00255$:
                           9871 ;     genCmpEq
   3647 E5 31              9872 	mov	a,_current_display_state
   3649 B4 2C 03           9873 	cjne	a,#0x2C,00256$
   364C 02 37 4C           9874 	ljmp	00115$
   364F                    9875 00256$:
                           9876 ;     genCmpEq
   364F E5 31              9877 	mov	a,_current_display_state
   3651 B4 2D 03           9878 	cjne	a,#0x2D,00257$
   3654 02 37 4C           9879 	ljmp	00115$
   3657                    9880 00257$:
                           9881 ;     genCmpEq
   3657 E5 31              9882 	mov	a,_current_display_state
   3659 B4 2E 03           9883 	cjne	a,#0x2E,00258$
   365C 02 37 4C           9884 	ljmp	00115$
   365F                    9885 00258$:
                           9886 ;     genCmpEq
   365F E5 31              9887 	mov	a,_current_display_state
   3661 B4 2F 03           9888 	cjne	a,#0x2F,00259$
   3664 02 37 4C           9889 	ljmp	00115$
   3667                    9890 00259$:
                           9891 ;     genCmpEq
   3667 E5 31              9892 	mov	a,_current_display_state
   3669 B4 30 03           9893 	cjne	a,#0x30,00260$
   366C 02 37 4C           9894 	ljmp	00115$
   366F                    9895 00260$:
                           9896 ;     genCmpEq
   366F E5 31              9897 	mov	a,_current_display_state
   3671 B4 31 03           9898 	cjne	a,#0x31,00261$
   3674 02 37 4C           9899 	ljmp	00115$
   3677                    9900 00261$:
                           9901 ;     genCmpEq
   3677 E5 31              9902 	mov	a,_current_display_state
   3679 B4 32 03           9903 	cjne	a,#0x32,00262$
   367C 02 37 4C           9904 	ljmp	00115$
   367F                    9905 00262$:
                           9906 ;     genCmpEq
   367F E5 31              9907 	mov	a,_current_display_state
   3681 B4 33 03           9908 	cjne	a,#0x33,00263$
   3684 02 37 4C           9909 	ljmp	00115$
   3687                    9910 00263$:
                           9911 ;     genCmpEq
   3687 E5 31              9912 	mov	a,_current_display_state
   3689 B4 34 03           9913 	cjne	a,#0x34,00264$
   368C 02 37 4C           9914 	ljmp	00115$
   368F                    9915 00264$:
                           9916 ;     genCmpEq
   368F E5 31              9917 	mov	a,_current_display_state
   3691 B4 35 03           9918 	cjne	a,#0x35,00265$
   3694 02 37 4C           9919 	ljmp	00115$
   3697                    9920 00265$:
                           9921 ;     genCmpEq
   3697 E5 31              9922 	mov	a,_current_display_state
   3699 B4 36 03           9923 	cjne	a,#0x36,00266$
   369C 02 37 7F           9924 	ljmp	00152$
   369F                    9925 00266$:
                           9926 ;     genCmpEq
   369F E5 31              9927 	mov	a,_current_display_state
   36A1 B4 37 03           9928 	cjne	a,#0x37,00267$
   36A4 02 37 9C           9929 	ljmp	00153$
   36A7                    9930 00267$:
                           9931 ;     genCmpEq
   36A7 E5 31              9932 	mov	a,_current_display_state
   36A9 B4 38 02           9933 	cjne	a,#0x38,00268$
                           9934 ;       Peephole 112.b  changed ljmp to sjmp
   36AC 80 0B              9935 	sjmp    00101$
   36AE                    9936 00268$:
                           9937 ;     genCmpEq
   36AE E5 31              9938 	mov	a,_current_display_state
   36B0 B4 39 03           9939 	cjne	a,#0x39,00269$
   36B3 02 37 5A           9940 	ljmp	00151$
   36B6                    9941 00269$:
   36B6 02 37 B4           9942 	ljmp	00154$
                           9943 ;src/menu.c:2052: reset_workloop(0);
   36B9                    9944 00101$:
                           9945 ;     genCall
   36B9 75 82 00           9946 	mov	dpl,#0x00
                           9947 ;       Peephole 3.a    changed mov to clr
                           9948 ;       Peephole 3.b    changed mov to clr
   36BC E4                 9949 	clr     a
   36BD F5 83              9950 	mov     dph,a
   36BF F5 F0              9951 	mov     b,a
   36C1 12 1F 4F           9952 	lcall	_reset_workloop
                           9953 ;src/menu.c:2053: enter_workloop = false;
                           9954 ;     genAssign
   36C4 75 34 00           9955 	mov	_enter_workloop,#0x00
                           9956 ;src/menu.c:2054: break;
   36C7 02 37 B4           9957 	ljmp	00154$
                           9958 ;src/menu.c:2060: display_stored_data((unsigned int*)system_data.temperatures,true);
   36CA                    9959 00102$:
                           9960 ;     genIpush
   36CA 74 01              9961 	mov	a,#0x01
   36CC C0 E0              9962 	push	acc
                           9963 ;     genCall
                           9964 ;       Peephole 182.a  used 16 bit load of DPTR
   36CE 90 01 79           9965 	mov     dptr,#(_system_data + 0x016c)
   36D1 75 F0 01           9966 	mov	b,#0x01
   36D4 12 16 3D           9967 	lcall	_display_stored_data
   36D7 15 81              9968 	dec	sp
                           9969 ;src/menu.c:2061: display_enabled_channels(true);
                           9970 ;     genCall
   36D9 75 82 01           9971 	mov	dpl,#0x01
   36DC 12 19 46           9972 	lcall	_display_enabled_channels
                           9973 ;src/menu.c:2062: break;
   36DF 02 37 B4           9974 	ljmp	00154$
                           9975 ;src/menu.c:2065: display_zone_setings(0);
   36E2                    9976 00103$:
                           9977 ;     genCall
   36E2 75 82 00           9978 	mov	dpl,#0x00
   36E5 12 10 36           9979 	lcall	_display_zone_setings
                           9980 ;src/menu.c:2066: break;
   36E8 02 37 B4           9981 	ljmp	00154$
                           9982 ;src/menu.c:2068: display_zone_setings(3);
   36EB                    9983 00104$:
                           9984 ;     genCall
   36EB 75 82 03           9985 	mov	dpl,#0x03
   36EE 12 10 36           9986 	lcall	_display_zone_setings
                           9987 ;src/menu.c:2069: break;
   36F1 02 37 B4           9988 	ljmp	00154$
                           9989 ;src/menu.c:2071: display_zone_setings(6);
   36F4                    9990 00105$:
                           9991 ;     genCall
   36F4 75 82 06           9992 	mov	dpl,#0x06
   36F7 12 10 36           9993 	lcall	_display_zone_setings
                           9994 ;src/menu.c:2072: break;
   36FA 02 37 B4           9995 	ljmp	00154$
                           9996 ;src/menu.c:2074: display_zone_setings(9);
   36FD                    9997 00106$:
                           9998 ;     genCall
   36FD 75 82 09           9999 	mov	dpl,#0x09
   3700 12 10 36          10000 	lcall	_display_zone_setings
                          10001 ;src/menu.c:2075: break;
   3703 02 37 B4          10002 	ljmp	00154$
                          10003 ;src/menu.c:2077: display_zone_setings(12);
   3706                   10004 00107$:
                          10005 ;     genCall
   3706 75 82 0C          10006 	mov	dpl,#0x0C
   3709 12 10 36          10007 	lcall	_display_zone_setings
                          10008 ;src/menu.c:2078: break;
   370C 02 37 B4          10009 	ljmp	00154$
                          10010 ;src/menu.c:2080: display_zone_setings(15);
   370F                   10011 00108$:
                          10012 ;     genCall
   370F 75 82 0F          10013 	mov	dpl,#0x0F
   3712 12 10 36          10014 	lcall	_display_zone_setings
                          10015 ;src/menu.c:2081: break;
   3715 02 37 B4          10016 	ljmp	00154$
                          10017 ;src/menu.c:2083: display_zone_setings(18);
   3718                   10018 00109$:
                          10019 ;     genCall
   3718 75 82 12          10020 	mov	dpl,#0x12
   371B 12 10 36          10021 	lcall	_display_zone_setings
                          10022 ;src/menu.c:2084: break;
   371E 02 37 B4          10023 	ljmp	00154$
                          10024 ;src/menu.c:2086: display_zone_setings(21);
   3721                   10025 00110$:
                          10026 ;     genCall
   3721 75 82 15          10027 	mov	dpl,#0x15
   3724 12 10 36          10028 	lcall	_display_zone_setings
                          10029 ;src/menu.c:2087: break;
   3727 02 37 B4          10030 	ljmp	00154$
                          10031 ;src/menu.c:2089: display_zone_setings(24);
   372A                   10032 00111$:
                          10033 ;     genCall
   372A 75 82 18          10034 	mov	dpl,#0x18
   372D 12 10 36          10035 	lcall	_display_zone_setings
                          10036 ;src/menu.c:2090: break;
   3730 02 37 B4          10037 	ljmp	00154$
                          10038 ;src/menu.c:2092: display_zone_setings(27);
   3733                   10039 00112$:
                          10040 ;     genCall
   3733 75 82 1B          10041 	mov	dpl,#0x1B
   3736 12 10 36          10042 	lcall	_display_zone_setings
                          10043 ;src/menu.c:2093: break;
   3739 02 37 B4          10044 	ljmp	00154$
                          10045 ;src/menu.c:2095: display_zone_setings(30);
   373C                   10046 00113$:
                          10047 ;     genCall
   373C 75 82 1E          10048 	mov	dpl,#0x1E
   373F 12 10 36          10049 	lcall	_display_zone_setings
                          10050 ;src/menu.c:2096: break;
                          10051 ;src/menu.c:2098: display_zone_setings(33);
                          10052 ;       Peephole 112.b  changed ljmp to sjmp
   3742 80 70             10053 	sjmp    00154$
   3744                   10054 00114$:
                          10055 ;     genCall
   3744 75 82 21          10056 	mov	dpl,#0x21
   3747 12 10 36          10057 	lcall	_display_zone_setings
                          10058 ;src/menu.c:2099: break;
                          10059 ;src/menu.c:2137: zone_workloop(current_display_state - POS_2_ZONE_OFFSET);
                          10060 ;       Peephole 112.b  changed ljmp to sjmp
   374A 80 68             10061 	sjmp    00154$
   374C                   10062 00115$:
                          10063 ;     genMinus
   374C E5 31             10064 	mov	a,_current_display_state
   374E 24 EE             10065 	add	a,#0xee
   3750 F5 82             10066 	mov	dpl,a
                          10067 ;     genCall
   3752 12 25 60          10068 	lcall	_zone_workloop
                          10069 ;src/menu.c:2138: enter_workloop = false;
                          10070 ;     genAssign
   3755 75 34 00          10071 	mov	_enter_workloop,#0x00
                          10072 ;src/menu.c:2139: break;
                          10073 ;src/menu.c:2142: display_stored_time(0, WEEKDAY,true);
                          10074 ;       Peephole 112.b  changed ljmp to sjmp
   3758 80 5A             10075 	sjmp    00154$
   375A                   10076 00151$:
                          10077 ;     genIpush
   375A 74 01             10078 	mov	a,#0x01
   375C C0 E0             10079 	push	acc
                          10080 ;     genIpush
   375E 74 04             10081 	mov	a,#0x04
   3760 C0 E0             10082 	push	acc
                          10083 ;     genCall
   3762 75 82 00          10084 	mov	dpl,#0x00
   3765 12 12 CE          10085 	lcall	_display_stored_time
   3768 15 81             10086 	dec	sp
   376A 15 81             10087 	dec	sp
                          10088 ;src/menu.c:2143: weekday_worklop(system_time.tm_wday);
                          10089 ;     genPointerGet
                          10090 ;     genFarPointerGet
   376C 90 01 88          10091 	mov	dptr,#(_system_time + 0x0007)
   376F E0                10092 	movx	a,@dptr
   3770 FA                10093 	mov	r2,a
                          10094 ;     genCast
   3771 7B 00             10095 	mov	r3,#0x00
                          10096 ;     genCall
   3773 8A 82             10097 	mov	dpl,r2
   3775 8B 83             10098 	mov	dph,r3
   3777 12 20 6F          10099 	lcall	_weekday_worklop
                          10100 ;src/menu.c:2144: enter_workloop = false;
                          10101 ;     genAssign
   377A 75 34 00          10102 	mov	_enter_workloop,#0x00
                          10103 ;src/menu.c:2145: break;
                          10104 ;src/menu.c:2148: display_stored_time(0, DATE_FORMAT,true);
                          10105 ;       Peephole 112.b  changed ljmp to sjmp
   377D 80 35             10106 	sjmp    00154$
   377F                   10107 00152$:
                          10108 ;     genIpush
   377F 74 01             10109 	mov	a,#0x01
   3781 C0 E0             10110 	push	acc
                          10111 ;     genIpush
   3783 74 01             10112 	mov	a,#0x01
   3785 C0 E0             10113 	push	acc
                          10114 ;     genCall
   3787 75 82 00          10115 	mov	dpl,#0x00
   378A 12 12 CE          10116 	lcall	_display_stored_time
   378D 15 81             10117 	dec	sp
   378F 15 81             10118 	dec	sp
                          10119 ;src/menu.c:2149: date_workloop(true);
                          10120 ;     genCall
   3791 75 82 01          10121 	mov	dpl,#0x01
   3794 12 30 7B          10122 	lcall	_date_workloop
                          10123 ;src/menu.c:2150: enter_workloop = false;
                          10124 ;     genAssign
   3797 75 34 00          10125 	mov	_enter_workloop,#0x00
                          10126 ;src/menu.c:2151: break;
                          10127 ;src/menu.c:2154: display_stored_time(0, TIME_FORMAT,true);
                          10128 ;       Peephole 112.b  changed ljmp to sjmp
   379A 80 18             10129 	sjmp    00154$
   379C                   10130 00153$:
                          10131 ;     genIpush
   379C 74 01             10132 	mov	a,#0x01
   379E C0 E0             10133 	push	acc
                          10134 ;     genIpush
   37A0 74 02             10135 	mov	a,#0x02
   37A2 C0 E0             10136 	push	acc
                          10137 ;     genCall
   37A4 75 82 00          10138 	mov	dpl,#0x00
   37A7 12 12 CE          10139 	lcall	_display_stored_time
   37AA 15 81             10140 	dec	sp
   37AC 15 81             10141 	dec	sp
                          10142 ;src/menu.c:2155: time_workloop();
                          10143 ;     genCall
   37AE 12 2E 54          10144 	lcall	_time_workloop
                          10145 ;src/menu.c:2156: enter_workloop = false;
                          10146 ;     genAssign
   37B1 75 34 00          10147 	mov	_enter_workloop,#0x00
                          10148 ;src/menu.c:2158: }
   37B4                   10149 00154$:
                          10150 ;src/menu.c:2160: if (enter_workloop == true)
                          10151 ;     genCmpEq
   37B4 E5 34             10152 	mov	a,_enter_workloop
   37B6 B4 01 02          10153 	cjne	a,#0x01,00270$
   37B9 80 03             10154 	sjmp	00271$
   37BB                   10155 00270$:
   37BB 02 34 AB          10156 	ljmp	00158$
   37BE                   10157 00271$:
                          10158 ;src/menu.c:2161: workloop();
                          10159 ;     genCall
   37BE 12 32 5F          10160 	lcall	_workloop
   37C1 02 34 AB          10161 	ljmp	00158$
   37C4                   10162 00160$:
   37C4 85 40 81          10163 	mov	sp,_bp
   37C7 D0 40             10164 	pop	_bp
   37C9 22                10165 	ret
                          10166 	.area CSEG    (CODE)
   37CA                   10167 _zone_day_map:
   37CA 00                10168 	.db #0x00
   37CB 00                10169 	.db #0x00
   37CC 01                10170 	.db #0x01
   37CD 00                10171 	.db #0x00
   37CE 02                10172 	.db #0x02
   37CF 00                10173 	.db #0x00
   37D0 03                10174 	.db #0x03
   37D1 05                10175 	.db #0x05
   37D2 04                10176 	.db #0x04
   37D3 05                10177 	.db #0x05
   37D4 05                10178 	.db #0x05
   37D5 05                10179 	.db #0x05
   37D6 06                10180 	.db #0x06
   37D7 06                10181 	.db #0x06
   37D8 07                10182 	.db #0x07
   37D9 06                10183 	.db #0x06
   37DA 08                10184 	.db #0x08
   37DB 06                10185 	.db #0x06
   37DC 09                10186 	.db #0x09
   37DD 00                10187 	.db #0x00
   37DE 0A                10188 	.db #0x0A
   37DF 00                10189 	.db #0x00
   37E0 0B                10190 	.db #0x0B
   37E1 00                10191 	.db #0x00
   37E2 0C                10192 	.db #0x0C
   37E3 05                10193 	.db #0x05
   37E4 0D                10194 	.db #0x0D
   37E5 05                10195 	.db #0x05
   37E6 0E                10196 	.db #0x0E
   37E7 05                10197 	.db #0x05
   37E8 0F                10198 	.db #0x0F
   37E9 06                10199 	.db #0x06
   37EA 10                10200 	.db #0x10
   37EB 06                10201 	.db #0x06
   37EC 11                10202 	.db #0x11
   37ED 06                10203 	.db #0x06
   37EE 12                10204 	.db #0x12
   37EF 00                10205 	.db #0x00
   37F0 13                10206 	.db #0x13
   37F1 00                10207 	.db #0x00
   37F2 14                10208 	.db #0x14
   37F3 00                10209 	.db #0x00
   37F4 15                10210 	.db #0x15
   37F5 05                10211 	.db #0x05
   37F6 16                10212 	.db #0x16
   37F7 05                10213 	.db #0x05
   37F8 17                10214 	.db #0x17
   37F9 05                10215 	.db #0x05
   37FA 18                10216 	.db #0x18
   37FB 06                10217 	.db #0x06
   37FC 19                10218 	.db #0x19
   37FD 06                10219 	.db #0x06
   37FE 1A                10220 	.db #0x1A
   37FF 06                10221 	.db #0x06
   3800 1B                10222 	.db #0x1B
   3801 00                10223 	.db #0x00
   3802 1C                10224 	.db #0x1C
   3803 00                10225 	.db #0x00
   3804 1D                10226 	.db #0x1D
   3805 00                10227 	.db #0x00
   3806 1E                10228 	.db #0x1E
   3807 05                10229 	.db #0x05
   3808 1F                10230 	.db #0x1F
   3809 05                10231 	.db #0x05
   380A 20                10232 	.db #0x20
   380B 05                10233 	.db #0x05
   380C 21                10234 	.db #0x21
   380D 06                10235 	.db #0x06
   380E 22                10236 	.db #0x22
   380F 06                10237 	.db #0x06
   3810 23                10238 	.db #0x23
   3811 06                10239 	.db #0x06
   3812                   10240 _dfp:
   3812 00 7D             10241 	.byte #0x00,#0x7D
   3814                   10242 _minmax:
   3814 00 00             10243 	.byte #0x00,#0x00
   3816 0F 27             10244 	.byte #0x0F,#0x27
   3818 00 00             10245 	.byte #0x00,#0x00
   381A 63 00             10246 	.byte #0x63,#0x00
   381C 00 00             10247 	.byte #0x00,#0x00
   381E 0F 27             10248 	.byte #0x0F,#0x27
   3820 00 00             10249 	.byte #0x00,#0x00
   3822 D0 07             10250 	.byte #0xD0,#0x07
   3824 01 00             10251 	.byte #0x01,#0x00
   3826 0A 00             10252 	.byte #0x0A,#0x00
   3828 01 00             10253 	.byte #0x01,#0x00
   382A 0A 00             10254 	.byte #0x0A,#0x00
   382C 01 00             10255 	.byte #0x01,#0x00
   382E 0A 00             10256 	.byte #0x0A,#0x00
   3830 01 00             10257 	.byte #0x01,#0x00
   3832 14 00             10258 	.byte #0x14,#0x00
   3834 00 00             10259 	.byte #0x00,#0x00
   3836 63 00             10260 	.byte #0x63,#0x00
   3838 00 00             10261 	.byte #0x00,#0x00
   383A E7 03             10262 	.byte #0xE7,#0x03
   383C 00 00             10263 	.byte #0x00,#0x00
   383E 64 00             10264 	.byte #0x64,#0x00
   3840 00 00             10265 	.byte #0x00,#0x00
   3842 C8 00             10266 	.byte #0xC8,#0x00
   3844 01 00             10267 	.byte #0x01,#0x00
   3846 0A 00             10268 	.byte #0x0A,#0x00
   3848 01 00             10269 	.byte #0x01,#0x00
   384A 63 00             10270 	.byte #0x63,#0x00
   384C A0 00             10271 	.byte #0xA0,#0x00
   384E FF 00             10272 	.byte #0xFF,#0x00
   3850                   10273 _bpr:
   3850 FF                10274 	.db #0xFF
   3851 C1 4A 02          10275 	.byte _str_18,(_str_18 >> 8),#0x02
   3854 C2 4A 02          10276 	.byte _str_19,(_str_19 >> 8),#0x02
   3857 C3 4A 02          10277 	.byte _str_20,(_str_20 >> 8),#0x02
   385A C4 4A 02          10278 	.byte _str_21,(_str_21 >> 8),#0x02
   385D FF                10279 	.db #0xFF
   385E 00                10280 	.db #0x00
   385F C5 4A 02          10281 	.byte _str_22,(_str_22 >> 8),#0x02
   3862 CC 4A 02          10282 	.byte _str_23,(_str_23 >> 8),#0x02
   3865 D3 4A 02          10283 	.byte _str_24,(_str_24 >> 8),#0x02
   3868 D4 4A 02          10284 	.byte _str_25,(_str_25 >> 8),#0x02
   386B 01                10285 	.db #0x01
   386C 07                10286 	.db #0x07
   386D D5 4A 02          10287 	.byte _str_26,(_str_26 >> 8),#0x02
   3870 DD 4A 02          10288 	.byte _str_27,(_str_27 >> 8),#0x02
   3873 E5 4A 02          10289 	.byte _str_28,(_str_28 >> 8),#0x02
   3876 E6 4A 02          10290 	.byte _str_29,(_str_29 >> 8),#0x02
   3879 01                10291 	.db #0x01
   387A 0F                10292 	.db #0x0F
   387B E7 4A 02          10293 	.byte _str_30,(_str_30 >> 8),#0x02
   387E EE 4A 02          10294 	.byte _str_31,(_str_31 >> 8),#0x02
   3881 F5 4A 02          10295 	.byte _str_32,(_str_32 >> 8),#0x02
   3884 F6 4A 02          10296 	.byte _str_33,(_str_33 >> 8),#0x02
   3887 01                10297 	.db #0x01
   3888 16                10298 	.db #0x16
   3889 F7 4A 02          10299 	.byte _str_34,(_str_34 >> 8),#0x02
   388C FF 4A 02          10300 	.byte _str_35,(_str_35 >> 8),#0x02
   388F 07 4B 02          10301 	.byte _str_36,(_str_36 >> 8),#0x02
   3892 08 4B 02          10302 	.byte _str_37,(_str_37 >> 8),#0x02
   3895 01                10303 	.db #0x01
   3896 23                10304 	.db #0x23
   3897 09 4B 02          10305 	.byte _str_38,(_str_38 >> 8),#0x02
   389A 0F 4B 02          10306 	.byte _str_39,(_str_39 >> 8),#0x02
   389D 15 4B 02          10307 	.byte _str_40,(_str_40 >> 8),#0x02
   38A0 16 4B 02          10308 	.byte _str_41,(_str_41 >> 8),#0x02
   38A3 01                10309 	.db #0x01
   38A4 21                10310 	.db #0x21
   38A5 17 4B 02          10311 	.byte _str_42,(_str_42 >> 8),#0x02
   38A8 1E 4B 02          10312 	.byte _str_43,(_str_43 >> 8),#0x02
   38AB 25 4B 02          10313 	.byte _str_44,(_str_44 >> 8),#0x02
   38AE 2B 4B 02          10314 	.byte _str_45,(_str_45 >> 8),#0x02
   38B1 02                10315 	.db #0x02
   38B2 05                10316 	.db #0x05
   38B3 31 4B 02          10317 	.byte _str_46,(_str_46 >> 8),#0x02
   38B6 3C 4B 02          10318 	.byte _str_47,(_str_47 >> 8),#0x02
   38B9 47 4B 02          10319 	.byte _str_48,(_str_48 >> 8),#0x02
   38BC 48 4B 02          10320 	.byte _str_49,(_str_49 >> 8),#0x02
   38BF 01                10321 	.db #0x01
   38C0 11                10322 	.db #0x11
   38C1 49 4B 02          10323 	.byte _str_50,(_str_50 >> 8),#0x02
   38C4 50 4B 02          10324 	.byte _str_51,(_str_51 >> 8),#0x02
   38C7 57 4B 02          10325 	.byte _str_52,(_str_52 >> 8),#0x02
   38CA 58 4B 02          10326 	.byte _str_53,(_str_53 >> 8),#0x02
   38CD 01                10327 	.db #0x01
   38CE 19                10328 	.db #0x19
   38CF 59 4B 02          10329 	.byte _str_54,(_str_54 >> 8),#0x02
   38D2 63 4B 02          10330 	.byte _str_55,(_str_55 >> 8),#0x02
   38D5 6D 4B 02          10331 	.byte _str_56,(_str_56 >> 8),#0x02
   38D8 6E 4B 02          10332 	.byte _str_57,(_str_57 >> 8),#0x02
   38DB 01                10333 	.db #0x01
   38DC 24                10334 	.db #0x24
   38DD 6F 4B 02          10335 	.byte _str_58,(_str_58 >> 8),#0x02
   38E0 74 4B 02          10336 	.byte _str_59,(_str_59 >> 8),#0x02
   38E3 79 4B 02          10337 	.byte _str_60,(_str_60 >> 8),#0x02
   38E6 7A 4B 02          10338 	.byte _str_61,(_str_61 >> 8),#0x02
   38E9 01                10339 	.db #0x01
   38EA 00                10340 	.db #0x00
   38EB 7B 4B 02          10341 	.byte _str_62,(_str_62 >> 8),#0x02
   38EE 7E 4B 02          10342 	.byte _str_63,(_str_63 >> 8),#0x02
   38F1 81 4B 02          10343 	.byte _str_64,(_str_64 >> 8),#0x02
   38F4 82 4B 02          10344 	.byte _str_65,(_str_65 >> 8),#0x02
   38F7 01                10345 	.db #0x01
   38F8 0E                10346 	.db #0x0E
   38F9 83 4B 02          10347 	.byte _str_66,(_str_66 >> 8),#0x02
   38FC 86 4B 02          10348 	.byte _str_67,(_str_67 >> 8),#0x02
   38FF 89 4B 02          10349 	.byte _str_68,(_str_68 >> 8),#0x02
   3902 8A 4B 02          10350 	.byte _str_69,(_str_69 >> 8),#0x02
   3905 01                10351 	.db #0x01
   3906 1C                10352 	.db #0x1C
   3907 8B 4B 02          10353 	.byte _str_70,(_str_70 >> 8),#0x02
   390A 8E 4B 02          10354 	.byte _str_71,(_str_71 >> 8),#0x02
   390D 91 4B 02          10355 	.byte _str_72,(_str_72 >> 8),#0x02
   3910 92 4B 02          10356 	.byte _str_73,(_str_73 >> 8),#0x02
   3913 01                10357 	.db #0x01
   3914 1C                10358 	.db #0x1C
   3915 93 4B 02          10359 	.byte _str_74,(_str_74 >> 8),#0x02
   3918 98 4B 02          10360 	.byte _str_75,(_str_75 >> 8),#0x02
   391B 9D 4B 02          10361 	.byte _str_76,(_str_76 >> 8),#0x02
   391E 9E 4B 02          10362 	.byte _str_77,(_str_77 >> 8),#0x02
   3921 01                10363 	.db #0x01
   3922 24                10364 	.db #0x24
   3923 9F 4B 02          10365 	.byte _str_78,(_str_78 >> 8),#0x02
   3926 A4 4B 02          10366 	.byte _str_79,(_str_79 >> 8),#0x02
   3929 A9 4B 02          10367 	.byte _str_80,(_str_80 >> 8),#0x02
   392C AA 4B 02          10368 	.byte _str_81,(_str_81 >> 8),#0x02
   392F 01                10369 	.db #0x01
   3930 09                10370 	.db #0x09
   3931 AB 4B 02          10371 	.byte _str_82,(_str_82 >> 8),#0x02
   3934 B2 4B 02          10372 	.byte _str_83,(_str_83 >> 8),#0x02
   3937 B9 4B 02          10373 	.byte _str_84,(_str_84 >> 8),#0x02
   393A BA 4B 02          10374 	.byte _str_85,(_str_85 >> 8),#0x02
   393D 01                10375 	.db #0x01
   393E 12                10376 	.db #0x12
   393F BB 4B 02          10377 	.byte _str_86,(_str_86 >> 8),#0x02
   3942 C5 4B 02          10378 	.byte _str_87,(_str_87 >> 8),#0x02
   3945 CF 4B 02          10379 	.byte _str_88,(_str_88 >> 8),#0x02
   3948 D0 4B 02          10380 	.byte _str_89,(_str_89 >> 8),#0x02
   394B 01                10381 	.db #0x01
   394C 24                10382 	.db #0x24
   394D D1 4B 02          10383 	.byte _str_90,(_str_90 >> 8),#0x02
   3950 D6 4B 02          10384 	.byte _str_91,(_str_91 >> 8),#0x02
   3953 DB 4B 02          10385 	.byte _str_92,(_str_92 >> 8),#0x02
   3956 DC 4B 02          10386 	.byte _str_93,(_str_93 >> 8),#0x02
   3959 01                10387 	.db #0x01
   395A 08                10388 	.db #0x08
   395B DD 4B 02          10389 	.byte _str_94,(_str_94 >> 8),#0x02
   395E E5 4B 02          10390 	.byte _str_95,(_str_95 >> 8),#0x02
   3961 ED 4B 02          10391 	.byte _str_96,(_str_96 >> 8),#0x02
   3964 EE 4B 02          10392 	.byte _str_97,(_str_97 >> 8),#0x02
   3967 01                10393 	.db #0x01
   3968 11                10394 	.db #0x11
   3969 EF 4B 02          10395 	.byte _str_98,(_str_98 >> 8),#0x02
   396C F9 4B 02          10396 	.byte _str_99,(_str_99 >> 8),#0x02
   396F 03 4C 02          10397 	.byte _str_100,(_str_100 >> 8),#0x02
   3972 04 4C 02          10398 	.byte _str_101,(_str_101 >> 8),#0x02
   3975 01                10399 	.db #0x01
   3976 1D                10400 	.db #0x1D
   3977 05 4C 02          10401 	.byte _str_102,(_str_102 >> 8),#0x02
   397A 0B 4C 02          10402 	.byte _str_103,(_str_103 >> 8),#0x02
   397D 11 4C 02          10403 	.byte _str_104,(_str_104 >> 8),#0x02
   3980 12 4C 02          10404 	.byte _str_105,(_str_105 >> 8),#0x02
   3983 01                10405 	.db #0x01
   3984 24                10406 	.db #0x24
   3985 13 4C 02          10407 	.byte _str_106,(_str_106 >> 8),#0x02
   3988 18 4C 02          10408 	.byte _str_107,(_str_107 >> 8),#0x02
   398B 1D 4C 02          10409 	.byte _str_108,(_str_108 >> 8),#0x02
   398E 1E 4C 02          10410 	.byte _str_109,(_str_109 >> 8),#0x02
   3991 01                10411 	.db #0x01
   3992 07                10412 	.db #0x07
   3993 1F 4C 02          10413 	.byte _str_110,(_str_110 >> 8),#0x02
   3996 26 4C 02          10414 	.byte _str_111,(_str_111 >> 8),#0x02
   3999 2D 4C 02          10415 	.byte _str_112,(_str_112 >> 8),#0x02
   399C 2E 4C 02          10416 	.byte _str_113,(_str_113 >> 8),#0x02
   399F 01                10417 	.db #0x01
   39A0 0E                10418 	.db #0x0E
   39A1 2F 4C 02          10419 	.byte _str_114,(_str_114 >> 8),#0x02
   39A4 36 4C 02          10420 	.byte _str_115,(_str_115 >> 8),#0x02
   39A7 3D 4C 02          10421 	.byte _str_116,(_str_116 >> 8),#0x02
   39AA 3E 4C 02          10422 	.byte _str_117,(_str_117 >> 8),#0x02
   39AD 01                10423 	.db #0x01
   39AE 15                10424 	.db #0x15
   39AF 3F 4C 02          10425 	.byte _str_118,(_str_118 >> 8),#0x02
   39B2 47 4C 02          10426 	.byte _str_119,(_str_119 >> 8),#0x02
   39B5 4F 4C 02          10427 	.byte _str_120,(_str_120 >> 8),#0x02
   39B8 50 4C 02          10428 	.byte _str_121,(_str_121 >> 8),#0x02
   39BB 01                10429 	.db #0x01
   39BC 1D                10430 	.db #0x1D
   39BD 51 4C 02          10431 	.byte _str_122,(_str_122 >> 8),#0x02
   39C0 57 4C 02          10432 	.byte _str_123,(_str_123 >> 8),#0x02
   39C3 5D 4C 02          10433 	.byte _str_124,(_str_124 >> 8),#0x02
   39C6 5E 4C 02          10434 	.byte _str_125,(_str_125 >> 8),#0x02
   39C9 01                10435 	.db #0x01
   39CA 24                10436 	.db #0x24
   39CB 5F 4C 02          10437 	.byte _str_126,(_str_126 >> 8),#0x02
   39CE 64 4C 02          10438 	.byte _str_127,(_str_127 >> 8),#0x02
   39D1 69 4C 02          10439 	.byte _str_128,(_str_128 >> 8),#0x02
   39D4 6A 4C 02          10440 	.byte _str_129,(_str_129 >> 8),#0x02
   39D7 01                10441 	.db #0x01
   39D8 1C                10442 	.db #0x1C
   39D9 6B 4C 02          10443 	.byte _str_130,(_str_130 >> 8),#0x02
   39DC 71 4C 02          10444 	.byte _str_131,(_str_131 >> 8),#0x02
   39DF 77 4C 02          10445 	.byte _str_132,(_str_132 >> 8),#0x02
   39E2 78 4C 02          10446 	.byte _str_133,(_str_133 >> 8),#0x02
   39E5 01                10447 	.db #0x01
   39E6 00                10448 	.db #0x00
   39E7 79 4C 02          10449 	.byte _str_134,(_str_134 >> 8),#0x02
   39EA 7E 4C 02          10450 	.byte _str_135,(_str_135 >> 8),#0x02
   39ED 83 4C 02          10451 	.byte _str_136,(_str_136 >> 8),#0x02
   39F0 84 4C 02          10452 	.byte _str_137,(_str_137 >> 8),#0x02
   39F3 01                10453 	.db #0x01
   39F4 0C                10454 	.db #0x0C
   39F5 85 4C 02          10455 	.byte _str_138,(_str_138 >> 8),#0x02
   39F8 8A 4C 02          10456 	.byte _str_139,(_str_139 >> 8),#0x02
   39FB 8F 4C 02          10457 	.byte _str_140,(_str_140 >> 8),#0x02
   39FE 90 4C 02          10458 	.byte _str_141,(_str_141 >> 8),#0x02
   3A01 01                10459 	.db #0x01
   3A02 19                10460 	.db #0x19
   3A03 91 4C 02          10461 	.byte _str_142,(_str_142 >> 8),#0x02
   3A06 98 4C 02          10462 	.byte _str_143,(_str_143 >> 8),#0x02
   3A09 9F 4C 02          10463 	.byte _str_144,(_str_144 >> 8),#0x02
   3A0C AB 4C 02          10464 	.byte _str_145,(_str_145 >> 8),#0x02
   3A0F 02                10465 	.db #0x02
   3A10 00                10466 	.db #0x00
   3A11 B7 4C 02          10467 	.byte _str_146,(_str_146 >> 8),#0x02
   3A14 BB 4C 02          10468 	.byte _str_147,(_str_147 >> 8),#0x02
   3A17 BF 4C 02          10469 	.byte _str_148,(_str_148 >> 8),#0x02
   3A1A C0 4C 02          10470 	.byte _str_149,(_str_149 >> 8),#0x02
   3A1D 01                10471 	.db #0x01
   3A1E 09                10472 	.db #0x09
   3A1F C1 4C 02          10473 	.byte _str_150,(_str_150 >> 8),#0x02
   3A22 C6 4C 02          10474 	.byte _str_151,(_str_151 >> 8),#0x02
   3A25 CB 4C 02          10475 	.byte _str_152,(_str_152 >> 8),#0x02
   3A28 CC 4C 02          10476 	.byte _str_153,(_str_153 >> 8),#0x02
   3A2B 01                10477 	.db #0x01
   3A2C 0F                10478 	.db #0x0F
   3A2D CD 4C 02          10479 	.byte _str_154,(_str_154 >> 8),#0x02
   3A30 D3 4C 02          10480 	.byte _str_155,(_str_155 >> 8),#0x02
   3A33 D9 4C 02          10481 	.byte _str_156,(_str_156 >> 8),#0x02
   3A36 DA 4C 02          10482 	.byte _str_157,(_str_157 >> 8),#0x02
   3A39 01                10483 	.db #0x01
   3A3A 16                10484 	.db #0x16
   3A3B DB 4C 02          10485 	.byte _str_158,(_str_158 >> 8),#0x02
   3A3E E0 4C 02          10486 	.byte _str_159,(_str_159 >> 8),#0x02
   3A41 E5 4C 02          10487 	.byte _str_160,(_str_160 >> 8),#0x02
   3A44 E6 4C 02          10488 	.byte _str_161,(_str_161 >> 8),#0x02
   3A47 01                10489 	.db #0x01
   3A48 1C                10490 	.db #0x1C
   3A49 E7 4C 02          10491 	.byte _str_162,(_str_162 >> 8),#0x02
   3A4C ED 4C 02          10492 	.byte _str_163,(_str_163 >> 8),#0x02
   3A4F F3 4C 02          10493 	.byte _str_164,(_str_164 >> 8),#0x02
   3A52 F4 4C 02          10494 	.byte _str_165,(_str_165 >> 8),#0x02
   3A55 01                10495 	.db #0x01
   3A56 0F                10496 	.db #0x0F
   3A57 F5 4C 02          10497 	.byte _str_166,(_str_166 >> 8),#0x02
   3A5A FA 4C 02          10498 	.byte _str_167,(_str_167 >> 8),#0x02
   3A5D FF 4C 02          10499 	.byte _str_168,(_str_168 >> 8),#0x02
   3A60 00 4D 02          10500 	.byte _str_169,(_str_169 >> 8),#0x02
   3A63 01                10501 	.db #0x01
   3A64 15                10502 	.db #0x15
   3A65 01 4D 02          10503 	.byte _str_170,(_str_170 >> 8),#0x02
   3A68 0F 4D 02          10504 	.byte _str_171,(_str_171 >> 8),#0x02
   3A6B 1D 4D 02          10505 	.byte _str_172,(_str_172 >> 8),#0x02
   3A6E 1E 4D 02          10506 	.byte _str_173,(_str_173 >> 8),#0x02
   3A71 01                10507 	.db #0x01
   3A72 05                10508 	.db #0x05
   3A73 1F 4D 02          10509 	.byte _str_174,(_str_174 >> 8),#0x02
   3A76 22 4D 02          10510 	.byte _str_175,(_str_175 >> 8),#0x02
   3A79 25 4D 02          10511 	.byte _str_176,(_str_176 >> 8),#0x02
   3A7C 26 4D 02          10512 	.byte _str_177,(_str_177 >> 8),#0x02
   3A7F 01                10513 	.db #0x01
   3A80 08                10514 	.db #0x08
   3A81 27 4D 02          10515 	.byte _str_178,(_str_178 >> 8),#0x02
   3A84 32 4D 02          10516 	.byte _str_179,(_str_179 >> 8),#0x02
   3A87 3D 4D 02          10517 	.byte _str_180,(_str_180 >> 8),#0x02
   3A8A 3E 4D 02          10518 	.byte _str_181,(_str_181 >> 8),#0x02
   3A8D 01                10519 	.db #0x01
   3A8E 13                10520 	.db #0x13
   3A8F 3F 4D 02          10521 	.byte _str_182,(_str_182 >> 8),#0x02
   3A92 48 4D 02          10522 	.byte _str_183,(_str_183 >> 8),#0x02
   3A95 51 4D 02          10523 	.byte _str_184,(_str_184 >> 8),#0x02
   3A98 52 4D 02          10524 	.byte _str_185,(_str_185 >> 8),#0x02
   3A9B 01                10525 	.db #0x01
   3A9C 1C                10526 	.db #0x1C
   3A9D 53 4D 02          10527 	.byte _str_186,(_str_186 >> 8),#0x02
   3AA0 5A 4D 02          10528 	.byte _str_187,(_str_187 >> 8),#0x02
   3AA3 61 4D 02          10529 	.byte _str_188,(_str_188 >> 8),#0x02
   3AA6 62 4D 02          10530 	.byte _str_189,(_str_189 >> 8),#0x02
   3AA9 01                10531 	.db #0x01
   3AAA 17                10532 	.db #0x17
   3AAB 63 4D 02          10533 	.byte _str_190,(_str_190 >> 8),#0x02
   3AAE 69 4D 02          10534 	.byte _str_191,(_str_191 >> 8),#0x02
   3AB1 6F 4D 02          10535 	.byte _str_192,(_str_192 >> 8),#0x02
   3AB4 70 4D 02          10536 	.byte _str_193,(_str_193 >> 8),#0x02
   3AB7 01                10537 	.db #0x01
   3AB8                   10538 _dpl:
   3AB8 FF                10539 	.db #0xFF
   3AB9 FF                10540 	.db #0xFF
   3ABA FF                10541 	.db #0xFF
   3ABB C1 4A 02          10542 	.byte _str_18,(_str_18 >> 8),#0x02
   3ABE 08                10543 	.db #0x08
   3ABF 01                10544 	.db #0x01
   3AC0 03                10545 	.db #0x03
   3AC1 71 4D 02          10546 	.byte _str_194,(_str_194 >> 8),#0x02
   3AC4 0F                10547 	.db #0x0F
   3AC5 01                10548 	.db #0x01
   3AC6 00                10549 	.db #0x00
   3AC7 2E 4A 02          10550 	.byte __str_7,(__str_7 >> 8),#0x02
   3ACA 15                10551 	.db #0x15
   3ACB 01                10552 	.db #0x01
   3ACC 03                10553 	.db #0x03
   3ACD 76 4D 02          10554 	.byte _str_195,(_str_195 >> 8),#0x02
   3AD0 09                10555 	.db #0x09
   3AD1 01                10556 	.db #0x01
   3AD2 00                10557 	.db #0x00
   3AD3 2E 4A 02          10558 	.byte __str_7,(__str_7 >> 8),#0x02
   3AD6 0F                10559 	.db #0x0F
   3AD7 01                10560 	.db #0x01
   3AD8 00                10561 	.db #0x00
   3AD9 2E 4A 02          10562 	.byte __str_7,(__str_7 >> 8),#0x02
   3ADC 16                10563 	.db #0x16
   3ADD 01                10564 	.db #0x01
   3ADE 00                10565 	.db #0x00
   3ADF 2E 4A 02          10566 	.byte __str_7,(__str_7 >> 8),#0x02
   3AE2 1C                10567 	.db #0x1C
   3AE3 01                10568 	.db #0x01
   3AE4 00                10569 	.db #0x00
   3AE5 2E 4A 02          10570 	.byte __str_7,(__str_7 >> 8),#0x02
   3AE8 09                10571 	.db #0x09
   3AE9 01                10572 	.db #0x01
   3AEA 00                10573 	.db #0x00
   3AEB 2E 4A 02          10574 	.byte __str_7,(__str_7 >> 8),#0x02
   3AEE 12                10575 	.db #0x12
   3AEF 01                10576 	.db #0x01
   3AF0 00                10577 	.db #0x00
   3AF1 DD 49 02          10578 	.byte __str_1,(__str_1 >> 8),#0x02
   3AF4 08                10579 	.db #0x08
   3AF5 01                10580 	.db #0x01
   3AF6 00                10581 	.db #0x00
   3AF7 7B 4D 02          10582 	.byte _str_196,(_str_196 >> 8),#0x02
   3AFA 11                10583 	.db #0x11
   3AFB 01                10584 	.db #0x01
   3AFC 00                10585 	.db #0x00
   3AFD 81 4D 02          10586 	.byte _str_197,(_str_197 >> 8),#0x02
   3B00 1D                10587 	.db #0x1D
   3B01 01                10588 	.db #0x01
   3B02 00                10589 	.db #0x00
   3B03 DD 49 02          10590 	.byte __str_1,(__str_1 >> 8),#0x02
   3B06 07                10591 	.db #0x07
   3B07 01                10592 	.db #0x01
   3B08 00                10593 	.db #0x00
   3B09 86 4D 02          10594 	.byte _str_198,(_str_198 >> 8),#0x02
   3B0C 0E                10595 	.db #0x0E
   3B0D 01                10596 	.db #0x01
   3B0E 02                10597 	.db #0x02
   3B0F DD 49 02          10598 	.byte __str_1,(__str_1 >> 8),#0x02
   3B12 15                10599 	.db #0x15
   3B13 01                10600 	.db #0x01
   3B14 02                10601 	.db #0x02
   3B15 DD 49 02          10602 	.byte __str_1,(__str_1 >> 8),#0x02
   3B18 1D                10603 	.db #0x1D
   3B19 01                10604 	.db #0x01
   3B1A 00                10605 	.db #0x00
   3B1B 2E 4A 02          10606 	.byte __str_7,(__str_7 >> 8),#0x02
   3B1E 07                10607 	.db #0x07
   3B1F 01                10608 	.db #0x01
   3B20 00                10609 	.db #0x00
   3B21 2E 4A 02          10610 	.byte __str_7,(__str_7 >> 8),#0x02
   3B24 0E                10611 	.db #0x0E
   3B25 01                10612 	.db #0x01
   3B26 02                10613 	.db #0x02
   3B27 DD 49 02          10614 	.byte __str_1,(__str_1 >> 8),#0x02
   3B2A 15                10615 	.db #0x15
   3B2B 01                10616 	.db #0x01
   3B2C 02                10617 	.db #0x02
   3B2D DD 49 02          10618 	.byte __str_1,(__str_1 >> 8),#0x02
   3B30 23                10619 	.db #0x23
   3B31 00                10620 	.db #0x00
   3B32 03                10621 	.db #0x03
   3B33 8B 4D 02          10622 	.byte _str_199,(_str_199 >> 8),#0x02
   3B36 26                10623 	.db #0x26
   3B37 00                10624 	.db #0x00
   3B38 00                10625 	.db #0x00
   3B39 2E 4A 02          10626 	.byte __str_7,(__str_7 >> 8),#0x02
   3B3C 25                10627 	.db #0x25
   3B3D 00                10628 	.db #0x00
   3B3E 00                10629 	.db #0x00
   3B3F DD 49 02          10630 	.byte __str_1,(__str_1 >> 8),#0x02
   3B42 25                10631 	.db #0x25
   3B43 00                10632 	.db #0x00
   3B44 00                10633 	.db #0x00
   3B45 90 4D 02          10634 	.byte _str_200,(_str_200 >> 8),#0x02
   3B48 25                10635 	.db #0x25
   3B49 01                10636 	.db #0x01
   3B4A 00                10637 	.db #0x00
   3B4B 95 4D 02          10638 	.byte _str_201,(_str_201 >> 8),#0x02
   3B4E 24                10639 	.db #0x24
   3B4F 00                10640 	.db #0x00
   3B50 02                10641 	.db #0x02
   3B51 DD 49 02          10642 	.byte __str_1,(__str_1 >> 8),#0x02
   3B54 1C                10643 	.db #0x1C
   3B55 01                10644 	.db #0x01
   3B56 00                10645 	.db #0x00
   3B57 9A 4D 02          10646 	.byte _str_202,(_str_202 >> 8),#0x02
   3B5A 24                10647 	.db #0x24
   3B5B 00                10648 	.db #0x00
   3B5C 00                10649 	.db #0x00
   3B5D 9F 4D 02          10650 	.byte _str_203,(_str_203 >> 8),#0x02
   3B60 00                10651 	.db #0x00
   3B61 01                10652 	.db #0x01
   3B62 00                10653 	.db #0x00
   3B63 A4 4D 02          10654 	.byte _str_204,(_str_204 >> 8),#0x02
   3B66 0C                10655 	.db #0x0C
   3B67 01                10656 	.db #0x01
   3B68 00                10657 	.db #0x00
   3B69 A9 4D 02          10658 	.byte _str_205,(_str_205 >> 8),#0x02
   3B6C 16                10659 	.db #0x16
   3B6D 01                10660 	.db #0x01
   3B6E 00                10661 	.db #0x00
   3B6F AE 4D 02          10662 	.byte _str_206,(_str_206 >> 8),#0x02
   3B72 0F                10663 	.db #0x0F
   3B73 01                10664 	.db #0x01
   3B74 00                10665 	.db #0x00
   3B75 B3 4D 02          10666 	.byte _str_207,(_str_207 >> 8),#0x02
   3B78 00                10667 	.db #0x00
   3B79 01                10668 	.db #0x01
   3B7A 00                10669 	.db #0x00
   3B7B B8 4D 02          10670 	.byte _str_208,(_str_208 >> 8),#0x02
   3B7E 09                10671 	.db #0x09
   3B7F 01                10672 	.db #0x01
   3B80 03                10673 	.db #0x03
   3B81 BD 4D 02          10674 	.byte _str_209,(_str_209 >> 8),#0x02
   3B84 25                10675 	.db #0x25
   3B85 00                10676 	.db #0x00
   3B86 00                10677 	.db #0x00
   3B87 C2 4D 02          10678 	.byte _str_210,(_str_210 >> 8),#0x02
   3B8A 1E                10679 	.db #0x1E
   3B8B 00                10680 	.db #0x00
   3B8C 00                10681 	.db #0x00
   3B8D 33 4A 02          10682 	.byte __str_8,(__str_8 >> 8),#0x02
   3B90 20                10683 	.db #0x20
   3B91 00                10684 	.db #0x00
   3B92 00                10685 	.db #0x00
   3B93 42 4A 02          10686 	.byte __str_9,(__str_9 >> 8),#0x02
   3B96 1C                10687 	.db #0x1C
   3B97 01                10688 	.db #0x01
   3B98 00                10689 	.db #0x00
   3B99 C7 4D 02          10690 	.byte _str_211,(_str_211 >> 8),#0x02
   3B9C 1C                10691 	.db #0x1C
   3B9D 01                10692 	.db #0x01
   3B9E 00                10693 	.db #0x00
   3B9F CD 4D 02          10694 	.byte _str_212,(_str_212 >> 8),#0x02
   3BA2 15                10695 	.db #0x15
   3BA3 01                10696 	.db #0x01
   3BA4 00                10697 	.db #0x00
   3BA5 DD 49 02          10698 	.byte __str_1,(__str_1 >> 8),#0x02
   3BA8 08                10699 	.db #0x08
   3BA9 01                10700 	.db #0x01
   3BAA 00                10701 	.db #0x00
   3BAB 33 4A 02          10702 	.byte __str_8,(__str_8 >> 8),#0x02
   3BAE 13                10703 	.db #0x13
   3BAF 01                10704 	.db #0x01
   3BB0 00                10705 	.db #0x00
   3BB1 D3 4D 02          10706 	.byte _str_213,(_str_213 >> 8),#0x02
   3BB4 1E                10707 	.db #0x1E
   3BB5 00                10708 	.db #0x00
   3BB6 00                10709 	.db #0x00
   3BB7 33 4A 02          10710 	.byte __str_8,(__str_8 >> 8),#0x02
   3BBA 24                10711 	.db #0x24
   3BBB 00                10712 	.db #0x00
   3BBC 00                10713 	.db #0x00
   3BBD D8 4D 02          10714 	.byte _str_214,(_str_214 >> 8),#0x02
   3BC0 24                10715 	.db #0x24
   3BC1 01                10716 	.db #0x01
   3BC2 00                10717 	.db #0x00
   3BC3 DD 4D 02          10718 	.byte _str_215,(_str_215 >> 8),#0x02
   3BC6 1C                10719 	.db #0x1C
   3BC7 01                10720 	.db #0x01
   3BC8 00                10721 	.db #0x00
   3BC9 E2 4D 02          10722 	.byte _str_216,(_str_216 >> 8),#0x02
   3BCC 1C                10723 	.db #0x1C
   3BCD 01                10724 	.db #0x01
   3BCE 00                10725 	.db #0x00
   3BCF E7 4D 02          10726 	.byte _str_217,(_str_217 >> 8),#0x02
   3BD2 00                10727 	.db #0x00
   3BD3 01                10728 	.db #0x01
   3BD4 02                10729 	.db #0x02
   3BD5 DD 49 02          10730 	.byte __str_1,(__str_1 >> 8),#0x02
   3BD8 07                10731 	.db #0x07
   3BD9 01                10732 	.db #0x01
   3BDA 02                10733 	.db #0x02
   3BDB DD 49 02          10734 	.byte __str_1,(__str_1 >> 8),#0x02
   3BDE 0F                10735 	.db #0x0F
   3BDF 01                10736 	.db #0x01
   3BE0 02                10737 	.db #0x02
   3BE1 DD 49 02          10738 	.byte __str_1,(__str_1 >> 8),#0x02
   3BE4 16                10739 	.db #0x16
   3BE5 01                10740 	.db #0x01
   3BE6 02                10741 	.db #0x02
   3BE7 DD 49 02          10742 	.byte __str_1,(__str_1 >> 8),#0x02
   3BEA 17                10743 	.db #0x17
   3BEB 01                10744 	.db #0x01
   3BEC 02                10745 	.db #0x02
   3BED EC 4D 02          10746 	.byte _str_218,(_str_218 >> 8),#0x02
   3BF0 25                10747 	.db #0x25
   3BF1 00                10748 	.db #0x00
   3BF2 00                10749 	.db #0x00
   3BF3 F1 4D 02          10750 	.byte _str_219,(_str_219 >> 8),#0x02
   3BF6 00                10751 	.db #0x00
   3BF7 01                10752 	.db #0x01
   3BF8 00                10753 	.db #0x00
   3BF9 F6 4D 02          10754 	.byte _str_220,(_str_220 >> 8),#0x02
   3BFC 0E                10755 	.db #0x0E
   3BFD 01                10756 	.db #0x01
   3BFE 00                10757 	.db #0x00
   3BFF FB 4D 02          10758 	.byte _str_221,(_str_221 >> 8),#0x02
   3C02 1C                10759 	.db #0x1C
   3C03 01                10760 	.db #0x01
   3C04 00                10761 	.db #0x00
   3C05 00 4E 02          10762 	.byte _str_222,(_str_222 >> 8),#0x02
   3C08 10                10763 	.db #0x10
   3C09 00                10764 	.db #0x00
   3C0A 00                10765 	.db #0x00
   3C0B 05 4E 02          10766 	.byte _str_223,(_str_223 >> 8),#0x02
   3C0E                   10767 _menu:
   3C0E 0A 4E 02          10768 	.byte _str_224,(_str_224 >> 8),#0x02
   3C11 05                10769 	.db #0x05
   3C12 00                10770 	.db #0x00
   3C13 01                10771 	.db #0x01
   3C14 5E 38 02          10772 	.byte (_bpr + 14),((_bpr + 14) >> 8),#0x02
   3C17 D2 3B 02          10773 	.byte (_dpl + 282),((_dpl + 282) >> 8),#0x02
   3C1A 00                10774 	.db #0x00
   3C1B 02                10775 	.db #0x02
   3C1C 6C 38 02          10776 	.byte (_bpr + 28),((_bpr + 28) >> 8),#0x02
   3C1F D8 3B 02          10777 	.byte (_dpl + 288),((_dpl + 288) >> 8),#0x02
   3C22 00                10778 	.db #0x00
   3C23 03                10779 	.db #0x03
   3C24 7A 38 02          10780 	.byte (_bpr + 42),((_bpr + 42) >> 8),#0x02
   3C27 DE 3B 02          10781 	.byte (_dpl + 294),((_dpl + 294) >> 8),#0x02
   3C2A 00                10782 	.db #0x00
   3C2B 04                10783 	.db #0x04
   3C2C 88 38 02          10784 	.byte (_bpr + 56),((_bpr + 56) >> 8),#0x02
   3C2F E4 3B 02          10785 	.byte (_dpl + 300),((_dpl + 300) >> 8),#0x02
   3C32 00                10786 	.db #0x00
   3C33 05                10787 	.db #0x05
   3C34 96 38 02          10788 	.byte (_bpr + 70),((_bpr + 70) >> 8),#0x02
   3C37 CC 3B 02          10789 	.byte (_dpl + 276),((_dpl + 276) >> 8),#0x02
   3C3A 00                10790 	.db 0x00
   3C3B 00                10791 	.db 0x00
   3C3C 00                10792 	.db 0x00
   3C3D 00                10793 	.db 0x00
   3C3E 00                10794 	.db 0x00
   3C3F 00                10795 	.db 0x00
   3C40 00                10796 	.db 0x00
   3C41 00                10797 	.db 0x00
   3C42 00                10798 	.db 0x00
   3C43 00                10799 	.db 0x00
   3C44 00                10800 	.db 0x00
   3C45 00                10801 	.db 0x00
   3C46 00                10802 	.db 0x00
   3C47 00                10803 	.db 0x00
   3C48 00                10804 	.db 0x00
   3C49 00                10805 	.db 0x00
   3C4A 59 4E 02          10806 	.byte _str_225,(_str_225 >> 8),#0x02
   3C4D 04                10807 	.db #0x04
   3C4E 00                10808 	.db #0x00
   3C4F 06                10809 	.db #0x06
   3C50 B2 38 02          10810 	.byte (_bpr + 98),((_bpr + 98) >> 8),#0x02
   3C53 B8 3A 02          10811 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3C56 00                10812 	.db #0x00
   3C57 07                10813 	.db #0x07
   3C58 C0 38 02          10814 	.byte (_bpr + 112),((_bpr + 112) >> 8),#0x02
   3C5B B8 3A 02          10815 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3C5E 00                10816 	.db #0x00
   3C5F 08                10817 	.db #0x08
   3C60 CE 38 02          10818 	.byte (_bpr + 126),((_bpr + 126) >> 8),#0x02
   3C63 B8 3A 02          10819 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3C66 00                10820 	.db #0x00
   3C67 FE                10821 	.db #0xFE
   3C68 DC 38 02          10822 	.byte (_bpr + 140),((_bpr + 140) >> 8),#0x02
   3C6B B8 3A 02          10823 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3C6E 00                10824 	.db 0x00
   3C6F 00                10825 	.db 0x00
   3C70 00                10826 	.db 0x00
   3C71 00                10827 	.db 0x00
   3C72 00                10828 	.db 0x00
   3C73 00                10829 	.db 0x00
   3C74 00                10830 	.db 0x00
   3C75 00                10831 	.db 0x00
   3C76 00                10832 	.db 0x00
   3C77 00                10833 	.db 0x00
   3C78 00                10834 	.db 0x00
   3C79 00                10835 	.db 0x00
   3C7A 00                10836 	.db 0x00
   3C7B 00                10837 	.db 0x00
   3C7C 00                10838 	.db 0x00
   3C7D 00                10839 	.db 0x00
   3C7E 00                10840 	.db 0x00
   3C7F 00                10841 	.db 0x00
   3C80 00                10842 	.db 0x00
   3C81 00                10843 	.db 0x00
   3C82 00                10844 	.db 0x00
   3C83 00                10845 	.db 0x00
   3C84 00                10846 	.db 0x00
   3C85 00                10847 	.db 0x00
   3C86 82 4E 02          10848 	.byte _str_226,(_str_226 >> 8),#0x02
   3C89 04                10849 	.db #0x04
   3C8A 00                10850 	.db #0x00
   3C8B 09                10851 	.db #0x09
   3C8C B2 38 02          10852 	.byte (_bpr + 98),((_bpr + 98) >> 8),#0x02
   3C8F B8 3A 02          10853 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3C92 00                10854 	.db #0x00
   3C93 0A                10855 	.db #0x0A
   3C94 C0 38 02          10856 	.byte (_bpr + 112),((_bpr + 112) >> 8),#0x02
   3C97 B8 3A 02          10857 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3C9A 00                10858 	.db #0x00
   3C9B 0B                10859 	.db #0x0B
   3C9C CE 38 02          10860 	.byte (_bpr + 126),((_bpr + 126) >> 8),#0x02
   3C9F B8 3A 02          10861 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3CA2 00                10862 	.db #0x00
   3CA3 FE                10863 	.db #0xFE
   3CA4 DC 38 02          10864 	.byte (_bpr + 140),((_bpr + 140) >> 8),#0x02
   3CA7 B8 3A 02          10865 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3CAA 00                10866 	.db 0x00
   3CAB 00                10867 	.db 0x00
   3CAC 00                10868 	.db 0x00
   3CAD 00                10869 	.db 0x00
   3CAE 00                10870 	.db 0x00
   3CAF 00                10871 	.db 0x00
   3CB0 00                10872 	.db 0x00
   3CB1 00                10873 	.db 0x00
   3CB2 00                10874 	.db 0x00
   3CB3 00                10875 	.db 0x00
   3CB4 00                10876 	.db 0x00
   3CB5 00                10877 	.db 0x00
   3CB6 00                10878 	.db 0x00
   3CB7 00                10879 	.db 0x00
   3CB8 00                10880 	.db 0x00
   3CB9 00                10881 	.db 0x00
   3CBA 00                10882 	.db 0x00
   3CBB 00                10883 	.db 0x00
   3CBC 00                10884 	.db 0x00
   3CBD 00                10885 	.db 0x00
   3CBE 00                10886 	.db 0x00
   3CBF 00                10887 	.db 0x00
   3CC0 00                10888 	.db 0x00
   3CC1 00                10889 	.db 0x00
   3CC2 AB 4E 02          10890 	.byte _str_227,(_str_227 >> 8),#0x02
   3CC5 04                10891 	.db #0x04
   3CC6 00                10892 	.db #0x00
   3CC7 0C                10893 	.db #0x0C
   3CC8 B2 38 02          10894 	.byte (_bpr + 98),((_bpr + 98) >> 8),#0x02
   3CCB B8 3A 02          10895 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3CCE 00                10896 	.db #0x00
   3CCF 0D                10897 	.db #0x0D
   3CD0 C0 38 02          10898 	.byte (_bpr + 112),((_bpr + 112) >> 8),#0x02
   3CD3 B8 3A 02          10899 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3CD6 00                10900 	.db #0x00
   3CD7 0E                10901 	.db #0x0E
   3CD8 CE 38 02          10902 	.byte (_bpr + 126),((_bpr + 126) >> 8),#0x02
   3CDB B8 3A 02          10903 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3CDE 00                10904 	.db #0x00
   3CDF FE                10905 	.db #0xFE
   3CE0 DC 38 02          10906 	.byte (_bpr + 140),((_bpr + 140) >> 8),#0x02
   3CE3 B8 3A 02          10907 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3CE6 00                10908 	.db 0x00
   3CE7 00                10909 	.db 0x00
   3CE8 00                10910 	.db 0x00
   3CE9 00                10911 	.db 0x00
   3CEA 00                10912 	.db 0x00
   3CEB 00                10913 	.db 0x00
   3CEC 00                10914 	.db 0x00
   3CED 00                10915 	.db 0x00
   3CEE 00                10916 	.db 0x00
   3CEF 00                10917 	.db 0x00
   3CF0 00                10918 	.db 0x00
   3CF1 00                10919 	.db 0x00
   3CF2 00                10920 	.db 0x00
   3CF3 00                10921 	.db 0x00
   3CF4 00                10922 	.db 0x00
   3CF5 00                10923 	.db 0x00
   3CF6 00                10924 	.db 0x00
   3CF7 00                10925 	.db 0x00
   3CF8 00                10926 	.db 0x00
   3CF9 00                10927 	.db 0x00
   3CFA 00                10928 	.db 0x00
   3CFB 00                10929 	.db 0x00
   3CFC 00                10930 	.db 0x00
   3CFD 00                10931 	.db 0x00
   3CFE D4 4E 02          10932 	.byte _str_228,(_str_228 >> 8),#0x02
   3D01 04                10933 	.db #0x04
   3D02 00                10934 	.db #0x00
   3D03 0F                10935 	.db #0x0F
   3D04 B2 38 02          10936 	.byte (_bpr + 98),((_bpr + 98) >> 8),#0x02
   3D07 B8 3A 02          10937 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3D0A 00                10938 	.db #0x00
   3D0B 10                10939 	.db #0x10
   3D0C C0 38 02          10940 	.byte (_bpr + 112),((_bpr + 112) >> 8),#0x02
   3D0F B8 3A 02          10941 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3D12 00                10942 	.db #0x00
   3D13 11                10943 	.db #0x11
   3D14 CE 38 02          10944 	.byte (_bpr + 126),((_bpr + 126) >> 8),#0x02
   3D17 B8 3A 02          10945 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3D1A 00                10946 	.db #0x00
   3D1B FE                10947 	.db #0xFE
   3D1C DC 38 02          10948 	.byte (_bpr + 140),((_bpr + 140) >> 8),#0x02
   3D1F B8 3A 02          10949 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3D22 00                10950 	.db 0x00
   3D23 00                10951 	.db 0x00
   3D24 00                10952 	.db 0x00
   3D25 00                10953 	.db 0x00
   3D26 00                10954 	.db 0x00
   3D27 00                10955 	.db 0x00
   3D28 00                10956 	.db 0x00
   3D29 00                10957 	.db 0x00
   3D2A 00                10958 	.db 0x00
   3D2B 00                10959 	.db 0x00
   3D2C 00                10960 	.db 0x00
   3D2D 00                10961 	.db 0x00
   3D2E 00                10962 	.db 0x00
   3D2F 00                10963 	.db 0x00
   3D30 00                10964 	.db 0x00
   3D31 00                10965 	.db 0x00
   3D32 00                10966 	.db 0x00
   3D33 00                10967 	.db 0x00
   3D34 00                10968 	.db 0x00
   3D35 00                10969 	.db 0x00
   3D36 00                10970 	.db 0x00
   3D37 00                10971 	.db 0x00
   3D38 00                10972 	.db 0x00
   3D39 00                10973 	.db 0x00
   3D3A FD 4E 02          10974 	.byte _str_229,(_str_229 >> 8),#0x02
   3D3D 04                10975 	.db #0x04
   3D3E 00                10976 	.db #0x00
   3D3F 36                10977 	.db #0x36
   3D40 E6 39 02          10978 	.byte (_bpr + 406),((_bpr + 406) >> 8),#0x02
   3D43 60 3B 02          10979 	.byte (_dpl + 168),((_dpl + 168) >> 8),#0x02
   3D46 00                10980 	.db #0x00
   3D47 37                10981 	.db #0x37
   3D48 F4 39 02          10982 	.byte (_bpr + 420),((_bpr + 420) >> 8),#0x02
   3D4B 66 3B 02          10983 	.byte (_dpl + 174),((_dpl + 174) >> 8),#0x02
   3D4E 00                10984 	.db #0x00
   3D4F 39                10985 	.db #0x39
   3D50 AA 3A 02          10986 	.byte (_bpr + 602),((_bpr + 602) >> 8),#0x02
   3D53 EA 3B 02          10987 	.byte (_dpl + 306),((_dpl + 306) >> 8),#0x02
   3D56 00                10988 	.db #0x00
   3D57 FE                10989 	.db #0xFE
   3D58 CA 39 02          10990 	.byte (_bpr + 378),((_bpr + 378) >> 8),#0x02
   3D5B B8 3A 02          10991 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3D5E 00                10992 	.db 0x00
   3D5F 00                10993 	.db 0x00
   3D60 00                10994 	.db 0x00
   3D61 00                10995 	.db 0x00
   3D62 00                10996 	.db 0x00
   3D63 00                10997 	.db 0x00
   3D64 00                10998 	.db 0x00
   3D65 00                10999 	.db 0x00
   3D66 00                11000 	.db 0x00
   3D67 00                11001 	.db 0x00
   3D68 00                11002 	.db 0x00
   3D69 00                11003 	.db 0x00
   3D6A 00                11004 	.db 0x00
   3D6B 00                11005 	.db 0x00
   3D6C 00                11006 	.db 0x00
   3D6D 00                11007 	.db 0x00
   3D6E 00                11008 	.db 0x00
   3D6F 00                11009 	.db 0x00
   3D70 00                11010 	.db 0x00
   3D71 00                11011 	.db 0x00
   3D72 00                11012 	.db 0x00
   3D73 00                11013 	.db 0x00
   3D74 00                11014 	.db 0x00
   3D75 00                11015 	.db 0x00
   3D76 26 4F 02          11016 	.byte _str_230,(_str_230 >> 8),#0x02
   3D79 04                11017 	.db #0x04
   3D7A 01                11018 	.db #0x01
   3D7B 12                11019 	.db #0x12
   3D7C EA 38 02          11020 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   3D7F F6 3B 02          11021 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   3D82 01                11022 	.db #0x01
   3D83 13                11023 	.db #0x13
   3D84 F8 38 02          11024 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   3D87 FC 3B 02          11025 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   3D8A 01                11026 	.db #0x01
   3D8B 14                11027 	.db #0x14
   3D8C 06 39 02          11028 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   3D8F 02 3C 02          11029 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   3D92 01                11030 	.db #0x01
   3D93 FE                11031 	.db #0xFE
   3D94 22 39 02          11032 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   3D97 B8 3A 02          11033 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3D9A 00                11034 	.db 0x00
   3D9B 00                11035 	.db 0x00
   3D9C 00                11036 	.db 0x00
   3D9D 00                11037 	.db 0x00
   3D9E 00                11038 	.db 0x00
   3D9F 00                11039 	.db 0x00
   3DA0 00                11040 	.db 0x00
   3DA1 00                11041 	.db 0x00
   3DA2 00                11042 	.db 0x00
   3DA3 00                11043 	.db 0x00
   3DA4 00                11044 	.db 0x00
   3DA5 00                11045 	.db 0x00
   3DA6 00                11046 	.db 0x00
   3DA7 00                11047 	.db 0x00
   3DA8 00                11048 	.db 0x00
   3DA9 00                11049 	.db 0x00
   3DAA 00                11050 	.db 0x00
   3DAB 00                11051 	.db 0x00
   3DAC 00                11052 	.db 0x00
   3DAD 00                11053 	.db 0x00
   3DAE 00                11054 	.db 0x00
   3DAF 00                11055 	.db 0x00
   3DB0 00                11056 	.db 0x00
   3DB1 00                11057 	.db 0x00
   3DB2 4F 4F 02          11058 	.byte _str_231,(_str_231 >> 8),#0x02
   3DB5 04                11059 	.db #0x04
   3DB6 01                11060 	.db #0x01
   3DB7 15                11061 	.db #0x15
   3DB8 EA 38 02          11062 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   3DBB F6 3B 02          11063 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   3DBE 01                11064 	.db #0x01
   3DBF 16                11065 	.db #0x16
   3DC0 F8 38 02          11066 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   3DC3 FC 3B 02          11067 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   3DC6 01                11068 	.db #0x01
   3DC7 17                11069 	.db #0x17
   3DC8 06 39 02          11070 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   3DCB 02 3C 02          11071 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   3DCE 01                11072 	.db #0x01
   3DCF FE                11073 	.db #0xFE
   3DD0 22 39 02          11074 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   3DD3 B8 3A 02          11075 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3DD6 00                11076 	.db 0x00
   3DD7 00                11077 	.db 0x00
   3DD8 00                11078 	.db 0x00
   3DD9 00                11079 	.db 0x00
   3DDA 00                11080 	.db 0x00
   3DDB 00                11081 	.db 0x00
   3DDC 00                11082 	.db 0x00
   3DDD 00                11083 	.db 0x00
   3DDE 00                11084 	.db 0x00
   3DDF 00                11085 	.db 0x00
   3DE0 00                11086 	.db 0x00
   3DE1 00                11087 	.db 0x00
   3DE2 00                11088 	.db 0x00
   3DE3 00                11089 	.db 0x00
   3DE4 00                11090 	.db 0x00
   3DE5 00                11091 	.db 0x00
   3DE6 00                11092 	.db 0x00
   3DE7 00                11093 	.db 0x00
   3DE8 00                11094 	.db 0x00
   3DE9 00                11095 	.db 0x00
   3DEA 00                11096 	.db 0x00
   3DEB 00                11097 	.db 0x00
   3DEC 00                11098 	.db 0x00
   3DED 00                11099 	.db 0x00
   3DEE 78 4F 02          11100 	.byte _str_232,(_str_232 >> 8),#0x02
   3DF1 04                11101 	.db #0x04
   3DF2 01                11102 	.db #0x01
   3DF3 18                11103 	.db #0x18
   3DF4 EA 38 02          11104 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   3DF7 F6 3B 02          11105 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   3DFA 01                11106 	.db #0x01
   3DFB 19                11107 	.db #0x19
   3DFC F8 38 02          11108 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   3DFF FC 3B 02          11109 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   3E02 01                11110 	.db #0x01
   3E03 1A                11111 	.db #0x1A
   3E04 06 39 02          11112 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   3E07 02 3C 02          11113 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   3E0A 01                11114 	.db #0x01
   3E0B FE                11115 	.db #0xFE
   3E0C 22 39 02          11116 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   3E0F B8 3A 02          11117 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3E12 00                11118 	.db 0x00
   3E13 00                11119 	.db 0x00
   3E14 00                11120 	.db 0x00
   3E15 00                11121 	.db 0x00
   3E16 00                11122 	.db 0x00
   3E17 00                11123 	.db 0x00
   3E18 00                11124 	.db 0x00
   3E19 00                11125 	.db 0x00
   3E1A 00                11126 	.db 0x00
   3E1B 00                11127 	.db 0x00
   3E1C 00                11128 	.db 0x00
   3E1D 00                11129 	.db 0x00
   3E1E 00                11130 	.db 0x00
   3E1F 00                11131 	.db 0x00
   3E20 00                11132 	.db 0x00
   3E21 00                11133 	.db 0x00
   3E22 00                11134 	.db 0x00
   3E23 00                11135 	.db 0x00
   3E24 00                11136 	.db 0x00
   3E25 00                11137 	.db 0x00
   3E26 00                11138 	.db 0x00
   3E27 00                11139 	.db 0x00
   3E28 00                11140 	.db 0x00
   3E29 00                11141 	.db 0x00
   3E2A A1 4F 02          11142 	.byte _str_233,(_str_233 >> 8),#0x02
   3E2D 04                11143 	.db #0x04
   3E2E 02                11144 	.db #0x02
   3E2F 1B                11145 	.db #0x1B
   3E30 EA 38 02          11146 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   3E33 F6 3B 02          11147 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   3E36 02                11148 	.db #0x02
   3E37 1C                11149 	.db #0x1C
   3E38 F8 38 02          11150 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   3E3B FC 3B 02          11151 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   3E3E 02                11152 	.db #0x02
   3E3F 1D                11153 	.db #0x1D
   3E40 06 39 02          11154 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   3E43 02 3C 02          11155 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   3E46 01                11156 	.db #0x01
   3E47 FE                11157 	.db #0xFE
   3E48 22 39 02          11158 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   3E4B B8 3A 02          11159 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3E4E 00                11160 	.db 0x00
   3E4F 00                11161 	.db 0x00
   3E50 00                11162 	.db 0x00
   3E51 00                11163 	.db 0x00
   3E52 00                11164 	.db 0x00
   3E53 00                11165 	.db 0x00
   3E54 00                11166 	.db 0x00
   3E55 00                11167 	.db 0x00
   3E56 00                11168 	.db 0x00
   3E57 00                11169 	.db 0x00
   3E58 00                11170 	.db 0x00
   3E59 00                11171 	.db 0x00
   3E5A 00                11172 	.db 0x00
   3E5B 00                11173 	.db 0x00
   3E5C 00                11174 	.db 0x00
   3E5D 00                11175 	.db 0x00
   3E5E 00                11176 	.db 0x00
   3E5F 00                11177 	.db 0x00
   3E60 00                11178 	.db 0x00
   3E61 00                11179 	.db 0x00
   3E62 00                11180 	.db 0x00
   3E63 00                11181 	.db 0x00
   3E64 00                11182 	.db 0x00
   3E65 00                11183 	.db 0x00
   3E66 CA 4F 02          11184 	.byte _str_234,(_str_234 >> 8),#0x02
   3E69 04                11185 	.db #0x04
   3E6A 02                11186 	.db #0x02
   3E6B 1E                11187 	.db #0x1E
   3E6C EA 38 02          11188 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   3E6F F6 3B 02          11189 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   3E72 02                11190 	.db #0x02
   3E73 1F                11191 	.db #0x1F
   3E74 F8 38 02          11192 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   3E77 FC 3B 02          11193 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   3E7A 02                11194 	.db #0x02
   3E7B 20                11195 	.db #0x20
   3E7C 06 39 02          11196 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   3E7F 02 3C 02          11197 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   3E82 02                11198 	.db #0x02
   3E83 FE                11199 	.db #0xFE
   3E84 22 39 02          11200 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   3E87 B8 3A 02          11201 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3E8A 00                11202 	.db 0x00
   3E8B 00                11203 	.db 0x00
   3E8C 00                11204 	.db 0x00
   3E8D 00                11205 	.db 0x00
   3E8E 00                11206 	.db 0x00
   3E8F 00                11207 	.db 0x00
   3E90 00                11208 	.db 0x00
   3E91 00                11209 	.db 0x00
   3E92 00                11210 	.db 0x00
   3E93 00                11211 	.db 0x00
   3E94 00                11212 	.db 0x00
   3E95 00                11213 	.db 0x00
   3E96 00                11214 	.db 0x00
   3E97 00                11215 	.db 0x00
   3E98 00                11216 	.db 0x00
   3E99 00                11217 	.db 0x00
   3E9A 00                11218 	.db 0x00
   3E9B 00                11219 	.db 0x00
   3E9C 00                11220 	.db 0x00
   3E9D 00                11221 	.db 0x00
   3E9E 00                11222 	.db 0x00
   3E9F 00                11223 	.db 0x00
   3EA0 00                11224 	.db 0x00
   3EA1 00                11225 	.db 0x00
   3EA2 F3 4F 02          11226 	.byte _str_235,(_str_235 >> 8),#0x02
   3EA5 04                11227 	.db #0x04
   3EA6 02                11228 	.db #0x02
   3EA7 21                11229 	.db #0x21
   3EA8 EA 38 02          11230 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   3EAB F6 3B 02          11231 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   3EAE 02                11232 	.db #0x02
   3EAF 22                11233 	.db #0x22
   3EB0 F8 38 02          11234 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   3EB3 FC 3B 02          11235 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   3EB6 02                11236 	.db #0x02
   3EB7 23                11237 	.db #0x23
   3EB8 06 39 02          11238 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   3EBB 02 3C 02          11239 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   3EBE 02                11240 	.db #0x02
   3EBF FE                11241 	.db #0xFE
   3EC0 22 39 02          11242 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   3EC3 B8 3A 02          11243 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3EC6 00                11244 	.db 0x00
   3EC7 00                11245 	.db 0x00
   3EC8 00                11246 	.db 0x00
   3EC9 00                11247 	.db 0x00
   3ECA 00                11248 	.db 0x00
   3ECB 00                11249 	.db 0x00
   3ECC 00                11250 	.db 0x00
   3ECD 00                11251 	.db 0x00
   3ECE 00                11252 	.db 0x00
   3ECF 00                11253 	.db 0x00
   3ED0 00                11254 	.db 0x00
   3ED1 00                11255 	.db 0x00
   3ED2 00                11256 	.db 0x00
   3ED3 00                11257 	.db 0x00
   3ED4 00                11258 	.db 0x00
   3ED5 00                11259 	.db 0x00
   3ED6 00                11260 	.db 0x00
   3ED7 00                11261 	.db 0x00
   3ED8 00                11262 	.db 0x00
   3ED9 00                11263 	.db 0x00
   3EDA 00                11264 	.db 0x00
   3EDB 00                11265 	.db 0x00
   3EDC 00                11266 	.db 0x00
   3EDD 00                11267 	.db 0x00
   3EDE 1C 50 02          11268 	.byte _str_236,(_str_236 >> 8),#0x02
   3EE1 04                11269 	.db #0x04
   3EE2 03                11270 	.db #0x03
   3EE3 24                11271 	.db #0x24
   3EE4 EA 38 02          11272 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   3EE7 F6 3B 02          11273 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   3EEA 03                11274 	.db #0x03
   3EEB 25                11275 	.db #0x25
   3EEC F8 38 02          11276 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   3EEF FC 3B 02          11277 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   3EF2 03                11278 	.db #0x03
   3EF3 26                11279 	.db #0x26
   3EF4 06 39 02          11280 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   3EF7 02 3C 02          11281 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   3EFA 03                11282 	.db #0x03
   3EFB FE                11283 	.db #0xFE
   3EFC 22 39 02          11284 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   3EFF B8 3A 02          11285 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3F02 00                11286 	.db 0x00
   3F03 00                11287 	.db 0x00
   3F04 00                11288 	.db 0x00
   3F05 00                11289 	.db 0x00
   3F06 00                11290 	.db 0x00
   3F07 00                11291 	.db 0x00
   3F08 00                11292 	.db 0x00
   3F09 00                11293 	.db 0x00
   3F0A 00                11294 	.db 0x00
   3F0B 00                11295 	.db 0x00
   3F0C 00                11296 	.db 0x00
   3F0D 00                11297 	.db 0x00
   3F0E 00                11298 	.db 0x00
   3F0F 00                11299 	.db 0x00
   3F10 00                11300 	.db 0x00
   3F11 00                11301 	.db 0x00
   3F12 00                11302 	.db 0x00
   3F13 00                11303 	.db 0x00
   3F14 00                11304 	.db 0x00
   3F15 00                11305 	.db 0x00
   3F16 00                11306 	.db 0x00
   3F17 00                11307 	.db 0x00
   3F18 00                11308 	.db 0x00
   3F19 00                11309 	.db 0x00
   3F1A 45 50 02          11310 	.byte _str_237,(_str_237 >> 8),#0x02
   3F1D 04                11311 	.db #0x04
   3F1E 03                11312 	.db #0x03
   3F1F 27                11313 	.db #0x27
   3F20 EA 38 02          11314 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   3F23 F6 3B 02          11315 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   3F26 03                11316 	.db #0x03
   3F27 28                11317 	.db #0x28
   3F28 F8 38 02          11318 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   3F2B FC 3B 02          11319 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   3F2E 03                11320 	.db #0x03
   3F2F 29                11321 	.db #0x29
   3F30 06 39 02          11322 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   3F33 02 3C 02          11323 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   3F36 03                11324 	.db #0x03
   3F37 FE                11325 	.db #0xFE
   3F38 22 39 02          11326 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   3F3B B8 3A 02          11327 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3F3E 00                11328 	.db 0x00
   3F3F 00                11329 	.db 0x00
   3F40 00                11330 	.db 0x00
   3F41 00                11331 	.db 0x00
   3F42 00                11332 	.db 0x00
   3F43 00                11333 	.db 0x00
   3F44 00                11334 	.db 0x00
   3F45 00                11335 	.db 0x00
   3F46 00                11336 	.db 0x00
   3F47 00                11337 	.db 0x00
   3F48 00                11338 	.db 0x00
   3F49 00                11339 	.db 0x00
   3F4A 00                11340 	.db 0x00
   3F4B 00                11341 	.db 0x00
   3F4C 00                11342 	.db 0x00
   3F4D 00                11343 	.db 0x00
   3F4E 00                11344 	.db 0x00
   3F4F 00                11345 	.db 0x00
   3F50 00                11346 	.db 0x00
   3F51 00                11347 	.db 0x00
   3F52 00                11348 	.db 0x00
   3F53 00                11349 	.db 0x00
   3F54 00                11350 	.db 0x00
   3F55 00                11351 	.db 0x00
   3F56 6E 50 02          11352 	.byte _str_238,(_str_238 >> 8),#0x02
   3F59 04                11353 	.db #0x04
   3F5A 03                11354 	.db #0x03
   3F5B 2A                11355 	.db #0x2A
   3F5C EA 38 02          11356 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   3F5F F6 3B 02          11357 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   3F62 03                11358 	.db #0x03
   3F63 2B                11359 	.db #0x2B
   3F64 F8 38 02          11360 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   3F67 FC 3B 02          11361 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   3F6A 03                11362 	.db #0x03
   3F6B 2C                11363 	.db #0x2C
   3F6C 06 39 02          11364 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   3F6F 02 3C 02          11365 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   3F72 03                11366 	.db #0x03
   3F73 FE                11367 	.db #0xFE
   3F74 22 39 02          11368 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   3F77 B8 3A 02          11369 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3F7A 00                11370 	.db 0x00
   3F7B 00                11371 	.db 0x00
   3F7C 00                11372 	.db 0x00
   3F7D 00                11373 	.db 0x00
   3F7E 00                11374 	.db 0x00
   3F7F 00                11375 	.db 0x00
   3F80 00                11376 	.db 0x00
   3F81 00                11377 	.db 0x00
   3F82 00                11378 	.db 0x00
   3F83 00                11379 	.db 0x00
   3F84 00                11380 	.db 0x00
   3F85 00                11381 	.db 0x00
   3F86 00                11382 	.db 0x00
   3F87 00                11383 	.db 0x00
   3F88 00                11384 	.db 0x00
   3F89 00                11385 	.db 0x00
   3F8A 00                11386 	.db 0x00
   3F8B 00                11387 	.db 0x00
   3F8C 00                11388 	.db 0x00
   3F8D 00                11389 	.db 0x00
   3F8E 00                11390 	.db 0x00
   3F8F 00                11391 	.db 0x00
   3F90 00                11392 	.db 0x00
   3F91 00                11393 	.db 0x00
   3F92 97 50 02          11394 	.byte _str_239,(_str_239 >> 8),#0x02
   3F95 04                11395 	.db #0x04
   3F96 04                11396 	.db #0x04
   3F97 2D                11397 	.db #0x2D
   3F98 EA 38 02          11398 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   3F9B F6 3B 02          11399 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   3F9E 04                11400 	.db #0x04
   3F9F 2E                11401 	.db #0x2E
   3FA0 F8 38 02          11402 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   3FA3 FC 3B 02          11403 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   3FA6 04                11404 	.db #0x04
   3FA7 2F                11405 	.db #0x2F
   3FA8 06 39 02          11406 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   3FAB 02 3C 02          11407 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   3FAE 04                11408 	.db #0x04
   3FAF FE                11409 	.db #0xFE
   3FB0 22 39 02          11410 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   3FB3 B8 3A 02          11411 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3FB6 00                11412 	.db 0x00
   3FB7 00                11413 	.db 0x00
   3FB8 00                11414 	.db 0x00
   3FB9 00                11415 	.db 0x00
   3FBA 00                11416 	.db 0x00
   3FBB 00                11417 	.db 0x00
   3FBC 00                11418 	.db 0x00
   3FBD 00                11419 	.db 0x00
   3FBE 00                11420 	.db 0x00
   3FBF 00                11421 	.db 0x00
   3FC0 00                11422 	.db 0x00
   3FC1 00                11423 	.db 0x00
   3FC2 00                11424 	.db 0x00
   3FC3 00                11425 	.db 0x00
   3FC4 00                11426 	.db 0x00
   3FC5 00                11427 	.db 0x00
   3FC6 00                11428 	.db 0x00
   3FC7 00                11429 	.db 0x00
   3FC8 00                11430 	.db 0x00
   3FC9 00                11431 	.db 0x00
   3FCA 00                11432 	.db 0x00
   3FCB 00                11433 	.db 0x00
   3FCC 00                11434 	.db 0x00
   3FCD 00                11435 	.db 0x00
   3FCE C0 50 02          11436 	.byte _str_240,(_str_240 >> 8),#0x02
   3FD1 04                11437 	.db #0x04
   3FD2 04                11438 	.db #0x04
   3FD3 30                11439 	.db #0x30
   3FD4 EA 38 02          11440 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   3FD7 F6 3B 02          11441 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   3FDA 04                11442 	.db #0x04
   3FDB 31                11443 	.db #0x31
   3FDC F8 38 02          11444 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   3FDF FC 3B 02          11445 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   3FE2 04                11446 	.db #0x04
   3FE3 32                11447 	.db #0x32
   3FE4 06 39 02          11448 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   3FE7 02 3C 02          11449 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   3FEA 04                11450 	.db #0x04
   3FEB FE                11451 	.db #0xFE
   3FEC 22 39 02          11452 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   3FEF B8 3A 02          11453 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   3FF2 00                11454 	.db 0x00
   3FF3 00                11455 	.db 0x00
   3FF4 00                11456 	.db 0x00
   3FF5 00                11457 	.db 0x00
   3FF6 00                11458 	.db 0x00
   3FF7 00                11459 	.db 0x00
   3FF8 00                11460 	.db 0x00
   3FF9 00                11461 	.db 0x00
   3FFA 00                11462 	.db 0x00
   3FFB 00                11463 	.db 0x00
   3FFC 00                11464 	.db 0x00
   3FFD 00                11465 	.db 0x00
   3FFE 00                11466 	.db 0x00
   3FFF 00                11467 	.db 0x00
   4000 00                11468 	.db 0x00
   4001 00                11469 	.db 0x00
   4002 00                11470 	.db 0x00
   4003 00                11471 	.db 0x00
   4004 00                11472 	.db 0x00
   4005 00                11473 	.db 0x00
   4006 00                11474 	.db 0x00
   4007 00                11475 	.db 0x00
   4008 00                11476 	.db 0x00
   4009 00                11477 	.db 0x00
   400A E9 50 02          11478 	.byte _str_241,(_str_241 >> 8),#0x02
   400D 04                11479 	.db #0x04
   400E 04                11480 	.db #0x04
   400F 33                11481 	.db #0x33
   4010 EA 38 02          11482 	.byte (_bpr + 154),((_bpr + 154) >> 8),#0x02
   4013 F6 3B 02          11483 	.byte (_dpl + 318),((_dpl + 318) >> 8),#0x02
   4016 04                11484 	.db #0x04
   4017 34                11485 	.db #0x34
   4018 F8 38 02          11486 	.byte (_bpr + 168),((_bpr + 168) >> 8),#0x02
   401B FC 3B 02          11487 	.byte (_dpl + 324),((_dpl + 324) >> 8),#0x02
   401E 04                11488 	.db #0x04
   401F 35                11489 	.db #0x35
   4020 06 39 02          11490 	.byte (_bpr + 182),((_bpr + 182) >> 8),#0x02
   4023 02 3C 02          11491 	.byte (_dpl + 330),((_dpl + 330) >> 8),#0x02
   4026 04                11492 	.db #0x04
   4027 FE                11493 	.db #0xFE
   4028 22 39 02          11494 	.byte (_bpr + 210),((_bpr + 210) >> 8),#0x02
   402B B8 3A 02          11495 	.byte (_dpl + 0),((_dpl + 0) >> 8),#0x02
   402E 00                11496 	.db 0x00
   402F 00                11497 	.db 0x00
   4030 00                11498 	.db 0x00
   4031 00                11499 	.db 0x00
   4032 00                11500 	.db 0x00
   4033 00                11501 	.db 0x00
   4034 00                11502 	.db 0x00
   4035 00                11503 	.db 0x00
   4036 00                11504 	.db 0x00
   4037 00                11505 	.db 0x00
   4038 00                11506 	.db 0x00
   4039 00                11507 	.db 0x00
   403A 00                11508 	.db 0x00
   403B 00                11509 	.db 0x00
   403C 00                11510 	.db 0x00
   403D 00                11511 	.db 0x00
   403E 00                11512 	.db 0x00
   403F 00                11513 	.db 0x00
   4040 00                11514 	.db 0x00
   4041 00                11515 	.db 0x00
   4042 00                11516 	.db 0x00
   4043 00                11517 	.db 0x00
   4044 00                11518 	.db 0x00
   4045 00                11519 	.db 0x00
   4046 12 51 02          11520 	.byte _str_242,(_str_242 >> 8),#0x02
   4049 02                11521 	.db #0x02
   404A 06                11522 	.db #0x06
   404B FF                11523 	.db #0xFF
   404C 50 38 02          11524 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   404F 08 3C 02          11525 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   4052 00                11526 	.db 0x00
   4053 00                11527 	.db 0x00
   4054 00                11528 	.db 0x00
   4055 00                11529 	.db 0x00
   4056 00                11530 	.db 0x00
   4057 00                11531 	.db 0x00
   4058 00                11532 	.db 0x00
   4059 00                11533 	.db 0x00
   405A 00                11534 	.db 0x00
   405B 00                11535 	.db 0x00
   405C 00                11536 	.db 0x00
   405D 00                11537 	.db 0x00
   405E 00                11538 	.db 0x00
   405F 00                11539 	.db 0x00
   4060 00                11540 	.db 0x00
   4061 00                11541 	.db 0x00
   4062 00                11542 	.db 0x00
   4063 00                11543 	.db 0x00
   4064 00                11544 	.db 0x00
   4065 00                11545 	.db 0x00
   4066 00                11546 	.db 0x00
   4067 00                11547 	.db 0x00
   4068 00                11548 	.db 0x00
   4069 00                11549 	.db 0x00
   406A 00                11550 	.db 0x00
   406B 00                11551 	.db 0x00
   406C 00                11552 	.db 0x00
   406D 00                11553 	.db 0x00
   406E 00                11554 	.db 0x00
   406F 00                11555 	.db 0x00
   4070 00                11556 	.db 0x00
   4071 00                11557 	.db 0x00
   4072 00                11558 	.db 0x00
   4073 00                11559 	.db 0x00
   4074 00                11560 	.db 0x00
   4075 00                11561 	.db 0x00
   4076 00                11562 	.db 0x00
   4077 00                11563 	.db 0x00
   4078 00                11564 	.db 0x00
   4079 00                11565 	.db 0x00
   407A 00                11566 	.db 0x00
   407B 00                11567 	.db 0x00
   407C 00                11568 	.db 0x00
   407D 00                11569 	.db 0x00
   407E 00                11570 	.db 0x00
   407F 00                11571 	.db 0x00
   4080 00                11572 	.db 0x00
   4081 00                11573 	.db 0x00
   4082 63 51 02          11574 	.byte _str_243,(_str_243 >> 8),#0x02
   4085 02                11575 	.db #0x02
   4086 06                11576 	.db #0x06
   4087 FF                11577 	.db #0xFF
   4088 50 38 02          11578 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   408B 08 3C 02          11579 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   408E 00                11580 	.db 0x00
   408F 00                11581 	.db 0x00
   4090 00                11582 	.db 0x00
   4091 00                11583 	.db 0x00
   4092 00                11584 	.db 0x00
   4093 00                11585 	.db 0x00
   4094 00                11586 	.db 0x00
   4095 00                11587 	.db 0x00
   4096 00                11588 	.db 0x00
   4097 00                11589 	.db 0x00
   4098 00                11590 	.db 0x00
   4099 00                11591 	.db 0x00
   409A 00                11592 	.db 0x00
   409B 00                11593 	.db 0x00
   409C 00                11594 	.db 0x00
   409D 00                11595 	.db 0x00
   409E 00                11596 	.db 0x00
   409F 00                11597 	.db 0x00
   40A0 00                11598 	.db 0x00
   40A1 00                11599 	.db 0x00
   40A2 00                11600 	.db 0x00
   40A3 00                11601 	.db 0x00
   40A4 00                11602 	.db 0x00
   40A5 00                11603 	.db 0x00
   40A6 00                11604 	.db 0x00
   40A7 00                11605 	.db 0x00
   40A8 00                11606 	.db 0x00
   40A9 00                11607 	.db 0x00
   40AA 00                11608 	.db 0x00
   40AB 00                11609 	.db 0x00
   40AC 00                11610 	.db 0x00
   40AD 00                11611 	.db 0x00
   40AE 00                11612 	.db 0x00
   40AF 00                11613 	.db 0x00
   40B0 00                11614 	.db 0x00
   40B1 00                11615 	.db 0x00
   40B2 00                11616 	.db 0x00
   40B3 00                11617 	.db 0x00
   40B4 00                11618 	.db 0x00
   40B5 00                11619 	.db 0x00
   40B6 00                11620 	.db 0x00
   40B7 00                11621 	.db 0x00
   40B8 00                11622 	.db 0x00
   40B9 00                11623 	.db 0x00
   40BA 00                11624 	.db 0x00
   40BB 00                11625 	.db 0x00
   40BC 00                11626 	.db 0x00
   40BD 00                11627 	.db 0x00
   40BE B4 51 02          11628 	.byte _str_244,(_str_244 >> 8),#0x02
   40C1 02                11629 	.db #0x02
   40C2 06                11630 	.db #0x06
   40C3 FF                11631 	.db #0xFF
   40C4 50 38 02          11632 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   40C7 08 3C 02          11633 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   40CA 00                11634 	.db 0x00
   40CB 00                11635 	.db 0x00
   40CC 00                11636 	.db 0x00
   40CD 00                11637 	.db 0x00
   40CE 00                11638 	.db 0x00
   40CF 00                11639 	.db 0x00
   40D0 00                11640 	.db 0x00
   40D1 00                11641 	.db 0x00
   40D2 00                11642 	.db 0x00
   40D3 00                11643 	.db 0x00
   40D4 00                11644 	.db 0x00
   40D5 00                11645 	.db 0x00
   40D6 00                11646 	.db 0x00
   40D7 00                11647 	.db 0x00
   40D8 00                11648 	.db 0x00
   40D9 00                11649 	.db 0x00
   40DA 00                11650 	.db 0x00
   40DB 00                11651 	.db 0x00
   40DC 00                11652 	.db 0x00
   40DD 00                11653 	.db 0x00
   40DE 00                11654 	.db 0x00
   40DF 00                11655 	.db 0x00
   40E0 00                11656 	.db 0x00
   40E1 00                11657 	.db 0x00
   40E2 00                11658 	.db 0x00
   40E3 00                11659 	.db 0x00
   40E4 00                11660 	.db 0x00
   40E5 00                11661 	.db 0x00
   40E6 00                11662 	.db 0x00
   40E7 00                11663 	.db 0x00
   40E8 00                11664 	.db 0x00
   40E9 00                11665 	.db 0x00
   40EA 00                11666 	.db 0x00
   40EB 00                11667 	.db 0x00
   40EC 00                11668 	.db 0x00
   40ED 00                11669 	.db 0x00
   40EE 00                11670 	.db 0x00
   40EF 00                11671 	.db 0x00
   40F0 00                11672 	.db 0x00
   40F1 00                11673 	.db 0x00
   40F2 00                11674 	.db 0x00
   40F3 00                11675 	.db 0x00
   40F4 00                11676 	.db 0x00
   40F5 00                11677 	.db 0x00
   40F6 00                11678 	.db 0x00
   40F7 00                11679 	.db 0x00
   40F8 00                11680 	.db 0x00
   40F9 00                11681 	.db 0x00
   40FA 05 52 02          11682 	.byte _str_245,(_str_245 >> 8),#0x02
   40FD 02                11683 	.db #0x02
   40FE 07                11684 	.db #0x07
   40FF FF                11685 	.db #0xFF
   4100 50 38 02          11686 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   4103 08 3C 02          11687 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   4106 00                11688 	.db 0x00
   4107 00                11689 	.db 0x00
   4108 00                11690 	.db 0x00
   4109 00                11691 	.db 0x00
   410A 00                11692 	.db 0x00
   410B 00                11693 	.db 0x00
   410C 00                11694 	.db 0x00
   410D 00                11695 	.db 0x00
   410E 00                11696 	.db 0x00
   410F 00                11697 	.db 0x00
   4110 00                11698 	.db 0x00
   4111 00                11699 	.db 0x00
   4112 00                11700 	.db 0x00
   4113 00                11701 	.db 0x00
   4114 00                11702 	.db 0x00
   4115 00                11703 	.db 0x00
   4116 00                11704 	.db 0x00
   4117 00                11705 	.db 0x00
   4118 00                11706 	.db 0x00
   4119 00                11707 	.db 0x00
   411A 00                11708 	.db 0x00
   411B 00                11709 	.db 0x00
   411C 00                11710 	.db 0x00
   411D 00                11711 	.db 0x00
   411E 00                11712 	.db 0x00
   411F 00                11713 	.db 0x00
   4120 00                11714 	.db 0x00
   4121 00                11715 	.db 0x00
   4122 00                11716 	.db 0x00
   4123 00                11717 	.db 0x00
   4124 00                11718 	.db 0x00
   4125 00                11719 	.db 0x00
   4126 00                11720 	.db 0x00
   4127 00                11721 	.db 0x00
   4128 00                11722 	.db 0x00
   4129 00                11723 	.db 0x00
   412A 00                11724 	.db 0x00
   412B 00                11725 	.db 0x00
   412C 00                11726 	.db 0x00
   412D 00                11727 	.db 0x00
   412E 00                11728 	.db 0x00
   412F 00                11729 	.db 0x00
   4130 00                11730 	.db 0x00
   4131 00                11731 	.db 0x00
   4132 00                11732 	.db 0x00
   4133 00                11733 	.db 0x00
   4134 00                11734 	.db 0x00
   4135 00                11735 	.db 0x00
   4136 56 52 02          11736 	.byte _str_246,(_str_246 >> 8),#0x02
   4139 02                11737 	.db #0x02
   413A 07                11738 	.db #0x07
   413B FF                11739 	.db #0xFF
   413C 50 38 02          11740 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   413F 08 3C 02          11741 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   4142 00                11742 	.db 0x00
   4143 00                11743 	.db 0x00
   4144 00                11744 	.db 0x00
   4145 00                11745 	.db 0x00
   4146 00                11746 	.db 0x00
   4147 00                11747 	.db 0x00
   4148 00                11748 	.db 0x00
   4149 00                11749 	.db 0x00
   414A 00                11750 	.db 0x00
   414B 00                11751 	.db 0x00
   414C 00                11752 	.db 0x00
   414D 00                11753 	.db 0x00
   414E 00                11754 	.db 0x00
   414F 00                11755 	.db 0x00
   4150 00                11756 	.db 0x00
   4151 00                11757 	.db 0x00
   4152 00                11758 	.db 0x00
   4153 00                11759 	.db 0x00
   4154 00                11760 	.db 0x00
   4155 00                11761 	.db 0x00
   4156 00                11762 	.db 0x00
   4157 00                11763 	.db 0x00
   4158 00                11764 	.db 0x00
   4159 00                11765 	.db 0x00
   415A 00                11766 	.db 0x00
   415B 00                11767 	.db 0x00
   415C 00                11768 	.db 0x00
   415D 00                11769 	.db 0x00
   415E 00                11770 	.db 0x00
   415F 00                11771 	.db 0x00
   4160 00                11772 	.db 0x00
   4161 00                11773 	.db 0x00
   4162 00                11774 	.db 0x00
   4163 00                11775 	.db 0x00
   4164 00                11776 	.db 0x00
   4165 00                11777 	.db 0x00
   4166 00                11778 	.db 0x00
   4167 00                11779 	.db 0x00
   4168 00                11780 	.db 0x00
   4169 00                11781 	.db 0x00
   416A 00                11782 	.db 0x00
   416B 00                11783 	.db 0x00
   416C 00                11784 	.db 0x00
   416D 00                11785 	.db 0x00
   416E 00                11786 	.db 0x00
   416F 00                11787 	.db 0x00
   4170 00                11788 	.db 0x00
   4171 00                11789 	.db 0x00
   4172 A7 52 02          11790 	.byte _str_247,(_str_247 >> 8),#0x02
   4175 02                11791 	.db #0x02
   4176 07                11792 	.db #0x07
   4177 FF                11793 	.db #0xFF
   4178 50 38 02          11794 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   417B 08 3C 02          11795 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   417E 00                11796 	.db 0x00
   417F 00                11797 	.db 0x00
   4180 00                11798 	.db 0x00
   4181 00                11799 	.db 0x00
   4182 00                11800 	.db 0x00
   4183 00                11801 	.db 0x00
   4184 00                11802 	.db 0x00
   4185 00                11803 	.db 0x00
   4186 00                11804 	.db 0x00
   4187 00                11805 	.db 0x00
   4188 00                11806 	.db 0x00
   4189 00                11807 	.db 0x00
   418A 00                11808 	.db 0x00
   418B 00                11809 	.db 0x00
   418C 00                11810 	.db 0x00
   418D 00                11811 	.db 0x00
   418E 00                11812 	.db 0x00
   418F 00                11813 	.db 0x00
   4190 00                11814 	.db 0x00
   4191 00                11815 	.db 0x00
   4192 00                11816 	.db 0x00
   4193 00                11817 	.db 0x00
   4194 00                11818 	.db 0x00
   4195 00                11819 	.db 0x00
   4196 00                11820 	.db 0x00
   4197 00                11821 	.db 0x00
   4198 00                11822 	.db 0x00
   4199 00                11823 	.db 0x00
   419A 00                11824 	.db 0x00
   419B 00                11825 	.db 0x00
   419C 00                11826 	.db 0x00
   419D 00                11827 	.db 0x00
   419E 00                11828 	.db 0x00
   419F 00                11829 	.db 0x00
   41A0 00                11830 	.db 0x00
   41A1 00                11831 	.db 0x00
   41A2 00                11832 	.db 0x00
   41A3 00                11833 	.db 0x00
   41A4 00                11834 	.db 0x00
   41A5 00                11835 	.db 0x00
   41A6 00                11836 	.db 0x00
   41A7 00                11837 	.db 0x00
   41A8 00                11838 	.db 0x00
   41A9 00                11839 	.db 0x00
   41AA 00                11840 	.db 0x00
   41AB 00                11841 	.db 0x00
   41AC 00                11842 	.db 0x00
   41AD 00                11843 	.db 0x00
   41AE F8 52 02          11844 	.byte _str_248,(_str_248 >> 8),#0x02
   41B1 02                11845 	.db #0x02
   41B2 08                11846 	.db #0x08
   41B3 FF                11847 	.db #0xFF
   41B4 50 38 02          11848 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   41B7 08 3C 02          11849 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   41BA 00                11850 	.db 0x00
   41BB 00                11851 	.db 0x00
   41BC 00                11852 	.db 0x00
   41BD 00                11853 	.db 0x00
   41BE 00                11854 	.db 0x00
   41BF 00                11855 	.db 0x00
   41C0 00                11856 	.db 0x00
   41C1 00                11857 	.db 0x00
   41C2 00                11858 	.db 0x00
   41C3 00                11859 	.db 0x00
   41C4 00                11860 	.db 0x00
   41C5 00                11861 	.db 0x00
   41C6 00                11862 	.db 0x00
   41C7 00                11863 	.db 0x00
   41C8 00                11864 	.db 0x00
   41C9 00                11865 	.db 0x00
   41CA 00                11866 	.db 0x00
   41CB 00                11867 	.db 0x00
   41CC 00                11868 	.db 0x00
   41CD 00                11869 	.db 0x00
   41CE 00                11870 	.db 0x00
   41CF 00                11871 	.db 0x00
   41D0 00                11872 	.db 0x00
   41D1 00                11873 	.db 0x00
   41D2 00                11874 	.db 0x00
   41D3 00                11875 	.db 0x00
   41D4 00                11876 	.db 0x00
   41D5 00                11877 	.db 0x00
   41D6 00                11878 	.db 0x00
   41D7 00                11879 	.db 0x00
   41D8 00                11880 	.db 0x00
   41D9 00                11881 	.db 0x00
   41DA 00                11882 	.db 0x00
   41DB 00                11883 	.db 0x00
   41DC 00                11884 	.db 0x00
   41DD 00                11885 	.db 0x00
   41DE 00                11886 	.db 0x00
   41DF 00                11887 	.db 0x00
   41E0 00                11888 	.db 0x00
   41E1 00                11889 	.db 0x00
   41E2 00                11890 	.db 0x00
   41E3 00                11891 	.db 0x00
   41E4 00                11892 	.db 0x00
   41E5 00                11893 	.db 0x00
   41E6 00                11894 	.db 0x00
   41E7 00                11895 	.db 0x00
   41E8 00                11896 	.db 0x00
   41E9 00                11897 	.db 0x00
   41EA 49 53 02          11898 	.byte _str_249,(_str_249 >> 8),#0x02
   41ED 02                11899 	.db #0x02
   41EE 08                11900 	.db #0x08
   41EF FF                11901 	.db #0xFF
   41F0 50 38 02          11902 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   41F3 08 3C 02          11903 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   41F6 00                11904 	.db 0x00
   41F7 00                11905 	.db 0x00
   41F8 00                11906 	.db 0x00
   41F9 00                11907 	.db 0x00
   41FA 00                11908 	.db 0x00
   41FB 00                11909 	.db 0x00
   41FC 00                11910 	.db 0x00
   41FD 00                11911 	.db 0x00
   41FE 00                11912 	.db 0x00
   41FF 00                11913 	.db 0x00
   4200 00                11914 	.db 0x00
   4201 00                11915 	.db 0x00
   4202 00                11916 	.db 0x00
   4203 00                11917 	.db 0x00
   4204 00                11918 	.db 0x00
   4205 00                11919 	.db 0x00
   4206 00                11920 	.db 0x00
   4207 00                11921 	.db 0x00
   4208 00                11922 	.db 0x00
   4209 00                11923 	.db 0x00
   420A 00                11924 	.db 0x00
   420B 00                11925 	.db 0x00
   420C 00                11926 	.db 0x00
   420D 00                11927 	.db 0x00
   420E 00                11928 	.db 0x00
   420F 00                11929 	.db 0x00
   4210 00                11930 	.db 0x00
   4211 00                11931 	.db 0x00
   4212 00                11932 	.db 0x00
   4213 00                11933 	.db 0x00
   4214 00                11934 	.db 0x00
   4215 00                11935 	.db 0x00
   4216 00                11936 	.db 0x00
   4217 00                11937 	.db 0x00
   4218 00                11938 	.db 0x00
   4219 00                11939 	.db 0x00
   421A 00                11940 	.db 0x00
   421B 00                11941 	.db 0x00
   421C 00                11942 	.db 0x00
   421D 00                11943 	.db 0x00
   421E 00                11944 	.db 0x00
   421F 00                11945 	.db 0x00
   4220 00                11946 	.db 0x00
   4221 00                11947 	.db 0x00
   4222 00                11948 	.db 0x00
   4223 00                11949 	.db 0x00
   4224 00                11950 	.db 0x00
   4225 00                11951 	.db 0x00
   4226 9A 53 02          11952 	.byte _str_250,(_str_250 >> 8),#0x02
   4229 02                11953 	.db #0x02
   422A 08                11954 	.db #0x08
   422B FF                11955 	.db #0xFF
   422C 50 38 02          11956 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   422F 08 3C 02          11957 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   4232 00                11958 	.db 0x00
   4233 00                11959 	.db 0x00
   4234 00                11960 	.db 0x00
   4235 00                11961 	.db 0x00
   4236 00                11962 	.db 0x00
   4237 00                11963 	.db 0x00
   4238 00                11964 	.db 0x00
   4239 00                11965 	.db 0x00
   423A 00                11966 	.db 0x00
   423B 00                11967 	.db 0x00
   423C 00                11968 	.db 0x00
   423D 00                11969 	.db 0x00
   423E 00                11970 	.db 0x00
   423F 00                11971 	.db 0x00
   4240 00                11972 	.db 0x00
   4241 00                11973 	.db 0x00
   4242 00                11974 	.db 0x00
   4243 00                11975 	.db 0x00
   4244 00                11976 	.db 0x00
   4245 00                11977 	.db 0x00
   4246 00                11978 	.db 0x00
   4247 00                11979 	.db 0x00
   4248 00                11980 	.db 0x00
   4249 00                11981 	.db 0x00
   424A 00                11982 	.db 0x00
   424B 00                11983 	.db 0x00
   424C 00                11984 	.db 0x00
   424D 00                11985 	.db 0x00
   424E 00                11986 	.db 0x00
   424F 00                11987 	.db 0x00
   4250 00                11988 	.db 0x00
   4251 00                11989 	.db 0x00
   4252 00                11990 	.db 0x00
   4253 00                11991 	.db 0x00
   4254 00                11992 	.db 0x00
   4255 00                11993 	.db 0x00
   4256 00                11994 	.db 0x00
   4257 00                11995 	.db 0x00
   4258 00                11996 	.db 0x00
   4259 00                11997 	.db 0x00
   425A 00                11998 	.db 0x00
   425B 00                11999 	.db 0x00
   425C 00                12000 	.db 0x00
   425D 00                12001 	.db 0x00
   425E 00                12002 	.db 0x00
   425F 00                12003 	.db 0x00
   4260 00                12004 	.db 0x00
   4261 00                12005 	.db 0x00
   4262 EB 53 02          12006 	.byte _str_251,(_str_251 >> 8),#0x02
   4265 02                12007 	.db #0x02
   4266 09                12008 	.db #0x09
   4267 FF                12009 	.db #0xFF
   4268 50 38 02          12010 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   426B 08 3C 02          12011 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   426E 00                12012 	.db 0x00
   426F 00                12013 	.db 0x00
   4270 00                12014 	.db 0x00
   4271 00                12015 	.db 0x00
   4272 00                12016 	.db 0x00
   4273 00                12017 	.db 0x00
   4274 00                12018 	.db 0x00
   4275 00                12019 	.db 0x00
   4276 00                12020 	.db 0x00
   4277 00                12021 	.db 0x00
   4278 00                12022 	.db 0x00
   4279 00                12023 	.db 0x00
   427A 00                12024 	.db 0x00
   427B 00                12025 	.db 0x00
   427C 00                12026 	.db 0x00
   427D 00                12027 	.db 0x00
   427E 00                12028 	.db 0x00
   427F 00                12029 	.db 0x00
   4280 00                12030 	.db 0x00
   4281 00                12031 	.db 0x00
   4282 00                12032 	.db 0x00
   4283 00                12033 	.db 0x00
   4284 00                12034 	.db 0x00
   4285 00                12035 	.db 0x00
   4286 00                12036 	.db 0x00
   4287 00                12037 	.db 0x00
   4288 00                12038 	.db 0x00
   4289 00                12039 	.db 0x00
   428A 00                12040 	.db 0x00
   428B 00                12041 	.db 0x00
   428C 00                12042 	.db 0x00
   428D 00                12043 	.db 0x00
   428E 00                12044 	.db 0x00
   428F 00                12045 	.db 0x00
   4290 00                12046 	.db 0x00
   4291 00                12047 	.db 0x00
   4292 00                12048 	.db 0x00
   4293 00                12049 	.db 0x00
   4294 00                12050 	.db 0x00
   4295 00                12051 	.db 0x00
   4296 00                12052 	.db 0x00
   4297 00                12053 	.db 0x00
   4298 00                12054 	.db 0x00
   4299 00                12055 	.db 0x00
   429A 00                12056 	.db 0x00
   429B 00                12057 	.db 0x00
   429C 00                12058 	.db 0x00
   429D 00                12059 	.db 0x00
   429E 3C 54 02          12060 	.byte _str_252,(_str_252 >> 8),#0x02
   42A1 02                12061 	.db #0x02
   42A2 09                12062 	.db #0x09
   42A3 FF                12063 	.db #0xFF
   42A4 50 38 02          12064 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   42A7 08 3C 02          12065 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   42AA 00                12066 	.db 0x00
   42AB 00                12067 	.db 0x00
   42AC 00                12068 	.db 0x00
   42AD 00                12069 	.db 0x00
   42AE 00                12070 	.db 0x00
   42AF 00                12071 	.db 0x00
   42B0 00                12072 	.db 0x00
   42B1 00                12073 	.db 0x00
   42B2 00                12074 	.db 0x00
   42B3 00                12075 	.db 0x00
   42B4 00                12076 	.db 0x00
   42B5 00                12077 	.db 0x00
   42B6 00                12078 	.db 0x00
   42B7 00                12079 	.db 0x00
   42B8 00                12080 	.db 0x00
   42B9 00                12081 	.db 0x00
   42BA 00                12082 	.db 0x00
   42BB 00                12083 	.db 0x00
   42BC 00                12084 	.db 0x00
   42BD 00                12085 	.db 0x00
   42BE 00                12086 	.db 0x00
   42BF 00                12087 	.db 0x00
   42C0 00                12088 	.db 0x00
   42C1 00                12089 	.db 0x00
   42C2 00                12090 	.db 0x00
   42C3 00                12091 	.db 0x00
   42C4 00                12092 	.db 0x00
   42C5 00                12093 	.db 0x00
   42C6 00                12094 	.db 0x00
   42C7 00                12095 	.db 0x00
   42C8 00                12096 	.db 0x00
   42C9 00                12097 	.db 0x00
   42CA 00                12098 	.db 0x00
   42CB 00                12099 	.db 0x00
   42CC 00                12100 	.db 0x00
   42CD 00                12101 	.db 0x00
   42CE 00                12102 	.db 0x00
   42CF 00                12103 	.db 0x00
   42D0 00                12104 	.db 0x00
   42D1 00                12105 	.db 0x00
   42D2 00                12106 	.db 0x00
   42D3 00                12107 	.db 0x00
   42D4 00                12108 	.db 0x00
   42D5 00                12109 	.db 0x00
   42D6 00                12110 	.db 0x00
   42D7 00                12111 	.db 0x00
   42D8 00                12112 	.db 0x00
   42D9 00                12113 	.db 0x00
   42DA 8D 54 02          12114 	.byte _str_253,(_str_253 >> 8),#0x02
   42DD 02                12115 	.db #0x02
   42DE 09                12116 	.db #0x09
   42DF FF                12117 	.db #0xFF
   42E0 50 38 02          12118 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   42E3 08 3C 02          12119 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   42E6 00                12120 	.db 0x00
   42E7 00                12121 	.db 0x00
   42E8 00                12122 	.db 0x00
   42E9 00                12123 	.db 0x00
   42EA 00                12124 	.db 0x00
   42EB 00                12125 	.db 0x00
   42EC 00                12126 	.db 0x00
   42ED 00                12127 	.db 0x00
   42EE 00                12128 	.db 0x00
   42EF 00                12129 	.db 0x00
   42F0 00                12130 	.db 0x00
   42F1 00                12131 	.db 0x00
   42F2 00                12132 	.db 0x00
   42F3 00                12133 	.db 0x00
   42F4 00                12134 	.db 0x00
   42F5 00                12135 	.db 0x00
   42F6 00                12136 	.db 0x00
   42F7 00                12137 	.db 0x00
   42F8 00                12138 	.db 0x00
   42F9 00                12139 	.db 0x00
   42FA 00                12140 	.db 0x00
   42FB 00                12141 	.db 0x00
   42FC 00                12142 	.db 0x00
   42FD 00                12143 	.db 0x00
   42FE 00                12144 	.db 0x00
   42FF 00                12145 	.db 0x00
   4300 00                12146 	.db 0x00
   4301 00                12147 	.db 0x00
   4302 00                12148 	.db 0x00
   4303 00                12149 	.db 0x00
   4304 00                12150 	.db 0x00
   4305 00                12151 	.db 0x00
   4306 00                12152 	.db 0x00
   4307 00                12153 	.db 0x00
   4308 00                12154 	.db 0x00
   4309 00                12155 	.db 0x00
   430A 00                12156 	.db 0x00
   430B 00                12157 	.db 0x00
   430C 00                12158 	.db 0x00
   430D 00                12159 	.db 0x00
   430E 00                12160 	.db 0x00
   430F 00                12161 	.db 0x00
   4310 00                12162 	.db 0x00
   4311 00                12163 	.db 0x00
   4312 00                12164 	.db 0x00
   4313 00                12165 	.db 0x00
   4314 00                12166 	.db 0x00
   4315 00                12167 	.db 0x00
   4316 DE 54 02          12168 	.byte _str_254,(_str_254 >> 8),#0x02
   4319 02                12169 	.db #0x02
   431A 0A                12170 	.db #0x0A
   431B FF                12171 	.db #0xFF
   431C 50 38 02          12172 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   431F 08 3C 02          12173 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   4322 00                12174 	.db 0x00
   4323 00                12175 	.db 0x00
   4324 00                12176 	.db 0x00
   4325 00                12177 	.db 0x00
   4326 00                12178 	.db 0x00
   4327 00                12179 	.db 0x00
   4328 00                12180 	.db 0x00
   4329 00                12181 	.db 0x00
   432A 00                12182 	.db 0x00
   432B 00                12183 	.db 0x00
   432C 00                12184 	.db 0x00
   432D 00                12185 	.db 0x00
   432E 00                12186 	.db 0x00
   432F 00                12187 	.db 0x00
   4330 00                12188 	.db 0x00
   4331 00                12189 	.db 0x00
   4332 00                12190 	.db 0x00
   4333 00                12191 	.db 0x00
   4334 00                12192 	.db 0x00
   4335 00                12193 	.db 0x00
   4336 00                12194 	.db 0x00
   4337 00                12195 	.db 0x00
   4338 00                12196 	.db 0x00
   4339 00                12197 	.db 0x00
   433A 00                12198 	.db 0x00
   433B 00                12199 	.db 0x00
   433C 00                12200 	.db 0x00
   433D 00                12201 	.db 0x00
   433E 00                12202 	.db 0x00
   433F 00                12203 	.db 0x00
   4340 00                12204 	.db 0x00
   4341 00                12205 	.db 0x00
   4342 00                12206 	.db 0x00
   4343 00                12207 	.db 0x00
   4344 00                12208 	.db 0x00
   4345 00                12209 	.db 0x00
   4346 00                12210 	.db 0x00
   4347 00                12211 	.db 0x00
   4348 00                12212 	.db 0x00
   4349 00                12213 	.db 0x00
   434A 00                12214 	.db 0x00
   434B 00                12215 	.db 0x00
   434C 00                12216 	.db 0x00
   434D 00                12217 	.db 0x00
   434E 00                12218 	.db 0x00
   434F 00                12219 	.db 0x00
   4350 00                12220 	.db 0x00
   4351 00                12221 	.db 0x00
   4352 2F 55 02          12222 	.byte _str_255,(_str_255 >> 8),#0x02
   4355 02                12223 	.db #0x02
   4356 0A                12224 	.db #0x0A
   4357 FF                12225 	.db #0xFF
   4358 50 38 02          12226 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   435B 08 3C 02          12227 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   435E 00                12228 	.db 0x00
   435F 00                12229 	.db 0x00
   4360 00                12230 	.db 0x00
   4361 00                12231 	.db 0x00
   4362 00                12232 	.db 0x00
   4363 00                12233 	.db 0x00
   4364 00                12234 	.db 0x00
   4365 00                12235 	.db 0x00
   4366 00                12236 	.db 0x00
   4367 00                12237 	.db 0x00
   4368 00                12238 	.db 0x00
   4369 00                12239 	.db 0x00
   436A 00                12240 	.db 0x00
   436B 00                12241 	.db 0x00
   436C 00                12242 	.db 0x00
   436D 00                12243 	.db 0x00
   436E 00                12244 	.db 0x00
   436F 00                12245 	.db 0x00
   4370 00                12246 	.db 0x00
   4371 00                12247 	.db 0x00
   4372 00                12248 	.db 0x00
   4373 00                12249 	.db 0x00
   4374 00                12250 	.db 0x00
   4375 00                12251 	.db 0x00
   4376 00                12252 	.db 0x00
   4377 00                12253 	.db 0x00
   4378 00                12254 	.db 0x00
   4379 00                12255 	.db 0x00
   437A 00                12256 	.db 0x00
   437B 00                12257 	.db 0x00
   437C 00                12258 	.db 0x00
   437D 00                12259 	.db 0x00
   437E 00                12260 	.db 0x00
   437F 00                12261 	.db 0x00
   4380 00                12262 	.db 0x00
   4381 00                12263 	.db 0x00
   4382 00                12264 	.db 0x00
   4383 00                12265 	.db 0x00
   4384 00                12266 	.db 0x00
   4385 00                12267 	.db 0x00
   4386 00                12268 	.db 0x00
   4387 00                12269 	.db 0x00
   4388 00                12270 	.db 0x00
   4389 00                12271 	.db 0x00
   438A 00                12272 	.db 0x00
   438B 00                12273 	.db 0x00
   438C 00                12274 	.db 0x00
   438D 00                12275 	.db 0x00
   438E 80 55 02          12276 	.byte _str_256,(_str_256 >> 8),#0x02
   4391 02                12277 	.db #0x02
   4392 0A                12278 	.db #0x0A
   4393 FF                12279 	.db #0xFF
   4394 50 38 02          12280 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   4397 08 3C 02          12281 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   439A 00                12282 	.db 0x00
   439B 00                12283 	.db 0x00
   439C 00                12284 	.db 0x00
   439D 00                12285 	.db 0x00
   439E 00                12286 	.db 0x00
   439F 00                12287 	.db 0x00
   43A0 00                12288 	.db 0x00
   43A1 00                12289 	.db 0x00
   43A2 00                12290 	.db 0x00
   43A3 00                12291 	.db 0x00
   43A4 00                12292 	.db 0x00
   43A5 00                12293 	.db 0x00
   43A6 00                12294 	.db 0x00
   43A7 00                12295 	.db 0x00
   43A8 00                12296 	.db 0x00
   43A9 00                12297 	.db 0x00
   43AA 00                12298 	.db 0x00
   43AB 00                12299 	.db 0x00
   43AC 00                12300 	.db 0x00
   43AD 00                12301 	.db 0x00
   43AE 00                12302 	.db 0x00
   43AF 00                12303 	.db 0x00
   43B0 00                12304 	.db 0x00
   43B1 00                12305 	.db 0x00
   43B2 00                12306 	.db 0x00
   43B3 00                12307 	.db 0x00
   43B4 00                12308 	.db 0x00
   43B5 00                12309 	.db 0x00
   43B6 00                12310 	.db 0x00
   43B7 00                12311 	.db 0x00
   43B8 00                12312 	.db 0x00
   43B9 00                12313 	.db 0x00
   43BA 00                12314 	.db 0x00
   43BB 00                12315 	.db 0x00
   43BC 00                12316 	.db 0x00
   43BD 00                12317 	.db 0x00
   43BE 00                12318 	.db 0x00
   43BF 00                12319 	.db 0x00
   43C0 00                12320 	.db 0x00
   43C1 00                12321 	.db 0x00
   43C2 00                12322 	.db 0x00
   43C3 00                12323 	.db 0x00
   43C4 00                12324 	.db 0x00
   43C5 00                12325 	.db 0x00
   43C6 00                12326 	.db 0x00
   43C7 00                12327 	.db 0x00
   43C8 00                12328 	.db 0x00
   43C9 00                12329 	.db 0x00
   43CA D1 55 02          12330 	.byte _str_257,(_str_257 >> 8),#0x02
   43CD 02                12331 	.db #0x02
   43CE 0B                12332 	.db #0x0B
   43CF FF                12333 	.db #0xFF
   43D0 50 38 02          12334 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   43D3 08 3C 02          12335 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   43D6 00                12336 	.db 0x00
   43D7 00                12337 	.db 0x00
   43D8 00                12338 	.db 0x00
   43D9 00                12339 	.db 0x00
   43DA 00                12340 	.db 0x00
   43DB 00                12341 	.db 0x00
   43DC 00                12342 	.db 0x00
   43DD 00                12343 	.db 0x00
   43DE 00                12344 	.db 0x00
   43DF 00                12345 	.db 0x00
   43E0 00                12346 	.db 0x00
   43E1 00                12347 	.db 0x00
   43E2 00                12348 	.db 0x00
   43E3 00                12349 	.db 0x00
   43E4 00                12350 	.db 0x00
   43E5 00                12351 	.db 0x00
   43E6 00                12352 	.db 0x00
   43E7 00                12353 	.db 0x00
   43E8 00                12354 	.db 0x00
   43E9 00                12355 	.db 0x00
   43EA 00                12356 	.db 0x00
   43EB 00                12357 	.db 0x00
   43EC 00                12358 	.db 0x00
   43ED 00                12359 	.db 0x00
   43EE 00                12360 	.db 0x00
   43EF 00                12361 	.db 0x00
   43F0 00                12362 	.db 0x00
   43F1 00                12363 	.db 0x00
   43F2 00                12364 	.db 0x00
   43F3 00                12365 	.db 0x00
   43F4 00                12366 	.db 0x00
   43F5 00                12367 	.db 0x00
   43F6 00                12368 	.db 0x00
   43F7 00                12369 	.db 0x00
   43F8 00                12370 	.db 0x00
   43F9 00                12371 	.db 0x00
   43FA 00                12372 	.db 0x00
   43FB 00                12373 	.db 0x00
   43FC 00                12374 	.db 0x00
   43FD 00                12375 	.db 0x00
   43FE 00                12376 	.db 0x00
   43FF 00                12377 	.db 0x00
   4400 00                12378 	.db 0x00
   4401 00                12379 	.db 0x00
   4402 00                12380 	.db 0x00
   4403 00                12381 	.db 0x00
   4404 00                12382 	.db 0x00
   4405 00                12383 	.db 0x00
   4406 22 56 02          12384 	.byte _str_258,(_str_258 >> 8),#0x02
   4409 02                12385 	.db #0x02
   440A 0B                12386 	.db #0x0B
   440B FF                12387 	.db #0xFF
   440C 50 38 02          12388 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   440F 08 3C 02          12389 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   4412 00                12390 	.db 0x00
   4413 00                12391 	.db 0x00
   4414 00                12392 	.db 0x00
   4415 00                12393 	.db 0x00
   4416 00                12394 	.db 0x00
   4417 00                12395 	.db 0x00
   4418 00                12396 	.db 0x00
   4419 00                12397 	.db 0x00
   441A 00                12398 	.db 0x00
   441B 00                12399 	.db 0x00
   441C 00                12400 	.db 0x00
   441D 00                12401 	.db 0x00
   441E 00                12402 	.db 0x00
   441F 00                12403 	.db 0x00
   4420 00                12404 	.db 0x00
   4421 00                12405 	.db 0x00
   4422 00                12406 	.db 0x00
   4423 00                12407 	.db 0x00
   4424 00                12408 	.db 0x00
   4425 00                12409 	.db 0x00
   4426 00                12410 	.db 0x00
   4427 00                12411 	.db 0x00
   4428 00                12412 	.db 0x00
   4429 00                12413 	.db 0x00
   442A 00                12414 	.db 0x00
   442B 00                12415 	.db 0x00
   442C 00                12416 	.db 0x00
   442D 00                12417 	.db 0x00
   442E 00                12418 	.db 0x00
   442F 00                12419 	.db 0x00
   4430 00                12420 	.db 0x00
   4431 00                12421 	.db 0x00
   4432 00                12422 	.db 0x00
   4433 00                12423 	.db 0x00
   4434 00                12424 	.db 0x00
   4435 00                12425 	.db 0x00
   4436 00                12426 	.db 0x00
   4437 00                12427 	.db 0x00
   4438 00                12428 	.db 0x00
   4439 00                12429 	.db 0x00
   443A 00                12430 	.db 0x00
   443B 00                12431 	.db 0x00
   443C 00                12432 	.db 0x00
   443D 00                12433 	.db 0x00
   443E 00                12434 	.db 0x00
   443F 00                12435 	.db 0x00
   4440 00                12436 	.db 0x00
   4441 00                12437 	.db 0x00
   4442 73 56 02          12438 	.byte _str_259,(_str_259 >> 8),#0x02
   4445 02                12439 	.db #0x02
   4446 0B                12440 	.db #0x0B
   4447 FF                12441 	.db #0xFF
   4448 50 38 02          12442 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   444B 08 3C 02          12443 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   444E 00                12444 	.db 0x00
   444F 00                12445 	.db 0x00
   4450 00                12446 	.db 0x00
   4451 00                12447 	.db 0x00
   4452 00                12448 	.db 0x00
   4453 00                12449 	.db 0x00
   4454 00                12450 	.db 0x00
   4455 00                12451 	.db 0x00
   4456 00                12452 	.db 0x00
   4457 00                12453 	.db 0x00
   4458 00                12454 	.db 0x00
   4459 00                12455 	.db 0x00
   445A 00                12456 	.db 0x00
   445B 00                12457 	.db 0x00
   445C 00                12458 	.db 0x00
   445D 00                12459 	.db 0x00
   445E 00                12460 	.db 0x00
   445F 00                12461 	.db 0x00
   4460 00                12462 	.db 0x00
   4461 00                12463 	.db 0x00
   4462 00                12464 	.db 0x00
   4463 00                12465 	.db 0x00
   4464 00                12466 	.db 0x00
   4465 00                12467 	.db 0x00
   4466 00                12468 	.db 0x00
   4467 00                12469 	.db 0x00
   4468 00                12470 	.db 0x00
   4469 00                12471 	.db 0x00
   446A 00                12472 	.db 0x00
   446B 00                12473 	.db 0x00
   446C 00                12474 	.db 0x00
   446D 00                12475 	.db 0x00
   446E 00                12476 	.db 0x00
   446F 00                12477 	.db 0x00
   4470 00                12478 	.db 0x00
   4471 00                12479 	.db 0x00
   4472 00                12480 	.db 0x00
   4473 00                12481 	.db 0x00
   4474 00                12482 	.db 0x00
   4475 00                12483 	.db 0x00
   4476 00                12484 	.db 0x00
   4477 00                12485 	.db 0x00
   4478 00                12486 	.db 0x00
   4479 00                12487 	.db 0x00
   447A 00                12488 	.db 0x00
   447B 00                12489 	.db 0x00
   447C 00                12490 	.db 0x00
   447D 00                12491 	.db 0x00
   447E C4 56 02          12492 	.byte _str_260,(_str_260 >> 8),#0x02
   4481 02                12493 	.db #0x02
   4482 0C                12494 	.db #0x0C
   4483 FF                12495 	.db #0xFF
   4484 50 38 02          12496 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   4487 08 3C 02          12497 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   448A 00                12498 	.db 0x00
   448B 00                12499 	.db 0x00
   448C 00                12500 	.db 0x00
   448D 00                12501 	.db 0x00
   448E 00                12502 	.db 0x00
   448F 00                12503 	.db 0x00
   4490 00                12504 	.db 0x00
   4491 00                12505 	.db 0x00
   4492 00                12506 	.db 0x00
   4493 00                12507 	.db 0x00
   4494 00                12508 	.db 0x00
   4495 00                12509 	.db 0x00
   4496 00                12510 	.db 0x00
   4497 00                12511 	.db 0x00
   4498 00                12512 	.db 0x00
   4499 00                12513 	.db 0x00
   449A 00                12514 	.db 0x00
   449B 00                12515 	.db 0x00
   449C 00                12516 	.db 0x00
   449D 00                12517 	.db 0x00
   449E 00                12518 	.db 0x00
   449F 00                12519 	.db 0x00
   44A0 00                12520 	.db 0x00
   44A1 00                12521 	.db 0x00
   44A2 00                12522 	.db 0x00
   44A3 00                12523 	.db 0x00
   44A4 00                12524 	.db 0x00
   44A5 00                12525 	.db 0x00
   44A6 00                12526 	.db 0x00
   44A7 00                12527 	.db 0x00
   44A8 00                12528 	.db 0x00
   44A9 00                12529 	.db 0x00
   44AA 00                12530 	.db 0x00
   44AB 00                12531 	.db 0x00
   44AC 00                12532 	.db 0x00
   44AD 00                12533 	.db 0x00
   44AE 00                12534 	.db 0x00
   44AF 00                12535 	.db 0x00
   44B0 00                12536 	.db 0x00
   44B1 00                12537 	.db 0x00
   44B2 00                12538 	.db 0x00
   44B3 00                12539 	.db 0x00
   44B4 00                12540 	.db 0x00
   44B5 00                12541 	.db 0x00
   44B6 00                12542 	.db 0x00
   44B7 00                12543 	.db 0x00
   44B8 00                12544 	.db 0x00
   44B9 00                12545 	.db 0x00
   44BA 15 57 02          12546 	.byte _str_261,(_str_261 >> 8),#0x02
   44BD 02                12547 	.db #0x02
   44BE 0C                12548 	.db #0x0C
   44BF FF                12549 	.db #0xFF
   44C0 50 38 02          12550 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   44C3 08 3C 02          12551 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   44C6 00                12552 	.db 0x00
   44C7 00                12553 	.db 0x00
   44C8 00                12554 	.db 0x00
   44C9 00                12555 	.db 0x00
   44CA 00                12556 	.db 0x00
   44CB 00                12557 	.db 0x00
   44CC 00                12558 	.db 0x00
   44CD 00                12559 	.db 0x00
   44CE 00                12560 	.db 0x00
   44CF 00                12561 	.db 0x00
   44D0 00                12562 	.db 0x00
   44D1 00                12563 	.db 0x00
   44D2 00                12564 	.db 0x00
   44D3 00                12565 	.db 0x00
   44D4 00                12566 	.db 0x00
   44D5 00                12567 	.db 0x00
   44D6 00                12568 	.db 0x00
   44D7 00                12569 	.db 0x00
   44D8 00                12570 	.db 0x00
   44D9 00                12571 	.db 0x00
   44DA 00                12572 	.db 0x00
   44DB 00                12573 	.db 0x00
   44DC 00                12574 	.db 0x00
   44DD 00                12575 	.db 0x00
   44DE 00                12576 	.db 0x00
   44DF 00                12577 	.db 0x00
   44E0 00                12578 	.db 0x00
   44E1 00                12579 	.db 0x00
   44E2 00                12580 	.db 0x00
   44E3 00                12581 	.db 0x00
   44E4 00                12582 	.db 0x00
   44E5 00                12583 	.db 0x00
   44E6 00                12584 	.db 0x00
   44E7 00                12585 	.db 0x00
   44E8 00                12586 	.db 0x00
   44E9 00                12587 	.db 0x00
   44EA 00                12588 	.db 0x00
   44EB 00                12589 	.db 0x00
   44EC 00                12590 	.db 0x00
   44ED 00                12591 	.db 0x00
   44EE 00                12592 	.db 0x00
   44EF 00                12593 	.db 0x00
   44F0 00                12594 	.db 0x00
   44F1 00                12595 	.db 0x00
   44F2 00                12596 	.db 0x00
   44F3 00                12597 	.db 0x00
   44F4 00                12598 	.db 0x00
   44F5 00                12599 	.db 0x00
   44F6 66 57 02          12600 	.byte _str_262,(_str_262 >> 8),#0x02
   44F9 02                12601 	.db #0x02
   44FA 0C                12602 	.db #0x0C
   44FB FF                12603 	.db #0xFF
   44FC 50 38 02          12604 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   44FF 08 3C 02          12605 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   4502 00                12606 	.db 0x00
   4503 00                12607 	.db 0x00
   4504 00                12608 	.db 0x00
   4505 00                12609 	.db 0x00
   4506 00                12610 	.db 0x00
   4507 00                12611 	.db 0x00
   4508 00                12612 	.db 0x00
   4509 00                12613 	.db 0x00
   450A 00                12614 	.db 0x00
   450B 00                12615 	.db 0x00
   450C 00                12616 	.db 0x00
   450D 00                12617 	.db 0x00
   450E 00                12618 	.db 0x00
   450F 00                12619 	.db 0x00
   4510 00                12620 	.db 0x00
   4511 00                12621 	.db 0x00
   4512 00                12622 	.db 0x00
   4513 00                12623 	.db 0x00
   4514 00                12624 	.db 0x00
   4515 00                12625 	.db 0x00
   4516 00                12626 	.db 0x00
   4517 00                12627 	.db 0x00
   4518 00                12628 	.db 0x00
   4519 00                12629 	.db 0x00
   451A 00                12630 	.db 0x00
   451B 00                12631 	.db 0x00
   451C 00                12632 	.db 0x00
   451D 00                12633 	.db 0x00
   451E 00                12634 	.db 0x00
   451F 00                12635 	.db 0x00
   4520 00                12636 	.db 0x00
   4521 00                12637 	.db 0x00
   4522 00                12638 	.db 0x00
   4523 00                12639 	.db 0x00
   4524 00                12640 	.db 0x00
   4525 00                12641 	.db 0x00
   4526 00                12642 	.db 0x00
   4527 00                12643 	.db 0x00
   4528 00                12644 	.db 0x00
   4529 00                12645 	.db 0x00
   452A 00                12646 	.db 0x00
   452B 00                12647 	.db 0x00
   452C 00                12648 	.db 0x00
   452D 00                12649 	.db 0x00
   452E 00                12650 	.db 0x00
   452F 00                12651 	.db 0x00
   4530 00                12652 	.db 0x00
   4531 00                12653 	.db 0x00
   4532 B7 57 02          12654 	.byte _str_263,(_str_263 >> 8),#0x02
   4535 02                12655 	.db #0x02
   4536 0D                12656 	.db #0x0D
   4537 FF                12657 	.db #0xFF
   4538 50 38 02          12658 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   453B 08 3C 02          12659 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   453E 00                12660 	.db 0x00
   453F 00                12661 	.db 0x00
   4540 00                12662 	.db 0x00
   4541 00                12663 	.db 0x00
   4542 00                12664 	.db 0x00
   4543 00                12665 	.db 0x00
   4544 00                12666 	.db 0x00
   4545 00                12667 	.db 0x00
   4546 00                12668 	.db 0x00
   4547 00                12669 	.db 0x00
   4548 00                12670 	.db 0x00
   4549 00                12671 	.db 0x00
   454A 00                12672 	.db 0x00
   454B 00                12673 	.db 0x00
   454C 00                12674 	.db 0x00
   454D 00                12675 	.db 0x00
   454E 00                12676 	.db 0x00
   454F 00                12677 	.db 0x00
   4550 00                12678 	.db 0x00
   4551 00                12679 	.db 0x00
   4552 00                12680 	.db 0x00
   4553 00                12681 	.db 0x00
   4554 00                12682 	.db 0x00
   4555 00                12683 	.db 0x00
   4556 00                12684 	.db 0x00
   4557 00                12685 	.db 0x00
   4558 00                12686 	.db 0x00
   4559 00                12687 	.db 0x00
   455A 00                12688 	.db 0x00
   455B 00                12689 	.db 0x00
   455C 00                12690 	.db 0x00
   455D 00                12691 	.db 0x00
   455E 00                12692 	.db 0x00
   455F 00                12693 	.db 0x00
   4560 00                12694 	.db 0x00
   4561 00                12695 	.db 0x00
   4562 00                12696 	.db 0x00
   4563 00                12697 	.db 0x00
   4564 00                12698 	.db 0x00
   4565 00                12699 	.db 0x00
   4566 00                12700 	.db 0x00
   4567 00                12701 	.db 0x00
   4568 00                12702 	.db 0x00
   4569 00                12703 	.db 0x00
   456A 00                12704 	.db 0x00
   456B 00                12705 	.db 0x00
   456C 00                12706 	.db 0x00
   456D 00                12707 	.db 0x00
   456E 08 58 02          12708 	.byte _str_264,(_str_264 >> 8),#0x02
   4571 02                12709 	.db #0x02
   4572 0D                12710 	.db #0x0D
   4573 FF                12711 	.db #0xFF
   4574 50 38 02          12712 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   4577 08 3C 02          12713 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   457A 00                12714 	.db 0x00
   457B 00                12715 	.db 0x00
   457C 00                12716 	.db 0x00
   457D 00                12717 	.db 0x00
   457E 00                12718 	.db 0x00
   457F 00                12719 	.db 0x00
   4580 00                12720 	.db 0x00
   4581 00                12721 	.db 0x00
   4582 00                12722 	.db 0x00
   4583 00                12723 	.db 0x00
   4584 00                12724 	.db 0x00
   4585 00                12725 	.db 0x00
   4586 00                12726 	.db 0x00
   4587 00                12727 	.db 0x00
   4588 00                12728 	.db 0x00
   4589 00                12729 	.db 0x00
   458A 00                12730 	.db 0x00
   458B 00                12731 	.db 0x00
   458C 00                12732 	.db 0x00
   458D 00                12733 	.db 0x00
   458E 00                12734 	.db 0x00
   458F 00                12735 	.db 0x00
   4590 00                12736 	.db 0x00
   4591 00                12737 	.db 0x00
   4592 00                12738 	.db 0x00
   4593 00                12739 	.db 0x00
   4594 00                12740 	.db 0x00
   4595 00                12741 	.db 0x00
   4596 00                12742 	.db 0x00
   4597 00                12743 	.db 0x00
   4598 00                12744 	.db 0x00
   4599 00                12745 	.db 0x00
   459A 00                12746 	.db 0x00
   459B 00                12747 	.db 0x00
   459C 00                12748 	.db 0x00
   459D 00                12749 	.db 0x00
   459E 00                12750 	.db 0x00
   459F 00                12751 	.db 0x00
   45A0 00                12752 	.db 0x00
   45A1 00                12753 	.db 0x00
   45A2 00                12754 	.db 0x00
   45A3 00                12755 	.db 0x00
   45A4 00                12756 	.db 0x00
   45A5 00                12757 	.db 0x00
   45A6 00                12758 	.db 0x00
   45A7 00                12759 	.db 0x00
   45A8 00                12760 	.db 0x00
   45A9 00                12761 	.db 0x00
   45AA 59 58 02          12762 	.byte _str_265,(_str_265 >> 8),#0x02
   45AD 02                12763 	.db #0x02
   45AE 0D                12764 	.db #0x0D
   45AF FF                12765 	.db #0xFF
   45B0 50 38 02          12766 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   45B3 08 3C 02          12767 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   45B6 00                12768 	.db 0x00
   45B7 00                12769 	.db 0x00
   45B8 00                12770 	.db 0x00
   45B9 00                12771 	.db 0x00
   45BA 00                12772 	.db 0x00
   45BB 00                12773 	.db 0x00
   45BC 00                12774 	.db 0x00
   45BD 00                12775 	.db 0x00
   45BE 00                12776 	.db 0x00
   45BF 00                12777 	.db 0x00
   45C0 00                12778 	.db 0x00
   45C1 00                12779 	.db 0x00
   45C2 00                12780 	.db 0x00
   45C3 00                12781 	.db 0x00
   45C4 00                12782 	.db 0x00
   45C5 00                12783 	.db 0x00
   45C6 00                12784 	.db 0x00
   45C7 00                12785 	.db 0x00
   45C8 00                12786 	.db 0x00
   45C9 00                12787 	.db 0x00
   45CA 00                12788 	.db 0x00
   45CB 00                12789 	.db 0x00
   45CC 00                12790 	.db 0x00
   45CD 00                12791 	.db 0x00
   45CE 00                12792 	.db 0x00
   45CF 00                12793 	.db 0x00
   45D0 00                12794 	.db 0x00
   45D1 00                12795 	.db 0x00
   45D2 00                12796 	.db 0x00
   45D3 00                12797 	.db 0x00
   45D4 00                12798 	.db 0x00
   45D5 00                12799 	.db 0x00
   45D6 00                12800 	.db 0x00
   45D7 00                12801 	.db 0x00
   45D8 00                12802 	.db 0x00
   45D9 00                12803 	.db 0x00
   45DA 00                12804 	.db 0x00
   45DB 00                12805 	.db 0x00
   45DC 00                12806 	.db 0x00
   45DD 00                12807 	.db 0x00
   45DE 00                12808 	.db 0x00
   45DF 00                12809 	.db 0x00
   45E0 00                12810 	.db 0x00
   45E1 00                12811 	.db 0x00
   45E2 00                12812 	.db 0x00
   45E3 00                12813 	.db 0x00
   45E4 00                12814 	.db 0x00
   45E5 00                12815 	.db 0x00
   45E6 AA 58 02          12816 	.byte _str_266,(_str_266 >> 8),#0x02
   45E9 02                12817 	.db #0x02
   45EA 0E                12818 	.db #0x0E
   45EB FF                12819 	.db #0xFF
   45EC 50 38 02          12820 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   45EF 08 3C 02          12821 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   45F2 00                12822 	.db 0x00
   45F3 00                12823 	.db 0x00
   45F4 00                12824 	.db 0x00
   45F5 00                12825 	.db 0x00
   45F6 00                12826 	.db 0x00
   45F7 00                12827 	.db 0x00
   45F8 00                12828 	.db 0x00
   45F9 00                12829 	.db 0x00
   45FA 00                12830 	.db 0x00
   45FB 00                12831 	.db 0x00
   45FC 00                12832 	.db 0x00
   45FD 00                12833 	.db 0x00
   45FE 00                12834 	.db 0x00
   45FF 00                12835 	.db 0x00
   4600 00                12836 	.db 0x00
   4601 00                12837 	.db 0x00
   4602 00                12838 	.db 0x00
   4603 00                12839 	.db 0x00
   4604 00                12840 	.db 0x00
   4605 00                12841 	.db 0x00
   4606 00                12842 	.db 0x00
   4607 00                12843 	.db 0x00
   4608 00                12844 	.db 0x00
   4609 00                12845 	.db 0x00
   460A 00                12846 	.db 0x00
   460B 00                12847 	.db 0x00
   460C 00                12848 	.db 0x00
   460D 00                12849 	.db 0x00
   460E 00                12850 	.db 0x00
   460F 00                12851 	.db 0x00
   4610 00                12852 	.db 0x00
   4611 00                12853 	.db 0x00
   4612 00                12854 	.db 0x00
   4613 00                12855 	.db 0x00
   4614 00                12856 	.db 0x00
   4615 00                12857 	.db 0x00
   4616 00                12858 	.db 0x00
   4617 00                12859 	.db 0x00
   4618 00                12860 	.db 0x00
   4619 00                12861 	.db 0x00
   461A 00                12862 	.db 0x00
   461B 00                12863 	.db 0x00
   461C 00                12864 	.db 0x00
   461D 00                12865 	.db 0x00
   461E 00                12866 	.db 0x00
   461F 00                12867 	.db 0x00
   4620 00                12868 	.db 0x00
   4621 00                12869 	.db 0x00
   4622 FB 58 02          12870 	.byte _str_267,(_str_267 >> 8),#0x02
   4625 02                12871 	.db #0x02
   4626 0E                12872 	.db #0x0E
   4627 FF                12873 	.db #0xFF
   4628 50 38 02          12874 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   462B 08 3C 02          12875 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   462E 00                12876 	.db 0x00
   462F 00                12877 	.db 0x00
   4630 00                12878 	.db 0x00
   4631 00                12879 	.db 0x00
   4632 00                12880 	.db 0x00
   4633 00                12881 	.db 0x00
   4634 00                12882 	.db 0x00
   4635 00                12883 	.db 0x00
   4636 00                12884 	.db 0x00
   4637 00                12885 	.db 0x00
   4638 00                12886 	.db 0x00
   4639 00                12887 	.db 0x00
   463A 00                12888 	.db 0x00
   463B 00                12889 	.db 0x00
   463C 00                12890 	.db 0x00
   463D 00                12891 	.db 0x00
   463E 00                12892 	.db 0x00
   463F 00                12893 	.db 0x00
   4640 00                12894 	.db 0x00
   4641 00                12895 	.db 0x00
   4642 00                12896 	.db 0x00
   4643 00                12897 	.db 0x00
   4644 00                12898 	.db 0x00
   4645 00                12899 	.db 0x00
   4646 00                12900 	.db 0x00
   4647 00                12901 	.db 0x00
   4648 00                12902 	.db 0x00
   4649 00                12903 	.db 0x00
   464A 00                12904 	.db 0x00
   464B 00                12905 	.db 0x00
   464C 00                12906 	.db 0x00
   464D 00                12907 	.db 0x00
   464E 00                12908 	.db 0x00
   464F 00                12909 	.db 0x00
   4650 00                12910 	.db 0x00
   4651 00                12911 	.db 0x00
   4652 00                12912 	.db 0x00
   4653 00                12913 	.db 0x00
   4654 00                12914 	.db 0x00
   4655 00                12915 	.db 0x00
   4656 00                12916 	.db 0x00
   4657 00                12917 	.db 0x00
   4658 00                12918 	.db 0x00
   4659 00                12919 	.db 0x00
   465A 00                12920 	.db 0x00
   465B 00                12921 	.db 0x00
   465C 00                12922 	.db 0x00
   465D 00                12923 	.db 0x00
   465E 4C 59 02          12924 	.byte _str_268,(_str_268 >> 8),#0x02
   4661 02                12925 	.db #0x02
   4662 0E                12926 	.db #0x0E
   4663 FF                12927 	.db #0xFF
   4664 50 38 02          12928 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   4667 08 3C 02          12929 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   466A 00                12930 	.db 0x00
   466B 00                12931 	.db 0x00
   466C 00                12932 	.db 0x00
   466D 00                12933 	.db 0x00
   466E 00                12934 	.db 0x00
   466F 00                12935 	.db 0x00
   4670 00                12936 	.db 0x00
   4671 00                12937 	.db 0x00
   4672 00                12938 	.db 0x00
   4673 00                12939 	.db 0x00
   4674 00                12940 	.db 0x00
   4675 00                12941 	.db 0x00
   4676 00                12942 	.db 0x00
   4677 00                12943 	.db 0x00
   4678 00                12944 	.db 0x00
   4679 00                12945 	.db 0x00
   467A 00                12946 	.db 0x00
   467B 00                12947 	.db 0x00
   467C 00                12948 	.db 0x00
   467D 00                12949 	.db 0x00
   467E 00                12950 	.db 0x00
   467F 00                12951 	.db 0x00
   4680 00                12952 	.db 0x00
   4681 00                12953 	.db 0x00
   4682 00                12954 	.db 0x00
   4683 00                12955 	.db 0x00
   4684 00                12956 	.db 0x00
   4685 00                12957 	.db 0x00
   4686 00                12958 	.db 0x00
   4687 00                12959 	.db 0x00
   4688 00                12960 	.db 0x00
   4689 00                12961 	.db 0x00
   468A 00                12962 	.db 0x00
   468B 00                12963 	.db 0x00
   468C 00                12964 	.db 0x00
   468D 00                12965 	.db 0x00
   468E 00                12966 	.db 0x00
   468F 00                12967 	.db 0x00
   4690 00                12968 	.db 0x00
   4691 00                12969 	.db 0x00
   4692 00                12970 	.db 0x00
   4693 00                12971 	.db 0x00
   4694 00                12972 	.db 0x00
   4695 00                12973 	.db 0x00
   4696 00                12974 	.db 0x00
   4697 00                12975 	.db 0x00
   4698 00                12976 	.db 0x00
   4699 00                12977 	.db 0x00
   469A 9D 59 02          12978 	.byte _str_269,(_str_269 >> 8),#0x02
   469D 02                12979 	.db #0x02
   469E 0F                12980 	.db #0x0F
   469F FF                12981 	.db #0xFF
   46A0 50 38 02          12982 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   46A3 08 3C 02          12983 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   46A6 00                12984 	.db 0x00
   46A7 00                12985 	.db 0x00
   46A8 00                12986 	.db 0x00
   46A9 00                12987 	.db 0x00
   46AA 00                12988 	.db 0x00
   46AB 00                12989 	.db 0x00
   46AC 00                12990 	.db 0x00
   46AD 00                12991 	.db 0x00
   46AE 00                12992 	.db 0x00
   46AF 00                12993 	.db 0x00
   46B0 00                12994 	.db 0x00
   46B1 00                12995 	.db 0x00
   46B2 00                12996 	.db 0x00
   46B3 00                12997 	.db 0x00
   46B4 00                12998 	.db 0x00
   46B5 00                12999 	.db 0x00
   46B6 00                13000 	.db 0x00
   46B7 00                13001 	.db 0x00
   46B8 00                13002 	.db 0x00
   46B9 00                13003 	.db 0x00
   46BA 00                13004 	.db 0x00
   46BB 00                13005 	.db 0x00
   46BC 00                13006 	.db 0x00
   46BD 00                13007 	.db 0x00
   46BE 00                13008 	.db 0x00
   46BF 00                13009 	.db 0x00
   46C0 00                13010 	.db 0x00
   46C1 00                13011 	.db 0x00
   46C2 00                13012 	.db 0x00
   46C3 00                13013 	.db 0x00
   46C4 00                13014 	.db 0x00
   46C5 00                13015 	.db 0x00
   46C6 00                13016 	.db 0x00
   46C7 00                13017 	.db 0x00
   46C8 00                13018 	.db 0x00
   46C9 00                13019 	.db 0x00
   46CA 00                13020 	.db 0x00
   46CB 00                13021 	.db 0x00
   46CC 00                13022 	.db 0x00
   46CD 00                13023 	.db 0x00
   46CE 00                13024 	.db 0x00
   46CF 00                13025 	.db 0x00
   46D0 00                13026 	.db 0x00
   46D1 00                13027 	.db 0x00
   46D2 00                13028 	.db 0x00
   46D3 00                13029 	.db 0x00
   46D4 00                13030 	.db 0x00
   46D5 00                13031 	.db 0x00
   46D6 EE 59 02          13032 	.byte _str_270,(_str_270 >> 8),#0x02
   46D9 02                13033 	.db #0x02
   46DA 0F                13034 	.db #0x0F
   46DB FF                13035 	.db #0xFF
   46DC 50 38 02          13036 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   46DF 08 3C 02          13037 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   46E2 00                13038 	.db 0x00
   46E3 00                13039 	.db 0x00
   46E4 00                13040 	.db 0x00
   46E5 00                13041 	.db 0x00
   46E6 00                13042 	.db 0x00
   46E7 00                13043 	.db 0x00
   46E8 00                13044 	.db 0x00
   46E9 00                13045 	.db 0x00
   46EA 00                13046 	.db 0x00
   46EB 00                13047 	.db 0x00
   46EC 00                13048 	.db 0x00
   46ED 00                13049 	.db 0x00
   46EE 00                13050 	.db 0x00
   46EF 00                13051 	.db 0x00
   46F0 00                13052 	.db 0x00
   46F1 00                13053 	.db 0x00
   46F2 00                13054 	.db 0x00
   46F3 00                13055 	.db 0x00
   46F4 00                13056 	.db 0x00
   46F5 00                13057 	.db 0x00
   46F6 00                13058 	.db 0x00
   46F7 00                13059 	.db 0x00
   46F8 00                13060 	.db 0x00
   46F9 00                13061 	.db 0x00
   46FA 00                13062 	.db 0x00
   46FB 00                13063 	.db 0x00
   46FC 00                13064 	.db 0x00
   46FD 00                13065 	.db 0x00
   46FE 00                13066 	.db 0x00
   46FF 00                13067 	.db 0x00
   4700 00                13068 	.db 0x00
   4701 00                13069 	.db 0x00
   4702 00                13070 	.db 0x00
   4703 00                13071 	.db 0x00
   4704 00                13072 	.db 0x00
   4705 00                13073 	.db 0x00
   4706 00                13074 	.db 0x00
   4707 00                13075 	.db 0x00
   4708 00                13076 	.db 0x00
   4709 00                13077 	.db 0x00
   470A 00                13078 	.db 0x00
   470B 00                13079 	.db 0x00
   470C 00                13080 	.db 0x00
   470D 00                13081 	.db 0x00
   470E 00                13082 	.db 0x00
   470F 00                13083 	.db 0x00
   4710 00                13084 	.db 0x00
   4711 00                13085 	.db 0x00
   4712 3F 5A 02          13086 	.byte _str_271,(_str_271 >> 8),#0x02
   4715 02                13087 	.db #0x02
   4716 0F                13088 	.db #0x0F
   4717 FF                13089 	.db #0xFF
   4718 50 38 02          13090 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   471B 08 3C 02          13091 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   471E 00                13092 	.db 0x00
   471F 00                13093 	.db 0x00
   4720 00                13094 	.db 0x00
   4721 00                13095 	.db 0x00
   4722 00                13096 	.db 0x00
   4723 00                13097 	.db 0x00
   4724 00                13098 	.db 0x00
   4725 00                13099 	.db 0x00
   4726 00                13100 	.db 0x00
   4727 00                13101 	.db 0x00
   4728 00                13102 	.db 0x00
   4729 00                13103 	.db 0x00
   472A 00                13104 	.db 0x00
   472B 00                13105 	.db 0x00
   472C 00                13106 	.db 0x00
   472D 00                13107 	.db 0x00
   472E 00                13108 	.db 0x00
   472F 00                13109 	.db 0x00
   4730 00                13110 	.db 0x00
   4731 00                13111 	.db 0x00
   4732 00                13112 	.db 0x00
   4733 00                13113 	.db 0x00
   4734 00                13114 	.db 0x00
   4735 00                13115 	.db 0x00
   4736 00                13116 	.db 0x00
   4737 00                13117 	.db 0x00
   4738 00                13118 	.db 0x00
   4739 00                13119 	.db 0x00
   473A 00                13120 	.db 0x00
   473B 00                13121 	.db 0x00
   473C 00                13122 	.db 0x00
   473D 00                13123 	.db 0x00
   473E 00                13124 	.db 0x00
   473F 00                13125 	.db 0x00
   4740 00                13126 	.db 0x00
   4741 00                13127 	.db 0x00
   4742 00                13128 	.db 0x00
   4743 00                13129 	.db 0x00
   4744 00                13130 	.db 0x00
   4745 00                13131 	.db 0x00
   4746 00                13132 	.db 0x00
   4747 00                13133 	.db 0x00
   4748 00                13134 	.db 0x00
   4749 00                13135 	.db 0x00
   474A 00                13136 	.db 0x00
   474B 00                13137 	.db 0x00
   474C 00                13138 	.db 0x00
   474D 00                13139 	.db 0x00
   474E 90 5A 02          13140 	.byte _str_272,(_str_272 >> 8),#0x02
   4751 02                13141 	.db #0x02
   4752 10                13142 	.db #0x10
   4753 FF                13143 	.db #0xFF
   4754 50 38 02          13144 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   4757 08 3C 02          13145 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   475A 00                13146 	.db 0x00
   475B 00                13147 	.db 0x00
   475C 00                13148 	.db 0x00
   475D 00                13149 	.db 0x00
   475E 00                13150 	.db 0x00
   475F 00                13151 	.db 0x00
   4760 00                13152 	.db 0x00
   4761 00                13153 	.db 0x00
   4762 00                13154 	.db 0x00
   4763 00                13155 	.db 0x00
   4764 00                13156 	.db 0x00
   4765 00                13157 	.db 0x00
   4766 00                13158 	.db 0x00
   4767 00                13159 	.db 0x00
   4768 00                13160 	.db 0x00
   4769 00                13161 	.db 0x00
   476A 00                13162 	.db 0x00
   476B 00                13163 	.db 0x00
   476C 00                13164 	.db 0x00
   476D 00                13165 	.db 0x00
   476E 00                13166 	.db 0x00
   476F 00                13167 	.db 0x00
   4770 00                13168 	.db 0x00
   4771 00                13169 	.db 0x00
   4772 00                13170 	.db 0x00
   4773 00                13171 	.db 0x00
   4774 00                13172 	.db 0x00
   4775 00                13173 	.db 0x00
   4776 00                13174 	.db 0x00
   4777 00                13175 	.db 0x00
   4778 00                13176 	.db 0x00
   4779 00                13177 	.db 0x00
   477A 00                13178 	.db 0x00
   477B 00                13179 	.db 0x00
   477C 00                13180 	.db 0x00
   477D 00                13181 	.db 0x00
   477E 00                13182 	.db 0x00
   477F 00                13183 	.db 0x00
   4780 00                13184 	.db 0x00
   4781 00                13185 	.db 0x00
   4782 00                13186 	.db 0x00
   4783 00                13187 	.db 0x00
   4784 00                13188 	.db 0x00
   4785 00                13189 	.db 0x00
   4786 00                13190 	.db 0x00
   4787 00                13191 	.db 0x00
   4788 00                13192 	.db 0x00
   4789 00                13193 	.db 0x00
   478A E1 5A 02          13194 	.byte _str_273,(_str_273 >> 8),#0x02
   478D 02                13195 	.db #0x02
   478E 10                13196 	.db #0x10
   478F FF                13197 	.db #0xFF
   4790 50 38 02          13198 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   4793 08 3C 02          13199 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   4796 00                13200 	.db 0x00
   4797 00                13201 	.db 0x00
   4798 00                13202 	.db 0x00
   4799 00                13203 	.db 0x00
   479A 00                13204 	.db 0x00
   479B 00                13205 	.db 0x00
   479C 00                13206 	.db 0x00
   479D 00                13207 	.db 0x00
   479E 00                13208 	.db 0x00
   479F 00                13209 	.db 0x00
   47A0 00                13210 	.db 0x00
   47A1 00                13211 	.db 0x00
   47A2 00                13212 	.db 0x00
   47A3 00                13213 	.db 0x00
   47A4 00                13214 	.db 0x00
   47A5 00                13215 	.db 0x00
   47A6 00                13216 	.db 0x00
   47A7 00                13217 	.db 0x00
   47A8 00                13218 	.db 0x00
   47A9 00                13219 	.db 0x00
   47AA 00                13220 	.db 0x00
   47AB 00                13221 	.db 0x00
   47AC 00                13222 	.db 0x00
   47AD 00                13223 	.db 0x00
   47AE 00                13224 	.db 0x00
   47AF 00                13225 	.db 0x00
   47B0 00                13226 	.db 0x00
   47B1 00                13227 	.db 0x00
   47B2 00                13228 	.db 0x00
   47B3 00                13229 	.db 0x00
   47B4 00                13230 	.db 0x00
   47B5 00                13231 	.db 0x00
   47B6 00                13232 	.db 0x00
   47B7 00                13233 	.db 0x00
   47B8 00                13234 	.db 0x00
   47B9 00                13235 	.db 0x00
   47BA 00                13236 	.db 0x00
   47BB 00                13237 	.db 0x00
   47BC 00                13238 	.db 0x00
   47BD 00                13239 	.db 0x00
   47BE 00                13240 	.db 0x00
   47BF 00                13241 	.db 0x00
   47C0 00                13242 	.db 0x00
   47C1 00                13243 	.db 0x00
   47C2 00                13244 	.db 0x00
   47C3 00                13245 	.db 0x00
   47C4 00                13246 	.db 0x00
   47C5 00                13247 	.db 0x00
   47C6 32 5B 02          13248 	.byte _str_274,(_str_274 >> 8),#0x02
   47C9 02                13249 	.db #0x02
   47CA 10                13250 	.db #0x10
   47CB FF                13251 	.db #0xFF
   47CC 50 38 02          13252 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   47CF 08 3C 02          13253 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   47D2 00                13254 	.db 0x00
   47D3 00                13255 	.db 0x00
   47D4 00                13256 	.db 0x00
   47D5 00                13257 	.db 0x00
   47D6 00                13258 	.db 0x00
   47D7 00                13259 	.db 0x00
   47D8 00                13260 	.db 0x00
   47D9 00                13261 	.db 0x00
   47DA 00                13262 	.db 0x00
   47DB 00                13263 	.db 0x00
   47DC 00                13264 	.db 0x00
   47DD 00                13265 	.db 0x00
   47DE 00                13266 	.db 0x00
   47DF 00                13267 	.db 0x00
   47E0 00                13268 	.db 0x00
   47E1 00                13269 	.db 0x00
   47E2 00                13270 	.db 0x00
   47E3 00                13271 	.db 0x00
   47E4 00                13272 	.db 0x00
   47E5 00                13273 	.db 0x00
   47E6 00                13274 	.db 0x00
   47E7 00                13275 	.db 0x00
   47E8 00                13276 	.db 0x00
   47E9 00                13277 	.db 0x00
   47EA 00                13278 	.db 0x00
   47EB 00                13279 	.db 0x00
   47EC 00                13280 	.db 0x00
   47ED 00                13281 	.db 0x00
   47EE 00                13282 	.db 0x00
   47EF 00                13283 	.db 0x00
   47F0 00                13284 	.db 0x00
   47F1 00                13285 	.db 0x00
   47F2 00                13286 	.db 0x00
   47F3 00                13287 	.db 0x00
   47F4 00                13288 	.db 0x00
   47F5 00                13289 	.db 0x00
   47F6 00                13290 	.db 0x00
   47F7 00                13291 	.db 0x00
   47F8 00                13292 	.db 0x00
   47F9 00                13293 	.db 0x00
   47FA 00                13294 	.db 0x00
   47FB 00                13295 	.db 0x00
   47FC 00                13296 	.db 0x00
   47FD 00                13297 	.db 0x00
   47FE 00                13298 	.db 0x00
   47FF 00                13299 	.db 0x00
   4800 00                13300 	.db 0x00
   4801 00                13301 	.db 0x00
   4802 83 5B 02          13302 	.byte _str_275,(_str_275 >> 8),#0x02
   4805 02                13303 	.db #0x02
   4806 11                13304 	.db #0x11
   4807 FF                13305 	.db #0xFF
   4808 50 38 02          13306 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   480B 08 3C 02          13307 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   480E 00                13308 	.db 0x00
   480F 00                13309 	.db 0x00
   4810 00                13310 	.db 0x00
   4811 00                13311 	.db 0x00
   4812 00                13312 	.db 0x00
   4813 00                13313 	.db 0x00
   4814 00                13314 	.db 0x00
   4815 00                13315 	.db 0x00
   4816 00                13316 	.db 0x00
   4817 00                13317 	.db 0x00
   4818 00                13318 	.db 0x00
   4819 00                13319 	.db 0x00
   481A 00                13320 	.db 0x00
   481B 00                13321 	.db 0x00
   481C 00                13322 	.db 0x00
   481D 00                13323 	.db 0x00
   481E 00                13324 	.db 0x00
   481F 00                13325 	.db 0x00
   4820 00                13326 	.db 0x00
   4821 00                13327 	.db 0x00
   4822 00                13328 	.db 0x00
   4823 00                13329 	.db 0x00
   4824 00                13330 	.db 0x00
   4825 00                13331 	.db 0x00
   4826 00                13332 	.db 0x00
   4827 00                13333 	.db 0x00
   4828 00                13334 	.db 0x00
   4829 00                13335 	.db 0x00
   482A 00                13336 	.db 0x00
   482B 00                13337 	.db 0x00
   482C 00                13338 	.db 0x00
   482D 00                13339 	.db 0x00
   482E 00                13340 	.db 0x00
   482F 00                13341 	.db 0x00
   4830 00                13342 	.db 0x00
   4831 00                13343 	.db 0x00
   4832 00                13344 	.db 0x00
   4833 00                13345 	.db 0x00
   4834 00                13346 	.db 0x00
   4835 00                13347 	.db 0x00
   4836 00                13348 	.db 0x00
   4837 00                13349 	.db 0x00
   4838 00                13350 	.db 0x00
   4839 00                13351 	.db 0x00
   483A 00                13352 	.db 0x00
   483B 00                13353 	.db 0x00
   483C 00                13354 	.db 0x00
   483D 00                13355 	.db 0x00
   483E D4 5B 02          13356 	.byte _str_276,(_str_276 >> 8),#0x02
   4841 02                13357 	.db #0x02
   4842 11                13358 	.db #0x11
   4843 FF                13359 	.db #0xFF
   4844 50 38 02          13360 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   4847 08 3C 02          13361 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   484A 00                13362 	.db 0x00
   484B 00                13363 	.db 0x00
   484C 00                13364 	.db 0x00
   484D 00                13365 	.db 0x00
   484E 00                13366 	.db 0x00
   484F 00                13367 	.db 0x00
   4850 00                13368 	.db 0x00
   4851 00                13369 	.db 0x00
   4852 00                13370 	.db 0x00
   4853 00                13371 	.db 0x00
   4854 00                13372 	.db 0x00
   4855 00                13373 	.db 0x00
   4856 00                13374 	.db 0x00
   4857 00                13375 	.db 0x00
   4858 00                13376 	.db 0x00
   4859 00                13377 	.db 0x00
   485A 00                13378 	.db 0x00
   485B 00                13379 	.db 0x00
   485C 00                13380 	.db 0x00
   485D 00                13381 	.db 0x00
   485E 00                13382 	.db 0x00
   485F 00                13383 	.db 0x00
   4860 00                13384 	.db 0x00
   4861 00                13385 	.db 0x00
   4862 00                13386 	.db 0x00
   4863 00                13387 	.db 0x00
   4864 00                13388 	.db 0x00
   4865 00                13389 	.db 0x00
   4866 00                13390 	.db 0x00
   4867 00                13391 	.db 0x00
   4868 00                13392 	.db 0x00
   4869 00                13393 	.db 0x00
   486A 00                13394 	.db 0x00
   486B 00                13395 	.db 0x00
   486C 00                13396 	.db 0x00
   486D 00                13397 	.db 0x00
   486E 00                13398 	.db 0x00
   486F 00                13399 	.db 0x00
   4870 00                13400 	.db 0x00
   4871 00                13401 	.db 0x00
   4872 00                13402 	.db 0x00
   4873 00                13403 	.db 0x00
   4874 00                13404 	.db 0x00
   4875 00                13405 	.db 0x00
   4876 00                13406 	.db 0x00
   4877 00                13407 	.db 0x00
   4878 00                13408 	.db 0x00
   4879 00                13409 	.db 0x00
   487A 25 5C 02          13410 	.byte _str_277,(_str_277 >> 8),#0x02
   487D 02                13411 	.db #0x02
   487E 11                13412 	.db #0x11
   487F FF                13413 	.db #0xFF
   4880 50 38 02          13414 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   4883 08 3C 02          13415 	.byte (_dpl + 336),((_dpl + 336) >> 8),#0x02
   4886 00                13416 	.db 0x00
   4887 00                13417 	.db 0x00
   4888 00                13418 	.db 0x00
   4889 00                13419 	.db 0x00
   488A 00                13420 	.db 0x00
   488B 00                13421 	.db 0x00
   488C 00                13422 	.db 0x00
   488D 00                13423 	.db 0x00
   488E 00                13424 	.db 0x00
   488F 00                13425 	.db 0x00
   4890 00                13426 	.db 0x00
   4891 00                13427 	.db 0x00
   4892 00                13428 	.db 0x00
   4893 00                13429 	.db 0x00
   4894 00                13430 	.db 0x00
   4895 00                13431 	.db 0x00
   4896 00                13432 	.db 0x00
   4897 00                13433 	.db 0x00
   4898 00                13434 	.db 0x00
   4899 00                13435 	.db 0x00
   489A 00                13436 	.db 0x00
   489B 00                13437 	.db 0x00
   489C 00                13438 	.db 0x00
   489D 00                13439 	.db 0x00
   489E 00                13440 	.db 0x00
   489F 00                13441 	.db 0x00
   48A0 00                13442 	.db 0x00
   48A1 00                13443 	.db 0x00
   48A2 00                13444 	.db 0x00
   48A3 00                13445 	.db 0x00
   48A4 00                13446 	.db 0x00
   48A5 00                13447 	.db 0x00
   48A6 00                13448 	.db 0x00
   48A7 00                13449 	.db 0x00
   48A8 00                13450 	.db 0x00
   48A9 00                13451 	.db 0x00
   48AA 00                13452 	.db 0x00
   48AB 00                13453 	.db 0x00
   48AC 00                13454 	.db 0x00
   48AD 00                13455 	.db 0x00
   48AE 00                13456 	.db 0x00
   48AF 00                13457 	.db 0x00
   48B0 00                13458 	.db 0x00
   48B1 00                13459 	.db 0x00
   48B2 00                13460 	.db 0x00
   48B3 00                13461 	.db 0x00
   48B4 00                13462 	.db 0x00
   48B5 00                13463 	.db 0x00
   48B6 76 5C 02          13464 	.byte _str_278,(_str_278 >> 8),#0x02
   48B9 02                13465 	.db #0x02
   48BA 05                13466 	.db #0x05
   48BB FF                13467 	.db #0xFF
   48BC 20 38 02          13468 	.byte (_minmax + 12),((_minmax + 12) >> 8),#0x02
   48BF 8A 3B 02          13469 	.byte (_dpl + 210),((_dpl + 210) >> 8),#0x02
   48C2 00                13470 	.db 0x00
   48C3 00                13471 	.db 0x00
   48C4 00                13472 	.db 0x00
   48C5 00                13473 	.db 0x00
   48C6 00                13474 	.db 0x00
   48C7 00                13475 	.db 0x00
   48C8 00                13476 	.db 0x00
   48C9 00                13477 	.db 0x00
   48CA 00                13478 	.db 0x00
   48CB 00                13479 	.db 0x00
   48CC 00                13480 	.db 0x00
   48CD 00                13481 	.db 0x00
   48CE 00                13482 	.db 0x00
   48CF 00                13483 	.db 0x00
   48D0 00                13484 	.db 0x00
   48D1 00                13485 	.db 0x00
   48D2 00                13486 	.db 0x00
   48D3 00                13487 	.db 0x00
   48D4 00                13488 	.db 0x00
   48D5 00                13489 	.db 0x00
   48D6 00                13490 	.db 0x00
   48D7 00                13491 	.db 0x00
   48D8 00                13492 	.db 0x00
   48D9 00                13493 	.db 0x00
   48DA 00                13494 	.db 0x00
   48DB 00                13495 	.db 0x00
   48DC 00                13496 	.db 0x00
   48DD 00                13497 	.db 0x00
   48DE 00                13498 	.db 0x00
   48DF 00                13499 	.db 0x00
   48E0 00                13500 	.db 0x00
   48E1 00                13501 	.db 0x00
   48E2 00                13502 	.db 0x00
   48E3 00                13503 	.db 0x00
   48E4 00                13504 	.db 0x00
   48E5 00                13505 	.db 0x00
   48E6 00                13506 	.db 0x00
   48E7 00                13507 	.db 0x00
   48E8 00                13508 	.db 0x00
   48E9 00                13509 	.db 0x00
   48EA 00                13510 	.db 0x00
   48EB 00                13511 	.db 0x00
   48EC 00                13512 	.db 0x00
   48ED 00                13513 	.db 0x00
   48EE 00                13514 	.db 0x00
   48EF 00                13515 	.db 0x00
   48F0 00                13516 	.db 0x00
   48F1 00                13517 	.db 0x00
   48F2 C7 5C 02          13518 	.byte _str_279,(_str_279 >> 8),#0x02
   48F5 02                13519 	.db #0x02
   48F6 05                13520 	.db #0x05
   48F7 FF                13521 	.db #0xFF
   48F8 20 38 02          13522 	.byte (_minmax + 12),((_minmax + 12) >> 8),#0x02
   48FB 90 3B 02          13523 	.byte (_dpl + 216),((_dpl + 216) >> 8),#0x02
   48FE 00                13524 	.db 0x00
   48FF 00                13525 	.db 0x00
   4900 00                13526 	.db 0x00
   4901 00                13527 	.db 0x00
   4902 00                13528 	.db 0x00
   4903 00                13529 	.db 0x00
   4904 00                13530 	.db 0x00
   4905 00                13531 	.db 0x00
   4906 00                13532 	.db 0x00
   4907 00                13533 	.db 0x00
   4908 00                13534 	.db 0x00
   4909 00                13535 	.db 0x00
   490A 00                13536 	.db 0x00
   490B 00                13537 	.db 0x00
   490C 00                13538 	.db 0x00
   490D 00                13539 	.db 0x00
   490E 00                13540 	.db 0x00
   490F 00                13541 	.db 0x00
   4910 00                13542 	.db 0x00
   4911 00                13543 	.db 0x00
   4912 00                13544 	.db 0x00
   4913 00                13545 	.db 0x00
   4914 00                13546 	.db 0x00
   4915 00                13547 	.db 0x00
   4916 00                13548 	.db 0x00
   4917 00                13549 	.db 0x00
   4918 00                13550 	.db 0x00
   4919 00                13551 	.db 0x00
   491A 00                13552 	.db 0x00
   491B 00                13553 	.db 0x00
   491C 00                13554 	.db 0x00
   491D 00                13555 	.db 0x00
   491E 00                13556 	.db 0x00
   491F 00                13557 	.db 0x00
   4920 00                13558 	.db 0x00
   4921 00                13559 	.db 0x00
   4922 00                13560 	.db 0x00
   4923 00                13561 	.db 0x00
   4924 00                13562 	.db 0x00
   4925 00                13563 	.db 0x00
   4926 00                13564 	.db 0x00
   4927 00                13565 	.db 0x00
   4928 00                13566 	.db 0x00
   4929 00                13567 	.db 0x00
   492A 00                13568 	.db 0x00
   492B 00                13569 	.db 0x00
   492C 00                13570 	.db 0x00
   492D 00                13571 	.db 0x00
   492E 18 5D 02          13572 	.byte _str_280,(_str_280 >> 8),#0x02
   4931 02                13573 	.db #0x02
   4932 00                13574 	.db #0x00
   4933 FF                13575 	.db #0xFF
   4934 50 38 02          13576 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   4937 84 3B 02          13577 	.byte (_dpl + 204),((_dpl + 204) >> 8),#0x02
   493A 00                13578 	.db 0x00
   493B 00                13579 	.db 0x00
   493C 00                13580 	.db 0x00
   493D 00                13581 	.db 0x00
   493E 00                13582 	.db 0x00
   493F 00                13583 	.db 0x00
   4940 00                13584 	.db 0x00
   4941 00                13585 	.db 0x00
   4942 00                13586 	.db 0x00
   4943 00                13587 	.db 0x00
   4944 00                13588 	.db 0x00
   4945 00                13589 	.db 0x00
   4946 00                13590 	.db 0x00
   4947 00                13591 	.db 0x00
   4948 00                13592 	.db 0x00
   4949 00                13593 	.db 0x00
   494A 00                13594 	.db 0x00
   494B 00                13595 	.db 0x00
   494C 00                13596 	.db 0x00
   494D 00                13597 	.db 0x00
   494E 00                13598 	.db 0x00
   494F 00                13599 	.db 0x00
   4950 00                13600 	.db 0x00
   4951 00                13601 	.db 0x00
   4952 00                13602 	.db 0x00
   4953 00                13603 	.db 0x00
   4954 00                13604 	.db 0x00
   4955 00                13605 	.db 0x00
   4956 00                13606 	.db 0x00
   4957 00                13607 	.db 0x00
   4958 00                13608 	.db 0x00
   4959 00                13609 	.db 0x00
   495A 00                13610 	.db 0x00
   495B 00                13611 	.db 0x00
   495C 00                13612 	.db 0x00
   495D 00                13613 	.db 0x00
   495E 00                13614 	.db 0x00
   495F 00                13615 	.db 0x00
   4960 00                13616 	.db 0x00
   4961 00                13617 	.db 0x00
   4962 00                13618 	.db 0x00
   4963 00                13619 	.db 0x00
   4964 00                13620 	.db 0x00
   4965 00                13621 	.db 0x00
   4966 00                13622 	.db 0x00
   4967 00                13623 	.db 0x00
   4968 00                13624 	.db 0x00
   4969 00                13625 	.db 0x00
   496A 63 5D 02          13626 	.byte _str_281,(_str_281 >> 8),#0x02
   496D 02                13627 	.db #0x02
   496E 05                13628 	.db #0x05
   496F FF                13629 	.db #0xFF
   4970 50 38 02          13630 	.byte (_bpr + 0),((_bpr + 0) >> 8),#0x02
   4973 F0 3B 02          13631 	.byte (_dpl + 312),((_dpl + 312) >> 8),#0x02
   4976 00                13632 	.db 0x00
   4977 00                13633 	.db 0x00
   4978 00                13634 	.db 0x00
   4979 00                13635 	.db 0x00
   497A 00                13636 	.db 0x00
   497B 00                13637 	.db 0x00
   497C 00                13638 	.db 0x00
   497D 00                13639 	.db 0x00
   497E 00                13640 	.db 0x00
   497F 00                13641 	.db 0x00
   4980 00                13642 	.db 0x00
   4981 00                13643 	.db 0x00
   4982 00                13644 	.db 0x00
   4983 00                13645 	.db 0x00
   4984 00                13646 	.db 0x00
   4985 00                13647 	.db 0x00
   4986 00                13648 	.db 0x00
   4987 00                13649 	.db 0x00
   4988 00                13650 	.db 0x00
   4989 00                13651 	.db 0x00
   498A 00                13652 	.db 0x00
   498B 00                13653 	.db 0x00
   498C 00                13654 	.db 0x00
   498D 00                13655 	.db 0x00
   498E 00                13656 	.db 0x00
   498F 00                13657 	.db 0x00
   4990 00                13658 	.db 0x00
   4991 00                13659 	.db 0x00
   4992 00                13660 	.db 0x00
   4993 00                13661 	.db 0x00
   4994 00                13662 	.db 0x00
   4995 00                13663 	.db 0x00
   4996 00                13664 	.db 0x00
   4997 00                13665 	.db 0x00
   4998 00                13666 	.db 0x00
   4999 00                13667 	.db 0x00
   499A 00                13668 	.db 0x00
   499B 00                13669 	.db 0x00
   499C 00                13670 	.db 0x00
   499D 00                13671 	.db 0x00
   499E 00                13672 	.db 0x00
   499F 00                13673 	.db 0x00
   49A0 00                13674 	.db 0x00
   49A1 00                13675 	.db 0x00
   49A2 00                13676 	.db 0x00
   49A3 00                13677 	.db 0x00
   49A4 00                13678 	.db 0x00
   49A5 00                13679 	.db 0x00
   49A6                   13680 __str_0:
   49A6 50 72 6F 67 72 61 13681 	.ascii "Programowanie pamieci: (   ) z (%d). Prosze czekac ..."
        6D 6F 77 61 6E 69
        65 20 70 61 6D 69
        65 63 69 3A 20 28
        20 20 20 29 20 7A
        20 28 25 64 29 2E
        20 50 72 6F 73 7A
        65 20 63 7A 65 6B
        61 63 20 2E 2E 2E
   49DC 00                13682 	.db 0x00
   49DD                   13683 __str_1:
   49DD 25 30 33 75       13684 	.ascii "%03u"
   49E1 00                13685 	.db 0x00
   49E2                   13686 __str_2:
   49E2 4F 64 63 7A 79 74 13687 	.ascii "Odczyt ustawien: (   ) z (%d). Prosze czekac ..."
        20 75 73 74 61 77
        69 65 6E 3A 20 28
        20 20 20 29 20 7A
        20 28 25 64 29 2E
        20 50 72 6F 73 7A
        65 20 63 7A 65 6B
        61 63 20 2E 2E 2E
   4A12 00                13688 	.db 0x00
   4A13                   13689 __str_3:
   4A13 57 59 4C 41 43 5A 13690 	.ascii "WYLACZONE  "
        4F 4E 45 20 20
   4A1E 00                13691 	.db 0x00
   4A1F                   13692 __str_4:
   4A1F 2D 2D             13693 	.ascii "--"
   4A21 00                13694 	.db 0x00
   4A22                   13695 __str_5:
   4A22 25 30 32 75 3A 25 13696 	.ascii "%02u:%02u"
        30 32 75
   4A2B 00                13697 	.db 0x00
   4A2C                   13698 __str_6:
   4A2C 2D                13699 	.ascii "-"
   4A2D 00                13700 	.db 0x00
   4A2E                   13701 __str_7:
   4A2E 25 30 32 75       13702 	.ascii "%02u"
   4A32 00                13703 	.db 0x00
   4A33                   13704 __str_8:
   4A33 25 30 34 75 2D 25 13705 	.ascii "%04u-%02u-%02u"
        30 32 75 2D 25 30
        32 75
   4A41 00                13706 	.db 0x00
   4A42                   13707 __str_9:
   4A42 25 30 32 75 3A 25 13708 	.ascii "%02u:%02u:%02u"
        30 32 75 3A 25 30
        32 75
   4A50 00                13709 	.db 0x00
   4A51                   13710 __str_10:
   4A51 2E 25 64          13711 	.ascii ".%d"
   4A54 00                13712 	.db 0x00
   4A55                   13713 __str_11:
   4A55 2B                13714 	.ascii "+"
   4A56 00                13715 	.db 0x00
   4A57                   13716 __str_12:
   4A57 2A                13717 	.ascii "*"
   4A58 00                13718 	.db 0x00
   4A59                   13719 __str_13:
   4A59 23                13720 	.ascii "#"
   4A5A 00                13721 	.db 0x00
   4A5B                   13722 __str_14:
   4A5B 54 65 73 74 20 6B 13723 	.ascii "Test klawiatury, nacisnij dowolny klawisz ..."
        6C 61 77 69 61 74
        75 72 79 2C 20 6E
        61 63 69 73 6E 69
        6A 20 64 6F 77 6F
        6C 6E 79 20 6B 6C
        61 77 69 73 7A 20
        2E 2E 2E
   4A88 00                13724 	.db 0x00
   4A89                   13725 __str_15:
   4A89 4E 61 63 69 73 6E 13726 	.ascii "Nacisnieto klawisz o kodzie: (%x)               "
        69 65 74 6F 20 6B
        6C 61 77 69 73 7A
        20 6F 20 6B 6F 64
        7A 69 65 3A 20 28
        25 78 29 20 20 20
        20 20 20 20 20 20
        20 20 20 20 20 20
   4AB9 00                13727 	.db 0x00
   4ABA                   13728 __str_16:
   4ABA 25 64 2E          13729 	.ascii "%d."
   4ABD 00                13730 	.db 0x00
   4ABE                   13731 __str_17:
   4ABE 25 64             13732 	.ascii "%d"
   4AC0 00                13733 	.db 0x00
   4AC1                   13734 _str_18:
   4AC1 00                13735 	.db 0x00
   4AC2                   13736 _str_19:
   4AC2 00                13737 	.db 0x00
   4AC3                   13738 _str_20:
   4AC3 00                13739 	.db 0x00
   4AC4                   13740 _str_21:
   4AC4 00                13741 	.db 0x00
   4AC5                   13742 _str_22:
   4AC5 53 63 68 6F 64 79 13743 	.ascii "Schody"
   4ACB 00                13744 	.db 0x00
   4ACC                   13745 _str_23:
   4ACC 20 20 20 20 20 20 13746 	.ascii "      "
   4AD2 00                13747 	.db 0x00
   4AD3                   13748 _str_24:
   4AD3 00                13749 	.db 0x00
   4AD4                   13750 _str_25:
   4AD4 00                13751 	.db 0x00
   4AD5                   13752 _str_26:
   4AD5 50 61 72 6B 69 6E 13753 	.ascii "Parking"
        67
   4ADC 00                13754 	.db 0x00
   4ADD                   13755 _str_27:
   4ADD 20 20 20 20 20 20 13756 	.ascii "       "
        20
   4AE4 00                13757 	.db 0x00
   4AE5                   13758 _str_28:
   4AE5 00                13759 	.db 0x00
   4AE6                   13760 _str_29:
   4AE6 00                13761 	.db 0x00
   4AE7                   13762 _str_30:
   4AE7 53 6F 63 6A 61 6C 13763 	.ascii "Socjal"
   4AED 00                13764 	.db 0x00
   4AEE                   13765 _str_31:
   4AEE 20 20 20 20 20 20 13766 	.ascii "      "
   4AF4 00                13767 	.db 0x00
   4AF5                   13768 _str_32:
   4AF5 00                13769 	.db 0x00
   4AF6                   13770 _str_33:
   4AF6 00                13771 	.db 0x00
   4AF7                   13772 _str_34:
   4AF7 4D 61 67 61 7A 79 13773 	.ascii "Magazyn"
        6E
   4AFE 00                13774 	.db 0x00
   4AFF                   13775 _str_35:
   4AFF 20 20 20 20 20 20 13776 	.ascii "       "
        20
   4B06 00                13777 	.db 0x00
   4B07                   13778 _str_36:
   4B07 00                13779 	.db 0x00
   4B08                   13780 _str_37:
   4B08 00                13781 	.db 0x00
   4B09                   13782 _str_38:
   4B09 5A 65 67 61 72    13783 	.ascii "Zegar"
   4B0E 00                13784 	.db 0x00
   4B0F                   13785 _str_39:
   4B0F 20 20 20 20 20    13786 	.ascii "     "
   4B14 00                13787 	.db 0x00
   4B15                   13788 _str_40:
   4B15 00                13789 	.db 0x00
   4B16                   13790 _str_41:
   4B16 00                13791 	.db 0x00
   4B17                   13792 _str_42:
   4B17 53 79 73 74 65 6D 13793 	.ascii "System"
   4B1D 00                13794 	.db 0x00
   4B1E                   13795 _str_43:
   4B1E 20 20 20 20 20 20 13796 	.ascii "      "
   4B24 00                13797 	.db 0x00
   4B25                   13798 _str_44:
   4B25 53 65 74 75 70    13799 	.ascii "Setup"
   4B2A 00                13800 	.db 0x00
   4B2B                   13801 _str_45:
   4B2B 20 20 20 20 20    13802 	.ascii "     "
   4B30 00                13803 	.db 0x00
   4B31                   13804 _str_46:
   4B31 50 6F 6E 2D 50 69 13805 	.ascii "Pon-Piatek"
        61 74 65 6B
   4B3B 00                13806 	.db 0x00
   4B3C                   13807 _str_47:
   4B3C 20 20 20 20 20 20 13808 	.ascii "          "
        20 20 20 20
   4B46 00                13809 	.db 0x00
   4B47                   13810 _str_48:
   4B47 00                13811 	.db 0x00
   4B48                   13812 _str_49:
   4B48 00                13813 	.db 0x00
   4B49                   13814 _str_50:
   4B49 53 6F 62 6F 74 61 13815 	.ascii "Sobota"
   4B4F 00                13816 	.db 0x00
   4B50                   13817 _str_51:
   4B50 20 20 20 20 20 20 13818 	.ascii "      "
   4B56 00                13819 	.db 0x00
   4B57                   13820 _str_52:
   4B57 00                13821 	.db 0x00
   4B58                   13822 _str_53:
   4B58 00                13823 	.db 0x00
   4B59                   13824 _str_54:
   4B59 4E 69 65 64 7A 69 13825 	.ascii "Niedziela"
        65 6C 61
   4B62 00                13826 	.db 0x00
   4B63                   13827 _str_55:
   4B63 20 20 20 20 20 20 13828 	.ascii "         "
        20 20 20
   4B6C 00                13829 	.db 0x00
   4B6D                   13830 _str_56:
   4B6D 00                13831 	.db 0x00
   4B6E                   13832 _str_57:
   4B6E 00                13833 	.db 0x00
   4B6F                   13834 _str_58:
   4B6F 57 59 4A 53       13835 	.ascii "WYJS"
   4B73 00                13836 	.db 0x00
   4B74                   13837 _str_59:
   4B74 20 20 20 20       13838 	.ascii "    "
   4B78 00                13839 	.db 0x00
   4B79                   13840 _str_60:
   4B79 00                13841 	.db 0x00
   4B7A                   13842 _str_61:
   4B7A 00                13843 	.db 0x00
   4B7B                   13844 _str_62:
   4B7B 5A 31             13845 	.ascii "Z1"
   4B7D 00                13846 	.db 0x00
   4B7E                   13847 _str_63:
   4B7E 20 20             13848 	.ascii "  "
   4B80 00                13849 	.db 0x00
   4B81                   13850 _str_64:
   4B81 00                13851 	.db 0x00
   4B82                   13852 _str_65:
   4B82 00                13853 	.db 0x00
   4B83                   13854 _str_66:
   4B83 5A 32             13855 	.ascii "Z2"
   4B85 00                13856 	.db 0x00
   4B86                   13857 _str_67:
   4B86 20 20             13858 	.ascii "  "
   4B88 00                13859 	.db 0x00
   4B89                   13860 _str_68:
   4B89 00                13861 	.db 0x00
   4B8A                   13862 _str_69:
   4B8A 00                13863 	.db 0x00
   4B8B                   13864 _str_70:
   4B8B 5A 33             13865 	.ascii "Z3"
   4B8D 00                13866 	.db 0x00
   4B8E                   13867 _str_71:
   4B8E 20 20             13868 	.ascii "  "
   4B90 00                13869 	.db 0x00
   4B91                   13870 _str_72:
   4B91 00                13871 	.db 0x00
   4B92                   13872 _str_73:
   4B92 00                13873 	.db 0x00
   4B93                   13874 _str_74:
   4B93 52 61 6D 70       13875 	.ascii "Ramp"
   4B97 00                13876 	.db 0x00
   4B98                   13877 _str_75:
   4B98 20 20 20 20       13878 	.ascii "    "
   4B9C 00                13879 	.db 0x00
   4B9D                   13880 _str_76:
   4B9D 00                13881 	.db 0x00
   4B9E                   13882 _str_77:
   4B9E 00                13883 	.db 0x00
   4B9F                   13884 _str_78:
   4B9F 57 59 4A 53       13885 	.ascii "WYJS"
   4BA3 00                13886 	.db 0x00
   4BA4                   13887 _str_79:
   4BA4 20 20 20 20       13888 	.ascii "    "
   4BA8 00                13889 	.db 0x00
   4BA9                   13890 _str_80:
   4BA9 00                13891 	.db 0x00
   4BAA                   13892 _str_81:
   4BAA 00                13893 	.db 0x00
   4BAB                   13894 _str_82:
   4BAB 45 6E 61 62 6C 65 13895 	.ascii "Enable"
   4BB1 00                13896 	.db 0x00
   4BB2                   13897 _str_83:
   4BB2 20 20 20 20 20 20 13898 	.ascii "      "
   4BB8 00                13899 	.db 0x00
   4BB9                   13900 _str_84:
   4BB9 00                13901 	.db 0x00
   4BBA                   13902 _str_85:
   4BBA 00                13903 	.db 0x00
   4BBB                   13904 _str_86:
   4BBB 52 6F 6C 6C 20 53 13905 	.ascii "Roll Size"
        69 7A 65
   4BC4 00                13906 	.db 0x00
   4BC5                   13907 _str_87:
   4BC5 20 20 20 20 20 20 13908 	.ascii "         "
        20 20 20
   4BCE 00                13909 	.db 0x00
   4BCF                   13910 _str_88:
   4BCF 00                13911 	.db 0x00
   4BD0                   13912 _str_89:
   4BD0 00                13913 	.db 0x00
   4BD1                   13914 _str_90:
   4BD1 57 59 4A 53       13915 	.ascii "WYJS"
   4BD5 00                13916 	.db 0x00
   4BD6                   13917 _str_91:
   4BD6 20 20 20 20       13918 	.ascii "    "
   4BDA 00                13919 	.db 0x00
   4BDB                   13920 _str_92:
   4BDB 00                13921 	.db 0x00
   4BDC                   13922 _str_93:
   4BDC 00                13923 	.db 0x00
   4BDD                   13924 _str_94:
   4BDD 49 6D 70 72 65 73 13925 	.ascii "Impress"
        73
   4BE4 00                13926 	.db 0x00
   4BE5                   13927 _str_95:
   4BE5 20 20 20 20 20 20 13928 	.ascii "       "
        20
   4BEC 00                13929 	.db 0x00
   4BED                   13930 _str_96:
   4BED 00                13931 	.db 0x00
   4BEE                   13932 _str_97:
   4BEE 00                13933 	.db 0x00
   4BEF                   13934 _str_98:
   4BEF 46 6F 69 6C 20 75 13935 	.ascii "Foil used"
        73 65 64
   4BF8 00                13936 	.db 0x00
   4BF9                   13937 _str_99:
   4BF9 20 20 20 20 20 20 13938 	.ascii "         "
        20 20 20
   4C02 00                13939 	.db 0x00
   4C03                   13940 _str_100:
   4C03 00                13941 	.db 0x00
   4C04                   13942 _str_101:
   4C04 00                13943 	.db 0x00
   4C05                   13944 _str_102:
   4C05 52 65 73 65 74    13945 	.ascii "Reset"
   4C0A 00                13946 	.db 0x00
   4C0B                   13947 _str_103:
   4C0B 20 20 20 20 20    13948 	.ascii "     "
   4C10 00                13949 	.db 0x00
   4C11                   13950 _str_104:
   4C11 00                13951 	.db 0x00
   4C12                   13952 _str_105:
   4C12 00                13953 	.db 0x00
   4C13                   13954 _str_106:
   4C13 57 59 4A 53       13955 	.ascii "WYJS"
   4C17 00                13956 	.db 0x00
   4C18                   13957 _str_107:
   4C18 20 20 20 20       13958 	.ascii "    "
   4C1C 00                13959 	.db 0x00
   4C1D                   13960 _str_108:
   4C1D 00                13961 	.db 0x00
   4C1E                   13962 _str_109:
   4C1E 00                13963 	.db 0x00
   4C1F                   13964 _str_110:
   4C1F 41 63 74 69 76 65 13965 	.ascii "Active"
   4C25 00                13966 	.db 0x00
   4C26                   13967 _str_111:
   4C26 20 20 20 20 20 20 13968 	.ascii "      "
   4C2C 00                13969 	.db 0x00
   4C2D                   13970 _str_112:
   4C2D 00                13971 	.db 0x00
   4C2E                   13972 _str_113:
   4C2E 00                13973 	.db 0x00
   4C2F                   13974 _str_114:
   4C2F 4F 66 66 73 65 74 13975 	.ascii "Offset"
   4C35 00                13976 	.db 0x00
   4C36                   13977 _str_115:
   4C36 20 20 20 20 20 20 13978 	.ascii "      "
   4C3C 00                13979 	.db 0x00
   4C3D                   13980 _str_116:
   4C3D 00                13981 	.db 0x00
   4C3E                   13982 _str_117:
   4C3E 00                13983 	.db 0x00
   4C3F                   13984 _str_118:
   4C3F 4F 76 65 72 72 75 13985 	.ascii "Overrun"
        6E
   4C46 00                13986 	.db 0x00
   4C47                   13987 _str_119:
   4C47 20 20 20 20 20 20 13988 	.ascii "       "
        20
   4C4E 00                13989 	.db 0x00
   4C4F                   13990 _str_120:
   4C4F 00                13991 	.db 0x00
   4C50                   13992 _str_121:
   4C50 00                13993 	.db 0x00
   4C51                   13994 _str_122:
   4C51 53 70 65 65 64    13995 	.ascii "Speed"
   4C56 00                13996 	.db 0x00
   4C57                   13997 _str_123:
   4C57 20 20 20 20 20    13998 	.ascii "     "
   4C5C 00                13999 	.db 0x00
   4C5D                   14000 _str_124:
   4C5D 00                14001 	.db 0x00
   4C5E                   14002 _str_125:
   4C5E 00                14003 	.db 0x00
   4C5F                   14004 _str_126:
   4C5F 57 59 4A 53       14005 	.ascii "WYJS"
   4C63 00                14006 	.db 0x00
   4C64                   14007 _str_127:
   4C64 20 20 20 20       14008 	.ascii "    "
   4C68 00                14009 	.db 0x00
   4C69                   14010 _str_128:
   4C69 00                14011 	.db 0x00
   4C6A                   14012 _str_129:
   4C6A 00                14013 	.db 0x00
   4C6B                   14014 _str_130:
   4C6B 44 65 6C 61 79    14015 	.ascii "Delay"
   4C70 00                14016 	.db 0x00
   4C71                   14017 _str_131:
   4C71 20 20 20 20 20    14018 	.ascii "     "
   4C76 00                14019 	.db 0x00
   4C77                   14020 _str_132:
   4C77 00                14021 	.db 0x00
   4C78                   14022 _str_133:
   4C78 00                14023 	.db 0x00
   4C79                   14024 _str_134:
   4C79 44 61 74 61       14025 	.ascii "Data"
   4C7D 00                14026 	.db 0x00
   4C7E                   14027 _str_135:
   4C7E 20 20 20 20       14028 	.ascii "    "
   4C82 00                14029 	.db 0x00
   4C83                   14030 _str_136:
   4C83 00                14031 	.db 0x00
   4C84                   14032 _str_137:
   4C84 00                14033 	.db 0x00
   4C85                   14034 _str_138:
   4C85 43 7A 61 73       14035 	.ascii "Czas"
   4C89 00                14036 	.db 0x00
   4C8A                   14037 _str_139:
   4C8A 20 20 20 20       14038 	.ascii "    "
   4C8E 00                14039 	.db 0x00
   4C8F                   14040 _str_140:
   4C8F 00                14041 	.db 0x00
   4C90                   14042 _str_141:
   4C90 00                14043 	.db 0x00
   4C91                   14044 _str_142:
   4C91 53 79 73 74 65 6D 14045 	.ascii "System"
   4C97 00                14046 	.db 0x00
   4C98                   14047 _str_143:
   4C98 20 20 20 20 20 20 14048 	.ascii "      "
   4C9E 00                14049 	.db 0x00
   4C9F                   14050 _str_144:
   4C9F 4D 61 69 6E 74 65 14051 	.ascii "Maintenance"
        6E 61 6E 63 65
   4CAA 00                14052 	.db 0x00
   4CAB                   14053 _str_145:
   4CAB 20 20 20 20 20 20 14054 	.ascii "           "
        20 20 20 20 20
   4CB6 00                14055 	.db 0x00
   4CB7                   14056 _str_146:
   4CB7 42 26 48          14057 	.ascii "B&H"
   4CBA 00                14058 	.db 0x00
   4CBB                   14059 _str_147:
   4CBB 20 20 20          14060 	.ascii "   "
   4CBE 00                14061 	.db 0x00
   4CBF                   14062 _str_148:
   4CBF 00                14063 	.db 0x00
   4CC0                   14064 _str_149:
   4CC0 00                14065 	.db 0x00
   4CC1                   14066 _str_150:
   4CC1 50 75 6C 6C       14067 	.ascii "Pull"
   4CC5 00                14068 	.db 0x00
   4CC6                   14069 _str_151:
   4CC6 20 20 20 20       14070 	.ascii "    "
   4CCA 00                14071 	.db 0x00
   4CCB                   14072 _str_152:
   4CCB 00                14073 	.db 0x00
   4CCC                   14074 _str_153:
   4CCC 00                14075 	.db 0x00
   4CCD                   14076 _str_154:
   4CCD 52 61 74 69 6F    14077 	.ascii "Ratio"
   4CD2 00                14078 	.db 0x00
   4CD3                   14079 _str_155:
   4CD3 20 20 20 20 20    14080 	.ascii "     "
   4CD8 00                14081 	.db 0x00
   4CD9                   14082 _str_156:
   4CD9 00                14083 	.db 0x00
   4CDA                   14084 _str_157:
   4CDA 00                14085 	.db 0x00
   4CDB                   14086 _str_158:
   4CDB 48 6F 6C 6F       14087 	.ascii "Holo"
   4CDF 00                14088 	.db 0x00
   4CE0                   14089 _str_159:
   4CE0 20 20 20 20       14090 	.ascii "    "
   4CE4 00                14091 	.db 0x00
   4CE5                   14092 _str_160:
   4CE5 00                14093 	.db 0x00
   4CE6                   14094 _str_161:
   4CE6 00                14095 	.db 0x00
   4CE7                   14096 _str_162:
   4CE7 54 6F 74 61 6C    14097 	.ascii "Total"
   4CEC 00                14098 	.db 0x00
   4CED                   14099 _str_163:
   4CED 20 20 20 20 20    14100 	.ascii "     "
   4CF2 00                14101 	.db 0x00
   4CF3                   14102 _str_164:
   4CF3 00                14103 	.db 0x00
   4CF4                   14104 _str_165:
   4CF4 00                14105 	.db 0x00
   4CF5                   14106 _str_166:
   4CF5 52 61 6D 70       14107 	.ascii "Ramp"
   4CF9 00                14108 	.db 0x00
   4CFA                   14109 _str_167:
   4CFA 20 20 20 20       14110 	.ascii "    "
   4CFE 00                14111 	.db 0x00
   4CFF                   14112 _str_168:
   4CFF 00                14113 	.db 0x00
   4D00                   14114 _str_169:
   4D00 00                14115 	.db 0x00
   4D01                   14116 _str_170:
   4D01 49 6E 69 74 69 61 14117 	.ascii "Initial speed"
        6C 20 73 70 65 65
        64
   4D0E 00                14118 	.db 0x00
   4D0F                   14119 _str_171:
   4D0F 20 20 20 20 20 20 14120 	.ascii "             "
        20 20 20 20 20 20
        20
   4D1C 00                14121 	.db 0x00
   4D1D                   14122 _str_172:
   4D1D 00                14123 	.db 0x00
   4D1E                   14124 _str_173:
   4D1E 00                14125 	.db 0x00
   4D1F                   14126 _str_174:
   4D1F 50 4D             14127 	.ascii "PM"
   4D21 00                14128 	.db 0x00
   4D22                   14129 _str_175:
   4D22 20 20             14130 	.ascii "  "
   4D24 00                14131 	.db 0x00
   4D25                   14132 _str_176:
   4D25 00                14133 	.db 0x00
   4D26                   14134 _str_177:
   4D26 00                14135 	.db 0x00
   4D27                   14136 _str_178:
   4D27 41 63 74 69 76 61 14137 	.ascii "Activation"
        74 69 6F 6E
   4D31 00                14138 	.db 0x00
   4D32                   14139 _str_179:
   4D32 20 20 20 20 20 20 14140 	.ascii "          "
        20 20 20 20
   4D3C 00                14141 	.db 0x00
   4D3D                   14142 _str_180:
   4D3D 00                14143 	.db 0x00
   4D3E                   14144 _str_181:
   4D3E 00                14145 	.db 0x00
   4D3F                   14146 _str_182:
   4D3F 50 61 73 73 77 6F 14147 	.ascii "Password"
        72 64
   4D47 00                14148 	.db 0x00
   4D48                   14149 _str_183:
   4D48 20 20 20 20 20 20 14150 	.ascii "        "
        20 20
   4D50 00                14151 	.db 0x00
   4D51                   14152 _str_184:
   4D51 00                14153 	.db 0x00
   4D52                   14154 _str_185:
   4D52 00                14155 	.db 0x00
   4D53                   14156 _str_186:
   4D53 53 74 61 74 75 73 14157 	.ascii "Status"
   4D59 00                14158 	.db 0x00
   4D5A                   14159 _str_187:
   4D5A 20 20 20 20 20 20 14160 	.ascii "      "
   4D60 00                14161 	.db 0x00
   4D61                   14162 _str_188:
   4D61 00                14163 	.db 0x00
   4D62                   14164 _str_189:
   4D62 00                14165 	.db 0x00
   4D63                   14166 _str_190:
   4D63 44 7A 69 65 6E    14167 	.ascii "Dzien"
   4D68 00                14168 	.db 0x00
   4D69                   14169 _str_191:
   4D69 20 20 20 20 20    14170 	.ascii "     "
   4D6E 00                14171 	.db 0x00
   4D6F                   14172 _str_192:
   4D6F 00                14173 	.db 0x00
   4D70                   14174 _str_193:
   4D70 00                14175 	.db 0x00
   4D71                   14176 _str_194:
   4D71 25 30 34 75       14177 	.ascii "%04u"
   4D75 00                14178 	.db 0x00
   4D76                   14179 _str_195:
   4D76 25 30 34 75       14180 	.ascii "%04u"
   4D7A 00                14181 	.db 0x00
   4D7B                   14182 _str_196:
   4D7B 25 30 37 6C 75    14183 	.ascii "%07lu"
   4D80 00                14184 	.db 0x00
   4D81                   14185 _str_197:
   4D81 25 30 34 75       14186 	.ascii "%04u"
   4D85 00                14187 	.db 0x00
   4D86                   14188 _str_198:
   4D86 25 30 31 75       14189 	.ascii "%01u"
   4D8A 00                14190 	.db 0x00
   4D8B                   14191 _str_199:
   4D8B 25 30 34 75       14192 	.ascii "%04u"
   4D8F 00                14193 	.db 0x00
   4D90                   14194 _str_200:
   4D90 25 30 31 75       14195 	.ascii "%01u"
   4D94 00                14196 	.db 0x00
   4D95                   14197 _str_201:
   4D95 25 30 31 75       14198 	.ascii "%01u"
   4D99 00                14199 	.db 0x00
   4D9A                   14200 _str_202:
   4D9A 25 30 34 75       14201 	.ascii "%04u"
   4D9E 00                14202 	.db 0x00
   4D9F                   14203 _str_203:
   4D9F 25 30 34 75       14204 	.ascii "%04u"
   4DA3 00                14205 	.db 0x00
   4DA4                   14206 _str_204:
   4DA4 4E 4F 4E 45       14207 	.ascii "NONE"
   4DA8 00                14208 	.db 0x00
   4DA9                   14209 _str_205:
   4DA9 4E 4F 4E 45       14210 	.ascii "NONE"
   4DAD 00                14211 	.db 0x00
   4DAE                   14212 _str_206:
   4DAE 25 30 31 75       14213 	.ascii "%01u"
   4DB2 00                14214 	.db 0x00
   4DB3                   14215 _str_207:
   4DB3 25 30 31 75       14216 	.ascii "%01u"
   4DB7 00                14217 	.db 0x00
   4DB8                   14218 _str_208:
   4DB8 25 30 31 75       14219 	.ascii "%01u"
   4DBC 00                14220 	.db 0x00
   4DBD                   14221 _str_209:
   4DBD 25 30 34 75       14222 	.ascii "%04u"
   4DC1 00                14223 	.db 0x00
   4DC2                   14224 _str_210:
   4DC2 25 30 31 75       14225 	.ascii "%01u"
   4DC6 00                14226 	.db 0x00
   4DC7                   14227 _str_211:
   4DC7 25 30 38 6C 75    14228 	.ascii "%08lu"
   4DCC 00                14229 	.db 0x00
   4DCD                   14230 _str_212:
   4DCD 25 30 38 6C 75    14231 	.ascii "%08lu"
   4DD2 00                14232 	.db 0x00
   4DD3                   14233 _str_213:
   4DD3 25 30 34 75       14234 	.ascii "%04u"
   4DD7 00                14235 	.db 0x00
   4DD8                   14236 _str_214:
   4DD8 25 30 34 75       14237 	.ascii "%04u"
   4DDC 00                14238 	.db 0x00
   4DDD                   14239 _str_215:
   4DDD 25 30 34 75       14240 	.ascii "%04u"
   4DE1 00                14241 	.db 0x00
   4DE2                   14242 _str_216:
   4DE2 25 30 31 75       14243 	.ascii "%01u"
   4DE6 00                14244 	.db 0x00
   4DE7                   14245 _str_217:
   4DE7 4E 4F 4E 45       14246 	.ascii "NONE"
   4DEB 00                14247 	.db 0x00
   4DEC                   14248 _str_218:
   4DEC 4E 4F 4E 45       14249 	.ascii "NONE"
   4DF0 00                14250 	.db 0x00
   4DF1                   14251 _str_219:
   4DF1 4E 4F 4E 45       14252 	.ascii "NONE"
   4DF5 00                14253 	.db 0x00
   4DF6                   14254 _str_220:
   4DF6 4E 4F 4E 45       14255 	.ascii "NONE"
   4DFA 00                14256 	.db 0x00
   4DFB                   14257 _str_221:
   4DFB 4E 4F 4E 45       14258 	.ascii "NONE"
   4DFF 00                14259 	.db 0x00
   4E00                   14260 _str_222:
   4E00 4E 4F 4E 45       14261 	.ascii "NONE"
   4E04 00                14262 	.db 0x00
   4E05                   14263 _str_223:
   4E05 4E 4F 4E 45       14264 	.ascii "NONE"
   4E09 00                14265 	.db 0x00
   4E0A                   14266 _str_224:
   4E0A 53 63 68 6F 64 79 14267 	.ascii "Schody Parking Socjal Magazyn      Zegar                    "
        20 50 61 72 6B 69
        6E 67 20 53 6F 63
        6A 61 6C 20 4D 61
        67 61 7A 79 6E 20
        20 20 20 20 20 5A
        65 67 61 72 20 20
        20 20 20 20 20 20
        20 20 20 20 20 20
        20 20 20 20 20 20
   4E46 20 20 20 20 20 20 14268 	.ascii "                  "
        20 20 20 20 20 20
        20 20 20 20 20 20
   4E58 00                14269 	.db 0x00
   4E59                   14270 _str_225:
   4E59 53 63 68 2D 3E 50 14271 	.ascii "Sch->Pon-Piatek  Sobota  Niedziela  WYJS"
        6F 6E 2D 50 69 61
        74 65 6B 20 20 53
        6F 62 6F 74 61 20
        20 4E 69 65 64 7A
        69 65 6C 61 20 20
        57 59 4A 53
   4E81 00                14272 	.db 0x00
   4E82                   14273 _str_226:
   4E82 50 61 72 2D 3E 50 14274 	.ascii "Par->Pon-Piatek  Sobota  Niedziela  WYJS"
        6F 6E 2D 50 69 61
        74 65 6B 20 20 53
        6F 62 6F 74 61 20
        20 4E 69 65 64 7A
        69 65 6C 61 20 20
        57 59 4A 53
   4EAA 00                14275 	.db 0x00
   4EAB                   14276 _str_227:
   4EAB 53 6F 63 2D 3E 50 14277 	.ascii "Soc->Pon-Piatek  Sobota  Niedziela  WYJS"
        6F 6E 2D 50 69 61
        74 65 6B 20 20 53
        6F 62 6F 74 61 20
        20 4E 69 65 64 7A
        69 65 6C 61 20 20
        57 59 4A 53
   4ED3 00                14278 	.db 0x00
   4ED4                   14279 _str_228:
   4ED4 4D 61 67 2D 3E 50 14280 	.ascii "Mag->Pon-Piatek  Sobota  Niedziela  WYJS"
        6F 6E 2D 50 69 61
        74 65 6B 20 20 53
        6F 62 6F 74 61 20
        20 4E 69 65 64 7A
        69 65 6C 61 20 20
        57 59 4A 53
   4EFC 00                14281 	.db 0x00
   4EFD                   14282 _str_229:
   4EFD 44 61 74 61 20 20 14283 	.ascii "Data        Czas       Dzien        WYJS"
        20 20 20 20 20 20
        43 7A 61 73 20 20
        20 20 20 20 20 44
        7A 69 65 6E 20 20
        20 20 20 20 20 20
        57 59 4A 53
   4F25 00                14284 	.db 0x00
   4F26                   14285 _str_230:
   4F26 5A 31 20 30 30 43 14286 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   4F4E 00                14287 	.db 0x00
   4F4F                   14288 _str_231:
   4F4F 5A 31 20 30 30 43 14289 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   4F77 00                14290 	.db 0x00
   4F78                   14291 _str_232:
   4F78 5A 31 20 30 30 43 14292 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   4FA0 00                14293 	.db 0x00
   4FA1                   14294 _str_233:
   4FA1 5A 31 20 30 30 43 14295 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   4FC9 00                14296 	.db 0x00
   4FCA                   14297 _str_234:
   4FCA 5A 31 20 30 30 43 14298 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   4FF2 00                14299 	.db 0x00
   4FF3                   14300 _str_235:
   4FF3 5A 31 20 30 30 43 14301 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   501B 00                14302 	.db 0x00
   501C                   14303 _str_236:
   501C 5A 31 20 30 30 43 14304 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   5044 00                14305 	.db 0x00
   5045                   14306 _str_237:
   5045 5A 31 20 30 30 43 14307 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   506D 00                14308 	.db 0x00
   506E                   14309 _str_238:
   506E 5A 31 20 30 30 43 14310 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   5096 00                14311 	.db 0x00
   5097                   14312 _str_239:
   5097 5A 31 20 30 30 43 14313 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   50BF 00                14314 	.db 0x00
   50C0                   14315 _str_240:
   50C0 5A 31 20 30 30 43 14316 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   50E8 00                14317 	.db 0x00
   50E9                   14318 _str_241:
   50E9 5A 31 20 30 30 43 14319 	.ascii "Z1 00C        Z2 00C        Z3 00C  WYJS"
        20 20 20 20 20 20
        20 20 5A 32 20 30
        30 43 20 20 20 20
        20 20 20 20 5A 33
        20 30 30 43 20 20
        57 59 4A 53
   5111 00                14320 	.db 0x00
   5112                   14321 _str_242:
   5112 42 69 65 7A 61 63 14322 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   514E 2A 2D 2A 2A 3A 2A 14323 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5162 00                14324 	.db 0x00
   5163                   14325 _str_243:
   5163 42 69 65 7A 61 63 14326 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   519F 2A 2D 2A 2A 3A 2A 14327 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   51B3 00                14328 	.db 0x00
   51B4                   14329 _str_244:
   51B4 42 69 65 7A 61 63 14330 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   51F0 2A 2D 2A 2A 3A 2A 14331 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5204 00                14332 	.db 0x00
   5205                   14333 _str_245:
   5205 42 69 65 7A 61 63 14334 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5241 2A 2D 2A 2A 3A 2A 14335 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5255 00                14336 	.db 0x00
   5256                   14337 _str_246:
   5256 42 69 65 7A 61 63 14338 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5292 2A 2D 2A 2A 3A 2A 14339 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   52A6 00                14340 	.db 0x00
   52A7                   14341 _str_247:
   52A7 42 69 65 7A 61 63 14342 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   52E3 2A 2D 2A 2A 3A 2A 14343 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   52F7 00                14344 	.db 0x00
   52F8                   14345 _str_248:
   52F8 42 69 65 7A 61 63 14346 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5334 2A 2D 2A 2A 3A 2A 14347 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5348 00                14348 	.db 0x00
   5349                   14349 _str_249:
   5349 42 69 65 7A 61 63 14350 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5385 2A 2D 2A 2A 3A 2A 14351 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5399 00                14352 	.db 0x00
   539A                   14353 _str_250:
   539A 42 69 65 7A 61 63 14354 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   53D6 2A 2D 2A 2A 3A 2A 14355 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   53EA 00                14356 	.db 0x00
   53EB                   14357 _str_251:
   53EB 42 69 65 7A 61 63 14358 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5427 2A 2D 2A 2A 3A 2A 14359 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   543B 00                14360 	.db 0x00
   543C                   14361 _str_252:
   543C 42 69 65 7A 61 63 14362 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5478 2A 2D 2A 2A 3A 2A 14363 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   548C 00                14364 	.db 0x00
   548D                   14365 _str_253:
   548D 42 69 65 7A 61 63 14366 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   54C9 2A 2D 2A 2A 3A 2A 14367 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   54DD 00                14368 	.db 0x00
   54DE                   14369 _str_254:
   54DE 42 69 65 7A 61 63 14370 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   551A 2A 2D 2A 2A 3A 2A 14371 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   552E 00                14372 	.db 0x00
   552F                   14373 _str_255:
   552F 42 69 65 7A 61 63 14374 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   556B 2A 2D 2A 2A 3A 2A 14375 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   557F 00                14376 	.db 0x00
   5580                   14377 _str_256:
   5580 42 69 65 7A 61 63 14378 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   55BC 2A 2D 2A 2A 3A 2A 14379 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   55D0 00                14380 	.db 0x00
   55D1                   14381 _str_257:
   55D1 42 69 65 7A 61 63 14382 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   560D 2A 2D 2A 2A 3A 2A 14383 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5621 00                14384 	.db 0x00
   5622                   14385 _str_258:
   5622 42 69 65 7A 61 63 14386 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   565E 2A 2D 2A 2A 3A 2A 14387 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5672 00                14388 	.db 0x00
   5673                   14389 _str_259:
   5673 42 69 65 7A 61 63 14390 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   56AF 2A 2D 2A 2A 3A 2A 14391 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   56C3 00                14392 	.db 0x00
   56C4                   14393 _str_260:
   56C4 42 69 65 7A 61 63 14394 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5700 2A 2D 2A 2A 3A 2A 14395 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5714 00                14396 	.db 0x00
   5715                   14397 _str_261:
   5715 42 69 65 7A 61 63 14398 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5751 2A 2D 2A 2A 3A 2A 14399 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5765 00                14400 	.db 0x00
   5766                   14401 _str_262:
   5766 42 69 65 7A 61 63 14402 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   57A2 2A 2D 2A 2A 3A 2A 14403 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   57B6 00                14404 	.db 0x00
   57B7                   14405 _str_263:
   57B7 42 69 65 7A 61 63 14406 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   57F3 2A 2D 2A 2A 3A 2A 14407 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5807 00                14408 	.db 0x00
   5808                   14409 _str_264:
   5808 42 69 65 7A 61 63 14410 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5844 2A 2D 2A 2A 3A 2A 14411 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5858 00                14412 	.db 0x00
   5859                   14413 _str_265:
   5859 42 69 65 7A 61 63 14414 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5895 2A 2D 2A 2A 3A 2A 14415 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   58A9 00                14416 	.db 0x00
   58AA                   14417 _str_266:
   58AA 42 69 65 7A 61 63 14418 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   58E6 2A 2D 2A 2A 3A 2A 14419 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   58FA 00                14420 	.db 0x00
   58FB                   14421 _str_267:
   58FB 42 69 65 7A 61 63 14422 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5937 2A 2D 2A 2A 3A 2A 14423 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   594B 00                14424 	.db 0x00
   594C                   14425 _str_268:
   594C 42 69 65 7A 61 63 14426 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5988 2A 2D 2A 2A 3A 2A 14427 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   599C 00                14428 	.db 0x00
   599D                   14429 _str_269:
   599D 42 69 65 7A 61 63 14430 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   59D9 2A 2D 2A 2A 3A 2A 14431 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   59ED 00                14432 	.db 0x00
   59EE                   14433 _str_270:
   59EE 42 69 65 7A 61 63 14434 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5A2A 2A 2D 2A 2A 3A 2A 14435 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5A3E 00                14436 	.db 0x00
   5A3F                   14437 _str_271:
   5A3F 42 69 65 7A 61 63 14438 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5A7B 2A 2D 2A 2A 3A 2A 14439 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5A8F 00                14440 	.db 0x00
   5A90                   14441 _str_272:
   5A90 42 69 65 7A 61 63 14442 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5ACC 2A 2D 2A 2A 3A 2A 14443 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5AE0 00                14444 	.db 0x00
   5AE1                   14445 _str_273:
   5AE1 42 69 65 7A 61 63 14446 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5B1D 2A 2D 2A 2A 3A 2A 14447 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5B31 00                14448 	.db 0x00
   5B32                   14449 _str_274:
   5B32 42 69 65 7A 61 63 14450 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5B6E 2A 2D 2A 2A 3A 2A 14451 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5B82 00                14452 	.db 0x00
   5B83                   14453 _str_275:
   5B83 42 69 65 7A 61 63 14454 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5BBF 2A 2D 2A 2A 3A 2A 14455 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5BD3 00                14456 	.db 0x00
   5BD4                   14457 _str_276:
   5BD4 42 69 65 7A 61 63 14458 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5C10 2A 2D 2A 2A 3A 2A 14459 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5C24 00                14460 	.db 0x00
   5C25                   14461 _str_277:
   5C25 42 69 65 7A 61 63 14462 	.ascii "Biezacy zakres: 23:59-23:59 Temp:    22CNowy zakres   : **:*"
        79 20 7A 61 6B 72
        65 73 3A 20 32 33
        3A 35 39 2D 32 33
        3A 35 39 20 54 65
        6D 70 3A 20 20 20
        20 32 32 43 4E 6F
        77 79 20 7A 61 6B
        72 65 73 20 20 20
        3A 20 2A 2A 3A 2A
   5C61 2A 2D 2A 2A 3A 2A 14463 	.ascii "*-**:** Temp:    **C"
        2A 20 54 65 6D 70
        3A 20 20 20 20 2A
        2A 43
   5C75 00                14464 	.db 0x00
   5C76                   14465 _str_278:
   5C76 43 75 72 72 65 6E 14466 	.ascii "Current system DATE value   :              New value (YYYY-M"
        74 20 73 79 73 74
        65 6D 20 44 41 54
        45 20 76 61 6C 75
        65 20 20 20 3A 20
        20 20 20 20 20 20
        20 20 20 20 20 20
        20 4E 65 77 20 76
        61 6C 75 65 20 28
        59 59 59 59 2D 4D
   5CB2 4D 2D 44 44 29 20 14467 	.ascii "M-DD)   : ****-**-**"
        20 20 3A 20 2A 2A
        2A 2A 2D 2A 2A 2D
        2A 2A
   5CC6 00                14468 	.db 0x00
   5CC7                   14469 _str_279:
   5CC7 43 75 72 72 65 6E 14470 	.ascii "Current system TIME value   :                New value (HH:M"
        74 20 73 79 73 74
        65 6D 20 54 49 4D
        45 20 76 61 6C 75
        65 20 20 20 3A 20
        20 20 20 20 20 20
        20 20 20 20 20 20
        20 20 20 4E 65 77
        20 76 61 6C 75 65
        20 28 48 48 3A 4D
   5D03 4D 3A 53 53 29 20 14471 	.ascii "M:SS)   :   **:**:**"
        20 20 3A 20 20 20
        2A 2A 3A 2A 2A 3A
        2A 2A
   5D17 00                14472 	.db 0x00
   5D18                   14473 _str_280:
   5D18 20 42 41 54 45 52 14474 	.ascii " BATERIA ROZLADOWANA !!! WYMIEN BATERIE          ENTER ZEBY "
        49 41 20 52 4F 5A
        4C 41 44 4F 57 41
        4E 41 20 21 21 21
        20 57 59 4D 49 45
        4E 20 42 41 54 45
        52 49 45 20 20 20
        20 20 20 20 20 20
        20 45 4E 54 45 52
        20 5A 45 42 59 20
   5D54 4B 4F 4E 54 59 4E 14475 	.ascii "KONTYNUOWAC  !"
        55 4F 57 41 43 20
        20 21
   5D62 00                14476 	.db 0x00
   5D63                   14477 _str_281:
   5D63 55 73 74 61 77 20 14478 	.ascii "Ustaw dzien tygodnia       Biezacy:     uzywajac strzalek   "
        64 7A 69 65 6E 20
        74 79 67 6F 64 6E
        69 61 20 20 20 20
        20 20 20 42 69 65
        7A 61 63 79 3A 20
        20 20 20 20 75 7A
        79 77 61 6A 61 63
        20 73 74 72 7A 61
        6C 65 6B 20 20 20
   5D9F 20 20 20 20 20 20 14479 	.ascii "          Nowy:  ***"
        20 20 20 20 4E 6F
        77 79 3A 20 20 2A
        2A 2A
   5DB3 00                14480 	.db 0x00
                          14481 	.area XINIT   (CODE)
   7750                   14482 __xinit__battery_counter:
   7750 00 00             14483 	.byte #0x00,#0x00
   7752                   14484 __xinit__update_flash:
   7752 00                14485 	.db #0x00
