                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.4.0 Thu Feb 10 12:42:19 2011
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module src/rtc
                              7 	.optsdcc -mmcs51 --model-small
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _monthDays
                             13 	.globl _day_full
                             14 	.globl _day
                             15 	.globl _month
                             16 	.globl _check_time
                             17 	.globl _rbyte_3w
                             18 	.globl _wbyte_3w
                             19 	.globl _reset_3w
                             20 	.globl _clear_time_struct
                             21 	.globl _ds1302_read_rtc
                             22 	.globl _ds1302_read_rtc_bcd
                             23 	.globl _ds1302_write_rtc
                             24 	.globl _bcd2bin
                             25 	.globl _local_gmtime
                             26 	.globl _local_mktime
                             27 	.globl _printf_asctime
                             28 	.globl _printf_short_asctime
                             29 	.globl _printf_date
                             30 	.globl _printf_weekday_short
                             31 	.globl _printf_day
                             32 	.globl _printf_time
                             33 	.globl _ds1302_write_memory
                             34 	.globl _ds1302_read_memory
                             35 ;--------------------------------------------------------
                             36 ; special function registers
                             37 ;--------------------------------------------------------
                    0080     38 _P0	=	0x0080
                    0081     39 _SP	=	0x0081
                    0082     40 _DPL	=	0x0082
                    0083     41 _DPH	=	0x0083
                    0087     42 _PCON	=	0x0087
                    0088     43 _TCON	=	0x0088
                    0089     44 _TMOD	=	0x0089
                    008A     45 _TL0	=	0x008a
                    008B     46 _TL1	=	0x008b
                    008C     47 _TH0	=	0x008c
                    008D     48 _TH1	=	0x008d
                    0090     49 _P1	=	0x0090
                    0098     50 _SCON	=	0x0098
                    0099     51 _SBUF	=	0x0099
                    00A0     52 _P2	=	0x00a0
                    00B0     53 _P3	=	0x00b0
                    00B8     54 _IP	=	0x00b8
                    00C8     55 _T2CON	=	0x00c8
                    00C9     56 _T2MOD	=	0x00c9
                    00CA     57 _RCAP2L	=	0x00ca
                    00CB     58 _RCAP2H	=	0x00cb
                    00CC     59 _TL2	=	0x00cc
                    00CD     60 _TH2	=	0x00cd
                    00D0     61 _PSW	=	0x00d0
                    00E0     62 _A	=	0x00e0
                    00A6     63 _WDTRST	=	0x00a6
                    00A7     64 _WDTPRG	=	0x00a7
                    00A2     65 _AUXR1	=	0x00a2
                    008E     66 _AUXR	=	0x008e
                    00B9     67 _SADEN	=	0x00b9
                    00BA     68 _SADEN_1	=	0x00ba
                    00B7     69 _IPH	=	0x00b7
                    00B7     70 _IPH0	=	0x00b7
                    00B8     71 _IPL	=	0x00b8
                    00B8     72 _IPL0	=	0x00b8
                    00A8     73 _IE	=	0x00a8
                    00A9     74 _SADDR	=	0x00a9
                    00AA     75 _SADDR_1	=	0x00aa
                    00D8     76 _CCON	=	0x00d8
                    00D9     77 _CMOD	=	0x00d9
                    00DA     78 _CCAPM0	=	0x00da
                    00DB     79 _CCAPM1	=	0x00db
                    00DC     80 _CCAPM2	=	0x00dc
                    00DD     81 _CCAPM3	=	0x00dd
                    00DE     82 _CCAPM4	=	0x00de
                    00E9     83 _CL	=	0x00e9
                    00EA     84 _CCAP0L	=	0x00ea
                    00EB     85 _CCAP1L	=	0x00eb
                    00EC     86 _CCAP2L	=	0x00ec
                    00ED     87 _CCAP3L	=	0x00ed
                    00EE     88 _CCAP4L	=	0x00ee
                    00E0     89 _ACC	=	0x00e0
                    00F0     90 _B	=	0x00f0
                    00F9     91 _CH	=	0x00f9
                    00FA     92 _CCAP0H	=	0x00fa
                    00FB     93 _CCAP1H	=	0x00fb
                    00FC     94 _CCAP2H	=	0x00fc
                    00FD     95 _CCAP3H	=	0x00fd
                    00FE     96 _CCAP4H	=	0x00fe
                    00FF     97 _ICON	=	0x00ff
                    0085     98 _CKSEL	=	0x0085
                    0086     99 _OSCCON	=	0x0086
                    00D1    100 _FCON	=	0x00d1
                    00D2    101 _EECON	=	0x00d2
                    00D3    102 _EETIM	=	0x00d3
                            103 ;--------------------------------------------------------
                            104 ; special function bits 
                            105 ;--------------------------------------------------------
                    0080    106 _P0_0	=	0x0080
                    0081    107 _P0_1	=	0x0081
                    0082    108 _P0_2	=	0x0082
                    0083    109 _P0_3	=	0x0083
                    0084    110 _P0_4	=	0x0084
                    0085    111 _P0_5	=	0x0085
                    0086    112 _P0_6	=	0x0086
                    0087    113 _P0_7	=	0x0087
                    00A7    114 _ENBOOT	=	0x00a7
                    0088    115 _IT0	=	0x0088
                    0089    116 _IE0	=	0x0089
                    008A    117 _IT1	=	0x008a
                    008B    118 _IE1	=	0x008b
                    008C    119 _TR0	=	0x008c
                    008D    120 _TF0	=	0x008d
                    008E    121 _TR1	=	0x008e
                    008F    122 _TF1	=	0x008f
                    0090    123 _P1_0	=	0x0090
                    0091    124 _P1_1	=	0x0091
                    0092    125 _P1_2	=	0x0092
                    0093    126 _P1_3	=	0x0093
                    0094    127 _P1_4	=	0x0094
                    0095    128 _P1_5	=	0x0095
                    0096    129 _P1_6	=	0x0096
                    0097    130 _P1_7	=	0x0097
                    0090    131 _T2	=	0x0090
                    0091    132 _T2EX	=	0x0091
                    0098    133 _RI	=	0x0098
                    0099    134 _TI	=	0x0099
                    009A    135 _RB8	=	0x009a
                    009B    136 _TB8	=	0x009b
                    009C    137 _REN	=	0x009c
                    009D    138 _SM2	=	0x009d
                    009E    139 _SM1	=	0x009e
                    009F    140 _SM0	=	0x009f
                    00A0    141 _P2_0	=	0x00a0
                    00A1    142 _P2_1	=	0x00a1
                    00A2    143 _P2_2	=	0x00a2
                    00A3    144 _P2_3	=	0x00a3
                    00A4    145 _P2_4	=	0x00a4
                    00A5    146 _P2_5	=	0x00a5
                    00A6    147 _P2_6	=	0x00a6
                    00A7    148 _P2_7	=	0x00a7
                    00B0    149 _P3_0	=	0x00b0
                    00B1    150 _P3_1	=	0x00b1
                    00B2    151 _P3_2	=	0x00b2
                    00B3    152 _P3_3	=	0x00b3
                    00B4    153 _P3_4	=	0x00b4
                    00B5    154 _P3_5	=	0x00b5
                    00B6    155 _P3_6	=	0x00b6
                    00B7    156 _P3_7	=	0x00b7
                    00B0    157 _RXD	=	0x00b0
                    00B1    158 _TXD	=	0x00b1
                    00B2    159 _INT0	=	0x00b2
                    00B3    160 _INT1	=	0x00b3
                    00B4    161 _T0	=	0x00b4
                    00B5    162 _T1	=	0x00b5
                    00B6    163 _WR	=	0x00b6
                    00B7    164 _RD	=	0x00b7
                    00B8    165 _PX0	=	0x00b8
                    00B9    166 _PT0	=	0x00b9
                    00BA    167 _PX1	=	0x00ba
                    00BB    168 _PT1	=	0x00bb
                    00BC    169 _PS	=	0x00bc
                    00BD    170 _PT2	=	0x00bd
                    00C8    171 _T2CON_0	=	0x00c8
                    00C9    172 _T2CON_1	=	0x00c9
                    00CA    173 _T2CON_2	=	0x00ca
                    00CB    174 _T2CON_3	=	0x00cb
                    00CC    175 _T2CON_4	=	0x00cc
                    00CD    176 _T2CON_5	=	0x00cd
                    00CE    177 _T2CON_6	=	0x00ce
                    00CF    178 _T2CON_7	=	0x00cf
                    00C8    179 _CP_RL2	=	0x00c8
                    00C9    180 _C_T2	=	0x00c9
                    00CA    181 _TR2	=	0x00ca
                    00CB    182 _EXEN2	=	0x00cb
                    00CC    183 _TCLK	=	0x00cc
                    00CD    184 _RCLK	=	0x00cd
                    00CE    185 _EXF2	=	0x00ce
                    00CF    186 _TF2	=	0x00cf
                    00D0    187 _P	=	0x00d0
                    00D1    188 _FL	=	0x00d1
                    00D2    189 _OV	=	0x00d2
                    00D3    190 _RS0	=	0x00d3
                    00D4    191 _RS1	=	0x00d4
                    00D5    192 _F0	=	0x00d5
                    00D6    193 _AC	=	0x00d6
                    00D7    194 _CY	=	0x00d7
                    00AF    195 _EA	=	0x00af
                    00AE    196 _EC	=	0x00ae
                    00AD    197 _ET2	=	0x00ad
                    00AC    198 _ES	=	0x00ac
                    00AB    199 _ET1	=	0x00ab
                    00AA    200 _EX1	=	0x00aa
                    00A9    201 _ET0	=	0x00a9
                    00A8    202 _EX0	=	0x00a8
                    00DF    203 _CF	=	0x00df
                    00DE    204 _CR	=	0x00de
                    00DC    205 _CCF4	=	0x00dc
                    00DB    206 _CCF3	=	0x00db
                    00DA    207 _CCF2	=	0x00da
                    00D9    208 _CCF1	=	0x00d9
                    00D8    209 _CCF0	=	0x00d8
                            210 ;--------------------------------------------------------
                            211 ; overlayable register banks 
                            212 ;--------------------------------------------------------
                            213 	.area REG_BANK_0	(REL,OVR,DATA)
   0000                     214 	.ds 8
                            215 ;--------------------------------------------------------
                            216 ; internal ram data
                            217 ;--------------------------------------------------------
                            218 	.area DSEG    (DATA)
                            219 ;--------------------------------------------------------
                            220 ; overlayable items in internal ram 
                            221 ;--------------------------------------------------------
                            222 	.area OSEG    (OVR,DATA)
                            223 ;--------------------------------------------------------
                            224 ; indirectly addressable internal ram data
                            225 ;--------------------------------------------------------
                            226 	.area ISEG    (DATA)
                            227 ;--------------------------------------------------------
                            228 ; bit data
                            229 ;--------------------------------------------------------
                            230 	.area BSEG    (BIT)
                            231 ;--------------------------------------------------------
                            232 ; external ram data
                            233 ;--------------------------------------------------------
                            234 	.area XSEG    (XDATA)
                            235 ;--------------------------------------------------------
                            236 ; external initialized ram data
                            237 ;--------------------------------------------------------
                            238 	.area XISEG   (XDATA)
                            239 ;--------------------------------------------------------
                            240 ; global & static initialisations
                            241 ;--------------------------------------------------------
                            242 	.area GSINIT  (CODE)
                            243 	.area GSFINAL (CODE)
                            244 	.area GSINIT  (CODE)
                            245 ;--------------------------------------------------------
                            246 ; Home
                            247 ;--------------------------------------------------------
                            248 	.area HOME    (CODE)
                            249 	.area CSEG    (CODE)
                            250 ;--------------------------------------------------------
                            251 ; code
                            252 ;--------------------------------------------------------
                            253 	.area CSEG    (CODE)
                            254 ;------------------------------------------------------------
                            255 ;Allocation info for local variables in function 'reset_3w'
                            256 ;------------------------------------------------------------
                            257 ;------------------------------------------------------------
                            258 ;src/rtc.c:76: void reset_3w()
                            259 ;	-----------------------------------------
                            260 ;	 function reset_3w
                            261 ;	-----------------------------------------
   5DB4                     262 _reset_3w:
                    0002    263 	ar2 = 0x02
                    0003    264 	ar3 = 0x03
                    0004    265 	ar4 = 0x04
                    0005    266 	ar5 = 0x05
                    0006    267 	ar6 = 0x06
                    0007    268 	ar7 = 0x07
                    0000    269 	ar0 = 0x00
                    0001    270 	ar1 = 0x01
   5DB4 C0 40               271 	push	_bp
   5DB6 85 81 40            272 	mov	_bp,sp
                            273 ;src/rtc.c:78: SCLK = 0;
                            274 ;     genAssign
   5DB9 C2 96               275 	clr	_P1_6
                            276 ;src/rtc.c:79: RSTB = 0;
                            277 ;     genAssign
   5DBB C2 97               278 	clr	_P1_7
                            279 ;src/rtc.c:80: RSTB = 1;
                            280 ;     genAssign
   5DBD D2 97               281 	setb	_P1_7
   5DBF                     282 00101$:
   5DBF 85 40 81            283 	mov	sp,_bp
   5DC2 D0 40               284 	pop	_bp
   5DC4 22                  285 	ret
                            286 ;------------------------------------------------------------
                            287 ;Allocation info for local variables in function 'wbyte_3w'
                            288 ;------------------------------------------------------------
                            289 ;W_Byte                    Allocated to registers r2 
                            290 ;i                         Allocated to registers 
                            291 ;temp                      Allocated to registers r2 
                            292 ;------------------------------------------------------------
                            293 ;src/rtc.c:83: void wbyte_3w(uchar W_Byte)
                            294 ;	-----------------------------------------
                            295 ;	 function wbyte_3w
                            296 ;	-----------------------------------------
   5DC5                     297 _wbyte_3w:
   5DC5 C0 40               298 	push	_bp
   5DC7 85 81 40            299 	mov	_bp,sp
                            300 ;     genReceive
   5DCA AA 82               301 	mov	r2,dpl
                            302 ;src/rtc.c:88: temp = W_Byte;
                            303 ;     genAssign
                            304 ;src/rtc.c:90: for(i = 0; i < 8; ++i)
                            305 ;     genAssign
   5DCC 7B 00               306 	mov	r3,#0x00
   5DCE                     307 00103$:
                            308 ;     genCmpLt
                            309 ;     genCmp
   5DCE BB 08 00            310 	cjne	r3,#0x08,00112$
   5DD1                     311 00112$:
                            312 ;     genIfxJump
                            313 ;       Peephole 108    removed ljmp by inverse jump logic
   5DD1 50 13               314 	jnc     00107$
   5DD3                     315 00113$:
                            316 ;src/rtc.c:92: IO = 0;
                            317 ;     genAssign
   5DD3 C2 95               318 	clr	_P1_5
                            319 ;src/rtc.c:93: if(temp & 0x01)
                            320 ;     genAnd
   5DD5 EA                  321 	mov	a,r2
                            322 ;     genIfxJump
                            323 ;       Peephole 111    removed ljmp by inverse jump logic
   5DD6 30 E0 02            324 	jnb     acc.0,00102$
   5DD9                     325 00114$:
                            326 ;src/rtc.c:95: IO = 1;	/* set port pin high to read data */
                            327 ;     genAssign
   5DD9 D2 95               328 	setb	_P1_5
   5DDB                     329 00102$:
                            330 ;src/rtc.c:97: SCLK = 0;
                            331 ;     genAssign
   5DDB C2 96               332 	clr	_P1_6
                            333 ;src/rtc.c:98: SCLK = 1;
                            334 ;     genAssign
   5DDD D2 96               335 	setb	_P1_6
                            336 ;src/rtc.c:99: temp >>= 1;
                            337 ;     genRightShift
                            338 ;     genRightShiftLiteral
                            339 ;     genrshOne
   5DDF EA                  340 	mov	a,r2
   5DE0 C3                  341 	clr	c
   5DE1 13                  342 	rrc	a
   5DE2 FA                  343 	mov	r2,a
                            344 ;src/rtc.c:90: for(i = 0; i < 8; ++i)
                            345 ;     genPlus
                            346 ;     genPlusIncr
   5DE3 0B                  347 	inc	r3
                            348 ;       Peephole 112.b  changed ljmp to sjmp
   5DE4 80 E8               349 	sjmp    00103$
   5DE6                     350 00107$:
   5DE6 85 40 81            351 	mov	sp,_bp
   5DE9 D0 40               352 	pop	_bp
   5DEB 22                  353 	ret
                            354 ;------------------------------------------------------------
                            355 ;Allocation info for local variables in function 'rbyte_3w'
                            356 ;------------------------------------------------------------
                            357 ;i                         Allocated to registers 
                            358 ;R_Byte                    Allocated to registers r2 
                            359 ;TmpByte                   Allocated to registers r4 
                            360 ;------------------------------------------------------------
                            361 ;src/rtc.c:103: uchar rbyte_3w()
                            362 ;	-----------------------------------------
                            363 ;	 function rbyte_3w
                            364 ;	-----------------------------------------
   5DEC                     365 _rbyte_3w:
   5DEC C0 40               366 	push	_bp
   5DEE 85 81 40            367 	mov	_bp,sp
                            368 ;src/rtc.c:109: R_Byte = 0x00;
                            369 ;     genAssign
   5DF1 7A 00               370 	mov	r2,#0x00
                            371 ;src/rtc.c:110: IO = 1;
                            372 ;     genAssign
   5DF3 D2 95               373 	setb	_P1_5
                            374 ;src/rtc.c:111: for(i=0; i<8; ++i)
                            375 ;     genAssign
   5DF5 7B 00               376 	mov	r3,#0x00
   5DF7                     377 00101$:
                            378 ;     genCmpLt
                            379 ;     genCmp
   5DF7 BB 08 00            380 	cjne	r3,#0x08,00109$
   5DFA                     381 00109$:
                            382 ;     genIfxJump
                            383 ;       Peephole 108    removed ljmp by inverse jump logic
   5DFA 50 17               384 	jnc     00104$
   5DFC                     385 00110$:
                            386 ;src/rtc.c:113: SCLK = 1;
                            387 ;     genAssign
   5DFC D2 96               388 	setb	_P1_6
                            389 ;src/rtc.c:114: SCLK = 0;
                            390 ;     genAssign
   5DFE C2 96               391 	clr	_P1_6
                            392 ;src/rtc.c:115: TmpByte = (uchar)IO;
                            393 ;     genAssign
   5E00 E4                  394 	clr	a
   5E01 A2 95               395 	mov	c,_P1_5
   5E03 33                  396 	rlc	a
                            397 ;src/rtc.c:116: TmpByte <<= 7;
                            398 ;     genLeftShift
                            399 ;     genLeftShiftLiteral
                            400 ;     genlshOne
                            401 ;       Peephole 105    removed redundant mov
   5E04 FC                  402 	mov     r4,a
   5E05 03                  403 	rr	a
   5E06 54 80               404 	anl	a,#0x80
   5E08 FC                  405 	mov	r4,a
                            406 ;src/rtc.c:117: R_Byte >>= 1;
                            407 ;     genRightShift
                            408 ;     genRightShiftLiteral
                            409 ;     genrshOne
   5E09 EA                  410 	mov	a,r2
   5E0A C3                  411 	clr	c
   5E0B 13                  412 	rrc	a
   5E0C FA                  413 	mov	r2,a
                            414 ;src/rtc.c:118: R_Byte |= TmpByte; 
                            415 ;     genOr
   5E0D EC                  416 	mov	a,r4
   5E0E 42 02               417 	orl	ar2,a
                            418 ;src/rtc.c:111: for(i=0; i<8; ++i)
                            419 ;     genPlus
                            420 ;     genPlusIncr
   5E10 0B                  421 	inc	r3
                            422 ;       Peephole 112.b  changed ljmp to sjmp
   5E11 80 E4               423 	sjmp    00101$
   5E13                     424 00104$:
                            425 ;src/rtc.c:120: return R_Byte;
                            426 ;     genRet
   5E13 8A 82               427 	mov	dpl,r2
   5E15                     428 00105$:
   5E15 85 40 81            429 	mov	sp,_bp
   5E18 D0 40               430 	pop	_bp
   5E1A 22                  431 	ret
                            432 ;------------------------------------------------------------
                            433 ;Allocation info for local variables in function 'clear_time_struct'
                            434 ;------------------------------------------------------------
                            435 ;tm_time                   Allocated to registers r2 r3 r4 
                            436 ;------------------------------------------------------------
                            437 ;src/rtc.c:137: void clear_time_struct ( struct tm *tm_time )
                            438 ;	-----------------------------------------
                            439 ;	 function clear_time_struct
                            440 ;	-----------------------------------------
   5E1B                     441 _clear_time_struct:
   5E1B C0 40               442 	push	_bp
   5E1D 85 81 40            443 	mov	_bp,sp
                            444 ;     genReceive
                            445 ;src/rtc.c:139: tm_time->tm_sec = 0;
                            446 ;     genPointerSet
                            447 ;     genGenPointerSet
   5E20 AA 82               448 	mov     r2,dpl
   5E22 AB 83               449 	mov     r3,dph
   5E24 AC F0               450 	mov     r4,b
                            451 ;       Peephole 238.d  removed 3 redundant moves
                            452 ;       Peephole 181    changed mov to clr
   5E26 E4                  453 	clr     a
   5E27 12 70 71            454 	lcall	__gptrput
                            455 ;src/rtc.c:140: tm_time->tm_min = 0;
                            456 ;     genPlus
                            457 ;     genPlusIncr
   5E2A 74 01               458 	mov	a,#0x01
                            459 ;       Peephole 236.a  used r2 instead of ar2
   5E2C 2A                  460 	add     a,r2
   5E2D FD                  461 	mov	r5,a
                            462 ;       Peephole 181    changed mov to clr
   5E2E E4                  463 	clr     a
                            464 ;       Peephole 236.b  used r3 instead of ar3
   5E2F 3B                  465 	addc    a,r3
   5E30 FE                  466 	mov	r6,a
   5E31 8C 07               467 	mov	ar7,r4
                            468 ;     genPointerSet
                            469 ;     genGenPointerSet
   5E33 8D 82               470 	mov	dpl,r5
   5E35 8E 83               471 	mov	dph,r6
   5E37 8F F0               472 	mov	b,r7
                            473 ;       Peephole 181    changed mov to clr
   5E39 E4                  474 	clr     a
   5E3A 12 70 71            475 	lcall	__gptrput
                            476 ;src/rtc.c:141: tm_time->tm_hour = 0;
                            477 ;     genPlus
                            478 ;     genPlusIncr
   5E3D 74 02               479 	mov	a,#0x02
                            480 ;       Peephole 236.a  used r2 instead of ar2
   5E3F 2A                  481 	add     a,r2
   5E40 FD                  482 	mov	r5,a
                            483 ;       Peephole 181    changed mov to clr
   5E41 E4                  484 	clr     a
                            485 ;       Peephole 236.b  used r3 instead of ar3
   5E42 3B                  486 	addc    a,r3
   5E43 FE                  487 	mov	r6,a
   5E44 8C 07               488 	mov	ar7,r4
                            489 ;     genPointerSet
                            490 ;     genGenPointerSet
   5E46 8D 82               491 	mov	dpl,r5
   5E48 8E 83               492 	mov	dph,r6
   5E4A 8F F0               493 	mov	b,r7
                            494 ;       Peephole 181    changed mov to clr
   5E4C E4                  495 	clr     a
   5E4D 12 70 71            496 	lcall	__gptrput
                            497 ;src/rtc.c:142: tm_time->tm_mday = 1;
                            498 ;     genPlus
                            499 ;     genPlusIncr
   5E50 74 03               500 	mov	a,#0x03
                            501 ;       Peephole 236.a  used r2 instead of ar2
   5E52 2A                  502 	add     a,r2
   5E53 FD                  503 	mov	r5,a
                            504 ;       Peephole 181    changed mov to clr
   5E54 E4                  505 	clr     a
                            506 ;       Peephole 236.b  used r3 instead of ar3
   5E55 3B                  507 	addc    a,r3
   5E56 FE                  508 	mov	r6,a
   5E57 8C 07               509 	mov	ar7,r4
                            510 ;     genPointerSet
                            511 ;     genGenPointerSet
   5E59 8D 82               512 	mov	dpl,r5
   5E5B 8E 83               513 	mov	dph,r6
   5E5D 8F F0               514 	mov	b,r7
   5E5F 74 01               515 	mov	a,#0x01
   5E61 12 70 71            516 	lcall	__gptrput
                            517 ;src/rtc.c:143: tm_time->tm_mon = 0;
                            518 ;     genPlus
                            519 ;     genPlusIncr
   5E64 74 04               520 	mov	a,#0x04
                            521 ;       Peephole 236.a  used r2 instead of ar2
   5E66 2A                  522 	add     a,r2
   5E67 FD                  523 	mov	r5,a
                            524 ;       Peephole 181    changed mov to clr
   5E68 E4                  525 	clr     a
                            526 ;       Peephole 236.b  used r3 instead of ar3
   5E69 3B                  527 	addc    a,r3
   5E6A FE                  528 	mov	r6,a
   5E6B 8C 07               529 	mov	ar7,r4
                            530 ;     genPointerSet
                            531 ;     genGenPointerSet
   5E6D 8D 82               532 	mov	dpl,r5
   5E6F 8E 83               533 	mov	dph,r6
   5E71 8F F0               534 	mov	b,r7
                            535 ;       Peephole 181    changed mov to clr
   5E73 E4                  536 	clr     a
   5E74 12 70 71            537 	lcall	__gptrput
                            538 ;src/rtc.c:144: tm_time->tm_wday = 1;
                            539 ;     genPlus
   5E77 74 07               540 	mov	a,#0x07
                            541 ;       Peephole 236.a  used r2 instead of ar2
   5E79 2A                  542 	add     a,r2
   5E7A FD                  543 	mov	r5,a
                            544 ;       Peephole 181    changed mov to clr
   5E7B E4                  545 	clr     a
                            546 ;       Peephole 236.b  used r3 instead of ar3
   5E7C 3B                  547 	addc    a,r3
   5E7D FE                  548 	mov	r6,a
   5E7E 8C 07               549 	mov	ar7,r4
                            550 ;     genPointerSet
                            551 ;     genGenPointerSet
   5E80 8D 82               552 	mov	dpl,r5
   5E82 8E 83               553 	mov	dph,r6
   5E84 8F F0               554 	mov	b,r7
   5E86 74 01               555 	mov	a,#0x01
   5E88 12 70 71            556 	lcall	__gptrput
                            557 ;src/rtc.c:145: tm_time->tm_year = 0;
                            558 ;     genPlus
   5E8B 74 05               559 	mov	a,#0x05
                            560 ;       Peephole 236.a  used r2 instead of ar2
   5E8D 2A                  561 	add     a,r2
   5E8E FA                  562 	mov	r2,a
                            563 ;       Peephole 181    changed mov to clr
   5E8F E4                  564 	clr     a
                            565 ;       Peephole 236.b  used r3 instead of ar3
   5E90 3B                  566 	addc    a,r3
   5E91 FB                  567 	mov	r3,a
                            568 ;     genPointerSet
                            569 ;     genGenPointerSet
   5E92 8A 82               570 	mov	dpl,r2
   5E94 8B 83               571 	mov	dph,r3
   5E96 8C F0               572 	mov	b,r4
                            573 ;       Peephole 181    changed mov to clr
   5E98 E4                  574 	clr     a
   5E99 12 70 71            575 	lcall	__gptrput
   5E9C A3                  576 	inc	dptr
                            577 ;       Peephole 181    changed mov to clr
   5E9D E4                  578 	clr     a
   5E9E 12 70 71            579 	lcall	__gptrput
   5EA1                     580 00101$:
   5EA1 85 40 81            581 	mov	sp,_bp
   5EA4 D0 40               582 	pop	_bp
   5EA6 22                  583 	ret
                            584 ;------------------------------------------------------------
                            585 ;Allocation info for local variables in function 'ds1302_read_rtc'
                            586 ;------------------------------------------------------------
                            587 ;tm_time                   Allocated to registers r2 r3 r4 
                            588 ;------------------------------------------------------------
                            589 ;src/rtc.c:148: void ds1302_read_rtc ( struct tm *tm_time )
                            590 ;	-----------------------------------------
                            591 ;	 function ds1302_read_rtc
                            592 ;	-----------------------------------------
   5EA7                     593 _ds1302_read_rtc:
   5EA7 C0 40               594 	push	_bp
   5EA9 85 81 40            595 	mov	_bp,sp
                            596 ;     genReceive
   5EAC AA 82               597 	mov	r2,dpl
   5EAE AB 83               598 	mov	r3,dph
   5EB0 AC F0               599 	mov	r4,b
                            600 ;src/rtc.c:150: reset_3w();
                            601 ;     genCall
   5EB2 C0 02               602 	push	ar2
   5EB4 C0 03               603 	push	ar3
   5EB6 C0 04               604 	push	ar4
   5EB8 12 5D B4            605 	lcall	_reset_3w
   5EBB D0 04               606 	pop	ar4
   5EBD D0 03               607 	pop	ar3
   5EBF D0 02               608 	pop	ar2
                            609 ;src/rtc.c:151: wbyte_3w(RTC_BURST|0x01);
                            610 ;     genCall
   5EC1 75 82 BF            611 	mov	dpl,#0xBF
   5EC4 C0 02               612 	push	ar2
   5EC6 C0 03               613 	push	ar3
   5EC8 C0 04               614 	push	ar4
   5ECA 12 5D C5            615 	lcall	_wbyte_3w
   5ECD D0 04               616 	pop	ar4
   5ECF D0 03               617 	pop	ar3
   5ED1 D0 02               618 	pop	ar2
                            619 ;src/rtc.c:152: tm_time->tm_sec = bcd2bin(rbyte_3w()&0x7F);
                            620 ;     genCall
   5ED3 C0 02               621 	push	ar2
   5ED5 C0 03               622 	push	ar3
   5ED7 C0 04               623 	push	ar4
   5ED9 12 5D EC            624 	lcall	_rbyte_3w
   5EDC E5 82               625 	mov	a,dpl
   5EDE D0 04               626 	pop	ar4
   5EE0 D0 03               627 	pop	ar3
   5EE2 D0 02               628 	pop	ar2
                            629 ;     genAnd
   5EE4 54 7F               630 	anl	a,#0x7F
   5EE6 F5 82               631 	mov	dpl,a
                            632 ;     genCall
   5EE8 C0 02               633 	push	ar2
   5EEA C0 03               634 	push	ar3
   5EEC C0 04               635 	push	ar4
   5EEE 12 63 AC            636 	lcall	_bcd2bin
   5EF1 AD 82               637 	mov	r5,dpl
   5EF3 D0 04               638 	pop	ar4
   5EF5 D0 03               639 	pop	ar3
   5EF7 D0 02               640 	pop	ar2
                            641 ;     genPointerSet
                            642 ;     genGenPointerSet
   5EF9 8A 82               643 	mov	dpl,r2
   5EFB 8B 83               644 	mov	dph,r3
   5EFD 8C F0               645 	mov	b,r4
   5EFF ED                  646 	mov	a,r5
   5F00 12 70 71            647 	lcall	__gptrput
                            648 ;src/rtc.c:153: tm_time->tm_min = bcd2bin(rbyte_3w()&0x7F);
                            649 ;     genPlus
                            650 ;     genPlusIncr
   5F03 74 01               651 	mov	a,#0x01
                            652 ;       Peephole 236.a  used r2 instead of ar2
   5F05 2A                  653 	add     a,r2
   5F06 FD                  654 	mov	r5,a
                            655 ;       Peephole 181    changed mov to clr
   5F07 E4                  656 	clr     a
                            657 ;       Peephole 236.b  used r3 instead of ar3
   5F08 3B                  658 	addc    a,r3
   5F09 FE                  659 	mov	r6,a
   5F0A 8C 07               660 	mov	ar7,r4
                            661 ;     genCall
   5F0C C0 02               662 	push	ar2
   5F0E C0 03               663 	push	ar3
   5F10 C0 04               664 	push	ar4
   5F12 C0 05               665 	push	ar5
   5F14 C0 06               666 	push	ar6
   5F16 C0 07               667 	push	ar7
   5F18 12 5D EC            668 	lcall	_rbyte_3w
   5F1B E5 82               669 	mov	a,dpl
   5F1D D0 07               670 	pop	ar7
   5F1F D0 06               671 	pop	ar6
   5F21 D0 05               672 	pop	ar5
   5F23 D0 04               673 	pop	ar4
   5F25 D0 03               674 	pop	ar3
   5F27 D0 02               675 	pop	ar2
                            676 ;     genAnd
   5F29 54 7F               677 	anl	a,#0x7F
   5F2B F5 82               678 	mov	dpl,a
                            679 ;     genCall
   5F2D C0 02               680 	push	ar2
   5F2F C0 03               681 	push	ar3
   5F31 C0 04               682 	push	ar4
   5F33 C0 05               683 	push	ar5
   5F35 C0 06               684 	push	ar6
   5F37 C0 07               685 	push	ar7
   5F39 12 63 AC            686 	lcall	_bcd2bin
   5F3C A8 82               687 	mov	r0,dpl
   5F3E D0 07               688 	pop	ar7
   5F40 D0 06               689 	pop	ar6
   5F42 D0 05               690 	pop	ar5
   5F44 D0 04               691 	pop	ar4
   5F46 D0 03               692 	pop	ar3
   5F48 D0 02               693 	pop	ar2
                            694 ;     genPointerSet
                            695 ;     genGenPointerSet
   5F4A 8D 82               696 	mov	dpl,r5
   5F4C 8E 83               697 	mov	dph,r6
   5F4E 8F F0               698 	mov	b,r7
   5F50 E8                  699 	mov	a,r0
   5F51 12 70 71            700 	lcall	__gptrput
                            701 ;src/rtc.c:154: tm_time->tm_hour = bcd2bin(rbyte_3w()&0x3F);
                            702 ;     genPlus
                            703 ;     genPlusIncr
   5F54 74 02               704 	mov	a,#0x02
                            705 ;       Peephole 236.a  used r2 instead of ar2
   5F56 2A                  706 	add     a,r2
   5F57 FD                  707 	mov	r5,a
                            708 ;       Peephole 181    changed mov to clr
   5F58 E4                  709 	clr     a
                            710 ;       Peephole 236.b  used r3 instead of ar3
   5F59 3B                  711 	addc    a,r3
   5F5A FE                  712 	mov	r6,a
   5F5B 8C 07               713 	mov	ar7,r4
                            714 ;     genCall
   5F5D C0 02               715 	push	ar2
   5F5F C0 03               716 	push	ar3
   5F61 C0 04               717 	push	ar4
   5F63 C0 05               718 	push	ar5
   5F65 C0 06               719 	push	ar6
   5F67 C0 07               720 	push	ar7
   5F69 12 5D EC            721 	lcall	_rbyte_3w
   5F6C E5 82               722 	mov	a,dpl
   5F6E D0 07               723 	pop	ar7
   5F70 D0 06               724 	pop	ar6
   5F72 D0 05               725 	pop	ar5
   5F74 D0 04               726 	pop	ar4
   5F76 D0 03               727 	pop	ar3
   5F78 D0 02               728 	pop	ar2
                            729 ;     genAnd
   5F7A 54 3F               730 	anl	a,#0x3F
   5F7C F5 82               731 	mov	dpl,a
                            732 ;     genCall
   5F7E C0 02               733 	push	ar2
   5F80 C0 03               734 	push	ar3
   5F82 C0 04               735 	push	ar4
   5F84 C0 05               736 	push	ar5
   5F86 C0 06               737 	push	ar6
   5F88 C0 07               738 	push	ar7
   5F8A 12 63 AC            739 	lcall	_bcd2bin
   5F8D A8 82               740 	mov	r0,dpl
   5F8F D0 07               741 	pop	ar7
   5F91 D0 06               742 	pop	ar6
   5F93 D0 05               743 	pop	ar5
   5F95 D0 04               744 	pop	ar4
   5F97 D0 03               745 	pop	ar3
   5F99 D0 02               746 	pop	ar2
                            747 ;     genPointerSet
                            748 ;     genGenPointerSet
   5F9B 8D 82               749 	mov	dpl,r5
   5F9D 8E 83               750 	mov	dph,r6
   5F9F 8F F0               751 	mov	b,r7
   5FA1 E8                  752 	mov	a,r0
   5FA2 12 70 71            753 	lcall	__gptrput
                            754 ;src/rtc.c:155: tm_time->tm_mday = bcd2bin(rbyte_3w()&0x3F);
                            755 ;     genPlus
                            756 ;     genPlusIncr
   5FA5 74 03               757 	mov	a,#0x03
                            758 ;       Peephole 236.a  used r2 instead of ar2
   5FA7 2A                  759 	add     a,r2
   5FA8 FD                  760 	mov	r5,a
                            761 ;       Peephole 181    changed mov to clr
   5FA9 E4                  762 	clr     a
                            763 ;       Peephole 236.b  used r3 instead of ar3
   5FAA 3B                  764 	addc    a,r3
   5FAB FE                  765 	mov	r6,a
   5FAC 8C 07               766 	mov	ar7,r4
                            767 ;     genCall
   5FAE C0 02               768 	push	ar2
   5FB0 C0 03               769 	push	ar3
   5FB2 C0 04               770 	push	ar4
   5FB4 C0 05               771 	push	ar5
   5FB6 C0 06               772 	push	ar6
   5FB8 C0 07               773 	push	ar7
   5FBA 12 5D EC            774 	lcall	_rbyte_3w
   5FBD E5 82               775 	mov	a,dpl
   5FBF D0 07               776 	pop	ar7
   5FC1 D0 06               777 	pop	ar6
   5FC3 D0 05               778 	pop	ar5
   5FC5 D0 04               779 	pop	ar4
   5FC7 D0 03               780 	pop	ar3
   5FC9 D0 02               781 	pop	ar2
                            782 ;     genAnd
   5FCB 54 3F               783 	anl	a,#0x3F
   5FCD F5 82               784 	mov	dpl,a
                            785 ;     genCall
   5FCF C0 02               786 	push	ar2
   5FD1 C0 03               787 	push	ar3
   5FD3 C0 04               788 	push	ar4
   5FD5 C0 05               789 	push	ar5
   5FD7 C0 06               790 	push	ar6
   5FD9 C0 07               791 	push	ar7
   5FDB 12 63 AC            792 	lcall	_bcd2bin
   5FDE A8 82               793 	mov	r0,dpl
   5FE0 D0 07               794 	pop	ar7
   5FE2 D0 06               795 	pop	ar6
   5FE4 D0 05               796 	pop	ar5
   5FE6 D0 04               797 	pop	ar4
   5FE8 D0 03               798 	pop	ar3
   5FEA D0 02               799 	pop	ar2
                            800 ;     genPointerSet
                            801 ;     genGenPointerSet
   5FEC 8D 82               802 	mov	dpl,r5
   5FEE 8E 83               803 	mov	dph,r6
   5FF0 8F F0               804 	mov	b,r7
   5FF2 E8                  805 	mov	a,r0
   5FF3 12 70 71            806 	lcall	__gptrput
                            807 ;src/rtc.c:156: tm_time->tm_mon = bcd2bin(rbyte_3w()&0x1F);
                            808 ;     genPlus
                            809 ;     genPlusIncr
   5FF6 74 04               810 	mov	a,#0x04
                            811 ;       Peephole 236.a  used r2 instead of ar2
   5FF8 2A                  812 	add     a,r2
   5FF9 FD                  813 	mov	r5,a
                            814 ;       Peephole 181    changed mov to clr
   5FFA E4                  815 	clr     a
                            816 ;       Peephole 236.b  used r3 instead of ar3
   5FFB 3B                  817 	addc    a,r3
   5FFC FE                  818 	mov	r6,a
   5FFD 8C 07               819 	mov	ar7,r4
                            820 ;     genCall
   5FFF C0 02               821 	push	ar2
   6001 C0 03               822 	push	ar3
   6003 C0 04               823 	push	ar4
   6005 C0 05               824 	push	ar5
   6007 C0 06               825 	push	ar6
   6009 C0 07               826 	push	ar7
   600B 12 5D EC            827 	lcall	_rbyte_3w
   600E E5 82               828 	mov	a,dpl
   6010 D0 07               829 	pop	ar7
   6012 D0 06               830 	pop	ar6
   6014 D0 05               831 	pop	ar5
   6016 D0 04               832 	pop	ar4
   6018 D0 03               833 	pop	ar3
   601A D0 02               834 	pop	ar2
                            835 ;     genAnd
   601C 54 1F               836 	anl	a,#0x1F
   601E F5 82               837 	mov	dpl,a
                            838 ;     genCall
   6020 C0 02               839 	push	ar2
   6022 C0 03               840 	push	ar3
   6024 C0 04               841 	push	ar4
   6026 C0 05               842 	push	ar5
   6028 C0 06               843 	push	ar6
   602A C0 07               844 	push	ar7
   602C 12 63 AC            845 	lcall	_bcd2bin
   602F A8 82               846 	mov	r0,dpl
   6031 D0 07               847 	pop	ar7
   6033 D0 06               848 	pop	ar6
   6035 D0 05               849 	pop	ar5
   6037 D0 04               850 	pop	ar4
   6039 D0 03               851 	pop	ar3
   603B D0 02               852 	pop	ar2
                            853 ;     genPointerSet
                            854 ;     genGenPointerSet
   603D 8D 82               855 	mov	dpl,r5
   603F 8E 83               856 	mov	dph,r6
   6041 8F F0               857 	mov	b,r7
   6043 E8                  858 	mov	a,r0
   6044 12 70 71            859 	lcall	__gptrput
                            860 ;src/rtc.c:157: tm_time->tm_wday = bcd2bin(rbyte_3w()&0x7);
                            861 ;     genPlus
   6047 74 07               862 	mov	a,#0x07
                            863 ;       Peephole 236.a  used r2 instead of ar2
   6049 2A                  864 	add     a,r2
   604A FD                  865 	mov	r5,a
                            866 ;       Peephole 181    changed mov to clr
   604B E4                  867 	clr     a
                            868 ;       Peephole 236.b  used r3 instead of ar3
   604C 3B                  869 	addc    a,r3
   604D FE                  870 	mov	r6,a
   604E 8C 07               871 	mov	ar7,r4
                            872 ;     genCall
   6050 C0 02               873 	push	ar2
   6052 C0 03               874 	push	ar3
   6054 C0 04               875 	push	ar4
   6056 C0 05               876 	push	ar5
   6058 C0 06               877 	push	ar6
   605A C0 07               878 	push	ar7
   605C 12 5D EC            879 	lcall	_rbyte_3w
   605F E5 82               880 	mov	a,dpl
   6061 D0 07               881 	pop	ar7
   6063 D0 06               882 	pop	ar6
   6065 D0 05               883 	pop	ar5
   6067 D0 04               884 	pop	ar4
   6069 D0 03               885 	pop	ar3
   606B D0 02               886 	pop	ar2
                            887 ;     genAnd
   606D 54 07               888 	anl	a,#0x07
   606F F5 82               889 	mov	dpl,a
                            890 ;     genCall
   6071 C0 02               891 	push	ar2
   6073 C0 03               892 	push	ar3
   6075 C0 04               893 	push	ar4
   6077 C0 05               894 	push	ar5
   6079 C0 06               895 	push	ar6
   607B C0 07               896 	push	ar7
   607D 12 63 AC            897 	lcall	_bcd2bin
   6080 A8 82               898 	mov	r0,dpl
   6082 D0 07               899 	pop	ar7
   6084 D0 06               900 	pop	ar6
   6086 D0 05               901 	pop	ar5
   6088 D0 04               902 	pop	ar4
   608A D0 03               903 	pop	ar3
   608C D0 02               904 	pop	ar2
                            905 ;     genPointerSet
                            906 ;     genGenPointerSet
   608E 8D 82               907 	mov	dpl,r5
   6090 8E 83               908 	mov	dph,r6
   6092 8F F0               909 	mov	b,r7
   6094 E8                  910 	mov	a,r0
   6095 12 70 71            911 	lcall	__gptrput
                            912 ;src/rtc.c:158: tm_time->tm_year = bcd2bin(rbyte_3w());
                            913 ;     genPlus
   6098 74 05               914 	mov	a,#0x05
                            915 ;       Peephole 236.a  used r2 instead of ar2
   609A 2A                  916 	add     a,r2
   609B FA                  917 	mov	r2,a
                            918 ;       Peephole 181    changed mov to clr
   609C E4                  919 	clr     a
                            920 ;       Peephole 236.b  used r3 instead of ar3
   609D 3B                  921 	addc    a,r3
   609E FB                  922 	mov	r3,a
                            923 ;     genCall
   609F C0 02               924 	push	ar2
   60A1 C0 03               925 	push	ar3
   60A3 C0 04               926 	push	ar4
   60A5 12 5D EC            927 	lcall	_rbyte_3w
   60A8 D0 04               928 	pop	ar4
   60AA D0 03               929 	pop	ar3
   60AC D0 02               930 	pop	ar2
                            931 ;     genCall
   60AE C0 02               932 	push	ar2
   60B0 C0 03               933 	push	ar3
   60B2 C0 04               934 	push	ar4
   60B4 12 63 AC            935 	lcall	_bcd2bin
   60B7 AD 82               936 	mov	r5,dpl
   60B9 D0 04               937 	pop	ar4
   60BB D0 03               938 	pop	ar3
   60BD D0 02               939 	pop	ar2
                            940 ;     genCast
   60BF 7E 00               941 	mov	r6,#0x00
                            942 ;     genPointerSet
                            943 ;     genGenPointerSet
   60C1 8A 82               944 	mov	dpl,r2
   60C3 8B 83               945 	mov	dph,r3
   60C5 8C F0               946 	mov	b,r4
   60C7 ED                  947 	mov	a,r5
   60C8 12 70 71            948 	lcall	__gptrput
   60CB A3                  949 	inc	dptr
   60CC EE                  950 	mov	a,r6
   60CD 12 70 71            951 	lcall	__gptrput
                            952 ;src/rtc.c:160: rbyte_3w();
                            953 ;     genCall
   60D0 12 5D EC            954 	lcall	_rbyte_3w
                            955 ;src/rtc.c:161: reset_3w();
                            956 ;     genCall
   60D3 12 5D B4            957 	lcall	_reset_3w
   60D6                     958 00101$:
   60D6 85 40 81            959 	mov	sp,_bp
   60D9 D0 40               960 	pop	_bp
   60DB 22                  961 	ret
                            962 ;------------------------------------------------------------
                            963 ;Allocation info for local variables in function 'ds1302_read_rtc_bcd'
                            964 ;------------------------------------------------------------
                            965 ;tm_time                   Allocated to registers r2 r3 r4 
                            966 ;------------------------------------------------------------
                            967 ;src/rtc.c:164: void ds1302_read_rtc_bcd ( struct tm *tm_time )
                            968 ;	-----------------------------------------
                            969 ;	 function ds1302_read_rtc_bcd
                            970 ;	-----------------------------------------
   60DC                     971 _ds1302_read_rtc_bcd:
   60DC C0 40               972 	push	_bp
   60DE 85 81 40            973 	mov	_bp,sp
                            974 ;     genReceive
   60E1 AA 82               975 	mov	r2,dpl
   60E3 AB 83               976 	mov	r3,dph
   60E5 AC F0               977 	mov	r4,b
                            978 ;src/rtc.c:166: reset_3w();
                            979 ;     genCall
   60E7 C0 02               980 	push	ar2
   60E9 C0 03               981 	push	ar3
   60EB C0 04               982 	push	ar4
   60ED 12 5D B4            983 	lcall	_reset_3w
   60F0 D0 04               984 	pop	ar4
   60F2 D0 03               985 	pop	ar3
   60F4 D0 02               986 	pop	ar2
                            987 ;src/rtc.c:167: wbyte_3w(RTC_BURST|0x01);
                            988 ;     genCall
   60F6 75 82 BF            989 	mov	dpl,#0xBF
   60F9 C0 02               990 	push	ar2
   60FB C0 03               991 	push	ar3
   60FD C0 04               992 	push	ar4
   60FF 12 5D C5            993 	lcall	_wbyte_3w
   6102 D0 04               994 	pop	ar4
   6104 D0 03               995 	pop	ar3
   6106 D0 02               996 	pop	ar2
                            997 ;src/rtc.c:168: tm_time->tm_sec =  rbyte_3w()&0x7F;
                            998 ;     genCall
   6108 C0 02               999 	push	ar2
   610A C0 03              1000 	push	ar3
   610C C0 04              1001 	push	ar4
   610E 12 5D EC           1002 	lcall	_rbyte_3w
   6111 E5 82              1003 	mov	a,dpl
   6113 D0 04              1004 	pop	ar4
   6115 D0 03              1005 	pop	ar3
   6117 D0 02              1006 	pop	ar2
                           1007 ;     genAnd
   6119 54 7F              1008 	anl	a,#0x7F
                           1009 ;     genPointerSet
                           1010 ;     genGenPointerSet
                           1011 ;       Peephole 191    removed redundant mov
   611B FD                 1012 	mov     r5,a
   611C 8A 82              1013 	mov     dpl,r2
   611E 8B 83              1014 	mov     dph,r3
   6120 8C F0              1015 	mov     b,r4
   6122 12 70 71           1016 	lcall	__gptrput
                           1017 ;src/rtc.c:169: tm_time->tm_min =  rbyte_3w()&0x7F;
                           1018 ;     genPlus
                           1019 ;     genPlusIncr
   6125 74 01              1020 	mov	a,#0x01
                           1021 ;       Peephole 236.a  used r2 instead of ar2
   6127 2A                 1022 	add     a,r2
   6128 FD                 1023 	mov	r5,a
                           1024 ;       Peephole 181    changed mov to clr
   6129 E4                 1025 	clr     a
                           1026 ;       Peephole 236.b  used r3 instead of ar3
   612A 3B                 1027 	addc    a,r3
   612B FE                 1028 	mov	r6,a
   612C 8C 07              1029 	mov	ar7,r4
                           1030 ;     genCall
   612E C0 02              1031 	push	ar2
   6130 C0 03              1032 	push	ar3
   6132 C0 04              1033 	push	ar4
   6134 C0 05              1034 	push	ar5
   6136 C0 06              1035 	push	ar6
   6138 C0 07              1036 	push	ar7
   613A 12 5D EC           1037 	lcall	_rbyte_3w
   613D E5 82              1038 	mov	a,dpl
   613F D0 07              1039 	pop	ar7
   6141 D0 06              1040 	pop	ar6
   6143 D0 05              1041 	pop	ar5
   6145 D0 04              1042 	pop	ar4
   6147 D0 03              1043 	pop	ar3
   6149 D0 02              1044 	pop	ar2
                           1045 ;     genAnd
   614B 54 7F              1046 	anl	a,#0x7F
                           1047 ;     genPointerSet
                           1048 ;     genGenPointerSet
                           1049 ;       Peephole 191    removed redundant mov
   614D F8                 1050 	mov     r0,a
   614E 8D 82              1051 	mov     dpl,r5
   6150 8E 83              1052 	mov     dph,r6
   6152 8F F0              1053 	mov     b,r7
   6154 12 70 71           1054 	lcall	__gptrput
                           1055 ;src/rtc.c:170: tm_time->tm_hour = rbyte_3w()&0x3F;
                           1056 ;     genPlus
                           1057 ;     genPlusIncr
   6157 74 02              1058 	mov	a,#0x02
                           1059 ;       Peephole 236.a  used r2 instead of ar2
   6159 2A                 1060 	add     a,r2
   615A FD                 1061 	mov	r5,a
                           1062 ;       Peephole 181    changed mov to clr
   615B E4                 1063 	clr     a
                           1064 ;       Peephole 236.b  used r3 instead of ar3
   615C 3B                 1065 	addc    a,r3
   615D FE                 1066 	mov	r6,a
   615E 8C 07              1067 	mov	ar7,r4
                           1068 ;     genCall
   6160 C0 02              1069 	push	ar2
   6162 C0 03              1070 	push	ar3
   6164 C0 04              1071 	push	ar4
   6166 C0 05              1072 	push	ar5
   6168 C0 06              1073 	push	ar6
   616A C0 07              1074 	push	ar7
   616C 12 5D EC           1075 	lcall	_rbyte_3w
   616F E5 82              1076 	mov	a,dpl
   6171 D0 07              1077 	pop	ar7
   6173 D0 06              1078 	pop	ar6
   6175 D0 05              1079 	pop	ar5
   6177 D0 04              1080 	pop	ar4
   6179 D0 03              1081 	pop	ar3
   617B D0 02              1082 	pop	ar2
                           1083 ;     genAnd
   617D 54 3F              1084 	anl	a,#0x3F
                           1085 ;     genPointerSet
                           1086 ;     genGenPointerSet
                           1087 ;       Peephole 191    removed redundant mov
   617F F8                 1088 	mov     r0,a
   6180 8D 82              1089 	mov     dpl,r5
   6182 8E 83              1090 	mov     dph,r6
   6184 8F F0              1091 	mov     b,r7
   6186 12 70 71           1092 	lcall	__gptrput
                           1093 ;src/rtc.c:171: tm_time->tm_mday = rbyte_3w()&0x3F;
                           1094 ;     genPlus
                           1095 ;     genPlusIncr
   6189 74 03              1096 	mov	a,#0x03
                           1097 ;       Peephole 236.a  used r2 instead of ar2
   618B 2A                 1098 	add     a,r2
   618C FD                 1099 	mov	r5,a
                           1100 ;       Peephole 181    changed mov to clr
   618D E4                 1101 	clr     a
                           1102 ;       Peephole 236.b  used r3 instead of ar3
   618E 3B                 1103 	addc    a,r3
   618F FE                 1104 	mov	r6,a
   6190 8C 07              1105 	mov	ar7,r4
                           1106 ;     genCall
   6192 C0 02              1107 	push	ar2
   6194 C0 03              1108 	push	ar3
   6196 C0 04              1109 	push	ar4
   6198 C0 05              1110 	push	ar5
   619A C0 06              1111 	push	ar6
   619C C0 07              1112 	push	ar7
   619E 12 5D EC           1113 	lcall	_rbyte_3w
   61A1 E5 82              1114 	mov	a,dpl
   61A3 D0 07              1115 	pop	ar7
   61A5 D0 06              1116 	pop	ar6
   61A7 D0 05              1117 	pop	ar5
   61A9 D0 04              1118 	pop	ar4
   61AB D0 03              1119 	pop	ar3
   61AD D0 02              1120 	pop	ar2
                           1121 ;     genAnd
   61AF 54 3F              1122 	anl	a,#0x3F
                           1123 ;     genPointerSet
                           1124 ;     genGenPointerSet
                           1125 ;       Peephole 191    removed redundant mov
   61B1 F8                 1126 	mov     r0,a
   61B2 8D 82              1127 	mov     dpl,r5
   61B4 8E 83              1128 	mov     dph,r6
   61B6 8F F0              1129 	mov     b,r7
   61B8 12 70 71           1130 	lcall	__gptrput
                           1131 ;src/rtc.c:172: tm_time->tm_mon =  rbyte_3w()&0x1F;
                           1132 ;     genPlus
                           1133 ;     genPlusIncr
   61BB 74 04              1134 	mov	a,#0x04
                           1135 ;       Peephole 236.a  used r2 instead of ar2
   61BD 2A                 1136 	add     a,r2
   61BE FD                 1137 	mov	r5,a
                           1138 ;       Peephole 181    changed mov to clr
   61BF E4                 1139 	clr     a
                           1140 ;       Peephole 236.b  used r3 instead of ar3
   61C0 3B                 1141 	addc    a,r3
   61C1 FE                 1142 	mov	r6,a
   61C2 8C 07              1143 	mov	ar7,r4
                           1144 ;     genCall
   61C4 C0 02              1145 	push	ar2
   61C6 C0 03              1146 	push	ar3
   61C8 C0 04              1147 	push	ar4
   61CA C0 05              1148 	push	ar5
   61CC C0 06              1149 	push	ar6
   61CE C0 07              1150 	push	ar7
   61D0 12 5D EC           1151 	lcall	_rbyte_3w
   61D3 E5 82              1152 	mov	a,dpl
   61D5 D0 07              1153 	pop	ar7
   61D7 D0 06              1154 	pop	ar6
   61D9 D0 05              1155 	pop	ar5
   61DB D0 04              1156 	pop	ar4
   61DD D0 03              1157 	pop	ar3
   61DF D0 02              1158 	pop	ar2
                           1159 ;     genAnd
   61E1 54 1F              1160 	anl	a,#0x1F
                           1161 ;     genPointerSet
                           1162 ;     genGenPointerSet
                           1163 ;       Peephole 191    removed redundant mov
   61E3 F8                 1164 	mov     r0,a
   61E4 8D 82              1165 	mov     dpl,r5
   61E6 8E 83              1166 	mov     dph,r6
   61E8 8F F0              1167 	mov     b,r7
   61EA 12 70 71           1168 	lcall	__gptrput
                           1169 ;src/rtc.c:173: tm_time->tm_wday = rbyte_3w()&0x7;
                           1170 ;     genPlus
   61ED 74 07              1171 	mov	a,#0x07
                           1172 ;       Peephole 236.a  used r2 instead of ar2
   61EF 2A                 1173 	add     a,r2
   61F0 FD                 1174 	mov	r5,a
                           1175 ;       Peephole 181    changed mov to clr
   61F1 E4                 1176 	clr     a
                           1177 ;       Peephole 236.b  used r3 instead of ar3
   61F2 3B                 1178 	addc    a,r3
   61F3 FE                 1179 	mov	r6,a
   61F4 8C 07              1180 	mov	ar7,r4
                           1181 ;     genCall
   61F6 C0 02              1182 	push	ar2
   61F8 C0 03              1183 	push	ar3
   61FA C0 04              1184 	push	ar4
   61FC C0 05              1185 	push	ar5
   61FE C0 06              1186 	push	ar6
   6200 C0 07              1187 	push	ar7
   6202 12 5D EC           1188 	lcall	_rbyte_3w
   6205 E5 82              1189 	mov	a,dpl
   6207 D0 07              1190 	pop	ar7
   6209 D0 06              1191 	pop	ar6
   620B D0 05              1192 	pop	ar5
   620D D0 04              1193 	pop	ar4
   620F D0 03              1194 	pop	ar3
   6211 D0 02              1195 	pop	ar2
                           1196 ;     genAnd
   6213 54 07              1197 	anl	a,#0x07
                           1198 ;     genPointerSet
                           1199 ;     genGenPointerSet
                           1200 ;       Peephole 191    removed redundant mov
   6215 F8                 1201 	mov     r0,a
   6216 8D 82              1202 	mov     dpl,r5
   6218 8E 83              1203 	mov     dph,r6
   621A 8F F0              1204 	mov     b,r7
   621C 12 70 71           1205 	lcall	__gptrput
                           1206 ;src/rtc.c:174: tm_time->tm_year = rbyte_3w();
                           1207 ;     genPlus
   621F 74 05              1208 	mov	a,#0x05
                           1209 ;       Peephole 236.a  used r2 instead of ar2
   6221 2A                 1210 	add     a,r2
   6222 FA                 1211 	mov	r2,a
                           1212 ;       Peephole 181    changed mov to clr
   6223 E4                 1213 	clr     a
                           1214 ;       Peephole 236.b  used r3 instead of ar3
   6224 3B                 1215 	addc    a,r3
   6225 FB                 1216 	mov	r3,a
                           1217 ;     genCall
   6226 C0 02              1218 	push	ar2
   6228 C0 03              1219 	push	ar3
   622A C0 04              1220 	push	ar4
   622C 12 5D EC           1221 	lcall	_rbyte_3w
   622F AD 82              1222 	mov	r5,dpl
   6231 D0 04              1223 	pop	ar4
   6233 D0 03              1224 	pop	ar3
   6235 D0 02              1225 	pop	ar2
                           1226 ;     genCast
   6237 7E 00              1227 	mov	r6,#0x00
                           1228 ;     genPointerSet
                           1229 ;     genGenPointerSet
   6239 8A 82              1230 	mov	dpl,r2
   623B 8B 83              1231 	mov	dph,r3
   623D 8C F0              1232 	mov	b,r4
   623F ED                 1233 	mov	a,r5
   6240 12 70 71           1234 	lcall	__gptrput
   6243 A3                 1235 	inc	dptr
   6244 EE                 1236 	mov	a,r6
   6245 12 70 71           1237 	lcall	__gptrput
                           1238 ;src/rtc.c:176: rbyte_3w();
                           1239 ;     genCall
   6248 12 5D EC           1240 	lcall	_rbyte_3w
                           1241 ;src/rtc.c:177: reset_3w();
                           1242 ;     genCall
   624B 12 5D B4           1243 	lcall	_reset_3w
   624E                    1244 00101$:
   624E 85 40 81           1245 	mov	sp,_bp
   6251 D0 40              1246 	pop	_bp
   6253 22                 1247 	ret
                           1248 ;------------------------------------------------------------
                           1249 ;Allocation info for local variables in function 'ds1302_write_rtc'
                           1250 ;------------------------------------------------------------
                           1251 ;tm_time                   Allocated to registers r2 r3 r4 
                           1252 ;------------------------------------------------------------
                           1253 ;src/rtc.c:180: void ds1302_write_rtc ( const struct tm *tm_time )
                           1254 ;	-----------------------------------------
                           1255 ;	 function ds1302_write_rtc
                           1256 ;	-----------------------------------------
   6254                    1257 _ds1302_write_rtc:
   6254 C0 40              1258 	push	_bp
   6256 85 81 40           1259 	mov	_bp,sp
                           1260 ;     genReceive
   6259 AA 82              1261 	mov	r2,dpl
   625B AB 83              1262 	mov	r3,dph
   625D AC F0              1263 	mov	r4,b
                           1264 ;src/rtc.c:182: reset_3w();
                           1265 ;     genCall
   625F C0 02              1266 	push	ar2
   6261 C0 03              1267 	push	ar3
   6263 C0 04              1268 	push	ar4
   6265 12 5D B4           1269 	lcall	_reset_3w
   6268 D0 04              1270 	pop	ar4
   626A D0 03              1271 	pop	ar3
   626C D0 02              1272 	pop	ar2
                           1273 ;src/rtc.c:183: wbyte_3w(RTC_CTRL);    // "Write Protect" flag reset:
                           1274 ;     genCall
   626E 75 82 8E           1275 	mov	dpl,#0x8E
   6271 C0 02              1276 	push	ar2
   6273 C0 03              1277 	push	ar3
   6275 C0 04              1278 	push	ar4
   6277 12 5D C5           1279 	lcall	_wbyte_3w
   627A D0 04              1280 	pop	ar4
   627C D0 03              1281 	pop	ar3
   627E D0 02              1282 	pop	ar2
                           1283 ;src/rtc.c:184: wbyte_3w(0x00);
                           1284 ;     genCall
   6280 75 82 00           1285 	mov	dpl,#0x00
   6283 C0 02              1286 	push	ar2
   6285 C0 03              1287 	push	ar3
   6287 C0 04              1288 	push	ar4
   6289 12 5D C5           1289 	lcall	_wbyte_3w
   628C D0 04              1290 	pop	ar4
   628E D0 03              1291 	pop	ar3
   6290 D0 02              1292 	pop	ar2
                           1293 ;src/rtc.c:185: reset_3w();
                           1294 ;     genCall
   6292 C0 02              1295 	push	ar2
   6294 C0 03              1296 	push	ar3
   6296 C0 04              1297 	push	ar4
   6298 12 5D B4           1298 	lcall	_reset_3w
   629B D0 04              1299 	pop	ar4
   629D D0 03              1300 	pop	ar3
   629F D0 02              1301 	pop	ar2
                           1302 ;src/rtc.c:186: wbyte_3w(RTC_BURST);  // Writing data in burst mode:
                           1303 ;     genCall
   62A1 75 82 BE           1304 	mov	dpl,#0xBE
   62A4 C0 02              1305 	push	ar2
   62A6 C0 03              1306 	push	ar3
   62A8 C0 04              1307 	push	ar4
   62AA 12 5D C5           1308 	lcall	_wbyte_3w
   62AD D0 04              1309 	pop	ar4
   62AF D0 03              1310 	pop	ar3
   62B1 D0 02              1311 	pop	ar2
                           1312 ;src/rtc.c:187: wbyte_3w( tm_time->tm_sec );    // writing seconds:
                           1313 ;     genPointerGet
                           1314 ;     genGenPointerGet
   62B3 8A 82              1315 	mov	dpl,r2
   62B5 8B 83              1316 	mov	dph,r3
   62B7 8C F0              1317 	mov	b,r4
   62B9 12 71 F5           1318 	lcall	__gptrget
                           1319 ;     genCall
                           1320 ;       Peephole 244.c  loading dpl from a instead of r5
   62BC FD                 1321 	mov	r5,a
   62BD F5 82              1322 	mov	dpl,a
   62BF C0 02              1323 	push	ar2
   62C1 C0 03              1324 	push	ar3
   62C3 C0 04              1325 	push	ar4
   62C5 12 5D C5           1326 	lcall	_wbyte_3w
   62C8 D0 04              1327 	pop	ar4
   62CA D0 03              1328 	pop	ar3
   62CC D0 02              1329 	pop	ar2
                           1330 ;src/rtc.c:188: wbyte_3w( tm_time->tm_min );    // writing minutes:
                           1331 ;     genPlus
                           1332 ;     genPlusIncr
   62CE 74 01              1333 	mov	a,#0x01
                           1334 ;       Peephole 236.a  used r2 instead of ar2
   62D0 2A                 1335 	add     a,r2
   62D1 FD                 1336 	mov	r5,a
                           1337 ;       Peephole 181    changed mov to clr
   62D2 E4                 1338 	clr     a
                           1339 ;       Peephole 236.b  used r3 instead of ar3
   62D3 3B                 1340 	addc    a,r3
   62D4 FE                 1341 	mov	r6,a
   62D5 8C 07              1342 	mov	ar7,r4
                           1343 ;     genPointerGet
                           1344 ;     genGenPointerGet
   62D7 8D 82              1345 	mov	dpl,r5
   62D9 8E 83              1346 	mov	dph,r6
   62DB 8F F0              1347 	mov	b,r7
   62DD 12 71 F5           1348 	lcall	__gptrget
                           1349 ;     genCall
                           1350 ;       Peephole 244.c  loading dpl from a instead of r5
   62E0 FD                 1351 	mov	r5,a
   62E1 F5 82              1352 	mov	dpl,a
   62E3 C0 02              1353 	push	ar2
   62E5 C0 03              1354 	push	ar3
   62E7 C0 04              1355 	push	ar4
   62E9 12 5D C5           1356 	lcall	_wbyte_3w
   62EC D0 04              1357 	pop	ar4
   62EE D0 03              1358 	pop	ar3
   62F0 D0 02              1359 	pop	ar2
                           1360 ;src/rtc.c:189: wbyte_3w( tm_time->tm_hour );   // writing hours:
                           1361 ;     genPlus
                           1362 ;     genPlusIncr
   62F2 74 02              1363 	mov	a,#0x02
                           1364 ;       Peephole 236.a  used r2 instead of ar2
   62F4 2A                 1365 	add     a,r2
   62F5 FD                 1366 	mov	r5,a
                           1367 ;       Peephole 181    changed mov to clr
   62F6 E4                 1368 	clr     a
                           1369 ;       Peephole 236.b  used r3 instead of ar3
   62F7 3B                 1370 	addc    a,r3
   62F8 FE                 1371 	mov	r6,a
   62F9 8C 07              1372 	mov	ar7,r4
                           1373 ;     genPointerGet
                           1374 ;     genGenPointerGet
   62FB 8D 82              1375 	mov	dpl,r5
   62FD 8E 83              1376 	mov	dph,r6
   62FF 8F F0              1377 	mov	b,r7
   6301 12 71 F5           1378 	lcall	__gptrget
                           1379 ;     genCall
                           1380 ;       Peephole 244.c  loading dpl from a instead of r5
   6304 FD                 1381 	mov	r5,a
   6305 F5 82              1382 	mov	dpl,a
   6307 C0 02              1383 	push	ar2
   6309 C0 03              1384 	push	ar3
   630B C0 04              1385 	push	ar4
   630D 12 5D C5           1386 	lcall	_wbyte_3w
   6310 D0 04              1387 	pop	ar4
   6312 D0 03              1388 	pop	ar3
   6314 D0 02              1389 	pop	ar2
                           1390 ;src/rtc.c:190: wbyte_3w( tm_time->tm_mday );   // writing day of the month:
                           1391 ;     genPlus
                           1392 ;     genPlusIncr
   6316 74 03              1393 	mov	a,#0x03
                           1394 ;       Peephole 236.a  used r2 instead of ar2
   6318 2A                 1395 	add     a,r2
   6319 FD                 1396 	mov	r5,a
                           1397 ;       Peephole 181    changed mov to clr
   631A E4                 1398 	clr     a
                           1399 ;       Peephole 236.b  used r3 instead of ar3
   631B 3B                 1400 	addc    a,r3
   631C FE                 1401 	mov	r6,a
   631D 8C 07              1402 	mov	ar7,r4
                           1403 ;     genPointerGet
                           1404 ;     genGenPointerGet
   631F 8D 82              1405 	mov	dpl,r5
   6321 8E 83              1406 	mov	dph,r6
   6323 8F F0              1407 	mov	b,r7
   6325 12 71 F5           1408 	lcall	__gptrget
                           1409 ;     genCall
                           1410 ;       Peephole 244.c  loading dpl from a instead of r5
   6328 FD                 1411 	mov	r5,a
   6329 F5 82              1412 	mov	dpl,a
   632B C0 02              1413 	push	ar2
   632D C0 03              1414 	push	ar3
   632F C0 04              1415 	push	ar4
   6331 12 5D C5           1416 	lcall	_wbyte_3w
   6334 D0 04              1417 	pop	ar4
   6336 D0 03              1418 	pop	ar3
   6338 D0 02              1419 	pop	ar2
                           1420 ;src/rtc.c:191: wbyte_3w( tm_time->tm_mon );    // writing month:
                           1421 ;     genPlus
                           1422 ;     genPlusIncr
   633A 74 04              1423 	mov	a,#0x04
                           1424 ;       Peephole 236.a  used r2 instead of ar2
   633C 2A                 1425 	add     a,r2
   633D FD                 1426 	mov	r5,a
                           1427 ;       Peephole 181    changed mov to clr
   633E E4                 1428 	clr     a
                           1429 ;       Peephole 236.b  used r3 instead of ar3
   633F 3B                 1430 	addc    a,r3
   6340 FE                 1431 	mov	r6,a
   6341 8C 07              1432 	mov	ar7,r4
                           1433 ;     genPointerGet
                           1434 ;     genGenPointerGet
   6343 8D 82              1435 	mov	dpl,r5
   6345 8E 83              1436 	mov	dph,r6
   6347 8F F0              1437 	mov	b,r7
   6349 12 71 F5           1438 	lcall	__gptrget
                           1439 ;     genCall
                           1440 ;       Peephole 244.c  loading dpl from a instead of r5
   634C FD                 1441 	mov	r5,a
   634D F5 82              1442 	mov	dpl,a
   634F C0 02              1443 	push	ar2
   6351 C0 03              1444 	push	ar3
   6353 C0 04              1445 	push	ar4
   6355 12 5D C5           1446 	lcall	_wbyte_3w
   6358 D0 04              1447 	pop	ar4
   635A D0 03              1448 	pop	ar3
   635C D0 02              1449 	pop	ar2
                           1450 ;src/rtc.c:192: wbyte_3w( tm_time->tm_wday );   // writing day of week:
                           1451 ;     genPlus
   635E 74 07              1452 	mov	a,#0x07
                           1453 ;       Peephole 236.a  used r2 instead of ar2
   6360 2A                 1454 	add     a,r2
   6361 FD                 1455 	mov	r5,a
                           1456 ;       Peephole 181    changed mov to clr
   6362 E4                 1457 	clr     a
                           1458 ;       Peephole 236.b  used r3 instead of ar3
   6363 3B                 1459 	addc    a,r3
   6364 FE                 1460 	mov	r6,a
   6365 8C 07              1461 	mov	ar7,r4
                           1462 ;     genPointerGet
                           1463 ;     genGenPointerGet
   6367 8D 82              1464 	mov	dpl,r5
   6369 8E 83              1465 	mov	dph,r6
   636B 8F F0              1466 	mov	b,r7
   636D 12 71 F5           1467 	lcall	__gptrget
                           1468 ;     genCall
                           1469 ;       Peephole 244.c  loading dpl from a instead of r5
   6370 FD                 1470 	mov	r5,a
   6371 F5 82              1471 	mov	dpl,a
   6373 C0 02              1472 	push	ar2
   6375 C0 03              1473 	push	ar3
   6377 C0 04              1474 	push	ar4
   6379 12 5D C5           1475 	lcall	_wbyte_3w
   637C D0 04              1476 	pop	ar4
   637E D0 03              1477 	pop	ar3
   6380 D0 02              1478 	pop	ar2
                           1479 ;src/rtc.c:193: wbyte_3w( (unsigned char)(tm_time->tm_year&0xff) );   // writing year:
                           1480 ;     genPlus
   6382 74 05              1481 	mov	a,#0x05
                           1482 ;       Peephole 236.a  used r2 instead of ar2
   6384 2A                 1483 	add     a,r2
   6385 FA                 1484 	mov	r2,a
                           1485 ;       Peephole 181    changed mov to clr
   6386 E4                 1486 	clr     a
                           1487 ;       Peephole 236.b  used r3 instead of ar3
   6387 3B                 1488 	addc    a,r3
   6388 FB                 1489 	mov	r3,a
                           1490 ;     genPointerGet
                           1491 ;     genGenPointerGet
   6389 8A 82              1492 	mov	dpl,r2
   638B 8B 83              1493 	mov	dph,r3
   638D 8C F0              1494 	mov	b,r4
   638F 12 71 F5           1495 	lcall	__gptrget
   6392 FA                 1496 	mov	r2,a
   6393 A3                 1497 	inc	dptr
   6394 12 71 F5           1498 	lcall	__gptrget
   6397 FB                 1499 	mov	r3,a
                           1500 ;     genCast
   6398 8A 82              1501 	mov	dpl,r2
                           1502 ;     genCall
   639A 12 5D C5           1503 	lcall	_wbyte_3w
                           1504 ;src/rtc.c:194: wbyte_3w(0x80);                 // "Write Protect" flag set:
                           1505 ;     genCall
   639D 75 82 80           1506 	mov	dpl,#0x80
   63A0 12 5D C5           1507 	lcall	_wbyte_3w
                           1508 ;src/rtc.c:195: reset_3w();
                           1509 ;     genCall
   63A3 12 5D B4           1510 	lcall	_reset_3w
   63A6                    1511 00101$:
   63A6 85 40 81           1512 	mov	sp,_bp
   63A9 D0 40              1513 	pop	_bp
   63AB 22                 1514 	ret
                           1515 ;------------------------------------------------------------
                           1516 ;Allocation info for local variables in function 'bcd2bin'
                           1517 ;------------------------------------------------------------
                           1518 ;bcd                       Allocated to registers r2 
                           1519 ;retval                    Allocated to registers r3 
                           1520 ;------------------------------------------------------------
                           1521 ;src/rtc.c:198: unsigned char bcd2bin(unsigned char bcd)
                           1522 ;	-----------------------------------------
                           1523 ;	 function bcd2bin
                           1524 ;	-----------------------------------------
   63AC                    1525 _bcd2bin:
   63AC C0 40              1526 	push	_bp
   63AE 85 81 40           1527 	mov	_bp,sp
                           1528 ;     genReceive
                           1529 ;src/rtc.c:201: retval = bcd>>4 & 0x0f;
                           1530 ;     genRightShift
                           1531 ;     genRightShiftLiteral
                           1532 ;     genrshOne
                           1533 ;       Peephole 244.a  moving first to a instead of r2
   63B1 E5 82              1534 	mov	a,dpl
   63B3 FA                 1535 	mov	r2,a
   63B4 C4                 1536 	swap	a
                           1537 ;     genAnd
                           1538 ;src/rtc.c:202: retval *= 10;
                           1539 ;     genMult
                           1540 ;     genMultOneByte
                           1541 ;       Peephole 139    removed redundant mov
                           1542 ;       Peephole 183    avoided anl during execution
   63B5 54 0F              1543 	anl     a,#(0x0f & 0x0F)
   63B7 FB                 1544 	mov     r3,a
   63B8 75 F0 0A           1545 	mov	b,#0x0A
   63BB A4                 1546 	mul	ab
   63BC FB                 1547 	mov	r3,a
                           1548 ;src/rtc.c:203: retval += bcd & 0x0f;
                           1549 ;     genAnd
   63BD 53 02 0F           1550 	anl	ar2,#0x0F
                           1551 ;     genPlus
                           1552 ;       Peephole 236.g  used r2 instead of ar2
   63C0 EA                 1553 	mov     a,r2
                           1554 ;       Peephole 236.a  used r3 instead of ar3
   63C1 2B                 1555 	add     a,r3
                           1556 ;src/rtc.c:204: return retval;
                           1557 ;     genRet
                           1558 ;       Peephole 244.c  loading dpl from a instead of r3
   63C2 FB                 1559 	mov	r3,a
   63C3 F5 82              1560 	mov	dpl,a
   63C5                    1561 00101$:
   63C5 85 40 81           1562 	mov	sp,_bp
   63C8 D0 40              1563 	pop	_bp
   63CA 22                 1564 	ret
                           1565 ;------------------------------------------------------------
                           1566 ;Allocation info for local variables in function 'check_time'
                           1567 ;------------------------------------------------------------
                           1568 ;timeptr                   Allocated to registers r2 r3 r4 
                           1569 ;------------------------------------------------------------
                           1570 ;src/rtc.c:207: void check_time(struct tm *timeptr) 
                           1571 ;	-----------------------------------------
                           1572 ;	 function check_time
                           1573 ;	-----------------------------------------
   63CB                    1574 _check_time:
   63CB C0 40              1575 	push	_bp
   63CD 85 81 40           1576 	mov	_bp,sp
                           1577 ;     genReceive
                           1578 ;src/rtc.c:211: if (timeptr->tm_sec<0) timeptr->tm_sec=0;
                           1579 ;     genPointerGet
                           1580 ;     genGenPointerGet
   63D0 AA 82              1581 	mov     r2,dpl
   63D2 AB 83              1582 	mov     r3,dph
   63D4 AC F0              1583 	mov     r4,b
                           1584 ;       Peephole 238.d  removed 3 redundant moves
   63D6 12 71 F5           1585 	lcall	__gptrget
   63D9 FD                 1586 	mov	r5,a
                           1587 ;     genCmpLt
                           1588 ;     genCmp
   63DA BD 00 00           1589 	cjne	r5,#0x00,00148$
   63DD                    1590 00148$:
                           1591 ;     genIfxJump
                           1592 ;       Peephole 108    removed ljmp by inverse jump logic
   63DD 50 0C              1593 	jnc     00104$
   63DF                    1594 00149$:
                           1595 ;     genPointerSet
                           1596 ;     genGenPointerSet
   63DF 8A 82              1597 	mov	dpl,r2
   63E1 8B 83              1598 	mov	dph,r3
   63E3 8C F0              1599 	mov	b,r4
                           1600 ;       Peephole 181    changed mov to clr
   63E5 E4                 1601 	clr     a
   63E6 12 70 71           1602 	lcall	__gptrput
                           1603 ;       Peephole 112.b  changed ljmp to sjmp
   63E9 80 11              1604 	sjmp    00105$
   63EB                    1605 00104$:
                           1606 ;src/rtc.c:212: else if (timeptr->tm_sec>59) timeptr->tm_sec=59;
                           1607 ;     genCmpGt
                           1608 ;     genCmp
   63EB C3                 1609 	clr	c
   63EC 74 3B              1610 	mov	a,#0x3B
   63EE 9D                 1611 	subb	a,r5
                           1612 ;     genIfxJump
                           1613 ;       Peephole 108    removed ljmp by inverse jump logic
   63EF 50 0B              1614 	jnc     00105$
   63F1                    1615 00150$:
                           1616 ;     genPointerSet
                           1617 ;     genGenPointerSet
   63F1 8A 82              1618 	mov	dpl,r2
   63F3 8B 83              1619 	mov	dph,r3
   63F5 8C F0              1620 	mov	b,r4
   63F7 74 3B              1621 	mov	a,#0x3B
   63F9 12 70 71           1622 	lcall	__gptrput
   63FC                    1623 00105$:
                           1624 ;src/rtc.c:213: if (timeptr->tm_min<0) timeptr->tm_min=0;
                           1625 ;     genPlus
                           1626 ;     genPlusIncr
   63FC 74 01              1627 	mov	a,#0x01
                           1628 ;       Peephole 236.a  used r2 instead of ar2
   63FE 2A                 1629 	add     a,r2
   63FF FD                 1630 	mov	r5,a
                           1631 ;       Peephole 181    changed mov to clr
   6400 E4                 1632 	clr     a
                           1633 ;       Peephole 236.b  used r3 instead of ar3
   6401 3B                 1634 	addc    a,r3
   6402 FE                 1635 	mov	r6,a
   6403 8C 07              1636 	mov	ar7,r4
                           1637 ;     genPointerGet
                           1638 ;     genGenPointerGet
   6405 8D 82              1639 	mov	dpl,r5
   6407 8E 83              1640 	mov	dph,r6
   6409 8F F0              1641 	mov	b,r7
   640B 12 71 F5           1642 	lcall	__gptrget
   640E F8                 1643 	mov	r0,a
                           1644 ;     genCmpLt
                           1645 ;     genCmp
   640F B8 00 00           1646 	cjne	r0,#0x00,00151$
   6412                    1647 00151$:
                           1648 ;     genIfxJump
                           1649 ;       Peephole 108    removed ljmp by inverse jump logic
   6412 50 0C              1650 	jnc     00109$
   6414                    1651 00152$:
                           1652 ;     genPointerSet
                           1653 ;     genGenPointerSet
   6414 8D 82              1654 	mov	dpl,r5
   6416 8E 83              1655 	mov	dph,r6
   6418 8F F0              1656 	mov	b,r7
                           1657 ;       Peephole 181    changed mov to clr
   641A E4                 1658 	clr     a
   641B 12 70 71           1659 	lcall	__gptrput
                           1660 ;       Peephole 112.b  changed ljmp to sjmp
   641E 80 11              1661 	sjmp    00110$
   6420                    1662 00109$:
                           1663 ;src/rtc.c:214: else if (timeptr->tm_min>59) timeptr->tm_min=59;
                           1664 ;     genCmpGt
                           1665 ;     genCmp
   6420 C3                 1666 	clr	c
   6421 74 3B              1667 	mov	a,#0x3B
   6423 98                 1668 	subb	a,r0
                           1669 ;     genIfxJump
                           1670 ;       Peephole 108    removed ljmp by inverse jump logic
   6424 50 0B              1671 	jnc     00110$
   6426                    1672 00153$:
                           1673 ;     genPointerSet
                           1674 ;     genGenPointerSet
   6426 8D 82              1675 	mov	dpl,r5
   6428 8E 83              1676 	mov	dph,r6
   642A 8F F0              1677 	mov	b,r7
   642C 74 3B              1678 	mov	a,#0x3B
   642E 12 70 71           1679 	lcall	__gptrput
   6431                    1680 00110$:
                           1681 ;src/rtc.c:215: if (timeptr->tm_hour<0) timeptr->tm_hour=0;
                           1682 ;     genPlus
                           1683 ;     genPlusIncr
   6431 74 02              1684 	mov	a,#0x02
                           1685 ;       Peephole 236.a  used r2 instead of ar2
   6433 2A                 1686 	add     a,r2
   6434 FD                 1687 	mov	r5,a
                           1688 ;       Peephole 181    changed mov to clr
   6435 E4                 1689 	clr     a
                           1690 ;       Peephole 236.b  used r3 instead of ar3
   6436 3B                 1691 	addc    a,r3
   6437 FE                 1692 	mov	r6,a
   6438 8C 07              1693 	mov	ar7,r4
                           1694 ;     genPointerGet
                           1695 ;     genGenPointerGet
   643A 8D 82              1696 	mov	dpl,r5
   643C 8E 83              1697 	mov	dph,r6
   643E 8F F0              1698 	mov	b,r7
   6440 12 71 F5           1699 	lcall	__gptrget
   6443 F8                 1700 	mov	r0,a
                           1701 ;     genCmpLt
                           1702 ;     genCmp
   6444 B8 00 00           1703 	cjne	r0,#0x00,00154$
   6447                    1704 00154$:
                           1705 ;     genIfxJump
                           1706 ;       Peephole 108    removed ljmp by inverse jump logic
   6447 50 0C              1707 	jnc     00114$
   6449                    1708 00155$:
                           1709 ;     genPointerSet
                           1710 ;     genGenPointerSet
   6449 8D 82              1711 	mov	dpl,r5
   644B 8E 83              1712 	mov	dph,r6
   644D 8F F0              1713 	mov	b,r7
                           1714 ;       Peephole 181    changed mov to clr
   644F E4                 1715 	clr     a
   6450 12 70 71           1716 	lcall	__gptrput
                           1717 ;       Peephole 112.b  changed ljmp to sjmp
   6453 80 11              1718 	sjmp    00115$
   6455                    1719 00114$:
                           1720 ;src/rtc.c:216: else if (timeptr->tm_hour>23) timeptr->tm_hour=23;
                           1721 ;     genCmpGt
                           1722 ;     genCmp
   6455 C3                 1723 	clr	c
   6456 74 17              1724 	mov	a,#0x17
   6458 98                 1725 	subb	a,r0
                           1726 ;     genIfxJump
                           1727 ;       Peephole 108    removed ljmp by inverse jump logic
   6459 50 0B              1728 	jnc     00115$
   645B                    1729 00156$:
                           1730 ;     genPointerSet
                           1731 ;     genGenPointerSet
   645B 8D 82              1732 	mov	dpl,r5
   645D 8E 83              1733 	mov	dph,r6
   645F 8F F0              1734 	mov	b,r7
   6461 74 17              1735 	mov	a,#0x17
   6463 12 70 71           1736 	lcall	__gptrput
   6466                    1737 00115$:
                           1738 ;src/rtc.c:217: if (timeptr->tm_wday<0) timeptr->tm_wday=0;
                           1739 ;     genPlus
   6466 74 07              1740 	mov	a,#0x07
                           1741 ;       Peephole 236.a  used r2 instead of ar2
   6468 2A                 1742 	add     a,r2
   6469 FD                 1743 	mov	r5,a
                           1744 ;       Peephole 181    changed mov to clr
   646A E4                 1745 	clr     a
                           1746 ;       Peephole 236.b  used r3 instead of ar3
   646B 3B                 1747 	addc    a,r3
   646C FE                 1748 	mov	r6,a
   646D 8C 07              1749 	mov	ar7,r4
                           1750 ;     genPointerGet
                           1751 ;     genGenPointerGet
   646F 8D 82              1752 	mov	dpl,r5
   6471 8E 83              1753 	mov	dph,r6
   6473 8F F0              1754 	mov	b,r7
   6475 12 71 F5           1755 	lcall	__gptrget
   6478 F8                 1756 	mov	r0,a
                           1757 ;     genCmpLt
                           1758 ;     genCmp
   6479 B8 00 00           1759 	cjne	r0,#0x00,00157$
   647C                    1760 00157$:
                           1761 ;     genIfxJump
                           1762 ;       Peephole 108    removed ljmp by inverse jump logic
   647C 50 0C              1763 	jnc     00119$
   647E                    1764 00158$:
                           1765 ;     genPointerSet
                           1766 ;     genGenPointerSet
   647E 8D 82              1767 	mov	dpl,r5
   6480 8E 83              1768 	mov	dph,r6
   6482 8F F0              1769 	mov	b,r7
                           1770 ;       Peephole 181    changed mov to clr
   6484 E4                 1771 	clr     a
   6485 12 70 71           1772 	lcall	__gptrput
                           1773 ;       Peephole 112.b  changed ljmp to sjmp
   6488 80 11              1774 	sjmp    00120$
   648A                    1775 00119$:
                           1776 ;src/rtc.c:218: else if (timeptr->tm_wday>7) timeptr->tm_wday=7;
                           1777 ;     genCmpGt
                           1778 ;     genCmp
   648A C3                 1779 	clr	c
   648B 74 07              1780 	mov	a,#0x07
   648D 98                 1781 	subb	a,r0
                           1782 ;     genIfxJump
                           1783 ;       Peephole 108    removed ljmp by inverse jump logic
   648E 50 0B              1784 	jnc     00120$
   6490                    1785 00159$:
                           1786 ;     genPointerSet
                           1787 ;     genGenPointerSet
   6490 8D 82              1788 	mov	dpl,r5
   6492 8E 83              1789 	mov	dph,r6
   6494 8F F0              1790 	mov	b,r7
   6496 74 07              1791 	mov	a,#0x07
   6498 12 70 71           1792 	lcall	__gptrput
   649B                    1793 00120$:
                           1794 ;src/rtc.c:219: if (timeptr->tm_mday<1) timeptr->tm_mday=1;
                           1795 ;     genPlus
                           1796 ;     genPlusIncr
   649B 74 03              1797 	mov	a,#0x03
                           1798 ;       Peephole 236.a  used r2 instead of ar2
   649D 2A                 1799 	add     a,r2
   649E FD                 1800 	mov	r5,a
                           1801 ;       Peephole 181    changed mov to clr
   649F E4                 1802 	clr     a
                           1803 ;       Peephole 236.b  used r3 instead of ar3
   64A0 3B                 1804 	addc    a,r3
   64A1 FE                 1805 	mov	r6,a
   64A2 8C 07              1806 	mov	ar7,r4
                           1807 ;     genPointerGet
                           1808 ;     genGenPointerGet
   64A4 8D 82              1809 	mov	dpl,r5
   64A6 8E 83              1810 	mov	dph,r6
   64A8 8F F0              1811 	mov	b,r7
   64AA 12 71 F5           1812 	lcall	__gptrget
   64AD F8                 1813 	mov	r0,a
                           1814 ;     genCmpLt
                           1815 ;     genCmp
   64AE B8 01 00           1816 	cjne	r0,#0x01,00160$
   64B1                    1817 00160$:
                           1818 ;     genIfxJump
                           1819 ;       Peephole 108    removed ljmp by inverse jump logic
   64B1 50 0D              1820 	jnc     00124$
   64B3                    1821 00161$:
                           1822 ;     genPointerSet
                           1823 ;     genGenPointerSet
   64B3 8D 82              1824 	mov	dpl,r5
   64B5 8E 83              1825 	mov	dph,r6
   64B7 8F F0              1826 	mov	b,r7
   64B9 74 01              1827 	mov	a,#0x01
   64BB 12 70 71           1828 	lcall	__gptrput
                           1829 ;       Peephole 112.b  changed ljmp to sjmp
   64BE 80 11              1830 	sjmp    00125$
   64C0                    1831 00124$:
                           1832 ;src/rtc.c:220: else if (timeptr->tm_mday>31) timeptr->tm_mday=31;
                           1833 ;     genCmpGt
                           1834 ;     genCmp
   64C0 C3                 1835 	clr	c
   64C1 74 1F              1836 	mov	a,#0x1F
   64C3 98                 1837 	subb	a,r0
                           1838 ;     genIfxJump
                           1839 ;       Peephole 108    removed ljmp by inverse jump logic
   64C4 50 0B              1840 	jnc     00125$
   64C6                    1841 00162$:
                           1842 ;     genPointerSet
                           1843 ;     genGenPointerSet
   64C6 8D 82              1844 	mov	dpl,r5
   64C8 8E 83              1845 	mov	dph,r6
   64CA 8F F0              1846 	mov	b,r7
   64CC 74 1F              1847 	mov	a,#0x1F
   64CE 12 70 71           1848 	lcall	__gptrput
   64D1                    1849 00125$:
                           1850 ;src/rtc.c:221: if (timeptr->tm_mon<0) timeptr->tm_mon=0;
                           1851 ;     genPlus
                           1852 ;     genPlusIncr
   64D1 74 04              1853 	mov	a,#0x04
                           1854 ;       Peephole 236.a  used r2 instead of ar2
   64D3 2A                 1855 	add     a,r2
   64D4 FD                 1856 	mov	r5,a
                           1857 ;       Peephole 181    changed mov to clr
   64D5 E4                 1858 	clr     a
                           1859 ;       Peephole 236.b  used r3 instead of ar3
   64D6 3B                 1860 	addc    a,r3
   64D7 FE                 1861 	mov	r6,a
   64D8 8C 07              1862 	mov	ar7,r4
                           1863 ;     genPointerGet
                           1864 ;     genGenPointerGet
   64DA 8D 82              1865 	mov	dpl,r5
   64DC 8E 83              1866 	mov	dph,r6
   64DE 8F F0              1867 	mov	b,r7
   64E0 12 71 F5           1868 	lcall	__gptrget
   64E3 F8                 1869 	mov	r0,a
                           1870 ;     genCmpLt
                           1871 ;     genCmp
   64E4 B8 00 00           1872 	cjne	r0,#0x00,00163$
   64E7                    1873 00163$:
                           1874 ;     genIfxJump
                           1875 ;       Peephole 108    removed ljmp by inverse jump logic
   64E7 50 0C              1876 	jnc     00129$
   64E9                    1877 00164$:
                           1878 ;     genPointerSet
                           1879 ;     genGenPointerSet
   64E9 8D 82              1880 	mov	dpl,r5
   64EB 8E 83              1881 	mov	dph,r6
   64ED 8F F0              1882 	mov	b,r7
                           1883 ;       Peephole 181    changed mov to clr
   64EF E4                 1884 	clr     a
   64F0 12 70 71           1885 	lcall	__gptrput
                           1886 ;       Peephole 112.b  changed ljmp to sjmp
   64F3 80 11              1887 	sjmp    00130$
   64F5                    1888 00129$:
                           1889 ;src/rtc.c:222: else if (timeptr->tm_mon>11) timeptr->tm_mon=11;
                           1890 ;     genCmpGt
                           1891 ;     genCmp
   64F5 C3                 1892 	clr	c
   64F6 74 0B              1893 	mov	a,#0x0B
   64F8 98                 1894 	subb	a,r0
                           1895 ;     genIfxJump
                           1896 ;       Peephole 108    removed ljmp by inverse jump logic
   64F9 50 0B              1897 	jnc     00130$
   64FB                    1898 00165$:
                           1899 ;     genPointerSet
                           1900 ;     genGenPointerSet
   64FB 8D 82              1901 	mov	dpl,r5
   64FD 8E 83              1902 	mov	dph,r6
   64FF 8F F0              1903 	mov	b,r7
   6501 74 0B              1904 	mov	a,#0x0B
   6503 12 70 71           1905 	lcall	__gptrput
   6506                    1906 00130$:
                           1907 ;src/rtc.c:223: if (timeptr->tm_year<0) timeptr->tm_year=0;
                           1908 ;     genPlus
   6506 74 05              1909 	mov	a,#0x05
                           1910 ;       Peephole 236.a  used r2 instead of ar2
   6508 2A                 1911 	add     a,r2
   6509 FA                 1912 	mov	r2,a
                           1913 ;       Peephole 181    changed mov to clr
   650A E4                 1914 	clr     a
                           1915 ;       Peephole 236.b  used r3 instead of ar3
   650B 3B                 1916 	addc    a,r3
   650C FB                 1917 	mov	r3,a
                           1918 ;     genPointerGet
                           1919 ;     genGenPointerGet
   650D 8A 82              1920 	mov	dpl,r2
   650F 8B 83              1921 	mov	dph,r3
   6511 8C F0              1922 	mov	b,r4
   6513 12 71 F5           1923 	lcall	__gptrget
   6516 FD                 1924 	mov	r5,a
   6517 A3                 1925 	inc	dptr
   6518 12 71 F5           1926 	lcall	__gptrget
                           1927 ;     genCmpLt
                           1928 ;     genCmp
                           1929 ;       Peephole 105    removed redundant mov
   651B FE                 1930 	mov     r6,a
                           1931 ;     genIfxJump
                           1932 ;       Peephole 111    removed ljmp by inverse jump logic
   651C 30 E7 0F           1933 	jnb     acc.7,00133$
   651F                    1934 00166$:
                           1935 ;     genPointerSet
                           1936 ;     genGenPointerSet
   651F 8A 82              1937 	mov	dpl,r2
   6521 8B 83              1938 	mov	dph,r3
   6523 8C F0              1939 	mov	b,r4
                           1940 ;       Peephole 181    changed mov to clr
   6525 E4                 1941 	clr     a
   6526 12 70 71           1942 	lcall	__gptrput
   6529 A3                 1943 	inc	dptr
                           1944 ;       Peephole 181    changed mov to clr
   652A E4                 1945 	clr     a
   652B 12 70 71           1946 	lcall	__gptrput
   652E                    1947 00133$:
   652E 85 40 81           1948 	mov	sp,_bp
   6531 D0 40              1949 	pop	_bp
   6533 22                 1950 	ret
                           1951 ;------------------------------------------------------------
                           1952 ;Allocation info for local variables in function 'local_gmtime'
                           1953 ;------------------------------------------------------------
                           1954 ;timep                     Allocated to registers r2 r3 r4 
                           1955 ;epoch                     Allocated to stack - offset 1
                           1956 ;year                      Allocated to registers 
                           1957 ;month                     Allocated to registers 
                           1958 ;monthLength               Allocated to registers r4 
                           1959 ;days                      Allocated to stack - offset 5
                           1960 ;------------------------------------------------------------
                           1961 ;src/rtc.c:228: void local_gmtime(time_t *timep) {
                           1962 ;	-----------------------------------------
                           1963 ;	 function local_gmtime
                           1964 ;	-----------------------------------------
   6534                    1965 _local_gmtime:
   6534 C0 40              1966 	push	_bp
   6536 85 81 40           1967 	mov	_bp,sp
   6539 E5 81              1968 	mov	a,sp
   653B 24 08              1969 	add	a,#0x08
   653D F5 81              1970 	mov	sp,a
                           1971 ;     genReceive
                           1972 ;src/rtc.c:230: unsigned long epoch=*timep;
                           1973 ;     genPointerGet
                           1974 ;     genGenPointerGet
   653F AA 82              1975 	mov     r2,dpl
   6541 AB 83              1976 	mov     r3,dph
   6543 AC F0              1977 	mov     r4,b
                           1978 ;       Peephole 238.d  removed 3 redundant moves
   6545 12 71 F5           1979 	lcall	__gptrget
   6548 FA                 1980 	mov	r2,a
   6549 A3                 1981 	inc	dptr
   654A 12 71 F5           1982 	lcall	__gptrget
   654D FB                 1983 	mov	r3,a
   654E A3                 1984 	inc	dptr
   654F 12 71 F5           1985 	lcall	__gptrget
   6552 FC                 1986 	mov	r4,a
   6553 A3                 1987 	inc	dptr
   6554 12 71 F5           1988 	lcall	__gptrget
   6557 FD                 1989 	mov	r5,a
                           1990 ;     genAssign
                           1991 ;       Peephole 212    reduced add sequence to inc
   6558 A8 40              1992 	mov     r0,_bp
   655A 08                 1993 	inc     r0
   655B A6 02              1994 	mov	@r0,ar2
   655D 08                 1995 	inc	r0
   655E A6 03              1996 	mov	@r0,ar3
   6560 08                 1997 	inc	r0
   6561 A6 04              1998 	mov	@r0,ar4
   6563 08                 1999 	inc	r0
   6564 A6 05              2000 	mov	@r0,ar5
                           2001 ;src/rtc.c:235: system_time.tm_sec=epoch%60;
                           2002 ;     genAssign
   6566 E4                 2003 	clr	a
   6567 F5 45              2004 	mov	(__modulong_PARM_2 + 3),a
   6569 F5 44              2005 	mov	(__modulong_PARM_2 + 2),a
   656B F5 43              2006 	mov	(__modulong_PARM_2 + 1),a
   656D 75 42 3C           2007 	mov	__modulong_PARM_2,#0x3C
                           2008 ;     genCall
                           2009 ;       Peephole 212    reduced add sequence to inc
   6570 A8 40              2010 	mov     r0,_bp
   6572 08                 2011 	inc     r0
   6573 86 82              2012 	mov	dpl,@r0
   6575 08                 2013 	inc	r0
   6576 86 83              2014 	mov	dph,@r0
   6578 08                 2015 	inc	r0
   6579 86 F0              2016 	mov	b,@r0
   657B 08                 2017 	inc	r0
   657C E6                 2018 	mov	a,@r0
   657D 12 6F 85           2019 	lcall	__modulong
   6580 AE 82              2020 	mov	r6,dpl
   6582 AF 83              2021 	mov	r7,dph
   6584 AA F0              2022 	mov	r2,b
   6586 FB                 2023 	mov	r3,a
                           2024 ;     genCast
                           2025 ;     genPointerSet
                           2026 ;     genFarPointerSet
   6587 90 01 81           2027 	mov	dptr,#_system_time
   658A EE                 2028 	mov	a,r6
   658B F0                 2029 	movx	@dptr,a
                           2030 ;src/rtc.c:236: epoch/=60; // now it is minutes
                           2031 ;     genAssign
   658C E4                 2032 	clr	a
   658D F5 45              2033 	mov	(__divulong_PARM_2 + 3),a
   658F F5 44              2034 	mov	(__divulong_PARM_2 + 2),a
   6591 F5 43              2035 	mov	(__divulong_PARM_2 + 1),a
   6593 75 42 3C           2036 	mov	__divulong_PARM_2,#0x3C
                           2037 ;     genCall
                           2038 ;       Peephole 212    reduced add sequence to inc
   6596 A8 40              2039 	mov     r0,_bp
   6598 08                 2040 	inc     r0
   6599 86 82              2041 	mov	dpl,@r0
   659B 08                 2042 	inc	r0
   659C 86 83              2043 	mov	dph,@r0
   659E 08                 2044 	inc	r0
   659F 86 F0              2045 	mov	b,@r0
   65A1 08                 2046 	inc	r0
   65A2 E6                 2047 	mov	a,@r0
   65A3 12 70 08           2048 	lcall	__divulong
   65A6 AA 82              2049 	mov	r2,dpl
   65A8 AB 83              2050 	mov	r3,dph
   65AA AC F0              2051 	mov	r4,b
   65AC FD                 2052 	mov	r5,a
                           2053 ;     genAssign
                           2054 ;       Peephole 212    reduced add sequence to inc
   65AD A8 40              2055 	mov     r0,_bp
   65AF 08                 2056 	inc     r0
   65B0 A6 02              2057 	mov	@r0,ar2
   65B2 08                 2058 	inc	r0
   65B3 A6 03              2059 	mov	@r0,ar3
   65B5 08                 2060 	inc	r0
   65B6 A6 04              2061 	mov	@r0,ar4
   65B8 08                 2062 	inc	r0
   65B9 A6 05              2063 	mov	@r0,ar5
                           2064 ;src/rtc.c:237: system_time.tm_min=epoch%60;
                           2065 ;     genAssign
   65BB E4                 2066 	clr	a
   65BC F5 45              2067 	mov	(__modulong_PARM_2 + 3),a
   65BE F5 44              2068 	mov	(__modulong_PARM_2 + 2),a
   65C0 F5 43              2069 	mov	(__modulong_PARM_2 + 1),a
   65C2 75 42 3C           2070 	mov	__modulong_PARM_2,#0x3C
                           2071 ;     genCall
                           2072 ;       Peephole 212    reduced add sequence to inc
   65C5 A8 40              2073 	mov     r0,_bp
   65C7 08                 2074 	inc     r0
   65C8 86 82              2075 	mov	dpl,@r0
   65CA 08                 2076 	inc	r0
   65CB 86 83              2077 	mov	dph,@r0
   65CD 08                 2078 	inc	r0
   65CE 86 F0              2079 	mov	b,@r0
   65D0 08                 2080 	inc	r0
   65D1 E6                 2081 	mov	a,@r0
   65D2 12 6F 85           2082 	lcall	__modulong
   65D5 AA 82              2083 	mov	r2,dpl
   65D7 AB 83              2084 	mov	r3,dph
   65D9 AC F0              2085 	mov	r4,b
   65DB FD                 2086 	mov	r5,a
                           2087 ;     genCast
                           2088 ;     genPointerSet
                           2089 ;     genFarPointerSet
   65DC 90 01 82           2090 	mov	dptr,#(_system_time + 0x0001)
   65DF EA                 2091 	mov	a,r2
   65E0 F0                 2092 	movx	@dptr,a
                           2093 ;src/rtc.c:238: epoch/=60; // now it is hours
                           2094 ;     genAssign
   65E1 E4                 2095 	clr	a
   65E2 F5 45              2096 	mov	(__divulong_PARM_2 + 3),a
   65E4 F5 44              2097 	mov	(__divulong_PARM_2 + 2),a
   65E6 F5 43              2098 	mov	(__divulong_PARM_2 + 1),a
   65E8 75 42 3C           2099 	mov	__divulong_PARM_2,#0x3C
                           2100 ;     genCall
                           2101 ;       Peephole 212    reduced add sequence to inc
   65EB A8 40              2102 	mov     r0,_bp
   65ED 08                 2103 	inc     r0
   65EE 86 82              2104 	mov	dpl,@r0
   65F0 08                 2105 	inc	r0
   65F1 86 83              2106 	mov	dph,@r0
   65F3 08                 2107 	inc	r0
   65F4 86 F0              2108 	mov	b,@r0
   65F6 08                 2109 	inc	r0
   65F7 E6                 2110 	mov	a,@r0
   65F8 12 70 08           2111 	lcall	__divulong
   65FB AA 82              2112 	mov	r2,dpl
   65FD AB 83              2113 	mov	r3,dph
   65FF AC F0              2114 	mov	r4,b
   6601 FD                 2115 	mov	r5,a
                           2116 ;     genAssign
                           2117 ;       Peephole 212    reduced add sequence to inc
   6602 A8 40              2118 	mov     r0,_bp
   6604 08                 2119 	inc     r0
   6605 A6 02              2120 	mov	@r0,ar2
   6607 08                 2121 	inc	r0
   6608 A6 03              2122 	mov	@r0,ar3
   660A 08                 2123 	inc	r0
   660B A6 04              2124 	mov	@r0,ar4
   660D 08                 2125 	inc	r0
   660E A6 05              2126 	mov	@r0,ar5
                           2127 ;src/rtc.c:239: system_time.tm_hour=epoch%24;
                           2128 ;     genAssign
   6610 E4                 2129 	clr	a
   6611 F5 45              2130 	mov	(__modulong_PARM_2 + 3),a
   6613 F5 44              2131 	mov	(__modulong_PARM_2 + 2),a
   6615 F5 43              2132 	mov	(__modulong_PARM_2 + 1),a
   6617 75 42 18           2133 	mov	__modulong_PARM_2,#0x18
                           2134 ;     genCall
                           2135 ;       Peephole 212    reduced add sequence to inc
   661A A8 40              2136 	mov     r0,_bp
   661C 08                 2137 	inc     r0
   661D 86 82              2138 	mov	dpl,@r0
   661F 08                 2139 	inc	r0
   6620 86 83              2140 	mov	dph,@r0
   6622 08                 2141 	inc	r0
   6623 86 F0              2142 	mov	b,@r0
   6625 08                 2143 	inc	r0
   6626 E6                 2144 	mov	a,@r0
   6627 12 6F 85           2145 	lcall	__modulong
   662A AA 82              2146 	mov	r2,dpl
   662C AB 83              2147 	mov	r3,dph
   662E AC F0              2148 	mov	r4,b
   6630 FD                 2149 	mov	r5,a
                           2150 ;     genCast
                           2151 ;     genPointerSet
                           2152 ;     genFarPointerSet
   6631 90 01 83           2153 	mov	dptr,#(_system_time + 0x0002)
   6634 EA                 2154 	mov	a,r2
   6635 F0                 2155 	movx	@dptr,a
                           2156 ;src/rtc.c:240: epoch/=24; // now it is days
                           2157 ;     genAssign
   6636 E4                 2158 	clr	a
   6637 F5 45              2159 	mov	(__divulong_PARM_2 + 3),a
   6639 F5 44              2160 	mov	(__divulong_PARM_2 + 2),a
   663B F5 43              2161 	mov	(__divulong_PARM_2 + 1),a
   663D 75 42 18           2162 	mov	__divulong_PARM_2,#0x18
                           2163 ;     genCall
                           2164 ;       Peephole 212    reduced add sequence to inc
   6640 A8 40              2165 	mov     r0,_bp
   6642 08                 2166 	inc     r0
   6643 86 82              2167 	mov	dpl,@r0
   6645 08                 2168 	inc	r0
   6646 86 83              2169 	mov	dph,@r0
   6648 08                 2170 	inc	r0
   6649 86 F0              2171 	mov	b,@r0
   664B 08                 2172 	inc	r0
   664C E6                 2173 	mov	a,@r0
   664D 12 70 08           2174 	lcall	__divulong
   6650 AA 82              2175 	mov	r2,dpl
   6652 AB 83              2176 	mov	r3,dph
   6654 AC F0              2177 	mov	r4,b
   6656 FD                 2178 	mov	r5,a
                           2179 ;     genAssign
                           2180 ;       Peephole 212    reduced add sequence to inc
   6657 A8 40              2181 	mov     r0,_bp
   6659 08                 2182 	inc     r0
   665A A6 02              2183 	mov	@r0,ar2
   665C 08                 2184 	inc	r0
   665D A6 03              2185 	mov	@r0,ar3
   665F 08                 2186 	inc	r0
   6660 A6 04              2187 	mov	@r0,ar4
   6662 08                 2188 	inc	r0
   6663 A6 05              2189 	mov	@r0,ar5
                           2190 ;src/rtc.c:241: system_time.tm_wday=(epoch+4)%7;
                           2191 ;     genPlus
                           2192 ;       Peephole 212    reduced add sequence to inc
   6665 A8 40              2193 	mov     r0,_bp
   6667 08                 2194 	inc     r0
                           2195 ;     genPlusIncr
   6668 74 04              2196 	mov	a,#0x04
   666A 26                 2197 	add	a,@r0
   666B FA                 2198 	mov	r2,a
                           2199 ;       Peephole 181    changed mov to clr
   666C E4                 2200 	clr     a
   666D 08                 2201 	inc	r0
   666E 36                 2202 	addc	a,@r0
   666F FB                 2203 	mov	r3,a
                           2204 ;       Peephole 181    changed mov to clr
   6670 E4                 2205 	clr     a
   6671 08                 2206 	inc	r0
   6672 36                 2207 	addc	a,@r0
   6673 FC                 2208 	mov	r4,a
                           2209 ;       Peephole 181    changed mov to clr
   6674 E4                 2210 	clr     a
   6675 08                 2211 	inc	r0
   6676 36                 2212 	addc	a,@r0
   6677 FD                 2213 	mov	r5,a
                           2214 ;     genAssign
   6678 E4                 2215 	clr	a
   6679 F5 45              2216 	mov	(__modulong_PARM_2 + 3),a
   667B F5 44              2217 	mov	(__modulong_PARM_2 + 2),a
   667D F5 43              2218 	mov	(__modulong_PARM_2 + 1),a
   667F 75 42 07           2219 	mov	__modulong_PARM_2,#0x07
                           2220 ;     genCall
   6682 8A 82              2221 	mov	dpl,r2
   6684 8B 83              2222 	mov	dph,r3
   6686 8C F0              2223 	mov	b,r4
   6688 ED                 2224 	mov	a,r5
   6689 12 6F 85           2225 	lcall	__modulong
   668C AA 82              2226 	mov	r2,dpl
   668E AB 83              2227 	mov	r3,dph
   6690 AC F0              2228 	mov	r4,b
   6692 FD                 2229 	mov	r5,a
                           2230 ;     genCast
                           2231 ;     genPointerSet
                           2232 ;     genFarPointerSet
   6693 90 01 88           2233 	mov	dptr,#(_system_time + 0x0007)
   6696 EA                 2234 	mov	a,r2
   6697 F0                 2235 	movx	@dptr,a
                           2236 ;src/rtc.c:244: days=0;
                           2237 ;     genAssign
   6698 E5 40              2238 	mov	a,_bp
   669A 24 05              2239 	add	a,#0x05
                           2240 ;       Peephole 218    simplified clear (4bytes)
   669C F8                 2241 	mov     r0,a
   669D E4                 2242 	clr     a
   669E F6                 2243 	mov     @r0,a
   669F 08                 2244 	inc     r0
   66A0 F6                 2245 	mov     @r0,a
   66A1 08                 2246 	inc     r0
   66A2 F6                 2247 	mov     @r0,a
   66A3 08                 2248 	inc     r0
   66A4 F6                 2249 	mov     @r0,a
                           2250 ;src/rtc.c:245: while((days += (LEAP_YEAR(year) ? 366 : 365)) <= epoch) {
                           2251 ;     genAssign
   66A5 7E B2              2252 	mov	r6,#0xB2
   66A7 7F 07              2253 	mov	r7,#0x07
   66A9                    2254 00101$:
                           2255 ;     genIpush
                           2256 ;     genAnd
   66A9 74 03              2257 	mov	a,#0x03
   66AB 5E                 2258 	anl	a,r6
   66AC FA                 2259 	mov	r2,a
   66AD 7B 00              2260 	mov	r3,#0x00
                           2261 ;     genCmpEq
                           2262 ;       Peephole 241.b  optimized compare
   66AF E4                 2263 	clr     a
   66B0 BA 00 04           2264 	cjne    r2,#0x00,00132$
   66B3 BB 00 01           2265 	cjne    r3,#0x00,00132$
   66B6 04                 2266 	inc     a
   66B7                    2267 00132$:
   66B7                    2268 00133$:
                           2269 ;     genIpop
                           2270 ;     genIfx
                           2271 ;     genIfxJump
                           2272 ;       Peephole 110    removed ljmp by inverse jump logic
   66B7 60 06              2273 	jz      00119$
   66B9                    2274 00134$:
                           2275 ;     genAssign
   66B9 7A 6E              2276 	mov	r2,#0x6E
   66BB 7B 01              2277 	mov	r3,#0x01
                           2278 ;       Peephole 112.b  changed ljmp to sjmp
   66BD 80 04              2279 	sjmp    00120$
   66BF                    2280 00119$:
                           2281 ;     genAssign
   66BF 7A 6D              2282 	mov	r2,#0x6D
   66C1 7B 01              2283 	mov	r3,#0x01
   66C3                    2284 00120$:
                           2285 ;     genCast
   66C3 EB                 2286 	mov	a,r3
   66C4 33                 2287 	rlc	a
   66C5 95 E0              2288 	subb	a,acc
   66C7 FC                 2289 	mov	r4,a
   66C8 FD                 2290 	mov	r5,a
                           2291 ;     genPlus
   66C9 E5 40              2292 	mov	a,_bp
   66CB 24 05              2293 	add	a,#0x05
   66CD F8                 2294 	mov	r0,a
                           2295 ;       Peephole 236.g  used r2 instead of ar2
   66CE EA                 2296 	mov     a,r2
   66CF 26                 2297 	add	a,@r0
   66D0 FA                 2298 	mov	r2,a
                           2299 ;       Peephole 236.g  used r3 instead of ar3
   66D1 EB                 2300 	mov     a,r3
   66D2 08                 2301 	inc	r0
   66D3 36                 2302 	addc	a,@r0
   66D4 FB                 2303 	mov	r3,a
                           2304 ;       Peephole 236.g  used r4 instead of ar4
   66D5 EC                 2305 	mov     a,r4
   66D6 08                 2306 	inc	r0
   66D7 36                 2307 	addc	a,@r0
   66D8 FC                 2308 	mov	r4,a
                           2309 ;       Peephole 236.g  used r5 instead of ar5
   66D9 ED                 2310 	mov     a,r5
   66DA 08                 2311 	inc	r0
   66DB 36                 2312 	addc	a,@r0
   66DC FD                 2313 	mov	r5,a
                           2314 ;     genAssign
   66DD E5 40              2315 	mov	a,_bp
   66DF 24 05              2316 	add	a,#0x05
   66E1 F8                 2317 	mov	r0,a
   66E2 A6 02              2318 	mov	@r0,ar2
   66E4 08                 2319 	inc	r0
   66E5 A6 03              2320 	mov	@r0,ar3
   66E7 08                 2321 	inc	r0
   66E8 A6 04              2322 	mov	@r0,ar4
   66EA 08                 2323 	inc	r0
   66EB A6 05              2324 	mov	@r0,ar5
                           2325 ;     genCmpGt
                           2326 ;       Peephole 212    reduced add sequence to inc
   66ED A8 40              2327 	mov     r0,_bp
   66EF 08                 2328 	inc     r0
                           2329 ;     genCmp
   66F0 C3                 2330 	clr	c
   66F1 E6                 2331 	mov	a,@r0
   66F2 9A                 2332 	subb	a,r2
   66F3 08                 2333 	inc	r0
   66F4 E6                 2334 	mov	a,@r0
   66F5 9B                 2335 	subb	a,r3
   66F6 08                 2336 	inc	r0
   66F7 E6                 2337 	mov	a,@r0
   66F8 9C                 2338 	subb	a,r4
   66F9 08                 2339 	inc	r0
   66FA E6                 2340 	mov	a,@r0
   66FB 9D                 2341 	subb	a,r5
                           2342 ;     genIfxJump
                           2343 ;       Peephole 112.b  changed ljmp to sjmp
                           2344 ;       Peephole 160    removed sjmp by inverse jump logic
   66FC 40 07              2345 	jc      00103$
   66FE                    2346 00135$:
                           2347 ;src/rtc.c:246: year++;
                           2348 ;     genPlus
                           2349 ;     genPlusIncr
   66FE 0E                 2350 	inc	r6
                           2351 ;       Peephole 112.b  changed ljmp to sjmp
                           2352 ;       Peephole 243    avoided branch to sjmp
   66FF BE 00 A7           2353 	cjne    r6,#0x00,00101$
   6702 0F                 2354 	inc     r7
   6703                    2355 00136$:
   6703 80 A4              2356 	sjmp    00101$      
   6705                    2357 00103$:
                           2358 ;src/rtc.c:248: system_time.tm_year=year-2000;
                           2359 ;     genMinus
   6705 EE                 2360 	mov	a,r6
   6706 24 30              2361 	add	a,#0x30
   6708 FA                 2362 	mov	r2,a
   6709 EF                 2363 	mov	a,r7
   670A 34 F8              2364 	addc	a,#0xf8
   670C FB                 2365 	mov	r3,a
                           2366 ;     genPointerSet
                           2367 ;     genFarPointerSet
   670D 90 01 86           2368 	mov	dptr,#(_system_time + 0x0005)
   6710 EA                 2369 	mov	a,r2
   6711 F0                 2370 	movx	@dptr,a
   6712 A3                 2371 	inc	dptr
   6713 EB                 2372 	mov	a,r3
   6714 F0                 2373 	movx	@dptr,a
                           2374 ;src/rtc.c:250: days -= LEAP_YEAR(year) ? 366 : 365;
                           2375 ;     genAnd
   6715 53 06 03           2376 	anl	ar6,#0x03
   6718 7F 00              2377 	mov	r7,#0x00
                           2378 ;     genCmpEq
                           2379 ;       Peephole 241.b  optimized compare
   671A E4                 2380 	clr     a
   671B BE 00 04           2381 	cjne    r6,#0x00,00137$
   671E BF 00 01           2382 	cjne    r7,#0x00,00137$
   6721 04                 2383 	inc     a
   6722                    2384 00137$:
   6722                    2385 00138$:
                           2386 ;     genIfx
                           2387 ;       Peephole 105    removed redundant mov
   6722 FA                 2388 	mov     r2,a
                           2389 ;     genIfxJump
                           2390 ;       Peephole 110    removed ljmp by inverse jump logic
   6723 60 06              2391 	jz      00121$
   6725                    2392 00139$:
                           2393 ;     genAssign
   6725 7B 6E              2394 	mov	r3,#0x6E
   6727 7C 01              2395 	mov	r4,#0x01
                           2396 ;       Peephole 112.b  changed ljmp to sjmp
   6729 80 04              2397 	sjmp    00122$
   672B                    2398 00121$:
                           2399 ;     genAssign
   672B 7B 6D              2400 	mov	r3,#0x6D
   672D 7C 01              2401 	mov	r4,#0x01
   672F                    2402 00122$:
                           2403 ;     genCast
   672F EC                 2404 	mov	a,r4
   6730 33                 2405 	rlc	a
   6731 95 E0              2406 	subb	a,acc
   6733 FD                 2407 	mov	r5,a
   6734 FE                 2408 	mov	r6,a
                           2409 ;     genMinus
   6735 E5 40              2410 	mov	a,_bp
   6737 24 05              2411 	add	a,#0x05
   6739 F8                 2412 	mov	r0,a
   673A E6                 2413 	mov	a,@r0
   673B C3                 2414 	clr	c
                           2415 ;       Peephole 236.l  used r3 instead of ar3
   673C 9B                 2416 	subb    a,r3
   673D F6                 2417 	mov	@r0,a
   673E 08                 2418 	inc	r0
   673F E6                 2419 	mov	a,@r0
                           2420 ;       Peephole 236.l  used r4 instead of ar4
   6740 9C                 2421 	subb    a,r4
   6741 F6                 2422 	mov	@r0,a
   6742 08                 2423 	inc	r0
   6743 E6                 2424 	mov	a,@r0
                           2425 ;       Peephole 236.l  used r5 instead of ar5
   6744 9D                 2426 	subb    a,r5
   6745 F6                 2427 	mov	@r0,a
   6746 08                 2428 	inc	r0
   6747 E6                 2429 	mov	a,@r0
                           2430 ;       Peephole 236.l  used r6 instead of ar6
   6748 9E                 2431 	subb    a,r6
   6749 F6                 2432 	mov	@r0,a
                           2433 ;src/rtc.c:251: epoch -= days; // now it is days in this year, starting at 0
                           2434 ;     genMinus
                           2435 ;       Peephole 212    reduced add sequence to inc
   674A A8 40              2436 	mov     r0,_bp
   674C 08                 2437 	inc     r0
   674D E5 40              2438 	mov	a,_bp
   674F 24 05              2439 	add	a,#0x05
   6751 F9                 2440 	mov	r1,a
   6752 E6                 2441 	mov	a,@r0
   6753 C3                 2442 	clr	c
   6754 97                 2443 	subb	a,@r1
   6755 F6                 2444 	mov	@r0,a
   6756 08                 2445 	inc	r0
   6757 E6                 2446 	mov	a,@r0
   6758 09                 2447 	inc	r1
   6759 97                 2448 	subb	a,@r1
   675A F6                 2449 	mov	@r0,a
   675B 08                 2450 	inc	r0
   675C E6                 2451 	mov	a,@r0
   675D 09                 2452 	inc	r1
   675E 97                 2453 	subb	a,@r1
   675F F6                 2454 	mov	@r0,a
   6760 08                 2455 	inc	r0
   6761 E6                 2456 	mov	a,@r0
   6762 09                 2457 	inc	r1
   6763 97                 2458 	subb	a,@r1
   6764 F6                 2459 	mov	@r0,a
                           2460 ;src/rtc.c:252: system_time.tm_yday=epoch;
                           2461 ;     genCast
                           2462 ;       Peephole 212    reduced add sequence to inc
   6765 A8 40              2463 	mov     r0,_bp
   6767 08                 2464 	inc     r0
   6768 86 03              2465 	mov	ar3,@r0
   676A 08                 2466 	inc	r0
   676B 86 04              2467 	mov	ar4,@r0
                           2468 ;     genPointerSet
                           2469 ;     genFarPointerSet
   676D 90 01 89           2470 	mov	dptr,#(_system_time + 0x0008)
   6770 EB                 2471 	mov	a,r3
   6771 F0                 2472 	movx	@dptr,a
   6772 A3                 2473 	inc	dptr
   6773 EC                 2474 	mov	a,r4
   6774 F0                 2475 	movx	@dptr,a
                           2476 ;src/rtc.c:257: for (month=0; month<12; month++) {
                           2477 ;     genAssign
   6775 7B 00              2478 	mov	r3,#0x00
   6777                    2479 00113$:
                           2480 ;     genCmpLt
                           2481 ;     genCmp
   6777 BB 0C 00           2482 	cjne	r3,#0x0C,00140$
   677A                    2483 00140$:
                           2484 ;     genIfxJump
                           2485 ;       Peephole 108    removed ljmp by inverse jump logic
   677A 50 52              2486 	jnc     00116$
   677C                    2487 00141$:
                           2488 ;src/rtc.c:258: if (month==1) { // februari
                           2489 ;     genCmpEq
                           2490 ;       Peephole 112.b  changed ljmp to sjmp
                           2491 ;       Peephole 199    optimized misc jump sequence
   677C BB 01 0B           2492 	cjne    r3,#0x01,00108$
                           2493 ;00142$:
                           2494 ;       Peephole 200    removed redundant sjmp
   677F                    2495 00143$:
                           2496 ;src/rtc.c:259: if (LEAP_YEAR(year)) {
                           2497 ;     genIfx
   677F EA                 2498 	mov	a,r2
                           2499 ;     genIfxJump
                           2500 ;       Peephole 110    removed ljmp by inverse jump logic
   6780 60 04              2501 	jz      00105$
   6782                    2502 00144$:
                           2503 ;src/rtc.c:260: monthLength=29;
                           2504 ;     genAssign
   6782 7C 1D              2505 	mov	r4,#0x1D
                           2506 ;       Peephole 112.b  changed ljmp to sjmp
   6784 80 0C              2507 	sjmp    00109$
   6786                    2508 00105$:
                           2509 ;src/rtc.c:262: monthLength=28;
                           2510 ;     genAssign
   6786 7C 1C              2511 	mov	r4,#0x1C
                           2512 ;       Peephole 112.b  changed ljmp to sjmp
   6788 80 08              2513 	sjmp    00109$
   678A                    2514 00108$:
                           2515 ;src/rtc.c:265: monthLength = monthDays[month];
                           2516 ;     genPlus
                           2517 ;       Peephole 236.g  used r3 instead of ar3
   678A EB                 2518 	mov     a,r3
                           2519 ;       Peephole 181    changed mov to clr
                           2520 ;     genPointerGet
                           2521 ;     genCodePointerGet
                           2522 ;       Peephole 181    changed mov to clr
                           2523 ;       Peephole 186.d  optimized movc sequence
   678B 90 6E 62           2524 	mov     dptr,#_monthDays
   678E 93                 2525 	movc    a,@a+dptr
   678F FD                 2526 	mov	r5,a
                           2527 ;     genAssign
   6790 8D 04              2528 	mov	ar4,r5
   6792                    2529 00109$:
                           2530 ;src/rtc.c:268: if (epoch>=monthLength) {
                           2531 ;     genIpush
   6792 C0 02              2532 	push	ar2
                           2533 ;     genCast
   6794 8C 05              2534 	mov	ar5,r4
   6796 7E 00              2535 	mov	r6,#0x00
                           2536 ;     genCmpLt
                           2537 ;       Peephole 3.c    changed mov to clr
   6798 E4                 2538 	clr     a
   6799 FF                 2539 	mov     r7,a
   679A FA                 2540 	mov     r2,a
                           2541 ;       Peephole 212    reduced add sequence to inc
   679B A8 40              2542 	mov     r0,_bp
   679D 08                 2543 	inc     r0
                           2544 ;     genCmp
   679E C3                 2545 	clr	c
   679F E6                 2546 	mov	a,@r0
   67A0 9D                 2547 	subb	a,r5
   67A1 08                 2548 	inc	r0
   67A2 E6                 2549 	mov	a,@r0
   67A3 9E                 2550 	subb	a,r6
   67A4 08                 2551 	inc	r0
   67A5 E6                 2552 	mov	a,@r0
   67A6 9F                 2553 	subb	a,r7
   67A7 08                 2554 	inc	r0
   67A8 E6                 2555 	mov	a,@r0
   67A9 9A                 2556 	subb	a,r2
   67AA E4                 2557 	clr	a
   67AB 33                 2558 	rlc	a
                           2559 ;     genIpop
   67AC D0 02              2560 	pop	ar2
                           2561 ;     genIfx
                           2562 ;     genIfxJump
                           2563 ;       Peephole 109    removed ljmp by inverse jump logic
   67AE 70 1E              2564 	jnz     00116$
   67B0                    2565 00145$:
                           2566 ;src/rtc.c:269: epoch-=monthLength;
                           2567 ;     genCast
   67B0 7D 00              2568 	mov	r5,#0x00
                           2569 ;     genCast
   67B2 ED                 2570 	mov	a,r5
   67B3 33                 2571 	rlc	a
   67B4 95 E0              2572 	subb	a,acc
   67B6 FE                 2573 	mov	r6,a
   67B7 FF                 2574 	mov	r7,a
                           2575 ;     genMinus
                           2576 ;       Peephole 212    reduced add sequence to inc
   67B8 A8 40              2577 	mov     r0,_bp
   67BA 08                 2578 	inc     r0
   67BB E6                 2579 	mov	a,@r0
   67BC C3                 2580 	clr	c
                           2581 ;       Peephole 236.l  used r4 instead of ar4
   67BD 9C                 2582 	subb    a,r4
   67BE F6                 2583 	mov	@r0,a
   67BF 08                 2584 	inc	r0
   67C0 E6                 2585 	mov	a,@r0
                           2586 ;       Peephole 236.l  used r5 instead of ar5
   67C1 9D                 2587 	subb    a,r5
   67C2 F6                 2588 	mov	@r0,a
   67C3 08                 2589 	inc	r0
   67C4 E6                 2590 	mov	a,@r0
                           2591 ;       Peephole 236.l  used r6 instead of ar6
   67C5 9E                 2592 	subb    a,r6
   67C6 F6                 2593 	mov	@r0,a
   67C7 08                 2594 	inc	r0
   67C8 E6                 2595 	mov	a,@r0
                           2596 ;       Peephole 236.l  used r7 instead of ar7
   67C9 9F                 2597 	subb    a,r7
   67CA F6                 2598 	mov	@r0,a
                           2599 ;src/rtc.c:257: for (month=0; month<12; month++) {
                           2600 ;     genPlus
                           2601 ;     genPlusIncr
   67CB 0B                 2602 	inc	r3
                           2603 ;       Peephole 112.b  changed ljmp to sjmp
   67CC 80 A9              2604 	sjmp    00113$
   67CE                    2605 00116$:
                           2606 ;src/rtc.c:274: system_time.tm_mon=month;
                           2607 ;     genPointerSet
                           2608 ;     genFarPointerSet
   67CE 90 01 85           2609 	mov	dptr,#(_system_time + 0x0004)
   67D1 EB                 2610 	mov	a,r3
   67D2 F0                 2611 	movx	@dptr,a
                           2612 ;src/rtc.c:275: system_time.tm_mday=epoch+1;
                           2613 ;     genCast
                           2614 ;       Peephole 212    reduced add sequence to inc
   67D3 A8 40              2615 	mov     r0,_bp
   67D5 08                 2616 	inc     r0
   67D6 86 02              2617 	mov	ar2,@r0
                           2618 ;     genPlus
                           2619 ;     genPlusIncr
   67D8 0A                 2620 	inc	r2
                           2621 ;     genPointerSet
                           2622 ;     genFarPointerSet
   67D9 90 01 84           2623 	mov	dptr,#(_system_time + 0x0003)
   67DC EA                 2624 	mov	a,r2
   67DD F0                 2625 	movx	@dptr,a
                           2626 ;src/rtc.c:277: system_time.tm_isdst=0;
                           2627 ;     genPointerSet
                           2628 ;     genFarPointerSet
   67DE 90 01 8B           2629 	mov	dptr,#(_system_time + 0x000a)
                           2630 ;       Peephole 181    changed mov to clr
   67E1 E4                 2631 	clr     a
   67E2 F0                 2632 	movx	@dptr,a
   67E3                    2633 00117$:
   67E3 85 40 81           2634 	mov	sp,_bp
   67E6 D0 40              2635 	pop	_bp
   67E8 22                 2636 	ret
                           2637 ;------------------------------------------------------------
                           2638 ;Allocation info for local variables in function 'local_mktime'
                           2639 ;------------------------------------------------------------
                           2640 ;add                       Allocated to stack - offset -4
                           2641 ;timeptr                   Allocated to stack - offset 1
                           2642 ;year                      Allocated to stack - offset 4
                           2643 ;month                     Allocated to stack - offset 6
                           2644 ;mday                      Allocated to stack - offset 7
                           2645 ;i                         Allocated to registers 
                           2646 ;seconds                   Allocated to stack - offset 8
                           2647 ;------------------------------------------------------------
                           2648 ;src/rtc.c:286: time_t local_mktime(struct tm *timeptr, unsigned int add) {
                           2649 ;	-----------------------------------------
                           2650 ;	 function local_mktime
                           2651 ;	-----------------------------------------
   67E9                    2652 _local_mktime:
   67E9 C0 40              2653 	push	_bp
   67EB 85 81 40           2654 	mov	_bp,sp
   67EE E5 81              2655 	mov	a,sp
   67F0 24 0B              2656 	add	a,#0x0b
   67F2 F5 81              2657 	mov	sp,a
                           2658 ;     genReceive
   67F4 C0 E0              2659 	push	acc
                           2660 ;       Peephole 212    reduced add sequence to inc
   67F6 A8 40              2661 	mov     r0,_bp
   67F8 08                 2662 	inc     r0
   67F9 D0 E0              2663 	pop	acc
   67FB A6 82              2664 	mov	@r0,dpl
   67FD 08                 2665 	inc	r0
   67FE A6 83              2666 	mov	@r0,dph
   6800 08                 2667 	inc	r0
   6801 A6 F0              2668 	mov	@r0,b
                           2669 ;src/rtc.c:289: int year=timeptr->tm_year + add;
                           2670 ;     genPlus
                           2671 ;       Peephole 212    reduced add sequence to inc
   6803 A8 40              2672 	mov     r0,_bp
   6805 08                 2673 	inc     r0
   6806 74 05              2674 	mov	a,#0x05
   6808 26                 2675 	add	a,@r0
   6809 FD                 2676 	mov	r5,a
                           2677 ;       Peephole 181    changed mov to clr
   680A E4                 2678 	clr     a
   680B 08                 2679 	inc	r0
   680C 36                 2680 	addc	a,@r0
   680D FE                 2681 	mov	r6,a
   680E 08                 2682 	inc	r0
   680F 86 07              2683 	mov	ar7,@r0
                           2684 ;     genPointerGet
                           2685 ;     genGenPointerGet
   6811 8D 82              2686 	mov	dpl,r5
   6813 8E 83              2687 	mov	dph,r6
   6815 8F F0              2688 	mov	b,r7
   6817 12 71 F5           2689 	lcall	__gptrget
   681A FD                 2690 	mov	r5,a
   681B A3                 2691 	inc	dptr
   681C 12 71 F5           2692 	lcall	__gptrget
   681F FE                 2693 	mov	r6,a
                           2694 ;     genPlus
   6820 E5 40              2695 	mov	a,_bp
   6822 24 FC              2696 	add	a,#0xfc
   6824 F8                 2697 	mov	r0,a
   6825 E6                 2698 	mov	a,@r0
                           2699 ;       Peephole 236.a  used r5 instead of ar5
   6826 2D                 2700 	add     a,r5
   6827 FD                 2701 	mov	r5,a
   6828 08                 2702 	inc	r0
   6829 E6                 2703 	mov	a,@r0
                           2704 ;       Peephole 236.b  used r6 instead of ar6
   682A 3E                 2705 	addc    a,r6
   682B FE                 2706 	mov	r6,a
                           2707 ;     genAssign
   682C E5 40              2708 	mov	a,_bp
   682E 24 04              2709 	add	a,#0x04
   6830 F8                 2710 	mov	r0,a
   6831 A6 05              2711 	mov	@r0,ar5
   6833 08                 2712 	inc	r0
   6834 A6 06              2713 	mov	@r0,ar6
                           2714 ;src/rtc.c:290: char month=timeptr->tm_mon;
                           2715 ;     genPlus
                           2716 ;       Peephole 212    reduced add sequence to inc
   6836 A8 40              2717 	mov     r0,_bp
   6838 08                 2718 	inc     r0
                           2719 ;     genPlusIncr
   6839 74 04              2720 	mov	a,#0x04
   683B 26                 2721 	add	a,@r0
   683C FF                 2722 	mov	r7,a
                           2723 ;       Peephole 181    changed mov to clr
   683D E4                 2724 	clr     a
   683E 08                 2725 	inc	r0
   683F 36                 2726 	addc	a,@r0
   6840 FA                 2727 	mov	r2,a
   6841 08                 2728 	inc	r0
   6842 86 03              2729 	mov	ar3,@r0
                           2730 ;     genPointerGet
                           2731 ;     genGenPointerGet
   6844 8F 82              2732 	mov	dpl,r7
   6846 8A 83              2733 	mov	dph,r2
   6848 8B F0              2734 	mov	b,r3
   684A 12 71 F5           2735 	lcall	__gptrget
   684D FF                 2736 	mov	r7,a
                           2737 ;     genAssign
   684E E5 40              2738 	mov	a,_bp
   6850 24 06              2739 	add	a,#0x06
   6852 F8                 2740 	mov	r0,a
   6853 A6 07              2741 	mov	@r0,ar7
                           2742 ;src/rtc.c:291: char mday = timeptr->tm_mday - 1;
                           2743 ;     genPlus
                           2744 ;       Peephole 212    reduced add sequence to inc
   6855 A8 40              2745 	mov     r0,_bp
   6857 08                 2746 	inc     r0
                           2747 ;     genPlusIncr
   6858 74 03              2748 	mov	a,#0x03
   685A 26                 2749 	add	a,@r0
   685B FB                 2750 	mov	r3,a
                           2751 ;       Peephole 181    changed mov to clr
   685C E4                 2752 	clr     a
   685D 08                 2753 	inc	r0
   685E 36                 2754 	addc	a,@r0
   685F FC                 2755 	mov	r4,a
   6860 08                 2756 	inc	r0
   6861 86 07              2757 	mov	ar7,@r0
                           2758 ;     genPointerGet
                           2759 ;     genGenPointerGet
   6863 8B 82              2760 	mov	dpl,r3
   6865 8C 83              2761 	mov	dph,r4
   6867 8F F0              2762 	mov	b,r7
   6869 12 71 F5           2763 	lcall	__gptrget
   686C FB                 2764 	mov	r3,a
                           2765 ;     genMinus
   686D E5 40              2766 	mov	a,_bp
   686F 24 07              2767 	add	a,#0x07
   6871 F8                 2768 	mov	r0,a
                           2769 ;     genMinusDec
   6872 EB                 2770 	mov	a,r3
   6873 14                 2771 	dec	a
   6874 F6                 2772 	mov	@r0,a
                           2773 ;src/rtc.c:295: check_time(timeptr);
                           2774 ;     genCall
                           2775 ;       Peephole 212    reduced add sequence to inc
   6875 A8 40              2776 	mov     r0,_bp
   6877 08                 2777 	inc     r0
   6878 86 82              2778 	mov	dpl,@r0
   687A 08                 2779 	inc	r0
   687B 86 83              2780 	mov	dph,@r0
   687D 08                 2781 	inc	r0
   687E 86 F0              2782 	mov	b,@r0
   6880 12 63 CB           2783 	lcall	_check_time
                           2784 ;src/rtc.c:298: seconds = (year-1970)*(YEAR);
                           2785 ;     genMinus
   6883 E5 40              2786 	mov	a,_bp
   6885 24 04              2787 	add	a,#0x04
   6887 F8                 2788 	mov	r0,a
   6888 E6                 2789 	mov	a,@r0
   6889 24 4E              2790 	add	a,#0x4e
   688B FC                 2791 	mov	r4,a
   688C 08                 2792 	inc	r0
   688D E6                 2793 	mov	a,@r0
   688E 34 F8              2794 	addc	a,#0xf8
                           2795 ;     genCast
                           2796 ;       Peephole 105    removed redundant mov
   6890 FF                 2797 	mov     r7,a
   6891 33                 2798 	rlc	a
   6892 95 E0              2799 	subb	a,acc
   6894 FB                 2800 	mov	r3,a
   6895 FA                 2801 	mov	r2,a
                           2802 ;     genAssign
   6896 75 42 80           2803 	mov	__mullong_PARM_2,#0x80
   6899 75 43 33           2804 	mov	(__mullong_PARM_2 + 1),#0x33
   689C 75 44 E1           2805 	mov	(__mullong_PARM_2 + 2),#0xE1
   689F 75 45 01           2806 	mov	(__mullong_PARM_2 + 3),#0x01
                           2807 ;     genCall
   68A2 8C 82              2808 	mov	dpl,r4
   68A4 8F 83              2809 	mov	dph,r7
   68A6 8B F0              2810 	mov	b,r3
   68A8 EA                 2811 	mov	a,r2
   68A9 12 70 BF           2812 	lcall	__mullong
   68AC AA 82              2813 	mov	r2,dpl
   68AE AB 83              2814 	mov	r3,dph
   68B0 AC F0              2815 	mov	r4,b
   68B2 FF                 2816 	mov	r7,a
                           2817 ;     genAssign
   68B3 E5 40              2818 	mov	a,_bp
   68B5 24 08              2819 	add	a,#0x08
   68B7 F8                 2820 	mov	r0,a
   68B8 A6 02              2821 	mov	@r0,ar2
   68BA 08                 2822 	inc	r0
   68BB A6 03              2823 	mov	@r0,ar3
   68BD 08                 2824 	inc	r0
   68BE A6 04              2825 	mov	@r0,ar4
   68C0 08                 2826 	inc	r0
   68C1 A6 07              2827 	mov	@r0,ar7
                           2828 ;src/rtc.c:301: for (i=1970; i<year; i++) 
                           2829 ;     genAssign
   68C3 7D B2              2830 	mov	r5,#0xB2
   68C5 7E 07              2831 	mov	r6,#0x07
   68C7                    2832 00107$:
                           2833 ;     genCmpLt
   68C7 E5 40              2834 	mov	a,_bp
   68C9 24 04              2835 	add	a,#0x04
   68CB F8                 2836 	mov	r0,a
                           2837 ;     genCmp
   68CC C3                 2838 	clr	c
   68CD ED                 2839 	mov	a,r5
   68CE 96                 2840 	subb	a,@r0
   68CF EE                 2841 	mov	a,r6
   68D0 64 80              2842 	xrl	a,#0x80
   68D2 08                 2843 	inc	r0
   68D3 86 F0              2844 	mov	b,@r0
   68D5 63 F0 80           2845 	xrl	b,#0x80
   68D8 95 F0              2846 	subb	a,b
                           2847 ;     genIfxJump
                           2848 ;       Peephole 108    removed ljmp by inverse jump logic
   68DA 50 2E              2849 	jnc     00123$
   68DC                    2850 00124$:
                           2851 ;src/rtc.c:303: if (LEAP_YEAR(i)) 
                           2852 ;     genIpush
                           2853 ;     genAnd
   68DC 74 03              2854 	mov	a,#0x03
   68DE 5D                 2855 	anl	a,r5
   68DF FA                 2856 	mov	r2,a
   68E0 7B 00              2857 	mov	r3,#0x00
                           2858 ;     genCmpEq
                           2859 ;       Peephole 241.b  optimized compare
   68E2 E4                 2860 	clr     a
   68E3 BA 00 04           2861 	cjne    r2,#0x00,00125$
   68E6 BB 00 01           2862 	cjne    r3,#0x00,00125$
   68E9 04                 2863 	inc     a
   68EA                    2864 00125$:
   68EA                    2865 00126$:
                           2866 ;     genIpop
                           2867 ;     genIfx
                           2868 ;     genIfxJump
                           2869 ;       Peephole 110    removed ljmp by inverse jump logic
   68EA 60 17              2870 	jz      00109$
   68EC                    2871 00127$:
                           2872 ;src/rtc.c:305: seconds+= DAY;
                           2873 ;     genPlus
   68EC E5 40              2874 	mov	a,_bp
   68EE 24 08              2875 	add	a,#0x08
   68F0 F8                 2876 	mov	r0,a
   68F1 74 80              2877 	mov	a,#0x80
   68F3 26                 2878 	add	a,@r0
   68F4 F6                 2879 	mov	@r0,a
   68F5 74 51              2880 	mov	a,#0x51
   68F7 08                 2881 	inc	r0
   68F8 36                 2882 	addc	a,@r0
   68F9 F6                 2883 	mov	@r0,a
   68FA 74 01              2884 	mov	a,#0x01
   68FC 08                 2885 	inc	r0
   68FD 36                 2886 	addc	a,@r0
   68FE F6                 2887 	mov	@r0,a
                           2888 ;       Peephole 181    changed mov to clr
   68FF E4                 2889 	clr     a
   6900 08                 2890 	inc	r0
   6901 36                 2891 	addc	a,@r0
   6902 F6                 2892 	mov	@r0,a
   6903                    2893 00109$:
                           2894 ;src/rtc.c:301: for (i=1970; i<year; i++) 
                           2895 ;     genPlus
                           2896 ;     genPlusIncr
   6903 0D                 2897 	inc	r5
                           2898 ;src/rtc.c:310: for (i=0; i<month; i++) 
                           2899 ;       Peephole 112.b  changed ljmp to sjmp
                           2900 ;       Peephole 243    avoided branch to sjmp
   6904 BD 00 C0           2901 	cjne    r5,#0x00,00107$
   6907 0E                 2902 	inc     r6
   6908                    2903 00128$:
   6908 80 BD              2904 	sjmp    00107$      
   690A                    2905 00123$:
                           2906 ;     genAnd
   690A E5 40              2907 	mov	a,_bp
   690C 24 04              2908 	add	a,#0x04
   690E F8                 2909 	mov	r0,a
   690F 74 03              2910 	mov	a,#0x03
   6911 56                 2911 	anl	a,@r0
   6912 FD                 2912 	mov	r5,a
   6913 7E 00              2913 	mov	r6,#0x00
                           2914 ;     genCmpEq
                           2915 ;       Peephole 241.b  optimized compare
   6915 E4                 2916 	clr     a
   6916 BD 00 04           2917 	cjne    r5,#0x00,00129$
   6919 BE 00 01           2918 	cjne    r6,#0x00,00129$
   691C 04                 2919 	inc     a
   691D                    2920 00129$:
   691D                    2921 00130$:
   691D FD                 2922 	mov	r5,a
                           2923 ;     genAssign
   691E 7E 00              2924 	mov	r6,#0x00
   6920 7A 00              2925 	mov	r2,#0x00
   6922                    2926 00111$:
                           2927 ;     genCast
   6922 E5 40              2928 	mov	a,_bp
   6924 24 06              2929 	add	a,#0x06
   6926 F8                 2930 	mov	r0,a
   6927 86 03              2931 	mov	ar3,@r0
   6929 E6                 2932 	mov	a,@r0
   692A 33                 2933 	rlc	a
   692B 95 E0              2934 	subb	a,acc
   692D FC                 2935 	mov	r4,a
                           2936 ;     genCmpLt
                           2937 ;     genCmp
   692E C3                 2938 	clr	c
   692F EE                 2939 	mov	a,r6
   6930 9B                 2940 	subb	a,r3
   6931 EA                 2941 	mov	a,r2
   6932 64 80              2942 	xrl	a,#0x80
   6934 8C F0              2943 	mov	b,r4
   6936 63 F0 80           2944 	xrl	b,#0x80
   6939 95 F0              2945 	subb	a,b
                           2946 ;     genIfxJump
   693B 40 03              2947 	jc	00131$
   693D 02 69 BA           2948 	ljmp	00114$
   6940                    2949 00131$:
                           2950 ;src/rtc.c:312: if (i==1 && LEAP_YEAR(year)) 
                           2951 ;     genCmpEq
                           2952 ;       Peephole 112.b  changed ljmp to sjmp
                           2953 ;       Peephole 198    optimized misc jump sequence
   6940 BE 01 1F           2954 	cjne    r6,#0x01,00104$
   6943 BA 00 1C           2955 	cjne    r2,#0x00,00104$
                           2956 ;00132$:
                           2957 ;       Peephole 200    removed redundant sjmp
   6946                    2958 00133$:
                           2959 ;     genIfx
   6946 ED                 2960 	mov	a,r5
                           2961 ;     genIfxJump
                           2962 ;       Peephole 110    removed ljmp by inverse jump logic
   6947 60 19              2963 	jz      00104$
   6949                    2964 00134$:
                           2965 ;src/rtc.c:314: seconds+= DAY*29;
                           2966 ;     genPlus
   6949 E5 40              2967 	mov	a,_bp
   694B 24 08              2968 	add	a,#0x08
   694D F8                 2969 	mov	r0,a
   694E 74 80              2970 	mov	a,#0x80
   6950 26                 2971 	add	a,@r0
   6951 F6                 2972 	mov	@r0,a
   6952 74 3B              2973 	mov	a,#0x3B
   6954 08                 2974 	inc	r0
   6955 36                 2975 	addc	a,@r0
   6956 F6                 2976 	mov	@r0,a
   6957 74 26              2977 	mov	a,#0x26
   6959 08                 2978 	inc	r0
   695A 36                 2979 	addc	a,@r0
   695B F6                 2980 	mov	@r0,a
                           2981 ;       Peephole 181    changed mov to clr
   695C E4                 2982 	clr     a
   695D 08                 2983 	inc	r0
   695E 36                 2984 	addc	a,@r0
   695F F6                 2985 	mov	@r0,a
                           2986 ;       Peephole 112.b  changed ljmp to sjmp
   6960 80 50              2987 	sjmp    00113$
   6962                    2988 00104$:
                           2989 ;src/rtc.c:318: seconds+= DAY*monthDays[i];
                           2990 ;     genIpush
   6962 C0 05              2991 	push	ar5
                           2992 ;     genPlus
                           2993 ;       Peephole 236.g  used r6 instead of ar6
   6964 EE                 2994 	mov     a,r6
   6965 24 62              2995 	add	a,#_monthDays
   6967 F5 82              2996 	mov	dpl,a
                           2997 ;       Peephole 236.g  used r2 instead of ar2
   6969 EA                 2998 	mov     a,r2
   696A 34 6E              2999 	addc	a,#(_monthDays >> 8)
   696C F5 83              3000 	mov	dph,a
                           3001 ;     genPointerGet
                           3002 ;     genCodePointerGet
                           3003 ;       Peephole 181    changed mov to clr
   696E E4                 3004 	clr     a
   696F 93                 3005 	movc	a,@a+dptr
                           3006 ;     genCast
                           3007 ;       Peephole 105    removed redundant mov
   6970 FB                 3008 	mov     r3,a
   6971 33                 3009 	rlc	a
   6972 95 E0              3010 	subb	a,acc
   6974 FC                 3011 	mov	r4,a
   6975 FF                 3012 	mov	r7,a
   6976 FD                 3013 	mov	r5,a
                           3014 ;     genAssign
   6977 75 42 80           3015 	mov	__mullong_PARM_2,#0x80
   697A 75 43 51           3016 	mov	(__mullong_PARM_2 + 1),#0x51
   697D 75 44 01           3017 	mov	(__mullong_PARM_2 + 2),#0x01
   6980 75 45 00           3018 	mov	(__mullong_PARM_2 + 3),#0x00
                           3019 ;     genCall
   6983 8B 82              3020 	mov	dpl,r3
   6985 8C 83              3021 	mov	dph,r4
   6987 8F F0              3022 	mov	b,r7
   6989 ED                 3023 	mov	a,r5
   698A C0 02              3024 	push	ar2
   698C C0 06              3025 	push	ar6
   698E 12 70 BF           3026 	lcall	__mullong
   6991 AB 82              3027 	mov	r3,dpl
   6993 AC 83              3028 	mov	r4,dph
   6995 AD F0              3029 	mov	r5,b
   6997 FF                 3030 	mov	r7,a
   6998 D0 06              3031 	pop	ar6
   699A D0 02              3032 	pop	ar2
                           3033 ;     genPlus
   699C E5 40              3034 	mov	a,_bp
   699E 24 08              3035 	add	a,#0x08
   69A0 F8                 3036 	mov	r0,a
                           3037 ;       Peephole 236.g  used r3 instead of ar3
   69A1 EB                 3038 	mov     a,r3
   69A2 26                 3039 	add	a,@r0
   69A3 F6                 3040 	mov	@r0,a
                           3041 ;       Peephole 236.g  used r4 instead of ar4
   69A4 EC                 3042 	mov     a,r4
   69A5 08                 3043 	inc	r0
   69A6 36                 3044 	addc	a,@r0
   69A7 F6                 3045 	mov	@r0,a
                           3046 ;       Peephole 236.g  used r5 instead of ar5
   69A8 ED                 3047 	mov     a,r5
   69A9 08                 3048 	inc	r0
   69AA 36                 3049 	addc	a,@r0
   69AB F6                 3050 	mov	@r0,a
                           3051 ;       Peephole 236.g  used r7 instead of ar7
   69AC EF                 3052 	mov     a,r7
   69AD 08                 3053 	inc	r0
   69AE 36                 3054 	addc	a,@r0
   69AF F6                 3055 	mov	@r0,a
                           3056 ;src/rtc.c:323: return seconds;
                           3057 ;     genIpop
   69B0 D0 05              3058 	pop	ar5
                           3059 ;src/rtc.c:318: seconds+= DAY*monthDays[i];
   69B2                    3060 00113$:
                           3061 ;src/rtc.c:310: for (i=0; i<month; i++) 
                           3062 ;     genPlus
                           3063 ;     genPlusIncr
   69B2 0E                 3064 	inc	r6
   69B3 BE 00 01           3065 	cjne	r6,#0x00,00135$
   69B6 0A                 3066 	inc	r2
   69B7                    3067 00135$:
   69B7 02 69 22           3068 	ljmp	00111$
   69BA                    3069 00114$:
                           3070 ;src/rtc.c:322: seconds+= mday*DAY;
                           3071 ;     genCast
   69BA E5 40              3072 	mov	a,_bp
   69BC 24 07              3073 	add	a,#0x07
   69BE F8                 3074 	mov	r0,a
   69BF 86 02              3075 	mov	ar2,@r0
   69C1 E6                 3076 	mov	a,@r0
   69C2 33                 3077 	rlc	a
   69C3 95 E0              3078 	subb	a,acc
   69C5 FB                 3079 	mov	r3,a
   69C6 FC                 3080 	mov	r4,a
   69C7 FD                 3081 	mov	r5,a
                           3082 ;     genAssign
   69C8 75 42 80           3083 	mov	__mullong_PARM_2,#0x80
   69CB 75 43 51           3084 	mov	(__mullong_PARM_2 + 1),#0x51
   69CE 75 44 01           3085 	mov	(__mullong_PARM_2 + 2),#0x01
   69D1 75 45 00           3086 	mov	(__mullong_PARM_2 + 3),#0x00
                           3087 ;     genCall
   69D4 8A 82              3088 	mov	dpl,r2
   69D6 8B 83              3089 	mov	dph,r3
   69D8 8C F0              3090 	mov	b,r4
   69DA ED                 3091 	mov	a,r5
   69DB 12 70 BF           3092 	lcall	__mullong
   69DE AA 82              3093 	mov	r2,dpl
   69E0 AB 83              3094 	mov	r3,dph
   69E2 AC F0              3095 	mov	r4,b
   69E4 FD                 3096 	mov	r5,a
                           3097 ;     genPlus
   69E5 E5 40              3098 	mov	a,_bp
   69E7 24 08              3099 	add	a,#0x08
   69E9 F8                 3100 	mov	r0,a
                           3101 ;       Peephole 236.g  used r2 instead of ar2
   69EA EA                 3102 	mov     a,r2
   69EB 26                 3103 	add	a,@r0
   69EC F6                 3104 	mov	@r0,a
                           3105 ;       Peephole 236.g  used r3 instead of ar3
   69ED EB                 3106 	mov     a,r3
   69EE 08                 3107 	inc	r0
   69EF 36                 3108 	addc	a,@r0
   69F0 F6                 3109 	mov	@r0,a
                           3110 ;       Peephole 236.g  used r4 instead of ar4
   69F1 EC                 3111 	mov     a,r4
   69F2 08                 3112 	inc	r0
   69F3 36                 3113 	addc	a,@r0
   69F4 F6                 3114 	mov	@r0,a
                           3115 ;       Peephole 236.g  used r5 instead of ar5
   69F5 ED                 3116 	mov     a,r5
   69F6 08                 3117 	inc	r0
   69F7 36                 3118 	addc	a,@r0
   69F8 F6                 3119 	mov	@r0,a
                           3120 ;src/rtc.c:323: return seconds;
                           3121 ;     genRet
   69F9 E5 40              3122 	mov	a,_bp
   69FB 24 08              3123 	add	a,#0x08
   69FD F8                 3124 	mov	r0,a
   69FE 86 82              3125 	mov	dpl,@r0
   6A00 08                 3126 	inc	r0
   6A01 86 83              3127 	mov	dph,@r0
   6A03 08                 3128 	inc	r0
   6A04 86 F0              3129 	mov	b,@r0
   6A06 08                 3130 	inc	r0
   6A07 E6                 3131 	mov	a,@r0
   6A08                    3132 00115$:
   6A08 85 40 81           3133 	mov	sp,_bp
   6A0B D0 40              3134 	pop	_bp
   6A0D 22                 3135 	ret
                           3136 ;------------------------------------------------------------
                           3137 ;Allocation info for local variables in function 'printf_asctime'
                           3138 ;------------------------------------------------------------
                           3139 ;timeptr                   Allocated to stack - offset 1
                           3140 ;sloc0                     Allocated to stack - offset 4
                           3141 ;sloc1                     Allocated to stack - offset 4
                           3142 ;sloc2                     Allocated to stack - offset 6
                           3143 ;sloc3                     Allocated to stack - offset 12
                           3144 ;------------------------------------------------------------
                           3145 ;src/rtc.c:327: void printf_asctime(struct tm *timeptr) 
                           3146 ;	-----------------------------------------
                           3147 ;	 function printf_asctime
                           3148 ;	-----------------------------------------
   6A0E                    3149 _printf_asctime:
   6A0E C0 40              3150 	push	_bp
   6A10 85 81 40           3151 	mov	_bp,sp
   6A13 E5 81              3152 	mov	a,sp
   6A15 24 08              3153 	add	a,#0x08
   6A17 F5 81              3154 	mov	sp,a
                           3155 ;     genReceive
   6A19 C0 E0              3156 	push	acc
                           3157 ;       Peephole 212    reduced add sequence to inc
   6A1B A8 40              3158 	mov     r0,_bp
   6A1D 08                 3159 	inc     r0
   6A1E D0 E0              3160 	pop	acc
   6A20 A6 82              3161 	mov	@r0,dpl
   6A22 08                 3162 	inc	r0
   6A23 A6 83              3163 	mov	@r0,dph
   6A25 08                 3164 	inc	r0
   6A26 A6 F0              3165 	mov	@r0,b
                           3166 ;src/rtc.c:329: check_time(timeptr);
                           3167 ;     genCall
                           3168 ;       Peephole 212    reduced add sequence to inc
   6A28 A8 40              3169 	mov     r0,_bp
   6A2A 08                 3170 	inc     r0
   6A2B 86 82              3171 	mov	dpl,@r0
   6A2D 08                 3172 	inc	r0
   6A2E 86 83              3173 	mov	dph,@r0
   6A30 08                 3174 	inc	r0
   6A31 86 F0              3175 	mov	b,@r0
   6A33 12 63 CB           3176 	lcall	_check_time
                           3177 ;src/rtc.c:330: printf_fast("%04u ",(unsigned int)timeptr->tm_year+2000);
                           3178 ;     genPlus
                           3179 ;       Peephole 212    reduced add sequence to inc
   6A36 A8 40              3180 	mov     r0,_bp
   6A38 08                 3181 	inc     r0
   6A39 74 05              3182 	mov	a,#0x05
   6A3B 26                 3183 	add	a,@r0
   6A3C FD                 3184 	mov	r5,a
                           3185 ;       Peephole 181    changed mov to clr
   6A3D E4                 3186 	clr     a
   6A3E 08                 3187 	inc	r0
   6A3F 36                 3188 	addc	a,@r0
   6A40 FE                 3189 	mov	r6,a
   6A41 08                 3190 	inc	r0
   6A42 86 07              3191 	mov	ar7,@r0
                           3192 ;     genPointerGet
                           3193 ;     genGenPointerGet
   6A44 8D 82              3194 	mov	dpl,r5
   6A46 8E 83              3195 	mov	dph,r6
   6A48 8F F0              3196 	mov	b,r7
   6A4A 12 71 F5           3197 	lcall	__gptrget
   6A4D FD                 3198 	mov	r5,a
   6A4E A3                 3199 	inc	dptr
   6A4F 12 71 F5           3200 	lcall	__gptrget
   6A52 FE                 3201 	mov	r6,a
                           3202 ;     genPlus
   6A53 74 D0              3203 	mov	a,#0xD0
                           3204 ;       Peephole 236.a  used r5 instead of ar5
   6A55 2D                 3205 	add     a,r5
   6A56 FD                 3206 	mov	r5,a
   6A57 74 07              3207 	mov	a,#0x07
                           3208 ;       Peephole 236.b  used r6 instead of ar6
   6A59 3E                 3209 	addc    a,r6
   6A5A FE                 3210 	mov	r6,a
                           3211 ;     genIpush
   6A5B C0 05              3212 	push	ar5
   6A5D C0 06              3213 	push	ar6
                           3214 ;     genIpush
   6A5F 74 6E              3215 	mov	a,#__str_0
   6A61 C0 E0              3216 	push	acc
   6A63 74 6E              3217 	mov	a,#(__str_0 >> 8)
   6A65 C0 E0              3218 	push	acc
                           3219 ;     genCall
   6A67 12 72 21           3220 	lcall	_printf_fast
   6A6A E5 81              3221 	mov	a,sp
   6A6C 24 FC              3222 	add	a,#0xfc
   6A6E F5 81              3223 	mov	sp,a
                           3224 ;src/rtc.c:331: printf_fast((char code*)month[bcd2bin(timeptr->tm_mon)]);
                           3225 ;     genPlus
                           3226 ;       Peephole 212    reduced add sequence to inc
   6A70 A8 40              3227 	mov     r0,_bp
   6A72 08                 3228 	inc     r0
                           3229 ;     genPlusIncr
   6A73 74 04              3230 	mov	a,#0x04
   6A75 26                 3231 	add	a,@r0
   6A76 FD                 3232 	mov	r5,a
                           3233 ;       Peephole 181    changed mov to clr
   6A77 E4                 3234 	clr     a
   6A78 08                 3235 	inc	r0
   6A79 36                 3236 	addc	a,@r0
   6A7A FE                 3237 	mov	r6,a
   6A7B 08                 3238 	inc	r0
   6A7C 86 07              3239 	mov	ar7,@r0
                           3240 ;     genPointerGet
                           3241 ;     genGenPointerGet
   6A7E 8D 82              3242 	mov	dpl,r5
   6A80 8E 83              3243 	mov	dph,r6
   6A82 8F F0              3244 	mov	b,r7
   6A84 12 71 F5           3245 	lcall	__gptrget
                           3246 ;     genCall
                           3247 ;       Peephole 244.c  loading dpl from a instead of r5
   6A87 FD                 3248 	mov	r5,a
   6A88 F5 82              3249 	mov	dpl,a
   6A8A 12 63 AC           3250 	lcall	_bcd2bin
   6A8D E5 82              3251 	mov	a,dpl
                           3252 ;     genMult
                           3253 ;     genMultOneByte
                           3254 ;     genPlus
                           3255 ;     genPointerGet
                           3256 ;     genCodePointerGet
                           3257 ;       Peephole 181    changed mov to clr
                           3258 ;       Peephole 186.e  optimized movc sequence (b, dptr differ)
   6A8F 25 E0              3259 	add	a,acc
   6A91 F5 F0              3260 	mov     b,a
   6A93 90 6E 2A           3261 	mov	dptr,#_month
   6A96 50 02              3262 	jnc	.+3
   6A98 05 83              3263 	inc	dph
   6A9A 93                 3264 	movc    a,@a+dptr
   6A9B FD                 3265 	mov     r5,a
   6A9C E5 F0              3266 	mov     a,b
   6A9E 04                 3267 	inc	a
   6A9F 93                 3268 	movc    a,@a+dptr
   6AA0 FE                 3269 	mov	r6,a
                           3270 ;     genIpush
   6AA1 C0 05              3271 	push	ar5
   6AA3 C0 06              3272 	push	ar6
                           3273 ;     genCall
   6AA5 12 72 21           3274 	lcall	_printf_fast
   6AA8 15 81              3275 	dec	sp
   6AAA 15 81              3276 	dec	sp
                           3277 ;src/rtc.c:336: (unsigned int)timeptr->tm_sec);
                           3278 ;     genPointerGet
                           3279 ;     genGenPointerGet
                           3280 ;       Peephole 212    reduced add sequence to inc
   6AAC A8 40              3281 	mov     r0,_bp
   6AAE 08                 3282 	inc     r0
   6AAF 86 82              3283 	mov	dpl,@r0
   6AB1 08                 3284 	inc	r0
   6AB2 86 83              3285 	mov	dph,@r0
   6AB4 08                 3286 	inc	r0
   6AB5 86 F0              3287 	mov	b,@r0
   6AB7 12 71 F5           3288 	lcall	__gptrget
   6ABA FD                 3289 	mov	r5,a
                           3290 ;     genCast
   6ABB 8D 02              3291 	mov	ar2,r5
   6ABD 7B 00              3292 	mov	r3,#0x00
                           3293 ;src/rtc.c:335: (unsigned int)timeptr->tm_min, 
                           3294 ;     genPlus
                           3295 ;       Peephole 212    reduced add sequence to inc
   6ABF A8 40              3296 	mov     r0,_bp
   6AC1 08                 3297 	inc     r0
                           3298 ;     genPlusIncr
   6AC2 74 01              3299 	mov	a,#0x01
   6AC4 26                 3300 	add	a,@r0
   6AC5 FC                 3301 	mov	r4,a
                           3302 ;       Peephole 181    changed mov to clr
   6AC6 E4                 3303 	clr     a
   6AC7 08                 3304 	inc	r0
   6AC8 36                 3305 	addc	a,@r0
   6AC9 FD                 3306 	mov	r5,a
   6ACA 08                 3307 	inc	r0
   6ACB 86 06              3308 	mov	ar6,@r0
                           3309 ;     genPointerGet
                           3310 ;     genGenPointerGet
   6ACD 8C 82              3311 	mov	dpl,r4
   6ACF 8D 83              3312 	mov	dph,r5
   6AD1 8E F0              3313 	mov	b,r6
   6AD3 12 71 F5           3314 	lcall	__gptrget
   6AD6 FF                 3315 	mov	r7,a
                           3316 ;     genCast
   6AD7 E5 40              3317 	mov	a,_bp
   6AD9 24 04              3318 	add	a,#0x04
   6ADB F8                 3319 	mov	r0,a
   6ADC A6 07              3320 	mov	@r0,ar7
   6ADE 08                 3321 	inc	r0
   6ADF 76 00              3322 	mov	@r0,#0x00
                           3323 ;src/rtc.c:334: (unsigned int)timeptr->tm_hour, 
                           3324 ;     genPlus
                           3325 ;       Peephole 212    reduced add sequence to inc
   6AE1 A8 40              3326 	mov     r0,_bp
   6AE3 08                 3327 	inc     r0
                           3328 ;     genPlusIncr
   6AE4 74 02              3329 	mov	a,#0x02
   6AE6 26                 3330 	add	a,@r0
   6AE7 FC                 3331 	mov	r4,a
                           3332 ;       Peephole 181    changed mov to clr
   6AE8 E4                 3333 	clr     a
   6AE9 08                 3334 	inc	r0
   6AEA 36                 3335 	addc	a,@r0
   6AEB FD                 3336 	mov	r5,a
   6AEC 08                 3337 	inc	r0
   6AED 86 06              3338 	mov	ar6,@r0
                           3339 ;     genPointerGet
                           3340 ;     genGenPointerGet
   6AEF 8C 82              3341 	mov	dpl,r4
   6AF1 8D 83              3342 	mov	dph,r5
   6AF3 8E F0              3343 	mov	b,r6
   6AF5 12 71 F5           3344 	lcall	__gptrget
   6AF8 FC                 3345 	mov	r4,a
                           3346 ;     genCast
   6AF9 E5 40              3347 	mov	a,_bp
   6AFB 24 06              3348 	add	a,#0x06
   6AFD F8                 3349 	mov	r0,a
   6AFE A6 04              3350 	mov	@r0,ar4
   6B00 08                 3351 	inc	r0
   6B01 76 00              3352 	mov	@r0,#0x00
                           3353 ;src/rtc.c:333: (unsigned int)timeptr->tm_mday, 
                           3354 ;     genPlus
                           3355 ;       Peephole 212    reduced add sequence to inc
   6B03 A8 40              3356 	mov     r0,_bp
   6B05 08                 3357 	inc     r0
                           3358 ;     genPlusIncr
   6B06 74 03              3359 	mov	a,#0x03
   6B08 26                 3360 	add	a,@r0
   6B09 FC                 3361 	mov	r4,a
                           3362 ;       Peephole 181    changed mov to clr
   6B0A E4                 3363 	clr     a
   6B0B 08                 3364 	inc	r0
   6B0C 36                 3365 	addc	a,@r0
   6B0D FF                 3366 	mov	r7,a
   6B0E 08                 3367 	inc	r0
   6B0F 86 05              3368 	mov	ar5,@r0
                           3369 ;     genPointerGet
                           3370 ;     genGenPointerGet
   6B11 8C 82              3371 	mov	dpl,r4
   6B13 8F 83              3372 	mov	dph,r7
   6B15 8D F0              3373 	mov	b,r5
   6B17 12 71 F5           3374 	lcall	__gptrget
   6B1A FC                 3375 	mov	r4,a
                           3376 ;     genCast
   6B1B 7D 00              3377 	mov	r5,#0x00
                           3378 ;src/rtc.c:332: printf_fast("%02u %02u:%02u:%02u", 
                           3379 ;     genIpush
   6B1D C0 02              3380 	push	ar2
   6B1F C0 03              3381 	push	ar3
                           3382 ;     genIpush
   6B21 E5 40              3383 	mov	a,_bp
   6B23 24 04              3384 	add	a,#0x04
   6B25 F8                 3385 	mov	r0,a
   6B26 E6                 3386 	mov	a,@r0
   6B27 C0 E0              3387 	push	acc
   6B29 08                 3388 	inc	r0
   6B2A E6                 3389 	mov	a,@r0
   6B2B C0 E0              3390 	push	acc
                           3391 ;     genIpush
   6B2D E5 40              3392 	mov	a,_bp
   6B2F 24 06              3393 	add	a,#0x06
   6B31 F8                 3394 	mov	r0,a
   6B32 E6                 3395 	mov	a,@r0
   6B33 C0 E0              3396 	push	acc
   6B35 08                 3397 	inc	r0
   6B36 E6                 3398 	mov	a,@r0
   6B37 C0 E0              3399 	push	acc
                           3400 ;     genIpush
   6B39 C0 04              3401 	push	ar4
   6B3B C0 05              3402 	push	ar5
                           3403 ;     genIpush
   6B3D 74 74              3404 	mov	a,#__str_1
   6B3F C0 E0              3405 	push	acc
   6B41 74 6E              3406 	mov	a,#(__str_1 >> 8)
   6B43 C0 E0              3407 	push	acc
                           3408 ;     genCall
   6B45 12 72 21           3409 	lcall	_printf_fast
   6B48 E5 81              3410 	mov	a,sp
   6B4A 24 F6              3411 	add	a,#0xf6
   6B4C F5 81              3412 	mov	sp,a
                           3413 ;src/rtc.c:337: printf_fast("   ");
                           3414 ;     genIpush
   6B4E 74 88              3415 	mov	a,#__str_2
   6B50 C0 E0              3416 	push	acc
   6B52 74 6E              3417 	mov	a,#(__str_2 >> 8)
   6B54 C0 E0              3418 	push	acc
                           3419 ;     genCall
   6B56 12 72 21           3420 	lcall	_printf_fast
   6B59 15 81              3421 	dec	sp
   6B5B 15 81              3422 	dec	sp
                           3423 ;src/rtc.c:338: printf_fast((char code*)day_full[bcd2bin(timeptr->tm_wday)]);
                           3424 ;     genPlus
                           3425 ;       Peephole 212    reduced add sequence to inc
   6B5D A8 40              3426 	mov     r0,_bp
   6B5F 08                 3427 	inc     r0
   6B60 74 07              3428 	mov	a,#0x07
   6B62 26                 3429 	add	a,@r0
   6B63 FC                 3430 	mov	r4,a
                           3431 ;       Peephole 181    changed mov to clr
   6B64 E4                 3432 	clr     a
   6B65 08                 3433 	inc	r0
   6B66 36                 3434 	addc	a,@r0
   6B67 FD                 3435 	mov	r5,a
   6B68 08                 3436 	inc	r0
   6B69 86 06              3437 	mov	ar6,@r0
                           3438 ;     genPointerGet
                           3439 ;     genGenPointerGet
   6B6B 8C 82              3440 	mov	dpl,r4
   6B6D 8D 83              3441 	mov	dph,r5
   6B6F 8E F0              3442 	mov	b,r6
   6B71 12 71 F5           3443 	lcall	__gptrget
                           3444 ;     genCall
                           3445 ;       Peephole 244.c  loading dpl from a instead of r4
   6B74 FC                 3446 	mov	r4,a
   6B75 F5 82              3447 	mov	dpl,a
   6B77 12 63 AC           3448 	lcall	_bcd2bin
   6B7A E5 82              3449 	mov	a,dpl
                           3450 ;     genMult
                           3451 ;     genMultOneByte
                           3452 ;     genPlus
                           3453 ;     genPointerGet
                           3454 ;     genCodePointerGet
                           3455 ;       Peephole 181    changed mov to clr
                           3456 ;       Peephole 186.e  optimized movc sequence (b, dptr differ)
   6B7C 25 E0              3457 	add	a,acc
   6B7E F5 F0              3458 	mov     b,a
   6B80 90 6E 52           3459 	mov	dptr,#_day_full
   6B83 50 02              3460 	jnc	.+3
   6B85 05 83              3461 	inc	dph
   6B87 93                 3462 	movc    a,@a+dptr
   6B88 FC                 3463 	mov     r4,a
   6B89 E5 F0              3464 	mov     a,b
   6B8B 04                 3465 	inc	a
   6B8C 93                 3466 	movc    a,@a+dptr
   6B8D FD                 3467 	mov	r5,a
                           3468 ;     genIpush
   6B8E C0 04              3469 	push	ar4
   6B90 C0 05              3470 	push	ar5
                           3471 ;     genCall
   6B92 12 72 21           3472 	lcall	_printf_fast
   6B95 15 81              3473 	dec	sp
   6B97 15 81              3474 	dec	sp
   6B99                    3475 00101$:
   6B99 85 40 81           3476 	mov	sp,_bp
   6B9C D0 40              3477 	pop	_bp
   6B9E 22                 3478 	ret
                           3479 ;------------------------------------------------------------
                           3480 ;Allocation info for local variables in function 'printf_short_asctime'
                           3481 ;------------------------------------------------------------
                           3482 ;timeptr                   Allocated to registers r2 r3 r4 
                           3483 ;------------------------------------------------------------
                           3484 ;src/rtc.c:342: void printf_short_asctime(struct tm *timeptr) 
                           3485 ;	-----------------------------------------
                           3486 ;	 function printf_short_asctime
                           3487 ;	-----------------------------------------
   6B9F                    3488 _printf_short_asctime:
   6B9F C0 40              3489 	push	_bp
   6BA1 85 81 40           3490 	mov	_bp,sp
                           3491 ;     genReceive
                           3492 ;src/rtc.c:344: check_time(timeptr);
                           3493 ;     genCall
   6BA4 AA 82              3494 	mov     r2,dpl
   6BA6 AB 83              3495 	mov     r3,dph
   6BA8 AC F0              3496 	mov     r4,b
                           3497 ;       Peephole 238.d  removed 3 redundant moves
   6BAA C0 02              3498 	push	ar2
   6BAC C0 03              3499 	push	ar3
   6BAE C0 04              3500 	push	ar4
   6BB0 12 63 CB           3501 	lcall	_check_time
   6BB3 D0 04              3502 	pop	ar4
   6BB5 D0 03              3503 	pop	ar3
   6BB7 D0 02              3504 	pop	ar2
                           3505 ;src/rtc.c:346: printf_fast((char code*)day[bcd2bin(timeptr->tm_wday)]);
                           3506 ;     genPlus
   6BB9 74 07              3507 	mov	a,#0x07
                           3508 ;       Peephole 236.a  used r2 instead of ar2
   6BBB 2A                 3509 	add     a,r2
   6BBC FD                 3510 	mov	r5,a
                           3511 ;       Peephole 181    changed mov to clr
   6BBD E4                 3512 	clr     a
                           3513 ;       Peephole 236.b  used r3 instead of ar3
   6BBE 3B                 3514 	addc    a,r3
   6BBF FE                 3515 	mov	r6,a
   6BC0 8C 07              3516 	mov	ar7,r4
                           3517 ;     genPointerGet
                           3518 ;     genGenPointerGet
   6BC2 8D 82              3519 	mov	dpl,r5
   6BC4 8E 83              3520 	mov	dph,r6
   6BC6 8F F0              3521 	mov	b,r7
   6BC8 12 71 F5           3522 	lcall	__gptrget
                           3523 ;     genCall
                           3524 ;       Peephole 244.c  loading dpl from a instead of r5
   6BCB FD                 3525 	mov	r5,a
   6BCC F5 82              3526 	mov	dpl,a
   6BCE C0 02              3527 	push	ar2
   6BD0 C0 03              3528 	push	ar3
   6BD2 C0 04              3529 	push	ar4
   6BD4 12 63 AC           3530 	lcall	_bcd2bin
   6BD7 E5 82              3531 	mov	a,dpl
   6BD9 D0 04              3532 	pop	ar4
   6BDB D0 03              3533 	pop	ar3
   6BDD D0 02              3534 	pop	ar2
                           3535 ;     genMult
                           3536 ;     genMultOneByte
                           3537 ;     genPlus
                           3538 ;     genPointerGet
                           3539 ;     genCodePointerGet
                           3540 ;       Peephole 181    changed mov to clr
                           3541 ;       Peephole 186.e  optimized movc sequence (b, dptr differ)
   6BDF 25 E0              3542 	add	a,acc
   6BE1 F5 F0              3543 	mov     b,a
   6BE3 90 6E 42           3544 	mov	dptr,#_day
   6BE6 50 02              3545 	jnc	.+3
   6BE8 05 83              3546 	inc	dph
   6BEA 93                 3547 	movc    a,@a+dptr
   6BEB FD                 3548 	mov     r5,a
   6BEC E5 F0              3549 	mov     a,b
   6BEE 04                 3550 	inc	a
   6BEF 93                 3551 	movc    a,@a+dptr
   6BF0 FE                 3552 	mov	r6,a
                           3553 ;     genIpush
   6BF1 C0 02              3554 	push	ar2
   6BF3 C0 03              3555 	push	ar3
   6BF5 C0 04              3556 	push	ar4
   6BF7 C0 05              3557 	push	ar5
   6BF9 C0 06              3558 	push	ar6
                           3559 ;     genCall
   6BFB 12 72 21           3560 	lcall	_printf_fast
   6BFE 15 81              3561 	dec	sp
   6C00 15 81              3562 	dec	sp
   6C02 D0 04              3563 	pop	ar4
   6C04 D0 03              3564 	pop	ar3
   6C06 D0 02              3565 	pop	ar2
                           3566 ;src/rtc.c:350: (unsigned int)timeptr->tm_min);
                           3567 ;     genPlus
                           3568 ;     genPlusIncr
   6C08 74 01              3569 	mov	a,#0x01
                           3570 ;       Peephole 236.a  used r2 instead of ar2
   6C0A 2A                 3571 	add     a,r2
   6C0B FD                 3572 	mov	r5,a
                           3573 ;       Peephole 181    changed mov to clr
   6C0C E4                 3574 	clr     a
                           3575 ;       Peephole 236.b  used r3 instead of ar3
   6C0D 3B                 3576 	addc    a,r3
   6C0E FE                 3577 	mov	r6,a
   6C0F 8C 07              3578 	mov	ar7,r4
                           3579 ;     genPointerGet
                           3580 ;     genGenPointerGet
   6C11 8D 82              3581 	mov	dpl,r5
   6C13 8E 83              3582 	mov	dph,r6
   6C15 8F F0              3583 	mov	b,r7
   6C17 12 71 F5           3584 	lcall	__gptrget
   6C1A FD                 3585 	mov	r5,a
                           3586 ;     genCast
   6C1B 7E 00              3587 	mov	r6,#0x00
                           3588 ;src/rtc.c:349: (unsigned int)timeptr->tm_hour, 
                           3589 ;     genPlus
                           3590 ;     genPlusIncr
   6C1D 74 02              3591 	mov	a,#0x02
                           3592 ;       Peephole 236.a  used r2 instead of ar2
   6C1F 2A                 3593 	add     a,r2
   6C20 FF                 3594 	mov	r7,a
                           3595 ;       Peephole 181    changed mov to clr
   6C21 E4                 3596 	clr     a
                           3597 ;       Peephole 236.b  used r3 instead of ar3
   6C22 3B                 3598 	addc    a,r3
   6C23 F8                 3599 	mov	r0,a
   6C24 8C 01              3600 	mov	ar1,r4
                           3601 ;     genPointerGet
                           3602 ;     genGenPointerGet
   6C26 8F 82              3603 	mov	dpl,r7
   6C28 88 83              3604 	mov	dph,r0
   6C2A 89 F0              3605 	mov	b,r1
   6C2C 12 71 F5           3606 	lcall	__gptrget
   6C2F FF                 3607 	mov	r7,a
                           3608 ;     genCast
   6C30 78 00              3609 	mov	r0,#0x00
                           3610 ;src/rtc.c:348: (unsigned int)timeptr->tm_mday, 
                           3611 ;     genPlus
                           3612 ;     genPlusIncr
   6C32 74 03              3613 	mov	a,#0x03
                           3614 ;       Peephole 236.a  used r2 instead of ar2
   6C34 2A                 3615 	add     a,r2
   6C35 FA                 3616 	mov	r2,a
                           3617 ;       Peephole 181    changed mov to clr
   6C36 E4                 3618 	clr     a
                           3619 ;       Peephole 236.b  used r3 instead of ar3
   6C37 3B                 3620 	addc    a,r3
   6C38 FB                 3621 	mov	r3,a
                           3622 ;     genPointerGet
                           3623 ;     genGenPointerGet
   6C39 8A 82              3624 	mov	dpl,r2
   6C3B 8B 83              3625 	mov	dph,r3
   6C3D 8C F0              3626 	mov	b,r4
   6C3F 12 71 F5           3627 	lcall	__gptrget
   6C42 FA                 3628 	mov	r2,a
                           3629 ;     genCast
   6C43 7B 00              3630 	mov	r3,#0x00
                           3631 ;src/rtc.c:347: printf_fast("%02u %02u:%02u", 
                           3632 ;     genIpush
   6C45 C0 05              3633 	push	ar5
   6C47 C0 06              3634 	push	ar6
                           3635 ;     genIpush
   6C49 C0 07              3636 	push	ar7
   6C4B C0 00              3637 	push	ar0
                           3638 ;     genIpush
   6C4D C0 02              3639 	push	ar2
   6C4F C0 03              3640 	push	ar3
                           3641 ;     genIpush
   6C51 74 8C              3642 	mov	a,#__str_3
   6C53 C0 E0              3643 	push	acc
   6C55 74 6E              3644 	mov	a,#(__str_3 >> 8)
   6C57 C0 E0              3645 	push	acc
                           3646 ;     genCall
   6C59 12 72 21           3647 	lcall	_printf_fast
   6C5C E5 81              3648 	mov	a,sp
   6C5E 24 F8              3649 	add	a,#0xf8
   6C60 F5 81              3650 	mov	sp,a
   6C62                    3651 00101$:
   6C62 85 40 81           3652 	mov	sp,_bp
   6C65 D0 40              3653 	pop	_bp
   6C67 22                 3654 	ret
                           3655 ;------------------------------------------------------------
                           3656 ;Allocation info for local variables in function 'printf_date'
                           3657 ;------------------------------------------------------------
                           3658 ;timeptr                   Allocated to registers r2 r3 r4 
                           3659 ;------------------------------------------------------------
                           3660 ;src/rtc.c:353: void printf_date(const struct tm *timeptr)
                           3661 ;	-----------------------------------------
                           3662 ;	 function printf_date
                           3663 ;	-----------------------------------------
   6C68                    3664 _printf_date:
   6C68 C0 40              3665 	push	_bp
   6C6A 85 81 40           3666 	mov	_bp,sp
                           3667 ;     genReceive
   6C6D AA 82              3668 	mov	r2,dpl
   6C6F AB 83              3669 	mov	r3,dph
   6C71 AC F0              3670 	mov	r4,b
                           3671 ;src/rtc.c:358: (unsigned int)timeptr->tm_mday);
                           3672 ;     genPlus
                           3673 ;     genPlusIncr
   6C73 74 03              3674 	mov	a,#0x03
                           3675 ;       Peephole 236.a  used r2 instead of ar2
   6C75 2A                 3676 	add     a,r2
   6C76 FD                 3677 	mov	r5,a
                           3678 ;       Peephole 181    changed mov to clr
   6C77 E4                 3679 	clr     a
                           3680 ;       Peephole 236.b  used r3 instead of ar3
   6C78 3B                 3681 	addc    a,r3
   6C79 FE                 3682 	mov	r6,a
   6C7A 8C 07              3683 	mov	ar7,r4
                           3684 ;     genPointerGet
                           3685 ;     genGenPointerGet
   6C7C 8D 82              3686 	mov	dpl,r5
   6C7E 8E 83              3687 	mov	dph,r6
   6C80 8F F0              3688 	mov	b,r7
   6C82 12 71 F5           3689 	lcall	__gptrget
   6C85 FD                 3690 	mov	r5,a
                           3691 ;     genCast
   6C86 7E 00              3692 	mov	r6,#0x00
                           3693 ;src/rtc.c:357: (unsigned int)timeptr->tm_mon,
                           3694 ;     genPlus
                           3695 ;     genPlusIncr
   6C88 74 04              3696 	mov	a,#0x04
                           3697 ;       Peephole 236.a  used r2 instead of ar2
   6C8A 2A                 3698 	add     a,r2
   6C8B FF                 3699 	mov	r7,a
                           3700 ;       Peephole 181    changed mov to clr
   6C8C E4                 3701 	clr     a
                           3702 ;       Peephole 236.b  used r3 instead of ar3
   6C8D 3B                 3703 	addc    a,r3
   6C8E F8                 3704 	mov	r0,a
   6C8F 8C 01              3705 	mov	ar1,r4
                           3706 ;     genPointerGet
                           3707 ;     genGenPointerGet
   6C91 8F 82              3708 	mov	dpl,r7
   6C93 88 83              3709 	mov	dph,r0
   6C95 89 F0              3710 	mov	b,r1
   6C97 12 71 F5           3711 	lcall	__gptrget
   6C9A FF                 3712 	mov	r7,a
                           3713 ;     genCast
   6C9B 78 00              3714 	mov	r0,#0x00
                           3715 ;src/rtc.c:356: (unsigned int)timeptr->tm_year,
                           3716 ;     genPlus
   6C9D 74 05              3717 	mov	a,#0x05
                           3718 ;       Peephole 236.a  used r2 instead of ar2
   6C9F 2A                 3719 	add     a,r2
   6CA0 FA                 3720 	mov	r2,a
                           3721 ;       Peephole 181    changed mov to clr
   6CA1 E4                 3722 	clr     a
                           3723 ;       Peephole 236.b  used r3 instead of ar3
   6CA2 3B                 3724 	addc    a,r3
   6CA3 FB                 3725 	mov	r3,a
                           3726 ;     genPointerGet
                           3727 ;     genGenPointerGet
   6CA4 8A 82              3728 	mov	dpl,r2
   6CA6 8B 83              3729 	mov	dph,r3
   6CA8 8C F0              3730 	mov	b,r4
   6CAA 12 71 F5           3731 	lcall	__gptrget
   6CAD FA                 3732 	mov	r2,a
   6CAE A3                 3733 	inc	dptr
   6CAF 12 71 F5           3734 	lcall	__gptrget
   6CB2 FB                 3735 	mov	r3,a
                           3736 ;src/rtc.c:355: printf_fast("%04u-%02u-%02u", 
                           3737 ;     genIpush
   6CB3 C0 05              3738 	push	ar5
   6CB5 C0 06              3739 	push	ar6
                           3740 ;     genIpush
   6CB7 C0 07              3741 	push	ar7
   6CB9 C0 00              3742 	push	ar0
                           3743 ;     genIpush
   6CBB C0 02              3744 	push	ar2
   6CBD C0 03              3745 	push	ar3
                           3746 ;     genIpush
   6CBF 74 9B              3747 	mov	a,#__str_4
   6CC1 C0 E0              3748 	push	acc
   6CC3 74 6E              3749 	mov	a,#(__str_4 >> 8)
   6CC5 C0 E0              3750 	push	acc
                           3751 ;     genCall
   6CC7 12 72 21           3752 	lcall	_printf_fast
   6CCA E5 81              3753 	mov	a,sp
   6CCC 24 F8              3754 	add	a,#0xf8
   6CCE F5 81              3755 	mov	sp,a
   6CD0                    3756 00101$:
   6CD0 85 40 81           3757 	mov	sp,_bp
   6CD3 D0 40              3758 	pop	_bp
   6CD5 22                 3759 	ret
                           3760 ;------------------------------------------------------------
                           3761 ;Allocation info for local variables in function 'printf_weekday_short'
                           3762 ;------------------------------------------------------------
                           3763 ;timeptr                   Allocated to registers r2 r3 r4 
                           3764 ;------------------------------------------------------------
                           3765 ;src/rtc.c:361: void printf_weekday_short(const struct tm *timeptr)
                           3766 ;	-----------------------------------------
                           3767 ;	 function printf_weekday_short
                           3768 ;	-----------------------------------------
   6CD6                    3769 _printf_weekday_short:
   6CD6 C0 40              3770 	push	_bp
   6CD8 85 81 40           3771 	mov	_bp,sp
                           3772 ;     genReceive
   6CDB AA 82              3773 	mov	r2,dpl
   6CDD AB 83              3774 	mov	r3,dph
   6CDF AC F0              3775 	mov	r4,b
                           3776 ;src/rtc.c:363: printf_fast((char code*)day[bcd2bin(timeptr->tm_wday)]);
                           3777 ;     genPlus
   6CE1 74 07              3778 	mov	a,#0x07
                           3779 ;       Peephole 236.a  used r2 instead of ar2
   6CE3 2A                 3780 	add     a,r2
   6CE4 FA                 3781 	mov	r2,a
                           3782 ;       Peephole 181    changed mov to clr
   6CE5 E4                 3783 	clr     a
                           3784 ;       Peephole 236.b  used r3 instead of ar3
   6CE6 3B                 3785 	addc    a,r3
   6CE7 FB                 3786 	mov	r3,a
                           3787 ;     genPointerGet
                           3788 ;     genGenPointerGet
   6CE8 8A 82              3789 	mov	dpl,r2
   6CEA 8B 83              3790 	mov	dph,r3
   6CEC 8C F0              3791 	mov	b,r4
   6CEE 12 71 F5           3792 	lcall	__gptrget
                           3793 ;     genCall
                           3794 ;       Peephole 244.c  loading dpl from a instead of r2
   6CF1 FA                 3795 	mov	r2,a
   6CF2 F5 82              3796 	mov	dpl,a
   6CF4 12 63 AC           3797 	lcall	_bcd2bin
   6CF7 E5 82              3798 	mov	a,dpl
                           3799 ;     genMult
                           3800 ;     genMultOneByte
                           3801 ;     genPlus
                           3802 ;     genPointerGet
                           3803 ;     genCodePointerGet
                           3804 ;       Peephole 181    changed mov to clr
                           3805 ;       Peephole 186.e  optimized movc sequence (b, dptr differ)
   6CF9 25 E0              3806 	add	a,acc
   6CFB F5 F0              3807 	mov     b,a
   6CFD 90 6E 42           3808 	mov	dptr,#_day
   6D00 50 02              3809 	jnc	.+3
   6D02 05 83              3810 	inc	dph
   6D04 93                 3811 	movc    a,@a+dptr
   6D05 FA                 3812 	mov     r2,a
   6D06 E5 F0              3813 	mov     a,b
   6D08 04                 3814 	inc	a
   6D09 93                 3815 	movc    a,@a+dptr
   6D0A FB                 3816 	mov	r3,a
                           3817 ;     genIpush
   6D0B C0 02              3818 	push	ar2
   6D0D C0 03              3819 	push	ar3
                           3820 ;     genCall
   6D0F 12 72 21           3821 	lcall	_printf_fast
   6D12 15 81              3822 	dec	sp
   6D14 15 81              3823 	dec	sp
   6D16                    3824 00101$:
   6D16 85 40 81           3825 	mov	sp,_bp
   6D19 D0 40              3826 	pop	_bp
   6D1B 22                 3827 	ret
                           3828 ;------------------------------------------------------------
                           3829 ;Allocation info for local variables in function 'printf_day'
                           3830 ;------------------------------------------------------------
                           3831 ;day_number                Allocated to registers 
                           3832 ;------------------------------------------------------------
                           3833 ;src/rtc.c:366: void printf_day(const unsigned char day_number)
                           3834 ;	-----------------------------------------
                           3835 ;	 function printf_day
                           3836 ;	-----------------------------------------
   6D1C                    3837 _printf_day:
   6D1C C0 40              3838 	push	_bp
   6D1E 85 81 40           3839 	mov	_bp,sp
                           3840 ;     genReceive
                           3841 ;src/rtc.c:368: printf_fast((char code*)day[bcd2bin(day_number)]);
                           3842 ;     genCall
   6D21 12 63 AC           3843 	lcall	_bcd2bin
   6D24 E5 82              3844 	mov	a,dpl
                           3845 ;     genMult
                           3846 ;     genMultOneByte
                           3847 ;     genPlus
                           3848 ;     genPointerGet
                           3849 ;     genCodePointerGet
                           3850 ;       Peephole 181    changed mov to clr
                           3851 ;       Peephole 186.e  optimized movc sequence (b, dptr differ)
   6D26 25 E0              3852 	add	a,acc
   6D28 F5 F0              3853 	mov     b,a
   6D2A 90 6E 42           3854 	mov	dptr,#_day
   6D2D 50 02              3855 	jnc	.+3
   6D2F 05 83              3856 	inc	dph
   6D31 93                 3857 	movc    a,@a+dptr
   6D32 FA                 3858 	mov     r2,a
   6D33 E5 F0              3859 	mov     a,b
   6D35 04                 3860 	inc	a
   6D36 93                 3861 	movc    a,@a+dptr
   6D37 FB                 3862 	mov	r3,a
                           3863 ;     genIpush
   6D38 C0 02              3864 	push	ar2
   6D3A C0 03              3865 	push	ar3
                           3866 ;     genCall
   6D3C 12 72 21           3867 	lcall	_printf_fast
   6D3F 15 81              3868 	dec	sp
   6D41 15 81              3869 	dec	sp
   6D43                    3870 00101$:
   6D43 85 40 81           3871 	mov	sp,_bp
   6D46 D0 40              3872 	pop	_bp
   6D48 22                 3873 	ret
                           3874 ;------------------------------------------------------------
                           3875 ;Allocation info for local variables in function 'printf_time'
                           3876 ;------------------------------------------------------------
                           3877 ;timeptr                   Allocated to registers r2 r3 r4 
                           3878 ;------------------------------------------------------------
                           3879 ;src/rtc.c:371: void printf_time(const struct tm *timeptr)
                           3880 ;	-----------------------------------------
                           3881 ;	 function printf_time
                           3882 ;	-----------------------------------------
   6D49                    3883 _printf_time:
   6D49 C0 40              3884 	push	_bp
   6D4B 85 81 40           3885 	mov	_bp,sp
                           3886 ;     genReceive
                           3887 ;src/rtc.c:376: (unsigned int)timeptr->tm_sec);
                           3888 ;     genPointerGet
                           3889 ;     genGenPointerGet
   6D4E AA 82              3890 	mov     r2,dpl
   6D50 AB 83              3891 	mov     r3,dph
   6D52 AC F0              3892 	mov     r4,b
                           3893 ;       Peephole 238.d  removed 3 redundant moves
   6D54 12 71 F5           3894 	lcall	__gptrget
   6D57 FD                 3895 	mov	r5,a
                           3896 ;     genCast
   6D58 7E 00              3897 	mov	r6,#0x00
                           3898 ;src/rtc.c:375: (unsigned int)timeptr->tm_min,
                           3899 ;     genPlus
                           3900 ;     genPlusIncr
   6D5A 74 01              3901 	mov	a,#0x01
                           3902 ;       Peephole 236.a  used r2 instead of ar2
   6D5C 2A                 3903 	add     a,r2
   6D5D FF                 3904 	mov	r7,a
                           3905 ;       Peephole 181    changed mov to clr
   6D5E E4                 3906 	clr     a
                           3907 ;       Peephole 236.b  used r3 instead of ar3
   6D5F 3B                 3908 	addc    a,r3
   6D60 F8                 3909 	mov	r0,a
   6D61 8C 01              3910 	mov	ar1,r4
                           3911 ;     genPointerGet
                           3912 ;     genGenPointerGet
   6D63 8F 82              3913 	mov	dpl,r7
   6D65 88 83              3914 	mov	dph,r0
   6D67 89 F0              3915 	mov	b,r1
   6D69 12 71 F5           3916 	lcall	__gptrget
   6D6C FF                 3917 	mov	r7,a
                           3918 ;     genCast
   6D6D 78 00              3919 	mov	r0,#0x00
                           3920 ;src/rtc.c:374: (unsigned int)timeptr->tm_hour,
                           3921 ;     genPlus
                           3922 ;     genPlusIncr
   6D6F 74 02              3923 	mov	a,#0x02
                           3924 ;       Peephole 236.a  used r2 instead of ar2
   6D71 2A                 3925 	add     a,r2
   6D72 FA                 3926 	mov	r2,a
                           3927 ;       Peephole 181    changed mov to clr
   6D73 E4                 3928 	clr     a
                           3929 ;       Peephole 236.b  used r3 instead of ar3
   6D74 3B                 3930 	addc    a,r3
   6D75 FB                 3931 	mov	r3,a
                           3932 ;     genPointerGet
                           3933 ;     genGenPointerGet
   6D76 8A 82              3934 	mov	dpl,r2
   6D78 8B 83              3935 	mov	dph,r3
   6D7A 8C F0              3936 	mov	b,r4
   6D7C 12 71 F5           3937 	lcall	__gptrget
   6D7F FA                 3938 	mov	r2,a
                           3939 ;     genCast
   6D80 7B 00              3940 	mov	r3,#0x00
                           3941 ;src/rtc.c:373: printf_fast("%02u:%02u:%02u", 
                           3942 ;     genIpush
   6D82 C0 05              3943 	push	ar5
   6D84 C0 06              3944 	push	ar6
                           3945 ;     genIpush
   6D86 C0 07              3946 	push	ar7
   6D88 C0 00              3947 	push	ar0
                           3948 ;     genIpush
   6D8A C0 02              3949 	push	ar2
   6D8C C0 03              3950 	push	ar3
                           3951 ;     genIpush
   6D8E 74 AA              3952 	mov	a,#__str_5
   6D90 C0 E0              3953 	push	acc
   6D92 74 6E              3954 	mov	a,#(__str_5 >> 8)
   6D94 C0 E0              3955 	push	acc
                           3956 ;     genCall
   6D96 12 72 21           3957 	lcall	_printf_fast
   6D99 E5 81              3958 	mov	a,sp
   6D9B 24 F8              3959 	add	a,#0xf8
   6D9D F5 81              3960 	mov	sp,a
   6D9F                    3961 00101$:
   6D9F 85 40 81           3962 	mov	sp,_bp
   6DA2 D0 40              3963 	pop	_bp
   6DA4 22                 3964 	ret
                           3965 ;------------------------------------------------------------
                           3966 ;Allocation info for local variables in function 'ds1302_write_memory'
                           3967 ;------------------------------------------------------------
                           3968 ;number                    Allocated to stack - offset -3
                           3969 ;addr                      Allocated to registers r2 
                           3970 ;address                   Allocated to registers 
                           3971 ;------------------------------------------------------------
                           3972 ;src/rtc.c:407: void ds1302_write_memory(const unsigned char addr, const unsigned char number)
                           3973 ;	-----------------------------------------
                           3974 ;	 function ds1302_write_memory
                           3975 ;	-----------------------------------------
   6DA5                    3976 _ds1302_write_memory:
   6DA5 C0 40              3977 	push	_bp
   6DA7 85 81 40           3978 	mov	_bp,sp
                           3979 ;     genReceive
   6DAA AA 82              3980 	mov	r2,dpl
                           3981 ;src/rtc.c:413: reset_3w();
                           3982 ;     genCall
   6DAC C0 02              3983 	push	ar2
   6DAE 12 5D B4           3984 	lcall	_reset_3w
   6DB1 D0 02              3985 	pop	ar2
                           3986 ;src/rtc.c:414: wbyte_3w(RTC_CTRL);
                           3987 ;     genCall
   6DB3 75 82 8E           3988 	mov	dpl,#0x8E
   6DB6 C0 02              3989 	push	ar2
   6DB8 12 5D C5           3990 	lcall	_wbyte_3w
   6DBB D0 02              3991 	pop	ar2
                           3992 ;src/rtc.c:415: wbyte_3w(0x00);
                           3993 ;     genCall
   6DBD 75 82 00           3994 	mov	dpl,#0x00
   6DC0 C0 02              3995 	push	ar2
   6DC2 12 5D C5           3996 	lcall	_wbyte_3w
   6DC5 D0 02              3997 	pop	ar2
                           3998 ;src/rtc.c:416: reset_3w();
                           3999 ;     genCall
   6DC7 C0 02              4000 	push	ar2
   6DC9 12 5D B4           4001 	lcall	_reset_3w
   6DCC D0 02              4002 	pop	ar2
                           4003 ;src/rtc.c:417: wbyte_3w((address<<1)|0xC0);
                           4004 ;     genLeftShift
                           4005 ;     genLeftShiftLiteral
                           4006 ;     genlshOne
   6DCE EA                 4007 	mov	a,r2
   6DCF 25 E0              4008 	add	a,acc
   6DD1 FA                 4009 	mov	r2,a
                           4010 ;     genOr
   6DD2 74 C0              4011 	mov	a,#0xC0
   6DD4 4A                 4012 	orl	a,r2
   6DD5 F5 82              4013 	mov	dpl,a
                           4014 ;     genCall
   6DD7 12 5D C5           4015 	lcall	_wbyte_3w
                           4016 ;src/rtc.c:418: wbyte_3w(number);
                           4017 ;     genCall
   6DDA E5 40              4018 	mov	a,_bp
   6DDC 24 FD              4019 	add	a,#0xfd
   6DDE F8                 4020 	mov	r0,a
   6DDF 86 82              4021 	mov	dpl,@r0
   6DE1 12 5D C5           4022 	lcall	_wbyte_3w
                           4023 ;src/rtc.c:419: reset_3w();
                           4024 ;     genCall
   6DE4 12 5D B4           4025 	lcall	_reset_3w
                           4026 ;src/rtc.c:420: wbyte_3w(RTC_CTRL);
                           4027 ;     genCall
   6DE7 75 82 8E           4028 	mov	dpl,#0x8E
   6DEA 12 5D C5           4029 	lcall	_wbyte_3w
                           4030 ;src/rtc.c:421: wbyte_3w(0x80);
                           4031 ;     genCall
   6DED 75 82 80           4032 	mov	dpl,#0x80
   6DF0 12 5D C5           4033 	lcall	_wbyte_3w
                           4034 ;src/rtc.c:422: reset_3w();
                           4035 ;     genCall
   6DF3 12 5D B4           4036 	lcall	_reset_3w
   6DF6                    4037 00101$:
   6DF6 85 40 81           4038 	mov	sp,_bp
   6DF9 D0 40              4039 	pop	_bp
   6DFB 22                 4040 	ret
                           4041 ;------------------------------------------------------------
                           4042 ;Allocation info for local variables in function 'ds1302_read_memory'
                           4043 ;------------------------------------------------------------
                           4044 ;addr                      Allocated to registers r2 
                           4045 ;result                    Allocated to registers r2 
                           4046 ;address                   Allocated to registers 
                           4047 ;------------------------------------------------------------
                           4048 ;src/rtc.c:433: unsigned char ds1302_read_memory( const unsigned char addr)
                           4049 ;	-----------------------------------------
                           4050 ;	 function ds1302_read_memory
                           4051 ;	-----------------------------------------
   6DFC                    4052 _ds1302_read_memory:
   6DFC C0 40              4053 	push	_bp
   6DFE 85 81 40           4054 	mov	_bp,sp
                           4055 ;     genReceive
   6E01 AA 82              4056 	mov	r2,dpl
                           4057 ;src/rtc.c:440: reset_3w();
                           4058 ;     genCall
   6E03 C0 02              4059 	push	ar2
   6E05 12 5D B4           4060 	lcall	_reset_3w
   6E08 D0 02              4061 	pop	ar2
                           4062 ;src/rtc.c:441: wbyte_3w((address<<1)|0xC1);
                           4063 ;     genLeftShift
                           4064 ;     genLeftShiftLiteral
                           4065 ;     genlshOne
   6E0A EA                 4066 	mov	a,r2
   6E0B 25 E0              4067 	add	a,acc
   6E0D FA                 4068 	mov	r2,a
                           4069 ;     genOr
   6E0E 74 C1              4070 	mov	a,#0xC1
   6E10 4A                 4071 	orl	a,r2
   6E11 F5 82              4072 	mov	dpl,a
                           4073 ;     genCall
   6E13 12 5D C5           4074 	lcall	_wbyte_3w
                           4075 ;src/rtc.c:442: result = rbyte_3w();
                           4076 ;     genCall
   6E16 12 5D EC           4077 	lcall	_rbyte_3w
   6E19 AA 82              4078 	mov	r2,dpl
                           4079 ;     genAssign
                           4080 ;src/rtc.c:443: reset_3w();
                           4081 ;     genCall
   6E1B C0 02              4082 	push	ar2
   6E1D 12 5D B4           4083 	lcall	_reset_3w
   6E20 D0 02              4084 	pop	ar2
                           4085 ;src/rtc.c:444: return result;
                           4086 ;     genRet
   6E22 8A 82              4087 	mov	dpl,r2
   6E24                    4088 00101$:
   6E24 85 40 81           4089 	mov	sp,_bp
   6E27 D0 40              4090 	pop	_bp
   6E29 22                 4091 	ret
                           4092 	.area CSEG    (CODE)
   6E2A                    4093 _month:
   6E2A B9 6E              4094 	.byte _str_6,(_str_6 >> 8)
   6E2C BE 6E              4095 	.byte _str_7,(_str_7 >> 8)
   6E2E C3 6E              4096 	.byte _str_8,(_str_8 >> 8)
   6E30 C8 6E              4097 	.byte _str_9,(_str_9 >> 8)
   6E32 CD 6E              4098 	.byte _str_10,(_str_10 >> 8)
   6E34 D2 6E              4099 	.byte _str_11,(_str_11 >> 8)
   6E36 D7 6E              4100 	.byte _str_12,(_str_12 >> 8)
   6E38 DC 6E              4101 	.byte _str_13,(_str_13 >> 8)
   6E3A E1 6E              4102 	.byte _str_14,(_str_14 >> 8)
   6E3C E6 6E              4103 	.byte _str_15,(_str_15 >> 8)
   6E3E EB 6E              4104 	.byte _str_16,(_str_16 >> 8)
   6E40 F0 6E              4105 	.byte _str_17,(_str_17 >> 8)
   6E42                    4106 _day:
   6E42 F5 6E              4107 	.byte _str_18,(_str_18 >> 8)
   6E44 F9 6E              4108 	.byte _str_19,(_str_19 >> 8)
   6E46 FE 6E              4109 	.byte _str_20,(_str_20 >> 8)
   6E48 03 6F              4110 	.byte _str_21,(_str_21 >> 8)
   6E4A 08 6F              4111 	.byte _str_22,(_str_22 >> 8)
   6E4C 0D 6F              4112 	.byte _str_23,(_str_23 >> 8)
   6E4E 12 6F              4113 	.byte _str_24,(_str_24 >> 8)
   6E50 17 6F              4114 	.byte _str_25,(_str_25 >> 8)
   6E52                    4115 _day_full:
   6E52 1C 6F              4116 	.byte _str_26,(_str_26 >> 8)
   6E54 29 6F              4117 	.byte _str_27,(_str_27 >> 8)
   6E56 37 6F              4118 	.byte _str_28,(_str_28 >> 8)
   6E58 44 6F              4119 	.byte _str_29,(_str_29 >> 8)
   6E5A 51 6F              4120 	.byte _str_30,(_str_30 >> 8)
   6E5C 5E 6F              4121 	.byte _str_31,(_str_31 >> 8)
   6E5E 6B 6F              4122 	.byte _str_32,(_str_32 >> 8)
   6E60 78 6F              4123 	.byte _str_33,(_str_33 >> 8)
   6E62                    4124 _monthDays:
   6E62 1F                 4125 	.db #0x1F
   6E63 1C                 4126 	.db #0x1C
   6E64 1F                 4127 	.db #0x1F
   6E65 1E                 4128 	.db #0x1E
   6E66 1F                 4129 	.db #0x1F
   6E67 1E                 4130 	.db #0x1E
   6E68 1F                 4131 	.db #0x1F
   6E69 1F                 4132 	.db #0x1F
   6E6A 1E                 4133 	.db #0x1E
   6E6B 1F                 4134 	.db #0x1F
   6E6C 1E                 4135 	.db #0x1E
   6E6D 1F                 4136 	.db #0x1F
   6E6E                    4137 __str_0:
   6E6E 25 30 34 75 20     4138 	.ascii "%04u "
   6E73 00                 4139 	.db 0x00
   6E74                    4140 __str_1:
   6E74 25 30 32 75 20 25  4141 	.ascii "%02u %02u:%02u:%02u"
        30 32 75 3A 25 30
        32 75 3A 25 30 32
        75
   6E87 00                 4142 	.db 0x00
   6E88                    4143 __str_2:
   6E88 20 20 20           4144 	.ascii "   "
   6E8B 00                 4145 	.db 0x00
   6E8C                    4146 __str_3:
   6E8C 25 30 32 75 20 25  4147 	.ascii "%02u %02u:%02u"
        30 32 75 3A 25 30
        32 75
   6E9A 00                 4148 	.db 0x00
   6E9B                    4149 __str_4:
   6E9B 25 30 34 75 2D 25  4150 	.ascii "%04u-%02u-%02u"
        30 32 75 2D 25 30
        32 75
   6EA9 00                 4151 	.db 0x00
   6EAA                    4152 __str_5:
   6EAA 25 30 32 75 3A 25  4153 	.ascii "%02u:%02u:%02u"
        30 32 75 3A 25 30
        32 75
   6EB8 00                 4154 	.db 0x00
   6EB9                    4155 _str_6:
   6EB9 53 74 79 20        4156 	.ascii "Sty "
   6EBD 00                 4157 	.db 0x00
   6EBE                    4158 _str_7:
   6EBE 4C 75 74 20        4159 	.ascii "Lut "
   6EC2 00                 4160 	.db 0x00
   6EC3                    4161 _str_8:
   6EC3 4D 61 72 20        4162 	.ascii "Mar "
   6EC7 00                 4163 	.db 0x00
   6EC8                    4164 _str_9:
   6EC8 4B 77 69 20        4165 	.ascii "Kwi "
   6ECC 00                 4166 	.db 0x00
   6ECD                    4167 _str_10:
   6ECD 4D 61 6A 20        4168 	.ascii "Maj "
   6ED1 00                 4169 	.db 0x00
   6ED2                    4170 _str_11:
   6ED2 43 7A 65 20        4171 	.ascii "Cze "
   6ED6 00                 4172 	.db 0x00
   6ED7                    4173 _str_12:
   6ED7 4C 69 70 20        4174 	.ascii "Lip "
   6EDB 00                 4175 	.db 0x00
   6EDC                    4176 _str_13:
   6EDC 53 69 65 20        4177 	.ascii "Sie "
   6EE0 00                 4178 	.db 0x00
   6EE1                    4179 _str_14:
   6EE1 57 72 7A 20        4180 	.ascii "Wrz "
   6EE5 00                 4181 	.db 0x00
   6EE6                    4182 _str_15:
   6EE6 50 61 7A 20        4183 	.ascii "Paz "
   6EEA 00                 4184 	.db 0x00
   6EEB                    4185 _str_16:
   6EEB 4C 69 73 20        4186 	.ascii "Lis "
   6EEF 00                 4187 	.db 0x00
   6EF0                    4188 _str_17:
   6EF0 47 72 75 20        4189 	.ascii "Gru "
   6EF4 00                 4190 	.db 0x00
   6EF5                    4191 _str_18:
   6EF5 45 72 72           4192 	.ascii "Err"
   6EF8 00                 4193 	.db 0x00
   6EF9                    4194 _str_19:
   6EF9 50 6F 6E 20        4195 	.ascii "Pon "
   6EFD 00                 4196 	.db 0x00
   6EFE                    4197 _str_20:
   6EFE 57 74 6F 20        4198 	.ascii "Wto "
   6F02 00                 4199 	.db 0x00
   6F03                    4200 _str_21:
   6F03 53 72 6F 20        4201 	.ascii "Sro "
   6F07 00                 4202 	.db 0x00
   6F08                    4203 _str_22:
   6F08 43 7A 77 20        4204 	.ascii "Czw "
   6F0C 00                 4205 	.db 0x00
   6F0D                    4206 _str_23:
   6F0D 50 69 61 20        4207 	.ascii "Pia "
   6F11 00                 4208 	.db 0x00
   6F12                    4209 _str_24:
   6F12 53 6F 62 20        4210 	.ascii "Sob "
   6F16 00                 4211 	.db 0x00
   6F17                    4212 _str_25:
   6F17 4E 69 65 20        4213 	.ascii "Nie "
   6F1B 00                 4214 	.db 0x00
   6F1C                    4215 _str_26:
   6F1C 45 72 72 6F 72 20  4216 	.ascii "Error       "
        20 20 20 20 20 20
   6F28 00                 4217 	.db 0x00
   6F29                    4218 _str_27:
   6F29 50 6F 6E 69 65 64  4219 	.ascii "Poniedzialek "
        7A 69 61 6C 65 6B
        20
   6F36 00                 4220 	.db 0x00
   6F37                    4221 _str_28:
   6F37 57 74 6F 72 65 6B  4222 	.ascii "Wtorek      "
        20 20 20 20 20 20
   6F43 00                 4223 	.db 0x00
   6F44                    4224 _str_29:
   6F44 53 72 6F 64 61 20  4225 	.ascii "Sroda       "
        20 20 20 20 20 20
   6F50 00                 4226 	.db 0x00
   6F51                    4227 _str_30:
   6F51 43 7A 77 61 72 74  4228 	.ascii "Czwartek    "
        65 6B 20 20 20 20
   6F5D 00                 4229 	.db 0x00
   6F5E                    4230 _str_31:
   6F5E 50 69 61 74 65 6B  4231 	.ascii "Piatek      "
        20 20 20 20 20 20
   6F6A 00                 4232 	.db 0x00
   6F6B                    4233 _str_32:
   6F6B 53 6F 62 6F 74 61  4234 	.ascii "Sobota      "
        20 20 20 20 20 20
   6F77 00                 4235 	.db 0x00
   6F78                    4236 _str_33:
   6F78 4E 69 65 64 7A 69  4237 	.ascii "Niedziela   "
        65 6C 61 20 20 20
   6F84 00                 4238 	.db 0x00
                           4239 	.area XINIT   (CODE)
