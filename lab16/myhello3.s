/* example of assembly programming
        Richard Brown 10/21/20 */

/* string constants */
        .section .rodata
        .align  2
hello:                                  @ format string for printf
        .ascii "Hello, world!\012\000"
        .align  2
bye:                                  @ format string for printf
        .ascii "Bye, world!\012\000"
        .align  2
num:                                  @ format string for printf
        .ascii "%d in Hex is %x\012\000"


/* main program */
        .text
        .align  2
        .global main
main:
        push    {fp, lr}                @ set up stack frame
        add     fp, sp, #4
        sub     sp, sp, #8              

        ldr     r0, helloP              @ call printf
        bl      printf

        ldr     r0, byeP              	@ call printf
	mov 	r1, #29
        bl      printf
	
	ldr     r0, numP                @ call printf
        mov	r1, #29
	mov	r2, #29
	bl      printf

        mov     r0, #0                  @ return 0 from main
        sub     sp, fp, #4              @ tear down stack frame
        pop     {fp, pc}

/* pointer variable for format string */
        .align  2
helloP: .word   hello                   @ pointer to string hello
byeP: .word	bye			@ pointer to string bye
numP: .word     num                     @ pointer to string bye

