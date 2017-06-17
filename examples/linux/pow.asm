%include "asm_io.inc"

;
;pow(x,y). ECX=X, EBX=Y, result store at EAX
;

segment .text
global asm_main
asm_main:
enter 0,0
pusha

mov eax,1	 
mov ecx,2
mov ebx,31	
for:
mul ecx
dec ebx
cmp ebx,0
jz result
jmp for

result:
dump_regs 1
call print_int
call print_nl
mov eax,ebx
dump_regs eax
call print_int

mov eax,0
leave
ret
