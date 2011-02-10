                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.4.0 Thu Feb 10 12:42:26 2011
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module src/lcd
                              7 	.optsdcc -mmcs51 --model-small
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _enable
                             13 	.globl _lcd_delay
                             14 	.globl _lcd_goto_xy
                             15 	.globl _lcd_put
                             16 	.globl _lcd_clear
                             17 	.globl _lcd_home
                             18 	.globl _putchar
                             19 	.globl _lcd_put_string
                             20 	.globl _lcd_cursor_on
                             21 	.globl _lcd_cursor_off
                             22 	.globl _lcd_init
                             23 ;--------------------------------------------------------
                             24 ; special function registers
                             25 ;--------------------------------------------------------
                    0080     26 _P0	=	0x0080
                    0081     27 _SP	=	0x0081
                    0082     28 _DPL	=	0x0082
                    0083     29 _DPH	=	0x0083
                    0087     30 _PCON	=	0x0087
                    0088     31 _TCON	=	0x0088
                    0089     32 _TMOD	=	0x0089
                    008A     33 _TL0	=	0x008a
                    008B     34 _TL1	=	0x008b
                    008C     35 _TH0	=	0x008c
                    008D     36 _TH1	=	0x008d
                    0090     37 _P1	=	0x0090
                    0098     38 _SCON	=	0x0098
                    0099     39 _SBUF	=	0x0099
                    00A0     40 _P2	=	0x00a0
                    00B0     41 _P3	=	0x00b0
                    00B8     42 _IP	=	0x00b8
                    00C8     43 _T2CON	=	0x00c8
                    00C9     44 _T2MOD	=	0x00c9
                    00CA     45 _RCAP2L	=	0x00ca
                    00CB     46 _RCAP2H	=	0x00cb
                    00CC     47 _TL2	=	0x00cc
                    00CD     48 _TH2	=	0x00cd
                    00D0     49 _PSW	=	0x00d0
                    00E0     50 _A	=	0x00e0
                    00A6     51 _WDTRST	=	0x00a6
                    00A7     52 _WDTPRG	=	0x00a7
                    00A2     53 _AUXR1	=	0x00a2
                    008E     54 _AUXR	=	0x008e
                    00B9     55 _SADEN	=	0x00b9
                    00BA     56 _SADEN_1	=	0x00ba
                    00B7     57 _IPH	=	0x00b7
                    00B7     58 _IPH0	=	0x00b7
                    00B8     59 _IPL	=	0x00b8
                    00B8     60 _IPL0	=	0x00b8
                    00A8     61 _IE	=	0x00a8
                    00A9     62 _SADDR	=	0x00a9
                    00AA     63 _SADDR_1	=	0x00aa
                    00D8     64 _CCON	=	0x00d8
                    00D9     65 _CMOD	=	0x00d9
                    00DA     66 _CCAPM0	=	0x00da
                    00DB     67 _CCAPM1	=	0x00db
                    00DC     68 _CCAPM2	=	0x00dc
                    00DD     69 _CCAPM3	=	0x00dd
                    00DE     70 _CCAPM4	=	0x00de
                    00E9     71 _CL	=	0x00e9
                    00EA     72 _CCAP0L	=	0x00ea
                    00EB     73 _CCAP1L	=	0x00eb
                    00EC     74 _CCAP2L	=	0x00ec
                    00ED     75 _CCAP3L	=	0x00ed
                    00EE     76 _CCAP4L	=	0x00ee
                    00E0     77 _ACC	=	0x00e0
                    00F0     78 _B	=	0x00f0
                    00F9     79 _CH	=	0x00f9
                    00FA     80 _CCAP0H	=	0x00fa
                    00FB     81 _CCAP1H	=	0x00fb
                    00FC     82 _CCAP2H	=	0x00fc
                    00FD     83 _CCAP3H	=	0x00fd
                    00FE     84 _CCAP4H	=	0x00fe
                    00FF     85 _ICON	=	0x00ff
                    0085     86 _CKSEL	=	0x0085
                    0086     87 _OSCCON	=	0x0086
                    00D1     88 _FCON	=	0x00d1
                    00D2     89 _EECON	=	0x00d2
                    00D3     90 _EETIM	=	0x00d3
                             91 ;--------------------------------------------------------
                             92 ; special function bits 
                             93 ;--------------------------------------------------------
                    0080     94 _P0_0	=	0x0080
                    0081     95 _P0_1	=	0x0081
                    0082     96 _P0_2	=	0x0082
                    0083     97 _P0_3	=	0x0083
                    0084     98 _P0_4	=	0x0084
                    0085     99 _P0_5	=	0x0085
                    0086    100 _P0_6	=	0x0086
                    0087    101 _P0_7	=	0x0087
                    00A7    102 _ENBOOT	=	0x00a7
                    0088    103 _IT0	=	0x0088
                    0089    104 _IE0	=	0x0089
                    008A    105 _IT1	=	0x008a
                    008B    106 _IE1	=	0x008b
                    008C    107 _TR0	=	0x008c
                    008D    108 _TF0	=	0x008d
                    008E    109 _TR1	=	0x008e
                    008F    110 _TF1	=	0x008f
                    0090    111 _P1_0	=	0x0090
                    0091    112 _P1_1	=	0x0091
                    0092    113 _P1_2	=	0x0092
                    0093    114 _P1_3	=	0x0093
                    0094    115 _P1_4	=	0x0094
                    0095    116 _P1_5	=	0x0095
                    0096    117 _P1_6	=	0x0096
                    0097    118 _P1_7	=	0x0097
                    0090    119 _T2	=	0x0090
                    0091    120 _T2EX	=	0x0091
                    0098    121 _RI	=	0x0098
                    0099    122 _TI	=	0x0099
                    009A    123 _RB8	=	0x009a
                    009B    124 _TB8	=	0x009b
                    009C    125 _REN	=	0x009c
                    009D    126 _SM2	=	0x009d
                    009E    127 _SM1	=	0x009e
                    009F    128 _SM0	=	0x009f
                    00A0    129 _P2_0	=	0x00a0
                    00A1    130 _P2_1	=	0x00a1
                    00A2    131 _P2_2	=	0x00a2
                    00A3    132 _P2_3	=	0x00a3
                    00A4    133 _P2_4	=	0x00a4
                    00A5    134 _P2_5	=	0x00a5
                    00A6    135 _P2_6	=	0x00a6
                    00A7    136 _P2_7	=	0x00a7
                    00B0    137 _P3_0	=	0x00b0
                    00B1    138 _P3_1	=	0x00b1
                    00B2    139 _P3_2	=	0x00b2
                    00B3    140 _P3_3	=	0x00b3
                    00B4    141 _P3_4	=	0x00b4
                    00B5    142 _P3_5	=	0x00b5
                    00B6    143 _P3_6	=	0x00b6
                    00B7    144 _P3_7	=	0x00b7
                    00B0    145 _RXD	=	0x00b0
                    00B1    146 _TXD	=	0x00b1
                    00B2    147 _INT0	=	0x00b2
                    00B3    148 _INT1	=	0x00b3
                    00B4    149 _T0	=	0x00b4
                    00B5    150 _T1	=	0x00b5
                    00B6    151 _WR	=	0x00b6
                    00B7    152 _RD	=	0x00b7
                    00B8    153 _PX0	=	0x00b8
                    00B9    154 _PT0	=	0x00b9
                    00BA    155 _PX1	=	0x00ba
                    00BB    156 _PT1	=	0x00bb
                    00BC    157 _PS	=	0x00bc
                    00BD    158 _PT2	=	0x00bd
                    00C8    159 _T2CON_0	=	0x00c8
                    00C9    160 _T2CON_1	=	0x00c9
                    00CA    161 _T2CON_2	=	0x00ca
                    00CB    162 _T2CON_3	=	0x00cb
                    00CC    163 _T2CON_4	=	0x00cc
                    00CD    164 _T2CON_5	=	0x00cd
                    00CE    165 _T2CON_6	=	0x00ce
                    00CF    166 _T2CON_7	=	0x00cf
                    00C8    167 _CP_RL2	=	0x00c8
                    00C9    168 _C_T2	=	0x00c9
                    00CA    169 _TR2	=	0x00ca
                    00CB    170 _EXEN2	=	0x00cb
                    00CC    171 _TCLK	=	0x00cc
                    00CD    172 _RCLK	=	0x00cd
                    00CE    173 _EXF2	=	0x00ce
                    00CF    174 _TF2	=	0x00cf
                    00D0    175 _P	=	0x00d0
                    00D1    176 _FL	=	0x00d1
                    00D2    177 _OV	=	0x00d2
                    00D3    178 _RS0	=	0x00d3
                    00D4    179 _RS1	=	0x00d4
                    00D5    180 _F0	=	0x00d5
                    00D6    181 _AC	=	0x00d6
                    00D7    182 _CY	=	0x00d7
                    00AF    183 _EA	=	0x00af
                    00AE    184 _EC	=	0x00ae
                    00AD    185 _ET2	=	0x00ad
                    00AC    186 _ES	=	0x00ac
                    00AB    187 _ET1	=	0x00ab
                    00AA    188 _EX1	=	0x00aa
                    00A9    189 _ET0	=	0x00a9
                    00A8    190 _EX0	=	0x00a8
                    00DF    191 _CF	=	0x00df
                    00DE    192 _CR	=	0x00de
                    00DC    193 _CCF4	=	0x00dc
                    00DB    194 _CCF3	=	0x00db
                    00DA    195 _CCF2	=	0x00da
                    00D9    196 _CCF1	=	0x00d9
                    00D8    197 _CCF0	=	0x00d8
                            198 ;--------------------------------------------------------
                            199 ; overlayable register banks 
                            200 ;--------------------------------------------------------
                            201 	.area REG_BANK_0	(REL,OVR,DATA)
   0000                     202 	.ds 8
                            203 ;--------------------------------------------------------
                            204 ; internal ram data
                            205 ;--------------------------------------------------------
                            206 	.area DSEG    (DATA)
                            207 ;--------------------------------------------------------
                            208 ; overlayable items in internal ram 
                            209 ;--------------------------------------------------------
                            210 	.area OSEG    (OVR,DATA)
                            211 ;--------------------------------------------------------
                            212 ; indirectly addressable internal ram data
                            213 ;--------------------------------------------------------
                            214 	.area ISEG    (DATA)
                            215 ;--------------------------------------------------------
                            216 ; bit data
                            217 ;--------------------------------------------------------
                            218 	.area BSEG    (BIT)
                            219 ;--------------------------------------------------------
                            220 ; external ram data
                            221 ;--------------------------------------------------------
                            222 	.area XSEG    (XDATA)
                            223 ;--------------------------------------------------------
                            224 ; external initialized ram data
                            225 ;--------------------------------------------------------
                            226 	.area XISEG   (XDATA)
                            227 ;--------------------------------------------------------
                            228 ; global & static initialisations
                            229 ;--------------------------------------------------------
                            230 	.area GSINIT  (CODE)
                            231 	.area GSFINAL (CODE)
                            232 	.area GSINIT  (CODE)
                            233 ;--------------------------------------------------------
                            234 ; Home
                            235 ;--------------------------------------------------------
                            236 	.area HOME    (CODE)
                            237 	.area CSEG    (CODE)
                            238 ;--------------------------------------------------------
                            239 ; code
                            240 ;--------------------------------------------------------
                            241 	.area CSEG    (CODE)
                            242 ;------------------------------------------------------------
                            243 ;Allocation info for local variables in function 'lcd_delay'
                            244 ;------------------------------------------------------------
                            245 ;delay                     Allocated to registers r2 r3 
                            246 ;counter                   Allocated to registers 
                            247 ;------------------------------------------------------------
                            248 ;src/lcd.c:64: void lcd_delay ( int delay ) 
                            249 ;	-----------------------------------------
                            250 ;	 function lcd_delay
                            251 ;	-----------------------------------------
   0A83                     252 _lcd_delay:
                    0002    253 	ar2 = 0x02
                    0003    254 	ar3 = 0x03
                    0004    255 	ar4 = 0x04
                    0005    256 	ar5 = 0x05
                    0006    257 	ar6 = 0x06
                    0007    258 	ar7 = 0x07
                    0000    259 	ar0 = 0x00
                    0001    260 	ar1 = 0x01
   0A83 C0 40               261 	push	_bp
   0A85 85 81 40            262 	mov	_bp,sp
                            263 ;     genReceive
   0A88 AA 82               264 	mov	r2,dpl
   0A8A AB 83               265 	mov	r3,dph
                            266 ;src/lcd.c:66: int counter = 0;
                            267 ;     genAssign
   0A8C 7C 00               268 	mov	r4,#0x00
   0A8E 7D 00               269 	mov	r5,#0x00
   0A90                     270 00101$:
                            271 ;src/lcd.c:68: for ( ; counter < delay; counter++ )
                            272 ;     genCmpLt
                            273 ;     genCmp
   0A90 C3                  274 	clr	c
   0A91 EC                  275 	mov	a,r4
   0A92 9A                  276 	subb	a,r2
   0A93 ED                  277 	mov	a,r5
   0A94 64 80               278 	xrl	a,#0x80
   0A96 8B F0               279 	mov	b,r3
   0A98 63 F0 80            280 	xrl	b,#0x80
   0A9B 95 F0               281 	subb	a,b
                            282 ;     genIfxJump
                            283 ;       Peephole 108    removed ljmp by inverse jump logic
   0A9D 50 0D               284 	jnc     00105$
   0A9F                     285 00109$:
                            286 ;src/lcd.c:70: SERVICE_WATCHDOG;
                            287 ;     genAssign
   0A9F 75 A6 1E            288 	mov	_WDTRST,#0x1E
                            289 ;     genAssign
   0AA2 75 A6 E1            290 	mov	_WDTRST,#0xE1
                            291 ;src/lcd.c:68: for ( ; counter < delay; counter++ )
                            292 ;     genPlus
                            293 ;     genPlusIncr
                            294 ;	tail increment optimized
   0AA5 0C                  295 	inc	r4
   0AA6 BC 00 E7            296 	cjne	r4,#0x00,00101$
   0AA9 0D                  297 	inc	r5
                            298 ;       Peephole 112.b  changed ljmp to sjmp
   0AAA 80 E4               299 	sjmp    00101$
   0AAC                     300 00105$:
   0AAC 85 40 81            301 	mov	sp,_bp
   0AAF D0 40               302 	pop	_bp
   0AB1 22                  303 	ret
                            304 ;------------------------------------------------------------
                            305 ;Allocation info for local variables in function 'enable'
                            306 ;------------------------------------------------------------
                            307 ;------------------------------------------------------------
                            308 ;src/lcd.c:74: void enable(void) 
                            309 ;	-----------------------------------------
                            310 ;	 function enable
                            311 ;	-----------------------------------------
   0AB2                     312 _enable:
   0AB2 C0 40               313 	push	_bp
   0AB4 85 81 40            314 	mov	_bp,sp
                            315 ;src/lcd.c:76: LCD_E_BIT = 1;
                            316 ;     genAssign
   0AB7 D2 A4               317 	setb	_P2_4
                            318 ;src/lcd.c:77: lcd_delay(ENABLE_DELAY);
                            319 ;     genCall
                            320 ;       Peephole 182.b  used 16 bit load of dptr
   0AB9 90 01 2C            321 	mov     dptr,#0x012C
   0ABC 12 0A 83            322 	lcall	_lcd_delay
                            323 ;src/lcd.c:78: LCD_E_BIT = 0;
                            324 ;     genAssign
   0ABF C2 A4               325 	clr	_P2_4
                            326 ;src/lcd.c:79: lcd_delay(ENABLE_DELAY);
                            327 ;     genCall
                            328 ;       Peephole 182.b  used 16 bit load of dptr
   0AC1 90 01 2C            329 	mov     dptr,#0x012C
   0AC4 12 0A 83            330 	lcall	_lcd_delay
   0AC7                     331 00101$:
   0AC7 85 40 81            332 	mov	sp,_bp
   0ACA D0 40               333 	pop	_bp
   0ACC 22                  334 	ret
                            335 ;------------------------------------------------------------
                            336 ;Allocation info for local variables in function 'lcd_goto_xy'
                            337 ;------------------------------------------------------------
                            338 ;y                         Allocated to stack - offset -3
                            339 ;x                         Allocated to registers r2 
                            340 ;------------------------------------------------------------
                            341 ;src/lcd.c:82: void lcd_goto_xy (const char x, const char y) reentrant
                            342 ;	-----------------------------------------
                            343 ;	 function lcd_goto_xy
                            344 ;	-----------------------------------------
   0ACD                     345 _lcd_goto_xy:
   0ACD C0 40               346 	push	_bp
   0ACF 85 81 40            347 	mov	_bp,sp
                            348 ;     genReceive
   0AD2 AA 82               349 	mov	r2,dpl
                            350 ;src/lcd.c:84: if (y == 0)
                            351 ;     genCmpEq
   0AD4 E5 40               352 	mov	a,_bp
   0AD6 24 FD               353 	add	a,#0xfd
   0AD8 F8                  354 	mov	r0,a
                            355 ;       Peephole 112.b  changed ljmp to sjmp
                            356 ;       Peephole 199    optimized misc jump sequence
   0AD9 B6 00 10            357 	cjne    @r0,#0x00,00102$
                            358 ;00107$:
                            359 ;       Peephole 200    removed redundant sjmp
   0ADC                     360 00108$:
                            361 ;src/lcd.c:86: lcd_put_command(x+0x80);
                            362 ;     genPlus
   0ADC 74 80               363 	mov	a,#0x80
                            364 ;       Peephole 236.a  used r2 instead of ar2
   0ADE 2A                  365 	add     a,r2
   0ADF F5 82               366 	mov	dpl,a
                            367 ;     genIpush
   0AE1 74 01               368 	mov	a,#0x01
   0AE3 C0 E0               369 	push	acc
                            370 ;     genCall
   0AE5 12 0B 05            371 	lcall	_lcd_put
   0AE8 15 81               372 	dec	sp
                            373 ;       Peephole 112.b  changed ljmp to sjmp
   0AEA 80 13               374 	sjmp    00104$
   0AEC                     375 00102$:
                            376 ;src/lcd.c:90: lcd_put_command(x+0x80+0x40);
                            377 ;     genCast
   0AEC EA                  378 	mov	a,r2
   0AED 33                  379 	rlc	a
   0AEE 95 E0               380 	subb	a,acc
   0AF0 FB                  381 	mov	r3,a
                            382 ;     genCast
                            383 ;     genPlus
   0AF1 74 C0               384 	mov	a,#0xC0
                            385 ;       Peephole 236.a  used r2 instead of ar2
   0AF3 2A                  386 	add     a,r2
   0AF4 F5 82               387 	mov	dpl,a
                            388 ;     genIpush
   0AF6 74 01               389 	mov	a,#0x01
   0AF8 C0 E0               390 	push	acc
                            391 ;     genCall
   0AFA 12 0B 05            392 	lcall	_lcd_put
   0AFD 15 81               393 	dec	sp
   0AFF                     394 00104$:
   0AFF 85 40 81            395 	mov	sp,_bp
   0B02 D0 40               396 	pop	_bp
   0B04 22                  397 	ret
                            398 ;------------------------------------------------------------
                            399 ;Allocation info for local variables in function 'lcd_put'
                            400 ;------------------------------------------------------------
                            401 ;command                   Allocated to stack - offset -3
                            402 ;value                     Allocated to registers r2 
                            403 ;------------------------------------------------------------
                            404 ;src/lcd.c:94: void lcd_put ( char value, BOOL command ) reentrant
                            405 ;	-----------------------------------------
                            406 ;	 function lcd_put
                            407 ;	-----------------------------------------
   0B05                     408 _lcd_put:
   0B05 C0 40               409 	push	_bp
   0B07 85 81 40            410 	mov	_bp,sp
                            411 ;     genReceive
   0B0A AA 82               412 	mov	r2,dpl
                            413 ;src/lcd.c:96: if ( command ) 
                            414 ;     genIfx
   0B0C E5 40               415 	mov	a,_bp
   0B0E 24 FD               416 	add	a,#0xfd
   0B10 F8                  417 	mov	r0,a
   0B11 E6                  418 	mov	a,@r0
                            419 ;     genIfxJump
                            420 ;       Peephole 110    removed ljmp by inverse jump logic
   0B12 60 2B               421 	jz      00102$
   0B14                     422 00107$:
                            423 ;src/lcd.c:98: LCD_CTRL_PORT = (( value >> 4 ) & 0x0f ) | LCD_CTRL_PORT&0x80;
                            424 ;     genRightShift
                            425 ;     genSignedRightShift
                            426 ;     genRightShiftLiteral
                            427 ;     genrshOne
   0B14 EA                  428 	mov	a,r2
   0B15 C4                  429 	swap	a
   0B16 54 0F               430 	anl	a,#0x0f
   0B18 30 E3 02            431 	jnb	acc.3,00108$
   0B1B 44 F0               432 	orl	a,#0xf0
   0B1D                     433 00108$:
   0B1D FB                  434 	mov	r3,a
                            435 ;     genAnd
   0B1E 53 03 0F            436 	anl	ar3,#0x0F
                            437 ;     genAnd
   0B21 74 80               438 	mov	a,#0x80
   0B23 55 A0               439 	anl	a,_P2
                            440 ;     genOr
   0B25 4B                  441 	orl	a,r3
   0B26 F5 A0               442 	mov	_P2,a
                            443 ;src/lcd.c:99: enable();
                            444 ;     genCall
   0B28 C0 02               445 	push	ar2
   0B2A 12 0A B2            446 	lcall	_enable
   0B2D D0 02               447 	pop	ar2
                            448 ;src/lcd.c:100: LCD_CTRL_PORT = ( value & 0x0f ) | LCD_CTRL_PORT&0x80;
                            449 ;     genAnd
   0B2F 74 0F               450 	mov	a,#0x0F
   0B31 5A                  451 	anl	a,r2
   0B32 FB                  452 	mov	r3,a
                            453 ;     genAnd
   0B33 74 80               454 	mov	a,#0x80
   0B35 55 A0               455 	anl	a,_P2
                            456 ;     genOr
   0B37 4B                  457 	orl	a,r3
   0B38 F5 A0               458 	mov	_P2,a
                            459 ;src/lcd.c:101: enable();
                            460 ;     genCall
   0B3A 12 0A B2            461 	lcall	_enable
                            462 ;       Peephole 112.b  changed ljmp to sjmp
   0B3D 80 30               463 	sjmp    00104$
   0B3F                     464 00102$:
                            465 ;src/lcd.c:105: LCD_CTRL_PORT = ( ( value >> 4 ) & 0x0f ) | LCD_RS_BIT_MASK | LCD_CTRL_PORT&0x80;
                            466 ;     genRightShift
                            467 ;     genSignedRightShift
                            468 ;     genRightShiftLiteral
                            469 ;     genrshOne
   0B3F EA                  470 	mov	a,r2
   0B40 C4                  471 	swap	a
   0B41 54 0F               472 	anl	a,#0x0f
   0B43 30 E3 02            473 	jnb	acc.3,00109$
   0B46 44 F0               474 	orl	a,#0xf0
   0B48                     475 00109$:
   0B48 FB                  476 	mov	r3,a
                            477 ;     genAnd
   0B49 74 0F               478 	mov	a,#0x0F
   0B4B 5B                  479 	anl	a,r3
                            480 ;     genOr
   0B4C 44 40               481 	orl	a,#0x40
   0B4E FB                  482 	mov	r3,a
                            483 ;     genAnd
   0B4F 74 80               484 	mov	a,#0x80
   0B51 55 A0               485 	anl	a,_P2
                            486 ;     genOr
   0B53 4B                  487 	orl	a,r3
   0B54 F5 A0               488 	mov	_P2,a
                            489 ;src/lcd.c:106: enable();
                            490 ;     genCall
   0B56 C0 02               491 	push	ar2
   0B58 12 0A B2            492 	lcall	_enable
   0B5B D0 02               493 	pop	ar2
                            494 ;src/lcd.c:107: LCD_CTRL_PORT = ( value & 0x0f ) | LCD_RS_BIT_MASK | LCD_CTRL_PORT&0x80;
                            495 ;     genAnd
   0B5D 74 0F               496 	mov	a,#0x0F
   0B5F 5A                  497 	anl	a,r2
                            498 ;     genOr
   0B60 44 40               499 	orl	a,#0x40
   0B62 FA                  500 	mov	r2,a
                            501 ;     genAnd
   0B63 74 80               502 	mov	a,#0x80
   0B65 55 A0               503 	anl	a,_P2
                            504 ;     genOr
   0B67 4A                  505 	orl	a,r2
   0B68 F5 A0               506 	mov	_P2,a
                            507 ;src/lcd.c:108: enable();
                            508 ;     genCall
   0B6A 12 0A B2            509 	lcall	_enable
                            510 ;src/lcd.c:109: LCD_RS_BIT = 0;
                            511 ;     genAssign
   0B6D C2 A6               512 	clr	_P2_6
   0B6F                     513 00104$:
   0B6F 85 40 81            514 	mov	sp,_bp
   0B72 D0 40               515 	pop	_bp
   0B74 22                  516 	ret
                            517 ;------------------------------------------------------------
                            518 ;Allocation info for local variables in function 'lcd_clear'
                            519 ;------------------------------------------------------------
                            520 ;------------------------------------------------------------
                            521 ;src/lcd.c:119: void lcd_clear ( void ) 
                            522 ;	-----------------------------------------
                            523 ;	 function lcd_clear
                            524 ;	-----------------------------------------
   0B75                     525 _lcd_clear:
   0B75 C0 40               526 	push	_bp
   0B77 85 81 40            527 	mov	_bp,sp
                            528 ;src/lcd.c:121: lcd_put_command( LCD_CLEAR );
                            529 ;     genIpush
   0B7A 74 01               530 	mov	a,#0x01
   0B7C C0 E0               531 	push	acc
                            532 ;     genCall
   0B7E 75 82 01            533 	mov	dpl,#0x01
   0B81 12 0B 05            534 	lcall	_lcd_put
   0B84 15 81               535 	dec	sp
   0B86                     536 00101$:
   0B86 85 40 81            537 	mov	sp,_bp
   0B89 D0 40               538 	pop	_bp
   0B8B 22                  539 	ret
                            540 ;------------------------------------------------------------
                            541 ;Allocation info for local variables in function 'lcd_home'
                            542 ;------------------------------------------------------------
                            543 ;------------------------------------------------------------
                            544 ;src/lcd.c:131: void lcd_home ( void ) 
                            545 ;	-----------------------------------------
                            546 ;	 function lcd_home
                            547 ;	-----------------------------------------
   0B8C                     548 _lcd_home:
   0B8C C0 40               549 	push	_bp
   0B8E 85 81 40            550 	mov	_bp,sp
                            551 ;src/lcd.c:133: lcd_put_command( LCD_HOME );
                            552 ;     genIpush
   0B91 74 01               553 	mov	a,#0x01
   0B93 C0 E0               554 	push	acc
                            555 ;     genCall
   0B95 75 82 02            556 	mov	dpl,#0x02
   0B98 12 0B 05            557 	lcall	_lcd_put
   0B9B 15 81               558 	dec	sp
   0B9D                     559 00101$:
   0B9D 85 40 81            560 	mov	sp,_bp
   0BA0 D0 40               561 	pop	_bp
   0BA2 22                  562 	ret
                            563 ;------------------------------------------------------------
                            564 ;Allocation info for local variables in function 'putchar'
                            565 ;------------------------------------------------------------
                            566 ;c                         Allocated to registers 
                            567 ;------------------------------------------------------------
                            568 ;src/lcd.c:136: void putchar(char c) 
                            569 ;	-----------------------------------------
                            570 ;	 function putchar
                            571 ;	-----------------------------------------
   0BA3                     572 _putchar:
   0BA3 C0 40               573 	push	_bp
   0BA5 85 81 40            574 	mov	_bp,sp
                            575 ;     genReceive
                            576 ;src/lcd.c:138: lcd_put_char(c);
                            577 ;     genIpush
                            578 ;       Peephole 181    changed mov to clr
   0BA8 E4                  579 	clr     a
   0BA9 C0 E0               580 	push	acc
                            581 ;     genCall
   0BAB 12 0B 05            582 	lcall	_lcd_put
   0BAE 15 81               583 	dec	sp
   0BB0                     584 00101$:
   0BB0 85 40 81            585 	mov	sp,_bp
   0BB3 D0 40               586 	pop	_bp
   0BB5 22                  587 	ret
                            588 ;------------------------------------------------------------
                            589 ;Allocation info for local variables in function 'lcd_put_string'
                            590 ;------------------------------------------------------------
                            591 ;value                     Allocated to registers r2 r3 r4 
                            592 ;i                         Allocated to registers 
                            593 ;------------------------------------------------------------
                            594 ;src/lcd.c:141: void lcd_put_string(const char *value) reentrant
                            595 ;	-----------------------------------------
                            596 ;	 function lcd_put_string
                            597 ;	-----------------------------------------
   0BB6                     598 _lcd_put_string:
   0BB6 C0 40               599 	push	_bp
   0BB8 85 81 40            600 	mov	_bp,sp
                            601 ;     genReceive
   0BBB AA 82               602 	mov	r2,dpl
   0BBD AB 83               603 	mov	r3,dph
   0BBF AC F0               604 	mov	r4,b
                            605 ;src/lcd.c:145: for(i=0; i<strlen(value); i++)
                            606 ;     genAssign
   0BC1 7D 00               607 	mov	r5,#0x00
   0BC3                     608 00101$:
                            609 ;     genCall
   0BC3 8A 82               610 	mov	dpl,r2
   0BC5 8B 83               611 	mov	dph,r3
   0BC7 8C F0               612 	mov	b,r4
   0BC9 C0 02               613 	push	ar2
   0BCB C0 03               614 	push	ar3
   0BCD C0 04               615 	push	ar4
   0BCF C0 05               616 	push	ar5
   0BD1 12 71 CD            617 	lcall	_strlen
   0BD4 AE 82               618 	mov	r6,dpl
   0BD6 AF 83               619 	mov	r7,dph
   0BD8 D0 05               620 	pop	ar5
   0BDA D0 04               621 	pop	ar4
   0BDC D0 03               622 	pop	ar3
   0BDE D0 02               623 	pop	ar2
                            624 ;     genCast
   0BE0 8D 00               625 	mov	ar0,r5
   0BE2 79 00               626 	mov	r1,#0x00
                            627 ;     genCmpLt
                            628 ;     genCmp
   0BE4 C3                  629 	clr	c
   0BE5 E8                  630 	mov	a,r0
   0BE6 9E                  631 	subb	a,r6
   0BE7 E9                  632 	mov	a,r1
   0BE8 64 80               633 	xrl	a,#0x80
   0BEA 8F F0               634 	mov	b,r7
   0BEC 63 F0 80            635 	xrl	b,#0x80
   0BEF 95 F0               636 	subb	a,b
                            637 ;     genIfxJump
                            638 ;       Peephole 108    removed ljmp by inverse jump logic
   0BF1 50 35               639 	jnc     00105$
   0BF3                     640 00109$:
                            641 ;src/lcd.c:147: SERVICE_WATCHDOG;
                            642 ;     genAssign
   0BF3 75 A6 1E            643 	mov	_WDTRST,#0x1E
                            644 ;     genAssign
   0BF6 75 A6 E1            645 	mov	_WDTRST,#0xE1
                            646 ;src/lcd.c:148: lcd_put_char(value[i]);
                            647 ;     genPlus
                            648 ;       Peephole 236.g  used r5 instead of ar5
   0BF9 ED                  649 	mov     a,r5
                            650 ;       Peephole 236.a  used r2 instead of ar2
   0BFA 2A                  651 	add     a,r2
   0BFB FE                  652 	mov	r6,a
                            653 ;       Peephole 181    changed mov to clr
   0BFC E4                  654 	clr     a
                            655 ;       Peephole 236.b  used r3 instead of ar3
   0BFD 3B                  656 	addc    a,r3
   0BFE FF                  657 	mov	r7,a
   0BFF 8C 00               658 	mov	ar0,r4
                            659 ;     genPointerGet
                            660 ;     genGenPointerGet
   0C01 8E 82               661 	mov	dpl,r6
   0C03 8F 83               662 	mov	dph,r7
   0C05 88 F0               663 	mov	b,r0
   0C07 12 71 F5            664 	lcall	__gptrget
   0C0A FE                  665 	mov	r6,a
                            666 ;     genIpush
   0C0B C0 02               667 	push	ar2
   0C0D C0 03               668 	push	ar3
   0C0F C0 04               669 	push	ar4
   0C11 C0 05               670 	push	ar5
                            671 ;       Peephole 181    changed mov to clr
   0C13 E4                  672 	clr     a
   0C14 C0 E0               673 	push	acc
                            674 ;     genCall
   0C16 8E 82               675 	mov	dpl,r6
   0C18 12 0B 05            676 	lcall	_lcd_put
   0C1B 15 81               677 	dec	sp
   0C1D D0 05               678 	pop	ar5
   0C1F D0 04               679 	pop	ar4
   0C21 D0 03               680 	pop	ar3
   0C23 D0 02               681 	pop	ar2
                            682 ;src/lcd.c:145: for(i=0; i<strlen(value); i++)
                            683 ;     genPlus
                            684 ;     genPlusIncr
   0C25 0D                  685 	inc	r5
                            686 ;       Peephole 112.b  changed ljmp to sjmp
   0C26 80 9B               687 	sjmp    00101$
   0C28                     688 00105$:
   0C28 85 40 81            689 	mov	sp,_bp
   0C2B D0 40               690 	pop	_bp
   0C2D 22                  691 	ret
                            692 ;------------------------------------------------------------
                            693 ;Allocation info for local variables in function 'lcd_cursor_on'
                            694 ;------------------------------------------------------------
                            695 ;------------------------------------------------------------
                            696 ;src/lcd.c:152: void lcd_cursor_on(void)
                            697 ;	-----------------------------------------
                            698 ;	 function lcd_cursor_on
                            699 ;	-----------------------------------------
   0C2E                     700 _lcd_cursor_on:
   0C2E C0 40               701 	push	_bp
   0C30 85 81 40            702 	mov	_bp,sp
                            703 ;src/lcd.c:154: lcd_put_command( LCD_CONTROL_ON | LCD_DISPLAY_ON | LCD_CURSOR_ON | LCD_BLINK_ON );
                            704 ;     genIpush
   0C33 74 01               705 	mov	a,#0x01
   0C35 C0 E0               706 	push	acc
                            707 ;     genCall
   0C37 75 82 0F            708 	mov	dpl,#0x0F
   0C3A 12 0B 05            709 	lcall	_lcd_put
   0C3D 15 81               710 	dec	sp
   0C3F                     711 00101$:
   0C3F 85 40 81            712 	mov	sp,_bp
   0C42 D0 40               713 	pop	_bp
   0C44 22                  714 	ret
                            715 ;------------------------------------------------------------
                            716 ;Allocation info for local variables in function 'lcd_cursor_off'
                            717 ;------------------------------------------------------------
                            718 ;------------------------------------------------------------
                            719 ;src/lcd.c:157: void lcd_cursor_off(void)
                            720 ;	-----------------------------------------
                            721 ;	 function lcd_cursor_off
                            722 ;	-----------------------------------------
   0C45                     723 _lcd_cursor_off:
   0C45 C0 40               724 	push	_bp
   0C47 85 81 40            725 	mov	_bp,sp
                            726 ;src/lcd.c:159: lcd_put_command( LCD_CONTROL_ON | LCD_DISPLAY_ON );
                            727 ;     genIpush
   0C4A 74 01               728 	mov	a,#0x01
   0C4C C0 E0               729 	push	acc
                            730 ;     genCall
   0C4E 75 82 0C            731 	mov	dpl,#0x0C
   0C51 12 0B 05            732 	lcall	_lcd_put
   0C54 15 81               733 	dec	sp
   0C56                     734 00101$:
   0C56 85 40 81            735 	mov	sp,_bp
   0C59 D0 40               736 	pop	_bp
   0C5B 22                  737 	ret
                            738 ;------------------------------------------------------------
                            739 ;Allocation info for local variables in function 'lcd_init'
                            740 ;------------------------------------------------------------
                            741 ;------------------------------------------------------------
                            742 ;src/lcd.c:174: void lcd_init ( void ) 
                            743 ;	-----------------------------------------
                            744 ;	 function lcd_init
                            745 ;	-----------------------------------------
   0C5C                     746 _lcd_init:
   0C5C C0 40               747 	push	_bp
   0C5E 85 81 40            748 	mov	_bp,sp
                            749 ;src/lcd.c:176: lcd_delay(ENABLE_DELAY_LONG);
                            750 ;     genCall
                            751 ;       Peephole 182.b  used 16 bit load of dptr
   0C61 90 0B B8            752 	mov     dptr,#0x0BB8
   0C64 12 0A 83            753 	lcall	_lcd_delay
                            754 ;src/lcd.c:177: LCD_CTRL_PORT = LCD_INIT_FOR_4_BITS;
                            755 ;     genAssign
   0C67 75 A0 03            756 	mov	_P2,#0x03
                            757 ;src/lcd.c:178: enable();
                            758 ;     genCall
   0C6A 12 0A B2            759 	lcall	_enable
                            760 ;src/lcd.c:180: lcd_delay(ENABLE_DELAY_LONG);
                            761 ;     genCall
                            762 ;       Peephole 182.b  used 16 bit load of dptr
   0C6D 90 0B B8            763 	mov     dptr,#0x0BB8
   0C70 12 0A 83            764 	lcall	_lcd_delay
                            765 ;src/lcd.c:181: LCD_CTRL_PORT = LCD_INIT_FOR_4_BITS;
                            766 ;     genAssign
   0C73 75 A0 03            767 	mov	_P2,#0x03
                            768 ;src/lcd.c:182: enable();
                            769 ;     genCall
   0C76 12 0A B2            770 	lcall	_enable
                            771 ;src/lcd.c:184: lcd_delay(ENABLE_DELAY_LONG);
                            772 ;     genCall
                            773 ;       Peephole 182.b  used 16 bit load of dptr
   0C79 90 0B B8            774 	mov     dptr,#0x0BB8
   0C7C 12 0A 83            775 	lcall	_lcd_delay
                            776 ;src/lcd.c:185: LCD_CTRL_PORT = LCD_INIT_FOR_4_BITS;
                            777 ;     genAssign
   0C7F 75 A0 03            778 	mov	_P2,#0x03
                            779 ;src/lcd.c:186: enable();
                            780 ;     genCall
   0C82 12 0A B2            781 	lcall	_enable
                            782 ;src/lcd.c:188: lcd_delay(ENABLE_DELAY_LONG);
                            783 ;     genCall
                            784 ;       Peephole 182.b  used 16 bit load of dptr
   0C85 90 0B B8            785 	mov     dptr,#0x0BB8
   0C88 12 0A 83            786 	lcall	_lcd_delay
                            787 ;src/lcd.c:189: LCD_CTRL_PORT = LCD_FUNCTION_SET; 
                            788 ;     genAssign
   0C8B 75 A0 02            789 	mov	_P2,#0x02
                            790 ;src/lcd.c:190: enable();
                            791 ;     genCall
   0C8E 12 0A B2            792 	lcall	_enable
                            793 ;src/lcd.c:192: lcd_delay(ENABLE_DELAY_LONG);
                            794 ;     genCall
                            795 ;       Peephole 182.b  used 16 bit load of dptr
   0C91 90 0B B8            796 	mov     dptr,#0x0BB8
   0C94 12 0A 83            797 	lcall	_lcd_delay
                            798 ;src/lcd.c:194: lcd_put_command( LCD_CONTROL_ON | LCD_DISPLAY_ON );
                            799 ;     genIpush
   0C97 74 01               800 	mov	a,#0x01
   0C99 C0 E0               801 	push	acc
                            802 ;     genCall
   0C9B 75 82 0C            803 	mov	dpl,#0x0C
   0C9E 12 0B 05            804 	lcall	_lcd_put
   0CA1 15 81               805 	dec	sp
                            806 ;src/lcd.c:195: lcd_clear();
                            807 ;     genCall
   0CA3 12 0B 75            808 	lcall	_lcd_clear
                            809 ;src/lcd.c:196: lcd_home();
                            810 ;     genCall
   0CA6 12 0B 8C            811 	lcall	_lcd_home
                            812 ;src/lcd.c:197: lcd_cursor_off();
                            813 ;     genCall
   0CA9 12 0C 45            814 	lcall	_lcd_cursor_off
                            815 ;src/lcd.c:200: lcd_delay(10000);
                            816 ;     genCall
                            817 ;       Peephole 182.b  used 16 bit load of dptr
   0CAC 90 27 10            818 	mov     dptr,#0x2710
   0CAF 12 0A 83            819 	lcall	_lcd_delay
   0CB2                     820 00101$:
   0CB2 85 40 81            821 	mov	sp,_bp
   0CB5 D0 40               822 	pop	_bp
   0CB7 22                  823 	ret
                            824 	.area CSEG    (CODE)
                            825 	.area XINIT   (CODE)
