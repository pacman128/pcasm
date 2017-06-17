

;
; file: read.asm
; This subroutine reads an array of doubles from a file

segment .data
format  db      "%lf", 0        ; format for fscanf()

segment .bss

 

segment .text
        global  read_doubles
        extern  fscanf

%define SIZEOF_DOUBLE   8
%define FP              dword [ebp + 8]
%define ARRAYP          dword [ebp + 12]
%define ARRAY_SIZE      dword [ebp + 16]
%define TEMP_DOUBLE     [ebp - 8]

;
; function read_doubles
; C prototype:
;   int read_doubles( FILE * fp, double * arrayp, int array_size );
; This function reads doubles from a text file into an array, until
; EOF or array is full.
; Parameters:
;   fp         - FILE pointer to read from (must be open for input)
;   arrayp     - pointer to double array to read into
;   array_size - number of elements in array
; Return value:
;   number of doubles stored into array (in EAX)

read_doubles:
        push    ebp
        mov     ebp,esp
        sub     esp, SIZEOF_DOUBLE      ; define one double on stack

        push    esi                     ; save esi
        mov     esi, ARRAYP             ; esi = ARRAYP
        xor     edx, edx                ; edx = array index (initially 0)

while_loop:
        cmp     edx, ARRAY_SIZE         ; is edx < ARRAY_SIZE?
        jnl     short quit              ; if not, quit loop
;
; call fscanf() to read a double into TEMP_DOUBLE
; fscanf() might change edx so save it
;
        push    edx                     ; save edx
        lea     eax, TEMP_DOUBLE
        push    eax                     ; push &TEMP_DOUBLE
        push    dword format            ; push &format
        push    FP                      ; push file pointer
        call    fscanf
        add     esp, 12
        pop     edx                     ; restore edx
        cmp     eax, 1                  ; did fscanf return 1?
        jne     short quit              ; if not, quit loop

;
; copy TEMP_DOUBLE into ARRAYP[edx]
; (The 8-bytes of the double are copied by two 4-byte copies)
;
        mov     eax, [ebp - 8]
        mov     [esi + 8*edx], eax      ; first copy lowest 4 bytes
        mov     eax, [ebp - 4]
        mov     [esi + 8*edx + 4], eax  ; next copy highest 4 bytes

        inc     edx
        jmp     while_loop

quit:
        pop     esi                     ; restore esi

        mov     eax, edx                ; store return value into eax

        mov     esp, ebp
        pop     ebp
        ret 

