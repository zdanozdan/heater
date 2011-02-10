                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.4.0 Thu Feb 10 12:42:27 2011
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module src/keypad
                              7 	.optsdcc -mmcs51 --model-small
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _mappingTable
                             13 	.globl _read_zone_temp_4
                             14 	.globl _read_zone_temp_3
                             15 	.globl _read_zone_temp_2
                             16 	.globl _read_zone_temp_1
                             17 	.globl _find_mapping_code
                             18 	.globl _delay_counter
                             19 	.globl _blink_counter
                             20 	.globl _T2_count
                             21 	.globl _T1_count
                             22 	.globl _keypad_init
                             23 	.globl _keypad_pop_front
                             24 	.globl _keypad_check_front
                             25 	.globl _keypad_purge_buffer
                             26 	.globl _keypad_get_last_code
                             27 	.globl _timer0_interrupt
                             28 ;--------------------------------------------------------
                             29 ; special function registers
                             30 ;--------------------------------------------------------
                    0080     31 _P0	=	0x0080
                    0081     32 _SP	=	0x0081
                    0082     33 _DPL	=	0x0082
                    0083     34 _DPH	=	0x0083
                    0087     35 _PCON	=	0x0087
                    0088     36 _TCON	=	0x0088
                    0089     37 _TMOD	=	0x0089
                    008A     38 _TL0	=	0x008a
                    008B     39 _TL1	=	0x008b
                    008C     40 _TH0	=	0x008c
                    008D     41 _TH1	=	0x008d
                    0090     42 _P1	=	0x0090
                    0098     43 _SCON	=	0x0098
                    0099     44 _SBUF	=	0x0099
                    00A0     45 _P2	=	0x00a0
                    00B0     46 _P3	=	0x00b0
                    00B8     47 _IP	=	0x00b8
                    00C8     48 _T2CON	=	0x00c8
                    00C9     49 _T2MOD	=	0x00c9
                    00CA     50 _RCAP2L	=	0x00ca
                    00CB     51 _RCAP2H	=	0x00cb
                    00CC     52 _TL2	=	0x00cc
                    00CD     53 _TH2	=	0x00cd
                    00D0     54 _PSW	=	0x00d0
                    00E0     55 _A	=	0x00e0
                    00A6     56 _WDTRST	=	0x00a6
                    00A7     57 _WDTPRG	=	0x00a7
                    00A2     58 _AUXR1	=	0x00a2
                    008E     59 _AUXR	=	0x008e
                    00B9     60 _SADEN	=	0x00b9
                    00BA     61 _SADEN_1	=	0x00ba
                    00B7     62 _IPH	=	0x00b7
                    00B7     63 _IPH0	=	0x00b7
                    00B8     64 _IPL	=	0x00b8
                    00B8     65 _IPL0	=	0x00b8
                    00A8     66 _IE	=	0x00a8
                    00A9     67 _SADDR	=	0x00a9
                    00AA     68 _SADDR_1	=	0x00aa
                    00D8     69 _CCON	=	0x00d8
                    00D9     70 _CMOD	=	0x00d9
                    00DA     71 _CCAPM0	=	0x00da
                    00DB     72 _CCAPM1	=	0x00db
                    00DC     73 _CCAPM2	=	0x00dc
                    00DD     74 _CCAPM3	=	0x00dd
                    00DE     75 _CCAPM4	=	0x00de
                    00E9     76 _CL	=	0x00e9
                    00EA     77 _CCAP0L	=	0x00ea
                    00EB     78 _CCAP1L	=	0x00eb
                    00EC     79 _CCAP2L	=	0x00ec
                    00ED     80 _CCAP3L	=	0x00ed
                    00EE     81 _CCAP4L	=	0x00ee
                    00E0     82 _ACC	=	0x00e0
                    00F0     83 _B	=	0x00f0
                    00F9     84 _CH	=	0x00f9
                    00FA     85 _CCAP0H	=	0x00fa
                    00FB     86 _CCAP1H	=	0x00fb
                    00FC     87 _CCAP2H	=	0x00fc
                    00FD     88 _CCAP3H	=	0x00fd
                    00FE     89 _CCAP4H	=	0x00fe
                    00FF     90 _ICON	=	0x00ff
                    0085     91 _CKSEL	=	0x0085
                    0086     92 _OSCCON	=	0x0086
                    00D1     93 _FCON	=	0x00d1
                    00D2     94 _EECON	=	0x00d2
                    00D3     95 _EETIM	=	0x00d3
                             96 ;--------------------------------------------------------
                             97 ; special function bits 
                             98 ;--------------------------------------------------------
                    0080     99 _P0_0	=	0x0080
                    0081    100 _P0_1	=	0x0081
                    0082    101 _P0_2	=	0x0082
                    0083    102 _P0_3	=	0x0083
                    0084    103 _P0_4	=	0x0084
                    0085    104 _P0_5	=	0x0085
                    0086    105 _P0_6	=	0x0086
                    0087    106 _P0_7	=	0x0087
                    00A7    107 _ENBOOT	=	0x00a7
                    0088    108 _IT0	=	0x0088
                    0089    109 _IE0	=	0x0089
                    008A    110 _IT1	=	0x008a
                    008B    111 _IE1	=	0x008b
                    008C    112 _TR0	=	0x008c
                    008D    113 _TF0	=	0x008d
                    008E    114 _TR1	=	0x008e
                    008F    115 _TF1	=	0x008f
                    0090    116 _P1_0	=	0x0090
                    0091    117 _P1_1	=	0x0091
                    0092    118 _P1_2	=	0x0092
                    0093    119 _P1_3	=	0x0093
                    0094    120 _P1_4	=	0x0094
                    0095    121 _P1_5	=	0x0095
                    0096    122 _P1_6	=	0x0096
                    0097    123 _P1_7	=	0x0097
                    0090    124 _T2	=	0x0090
                    0091    125 _T2EX	=	0x0091
                    0098    126 _RI	=	0x0098
                    0099    127 _TI	=	0x0099
                    009A    128 _RB8	=	0x009a
                    009B    129 _TB8	=	0x009b
                    009C    130 _REN	=	0x009c
                    009D    131 _SM2	=	0x009d
                    009E    132 _SM1	=	0x009e
                    009F    133 _SM0	=	0x009f
                    00A0    134 _P2_0	=	0x00a0
                    00A1    135 _P2_1	=	0x00a1
                    00A2    136 _P2_2	=	0x00a2
                    00A3    137 _P2_3	=	0x00a3
                    00A4    138 _P2_4	=	0x00a4
                    00A5    139 _P2_5	=	0x00a5
                    00A6    140 _P2_6	=	0x00a6
                    00A7    141 _P2_7	=	0x00a7
                    00B0    142 _P3_0	=	0x00b0
                    00B1    143 _P3_1	=	0x00b1
                    00B2    144 _P3_2	=	0x00b2
                    00B3    145 _P3_3	=	0x00b3
                    00B4    146 _P3_4	=	0x00b4
                    00B5    147 _P3_5	=	0x00b5
                    00B6    148 _P3_6	=	0x00b6
                    00B7    149 _P3_7	=	0x00b7
                    00B0    150 _RXD	=	0x00b0
                    00B1    151 _TXD	=	0x00b1
                    00B2    152 _INT0	=	0x00b2
                    00B3    153 _INT1	=	0x00b3
                    00B4    154 _T0	=	0x00b4
                    00B5    155 _T1	=	0x00b5
                    00B6    156 _WR	=	0x00b6
                    00B7    157 _RD	=	0x00b7
                    00B8    158 _PX0	=	0x00b8
                    00B9    159 _PT0	=	0x00b9
                    00BA    160 _PX1	=	0x00ba
                    00BB    161 _PT1	=	0x00bb
                    00BC    162 _PS	=	0x00bc
                    00BD    163 _PT2	=	0x00bd
                    00C8    164 _T2CON_0	=	0x00c8
                    00C9    165 _T2CON_1	=	0x00c9
                    00CA    166 _T2CON_2	=	0x00ca
                    00CB    167 _T2CON_3	=	0x00cb
                    00CC    168 _T2CON_4	=	0x00cc
                    00CD    169 _T2CON_5	=	0x00cd
                    00CE    170 _T2CON_6	=	0x00ce
                    00CF    171 _T2CON_7	=	0x00cf
                    00C8    172 _CP_RL2	=	0x00c8
                    00C9    173 _C_T2	=	0x00c9
                    00CA    174 _TR2	=	0x00ca
                    00CB    175 _EXEN2	=	0x00cb
                    00CC    176 _TCLK	=	0x00cc
                    00CD    177 _RCLK	=	0x00cd
                    00CE    178 _EXF2	=	0x00ce
                    00CF    179 _TF2	=	0x00cf
                    00D0    180 _P	=	0x00d0
                    00D1    181 _FL	=	0x00d1
                    00D2    182 _OV	=	0x00d2
                    00D3    183 _RS0	=	0x00d3
                    00D4    184 _RS1	=	0x00d4
                    00D5    185 _F0	=	0x00d5
                    00D6    186 _AC	=	0x00d6
                    00D7    187 _CY	=	0x00d7
                    00AF    188 _EA	=	0x00af
                    00AE    189 _EC	=	0x00ae
                    00AD    190 _ET2	=	0x00ad
                    00AC    191 _ES	=	0x00ac
                    00AB    192 _ET1	=	0x00ab
                    00AA    193 _EX1	=	0x00aa
                    00A9    194 _ET0	=	0x00a9
                    00A8    195 _EX0	=	0x00a8
                    00DF    196 _CF	=	0x00df
                    00DE    197 _CR	=	0x00de
                    00DC    198 _CCF4	=	0x00dc
                    00DB    199 _CCF3	=	0x00db
                    00DA    200 _CCF2	=	0x00da
                    00D9    201 _CCF1	=	0x00d9
                    00D8    202 _CCF0	=	0x00d8
                            203 ;--------------------------------------------------------
                            204 ; overlayable register banks 
                            205 ;--------------------------------------------------------
                            206 	.area REG_BANK_0	(REL,OVR,DATA)
   0000                     207 	.ds 8
                            208 ;--------------------------------------------------------
                            209 ; internal ram data
                            210 ;--------------------------------------------------------
                            211 	.area DSEG    (DATA)
   0026                     212 _T1_count::
   0026                     213 	.ds 2
   0028                     214 _T2_count::
   0028                     215 	.ds 2
   002A                     216 _blink_counter::
   002A                     217 	.ds 1
   002B                     218 _delay_counter::
   002B                     219 	.ds 1
   002C                     220 _timer0_interrupt_counter_1_1:
   002C                     221 	.ds 1
                            222 ;--------------------------------------------------------
                            223 ; overlayable items in internal ram 
                            224 ;--------------------------------------------------------
                            225 	.area OSEG    (OVR,DATA)
                            226 ;--------------------------------------------------------
                            227 ; indirectly addressable internal ram data
                            228 ;--------------------------------------------------------
                            229 	.area ISEG    (DATA)
                            230 ;--------------------------------------------------------
                            231 ; bit data
                            232 ;--------------------------------------------------------
                            233 	.area BSEG    (BIT)
                            234 ;--------------------------------------------------------
                            235 ; external ram data
                            236 ;--------------------------------------------------------
                            237 	.area XSEG    (XDATA)
   0000                     238 _kb:
   0000                     239 	.ds 3
                            240 ;--------------------------------------------------------
                            241 ; external initialized ram data
                            242 ;--------------------------------------------------------
                            243 	.area XISEG   (XDATA)
                            244 ;--------------------------------------------------------
                            245 ; global & static initialisations
                            246 ;--------------------------------------------------------
                            247 	.area GSINIT  (CODE)
                            248 	.area GSFINAL (CODE)
                            249 	.area GSINIT  (CODE)
                            250 ;------------------------------------------------------------
                            251 ;Allocation info for local variables in function 'timer0_interrupt'
                            252 ;------------------------------------------------------------
                            253 ;input_value               Allocated to registers r3 
                            254 ;key_code                  Allocated to registers r4 
                            255 ;empty                     Allocated to registers r2 
                            256 ;counter                   Allocated with name '_timer0_interrupt_counter_1_1'
                            257 ;------------------------------------------------------------
                            258 ;src/keypad.c:347: static unsigned char counter = 0;
                            259 ;     genAssign
   771B 75 2C 00            260 	mov	_timer0_interrupt_counter_1_1,#0x00
                            261 ;src/keypad.c:16: unsigned int T1_count=0;
                            262 ;     genAssign
   771E E4                  263 	clr	a
   771F F5 27               264 	mov	(_T1_count + 1),a
   7721 F5 26               265 	mov	_T1_count,a
                            266 ;src/keypad.c:17: unsigned int T2_count=0;
                            267 ;     genAssign
   7723 E4                  268 	clr	a
   7724 F5 29               269 	mov	(_T2_count + 1),a
   7726 F5 28               270 	mov	_T2_count,a
                            271 ;src/keypad.c:25: volatile unsigned char blink_counter = 0;
                            272 ;     genAssign
   7728 75 2A 00            273 	mov	_blink_counter,#0x00
                            274 ;src/keypad.c:26: volatile unsigned char delay_counter = 0;
                            275 ;     genAssign
   772B 75 2B 00            276 	mov	_delay_counter,#0x00
                            277 ;--------------------------------------------------------
                            278 ; Home
                            279 ;--------------------------------------------------------
                            280 	.area HOME    (CODE)
                            281 	.area CSEG    (CODE)
                            282 ;--------------------------------------------------------
                            283 ; code
                            284 ;--------------------------------------------------------
                            285 	.area CSEG    (CODE)
                            286 ;------------------------------------------------------------
                            287 ;Allocation info for local variables in function 'find_mapping_code'
                            288 ;------------------------------------------------------------
                            289 ;scan_code                 Allocated to stack - offset 1
                            290 ;result                    Allocated to registers r3 
                            291 ;stop                      Allocated to stack - offset 2
                            292 ;i                         Allocated to stack - offset 3
                            293 ;------------------------------------------------------------
                            294 ;src/keypad.c:54: unsigned char find_mapping_code(const unsigned char scan_code)
                            295 ;	-----------------------------------------
                            296 ;	 function find_mapping_code
                            297 ;	-----------------------------------------
   019D                     298 _find_mapping_code:
                    0002    299 	ar2 = 0x02
                    0003    300 	ar3 = 0x03
                    0004    301 	ar4 = 0x04
                    0005    302 	ar5 = 0x05
                    0006    303 	ar6 = 0x06
                    0007    304 	ar7 = 0x07
                    0000    305 	ar0 = 0x00
                    0001    306 	ar1 = 0x01
   019D C0 40               307 	push	_bp
   019F 85 81 40            308 	mov	_bp,sp
   01A2 05 81               309 	inc	sp
   01A4 05 81               310 	inc	sp
   01A6 05 81               311 	inc	sp
                            312 ;     genReceive
   01A8 C0 E0               313 	push	acc
                            314 ;       Peephole 212    reduced add sequence to inc
   01AA A8 40               315 	mov     r0,_bp
   01AC 08                  316 	inc     r0
   01AD D0 E0               317 	pop	acc
   01AF A6 82               318 	mov	@r0,dpl
                            319 ;src/keypad.c:56: unsigned char result = 0;
                            320 ;     genAssign
   01B1 7B 00               321 	mov	r3,#0x00
                            322 ;src/keypad.c:57: unsigned char stop = 0;
                            323 ;     genAssign
   01B3 E5 40               324 	mov	a,_bp
   01B5 24 02               325 	add	a,#0x02
   01B7 F8                  326 	mov	r0,a
   01B8 76 00               327 	mov	@r0,#0x00
                            328 ;src/keypad.c:60: for (i=0; i<255, stop==0; i++)
                            329 ;     genAssign
   01BA E5 40               330 	mov	a,_bp
   01BC 24 03               331 	add	a,#0x03
   01BE F8                  332 	mov	r0,a
   01BF 76 00               333 	mov	@r0,#0x00
   01C1                     334 00106$:
                            335 ;     genCmpEq
   01C1 E5 40               336 	mov	a,_bp
   01C3 24 02               337 	add	a,#0x02
   01C5 F8                  338 	mov	r0,a
   01C6 B6 00 02            339 	cjne	@r0,#0x00,00117$
   01C9 80 03               340 	sjmp	00118$
   01CB                     341 00117$:
   01CB 02 02 69            342 	ljmp	00109$
   01CE                     343 00118$:
                            344 ;src/keypad.c:62: if ( mappingTable[i].scan == scan_code )
                            345 ;     genIpush
   01CE C0 03               346 	push	ar3
                            347 ;     genMult
   01D0 E5 40               348 	mov	a,_bp
   01D2 24 03               349 	add	a,#0x03
   01D4 F8                  350 	mov	r0,a
                            351 ;     genMultOneByte
   01D5 E6                  352 	mov	a,@r0
   01D6 75 F0 07            353 	mov	b,#0x07
   01D9 A4                  354 	mul	ab
                            355 ;     genPlus
   01DA 24 E0               356 	add	a,#_mappingTable
   01DC FE                  357 	mov	r6,a
   01DD E5 F0               358 	mov	a,b
   01DF 34 09               359 	addc	a,#(_mappingTable >> 8)
   01E1 FF                  360 	mov	r7,a
                            361 ;     genPointerGet
                            362 ;     genCodePointerGet
   01E2 8E 82               363 	mov	dpl,r6
   01E4 8F 83               364 	mov	dph,r7
                            365 ;       Peephole 181    changed mov to clr
   01E6 E4                  366 	clr     a
   01E7 93                  367 	movc	a,@a+dptr
   01E8 FB                  368 	mov	r3,a
   01E9 74 01               369 	mov	a,#0x01
   01EB 93                  370 	movc	a,@a+dptr
   01EC FC                  371 	mov	r4,a
                            372 ;     genCast
                            373 ;       Peephole 212    reduced add sequence to inc
   01ED A8 40               374 	mov     r0,_bp
   01EF 08                  375 	inc     r0
   01F0 86 02               376 	mov	ar2,@r0
   01F2 7D 00               377 	mov	r5,#0x00
                            378 ;     genCmpEq
   01F4 EB                  379 	mov	a,r3
   01F5 B5 02 08            380 	cjne	a,ar2,00119$
   01F8 EC                  381 	mov	a,r4
   01F9 B5 05 04            382 	cjne	a,ar5,00119$
   01FC 74 01               383 	mov	a,#0x01
   01FE 80 01               384 	sjmp	00120$
   0200                     385 00119$:
   0200 E4                  386 	clr	a
   0201                     387 00120$:
                            388 ;     genIpop
   0201 D0 03               389 	pop	ar3
                            390 ;     genIfx
                            391 ;     genIfxJump
                            392 ;       Peephole 110    removed ljmp by inverse jump logic
   0203 60 19               393 	jz      00102$
   0205                     394 00121$:
                            395 ;src/keypad.c:64: result = mappingTable[i].normalized;
                            396 ;     genPlus
                            397 ;     genPlusIncr
   0205 74 02               398 	mov	a,#0x02
                            399 ;       Peephole 236.a  used r6 instead of ar6
   0207 2E                  400 	add     a,r6
   0208 F5 82               401 	mov	dpl,a
                            402 ;       Peephole 181    changed mov to clr
   020A E4                  403 	clr     a
                            404 ;       Peephole 236.b  used r7 instead of ar7
   020B 3F                  405 	addc    a,r7
   020C F5 83               406 	mov	dph,a
                            407 ;     genPointerGet
                            408 ;     genCodePointerGet
                            409 ;       Peephole 181    changed mov to clr
   020E E4                  410 	clr     a
   020F 93                  411 	movc	a,@a+dptr
   0210 FA                  412 	mov	r2,a
   0211 74 01               413 	mov	a,#0x01
   0213 93                  414 	movc	a,@a+dptr
   0214 FC                  415 	mov	r4,a
                            416 ;     genCast
   0215 8A 03               417 	mov	ar3,r2
                            418 ;src/keypad.c:65: stop = 1;
                            419 ;     genAssign
   0217 E5 40               420 	mov	a,_bp
   0219 24 02               421 	add	a,#0x02
   021B F8                  422 	mov	r0,a
   021C 76 01               423 	mov	@r0,#0x01
   021E                     424 00102$:
                            425 ;src/keypad.c:68: if ( (mappingTable[i].scan == 0) && 
                            426 ;     genMult
   021E E5 40               427 	mov	a,_bp
   0220 24 03               428 	add	a,#0x03
   0222 F8                  429 	mov	r0,a
                            430 ;     genMultOneByte
   0223 E6                  431 	mov	a,@r0
   0224 75 F0 07            432 	mov	b,#0x07
   0227 A4                  433 	mul	ab
                            434 ;     genPlus
   0228 24 E0               435 	add	a,#_mappingTable
   022A FA                  436 	mov	r2,a
   022B E5 F0               437 	mov	a,b
   022D 34 09               438 	addc	a,#(_mappingTable >> 8)
   022F FC                  439 	mov	r4,a
                            440 ;     genPointerGet
                            441 ;     genCodePointerGet
   0230 8A 82               442 	mov	dpl,r2
   0232 8C 83               443 	mov	dph,r4
                            444 ;       Peephole 181    changed mov to clr
   0234 E4                  445 	clr     a
   0235 93                  446 	movc	a,@a+dptr
   0236 FD                  447 	mov	r5,a
   0237 74 01               448 	mov	a,#0x01
   0239 93                  449 	movc	a,@a+dptr
   023A FE                  450 	mov	r6,a
                            451 ;     genCmpEq
                            452 ;       Peephole 112.b  changed ljmp to sjmp
                            453 ;       Peephole 198    optimized misc jump sequence
   023B BD 00 22            454 	cjne    r5,#0x00,00108$
   023E BE 00 1F            455 	cjne    r6,#0x00,00108$
                            456 ;00122$:
                            457 ;       Peephole 200    removed redundant sjmp
   0241                     458 00123$:
                            459 ;src/keypad.c:69: (mappingTable[i].normalized == 0) )
                            460 ;     genPlus
                            461 ;     genPlusIncr
   0241 74 02               462 	mov	a,#0x02
                            463 ;       Peephole 236.a  used r2 instead of ar2
   0243 2A                  464 	add     a,r2
   0244 F5 82               465 	mov	dpl,a
                            466 ;       Peephole 181    changed mov to clr
   0246 E4                  467 	clr     a
                            468 ;       Peephole 236.b  used r4 instead of ar4
   0247 3C                  469 	addc    a,r4
   0248 F5 83               470 	mov	dph,a
                            471 ;     genPointerGet
                            472 ;     genCodePointerGet
                            473 ;       Peephole 181    changed mov to clr
   024A E4                  474 	clr     a
   024B 93                  475 	movc	a,@a+dptr
   024C FA                  476 	mov	r2,a
   024D 74 01               477 	mov	a,#0x01
   024F 93                  478 	movc	a,@a+dptr
   0250 FC                  479 	mov	r4,a
                            480 ;     genCmpEq
                            481 ;       Peephole 112.b  changed ljmp to sjmp
                            482 ;       Peephole 198    optimized misc jump sequence
   0251 BA 00 0C            483 	cjne    r2,#0x00,00108$
   0254 BC 00 09            484 	cjne    r4,#0x00,00108$
                            485 ;00124$:
                            486 ;       Peephole 200    removed redundant sjmp
   0257                     487 00125$:
                            488 ;src/keypad.c:71: stop = 1;
                            489 ;     genAssign
   0257 E5 40               490 	mov	a,_bp
   0259 24 02               491 	add	a,#0x02
   025B F8                  492 	mov	r0,a
   025C 76 01               493 	mov	@r0,#0x01
                            494 ;src/keypad.c:72: result = SCAN_ERROR;
                            495 ;     genAssign
   025E 7B 92               496 	mov	r3,#0x92
   0260                     497 00108$:
                            498 ;src/keypad.c:60: for (i=0; i<255, stop==0; i++)
                            499 ;     genPlus
   0260 E5 40               500 	mov	a,_bp
   0262 24 03               501 	add	a,#0x03
   0264 F8                  502 	mov	r0,a
                            503 ;     genPlusIncr
   0265 06                  504 	inc	@r0
   0266 02 01 C1            505 	ljmp	00106$
   0269                     506 00109$:
                            507 ;src/keypad.c:77: return result;
                            508 ;     genRet
   0269 8B 82               509 	mov	dpl,r3
   026B                     510 00110$:
   026B 85 40 81            511 	mov	sp,_bp
   026E D0 40               512 	pop	_bp
   0270 22                  513 	ret
                            514 ;------------------------------------------------------------
                            515 ;Allocation info for local variables in function 'keypad_init'
                            516 ;------------------------------------------------------------
                            517 ;------------------------------------------------------------
                            518 ;src/keypad.c:85: void keypad_init (void)
                            519 ;	-----------------------------------------
                            520 ;	 function keypad_init
                            521 ;	-----------------------------------------
   0271                     522 _keypad_init:
   0271 C0 40               523 	push	_bp
   0273 85 81 40            524 	mov	_bp,sp
                            525 ;src/keypad.c:87: kb.last_code = BUFFER_EMPTY;
                            526 ;     genPointerSet
                            527 ;     genFarPointerSet
   0276 90 00 00            528 	mov	dptr,#_kb
   0279 74 90               529 	mov	a,#0x90
   027B F0                  530 	movx	@dptr,a
                            531 ;src/keypad.c:88: kb.status = BUFFER_EMPTY;
                            532 ;     genPointerSet
                            533 ;     genFarPointerSet
   027C 90 00 01            534 	mov	dptr,#(_kb + 0x0001)
   027F 74 90               535 	mov	a,#0x90
   0281 F0                  536 	movx	@dptr,a
                            537 ;src/keypad.c:91: ENABLE_T0_INTERRUPT;
                            538 ;     genAssign
   0282 D2 A9               539 	setb	_ET0
                            540 ;src/keypad.c:92: KEYPAD_START;
                            541 ;     genAssign
   0284 D2 8C               542 	setb	_TR0
   0286                     543 00101$:
   0286 85 40 81            544 	mov	sp,_bp
   0289 D0 40               545 	pop	_bp
   028B 22                  546 	ret
                            547 ;------------------------------------------------------------
                            548 ;Allocation info for local variables in function 'keypad_pop_front'
                            549 ;------------------------------------------------------------
                            550 ;------------------------------------------------------------
                            551 ;src/keypad.c:95: unsigned char keypad_pop_front(void)
                            552 ;	-----------------------------------------
                            553 ;	 function keypad_pop_front
                            554 ;	-----------------------------------------
   028C                     555 _keypad_pop_front:
   028C C0 40               556 	push	_bp
   028E 85 81 40            557 	mov	_bp,sp
                            558 ;src/keypad.c:97: return kb.buffer;
                            559 ;     genPointerGet
                            560 ;     genFarPointerGet
   0291 90 00 02            561 	mov	dptr,#(_kb + 0x0002)
   0294 E0                  562 	movx	a,@dptr
                            563 ;     genRet
                            564 ;       Peephole 244.c  loading dpl from a instead of r2
   0295 FA                  565 	mov	r2,a
   0296 F5 82               566 	mov	dpl,a
   0298                     567 00101$:
   0298 85 40 81            568 	mov	sp,_bp
   029B D0 40               569 	pop	_bp
   029D 22                  570 	ret
                            571 ;------------------------------------------------------------
                            572 ;Allocation info for local variables in function 'keypad_check_front'
                            573 ;------------------------------------------------------------
                            574 ;------------------------------------------------------------
                            575 ;src/keypad.c:100: unsigned char keypad_check_front(void)
                            576 ;	-----------------------------------------
                            577 ;	 function keypad_check_front
                            578 ;	-----------------------------------------
   029E                     579 _keypad_check_front:
   029E C0 40               580 	push	_bp
   02A0 85 81 40            581 	mov	_bp,sp
                            582 ;src/keypad.c:102: return kb.status;
                            583 ;     genPointerGet
                            584 ;     genFarPointerGet
   02A3 90 00 01            585 	mov	dptr,#(_kb + 0x0001)
   02A6 E0                  586 	movx	a,@dptr
                            587 ;     genRet
                            588 ;       Peephole 244.c  loading dpl from a instead of r2
   02A7 FA                  589 	mov	r2,a
   02A8 F5 82               590 	mov	dpl,a
   02AA                     591 00101$:
   02AA 85 40 81            592 	mov	sp,_bp
   02AD D0 40               593 	pop	_bp
   02AF 22                  594 	ret
                            595 ;------------------------------------------------------------
                            596 ;Allocation info for local variables in function 'keypad_purge_buffer'
                            597 ;------------------------------------------------------------
                            598 ;------------------------------------------------------------
                            599 ;src/keypad.c:105: void keypad_purge_buffer(void)
                            600 ;	-----------------------------------------
                            601 ;	 function keypad_purge_buffer
                            602 ;	-----------------------------------------
   02B0                     603 _keypad_purge_buffer:
   02B0 C0 40               604 	push	_bp
   02B2 85 81 40            605 	mov	_bp,sp
                            606 ;src/keypad.c:107: kb.status = BUFFER_EMPTY;
                            607 ;     genPointerSet
                            608 ;     genFarPointerSet
   02B5 90 00 01            609 	mov	dptr,#(_kb + 0x0001)
   02B8 74 90               610 	mov	a,#0x90
   02BA F0                  611 	movx	@dptr,a
   02BB                     612 00101$:
   02BB 85 40 81            613 	mov	sp,_bp
   02BE D0 40               614 	pop	_bp
   02C0 22                  615 	ret
                            616 ;------------------------------------------------------------
                            617 ;Allocation info for local variables in function 'keypad_get_last_code'
                            618 ;------------------------------------------------------------
                            619 ;------------------------------------------------------------
                            620 ;src/keypad.c:110: unsigned char keypad_get_last_code(void)
                            621 ;	-----------------------------------------
                            622 ;	 function keypad_get_last_code
                            623 ;	-----------------------------------------
   02C1                     624 _keypad_get_last_code:
   02C1 C0 40               625 	push	_bp
   02C3 85 81 40            626 	mov	_bp,sp
                            627 ;src/keypad.c:112: return kb.last_code;
                            628 ;     genPointerGet
                            629 ;     genFarPointerGet
   02C6 90 00 00            630 	mov	dptr,#_kb
   02C9 E0                  631 	movx	a,@dptr
                            632 ;     genRet
                            633 ;       Peephole 244.c  loading dpl from a instead of r2
   02CA FA                  634 	mov	r2,a
   02CB F5 82               635 	mov	dpl,a
   02CD                     636 00101$:
   02CD 85 40 81            637 	mov	sp,_bp
   02D0 D0 40               638 	pop	_bp
   02D2 22                  639 	ret
                            640 ;------------------------------------------------------------
                            641 ;Allocation info for local variables in function 'read_zone_temp_1'
                            642 ;------------------------------------------------------------
                            643 ;result                    Allocated to registers r2 r3 
                            644 ;------------------------------------------------------------
                            645 ;src/keypad.c:115: unsigned int read_zone_temp_1()
                            646 ;	-----------------------------------------
                            647 ;	 function read_zone_temp_1
                            648 ;	-----------------------------------------
   02D3                     649 _read_zone_temp_1:
   02D3 C0 40               650 	push	_bp
   02D5 85 81 40            651 	mov	_bp,sp
                            652 ;src/keypad.c:117: unsigned int result = 0;
                            653 ;     genAssign
   02D8 7A 00               654 	mov	r2,#0x00
                            655 ;src/keypad.c:119: T1_count=0;
                            656 ;     genAssign
                            657 ;       Peephole 3.b    changed mov to clr
   02DA E4                  658 	clr     a
   02DB FB                  659 	mov     r3,a
   02DC F5 27               660 	mov	(_T1_count + 1),a
   02DE F5 26               661 	mov	_T1_count,a
                            662 ;src/keypad.c:120: T2_count=0;
                            663 ;     genAssign
   02E0 E4                  664 	clr	a
   02E1 F5 29               665 	mov	(_T2_count + 1),a
   02E3 F5 28               666 	mov	_T2_count,a
                            667 ;src/keypad.c:123: while( SENSOR_ZONE_1 )
   02E5                     668 00103$:
                            669 ;     genIfx
                            670 ;     genIfxJump
                            671 ;       Peephole 111    removed ljmp by inverse jump logic
   02E5 30 94 17            672 	jnb     _P1_4,00108$
   02E8                     673 00138$:
                            674 ;src/keypad.c:125: if (++T2_count == 0x8000)
                            675 ;     genPlus
                            676 ;     genPlusIncr
   02E8 05 28               677 	inc	_T2_count
   02EA E4                  678 	clr	a
   02EB B5 28 02            679 	cjne	a,_T2_count,00139$
   02EE 05 29               680 	inc	(_T2_count + 1)
   02F0                     681 00139$:
                            682 ;     genCmpEq
   02F0 E5 28               683 	mov	a,_T2_count
                            684 ;       Peephole 112.b  changed ljmp to sjmp
                            685 ;       Peephole 197.a  optimized misc jump sequence
   02F2 70 F1               686 	jnz     00103$
   02F4 E5 29               687 	mov     a,(_T2_count + 1)
   02F6 B4 80 EC            688 	cjne    a,#0x80,00103$
                            689 ;00140$:     
                            690 ;       Peephole 200    removed redundant sjmp
   02F9                     691 00141$:
                            692 ;src/keypad.c:126: return 0;
                            693 ;     genRet
                            694 ;       Peephole 182.b  used 16 bit load of dptr
   02F9 90 00 00            695 	mov     dptr,#0x0000
   02FC 02 03 C4            696 	ljmp	00123$
                            697 ;src/keypad.c:130: while( !SENSOR_ZONE_1 )
   02FF                     698 00108$:
                            699 ;     genIfx
                            700 ;     genIfxJump
                            701 ;       Peephole 112.a  removed ljmp by inverse jump logic
   02FF 20 94 17            702 	jb      _P1_4,00110$
   0302                     703 00142$:
                            704 ;src/keypad.c:132: if (++T2_count == 0x8000)
                            705 ;     genPlus
                            706 ;     genPlusIncr
   0302 05 28               707 	inc	_T2_count
   0304 E4                  708 	clr	a
   0305 B5 28 02            709 	cjne	a,_T2_count,00143$
   0308 05 29               710 	inc	(_T2_count + 1)
   030A                     711 00143$:
                            712 ;     genCmpEq
   030A E5 28               713 	mov	a,_T2_count
                            714 ;       Peephole 112.b  changed ljmp to sjmp
                            715 ;       Peephole 197.a  optimized misc jump sequence
   030C 70 F1               716 	jnz     00108$
   030E E5 29               717 	mov     a,(_T2_count + 1)
   0310 B4 80 EC            718 	cjne    a,#0x80,00108$
                            719 ;00144$:     
                            720 ;       Peephole 200    removed redundant sjmp
   0313                     721 00145$:
                            722 ;src/keypad.c:133: return 0;
                            723 ;     genRet
                            724 ;       Peephole 182.b  used 16 bit load of dptr
   0313 90 00 00            725 	mov     dptr,#0x0000
   0316 02 03 C4            726 	ljmp	00123$
   0319                     727 00110$:
                            728 ;src/keypad.c:136: T1_count=0;
                            729 ;     genAssign
   0319 E4                  730 	clr	a
   031A F5 27               731 	mov	(_T1_count + 1),a
   031C F5 26               732 	mov	_T1_count,a
                            733 ;src/keypad.c:137: T2_count=0;
                            734 ;     genAssign
   031E E4                  735 	clr	a
   031F F5 29               736 	mov	(_T2_count + 1),a
   0321 F5 28               737 	mov	_T2_count,a
                            738 ;src/keypad.c:140: while( SENSOR_ZONE_1 )
   0323                     739 00113$:
                            740 ;     genIfx
                            741 ;     genIfxJump
                            742 ;       Peephole 111    removed ljmp by inverse jump logic
   0323 30 94 17            743 	jnb     _P1_4,00118$
   0326                     744 00146$:
                            745 ;src/keypad.c:143: T1_count++;
                            746 ;     genPlus
                            747 ;     genPlusIncr
   0326 05 26               748 	inc	_T1_count
   0328 E4                  749 	clr	a
   0329 B5 26 02            750 	cjne	a,_T1_count,00147$
   032C 05 27               751 	inc	(_T1_count + 1)
   032E                     752 00147$:
                            753 ;src/keypad.c:144: if (T1_count == 0x8000)
                            754 ;     genCmpEq
   032E E5 26               755 	mov	a,_T1_count
                            756 ;       Peephole 112.b  changed ljmp to sjmp
                            757 ;       Peephole 197.a  optimized misc jump sequence
   0330 70 F1               758 	jnz     00113$
   0332 E5 27               759 	mov     a,(_T1_count + 1)
   0334 B4 80 EC            760 	cjne    a,#0x80,00113$
                            761 ;00148$:     
                            762 ;       Peephole 200    removed redundant sjmp
   0337                     763 00149$:
                            764 ;src/keypad.c:145: return 0;
                            765 ;     genRet
                            766 ;       Peephole 182.b  used 16 bit load of dptr
   0337 90 00 00            767 	mov     dptr,#0x0000
   033A 02 03 C4            768 	ljmp	00123$
                            769 ;src/keypad.c:149: while( !SENSOR_ZONE_1 )
   033D                     770 00118$:
                            771 ;     genIfx
                            772 ;     genIfxJump
                            773 ;       Peephole 112.a  removed ljmp by inverse jump logic
   033D 20 94 16            774 	jb      _P1_4,00120$
   0340                     775 00150$:
                            776 ;src/keypad.c:151: T2_count++;
                            777 ;     genPlus
                            778 ;     genPlusIncr
   0340 05 28               779 	inc	_T2_count
   0342 E4                  780 	clr	a
   0343 B5 28 02            781 	cjne	a,_T2_count,00151$
   0346 05 29               782 	inc	(_T2_count + 1)
   0348                     783 00151$:
                            784 ;src/keypad.c:152: if (T2_count == 0x8000)
                            785 ;     genCmpEq
   0348 E5 28               786 	mov	a,_T2_count
                            787 ;       Peephole 112.b  changed ljmp to sjmp
                            788 ;       Peephole 197.a  optimized misc jump sequence
   034A 70 F1               789 	jnz     00118$
   034C E5 29               790 	mov     a,(_T2_count + 1)
   034E B4 80 EC            791 	cjne    a,#0x80,00118$
                            792 ;00152$:     
                            793 ;       Peephole 200    removed redundant sjmp
   0351                     794 00153$:
                            795 ;src/keypad.c:153: return 0;
                            796 ;     genRet
                            797 ;       Peephole 182.b  used 16 bit load of dptr
   0351 90 00 00            798 	mov     dptr,#0x0000
                            799 ;       Peephole 112.b  changed ljmp to sjmp
   0354 80 6E               800 	sjmp    00123$
   0356                     801 00120$:
                            802 ;src/keypad.c:156: if (T2_count != 0)
                            803 ;     genCmpEq
   0356 E5 28               804 	mov	a,_T2_count
   0358 70 04               805 	jnz	00154$
   035A E5 29               806 	mov	a,(_T2_count + 1)
                            807 ;       Peephole 110    removed ljmp by inverse jump logic
   035C 60 62               808 	jz      00122$
   035E                     809 00154$:
                            810 ;src/keypad.c:164: result = (unsigned int)235L-((400L*T1_count)/T2_count);
                            811 ;     genCast
   035E AC 26               812 	mov	r4,_T1_count
   0360 AD 27               813 	mov	r5,(_T1_count + 1)
   0362 7E 00               814 	mov	r6,#0x00
   0364 7F 00               815 	mov	r7,#0x00
                            816 ;     genAssign
   0366 75 42 90            817 	mov	__mullong_PARM_2,#0x90
   0369 75 43 01            818 	mov	(__mullong_PARM_2 + 1),#0x01
   036C 75 44 00            819 	mov	(__mullong_PARM_2 + 2),#0x00
   036F 75 45 00            820 	mov	(__mullong_PARM_2 + 3),#0x00
                            821 ;     genCall
   0372 8C 82               822 	mov	dpl,r4
   0374 8D 83               823 	mov	dph,r5
   0376 8E F0               824 	mov	b,r6
   0378 EF                  825 	mov	a,r7
   0379 12 70 BF            826 	lcall	__mullong
                            827 ;     genCast
                            828 ;     genCall
   037C AC 82               829 	mov     r4,dpl
   037E AD 83               830 	mov     r5,dph
   0380 AE F0               831 	mov     r6,b
   0382 FF                  832 	mov     r7,a
   0383 85 28 42            833 	mov     __divslong_PARM_2,_T2_count
   0386 85 29 43            834 	mov     (__divslong_PARM_2 + 1),(_T2_count + 1)
   0389 75 44 00            835 	mov     (__divslong_PARM_2 + 2),#0x00
   038C 75 45 00            836 	mov     (__divslong_PARM_2 + 3),#0x00
                            837 ;       Peephole 238.a  removed 4 redundant moves
   038F 12 71 7A            838 	lcall	__divslong
   0392 AC 82               839 	mov	r4,dpl
   0394 AD 83               840 	mov	r5,dph
   0396 AE F0               841 	mov	r6,b
   0398 FF                  842 	mov	r7,a
                            843 ;     genMinus
   0399 74 EB               844 	mov	a,#0xEB
   039B C3                  845 	clr	c
                            846 ;       Peephole 236.l  used r4 instead of ar4
   039C 9C                  847 	subb    a,r4
   039D FC                  848 	mov	r4,a
                            849 ;       Peephole 181    changed mov to clr
   039E E4                  850 	clr     a
                            851 ;       Peephole 236.l  used r5 instead of ar5
   039F 9D                  852 	subb    a,r5
   03A0 FD                  853 	mov	r5,a
                            854 ;       Peephole 181    changed mov to clr
   03A1 E4                  855 	clr     a
                            856 ;       Peephole 236.l  used r6 instead of ar6
   03A2 9E                  857 	subb    a,r6
   03A3 FE                  858 	mov	r6,a
                            859 ;       Peephole 181    changed mov to clr
   03A4 E4                  860 	clr     a
                            861 ;       Peephole 236.l  used r7 instead of ar7
   03A5 9F                  862 	subb    a,r7
   03A6 FF                  863 	mov	r7,a
                            864 ;     genCast
   03A7 8C 02               865 	mov	ar2,r4
   03A9 8D 03               866 	mov	ar3,r5
                            867 ;src/keypad.c:165: result *= 10;
                            868 ;     genAssign
   03AB E4                  869 	clr	a
   03AC F5 43               870 	mov	(__mulint_PARM_2 + 1),a
   03AE 75 42 0A            871 	mov	__mulint_PARM_2,#0x0A
                            872 ;     genCall
   03B1 8A 82               873 	mov	dpl,r2
   03B3 8B 83               874 	mov	dph,r3
   03B5 12 70 A2            875 	lcall	__mulint
   03B8 AC 82               876 	mov	r4,dpl
   03BA AD 83               877 	mov	r5,dph
                            878 ;     genAssign
   03BC 8C 02               879 	mov	ar2,r4
   03BE 8D 03               880 	mov	ar3,r5
   03C0                     881 00122$:
                            882 ;src/keypad.c:168: return result;
                            883 ;     genRet
   03C0 8A 82               884 	mov	dpl,r2
   03C2 8B 83               885 	mov	dph,r3
   03C4                     886 00123$:
   03C4 85 40 81            887 	mov	sp,_bp
   03C7 D0 40               888 	pop	_bp
   03C9 22                  889 	ret
                            890 ;------------------------------------------------------------
                            891 ;Allocation info for local variables in function 'read_zone_temp_2'
                            892 ;------------------------------------------------------------
                            893 ;result                    Allocated to registers r2 r3 
                            894 ;------------------------------------------------------------
                            895 ;src/keypad.c:171: unsigned int read_zone_temp_2()
                            896 ;	-----------------------------------------
                            897 ;	 function read_zone_temp_2
                            898 ;	-----------------------------------------
   03CA                     899 _read_zone_temp_2:
   03CA C0 40               900 	push	_bp
   03CC 85 81 40            901 	mov	_bp,sp
                            902 ;src/keypad.c:173: unsigned int result = 0;
                            903 ;     genAssign
   03CF 7A 00               904 	mov	r2,#0x00
                            905 ;src/keypad.c:175: T1_count=0;
                            906 ;     genAssign
                            907 ;       Peephole 3.b    changed mov to clr
   03D1 E4                  908 	clr     a
   03D2 FB                  909 	mov     r3,a
   03D3 F5 27               910 	mov	(_T1_count + 1),a
   03D5 F5 26               911 	mov	_T1_count,a
                            912 ;src/keypad.c:176: T2_count=0;
                            913 ;     genAssign
   03D7 E4                  914 	clr	a
   03D8 F5 29               915 	mov	(_T2_count + 1),a
   03DA F5 28               916 	mov	_T2_count,a
                            917 ;src/keypad.c:179: while( SENSOR_ZONE_2 )
   03DC                     918 00103$:
                            919 ;     genIfx
                            920 ;     genIfxJump
                            921 ;       Peephole 111    removed ljmp by inverse jump logic
   03DC 30 93 17            922 	jnb     _P1_3,00108$
   03DF                     923 00138$:
                            924 ;src/keypad.c:181: if (++T2_count == 0x8000)
                            925 ;     genPlus
                            926 ;     genPlusIncr
   03DF 05 28               927 	inc	_T2_count
   03E1 E4                  928 	clr	a
   03E2 B5 28 02            929 	cjne	a,_T2_count,00139$
   03E5 05 29               930 	inc	(_T2_count + 1)
   03E7                     931 00139$:
                            932 ;     genCmpEq
   03E7 E5 28               933 	mov	a,_T2_count
                            934 ;       Peephole 112.b  changed ljmp to sjmp
                            935 ;       Peephole 197.a  optimized misc jump sequence
   03E9 70 F1               936 	jnz     00103$
   03EB E5 29               937 	mov     a,(_T2_count + 1)
   03ED B4 80 EC            938 	cjne    a,#0x80,00103$
                            939 ;00140$:     
                            940 ;       Peephole 200    removed redundant sjmp
   03F0                     941 00141$:
                            942 ;src/keypad.c:182: return 0;
                            943 ;     genRet
                            944 ;       Peephole 182.b  used 16 bit load of dptr
   03F0 90 00 00            945 	mov     dptr,#0x0000
   03F3 02 04 BB            946 	ljmp	00123$
                            947 ;src/keypad.c:186: while( !SENSOR_ZONE_2 )
   03F6                     948 00108$:
                            949 ;     genIfx
                            950 ;     genIfxJump
                            951 ;       Peephole 112.a  removed ljmp by inverse jump logic
   03F6 20 93 17            952 	jb      _P1_3,00110$
   03F9                     953 00142$:
                            954 ;src/keypad.c:188: if (++T2_count == 0x8000)
                            955 ;     genPlus
                            956 ;     genPlusIncr
   03F9 05 28               957 	inc	_T2_count
   03FB E4                  958 	clr	a
   03FC B5 28 02            959 	cjne	a,_T2_count,00143$
   03FF 05 29               960 	inc	(_T2_count + 1)
   0401                     961 00143$:
                            962 ;     genCmpEq
   0401 E5 28               963 	mov	a,_T2_count
                            964 ;       Peephole 112.b  changed ljmp to sjmp
                            965 ;       Peephole 197.a  optimized misc jump sequence
   0403 70 F1               966 	jnz     00108$
   0405 E5 29               967 	mov     a,(_T2_count + 1)
   0407 B4 80 EC            968 	cjne    a,#0x80,00108$
                            969 ;00144$:     
                            970 ;       Peephole 200    removed redundant sjmp
   040A                     971 00145$:
                            972 ;src/keypad.c:189: return 0;
                            973 ;     genRet
                            974 ;       Peephole 182.b  used 16 bit load of dptr
   040A 90 00 00            975 	mov     dptr,#0x0000
   040D 02 04 BB            976 	ljmp	00123$
   0410                     977 00110$:
                            978 ;src/keypad.c:192: T1_count=0;
                            979 ;     genAssign
   0410 E4                  980 	clr	a
   0411 F5 27               981 	mov	(_T1_count + 1),a
   0413 F5 26               982 	mov	_T1_count,a
                            983 ;src/keypad.c:193: T2_count=0;
                            984 ;     genAssign
   0415 E4                  985 	clr	a
   0416 F5 29               986 	mov	(_T2_count + 1),a
   0418 F5 28               987 	mov	_T2_count,a
                            988 ;src/keypad.c:196: while( SENSOR_ZONE_2 )
   041A                     989 00113$:
                            990 ;     genIfx
                            991 ;     genIfxJump
                            992 ;       Peephole 111    removed ljmp by inverse jump logic
   041A 30 93 17            993 	jnb     _P1_3,00118$
   041D                     994 00146$:
                            995 ;src/keypad.c:199: T1_count++;
                            996 ;     genPlus
                            997 ;     genPlusIncr
   041D 05 26               998 	inc	_T1_count
   041F E4                  999 	clr	a
   0420 B5 26 02           1000 	cjne	a,_T1_count,00147$
   0423 05 27              1001 	inc	(_T1_count + 1)
   0425                    1002 00147$:
                           1003 ;src/keypad.c:200: if (T1_count == 0x8000)
                           1004 ;     genCmpEq
   0425 E5 26              1005 	mov	a,_T1_count
                           1006 ;       Peephole 112.b  changed ljmp to sjmp
                           1007 ;       Peephole 197.a  optimized misc jump sequence
   0427 70 F1              1008 	jnz     00113$
   0429 E5 27              1009 	mov     a,(_T1_count + 1)
   042B B4 80 EC           1010 	cjne    a,#0x80,00113$
                           1011 ;00148$:     
                           1012 ;       Peephole 200    removed redundant sjmp
   042E                    1013 00149$:
                           1014 ;src/keypad.c:201: return 0;
                           1015 ;     genRet
                           1016 ;       Peephole 182.b  used 16 bit load of dptr
   042E 90 00 00           1017 	mov     dptr,#0x0000
   0431 02 04 BB           1018 	ljmp	00123$
                           1019 ;src/keypad.c:205: while( !SENSOR_ZONE_2 )
   0434                    1020 00118$:
                           1021 ;     genIfx
                           1022 ;     genIfxJump
                           1023 ;       Peephole 112.a  removed ljmp by inverse jump logic
   0434 20 93 16           1024 	jb      _P1_3,00120$
   0437                    1025 00150$:
                           1026 ;src/keypad.c:207: T2_count++;
                           1027 ;     genPlus
                           1028 ;     genPlusIncr
   0437 05 28              1029 	inc	_T2_count
   0439 E4                 1030 	clr	a
   043A B5 28 02           1031 	cjne	a,_T2_count,00151$
   043D 05 29              1032 	inc	(_T2_count + 1)
   043F                    1033 00151$:
                           1034 ;src/keypad.c:208: if (T2_count == 0x8000)
                           1035 ;     genCmpEq
   043F E5 28              1036 	mov	a,_T2_count
                           1037 ;       Peephole 112.b  changed ljmp to sjmp
                           1038 ;       Peephole 197.a  optimized misc jump sequence
   0441 70 F1              1039 	jnz     00118$
   0443 E5 29              1040 	mov     a,(_T2_count + 1)
   0445 B4 80 EC           1041 	cjne    a,#0x80,00118$
                           1042 ;00152$:     
                           1043 ;       Peephole 200    removed redundant sjmp
   0448                    1044 00153$:
                           1045 ;src/keypad.c:209: return 0;
                           1046 ;     genRet
                           1047 ;       Peephole 182.b  used 16 bit load of dptr
   0448 90 00 00           1048 	mov     dptr,#0x0000
                           1049 ;       Peephole 112.b  changed ljmp to sjmp
   044B 80 6E              1050 	sjmp    00123$
   044D                    1051 00120$:
                           1052 ;src/keypad.c:212: if (T2_count != 0)
                           1053 ;     genCmpEq
   044D E5 28              1054 	mov	a,_T2_count
   044F 70 04              1055 	jnz	00154$
   0451 E5 29              1056 	mov	a,(_T2_count + 1)
                           1057 ;       Peephole 110    removed ljmp by inverse jump logic
   0453 60 62              1058 	jz      00122$
   0455                    1059 00154$:
                           1060 ;src/keypad.c:219: result = (unsigned int)235L-((400L*T1_count)/T2_count);
                           1061 ;     genCast
   0455 AC 26              1062 	mov	r4,_T1_count
   0457 AD 27              1063 	mov	r5,(_T1_count + 1)
   0459 7E 00              1064 	mov	r6,#0x00
   045B 7F 00              1065 	mov	r7,#0x00
                           1066 ;     genAssign
   045D 75 42 90           1067 	mov	__mullong_PARM_2,#0x90
   0460 75 43 01           1068 	mov	(__mullong_PARM_2 + 1),#0x01
   0463 75 44 00           1069 	mov	(__mullong_PARM_2 + 2),#0x00
   0466 75 45 00           1070 	mov	(__mullong_PARM_2 + 3),#0x00
                           1071 ;     genCall
   0469 8C 82              1072 	mov	dpl,r4
   046B 8D 83              1073 	mov	dph,r5
   046D 8E F0              1074 	mov	b,r6
   046F EF                 1075 	mov	a,r7
   0470 12 70 BF           1076 	lcall	__mullong
                           1077 ;     genCast
                           1078 ;     genCall
   0473 AC 82              1079 	mov     r4,dpl
   0475 AD 83              1080 	mov     r5,dph
   0477 AE F0              1081 	mov     r6,b
   0479 FF                 1082 	mov     r7,a
   047A 85 28 42           1083 	mov     __divslong_PARM_2,_T2_count
   047D 85 29 43           1084 	mov     (__divslong_PARM_2 + 1),(_T2_count + 1)
   0480 75 44 00           1085 	mov     (__divslong_PARM_2 + 2),#0x00
   0483 75 45 00           1086 	mov     (__divslong_PARM_2 + 3),#0x00
                           1087 ;       Peephole 238.a  removed 4 redundant moves
   0486 12 71 7A           1088 	lcall	__divslong
   0489 AC 82              1089 	mov	r4,dpl
   048B AD 83              1090 	mov	r5,dph
   048D AE F0              1091 	mov	r6,b
   048F FF                 1092 	mov	r7,a
                           1093 ;     genMinus
   0490 74 EB              1094 	mov	a,#0xEB
   0492 C3                 1095 	clr	c
                           1096 ;       Peephole 236.l  used r4 instead of ar4
   0493 9C                 1097 	subb    a,r4
   0494 FC                 1098 	mov	r4,a
                           1099 ;       Peephole 181    changed mov to clr
   0495 E4                 1100 	clr     a
                           1101 ;       Peephole 236.l  used r5 instead of ar5
   0496 9D                 1102 	subb    a,r5
   0497 FD                 1103 	mov	r5,a
                           1104 ;       Peephole 181    changed mov to clr
   0498 E4                 1105 	clr     a
                           1106 ;       Peephole 236.l  used r6 instead of ar6
   0499 9E                 1107 	subb    a,r6
   049A FE                 1108 	mov	r6,a
                           1109 ;       Peephole 181    changed mov to clr
   049B E4                 1110 	clr     a
                           1111 ;       Peephole 236.l  used r7 instead of ar7
   049C 9F                 1112 	subb    a,r7
   049D FF                 1113 	mov	r7,a
                           1114 ;     genCast
   049E 8C 02              1115 	mov	ar2,r4
   04A0 8D 03              1116 	mov	ar3,r5
                           1117 ;src/keypad.c:220: result *= 10;
                           1118 ;     genAssign
   04A2 E4                 1119 	clr	a
   04A3 F5 43              1120 	mov	(__mulint_PARM_2 + 1),a
   04A5 75 42 0A           1121 	mov	__mulint_PARM_2,#0x0A
                           1122 ;     genCall
   04A8 8A 82              1123 	mov	dpl,r2
   04AA 8B 83              1124 	mov	dph,r3
   04AC 12 70 A2           1125 	lcall	__mulint
   04AF AC 82              1126 	mov	r4,dpl
   04B1 AD 83              1127 	mov	r5,dph
                           1128 ;     genAssign
   04B3 8C 02              1129 	mov	ar2,r4
   04B5 8D 03              1130 	mov	ar3,r5
   04B7                    1131 00122$:
                           1132 ;src/keypad.c:224: return result;
                           1133 ;     genRet
   04B7 8A 82              1134 	mov	dpl,r2
   04B9 8B 83              1135 	mov	dph,r3
   04BB                    1136 00123$:
   04BB 85 40 81           1137 	mov	sp,_bp
   04BE D0 40              1138 	pop	_bp
   04C0 22                 1139 	ret
                           1140 ;------------------------------------------------------------
                           1141 ;Allocation info for local variables in function 'read_zone_temp_3'
                           1142 ;------------------------------------------------------------
                           1143 ;result                    Allocated to registers r2 r3 
                           1144 ;------------------------------------------------------------
                           1145 ;src/keypad.c:226: unsigned int read_zone_temp_3()
                           1146 ;	-----------------------------------------
                           1147 ;	 function read_zone_temp_3
                           1148 ;	-----------------------------------------
   04C1                    1149 _read_zone_temp_3:
   04C1 C0 40              1150 	push	_bp
   04C3 85 81 40           1151 	mov	_bp,sp
                           1152 ;src/keypad.c:228: unsigned int result = 0;
                           1153 ;     genAssign
   04C6 7A 00              1154 	mov	r2,#0x00
                           1155 ;src/keypad.c:230: T1_count=0;
                           1156 ;     genAssign
                           1157 ;       Peephole 3.b    changed mov to clr
   04C8 E4                 1158 	clr     a
   04C9 FB                 1159 	mov     r3,a
   04CA F5 27              1160 	mov	(_T1_count + 1),a
   04CC F5 26              1161 	mov	_T1_count,a
                           1162 ;src/keypad.c:231: T2_count=0;
                           1163 ;     genAssign
   04CE E4                 1164 	clr	a
   04CF F5 29              1165 	mov	(_T2_count + 1),a
   04D1 F5 28              1166 	mov	_T2_count,a
                           1167 ;src/keypad.c:234: while( SENSOR_ZONE_3 )
   04D3                    1168 00103$:
                           1169 ;     genIfx
                           1170 ;     genIfxJump
                           1171 ;       Peephole 111    removed ljmp by inverse jump logic
   04D3 30 92 17           1172 	jnb     _P1_2,00108$
   04D6                    1173 00138$:
                           1174 ;src/keypad.c:236: if (++T2_count == 0x8000)
                           1175 ;     genPlus
                           1176 ;     genPlusIncr
   04D6 05 28              1177 	inc	_T2_count
   04D8 E4                 1178 	clr	a
   04D9 B5 28 02           1179 	cjne	a,_T2_count,00139$
   04DC 05 29              1180 	inc	(_T2_count + 1)
   04DE                    1181 00139$:
                           1182 ;     genCmpEq
   04DE E5 28              1183 	mov	a,_T2_count
                           1184 ;       Peephole 112.b  changed ljmp to sjmp
                           1185 ;       Peephole 197.a  optimized misc jump sequence
   04E0 70 F1              1186 	jnz     00103$
   04E2 E5 29              1187 	mov     a,(_T2_count + 1)
   04E4 B4 80 EC           1188 	cjne    a,#0x80,00103$
                           1189 ;00140$:     
                           1190 ;       Peephole 200    removed redundant sjmp
   04E7                    1191 00141$:
                           1192 ;src/keypad.c:237: return 0;
                           1193 ;     genRet
                           1194 ;       Peephole 182.b  used 16 bit load of dptr
   04E7 90 00 00           1195 	mov     dptr,#0x0000
   04EA 02 05 B2           1196 	ljmp	00123$
                           1197 ;src/keypad.c:241: while( !SENSOR_ZONE_3 )
   04ED                    1198 00108$:
                           1199 ;     genIfx
                           1200 ;     genIfxJump
                           1201 ;       Peephole 112.a  removed ljmp by inverse jump logic
   04ED 20 92 17           1202 	jb      _P1_2,00110$
   04F0                    1203 00142$:
                           1204 ;src/keypad.c:243: if (++T2_count == 0x8000)
                           1205 ;     genPlus
                           1206 ;     genPlusIncr
   04F0 05 28              1207 	inc	_T2_count
   04F2 E4                 1208 	clr	a
   04F3 B5 28 02           1209 	cjne	a,_T2_count,00143$
   04F6 05 29              1210 	inc	(_T2_count + 1)
   04F8                    1211 00143$:
                           1212 ;     genCmpEq
   04F8 E5 28              1213 	mov	a,_T2_count
                           1214 ;       Peephole 112.b  changed ljmp to sjmp
                           1215 ;       Peephole 197.a  optimized misc jump sequence
   04FA 70 F1              1216 	jnz     00108$
   04FC E5 29              1217 	mov     a,(_T2_count + 1)
   04FE B4 80 EC           1218 	cjne    a,#0x80,00108$
                           1219 ;00144$:     
                           1220 ;       Peephole 200    removed redundant sjmp
   0501                    1221 00145$:
                           1222 ;src/keypad.c:244: return 0;
                           1223 ;     genRet
                           1224 ;       Peephole 182.b  used 16 bit load of dptr
   0501 90 00 00           1225 	mov     dptr,#0x0000
   0504 02 05 B2           1226 	ljmp	00123$
   0507                    1227 00110$:
                           1228 ;src/keypad.c:247: T1_count=0;
                           1229 ;     genAssign
   0507 E4                 1230 	clr	a
   0508 F5 27              1231 	mov	(_T1_count + 1),a
   050A F5 26              1232 	mov	_T1_count,a
                           1233 ;src/keypad.c:248: T2_count=0;
                           1234 ;     genAssign
   050C E4                 1235 	clr	a
   050D F5 29              1236 	mov	(_T2_count + 1),a
   050F F5 28              1237 	mov	_T2_count,a
                           1238 ;src/keypad.c:251: while( SENSOR_ZONE_3 )
   0511                    1239 00113$:
                           1240 ;     genIfx
                           1241 ;     genIfxJump
                           1242 ;       Peephole 111    removed ljmp by inverse jump logic
   0511 30 92 17           1243 	jnb     _P1_2,00118$
   0514                    1244 00146$:
                           1245 ;src/keypad.c:254: T1_count++;
                           1246 ;     genPlus
                           1247 ;     genPlusIncr
   0514 05 26              1248 	inc	_T1_count
   0516 E4                 1249 	clr	a
   0517 B5 26 02           1250 	cjne	a,_T1_count,00147$
   051A 05 27              1251 	inc	(_T1_count + 1)
   051C                    1252 00147$:
                           1253 ;src/keypad.c:255: if (T1_count == 0x8000)
                           1254 ;     genCmpEq
   051C E5 26              1255 	mov	a,_T1_count
                           1256 ;       Peephole 112.b  changed ljmp to sjmp
                           1257 ;       Peephole 197.a  optimized misc jump sequence
   051E 70 F1              1258 	jnz     00113$
   0520 E5 27              1259 	mov     a,(_T1_count + 1)
   0522 B4 80 EC           1260 	cjne    a,#0x80,00113$
                           1261 ;00148$:     
                           1262 ;       Peephole 200    removed redundant sjmp
   0525                    1263 00149$:
                           1264 ;src/keypad.c:256: return 0;
                           1265 ;     genRet
                           1266 ;       Peephole 182.b  used 16 bit load of dptr
   0525 90 00 00           1267 	mov     dptr,#0x0000
   0528 02 05 B2           1268 	ljmp	00123$
                           1269 ;src/keypad.c:260: while( !SENSOR_ZONE_3 )
   052B                    1270 00118$:
                           1271 ;     genIfx
                           1272 ;     genIfxJump
                           1273 ;       Peephole 112.a  removed ljmp by inverse jump logic
   052B 20 92 16           1274 	jb      _P1_2,00120$
   052E                    1275 00150$:
                           1276 ;src/keypad.c:262: T2_count++;
                           1277 ;     genPlus
                           1278 ;     genPlusIncr
   052E 05 28              1279 	inc	_T2_count
   0530 E4                 1280 	clr	a
   0531 B5 28 02           1281 	cjne	a,_T2_count,00151$
   0534 05 29              1282 	inc	(_T2_count + 1)
   0536                    1283 00151$:
                           1284 ;src/keypad.c:263: if (T2_count == 0x8000)
                           1285 ;     genCmpEq
   0536 E5 28              1286 	mov	a,_T2_count
                           1287 ;       Peephole 112.b  changed ljmp to sjmp
                           1288 ;       Peephole 197.a  optimized misc jump sequence
   0538 70 F1              1289 	jnz     00118$
   053A E5 29              1290 	mov     a,(_T2_count + 1)
   053C B4 80 EC           1291 	cjne    a,#0x80,00118$
                           1292 ;00152$:     
                           1293 ;       Peephole 200    removed redundant sjmp
   053F                    1294 00153$:
                           1295 ;src/keypad.c:264: return 0;
                           1296 ;     genRet
                           1297 ;       Peephole 182.b  used 16 bit load of dptr
   053F 90 00 00           1298 	mov     dptr,#0x0000
                           1299 ;       Peephole 112.b  changed ljmp to sjmp
   0542 80 6E              1300 	sjmp    00123$
   0544                    1301 00120$:
                           1302 ;src/keypad.c:267: if (T2_count != 0)
                           1303 ;     genCmpEq
   0544 E5 28              1304 	mov	a,_T2_count
   0546 70 04              1305 	jnz	00154$
   0548 E5 29              1306 	mov	a,(_T2_count + 1)
                           1307 ;       Peephole 110    removed ljmp by inverse jump logic
   054A 60 62              1308 	jz      00122$
   054C                    1309 00154$:
                           1310 ;src/keypad.c:274: result = (unsigned int)235L-((400L*T1_count)/T2_count);
                           1311 ;     genCast
   054C AC 26              1312 	mov	r4,_T1_count
   054E AD 27              1313 	mov	r5,(_T1_count + 1)
   0550 7E 00              1314 	mov	r6,#0x00
   0552 7F 00              1315 	mov	r7,#0x00
                           1316 ;     genAssign
   0554 75 42 90           1317 	mov	__mullong_PARM_2,#0x90
   0557 75 43 01           1318 	mov	(__mullong_PARM_2 + 1),#0x01
   055A 75 44 00           1319 	mov	(__mullong_PARM_2 + 2),#0x00
   055D 75 45 00           1320 	mov	(__mullong_PARM_2 + 3),#0x00
                           1321 ;     genCall
   0560 8C 82              1322 	mov	dpl,r4
   0562 8D 83              1323 	mov	dph,r5
   0564 8E F0              1324 	mov	b,r6
   0566 EF                 1325 	mov	a,r7
   0567 12 70 BF           1326 	lcall	__mullong
                           1327 ;     genCast
                           1328 ;     genCall
   056A AC 82              1329 	mov     r4,dpl
   056C AD 83              1330 	mov     r5,dph
   056E AE F0              1331 	mov     r6,b
   0570 FF                 1332 	mov     r7,a
   0571 85 28 42           1333 	mov     __divslong_PARM_2,_T2_count
   0574 85 29 43           1334 	mov     (__divslong_PARM_2 + 1),(_T2_count + 1)
   0577 75 44 00           1335 	mov     (__divslong_PARM_2 + 2),#0x00
   057A 75 45 00           1336 	mov     (__divslong_PARM_2 + 3),#0x00
                           1337 ;       Peephole 238.a  removed 4 redundant moves
   057D 12 71 7A           1338 	lcall	__divslong
   0580 AC 82              1339 	mov	r4,dpl
   0582 AD 83              1340 	mov	r5,dph
   0584 AE F0              1341 	mov	r6,b
   0586 FF                 1342 	mov	r7,a
                           1343 ;     genMinus
   0587 74 EB              1344 	mov	a,#0xEB
   0589 C3                 1345 	clr	c
                           1346 ;       Peephole 236.l  used r4 instead of ar4
   058A 9C                 1347 	subb    a,r4
   058B FC                 1348 	mov	r4,a
                           1349 ;       Peephole 181    changed mov to clr
   058C E4                 1350 	clr     a
                           1351 ;       Peephole 236.l  used r5 instead of ar5
   058D 9D                 1352 	subb    a,r5
   058E FD                 1353 	mov	r5,a
                           1354 ;       Peephole 181    changed mov to clr
   058F E4                 1355 	clr     a
                           1356 ;       Peephole 236.l  used r6 instead of ar6
   0590 9E                 1357 	subb    a,r6
   0591 FE                 1358 	mov	r6,a
                           1359 ;       Peephole 181    changed mov to clr
   0592 E4                 1360 	clr     a
                           1361 ;       Peephole 236.l  used r7 instead of ar7
   0593 9F                 1362 	subb    a,r7
   0594 FF                 1363 	mov	r7,a
                           1364 ;     genCast
   0595 8C 02              1365 	mov	ar2,r4
   0597 8D 03              1366 	mov	ar3,r5
                           1367 ;src/keypad.c:275: result *= 10;
                           1368 ;     genAssign
   0599 E4                 1369 	clr	a
   059A F5 43              1370 	mov	(__mulint_PARM_2 + 1),a
   059C 75 42 0A           1371 	mov	__mulint_PARM_2,#0x0A
                           1372 ;     genCall
   059F 8A 82              1373 	mov	dpl,r2
   05A1 8B 83              1374 	mov	dph,r3
   05A3 12 70 A2           1375 	lcall	__mulint
   05A6 AC 82              1376 	mov	r4,dpl
   05A8 AD 83              1377 	mov	r5,dph
                           1378 ;     genAssign
   05AA 8C 02              1379 	mov	ar2,r4
   05AC 8D 03              1380 	mov	ar3,r5
   05AE                    1381 00122$:
                           1382 ;src/keypad.c:279: return result;
                           1383 ;     genRet
   05AE 8A 82              1384 	mov	dpl,r2
   05B0 8B 83              1385 	mov	dph,r3
   05B2                    1386 00123$:
   05B2 85 40 81           1387 	mov	sp,_bp
   05B5 D0 40              1388 	pop	_bp
   05B7 22                 1389 	ret
                           1390 ;------------------------------------------------------------
                           1391 ;Allocation info for local variables in function 'read_zone_temp_4'
                           1392 ;------------------------------------------------------------
                           1393 ;result                    Allocated to registers r2 r3 
                           1394 ;------------------------------------------------------------
                           1395 ;src/keypad.c:281: unsigned int read_zone_temp_4()
                           1396 ;	-----------------------------------------
                           1397 ;	 function read_zone_temp_4
                           1398 ;	-----------------------------------------
   05B8                    1399 _read_zone_temp_4:
   05B8 C0 40              1400 	push	_bp
   05BA 85 81 40           1401 	mov	_bp,sp
                           1402 ;src/keypad.c:283: unsigned int result = 0;
                           1403 ;     genAssign
   05BD 7A 00              1404 	mov	r2,#0x00
                           1405 ;src/keypad.c:285: T1_count=0;
                           1406 ;     genAssign
                           1407 ;       Peephole 3.b    changed mov to clr
   05BF E4                 1408 	clr     a
   05C0 FB                 1409 	mov     r3,a
   05C1 F5 27              1410 	mov	(_T1_count + 1),a
   05C3 F5 26              1411 	mov	_T1_count,a
                           1412 ;src/keypad.c:286: T2_count=0;
                           1413 ;     genAssign
   05C5 E4                 1414 	clr	a
   05C6 F5 29              1415 	mov	(_T2_count + 1),a
   05C8 F5 28              1416 	mov	_T2_count,a
                           1417 ;src/keypad.c:289: while( SENSOR_ZONE_4 )
   05CA                    1418 00103$:
                           1419 ;     genIfx
                           1420 ;     genIfxJump
                           1421 ;       Peephole 111    removed ljmp by inverse jump logic
   05CA 30 80 17           1422 	jnb     _P0_0,00108$
   05CD                    1423 00138$:
                           1424 ;src/keypad.c:291: if (++T2_count == 0x8000)
                           1425 ;     genPlus
                           1426 ;     genPlusIncr
   05CD 05 28              1427 	inc	_T2_count
   05CF E4                 1428 	clr	a
   05D0 B5 28 02           1429 	cjne	a,_T2_count,00139$
   05D3 05 29              1430 	inc	(_T2_count + 1)
   05D5                    1431 00139$:
                           1432 ;     genCmpEq
   05D5 E5 28              1433 	mov	a,_T2_count
                           1434 ;       Peephole 112.b  changed ljmp to sjmp
                           1435 ;       Peephole 197.a  optimized misc jump sequence
   05D7 70 F1              1436 	jnz     00103$
   05D9 E5 29              1437 	mov     a,(_T2_count + 1)
   05DB B4 80 EC           1438 	cjne    a,#0x80,00103$
                           1439 ;00140$:     
                           1440 ;       Peephole 200    removed redundant sjmp
   05DE                    1441 00141$:
                           1442 ;src/keypad.c:292: return 0;
                           1443 ;     genRet
                           1444 ;       Peephole 182.b  used 16 bit load of dptr
   05DE 90 00 00           1445 	mov     dptr,#0x0000
   05E1 02 06 A9           1446 	ljmp	00123$
                           1447 ;src/keypad.c:296: while( !SENSOR_ZONE_4 )
   05E4                    1448 00108$:
                           1449 ;     genIfx
                           1450 ;     genIfxJump
                           1451 ;       Peephole 112.a  removed ljmp by inverse jump logic
   05E4 20 80 17           1452 	jb      _P0_0,00110$
   05E7                    1453 00142$:
                           1454 ;src/keypad.c:298: if (++T2_count == 0x8000)
                           1455 ;     genPlus
                           1456 ;     genPlusIncr
   05E7 05 28              1457 	inc	_T2_count
   05E9 E4                 1458 	clr	a
   05EA B5 28 02           1459 	cjne	a,_T2_count,00143$
   05ED 05 29              1460 	inc	(_T2_count + 1)
   05EF                    1461 00143$:
                           1462 ;     genCmpEq
   05EF E5 28              1463 	mov	a,_T2_count
                           1464 ;       Peephole 112.b  changed ljmp to sjmp
                           1465 ;       Peephole 197.a  optimized misc jump sequence
   05F1 70 F1              1466 	jnz     00108$
   05F3 E5 29              1467 	mov     a,(_T2_count + 1)
   05F5 B4 80 EC           1468 	cjne    a,#0x80,00108$
                           1469 ;00144$:     
                           1470 ;       Peephole 200    removed redundant sjmp
   05F8                    1471 00145$:
                           1472 ;src/keypad.c:299: return 0;
                           1473 ;     genRet
                           1474 ;       Peephole 182.b  used 16 bit load of dptr
   05F8 90 00 00           1475 	mov     dptr,#0x0000
   05FB 02 06 A9           1476 	ljmp	00123$
   05FE                    1477 00110$:
                           1478 ;src/keypad.c:302: T1_count=0;
                           1479 ;     genAssign
   05FE E4                 1480 	clr	a
   05FF F5 27              1481 	mov	(_T1_count + 1),a
   0601 F5 26              1482 	mov	_T1_count,a
                           1483 ;src/keypad.c:303: T2_count=0;
                           1484 ;     genAssign
   0603 E4                 1485 	clr	a
   0604 F5 29              1486 	mov	(_T2_count + 1),a
   0606 F5 28              1487 	mov	_T2_count,a
                           1488 ;src/keypad.c:306: while( SENSOR_ZONE_4 )
   0608                    1489 00113$:
                           1490 ;     genIfx
                           1491 ;     genIfxJump
                           1492 ;       Peephole 111    removed ljmp by inverse jump logic
   0608 30 80 17           1493 	jnb     _P0_0,00118$
   060B                    1494 00146$:
                           1495 ;src/keypad.c:309: T1_count++;
                           1496 ;     genPlus
                           1497 ;     genPlusIncr
   060B 05 26              1498 	inc	_T1_count
   060D E4                 1499 	clr	a
   060E B5 26 02           1500 	cjne	a,_T1_count,00147$
   0611 05 27              1501 	inc	(_T1_count + 1)
   0613                    1502 00147$:
                           1503 ;src/keypad.c:310: if (T1_count == 0x8000)
                           1504 ;     genCmpEq
   0613 E5 26              1505 	mov	a,_T1_count
                           1506 ;       Peephole 112.b  changed ljmp to sjmp
                           1507 ;       Peephole 197.a  optimized misc jump sequence
   0615 70 F1              1508 	jnz     00113$
   0617 E5 27              1509 	mov     a,(_T1_count + 1)
   0619 B4 80 EC           1510 	cjne    a,#0x80,00113$
                           1511 ;00148$:     
                           1512 ;       Peephole 200    removed redundant sjmp
   061C                    1513 00149$:
                           1514 ;src/keypad.c:311: return 0;
                           1515 ;     genRet
                           1516 ;       Peephole 182.b  used 16 bit load of dptr
   061C 90 00 00           1517 	mov     dptr,#0x0000
   061F 02 06 A9           1518 	ljmp	00123$
                           1519 ;src/keypad.c:315: while( !SENSOR_ZONE_4 )
   0622                    1520 00118$:
                           1521 ;     genIfx
                           1522 ;     genIfxJump
                           1523 ;       Peephole 112.a  removed ljmp by inverse jump logic
   0622 20 80 16           1524 	jb      _P0_0,00120$
   0625                    1525 00150$:
                           1526 ;src/keypad.c:317: T2_count++;
                           1527 ;     genPlus
                           1528 ;     genPlusIncr
   0625 05 28              1529 	inc	_T2_count
   0627 E4                 1530 	clr	a
   0628 B5 28 02           1531 	cjne	a,_T2_count,00151$
   062B 05 29              1532 	inc	(_T2_count + 1)
   062D                    1533 00151$:
                           1534 ;src/keypad.c:318: if (T2_count == 0x8000)
                           1535 ;     genCmpEq
   062D E5 28              1536 	mov	a,_T2_count
                           1537 ;       Peephole 112.b  changed ljmp to sjmp
                           1538 ;       Peephole 197.a  optimized misc jump sequence
   062F 70 F1              1539 	jnz     00118$
   0631 E5 29              1540 	mov     a,(_T2_count + 1)
   0633 B4 80 EC           1541 	cjne    a,#0x80,00118$
                           1542 ;00152$:     
                           1543 ;       Peephole 200    removed redundant sjmp
   0636                    1544 00153$:
                           1545 ;src/keypad.c:319: return 0;
                           1546 ;     genRet
                           1547 ;       Peephole 182.b  used 16 bit load of dptr
   0636 90 00 00           1548 	mov     dptr,#0x0000
                           1549 ;       Peephole 112.b  changed ljmp to sjmp
   0639 80 6E              1550 	sjmp    00123$
   063B                    1551 00120$:
                           1552 ;src/keypad.c:322: if (T2_count != 0)
                           1553 ;     genCmpEq
   063B E5 28              1554 	mov	a,_T2_count
   063D 70 04              1555 	jnz	00154$
   063F E5 29              1556 	mov	a,(_T2_count + 1)
                           1557 ;       Peephole 110    removed ljmp by inverse jump logic
   0641 60 62              1558 	jz      00122$
   0643                    1559 00154$:
                           1560 ;src/keypad.c:329: result = (unsigned int)235L-((400L*T1_count)/T2_count);
                           1561 ;     genCast
   0643 AC 26              1562 	mov	r4,_T1_count
   0645 AD 27              1563 	mov	r5,(_T1_count + 1)
   0647 7E 00              1564 	mov	r6,#0x00
   0649 7F 00              1565 	mov	r7,#0x00
                           1566 ;     genAssign
   064B 75 42 90           1567 	mov	__mullong_PARM_2,#0x90
   064E 75 43 01           1568 	mov	(__mullong_PARM_2 + 1),#0x01
   0651 75 44 00           1569 	mov	(__mullong_PARM_2 + 2),#0x00
   0654 75 45 00           1570 	mov	(__mullong_PARM_2 + 3),#0x00
                           1571 ;     genCall
   0657 8C 82              1572 	mov	dpl,r4
   0659 8D 83              1573 	mov	dph,r5
   065B 8E F0              1574 	mov	b,r6
   065D EF                 1575 	mov	a,r7
   065E 12 70 BF           1576 	lcall	__mullong
                           1577 ;     genCast
                           1578 ;     genCall
   0661 AC 82              1579 	mov     r4,dpl
   0663 AD 83              1580 	mov     r5,dph
   0665 AE F0              1581 	mov     r6,b
   0667 FF                 1582 	mov     r7,a
   0668 85 28 42           1583 	mov     __divslong_PARM_2,_T2_count
   066B 85 29 43           1584 	mov     (__divslong_PARM_2 + 1),(_T2_count + 1)
   066E 75 44 00           1585 	mov     (__divslong_PARM_2 + 2),#0x00
   0671 75 45 00           1586 	mov     (__divslong_PARM_2 + 3),#0x00
                           1587 ;       Peephole 238.a  removed 4 redundant moves
   0674 12 71 7A           1588 	lcall	__divslong
   0677 AC 82              1589 	mov	r4,dpl
   0679 AD 83              1590 	mov	r5,dph
   067B AE F0              1591 	mov	r6,b
   067D FF                 1592 	mov	r7,a
                           1593 ;     genMinus
   067E 74 EB              1594 	mov	a,#0xEB
   0680 C3                 1595 	clr	c
                           1596 ;       Peephole 236.l  used r4 instead of ar4
   0681 9C                 1597 	subb    a,r4
   0682 FC                 1598 	mov	r4,a
                           1599 ;       Peephole 181    changed mov to clr
   0683 E4                 1600 	clr     a
                           1601 ;       Peephole 236.l  used r5 instead of ar5
   0684 9D                 1602 	subb    a,r5
   0685 FD                 1603 	mov	r5,a
                           1604 ;       Peephole 181    changed mov to clr
   0686 E4                 1605 	clr     a
                           1606 ;       Peephole 236.l  used r6 instead of ar6
   0687 9E                 1607 	subb    a,r6
   0688 FE                 1608 	mov	r6,a
                           1609 ;       Peephole 181    changed mov to clr
   0689 E4                 1610 	clr     a
                           1611 ;       Peephole 236.l  used r7 instead of ar7
   068A 9F                 1612 	subb    a,r7
   068B FF                 1613 	mov	r7,a
                           1614 ;     genCast
   068C 8C 02              1615 	mov	ar2,r4
   068E 8D 03              1616 	mov	ar3,r5
                           1617 ;src/keypad.c:330: result *= 10;
                           1618 ;     genAssign
   0690 E4                 1619 	clr	a
   0691 F5 43              1620 	mov	(__mulint_PARM_2 + 1),a
   0693 75 42 0A           1621 	mov	__mulint_PARM_2,#0x0A
                           1622 ;     genCall
   0696 8A 82              1623 	mov	dpl,r2
   0698 8B 83              1624 	mov	dph,r3
   069A 12 70 A2           1625 	lcall	__mulint
   069D AC 82              1626 	mov	r4,dpl
   069F AD 83              1627 	mov	r5,dph
                           1628 ;     genAssign
   06A1 8C 02              1629 	mov	ar2,r4
   06A3 8D 03              1630 	mov	ar3,r5
   06A5                    1631 00122$:
                           1632 ;src/keypad.c:334: return result;
                           1633 ;     genRet
   06A5 8A 82              1634 	mov	dpl,r2
   06A7 8B 83              1635 	mov	dph,r3
   06A9                    1636 00123$:
   06A9 85 40 81           1637 	mov	sp,_bp
   06AC D0 40              1638 	pop	_bp
   06AE 22                 1639 	ret
                           1640 ;------------------------------------------------------------
                           1641 ;Allocation info for local variables in function 'timer0_interrupt'
                           1642 ;------------------------------------------------------------
                           1643 ;input_value               Allocated to registers r3 
                           1644 ;key_code                  Allocated to registers r4 
                           1645 ;empty                     Allocated to registers r2 
                           1646 ;counter                   Allocated with name '_timer0_interrupt_counter_1_1'
                           1647 ;------------------------------------------------------------
                           1648 ;src/keypad.c:345: void timer0_interrupt(void) interrupt TF0_VECTOR using 0
                           1649 ;	-----------------------------------------
                           1650 ;	 function timer0_interrupt
                           1651 ;	-----------------------------------------
   06AF                    1652 _timer0_interrupt:
   06AF C0 E0              1653 	push	acc
   06B1 C0 F0              1654 	push	b
   06B3 C0 82              1655 	push	dpl
   06B5 C0 83              1656 	push	dph
   06B7 C0 02              1657 	push	(0+2)
   06B9 C0 03              1658 	push	(0+3)
   06BB C0 04              1659 	push	(0+4)
   06BD C0 05              1660 	push	(0+5)
   06BF C0 06              1661 	push	(0+6)
   06C1 C0 07              1662 	push	(0+7)
   06C3 C0 00              1663 	push	(0+0)
   06C5 C0 01              1664 	push	(0+1)
   06C7 C0 D0              1665 	push	psw
   06C9 75 D0 00           1666 	mov	psw,#0x00
   06CC C0 40              1667 	push	_bp
   06CE 85 81 40           1668 	mov	_bp,sp
                           1669 ;src/keypad.c:353: delay_counter++;
                           1670 ;     genPlus
                           1671 ;     genPlusIncr
   06D1 05 2B              1672 	inc	_delay_counter
                           1673 ;src/keypad.c:354: if (delay_counter == 64)
                           1674 ;     genCmpEq
   06D3 E5 2B              1675 	mov	a,_delay_counter
                           1676 ;       Peephole 112.b  changed ljmp to sjmp
                           1677 ;       Peephole 199    optimized misc jump sequence
   06D5 B4 40 0F           1678 	cjne    a,#0x40,00102$
                           1679 ;00172$:
                           1680 ;       Peephole 200    removed redundant sjmp
   06D8                    1681 00173$:
                           1682 ;src/keypad.c:356: system_data.temperatures[0] = read_zone_temp_1();
                           1683 ;     genCall
   06D8 12 02 D3           1684 	lcall	_read_zone_temp_1
   06DB AA 82              1685 	mov	r2,dpl
   06DD AB 83              1686 	mov	r3,dph
                           1687 ;     genPointerSet
                           1688 ;     genFarPointerSet
   06DF 90 01 79           1689 	mov	dptr,#(_system_data + 0x016c)
   06E2 EA                 1690 	mov	a,r2
   06E3 F0                 1691 	movx	@dptr,a
   06E4 A3                 1692 	inc	dptr
   06E5 EB                 1693 	mov	a,r3
   06E6 F0                 1694 	movx	@dptr,a
   06E7                    1695 00102$:
                           1696 ;src/keypad.c:358: if (delay_counter == 128)
                           1697 ;     genCmpEq
   06E7 E5 2B              1698 	mov	a,_delay_counter
                           1699 ;       Peephole 112.b  changed ljmp to sjmp
                           1700 ;       Peephole 199    optimized misc jump sequence
   06E9 B4 80 0F           1701 	cjne    a,#0x80,00104$
                           1702 ;00174$:
                           1703 ;       Peephole 200    removed redundant sjmp
   06EC                    1704 00175$:
                           1705 ;src/keypad.c:360: system_data.temperatures[1] = read_zone_temp_2();
                           1706 ;     genCall
   06EC 12 03 CA           1707 	lcall	_read_zone_temp_2
   06EF AA 82              1708 	mov	r2,dpl
   06F1 AB 83              1709 	mov	r3,dph
                           1710 ;     genPointerSet
                           1711 ;     genFarPointerSet
   06F3 90 01 7B           1712 	mov	dptr,#(_system_data + 0x016e)
   06F6 EA                 1713 	mov	a,r2
   06F7 F0                 1714 	movx	@dptr,a
   06F8 A3                 1715 	inc	dptr
   06F9 EB                 1716 	mov	a,r3
   06FA F0                 1717 	movx	@dptr,a
   06FB                    1718 00104$:
                           1719 ;src/keypad.c:362: if (delay_counter == 192)
                           1720 ;     genCmpEq
   06FB E5 2B              1721 	mov	a,_delay_counter
                           1722 ;       Peephole 112.b  changed ljmp to sjmp
                           1723 ;       Peephole 199    optimized misc jump sequence
   06FD B4 C0 0F           1724 	cjne    a,#0xC0,00106$
                           1725 ;00176$:
                           1726 ;       Peephole 200    removed redundant sjmp
   0700                    1727 00177$:
                           1728 ;src/keypad.c:364: system_data.temperatures[2] = read_zone_temp_3();
                           1729 ;     genCall
   0700 12 04 C1           1730 	lcall	_read_zone_temp_3
   0703 AA 82              1731 	mov	r2,dpl
   0705 AB 83              1732 	mov	r3,dph
                           1733 ;     genPointerSet
                           1734 ;     genFarPointerSet
   0707 90 01 7D           1735 	mov	dptr,#(_system_data + 0x0170)
   070A EA                 1736 	mov	a,r2
   070B F0                 1737 	movx	@dptr,a
   070C A3                 1738 	inc	dptr
   070D EB                 1739 	mov	a,r3
   070E F0                 1740 	movx	@dptr,a
   070F                    1741 00106$:
                           1742 ;src/keypad.c:366: if (delay_counter == 255)
                           1743 ;     genCmpEq
   070F E5 2B              1744 	mov	a,_delay_counter
                           1745 ;       Peephole 112.b  changed ljmp to sjmp
                           1746 ;       Peephole 199    optimized misc jump sequence
   0711 B4 FF 0F           1747 	cjne    a,#0xFF,00108$
                           1748 ;00178$:
                           1749 ;       Peephole 200    removed redundant sjmp
   0714                    1750 00179$:
                           1751 ;src/keypad.c:368: system_data.temperatures[3] = read_zone_temp_4();
                           1752 ;     genCall
   0714 12 05 B8           1753 	lcall	_read_zone_temp_4
   0717 AA 82              1754 	mov	r2,dpl
   0719 AB 83              1755 	mov	r3,dph
                           1756 ;     genPointerSet
                           1757 ;     genFarPointerSet
   071B 90 01 7F           1758 	mov	dptr,#(_system_data + 0x0172)
   071E EA                 1759 	mov	a,r2
   071F F0                 1760 	movx	@dptr,a
   0720 A3                 1761 	inc	dptr
   0721 EB                 1762 	mov	a,r3
   0722 F0                 1763 	movx	@dptr,a
   0723                    1764 00108$:
                           1765 ;src/keypad.c:371: if (blinking == TRUE)
                           1766 ;     genCmpEq
   0723 E5 30              1767 	mov	a,_blinking
   0725 B4 01 02           1768 	cjne	a,#0x01,00180$
   0728 80 03              1769 	sjmp	00181$
   072A                    1770 00180$:
   072A 02 08 9C           1771 	ljmp	00118$
   072D                    1772 00181$:
                           1773 ;src/keypad.c:373: blink_counter++;
                           1774 ;     genPlus
                           1775 ;     genPlusIncr
   072D 05 2A              1776 	inc	_blink_counter
                           1777 ;src/keypad.c:374: if (blink_counter == 30)
                           1778 ;     genCmpEq
   072F E5 2A              1779 	mov	a,_blink_counter
   0731 B4 1E 02           1780 	cjne	a,#0x1E,00182$
   0734 80 03              1781 	sjmp	00183$
   0736                    1782 00182$:
   0736 02 07 E5           1783 	ljmp	00112$
   0739                    1784 00183$:
                           1785 ;src/keypad.c:376: lcd_goto_xy(current_blink_params->position, 0);
                           1786 ;     genAssign
   0739 AA 2D              1787 	mov	r2,_current_blink_params
   073B AB 2E              1788 	mov	r3,(_current_blink_params + 1)
   073D AC 2F              1789 	mov	r4,(_current_blink_params + 2)
                           1790 ;     genPointerGet
                           1791 ;     genGenPointerGet
   073F 8A 82              1792 	mov	dpl,r2
   0741 8B 83              1793 	mov	dph,r3
   0743 8C F0              1794 	mov	b,r4
   0745 12 71 F5           1795 	lcall	__gptrget
   0748 FA                 1796 	mov	r2,a
                           1797 ;     genIpush
                           1798 ;       Peephole 181    changed mov to clr
   0749 E4                 1799 	clr     a
   074A C0 E0              1800 	push	acc
                           1801 ;     genCall
   074C 8A 82              1802 	mov	dpl,r2
   074E 12 0A CD           1803 	lcall	_lcd_goto_xy
   0751 15 81              1804 	dec	sp
                           1805 ;src/keypad.c:377: lcd_put_string(current_blink_params->first_pattern_off);
                           1806 ;     genAssign
   0753 AA 2D              1807 	mov	r2,_current_blink_params
   0755 AB 2E              1808 	mov	r3,(_current_blink_params + 1)
   0757 AC 2F              1809 	mov	r4,(_current_blink_params + 2)
                           1810 ;     genPlus
                           1811 ;     genPlusIncr
   0759 74 04              1812 	mov	a,#0x04
                           1813 ;       Peephole 236.a  used r2 instead of ar2
   075B 2A                 1814 	add     a,r2
   075C FA                 1815 	mov	r2,a
                           1816 ;       Peephole 181    changed mov to clr
   075D E4                 1817 	clr     a
                           1818 ;       Peephole 236.b  used r3 instead of ar3
   075E 3B                 1819 	addc    a,r3
   075F FB                 1820 	mov	r3,a
                           1821 ;     genPointerGet
                           1822 ;     genGenPointerGet
   0760 8A 82              1823 	mov	dpl,r2
   0762 8B 83              1824 	mov	dph,r3
   0764 8C F0              1825 	mov	b,r4
   0766 12 71 F5           1826 	lcall	__gptrget
   0769 FA                 1827 	mov	r2,a
   076A A3                 1828 	inc	dptr
   076B 12 71 F5           1829 	lcall	__gptrget
   076E FB                 1830 	mov	r3,a
   076F A3                 1831 	inc	dptr
   0770 12 71 F5           1832 	lcall	__gptrget
   0773 FC                 1833 	mov	r4,a
                           1834 ;     genCall
   0774 8A 82              1835 	mov	dpl,r2
   0776 8B 83              1836 	mov	dph,r3
   0778 8C F0              1837 	mov	b,r4
   077A 12 0B B6           1838 	lcall	_lcd_put_string
                           1839 ;src/keypad.c:379: if (current_blink_params->lines > 1)
                           1840 ;     genAssign
   077D AA 2D              1841 	mov	r2,_current_blink_params
   077F AB 2E              1842 	mov	r3,(_current_blink_params + 1)
   0781 AC 2F              1843 	mov	r4,(_current_blink_params + 2)
                           1844 ;     genPlus
   0783 74 0D              1845 	mov	a,#0x0D
                           1846 ;       Peephole 236.a  used r2 instead of ar2
   0785 2A                 1847 	add     a,r2
   0786 FA                 1848 	mov	r2,a
                           1849 ;       Peephole 181    changed mov to clr
   0787 E4                 1850 	clr     a
                           1851 ;       Peephole 236.b  used r3 instead of ar3
   0788 3B                 1852 	addc    a,r3
   0789 FB                 1853 	mov	r3,a
                           1854 ;     genPointerGet
                           1855 ;     genGenPointerGet
   078A 8A 82              1856 	mov	dpl,r2
   078C 8B 83              1857 	mov	dph,r3
   078E 8C F0              1858 	mov	b,r4
   0790 12 71 F5           1859 	lcall	__gptrget
   0793 FA                 1860 	mov	r2,a
                           1861 ;     genCmpGt
                           1862 ;     genCmp
   0794 C3                 1863 	clr	c
                           1864 ;       Peephole 159    avoided xrl during execution
   0795 74 81              1865 	mov  a,#(0x01 ^ 0x80)
   0797 8A F0              1866 	mov	b,r2
   0799 63 F0 80           1867 	xrl	b,#0x80
   079C 95 F0              1868 	subb	a,b
                           1869 ;     genIfxJump
                           1870 ;       Peephole 108    removed ljmp by inverse jump logic
   079E 50 45              1871 	jnc     00112$
   07A0                    1872 00184$:
                           1873 ;src/keypad.c:381: lcd_goto_xy(current_blink_params->position, 2);
                           1874 ;     genAssign
   07A0 AA 2D              1875 	mov	r2,_current_blink_params
   07A2 AB 2E              1876 	mov	r3,(_current_blink_params + 1)
   07A4 AC 2F              1877 	mov	r4,(_current_blink_params + 2)
                           1878 ;     genPointerGet
                           1879 ;     genGenPointerGet
   07A6 8A 82              1880 	mov	dpl,r2
   07A8 8B 83              1881 	mov	dph,r3
   07AA 8C F0              1882 	mov	b,r4
   07AC 12 71 F5           1883 	lcall	__gptrget
   07AF FA                 1884 	mov	r2,a
                           1885 ;     genIpush
   07B0 74 02              1886 	mov	a,#0x02
   07B2 C0 E0              1887 	push	acc
                           1888 ;     genCall
   07B4 8A 82              1889 	mov	dpl,r2
   07B6 12 0A CD           1890 	lcall	_lcd_goto_xy
   07B9 15 81              1891 	dec	sp
                           1892 ;src/keypad.c:382: lcd_put_string(current_blink_params->second_pattern_off);
                           1893 ;     genAssign
   07BB AA 2D              1894 	mov	r2,_current_blink_params
   07BD AB 2E              1895 	mov	r3,(_current_blink_params + 1)
   07BF AC 2F              1896 	mov	r4,(_current_blink_params + 2)
                           1897 ;     genPlus
   07C1 74 0A              1898 	mov	a,#0x0A
                           1899 ;       Peephole 236.a  used r2 instead of ar2
   07C3 2A                 1900 	add     a,r2
   07C4 FA                 1901 	mov	r2,a
                           1902 ;       Peephole 181    changed mov to clr
   07C5 E4                 1903 	clr     a
                           1904 ;       Peephole 236.b  used r3 instead of ar3
   07C6 3B                 1905 	addc    a,r3
   07C7 FB                 1906 	mov	r3,a
                           1907 ;     genPointerGet
                           1908 ;     genGenPointerGet
   07C8 8A 82              1909 	mov	dpl,r2
   07CA 8B 83              1910 	mov	dph,r3
   07CC 8C F0              1911 	mov	b,r4
   07CE 12 71 F5           1912 	lcall	__gptrget
   07D1 FA                 1913 	mov	r2,a
   07D2 A3                 1914 	inc	dptr
   07D3 12 71 F5           1915 	lcall	__gptrget
   07D6 FB                 1916 	mov	r3,a
   07D7 A3                 1917 	inc	dptr
   07D8 12 71 F5           1918 	lcall	__gptrget
   07DB FC                 1919 	mov	r4,a
                           1920 ;     genCall
   07DC 8A 82              1921 	mov	dpl,r2
   07DE 8B 83              1922 	mov	dph,r3
   07E0 8C F0              1923 	mov	b,r4
   07E2 12 0B B6           1924 	lcall	_lcd_put_string
   07E5                    1925 00112$:
                           1926 ;src/keypad.c:385: if (blink_counter == 60)
                           1927 ;     genCmpEq
   07E5 E5 2A              1928 	mov	a,_blink_counter
   07E7 B4 3C 02           1929 	cjne	a,#0x3C,00185$
   07EA 80 03              1930 	sjmp	00186$
   07EC                    1931 00185$:
   07EC 02 08 9C           1932 	ljmp	00118$
   07EF                    1933 00186$:
                           1934 ;src/keypad.c:387: lcd_goto_xy(current_blink_params->position, 0);
                           1935 ;     genAssign
   07EF AA 2D              1936 	mov	r2,_current_blink_params
   07F1 AB 2E              1937 	mov	r3,(_current_blink_params + 1)
   07F3 AC 2F              1938 	mov	r4,(_current_blink_params + 2)
                           1939 ;     genPointerGet
                           1940 ;     genGenPointerGet
   07F5 8A 82              1941 	mov	dpl,r2
   07F7 8B 83              1942 	mov	dph,r3
   07F9 8C F0              1943 	mov	b,r4
   07FB 12 71 F5           1944 	lcall	__gptrget
   07FE FA                 1945 	mov	r2,a
                           1946 ;     genIpush
                           1947 ;       Peephole 181    changed mov to clr
   07FF E4                 1948 	clr     a
   0800 C0 E0              1949 	push	acc
                           1950 ;     genCall
   0802 8A 82              1951 	mov	dpl,r2
   0804 12 0A CD           1952 	lcall	_lcd_goto_xy
   0807 15 81              1953 	dec	sp
                           1954 ;src/keypad.c:388: lcd_put_string(current_blink_params->first_pattern_on);
                           1955 ;     genAssign
   0809 AA 2D              1956 	mov	r2,_current_blink_params
   080B AB 2E              1957 	mov	r3,(_current_blink_params + 1)
   080D AC 2F              1958 	mov	r4,(_current_blink_params + 2)
                           1959 ;     genPlus
                           1960 ;     genPlusIncr
   080F 0A                 1961 	inc	r2
   0810 BA 00 01           1962 	cjne	r2,#0x00,00187$
   0813 0B                 1963 	inc	r3
   0814                    1964 00187$:
                           1965 ;     genPointerGet
                           1966 ;     genGenPointerGet
   0814 8A 82              1967 	mov	dpl,r2
   0816 8B 83              1968 	mov	dph,r3
   0818 8C F0              1969 	mov	b,r4
   081A 12 71 F5           1970 	lcall	__gptrget
   081D FA                 1971 	mov	r2,a
   081E A3                 1972 	inc	dptr
   081F 12 71 F5           1973 	lcall	__gptrget
   0822 FB                 1974 	mov	r3,a
   0823 A3                 1975 	inc	dptr
   0824 12 71 F5           1976 	lcall	__gptrget
   0827 FC                 1977 	mov	r4,a
                           1978 ;     genCall
   0828 8A 82              1979 	mov	dpl,r2
   082A 8B 83              1980 	mov	dph,r3
   082C 8C F0              1981 	mov	b,r4
   082E 12 0B B6           1982 	lcall	_lcd_put_string
                           1983 ;src/keypad.c:390: if (current_blink_params->lines > 1)
                           1984 ;     genAssign
   0831 AA 2D              1985 	mov	r2,_current_blink_params
   0833 AB 2E              1986 	mov	r3,(_current_blink_params + 1)
   0835 AC 2F              1987 	mov	r4,(_current_blink_params + 2)
                           1988 ;     genPlus
   0837 74 0D              1989 	mov	a,#0x0D
                           1990 ;       Peephole 236.a  used r2 instead of ar2
   0839 2A                 1991 	add     a,r2
   083A FA                 1992 	mov	r2,a
                           1993 ;       Peephole 181    changed mov to clr
   083B E4                 1994 	clr     a
                           1995 ;       Peephole 236.b  used r3 instead of ar3
   083C 3B                 1996 	addc    a,r3
   083D FB                 1997 	mov	r3,a
                           1998 ;     genPointerGet
                           1999 ;     genGenPointerGet
   083E 8A 82              2000 	mov	dpl,r2
   0840 8B 83              2001 	mov	dph,r3
   0842 8C F0              2002 	mov	b,r4
   0844 12 71 F5           2003 	lcall	__gptrget
   0847 FA                 2004 	mov	r2,a
                           2005 ;     genCmpGt
                           2006 ;     genCmp
   0848 C3                 2007 	clr	c
                           2008 ;       Peephole 159    avoided xrl during execution
   0849 74 81              2009 	mov  a,#(0x01 ^ 0x80)
   084B 8A F0              2010 	mov	b,r2
   084D 63 F0 80           2011 	xrl	b,#0x80
   0850 95 F0              2012 	subb	a,b
                           2013 ;     genIfxJump
                           2014 ;       Peephole 108    removed ljmp by inverse jump logic
   0852 50 45              2015 	jnc     00114$
   0854                    2016 00188$:
                           2017 ;src/keypad.c:392: lcd_goto_xy(current_blink_params->position, 1);
                           2018 ;     genAssign
   0854 AA 2D              2019 	mov	r2,_current_blink_params
   0856 AB 2E              2020 	mov	r3,(_current_blink_params + 1)
   0858 AC 2F              2021 	mov	r4,(_current_blink_params + 2)
                           2022 ;     genPointerGet
                           2023 ;     genGenPointerGet
   085A 8A 82              2024 	mov	dpl,r2
   085C 8B 83              2025 	mov	dph,r3
   085E 8C F0              2026 	mov	b,r4
   0860 12 71 F5           2027 	lcall	__gptrget
   0863 FA                 2028 	mov	r2,a
                           2029 ;     genIpush
   0864 74 01              2030 	mov	a,#0x01
   0866 C0 E0              2031 	push	acc
                           2032 ;     genCall
   0868 8A 82              2033 	mov	dpl,r2
   086A 12 0A CD           2034 	lcall	_lcd_goto_xy
   086D 15 81              2035 	dec	sp
                           2036 ;src/keypad.c:393: lcd_put_string(current_blink_params->second_pattern_on);
                           2037 ;     genAssign
   086F AA 2D              2038 	mov	r2,_current_blink_params
   0871 AB 2E              2039 	mov	r3,(_current_blink_params + 1)
   0873 AC 2F              2040 	mov	r4,(_current_blink_params + 2)
                           2041 ;     genPlus
   0875 74 07              2042 	mov	a,#0x07
                           2043 ;       Peephole 236.a  used r2 instead of ar2
   0877 2A                 2044 	add     a,r2
   0878 FA                 2045 	mov	r2,a
                           2046 ;       Peephole 181    changed mov to clr
   0879 E4                 2047 	clr     a
                           2048 ;       Peephole 236.b  used r3 instead of ar3
   087A 3B                 2049 	addc    a,r3
   087B FB                 2050 	mov	r3,a
                           2051 ;     genPointerGet
                           2052 ;     genGenPointerGet
   087C 8A 82              2053 	mov	dpl,r2
   087E 8B 83              2054 	mov	dph,r3
   0880 8C F0              2055 	mov	b,r4
   0882 12 71 F5           2056 	lcall	__gptrget
   0885 FA                 2057 	mov	r2,a
   0886 A3                 2058 	inc	dptr
   0887 12 71 F5           2059 	lcall	__gptrget
   088A FB                 2060 	mov	r3,a
   088B A3                 2061 	inc	dptr
   088C 12 71 F5           2062 	lcall	__gptrget
   088F FC                 2063 	mov	r4,a
                           2064 ;     genCall
   0890 8A 82              2065 	mov	dpl,r2
   0892 8B 83              2066 	mov	dph,r3
   0894 8C F0              2067 	mov	b,r4
   0896 12 0B B6           2068 	lcall	_lcd_put_string
   0899                    2069 00114$:
                           2070 ;src/keypad.c:396: blink_counter = 0;
                           2071 ;     genAssign
   0899 75 2A 00           2072 	mov	_blink_counter,#0x00
   089C                    2073 00118$:
                           2074 ;src/keypad.c:400: if (counter++ >= 5)
                           2075 ;     genAssign
   089C AA 2C              2076 	mov	r2,_timer0_interrupt_counter_1_1
                           2077 ;     genPlus
                           2078 ;     genPlusIncr
   089E 05 2C              2079 	inc	_timer0_interrupt_counter_1_1
                           2080 ;     genCmpLt
                           2081 ;     genCmp
   08A0 BA 05 00           2082 	cjne	r2,#0x05,00189$
   08A3                    2083 00189$:
                           2084 ;     genIfxJump
   08A3 50 03              2085 	jnc	00190$
   08A5 02 09 C0           2086 	ljmp	00147$
   08A8                    2087 00190$:
                           2088 ;src/keypad.c:402: counter = 0;
                           2089 ;     genAssign
   08A8 75 2C 00           2090 	mov	_timer0_interrupt_counter_1_1,#0x00
                           2091 ;src/keypad.c:403: empty = 0;
                           2092 ;     genAssign
   08AB 7A 00              2093 	mov	r2,#0x00
                           2094 ;src/keypad.c:426: KSC1 = 0;
                           2095 ;     genAssign
   08AD C2 85              2096 	clr	_P0_5
                           2097 ;src/keypad.c:427: input_value = (KEYBOARD_PORT >> 1) & 0xF;
                           2098 ;     genRightShift
                           2099 ;     genRightShiftLiteral
                           2100 ;     genrshOne
   08AF E5 80              2101 	mov	a,_P0
   08B1 C3                 2102 	clr	c
   08B2 13                 2103 	rrc	a
   08B3 FB                 2104 	mov	r3,a
                           2105 ;     genAnd
   08B4 53 03 0F           2106 	anl	ar3,#0x0F
                           2107 ;src/keypad.c:428: if ( input_value != 0x0F ) 
                           2108 ;     genCmpEq
   08B7 BB 0F 02           2109 	cjne	r3,#0x0F,00191$
                           2110 ;       Peephole 112.b  changed ljmp to sjmp
   08BA 80 30              2111 	sjmp    00124$
   08BC                    2112 00191$:
                           2113 ;src/keypad.c:430: empty++;
                           2114 ;     genAssign
   08BC 7A 01              2115 	mov	r2,#0x01
                           2116 ;src/keypad.c:431: input_value |= 0x10;
                           2117 ;     genOr
   08BE 43 03 10           2118 	orl	ar3,#0x10
                           2119 ;src/keypad.c:432: key_code = find_mapping_code(input_value);
                           2120 ;     genCall
   08C1 8B 82              2121 	mov	dpl,r3
   08C3 C0 02              2122 	push	ar2
   08C5 12 01 9D           2123 	lcall	_find_mapping_code
   08C8 AC 82              2124 	mov	r4,dpl
   08CA D0 02              2125 	pop	ar2
                           2126 ;     genAssign
                           2127 ;src/keypad.c:434: if (key_code != SCAN_ERROR)
                           2128 ;     genCmpEq
   08CC BC 92 02           2129 	cjne	r4,#0x92,00192$
                           2130 ;       Peephole 112.b  changed ljmp to sjmp
   08CF 80 1B              2131 	sjmp    00124$
   08D1                    2132 00192$:
                           2133 ;src/keypad.c:436: if (key_code != kb.last_code)
                           2134 ;     genPointerGet
                           2135 ;     genFarPointerGet
   08D1 90 00 00           2136 	mov	dptr,#_kb
   08D4 E0                 2137 	movx	a,@dptr
   08D5 FD                 2138 	mov	r5,a
                           2139 ;     genCmpEq
   08D6 EC                 2140 	mov	a,r4
   08D7 B5 05 02           2141 	cjne	a,ar5,00193$
                           2142 ;       Peephole 112.b  changed ljmp to sjmp
   08DA 80 10              2143 	sjmp    00124$
   08DC                    2144 00193$:
                           2145 ;src/keypad.c:438: kb.buffer = key_code;
                           2146 ;     genPointerSet
                           2147 ;     genFarPointerSet
   08DC 90 00 02           2148 	mov	dptr,#(_kb + 0x0002)
   08DF EC                 2149 	mov	a,r4
   08E0 F0                 2150 	movx	@dptr,a
                           2151 ;src/keypad.c:439: kb.last_code = key_code;
                           2152 ;     genPointerSet
                           2153 ;     genFarPointerSet
   08E1 90 00 00           2154 	mov	dptr,#_kb
   08E4 EC                 2155 	mov	a,r4
   08E5 F0                 2156 	movx	@dptr,a
                           2157 ;src/keypad.c:440: kb.status = DATA_AVAILABLE;
                           2158 ;     genPointerSet
                           2159 ;     genFarPointerSet
   08E6 90 00 01           2160 	mov	dptr,#(_kb + 0x0001)
   08E9 74 91              2161 	mov	a,#0x91
   08EB F0                 2162 	movx	@dptr,a
   08EC                    2163 00124$:
                           2164 ;src/keypad.c:445: KSC1 = 1;
                           2165 ;     genAssign
   08EC D2 85              2166 	setb	_P0_5
                           2167 ;src/keypad.c:447: KSC2 = 0;
                           2168 ;     genAssign
   08EE C2 86              2169 	clr	_P0_6
                           2170 ;src/keypad.c:448: input_value = (KEYBOARD_PORT >> 1) & 0xF;
                           2171 ;     genRightShift
                           2172 ;     genRightShiftLiteral
                           2173 ;     genrshOne
   08F0 E5 80              2174 	mov	a,_P0
   08F2 C3                 2175 	clr	c
   08F3 13                 2176 	rrc	a
   08F4 FD                 2177 	mov	r5,a
                           2178 ;     genAnd
   08F5 74 0F              2179 	mov	a,#0x0F
   08F7 5D                 2180 	anl	a,r5
   08F8 FB                 2181 	mov	r3,a
                           2182 ;src/keypad.c:449: if ( input_value != 0x0F ) 
                           2183 ;     genCmpEq
   08F9 BB 0F 02           2184 	cjne	r3,#0x0F,00194$
                           2185 ;       Peephole 112.b  changed ljmp to sjmp
   08FC 80 31              2186 	sjmp    00130$
   08FE                    2187 00194$:
                           2188 ;src/keypad.c:451: empty++;
                           2189 ;     genPlus
                           2190 ;     genPlusIncr
   08FE 0A                 2191 	inc	r2
                           2192 ;src/keypad.c:453: input_value |= 0x20;
                           2193 ;     genOr
   08FF 43 03 20           2194 	orl	ar3,#0x20
                           2195 ;src/keypad.c:454: key_code = find_mapping_code(input_value);
                           2196 ;     genCall
   0902 8B 82              2197 	mov	dpl,r3
   0904 C0 02              2198 	push	ar2
   0906 12 01 9D           2199 	lcall	_find_mapping_code
   0909 AD 82              2200 	mov	r5,dpl
   090B D0 02              2201 	pop	ar2
                           2202 ;     genAssign
   090D 8D 04              2203 	mov	ar4,r5
                           2204 ;src/keypad.c:456: if (key_code != SCAN_ERROR)
                           2205 ;     genCmpEq
   090F BC 92 02           2206 	cjne	r4,#0x92,00195$
                           2207 ;       Peephole 112.b  changed ljmp to sjmp
   0912 80 1B              2208 	sjmp    00130$
   0914                    2209 00195$:
                           2210 ;src/keypad.c:458: if (key_code != kb.last_code)
                           2211 ;     genPointerGet
                           2212 ;     genFarPointerGet
   0914 90 00 00           2213 	mov	dptr,#_kb
   0917 E0                 2214 	movx	a,@dptr
   0918 FD                 2215 	mov	r5,a
                           2216 ;     genCmpEq
   0919 EC                 2217 	mov	a,r4
   091A B5 05 02           2218 	cjne	a,ar5,00196$
                           2219 ;       Peephole 112.b  changed ljmp to sjmp
   091D 80 10              2220 	sjmp    00130$
   091F                    2221 00196$:
                           2222 ;src/keypad.c:460: kb.buffer = key_code;
                           2223 ;     genPointerSet
                           2224 ;     genFarPointerSet
   091F 90 00 02           2225 	mov	dptr,#(_kb + 0x0002)
   0922 EC                 2226 	mov	a,r4
   0923 F0                 2227 	movx	@dptr,a
                           2228 ;src/keypad.c:461: kb.last_code = key_code;
                           2229 ;     genPointerSet
                           2230 ;     genFarPointerSet
   0924 90 00 00           2231 	mov	dptr,#_kb
   0927 EC                 2232 	mov	a,r4
   0928 F0                 2233 	movx	@dptr,a
                           2234 ;src/keypad.c:462: kb.status = DATA_AVAILABLE;
                           2235 ;     genPointerSet
                           2236 ;     genFarPointerSet
   0929 90 00 01           2237 	mov	dptr,#(_kb + 0x0001)
   092C 74 91              2238 	mov	a,#0x91
   092E F0                 2239 	movx	@dptr,a
   092F                    2240 00130$:
                           2241 ;src/keypad.c:467: KSC2 = 1;
                           2242 ;     genAssign
   092F D2 86              2243 	setb	_P0_6
                           2244 ;src/keypad.c:469: KSC3 = 0;
                           2245 ;     genAssign
   0931 C2 87              2246 	clr	_P0_7
                           2247 ;src/keypad.c:470: input_value = (KEYBOARD_PORT >> 1) & 0xF;
                           2248 ;     genRightShift
                           2249 ;     genRightShiftLiteral
                           2250 ;     genrshOne
   0933 E5 80              2251 	mov	a,_P0
   0935 C3                 2252 	clr	c
   0936 13                 2253 	rrc	a
   0937 FD                 2254 	mov	r5,a
                           2255 ;     genAnd
   0938 74 0F              2256 	mov	a,#0x0F
   093A 5D                 2257 	anl	a,r5
   093B FB                 2258 	mov	r3,a
                           2259 ;src/keypad.c:471: if ( input_value != 0x0F ) 
                           2260 ;     genCmpEq
   093C BB 0F 02           2261 	cjne	r3,#0x0F,00197$
                           2262 ;       Peephole 112.b  changed ljmp to sjmp
   093F 80 31              2263 	sjmp    00136$
   0941                    2264 00197$:
                           2265 ;src/keypad.c:473: empty++;
                           2266 ;     genPlus
                           2267 ;     genPlusIncr
   0941 0A                 2268 	inc	r2
                           2269 ;src/keypad.c:475: input_value |= 0x30;
                           2270 ;     genOr
   0942 43 03 30           2271 	orl	ar3,#0x30
                           2272 ;src/keypad.c:476: key_code = find_mapping_code(input_value);
                           2273 ;     genCall
   0945 8B 82              2274 	mov	dpl,r3
   0947 C0 02              2275 	push	ar2
   0949 12 01 9D           2276 	lcall	_find_mapping_code
   094C AD 82              2277 	mov	r5,dpl
   094E D0 02              2278 	pop	ar2
                           2279 ;     genAssign
   0950 8D 04              2280 	mov	ar4,r5
                           2281 ;src/keypad.c:478: if (key_code != SCAN_ERROR)
                           2282 ;     genCmpEq
   0952 BC 92 02           2283 	cjne	r4,#0x92,00198$
                           2284 ;       Peephole 112.b  changed ljmp to sjmp
   0955 80 1B              2285 	sjmp    00136$
   0957                    2286 00198$:
                           2287 ;src/keypad.c:480: if (key_code != kb.last_code)
                           2288 ;     genPointerGet
                           2289 ;     genFarPointerGet
   0957 90 00 00           2290 	mov	dptr,#_kb
   095A E0                 2291 	movx	a,@dptr
   095B FD                 2292 	mov	r5,a
                           2293 ;     genCmpEq
   095C EC                 2294 	mov	a,r4
   095D B5 05 02           2295 	cjne	a,ar5,00199$
                           2296 ;       Peephole 112.b  changed ljmp to sjmp
   0960 80 10              2297 	sjmp    00136$
   0962                    2298 00199$:
                           2299 ;src/keypad.c:482: kb.buffer = key_code;
                           2300 ;     genPointerSet
                           2301 ;     genFarPointerSet
   0962 90 00 02           2302 	mov	dptr,#(_kb + 0x0002)
   0965 EC                 2303 	mov	a,r4
   0966 F0                 2304 	movx	@dptr,a
                           2305 ;src/keypad.c:483: kb.last_code = key_code;
                           2306 ;     genPointerSet
                           2307 ;     genFarPointerSet
   0967 90 00 00           2308 	mov	dptr,#_kb
   096A EC                 2309 	mov	a,r4
   096B F0                 2310 	movx	@dptr,a
                           2311 ;src/keypad.c:484: kb.status = DATA_AVAILABLE;
                           2312 ;     genPointerSet
                           2313 ;     genFarPointerSet
   096C 90 00 01           2314 	mov	dptr,#(_kb + 0x0001)
   096F 74 91              2315 	mov	a,#0x91
   0971 F0                 2316 	movx	@dptr,a
   0972                    2317 00136$:
                           2318 ;src/keypad.c:489: KSC3 = 1;
                           2319 ;     genAssign
   0972 D2 87              2320 	setb	_P0_7
                           2321 ;src/keypad.c:491: KSC4 = 0;
                           2322 ;     genAssign
   0974 C2 B7              2323 	clr	_P3_7
                           2324 ;src/keypad.c:492: input_value = (KEYBOARD_PORT >> 1) & 0xF;
                           2325 ;     genRightShift
                           2326 ;     genRightShiftLiteral
                           2327 ;     genrshOne
   0976 E5 80              2328 	mov	a,_P0
   0978 C3                 2329 	clr	c
   0979 13                 2330 	rrc	a
   097A FD                 2331 	mov	r5,a
                           2332 ;     genAnd
   097B 74 0F              2333 	mov	a,#0x0F
   097D 5D                 2334 	anl	a,r5
   097E FB                 2335 	mov	r3,a
                           2336 ;src/keypad.c:493: if ( input_value != 0x0F ) 
                           2337 ;     genCmpEq
   097F BB 0F 02           2338 	cjne	r3,#0x0F,00200$
                           2339 ;       Peephole 112.b  changed ljmp to sjmp
   0982 80 31              2340 	sjmp    00142$
   0984                    2341 00200$:
                           2342 ;src/keypad.c:495: empty++;
                           2343 ;     genPlus
                           2344 ;     genPlusIncr
   0984 0A                 2345 	inc	r2
                           2346 ;src/keypad.c:497: input_value |= 0x40;
                           2347 ;     genOr
   0985 43 03 40           2348 	orl	ar3,#0x40
                           2349 ;src/keypad.c:498: key_code = find_mapping_code(input_value);
                           2350 ;     genCall
   0988 8B 82              2351 	mov	dpl,r3
   098A C0 02              2352 	push	ar2
   098C 12 01 9D           2353 	lcall	_find_mapping_code
   098F AB 82              2354 	mov	r3,dpl
   0991 D0 02              2355 	pop	ar2
                           2356 ;     genAssign
   0993 8B 04              2357 	mov	ar4,r3
                           2358 ;src/keypad.c:500: if (key_code != SCAN_ERROR)
                           2359 ;     genCmpEq
   0995 BC 92 02           2360 	cjne	r4,#0x92,00201$
                           2361 ;       Peephole 112.b  changed ljmp to sjmp
   0998 80 1B              2362 	sjmp    00142$
   099A                    2363 00201$:
                           2364 ;src/keypad.c:502: if (key_code != kb.last_code)
                           2365 ;     genPointerGet
                           2366 ;     genFarPointerGet
   099A 90 00 00           2367 	mov	dptr,#_kb
   099D E0                 2368 	movx	a,@dptr
   099E FB                 2369 	mov	r3,a
                           2370 ;     genCmpEq
   099F EC                 2371 	mov	a,r4
   09A0 B5 03 02           2372 	cjne	a,ar3,00202$
                           2373 ;       Peephole 112.b  changed ljmp to sjmp
   09A3 80 10              2374 	sjmp    00142$
   09A5                    2375 00202$:
                           2376 ;src/keypad.c:504: kb.buffer = key_code;
                           2377 ;     genPointerSet
                           2378 ;     genFarPointerSet
   09A5 90 00 02           2379 	mov	dptr,#(_kb + 0x0002)
   09A8 EC                 2380 	mov	a,r4
   09A9 F0                 2381 	movx	@dptr,a
                           2382 ;src/keypad.c:505: kb.last_code = key_code;
                           2383 ;     genPointerSet
                           2384 ;     genFarPointerSet
   09AA 90 00 00           2385 	mov	dptr,#_kb
   09AD EC                 2386 	mov	a,r4
   09AE F0                 2387 	movx	@dptr,a
                           2388 ;src/keypad.c:506: kb.status = DATA_AVAILABLE;
                           2389 ;     genPointerSet
                           2390 ;     genFarPointerSet
   09AF 90 00 01           2391 	mov	dptr,#(_kb + 0x0001)
   09B2 74 91              2392 	mov	a,#0x91
   09B4 F0                 2393 	movx	@dptr,a
   09B5                    2394 00142$:
                           2395 ;src/keypad.c:511: KSC4 = 1;
                           2396 ;     genAssign
   09B5 D2 B7              2397 	setb	_P3_7
                           2398 ;src/keypad.c:513: if (empty == 0)
                           2399 ;     genCmpEq
                           2400 ;       Peephole 112.b  changed ljmp to sjmp
                           2401 ;       Peephole 199    optimized misc jump sequence
   09B7 BA 00 06           2402 	cjne    r2,#0x00,00147$
                           2403 ;00203$:
                           2404 ;       Peephole 200    removed redundant sjmp
   09BA                    2405 00204$:
                           2406 ;src/keypad.c:515: kb.last_code = BUFFER_EMPTY;
                           2407 ;     genPointerSet
                           2408 ;     genFarPointerSet
   09BA 90 00 00           2409 	mov	dptr,#_kb
   09BD 74 90              2410 	mov	a,#0x90
   09BF F0                 2411 	movx	@dptr,a
   09C0                    2412 00147$:
   09C0 85 40 81           2413 	mov	sp,_bp
   09C3 D0 40              2414 	pop	_bp
   09C5 D0 D0              2415 	pop	psw
   09C7 D0 01              2416 	pop	(0+1)
   09C9 D0 00              2417 	pop	(0+0)
   09CB D0 07              2418 	pop	(0+7)
   09CD D0 06              2419 	pop	(0+6)
   09CF D0 05              2420 	pop	(0+5)
   09D1 D0 04              2421 	pop	(0+4)
   09D3 D0 03              2422 	pop	(0+3)
   09D5 D0 02              2423 	pop	(0+2)
   09D7 D0 83              2424 	pop	dph
   09D9 D0 82              2425 	pop	dpl
   09DB D0 F0              2426 	pop	b
   09DD D0 E0              2427 	pop	acc
   09DF 32                 2428 	reti
                           2429 	.area CSEG    (CODE)
   09E0                    2430 _mappingTable:
   09E0 3E 00              2431 	.byte #0x3E,#0x00
   09E2 00 00              2432 	.byte #0x00,#0x00
   09E4 54 0A 02           2433 	.byte _str_0,(_str_0 >> 8),#0x02
   09E7 47 00              2434 	.byte #0x47,#0x00
   09E9 01 00              2435 	.byte #0x01,#0x00
   09EB 56 0A 02           2436 	.byte _str_1,(_str_1 >> 8),#0x02
   09EE 37 00              2437 	.byte #0x37,#0x00
   09F0 02 00              2438 	.byte #0x02,#0x00
   09F2 58 0A 02           2439 	.byte _str_2,(_str_2 >> 8),#0x02
   09F5 27 00              2440 	.byte #0x27,#0x00
   09F7 03 00              2441 	.byte #0x03,#0x00
   09F9 5A 0A 02           2442 	.byte _str_3,(_str_3 >> 8),#0x02
   09FC 4B 00              2443 	.byte #0x4B,#0x00
   09FE 04 00              2444 	.byte #0x04,#0x00
   0A00 5C 0A 02           2445 	.byte _str_4,(_str_4 >> 8),#0x02
   0A03 3B 00              2446 	.byte #0x3B,#0x00
   0A05 05 00              2447 	.byte #0x05,#0x00
   0A07 5E 0A 02           2448 	.byte _str_5,(_str_5 >> 8),#0x02
   0A0A 2B 00              2449 	.byte #0x2B,#0x00
   0A0C 06 00              2450 	.byte #0x06,#0x00
   0A0E 60 0A 02           2451 	.byte _str_6,(_str_6 >> 8),#0x02
   0A11 4D 00              2452 	.byte #0x4D,#0x00
   0A13 07 00              2453 	.byte #0x07,#0x00
   0A15 62 0A 02           2454 	.byte _str_7,(_str_7 >> 8),#0x02
   0A18 3D 00              2455 	.byte #0x3D,#0x00
   0A1A 08 00              2456 	.byte #0x08,#0x00
   0A1C 64 0A 02           2457 	.byte _str_8,(_str_8 >> 8),#0x02
   0A1F 2D 00              2458 	.byte #0x2D,#0x00
   0A21 09 00              2459 	.byte #0x09,#0x00
   0A23 66 0A 02           2460 	.byte _str_9,(_str_9 >> 8),#0x02
   0A26 17 00              2461 	.byte #0x17,#0x00
   0A28 10 00              2462 	.byte #0x10,#0x00
   0A2A 68 0A 02           2463 	.byte _str_10,(_str_10 >> 8),#0x02
   0A2D 1B 00              2464 	.byte #0x1B,#0x00
   0A2F 11 00              2465 	.byte #0x11,#0x00
   0A31 6D 0A 02           2466 	.byte _str_11,(_str_11 >> 8),#0x02
   0A34 4E 00              2467 	.byte #0x4E,#0x00
   0A36 15 00              2468 	.byte #0x15,#0x00
   0A38 73 0A 02           2469 	.byte _str_12,(_str_12 >> 8),#0x02
   0A3B 2E 00              2470 	.byte #0x2E,#0x00
   0A3D 16 00              2471 	.byte #0x16,#0x00
   0A3F 75 0A 02           2472 	.byte _str_13,(_str_13 >> 8),#0x02
   0A42 1E 00              2473 	.byte #0x1E,#0x00
   0A44 13 00              2474 	.byte #0x13,#0x00
   0A46 77 0A 02           2475 	.byte _str_14,(_str_14 >> 8),#0x02
   0A49 1D 00              2476 	.byte #0x1D,#0x00
   0A4B 14 00              2477 	.byte #0x14,#0x00
   0A4D 7D 0A 02           2478 	.byte _str_15,(_str_15 >> 8),#0x02
   0A50 00 00              2479 	.byte #0x00,#0x00
   0A52 00 00              2480 	.byte #0x00,#0x00
   0A54                    2481 _str_0:
   0A54 30                 2482 	.ascii "0"
   0A55 00                 2483 	.db 0x00
   0A56                    2484 _str_1:
   0A56 31                 2485 	.ascii "1"
   0A57 00                 2486 	.db 0x00
   0A58                    2487 _str_2:
   0A58 32                 2488 	.ascii "2"
   0A59 00                 2489 	.db 0x00
   0A5A                    2490 _str_3:
   0A5A 33                 2491 	.ascii "3"
   0A5B 00                 2492 	.db 0x00
   0A5C                    2493 _str_4:
   0A5C 34                 2494 	.ascii "4"
   0A5D 00                 2495 	.db 0x00
   0A5E                    2496 _str_5:
   0A5E 35                 2497 	.ascii "5"
   0A5F 00                 2498 	.db 0x00
   0A60                    2499 _str_6:
   0A60 36                 2500 	.ascii "6"
   0A61 00                 2501 	.db 0x00
   0A62                    2502 _str_7:
   0A62 37                 2503 	.ascii "7"
   0A63 00                 2504 	.db 0x00
   0A64                    2505 _str_8:
   0A64 38                 2506 	.ascii "8"
   0A65 00                 2507 	.db 0x00
   0A66                    2508 _str_9:
   0A66 39                 2509 	.ascii "9"
   0A67 00                 2510 	.db 0x00
   0A68                    2511 _str_10:
   0A68 4C 45 46 54        2512 	.ascii "LEFT"
   0A6C 00                 2513 	.db 0x00
   0A6D                    2514 _str_11:
   0A6D 52 49 47 48 54     2515 	.ascii "RIGHT"
   0A72 00                 2516 	.db 0x00
   0A73                    2517 _str_12:
   0A73 2A                 2518 	.ascii "*"
   0A74 00                 2519 	.db 0x00
   0A75                    2520 _str_13:
   0A75 23                 2521 	.ascii "#"
   0A76 00                 2522 	.db 0x00
   0A77                    2523 _str_14:
   0A77 43 4C 45 41 52     2524 	.ascii "CLEAR"
   0A7C 00                 2525 	.db 0x00
   0A7D                    2526 _str_15:
   0A7D 45 4E 54 45 52     2527 	.ascii "ENTER"
   0A82 00                 2528 	.db 0x00
                           2529 	.area XINIT   (CODE)
