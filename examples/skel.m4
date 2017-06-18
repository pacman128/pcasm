m4_include(`asm.m4')
;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
_DATA_SEG
;
; initialized data is put in the data segment here
;


_BSS_SEG
;
; uninitialized data is put in the bss segment
;


_DGROUP

_TEXT_SEG
        global  _C_LABEL(asm_main)
_C_LABEL(asm_main):
	enter	0,0               ; setup routine
	pusha

;
; code is put in the text segment. Do not modify the code before
; or after this comment.
;

	popa
	mov     eax, 0            ; return back to C
	leave			  
	ret


