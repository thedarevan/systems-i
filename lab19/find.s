/* find.s */

/* format strings for I/O */
        .section        .rodata
        .align  2
prompt: .asciz "Enter character: : "
        .align  2
scanf:
        .asciz "%c"
        .align  2
confirm: .asciz "In case you forgot, you input %c\n"



/* main program */
        .text
        .align  2
        .global main
main:
        push    {fp, lr}        @ setup stack frame
        add     fp, sp, #4
        sub     sp, sp, #8      @ #8 for 1 local variables
        @ [fp, #-8] is ch, first char variable

        ldr     r0, promptP     @ print prompt
        bl      printf
        ldr     r0, scanfP  @ read char
        sub     r1, fp, #8
        bl      __isoc99_scanf

        ldr     r0, [fp, #-8]	
        ldr     r0, confirmP     @ print confirmation
        ldr     r1, [fp, #-8]   
        bl      printf

        mov     r0, #0          @ assign 0 as return value
        sub     sp, fp, #4      @ tear down stack frame
        pop     {fp, pc}

/* pointer variables for format strings */
        .align  2
promptP:
        .word   prompt
scanfP:
        .word   scanf     
confirmP:
        .word   confirm
