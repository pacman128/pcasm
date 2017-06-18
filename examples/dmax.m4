m4_include(`asm.m4')
;
; file: dmax.asm

global _C_LABEL(dmax)

m4_ifelse( _SYSTEM, watcom,
`; Watcom doesn't pass floats back on the coprocessor stack'
`; Instead, the address of the location with the return value'
`; is passed back in EAX'
_BSS_SEG 
`return_value resq  1            ; quadword to store result into'
)

_TEXT_SEG
; function _C_LABEL(dmax)
; returns the larger of its two double arguments
; C prototype
; double dmax( double d1, double d2 )
; Parameters:
;   d1   - first double
;   d2   - second double
; Return value:
;   larger of d1 and d2 m4_ifelse( _SYSTEM, watcom, `', `(in ST0)')

; next, some helpful symbols are defined

%define d1   [ebp+8]
%define d2   [ebp+16]

_C_LABEL(dmax):
	enter   0, 0

	fld     qword d2
	fld	qword d1            ; ST0 = d1, ST1 = d2
	fcomip  st1                 ; ST0 = d2
	jna	short d2_bigger
	fcomp   st0                 ; pop d2 from stack
	fld	qword d1            ; ST0 = d1

d2_bigger:                          ; if d2 is bigger, nothing to do
m4_ifelse( _SYSTEM, watcom,
`        mov     eax, return_value   ; address of quadword with result'
`        fstp    qword [eax]         ; store result at location' 
)
exit:
	leave
        ret


