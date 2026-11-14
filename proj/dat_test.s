/* dat_test.s - Project Stage 1, Part A */

/* Data structure */
        .data
        .align 2

dat:
        .word 0                 @ inchar
        .word 0                 @ outchar
        .word 0                 @ charct
        .word 0                 @ wordct
        .word 0                 @ linect

_inchar = 0
_outchar = 4
_charct = 8
_wordct = 12
_linect = 16

/* Format strings */
        .section .rodata
        .align 2

return:
        .asciz "mod(dp) returned %d\n"

        .align 2
dump:
        .asciz "dat holds {%d, %d, %d, "

        .align 2
dump2:
        .asciz "%d, %d}\n"


/* mod function */
        .text
        .align 2
        .global mod

mod:
        @ r0 contains the address of dat

        ldr r1, [r0, #_inchar]
        add r1, r1, #100
        str r1, [r0, #_inchar]

        ldr r1, [r0, #_outchar]
        add r1, r1, #100
        str r1, [r0, #_outchar]

        ldr r1, [r0, #_charct]
        add r1, r1, #100
        str r1, [r0, #_charct]

        ldr r1, [r0, #_wordct]
        add r1, r1, #100
        str r1, [r0, #_wordct]

        ldr r1, [r0, #_linect]
        add r1, r1, #100
        str r1, [r0, #_linect]

        @ Return modified inchar
        ldr r0, [r0, #_inchar]
        bx lr


/* Main program */
        .text
        .align 2
        .global main

main:
        push {fp, lr}
        add fp, sp, #4
        sub sp, sp, #8

        @ [fp, #-8] holds dp
        @ [fp, #-12] holds ret
        @ r4 holds pointer to dat

        push {r4}
        ldr r4, datP

        str r4, [fp, #-8]

        @ Initialize all five fields

        mov r0, #10
        str r0, [r4, #_inchar]

        mov r0, #11
        str r0, [r4, #_outchar]

        mov r0, #12
        str r0, [r4, #_charct]

        mov r0, #13
        str r0, [r4, #_wordct]

        mov r0, #14
        str r0, [r4, #_linect]


        @ Print first three fields

        ldr r0, dumpP
        ldr r1, [r4, #_inchar]
        ldr r2, [r4, #_outchar]
        ldr r3, [r4, #_charct]
        bl printf

        @ Print remaining two fields

        ldr r0, dump2P
        ldr r1, [r4, #_wordct]
        ldr r2, [r4, #_linect]
        bl printf


        @ Call mod(dp)

        ldr r0, [fp, #-8]
        bl mod

        str r0, [fp, #-12]

        @ Print return value

        ldr r0, returnP
        ldr r1, [fp, #-12]
        bl printf


        @ Print modified structure

        ldr r0, dumpP
        ldr r1, [r4, #_inchar]
        ldr r2, [r4, #_outchar]
        ldr r3, [r4, #_charct]
        bl printf

        ldr r0, dump2P
        ldr r1, [r4, #_wordct]
        ldr r2, [r4, #_linect]
        bl printf


        @ Return 0

        mov r0, #0

        pop {r4}
        sub sp, fp, #4
        pop {fp, pc}


/* Pointer variables */
        .align 2

datP:   .word dat
returnP:
        .word return
dumpP:  .word dump
dump2P: .word dump2
