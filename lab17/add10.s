/* add10.s */

/* string constants */
        .section .rodata
        .align  2
prompt:
        .asciz "Enter an integer: "
        .align  2
input:
        .asciz "%d"
        .align  2
results:
        .asciz "Ten plus %d equals %d\n"

/* main program */
        .text
        .align  2
        .global main
main:
        push    {fp, lr}            @ setup stack frame
        add     fp, sp, #4
        sub     sp, sp, #8          @ 2 local variables

        @ [fp, #-8] holds val, input integer
        @ [fp, #-12] holds result, val + 10

        ldr     r0, promptP         @ print prompt
        bl      printf

        ldr     r0, inputP          @ read val
        sub     r1, fp, #8
        bl      __isoc99_scanf

        ldr     r2, [fp, #-8]       @ compute result
        add     r1, r2, #10
        str     r1, [fp, #-12]

        ldr     r0, resultsP        @ print results
        ldr     r1, [fp, #-8]
        ldr     r2, [fp, #-12]
        bl      printf

        mov     r0, #0              @ load return value
        sub     sp, fp, #4          @ tear down stack frame
        pop     {fp, pc}

/* pointer variables for format strings */
        .align  2
promptP:
        .word   prompt
inputP:
        .word   input
resultsP:
        .word   results
