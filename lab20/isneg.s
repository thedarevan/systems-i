/* isneg.s - Lab 20, Part B1 */

/* format strings for I/O */
        .section        .rodata
        .align  2
prompt: .asciz "Enter an integer: "
        .align  2
scanf_fmt:
        .asciz "%d"
        .align  2
result: .asciz "isneg(%d) returns %d\n"

/* isneg function */
/* isneg(val)
   Argument: r0 = val
   Return: 1 if val is negative, 0 otherwise
*/
        .text
        .align  2
        .global isneg
isneg:
        push    {fp, lr}        @ setup stack frame
        add     fp, sp, #4

        cmp     r0, #0          @ if val < 0
        bge     else

        mov     r0, #1          @ then return 1
        b       next

else:
        mov     r0, #0          @ else return 0

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
        @ [fp, #-12] is result of isneg(x)

        ldr     r0, promptP     @ print prompt
        bl      printf

        ldr     r0, scanfP      @ read integer x
        sub     r1, fp, #8
        bl      __isoc99_scanf

        ldr     r0, [fp, #-8]   @ call isneg(x)
        bl      isneg
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
