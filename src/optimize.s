 	.syntax unified
 	.cpu cortex-m3
 	.thumb
 	.align 2
 	.global	optimize
 	.thumb_func

@  EE2024 Assignment 1 skeleton
@  CK Tham, ECE, NUS
@
@  Done by:
@		- Mohamed Riyas          (A0194608W)
@		- Mohideen Imran Khan    (A0181321U)





@  Subroutine to find the lowest point of a quadratic
@  cost function by performing gradient descent.
@
@  Parameters
@  ==========
@  R0 - x
@  R1 - a
@  R2 - b
@  R3 - *count
@  where x is the current solution x and
@        the quadratic function is ax^2 + bx + c.
@
@  Return
@  ======
@  R0 - solution x
@
@  Note
@  ====
@  This function only handles integer values.

optimize:
    PUSH {R1-R6}           @ OMITTED     @ save registers
    MOV  R4, #10           @ 0x03A0400A  @ R3 = 1/lambda, lambda = 0.5
    MOV  R5, #0            @ 0x03A05000  @ num iterations counter

loop:
    ADD   R5, R5, #1            @ 0x02855001 @ increment counter
    MUL   R6, R0, R1            @ 0x00006110 @ R6 = ax = R0 * R1;
    ADD   R6, R2, R6, LSL #1    @ OMITTED    @ R6 = 2ax + b = 2 * R6 + R2; (fp)
    SDIV  R6, R6, R4            @ OMITTED    @ R6 = fp * lambda = R6 / R4
    SUB   R0, R0, R6            @ 0x00400006 @ R0 = x - fp * lambda;
    CMP   R6, #0                @ 0x03560000 @ check if x = xprev
    BNE   loop                  @ 0x1800001C if x != xprev, loop

    STR  R5, [R3]          @ 0x05035000 store num iterations at pointed location
    POP  {R1-R6}           @ OMITTED    @ restore registers
    BX   LR                @ OMITTED    @ return

