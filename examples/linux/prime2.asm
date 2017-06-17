

;
; file: prime2.asm
; This file contains the assembly code to the
; find_primes procedure
;
segment .text
        global  find_primes

;
; function find_primes
; finds the indicated number of primes
; Parameters:
;   array  - array to hold primes
;   n_find - how many primes to find
; C Prototype:
;extern void find_primes( int * array, unsigned n_find )
;

%define array         ebp + 8
%define n_find        ebp + 12
%define n             ebp - 4           ; number of primes found so far
%define isqrt         ebp - 8           ; floor of sqrt of guess
%define orig_cntl_wd  ebp - 10          ; original control word
%define new_cntl_wd   ebp - 12          ; new control word

find_primes:
        enter   12,0                    ; make room for local variables
        push    ebx                     ; save possible register variables
        push    esi

        fstcw   word [orig_cntl_wd]     ; get current control word
        mov     ax, [orig_cntl_wd]
        or      ax, 0C00h               ; set rounding bits to 11 (truncate)
        mov     [new_cntl_wd], ax
        fldcw   word [new_cntl_wd]

        mov     esi, [array]            ; esi points to array
        mov     dword [esi], 2          ; array[0] = 2
        mov     dword [esi + 4], 3      ; array[1] = 3
        mov     ebx, 5                  ; ebx = guess = 5
        mov     dword [n], 2            ; n = 2
;
; This outer loop finds a new prime each iteration, which it adds to the
; end of the array. Unlike the earlier prime finding program, this function
; does not determine primeness by dividing by all odd numbers. It only
; divides by the prime numbers that it has already found. (That's why they
; are stored in the array.)
;
while_limit:
        mov     eax, [n]
        cmp     eax, [n_find]           ; while ( n < n_find )
        jnb     short quit_limit

        mov     ecx, 1                  ; ecx is used as array index
        push    ebx                     ; store guess on stack
        fild    dword [esp]             ; load guess onto coprocessor stack
        pop     ebx                     ; get guess off stack
        fsqrt                           ; find sqrt(guess)
        fistp   dword [isqrt]           ; isqrt = floor(sqrt(quess))
;
; This inner loop divides guess (ebx) by earlier computed prime numbers
; until it finds a prime factor of guess (which means guess is not prime)
; or until the prime number to divide is greater than floor(sqrt(guess))
;
while_factor:
        mov     eax, dword [esi + 4*ecx]        ; eax = array[ecx]
        cmp     eax, [isqrt]                    ; while ( isqrt < array[ecx] 
        jnbe    short quit_factor_prime
        mov     eax, ebx
        xor     edx, edx
        div     dword [esi + 4*ecx]     
        or      edx, edx                        ; && guess % array[ecx] != 0 )
        jz      short quit_factor_not_prime
        inc     ecx                             ; try next prime
        jmp     short while_factor

;
; found a new prime !
;
quit_factor_prime:
        mov     eax, [n]
        mov     dword [esi + 4*eax], ebx        ; add guess to end of array
        inc     eax
        mov     [n], eax                        ; inc n

quit_factor_not_prime:
        add     ebx, 2                          ; try next odd number
        jmp     short while_limit

quit_limit:

        fldcw   word [orig_cntl_wd]             ; restore control word
        pop     esi                             ; restore register variables
        pop     ebx

        leave
        ret 

