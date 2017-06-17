

;
; file: sub1.asm
; Subprogram example program
;
; To create executable:
; Using djgpp:
; nasm -f coff sub1.asm
; gcc -o sub1 sub1.o driver.c asm_io.o
;

%include "asm_io.inc"

segment .data
prompt1 db    "Enter a number: ", 0       ; don't forget nul terminator
prompt2 db    "Enter another number: ", 0
outmsg1 db    "You entered ", 0
outmsg2 db    " and ", 0
outmsg3 db    ", the sum of these is ", 0

segment .bss
;
; These labels refer to double words used to store the inputs
;
input1  resd 1
input2  resd 1

 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     eax, prompt1      ; print out prompt
        call    print_string

        mov     ebx, input1       ; store address of input1 into ebx
        mov     ecx, ret1         ; store return address into ecx
        jmp     short get_int     ; read integer
ret1:
        mov     eax, prompt2      ; print out prompt
        call    print_string

        mov     ebx, input2
        mov     ecx, $ + 7        ; ecx = this address + 7
        jmp     short get_int

        mov     eax, [input1]     ; eax = dword at input1
        add     eax, [input2]     ; eax += dword at input2
        mov     ebx, eax          ; ebx = eax
;
; next print out result message as series of steps
;

        mov     eax, outmsg1
        call    print_string      ; print out first message
        mov     eax, [input1]     
        call    print_int         ; print out input1
        mov     eax, outmsg2
        call    print_string      ; print out second message
        mov     eax, [input2]
        call    print_int         ; print out input2
        mov     eax, outmsg3
        call    print_string      ; print out third message
        mov     eax, ebx
        call    print_int         ; print out sum (ebx)
        call    print_nl          ; print new-line

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
;
; subprogram get_int
; Parameters:
;   ebx - address of dword to store integer into
;   ecx - address of instruction to return to
; Notes:
;   value of eax is destroyed
get_int:
        call    read_int
        mov     [ebx], eax         ; store input into memory
        jmp     ecx                ; jump back to caller


