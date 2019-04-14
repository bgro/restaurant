
	.SEGMENT "0"


	.FUNCT	PMEM?:ANY:1:1,PTR
	LESS?	PTR,PMEM-STORE /FALSE
	LESS?	PTR,PMEM-STORE+180 /TRUE
	RFALSE	


	.FUNCT	PMEM-RESET:ANY:0:0
	GRTR?	PMEM-WORDS-USED,0 \?CND1
	SET	'PMEM-WORDS-USED,0
	SUB	PMEM-STORE-LENGTH,PMEM-STORE-WORDS
	MUL	2,STACK
	COPYT	PMEM-STORE,0,STACK
?CND1:	SET	'PMEM-STORE-WORDS,PMEM-STORE-LENGTH
	SET	'PMEM-STORE-POINTER,PMEM-STORE
	RTRUE	


	.FUNCT	DO-PMEM-ALLOC:ANY:2:2,TYPE,LENGTH,STOR,LEFT,NEW
	SET	'STOR,PMEM-STORE-POINTER
	SET	'LEFT,PMEM-STORE-WORDS
	IGRTR?	'LENGTH,LEFT \?CND1
	ICALL2	P-NO-MEM-ROUTINE,TYPE
?CND1:	ADD	PMEM-WORDS-USED,LENGTH >PMEM-WORDS-USED
	SUB	LEFT,LENGTH >PMEM-STORE-WORDS
	GRTR?	PMEM-STORE-WARN,PMEM-STORE-WORDS \?CND3
	SET	'PMEM-STORE-WARN,PMEM-STORE-WORDS
	PRINTI	"[Debugging info: "
	PRINTI	"PMEM: "
	PRINTN	PMEM-STORE-WARN
	PRINTI	" left!]
"
?CND3:	MUL	LENGTH,2
	ADD	STOR,STACK >PMEM-STORE-POINTER
	DEC	'LENGTH
	PUTB	STOR,0,LENGTH
	PUTB	STOR,1,TYPE
	RETURN	STOR

	.ENDSEG

	.ENDI
