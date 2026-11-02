/* testpow.s - ARM assembly test program for pow() */

/* string constants */
        .section .rodata
        .align  2
prompt:                         @ format string for printf
        .asciz "Enter two integers:  "
        .align  2
input:                          @ format string for scanf
        .asciz "%d %d"
        .align  2
results:                        @ format string for printf
        .asciz "The call pow(%d, %d) returns %d\n"


/* pow(int x, int p)
   2 arguments: integers x and p
   Return: integer x raised to the power p
   Assumes p >= 0
*/

        .text
        .align  2
        .global pow
pow:
        push    {fp, lr}            @ set up stack frame
        add     fp, sp, #4
        sub     sp, sp, #16         @ 4 local variables, 16 bytes

        @ [fp, #-8] holds x, base
        @ [fp, #-12] holds p, exponent
        @ [fp, #-16] holds result
        @ [fp, #-20] holds i, loop counter

        str     r0, [fp, #-8]       @ save x
        str     r1, [fp, #-12]      @ save p

        mov     r3, #1              @ result = 1
        str     r3, [fp, #-16]

        mov     r3, #0              @ i = 0
        str     r3, [fp, #-20]

        b       guard               @ jump to loop guard

body:
        ldr     r2, [fp, #-16]      @ load result
        ldr     r3, [fp, #-8]       @ load x
        mul     r2, r3, r2          @ result = result * x
        str     r2, [fp, #-16]      @ save result

        ldr     r3, [fp, #-20]      @ load i
        add     r3, r3, #1          @ i++
        str     r3, [fp, #-20]      @ save i

guard:
        ldr     r2, [fp, #-20]      @ load i
        ldr     r3, [fp, #-12]      @ load p
        cmp     r2, r3              @ compare i and p
        blt     body                @ repeat if i < p

        ldr     r0, [fp, #-16]      @ return result

        sub     sp, fp, #4          @ tear down stack frame
        pop     {fp, pc}


/* main program */
        .text
        .align  2
        .global main
main:
        push    {fp, lr}            @ set up stack frame
        add     fp, sp, #4
        sub     sp, sp, #16         @ 3 local variables (12 bytes), plus 4 for alignment

        @ [fp, #-8] holds x, first input integer
        @ [fp, #-12] holds p, second input integer
        @ [fp, #-16] holds ret, return value from pow()

        ldr     r0, promptP         @ print prompt
        bl      printf

        ldr     r0, inputP          @ call scanf("%d %d", &x, &p)
        sub     r1, fp, #8
        sub     r2, fp, #12
        bl      scanf

        ldr     r0, [fp, #-8]       @ call pow(x, p)
        ldr     r1, [fp, #-12]
        bl      pow

        str     r0, [fp, #-16]      @ save return value in ret

        ldr     r0, resultsP        @ print results
        ldr     r1, [fp, #-8]       @ x
        ldr     r2, [fp, #-12]      @ p
        ldr     r3, [fp, #-16]      @ ret
        bl      printf

        mov     r0, #0              @ return 0
        sub     sp, fp, #4          @ tear down stack frame
        pop     {fp, pc}


/* pointer variables */
        .align  2
promptP:
        .word   prompt
inputP:
        .word   input
resultsP:
        .word   results
