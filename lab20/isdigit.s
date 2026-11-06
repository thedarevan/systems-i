/* isdigit.s - Lab 20, Part C4 */

/* format strings for I/O */
        .section        .rodata
        .align  2
prompt: .asciz "Enter an integer: "
        .align  2
scanf_fmt:
        .asciz "%d"
        .align  2
result: .asciz "isdigit(%d) returns %d\n"

/* isdigit function */
/* Returns 1 if val is an ASCII digit, 0 otherwise */
        .text
        .align  2
        .global isdigit
isdigit:
        push    {fp, lr}        @ setup stack frame
        add     fp, sp, #4

        cmp     r0, #'0'        @ compare val to ASCII 48
        blt     else            @ jump if val < 48

        cmp     r0, #'9'        @ compare val to ASCII 57
        bgt     else            @ jump if val > 57

        mov     r0, #1          @ return 1
        b       next

else:
        mov     r0, #0          @ return 0

next:
        sub     sp, fp, #4      @ tear down stack frame
        pop     {fp, pc}

/* main program */
        .text
        .align  2
        .global main
main:
        push    {fp, lr}        @ setup stack frame
        add     fp, sp, #4
        sub     sp, sp, #8      @ space for local variables
        @ [fp, #-8] is x, input integer
        @ [fp, #-12] is result of isdigit(x)

        ldr     r0, promptP     @ print prompt
        bl      printf

        ldr     r0, scanfP      @ read integer x
        sub     r1, fp, #8
        bl      __isoc99_scanf

        ldr     r0, [fp, #-8]   @ call isdigit(x)
        bl      isdigit
        str     r0, [fp, #-12]  @ store return value

        ldr     r0, resultP     @ print result
        ldr     r1, [fp, #-8]
        ldr     r2, [fp, #-12]
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
