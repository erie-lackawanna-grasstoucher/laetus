[org 0x7c00]

mov ax, 0x0013
int 0x10

shell:
        mov bx,text
        mov ah,0x0e
prnt:
        mov al,[bx]
        cmp al,0
        je next
        int 0x10
        inc bx
        jmp prnt
next:
        mov dx,8
        mov si,buffer
        mov di,0
mes:
        mov ah,0
        int 0x16
        mov [si],al
        inc si
        cmp al,0x0d
        jne hi
eap:
        mov byte [si],0
        mov si,[buffer]
        xor cx,cx
char:
        cmp byte [si],0
        je tns
        inc cx
        inc si
        jmp char
tns:
        lea si, buffer
        lea di, two
        cld
        repe cmpsb
        je hel
old:
        mov ch, [line_counter]
        inc ch
        cmp ch,25
        je zero
        mov [line_counter], ch
        mov ah,0x02
        mov bh,0
        mov dh,ch
        mov dl,0
        int 0x10
        jmp shell
zero:
        mov ch,-1
        mov ax,0x0013
        int 0x10
        mov [line_counter], ch
        jmp old
hi:
        mov ah,0x0e
        int 0x10
        inc dx
        cmp dx,39
        je old
        jmp mes
hel:
        mov ax,0x0e01
        int 0x10
        jmp old
line_counter db 0
text db 'laetus> ',0
two db 'his'
buffer resb 255
jmp $
times 510-($-$$) db 0
db 0x55, 0xaa
