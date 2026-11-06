/* isneg.s - Lab 20, Part B1a */

/* format strings for I/O */
        .section        .rodata
        .align  2
prompt: .asciz "Enter an integer: "
        .align  2
scanf_fmt:
        .asciz "%d"
        .align  2
result: .asciz "isneg(%d) returns %d\n"

/* main program */
        .text
        .align  2
        .global main
main:
        push    {fp, lr}        @ setup stack frame
        add     fp, sp, #4
        sub     sp, sp, #8      @ space for local variable
        @ [fp, #-8] is x, input integer

        ldr     r0, promptP     @ print prompt
        bl      printf

        ldr     r0, scanfP      @ read integer x
        sub     r1, fp, #8
        bl      __isoc99_scanf

        ldr     r0, resultP     @ print result
        ldr     r1, [fp, #-8]
        mov     r2, #1          @ always print 1
        bl      printf

        mov     r0, #0          @ assign 0 as return value
        sub     sp, fp, #4      @ tear down stack frame
        pop     {fp, pc}

/* pointer variables for format strings */
        .align  2
promptP:
        .word   prompt
scanfP:
        .word   scanf_fmt
resultP:
        .word   result
