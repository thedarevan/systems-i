/* testfact.s - ARM assembly test program for fact() */

/* string constants */
	.section .rodata
	.align	2
prompt:			@ format string for printf
	.asciz "Enter an integer:  "
	.align	2
input:			@ format string for scanf
	.asciz "%d"
	.align	2
results:			@ format string for printf
	.asciz "The call fact(%d) returns %d\n"


/* fact.s - recursive factorial function in assembly */
/* fact function */

        .text
        .align  2
        .global fact
fact:
        push    {fp, lr}        @ setup stack frame
        add     fp, sp, #4
        sub     sp, sp, #8      @ #8 for local variable
        str     r0, [fp, #-8]   @ save n
        cmp     r0, #1          @ if n <= 1
        ble     else
        sub     r0, r0, #1      @ calculate n - 1
        bl      fact            @ recursive call fact(n-1)
        ldr     r1, [fp, #-8]   @ load original n
        mul     r0, r1, r0      @ return n * fact(n-1)
        b       next
else:
        mov     r0, #1          @ return 1
next:
        sub     sp, fp, #4      @ restore stack pointer
        pop     {fp, pc}        @ return

/* main program */
	.text
	.align	2
	.global main
main:
	push	{fp, lr}	@ setup stack frame
	add	fp, sp, #4
	sub	sp, sp, #8	@ ADD INLINE DOCUMENTATION
	@ ADD FULL LINE DOCUMENTATION HERE

	ldr	r0, promptP	@ print prompt
	bl	printf

	ldr	r0, inputP	@ read value into x
	sub	r1, fp, #8	
	bl	__isoc99_scanf

	ldr	r0, [fp, #-8]	@ call fact(x)
	bl	fact
	str	r0, [fp, #-12]	@ store return value in local variable ret

	ldr	r0, resultsP	@ print results
	ldr	r1, [fp, #-8]
	ldr	r2, [fp, #-12]
	bl	printf

	mov	r0, #0		@ load return value
	sub	sp, fp, #4	@ tear down stack frame
	pop	{fp, pc}

/* pointer variables for format strings  */
	.align	2
promptP: 	.word	prompt	
inputP:		.word	input	
resultsP:	.word	results	
