

;
; file: big_math.asm
; Defines asm routines that add and subtract Big_ints
; There is a lot of common code between the add and subtract routines.
;

segment .data


segment .bss

 

segment .text
        global  add_big_ints, sub_big_ints

;
; A Big_int class is represented by a struct with a unsigned DWORD named 
; size_ and a DWORD pointer named number_. An instance looks like:
;  +---------+
;  | size_   |  offset = 0
;  +---------+
;  | number_ |  offset = 4
;  +---------+
;
%define size_offset 0
%define number_offset 4

%define EXIT_OK 0
%define EXIT_OVERFLOW 1
%define EXIT_SIZE_MISMATCH 2

;
; Parameters for both add and sub routines
;
;Pointer to the Big_int to store result into
%define res ebp+8
;
; Pointer to the first Big_int to add or sub
%define op1 ebp+12
;
; Pointer to the second Big_int to add or sub
%define op2 ebp+16

;
; int add_big_ints(Big_int & res, const Big_int & op1, const Big_int & op2);
; res at [ebp + 8]
; op1 at [ebp + 12]
; op2 at [ebp + 16]
;

add_big_ints:
        push    ebp
        mov     ebp, esp
        push    ebx
        push    esi
        push    edi

        ;
        ; first set up esi to point to op1
        ;              edi to point to op2
        ;              ebx to point to res
        ;       
        mov     esi, [op1]
        mov     edi, [op2]
        mov     ebx, [res]
        ;
        ; make sure that all 3 Big_int's have the same size
        ;
        mov     eax, [esi + size_offset]
        cmp     eax, [edi + size_offset]
        jne     sizes_not_equal                 ; op1.size_ != op2.size_
        cmp     eax, [ebx + size_offset]
        jne     sizes_not_equal                 ; op1.size_ != res.size_

        mov     ecx, eax                        ; ecx = size of Big_int's

        ;
        ; now, set registers to point to their respective arrays
        ;      esi = op1.number_
        ;      edi = op2.number_
        ;      ebx = res.number_
        ;
        mov     ebx, [ebx + number_offset]
        mov     esi, [esi + number_offset]
        mov     edi, [edi + number_offset]
        
        clc                                     ; clear carry flag
        xor     edx, edx                        ; edx = 0
        ;
        ; addition loop
        ;
add_loop:
        mov     eax, [edi+4*edx]
        adc     eax, [esi+4*edx]
        mov     [ebx + 4*edx], eax
        inc     edx                             ; does not alter carry flag
        loop    add_loop

        jc      overflow
ok_done:
        xor     eax, eax                        ; return value = EXIT_OK
        jmp     done
overflow:
        mov     eax, EXIT_OVERFLOW
        jmp     done
sizes_not_equal:
        mov     eax, EXIT_SIZE_MISMATCH
done:
        pop     edi
        pop     esi
        pop     ebx
        leave
        ret

;
; int sub_big_ints(Big_int & res, const Big_int & op1, const Big_int & op2);
; Computes res = op1 - op2
; This routine uses some of the add_big_ints routine code!
; res at [ebp + 8]
; op1 at [ebp + 12]
; op2 at [ebp + 16]
;

sub_big_ints:
        push    ebp
        mov     ebp, esp
        push    ebx
        push    esi
        push    edi
        
        ;
        ; first set up esi to point to op1
        ;              edi to point to op2
        ;              ebx to point to res
        ;       
        mov     esi, [op1]
        mov     edi, [op2]
        mov     ebx, [res]
        ;
        ; make sure that all 3 Big_int's have the same size
        ;
        mov     eax, [esi + size_offset]
        cmp     eax, [edi + size_offset]
        jne     sizes_not_equal
        cmp     eax, [ebx + size_offset]
        jne     sizes_not_equal

        mov     ecx, eax

        ;
        ; now, point registers to point to their respective arrays
        ;      esi = op1.number_
        ;      edi = op2.number_
        ;      ebx = res.number_
        ;
        mov     ebx, [ebx + number_offset]
        mov     esi, [esi + number_offset]
        mov     edi, [edi + number_offset]

        clc
        xor     edx, edx
        ;
        ; subtraction loop
        ;
sub_loop:
        mov     eax, [esi+4*edx]
        sbb     eax, [edi+4*edx]
        mov     [ebx + 4*edx], eax
        inc     edx
        loop    sub_loop

        jnc     ok_done
        jmp     overflow






