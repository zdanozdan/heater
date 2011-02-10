head	1.1;
branch	1.1.1;
access;
symbols
	Ziomek_CD_22_06_2005:1.1.1.1
	Ardetem_shipment_22_06_2005:1.1.1.1
	ed20:1.1.1.1
	easydevices:1.1.1;
locks; strict;
comment	@# @;


1.1
date	2004.06.19.21.48.16;	author tomasz;	state Exp;
branches
	1.1.1.1;
next	;

1.1.1.1
date	2004.06.19.21.48.16;	author tomasz;	state Exp;
branches;
next	;


desc
@@



1.1
log
@Initial revision
@
text
@
NAME	DUMMY

?PR?dummy_function?DUMMY                 SEGMENT CODE
PUBLIC	dummy_function

; void dummy_function()

	RSEG  ?PR?dummy_function?DUMMY
	USING	0
dummy_function:
	RETI
; END OF dummy_function

	END
@


1.1.1.1
log
@First import for new relases
@
text
@@
