

;
; file: sub4.asm
; Subprogram example

%include "asm_io.inc"

;
; subprogram get_int
; Parameters (in order pushed on stack)
;   number of input (at [ebp + 12])
;   address of word to store input into (at [ebp + 8])
; Notes:
;   values of eax and ebx are destroyed
segment .data
prompt  db      ") Enter an integer number (0 to quit): ", 0

segment .bss

 

segment .text
        global  get_int, print_sum
get_int:
        enter   0,0

        mov     eax, [ebp + 12]
        call    print_int

        mov     eax, prompt
        call    print_string
        
        call    read_int
        mov     ebx, [ebp + 8]
        mov     [ebx], eax         ; store input into memory

        leave
        ret                        ; jump back to caller

; subprogram print_sum
; prints out the sum
; Parameter:
;   sum to print out (at [ebp+8])
; Note: destroys value of eax
;
segment .data
result  db      "The sum is ", 0

segment .text
print_sum:
        enter   0,0

        mov     eax, result
        call    print_string

        mov     eax, [ebp+8]
        call    print_int
        call    print_nl

        leave
        ret






