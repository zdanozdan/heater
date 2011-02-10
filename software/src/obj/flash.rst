                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : FreeWare ANSI-C Compiler
                              3 ; Version 2.4.0 Thu Feb 10 12:42:20 2011
                              4 
                              5 ;--------------------------------------------------------
                              6 	.module src/flash
                              7 	.optsdcc -mmcs51 --model-small
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _dummy
                             13 	.globl _flash_write_page
                             14 	.globl _flash_write_byte
                             15 	.globl _read_manufacturer
                             16 	.globl _write
                             17 ;--------------------------------------------------------
                             18 ; special function registers
                             19 ;--------------------------------------------------------
                    0080     20 _P0	=	0x0080
                    0081     21 _SP	=	0x0081
                    0082     22 _DPL	=	0x0082
                    0083     23 _DPH	=	0x0083
                    0087     24 _PCON	=	0x0087
                    0088     25 _TCON	=	0x0088
                    0089     26 _TMOD	=	0x0089
                    008A     27 _TL0	=	0x008a
                    008B     28 _TL1	=	0x008b
                    008C     29 _TH0	=	0x008c
                    008D     30 _TH1	=	0x008d
                    0090     31 _P1	=	0x0090
                    0098     32 _SCON	=	0x0098
                    0099     33 _SBUF	=	0x0099
                    00A0     34 _P2	=	0x00a0
                    00B0     35 _P3	=	0x00b0
                    00B8     36 _IP	=	0x00b8
                    00C8     37 _T2CON	=	0x00c8
                    00C9     38 _T2MOD	=	0x00c9
                    00CA     39 _RCAP2L	=	0x00ca
                    00CB     40 _RCAP2H	=	0x00cb
                    00CC     41 _TL2	=	0x00cc
                    00CD     42 _TH2	=	0x00cd
                    00D0     43 _PSW	=	0x00d0
                    00E0     44 _A	=	0x00e0
                    00A6     45 _WDTRST	=	0x00a6
                    00A7     46 _WDTPRG	=	0x00a7
                    00A2     47 _AUXR1	=	0x00a2
                    008E     48 _AUXR	=	0x008e
                    00B9     49 _SADEN	=	0x00b9
                    00BA     50 _SADEN_1	=	0x00ba
                    00B7     51 _IPH	=	0x00b7
                    00B7     52 _IPH0	=	0x00b7
                    00B8     53 _IPL	=	0x00b8
                    00B8     54 _IPL0	=	0x00b8
                    00A8     55 _IE	=	0x00a8
                    00A9     56 _SADDR	=	0x00a9
                    00AA     57 _SADDR_1	=	0x00aa
                    00D8     58 _CCON	=	0x00d8
                    00D9     59 _CMOD	=	0x00d9
                    00DA     60 _CCAPM0	=	0x00da
                    00DB     61 _CCAPM1	=	0x00db
                    00DC     62 _CCAPM2	=	0x00dc
                    00DD     63 _CCAPM3	=	0x00dd
                    00DE     64 _CCAPM4	=	0x00de
                    00E9     65 _CL	=	0x00e9
                    00EA     66 _CCAP0L	=	0x00ea
                    00EB     67 _CCAP1L	=	0x00eb
                    00EC     68 _CCAP2L	=	0x00ec
                    00ED     69 _CCAP3L	=	0x00ed
                    00EE     70 _CCAP4L	=	0x00ee
                    00E0     71 _ACC	=	0x00e0
                    00F0     72 _B	=	0x00f0
                    00F9     73 _CH	=	0x00f9
                    00FA     74 _CCAP0H	=	0x00fa
                    00FB     75 _CCAP1H	=	0x00fb
                    00FC     76 _CCAP2H	=	0x00fc
                    00FD     77 _CCAP3H	=	0x00fd
                    00FE     78 _CCAP4H	=	0x00fe
                    00FF     79 _ICON	=	0x00ff
                    0085     80 _CKSEL	=	0x0085
                    0086     81 _OSCCON	=	0x0086
                    00D1     82 _FCON	=	0x00d1
                    00D2     83 _EECON	=	0x00d2
                    00D3     84 _EETIM	=	0x00d3
                             85 ;--------------------------------------------------------
                             86 ; special function bits 
                             87 ;--------------------------------------------------------
                    0080     88 _P0_0	=	0x0080
                    0081     89 _P0_1	=	0x0081
                    0082     90 _P0_2	=	0x0082
                    0083     91 _P0_3	=	0x0083
                    0084     92 _P0_4	=	0x0084
                    0085     93 _P0_5	=	0x0085
                    0086     94 _P0_6	=	0x0086
                    0087     95 _P0_7	=	0x0087
                    00A7     96 _ENBOOT	=	0x00a7
                    0088     97 _IT0	=	0x0088
                    0089     98 _IE0	=	0x0089
                    008A     99 _IT1	=	0x008a
                    008B    100 _IE1	=	0x008b
                    008C    101 _TR0	=	0x008c
                    008D    102 _TF0	=	0x008d
                    008E    103 _TR1	=	0x008e
                    008F    104 _TF1	=	0x008f
                    0090    105 _P1_0	=	0x0090
                    0091    106 _P1_1	=	0x0091
                    0092    107 _P1_2	=	0x0092
                    0093    108 _P1_3	=	0x0093
                    0094    109 _P1_4	=	0x0094
                    0095    110 _P1_5	=	0x0095
                    0096    111 _P1_6	=	0x0096
                    0097    112 _P1_7	=	0x0097
                    0090    113 _T2	=	0x0090
                    0091    114 _T2EX	=	0x0091
                    0098    115 _RI	=	0x0098
                    0099    116 _TI	=	0x0099
                    009A    117 _RB8	=	0x009a
                    009B    118 _TB8	=	0x009b
                    009C    119 _REN	=	0x009c
                    009D    120 _SM2	=	0x009d
                    009E    121 _SM1	=	0x009e
                    009F    122 _SM0	=	0x009f
                    00A0    123 _P2_0	=	0x00a0
                    00A1    124 _P2_1	=	0x00a1
                    00A2    125 _P2_2	=	0x00a2
                    00A3    126 _P2_3	=	0x00a3
                    00A4    127 _P2_4	=	0x00a4
                    00A5    128 _P2_5	=	0x00a5
                    00A6    129 _P2_6	=	0x00a6
                    00A7    130 _P2_7	=	0x00a7
                    00B0    131 _P3_0	=	0x00b0
                    00B1    132 _P3_1	=	0x00b1
                    00B2    133 _P3_2	=	0x00b2
                    00B3    134 _P3_3	=	0x00b3
                    00B4    135 _P3_4	=	0x00b4
                    00B5    136 _P3_5	=	0x00b5
                    00B6    137 _P3_6	=	0x00b6
                    00B7    138 _P3_7	=	0x00b7
                    00B0    139 _RXD	=	0x00b0
                    00B1    140 _TXD	=	0x00b1
                    00B2    141 _INT0	=	0x00b2
                    00B3    142 _INT1	=	0x00b3
                    00B4    143 _T0	=	0x00b4
                    00B5    144 _T1	=	0x00b5
                    00B6    145 _WR	=	0x00b6
                    00B7    146 _RD	=	0x00b7
                    00B8    147 _PX0	=	0x00b8
                    00B9    148 _PT0	=	0x00b9
                    00BA    149 _PX1	=	0x00ba
                    00BB    150 _PT1	=	0x00bb
                    00BC    151 _PS	=	0x00bc
                    00BD    152 _PT2	=	0x00bd
                    00C8    153 _T2CON_0	=	0x00c8
                    00C9    154 _T2CON_1	=	0x00c9
                    00CA    155 _T2CON_2	=	0x00ca
                    00CB    156 _T2CON_3	=	0x00cb
                    00CC    157 _T2CON_4	=	0x00cc
                    00CD    158 _T2CON_5	=	0x00cd
                    00CE    159 _T2CON_6	=	0x00ce
                    00CF    160 _T2CON_7	=	0x00cf
                    00C8    161 _CP_RL2	=	0x00c8
                    00C9    162 _C_T2	=	0x00c9
                    00CA    163 _TR2	=	0x00ca
                    00CB    164 _EXEN2	=	0x00cb
                    00CC    165 _TCLK	=	0x00cc
                    00CD    166 _RCLK	=	0x00cd
                    00CE    167 _EXF2	=	0x00ce
                    00CF    168 _TF2	=	0x00cf
                    00D0    169 _P	=	0x00d0
                    00D1    170 _FL	=	0x00d1
                    00D2    171 _OV	=	0x00d2
                    00D3    172 _RS0	=	0x00d3
                    00D4    173 _RS1	=	0x00d4
                    00D5    174 _F0	=	0x00d5
                    00D6    175 _AC	=	0x00d6
                    00D7    176 _CY	=	0x00d7
                    00AF    177 _EA	=	0x00af
                    00AE    178 _EC	=	0x00ae
                    00AD    179 _ET2	=	0x00ad
                    00AC    180 _ES	=	0x00ac
                    00AB    181 _ET1	=	0x00ab
                    00AA    182 _EX1	=	0x00aa
                    00A9    183 _ET0	=	0x00a9
                    00A8    184 _EX0	=	0x00a8
                    00DF    185 _CF	=	0x00df
                    00DE    186 _CR	=	0x00de
                    00DC    187 _CCF4	=	0x00dc
                    00DB    188 _CCF3	=	0x00db
                    00DA    189 _CCF2	=	0x00da
                    00D9    190 _CCF1	=	0x00d9
                    00D8    191 _CCF0	=	0x00d8
                            192 ;--------------------------------------------------------
                            193 ; overlayable register banks 
                            194 ;--------------------------------------------------------
                            195 	.area REG_BANK_0	(REL,OVR,DATA)
   0000                     196 	.ds 8
                            197 ;--------------------------------------------------------
                            198 ; internal ram data
                            199 ;--------------------------------------------------------
                            200 	.area DSEG    (DATA)
   0024                     201 _write::
   0024                     202 	.ds 2
                            203 ;--------------------------------------------------------
                            204 ; overlayable items in internal ram 
                            205 ;--------------------------------------------------------
                            206 	.area OSEG    (OVR,DATA)
                            207 ;--------------------------------------------------------
                            208 ; indirectly addressable internal ram data
                            209 ;--------------------------------------------------------
                            210 	.area ISEG    (DATA)
                            211 ;--------------------------------------------------------
                            212 ; bit data
                            213 ;--------------------------------------------------------
                            214 	.area BSEG    (BIT)
                            215 ;--------------------------------------------------------
                            216 ; external ram data
                            217 ;--------------------------------------------------------
                            218 	.area XSEG    (XDATA)
                            219 ;--------------------------------------------------------
                            220 ; external initialized ram data
                            221 ;--------------------------------------------------------
                            222 	.area XISEG   (XDATA)
                            223 ;--------------------------------------------------------
                            224 ; global & static initialisations
                            225 ;--------------------------------------------------------
                            226 	.area GSINIT  (CODE)
                            227 	.area GSFINAL (CODE)
                            228 	.area GSINIT  (CODE)
                            229 ;src/flash.c:32: const code void (*write)(void)  = (const void(code*)(void))0xFFF0;
                            230 ;     genAssign
   7715 75 24 F0            231 	mov	_write,#0xF0
   7718 75 25 FF            232 	mov	(_write + 1),#0xFF
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
                            243 ;Allocation info for local variables in function 'read_manufacturer'
                            244 ;------------------------------------------------------------
                            245 ;------------------------------------------------------------
                            246 ;src/flash.c:37: unsigned char read_manufacturer(void)
                            247 ;	-----------------------------------------
                            248 ;	 function read_manufacturer
                            249 ;	-----------------------------------------
   00C4                     250 _read_manufacturer:
                    0002    251 	ar2 = 0x02
                    0003    252 	ar3 = 0x03
                    0004    253 	ar4 = 0x04
                    0005    254 	ar5 = 0x05
                    0006    255 	ar6 = 0x06
                    0007    256 	ar7 = 0x07
                    0000    257 	ar0 = 0x00
                    0001    258 	ar1 = 0x01
   00C4 C0 40               259 	push	_bp
   00C6 85 81 40            260 	mov	_bp,sp
                            261 ;src/flash.c:39: EA=0;
                            262 ;     genAssign
   00C9 C2 AF               263 	clr	_EA
                            264 ;src/flash.c:40: MAP_BOOT
                            265 ;     genOr
   00CB 43 A2 20            266 	orl	_AUXR1,#0x20
                            267 ;src/flash.c:45: _endasm;
                            268 ;     genInline
                            269 ;
   00CE 79 00               270 	   mov r1,#0
   00D0 90 00 01            271 	   mov dptr,#1
   00D3 75 E0 02            272 	   mov acc,#02
                            273 ;src/flash.c:46: write();
                            274 ;     genPCall
   00D6 74 E3               275 	mov	a,#00103$
   00D8 C0 E0               276 	push	acc
   00DA 74 00               277 	mov	a,#(00103$ >> 8)
   00DC C0 E0               278 	push	acc
   00DE C0 24               279 	push	_write
   00E0 C0 25               280 	push	(_write + 1)
   00E2 22                  281 	ret
   00E3                     282 00103$:
                            283 ;src/flash.c:48: _endasm;
                            284 ;     genInline
                            285 ;
                            286 ;src/flash.c:49: UNMAP_BOOT
                            287 ;     genAssign
   00E3 AA A2               288 	mov	r2,_AUXR1
                            289 ;     genAnd
   00E5 74 DF               290 	mov	a,#0xDF
   00E7 5A                  291 	anl	a,r2
   00E8 F5 A2               292 	mov	_AUXR1,a
                            293 ;src/flash.c:50: EA=1;
                            294 ;     genAssign
   00EA D2 AF               295 	setb	_EA
                            296 ;src/flash.c:52: return ACC;
                            297 ;     genRet
   00EC 85 E0 82            298 	mov	dpl,_ACC
   00EF                     299 00101$:
   00EF 85 40 81            300 	mov	sp,_bp
   00F2 D0 40               301 	pop	_bp
   00F4 22                  302 	ret
                            303 ;------------------------------------------------------------
                            304 ;Allocation info for local variables in function 'flash_write_byte'
                            305 ;------------------------------------------------------------
                            306 ;address                   Allocated to stack - offset -4
                            307 ;value                     Allocated to registers r2 
                            308 ;------------------------------------------------------------
                            309 ;src/flash.c:55: unsigned char flash_write_byte(unsigned char value, unsigned int address)
                            310 ;	-----------------------------------------
                            311 ;	 function flash_write_byte
                            312 ;	-----------------------------------------
   00F5                     313 _flash_write_byte:
   00F5 C0 40               314 	push	_bp
   00F7 85 81 40            315 	mov	_bp,sp
                            316 ;     genReceive
   00FA AA 82               317 	mov	r2,dpl
                            318 ;src/flash.c:57: DPL = (unsigned char)address&0xFF;
                            319 ;     genCast
   00FC E5 40               320 	mov	a,_bp
   00FE 24 FC               321 	add	a,#0xfc
   0100 F8                  322 	mov	r0,a
   0101 86 82               323 	mov	_DPL,@r0
                            324 ;src/flash.c:58: DPH = (unsigned char)(address >> 8)&0xFF;
                            325 ;     genRightShift
                            326 ;     genRightShiftLiteral
   0103 E5 40               327 	mov	a,_bp
   0105 24 FC               328 	add	a,#0xfc
                            329 ;     genrshTwo
                            330 ;       Peephole 185    changed order of increment (acc incremented also!)
   0107 04                  331 	inc     a
   0108 F8                  332 	mov     r0,a
   0109 86 03               333 	mov	ar3,@r0
   010B 7C 00               334 	mov	r4,#0x00
                            335 ;     genCast
   010D 8B 83               336 	mov	_DPH,r3
                            337 ;src/flash.c:59: EA=0;
                            338 ;     genAssign
   010F C2 AF               339 	clr	_EA
                            340 ;src/flash.c:61: MAP_BOOT
                            341 ;     genOr
   0111 43 A2 20            342 	orl	_AUXR1,#0x20
                            343 ;src/flash.c:71: _endasm;
                            344 ;     genInline
                            345 ;
   0114 74 25               346 	   mov a,#dummyret$
   0116 C0 E0               347 	   push acc
   0118 74 01               348 	   mov a,#(dummyret$ >> 8)
   011A C0 E0               349 	   push acc
   011C C0 24               350 	   push _write
   011E C0 25               351 	   push (_write + 1)
   0120 79 02               352 	   mov r1,#02
                            353 ;src/flash.c:72: A=value;
                            354 ;     genAssign
   0122 8A E0               355 	mov	_A,r2
                            356 ;src/flash.c:77: _endasm;
                            357 ;     genInline
                            358 ;
   0124 22                  359 	   ret
   0125                     360 dummyret$:
                            361 ;src/flash.c:78: UNMAP_BOOT
                            362 ;     genAssign
   0125 AA A2               363 	mov	r2,_AUXR1
                            364 ;     genAnd
   0127 74 DF               365 	mov	a,#0xDF
   0129 5A                  366 	anl	a,r2
   012A F5 A2               367 	mov	_AUXR1,a
                            368 ;src/flash.c:79: EA=1;
                            369 ;     genAssign
   012C D2 AF               370 	setb	_EA
                            371 ;src/flash.c:81: return ACC;
                            372 ;     genRet
   012E 85 E0 82            373 	mov	dpl,_ACC
   0131                     374 00101$:
   0131 85 40 81            375 	mov	sp,_bp
   0134 D0 40               376 	pop	_bp
   0136 22                  377 	ret
                            378 ;------------------------------------------------------------
                            379 ;Allocation info for local variables in function 'flash_write_page'
                            380 ;------------------------------------------------------------
                            381 ;xram                      Allocated to stack - offset -4
                            382 ;flash                     Allocated to stack - offset -6
                            383 ;count                     Allocated to registers r2 
                            384 ;------------------------------------------------------------
                            385 ;src/flash.c:84: unsigned char flash_write_page(unsigned char count, unsigned int xram, unsigned int flash) critical
                            386 ;	-----------------------------------------
                            387 ;	 function flash_write_page
                            388 ;	-----------------------------------------
   0137                     389 _flash_write_page:
   0137 C0 40               390 	push	_bp
   0139 85 81 40            391 	mov	_bp,sp
   013C D3                  392 	setb	c
   013D 10 AF 01            393 	jbc	ea,00103$
   0140 C3                  394 	clr	c
   0141                     395 00103$:
   0141 C0 D0               396 	push	psw
                            397 ;     genReceive
   0143 AA 82               398 	mov	r2,dpl
                            399 ;src/flash.c:87: DPL = (unsigned char)flash&0xFF;
                            400 ;     genCast
   0145 E5 40               401 	mov	a,_bp
   0147 24 FA               402 	add	a,#0xfa
   0149 F8                  403 	mov	r0,a
   014A 86 82               404 	mov	_DPL,@r0
                            405 ;src/flash.c:88: DPH = (unsigned char)(flash >> 8)&0xFF;
                            406 ;     genRightShift
                            407 ;     genRightShiftLiteral
   014C E5 40               408 	mov	a,_bp
   014E 24 FA               409 	add	a,#0xfa
                            410 ;     genrshTwo
                            411 ;       Peephole 185    changed order of increment (acc incremented also!)
   0150 04                  412 	inc     a
   0151 F8                  413 	mov     r0,a
   0152 86 03               414 	mov	ar3,@r0
   0154 7C 00               415 	mov	r4,#0x00
                            416 ;     genCast
   0156 8B 83               417 	mov	_DPH,r3
                            418 ;src/flash.c:89: SET_DPTR1
                            419 ;     genOr
   0158 43 A2 01            420 	orl	_AUXR1,#0x01
                            421 ;src/flash.c:90: DPL = (unsigned char)xram&0xFF;
                            422 ;     genCast
   015B E5 40               423 	mov	a,_bp
   015D 24 FC               424 	add	a,#0xfc
   015F F8                  425 	mov	r0,a
   0160 86 82               426 	mov	_DPL,@r0
                            427 ;src/flash.c:91: DPH = (unsigned char)(xram >> 8)&0xFF;
                            428 ;     genRightShift
                            429 ;     genRightShiftLiteral
   0162 E5 40               430 	mov	a,_bp
   0164 24 FC               431 	add	a,#0xfc
                            432 ;     genrshTwo
                            433 ;       Peephole 185    changed order of increment (acc incremented also!)
   0166 04                  434 	inc     a
   0167 F8                  435 	mov     r0,a
   0168 86 03               436 	mov	ar3,@r0
   016A 7C 00               437 	mov	r4,#0x00
                            438 ;     genCast
   016C 8B 83               439 	mov	_DPH,r3
                            440 ;src/flash.c:92: SET_DPTR0
                            441 ;     genAssign
   016E AB A2               442 	mov	r3,_AUXR1
                            443 ;     genAnd
   0170 74 FE               444 	mov	a,#0xFE
   0172 5B                  445 	anl	a,r3
   0173 F5 A2               446 	mov	_AUXR1,a
                            447 ;src/flash.c:94: MAP_BOOT
                            448 ;     genOr
   0175 43 A2 20            449 	orl	_AUXR1,#0x20
                            450 ;src/flash.c:103: _endasm;
                            451 ;     genInline
                            452 ;
   0178 74 89               453 	   mov a,#dummyret_f$
   017A C0 E0               454 	   push acc
   017C 74 01               455 	   mov a,#(dummyret_f$ >> 8)
   017E C0 E0               456 	   push acc
   0180 C0 24               457 	   push _write
   0182 C0 25               458 	   push (_write + 1)
   0184 79 09               459 	   mov r1,#09
                            460 ;src/flash.c:104: A=count;
                            461 ;     genAssign
   0186 8A E0               462 	mov	_A,r2
                            463 ;src/flash.c:111: _endasm;
                            464 ;     genInline
                            465 ;
   0188 22                  466 	   ret
   0189                     467 dummyret_f$:
                            468 ;src/flash.c:112: UNMAP_BOOT
                            469 ;     genAssign
   0189 AA A2               470 	mov	r2,_AUXR1
                            471 ;     genAnd
   018B 74 DF               472 	mov	a,#0xDF
   018D 5A                  473 	anl	a,r2
   018E F5 A2               474 	mov	_AUXR1,a
                            475 ;src/flash.c:115: return ACC;
                            476 ;     genRet
   0190 85 E0 82            477 	mov	dpl,_ACC
   0193                     478 00101$:
   0193 D0 D0               479 	pop	psw
   0195 92 AF               480 	mov	ea,c
   0197 85 40 81            481 	mov	sp,_bp
   019A D0 40               482 	pop	_bp
   019C 22                  483 	ret
                            484 	.area CSEG    (CODE)
                    FFF0    485 _dummy	=	0xfff0
                            486 	.area XINIT   (CODE)
