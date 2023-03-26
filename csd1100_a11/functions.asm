; ------------------------------------------------------------------
; File: functions.asm
; Project: CSD1100 Assignment 11
; Author: Vadim Surov, vsurov@digipen.edu
; Co-Author: Deng Maojie, maojie.deng@digipen.edu
;
; Compile: nasm -f elf64 -g -F dwarf functions.asm -o functions.o
; Link: gcc main.o functions.o -o main.o -lm
; Run: ./main 0
; Debug: gdb main
;  (gdb) b f1
;  (gdb) run
;  ...
;  0
;  ...
;  (gdb) ...
;
; Copyright: 2021, Digipen Institute of Technology, Singapore
;
; Note: All functions use at most 6 parameters
;      p1, p2, p3, p4, p5, p6
;      located in registers
;      rdi, rsi, rdx, rcx, r8, r9
;      accordingly.
; ------------------------------------------------------------------

    section .text

    global f1
    global f2

f1:
; TODO: - Given two circles with central points at (p1,p2), (p3,p4),
;       and radii p5, p6. All values in p1, ..., p6 are integers.
;       - Create code that determins intersection
;       or non-intersection of the circles.
;       - You code must return 1 when intersecting or 0 otherwise
;       based on the result of calculation.
;       - Tip 1: use the method without square root calculations:
;       if (p1-p3)^2+(p2-p4)^2 <= (p5+p6)^2 then return 1
;       - Tip 2: do not use pow() function to calculate x^2, use 
;       x*x instead.
;       - Note that a point is a circle with radius 0.
        
        ;add p1-p3
        sub rdi,rdx
        ;store rdi into r10
        mov r10,rdi
        ;reset rdi to 0 so no value
        mov rdi,0
        ;squre the value r10
        imul r10,r10
        ;add p2-p4
        sub rsi,rcx
        ;store rsi into r11
        mov r11,rsi
        ;reset rsi to 0 so no value
        mov rsi,0
        ;squre the value r11
        imul r11,r11
        ;add both r10 and r11 tgh
        ;completed (p1-p3)^2+(p2-p4)^2
        add r10,r11

        ;add p5+p6
        add r8,r9
        ;store r8 into r12
        mov r12,r8
        ;reset r8 to 0 so no value
        mov r8,0
        ;squre the value r12
        ;complete (p5+p6)^2
        imul r12,r12

        ;now compare both answer and return true || false
        cmp r10,r12
        ;if r10 small or equal u go into hit function
        jle hit
        ;if r10 bigger than r12 u go into no hit function
        jg noHit

    ;function to return hit
    hit:
    ;rax return 1
    mov rax,1
    ret
    ;function to return no hit
    noHit:
    ;rax return 0
    mov rax, 0
    ret 


f2:
; TODO: - Calculare (p1+0)*(p2+0) + (p1+1)*(p2+1) + (p1+2)*(p2+2) + .... +
;           (p1+p3)*(p2+p3)
;       - Tip: Accumulate the result in reverse order by decrementing 
;           p3 or (p1+p3) and (p2+p3)
   
    ;set it 1 so i can increment later
    mov rcx,1
    ;add rx into rcx 
    add rcx, rdx
    ;set rax 0
    mov rax,0
    ;set r12 into rcx
    mov r12, rcx
    
repeat:
    ;decrement r12 everytime start of the loop
    dec r12
    ;set p1 into r11
    mov r11,rdi
    ;set p2 into r13
    mov r13,rsi
    ;increase the value with counter cause p1+1 p1+2 ect
    ;(p1+1),(p1+2)
    add r11,r12
    ;(p2+1),(p2+2)
    add r13,r12
    ;(p1+0)*(p2+0)
    ;multiply both value tgh
    imul r11,r13
    ;add back to rax value as u need return rax at the end
    add rax,r11
    ;loop the function
    loop repeat


    ret    ; return rax;