/* find.s - Lab 19, Part B, Stage C */

/* format strings for I/O */
        .section        .rodata
        .align  2
prompt: .asciz "Enter character: "
        .align  2
scanf_fmt:
        .asciz "%c"
        .align  2
confirm: .asciz "In case you forgot, you input %c\n"
        .align  2
line_prompt:
        .asciz "Enter a line of input:\n"
        .align  2
result:
        .asciz "Length: %d\nBuffer: %s\n"
	.align 2
index_fmt:
	.asciz "%d "
	.align 2
newline: 
	.asciz "\n"

/* buffer for input line */
        .data
        .align  2
buff:   .space 100

/* main program */
        .text
        .align  2
        .global main
main:
        push    {fp, lr}        @ setup stack frame
        add     fp, sp, #4
        sub     sp, sp, #16      @ space for 3 local variables
        @ [fp, #-8] is ch
        @ [fp, #-12] is ct
	@ [fp, #-16] is i	
        ldr     r0, promptP     @ print prompt
        bl      printf

        ldr     r0, scanfP      @ read character
        sub     r1, fp, #8
        bl      __isoc99_scanf

        ldr     r0, confirmP    @ print confirmation
        ldrb    r1, [fp, #-8]
        bl      printf

        @ consume newline after character
        ldr     r0, buffP
        mov     r1, #100
        bl      get_line

        ldr     r0, line_promptP  @ prompt for input line
        bl      printf

        ldr     r0, buffP       @ read input line into buff
        mov     r1, #100
        bl      get_line

        str     r0, [fp, #-12]  @ store return value in ct

        ldr     r0, resultP     @ print ct and buff
        ldr     r1, [fp, #-12]
        ldr     r2, buffP
        bl      printf

	mov     r0, #0          @ initialize i = 0
        str     r0, [fp, #-16]

       	ldr     r0, buffP       @ get buff[i]
        ldr     r1, [fp, #-16]
        bl      get_byte

        ldrb    r1, [fp, #-8]   @ if buff[i] == ch
        cmp     r0, r1
        bne     next

        ldr     r0, index_fmtP  @ then print index i
        ldr     r1, [fp, #-16]
        bl      printf

next:
        ldr     r0, newlineP    @ print newline
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
confirmP:
        .word   confirm
line_promptP:
        .word   line_prompt
resultP:
        .word   result
buffP:
        .word   buff
index_fmtP:
        .word index_fmt
newlineP:
        .word newline
