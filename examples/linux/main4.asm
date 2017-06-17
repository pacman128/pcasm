

;
; file: main4.asm
; Multi-module subprogram example program
;
; To create executable:
; Using djgpp:
; nasm -f coff sub4.asm
; nasm -f coff main4.asm
; gcc -o sub4 sub4.o main4.o driver.c asm_io.o
;
; Using Borland C/C++
; nasm -f obj sub4.asm
; nasm -f obj main4.asm
; bcc32 sub4.obj main4.asm driver.c asm_io.obj

%include "asm_io.inc"

segment .data
sum     dd   0

segment .bss
input   resd 1

 

;
; psuedo-code algorithm
; i = 1;
; sum = 0;
; while( get_int(i, &input), input != 0 ) {
;   sum += input;
;   i++;
; }
; print_sum(num);

segment .text
        global  asm_main
        extern  get_int, print_sum
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     edx, 1            ; edx is 'i' in pseudo-code
while_loop:
        push    edx               ; save i on stack
        push    dword input       ; push address on input on stack
        call    get_int
        add     esp, 8            ; remove i and &input from stack

        mov     eax, [input]
        cmp     eax, 0
        je      end_while

        add     [sum], eax        ; sum += input

        inc     edx
        jmp     short while_loop

end_while:
        push    dword [sum]       ; push value of sum onto stack
        call    print_sum
        pop     ecx               ; remove [sum] from stack

        popa
        leave                     
        ret




