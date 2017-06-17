

;
; file: max.asm
; This example demostrates how to avoid conditional branches

%include "asm_io.inc"
segment .data

message1 db "Enter a number: ",0
message2 db "Enter another number: ", 0
message3 db "The larger number is: ", 0

segment .bss

input1  resd    1        ; first number entered

 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     eax, message1     ; print out first message
        call    print_string
        call    read_int          ; input first number
        mov     [input1], eax

        mov     eax, message2     ; print out second message
        call    print_string
        call    read_int          ; input second number (in eax)

        xor     ebx, ebx          ; ebx = 0
        cmp     eax, [input1]     ; compare second and first number
        setg    bl                ; ebx = (input2 > input1) ?          1 : 0
        neg     ebx               ; ebx = (input2 > input1) ? 0xFFFFFFFF : 0
        mov     ecx, ebx          ; ecx = (input2 > input1) ? 0xFFFFFFFF : 0
        and     ecx, eax          ; ecx = (input2 > input1) ?     input2 : 0
        not     ebx               ; ebx = (input2 > input1) ?          0 : 0xFFFFFFFF
        and     ebx, [input1]     ; ebx = (input2 > input1) ?          0 : input1
        or      ecx, ebx          ; ecx = (input2 > input1) ?     input2 : input1

        mov     eax, message3     ; print out result
        call    print_string
        mov     eax, ecx
        call    print_int
        call    print_nl

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


