/* stage1.s - Project Stage 1, Part B */

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


/* Input buffer */
        .align 2
buff:
        .space 256


/* Format strings */
        .section .rodata
        .align 2

char_fmt:
        .asciz "%c%c\n"

        .align 2
str_fmt:
        .asciz "%s"

        .align 2
summary_fmt:
        .asciz "Summary:\n"


/* gettranslation(dp, buff)
   Extract first and third characters.
   Store them in dp->inchar and dp->outchar.
   Return 1.
*/

        .text
        .align 2
        .global gettranslation

gettranslation:
        push {r4, r5, r6, lr}

        mov r4, r0              @ r4 = dp
        mov r5, r1              @ r5 = buff

        @ Get first character

        mov r0, r5
        mov r1, #0
        bl get_byte

        str r0, [r4, #_inchar]

        @ Get third character

        mov r0, r5
        mov r1, #2
        bl get_byte

        str r0, [r4, #_outchar]

        @ Return 1

        mov r0, #1

        pop {r4, r5, r6, pc}


/* translate(dp, buff)
   Replace first character of buff with '*'.
   Return buff.
*/

        .text
        .align 2
        .global translate

translate:
        push {r4, lr}

        mov r4, r1              @ Save buff pointer

        @ put_byte(buff, 0, '*')

        mov r0, r4
        mov r1, #0
        mov r2, #'*'
        bl put_byte

        @ Return buff

        mov r0, r4

        pop {r4, pc}


/* print_summary(dp)
   Print summary header only.
*/

        .text
        .align 2
        .global print_summary

print_summary:
        push {r4, lr}

        ldr r0, summaryP
        bl printf

        pop {r4, pc}


/* Main program */
        .text
        .align 2
        .global main

main:
        push {fp, lr}
        add fp, sp, #4

        push {r4, r5}

        @ r4 = address of dat
        @ r5 = address of buff

        ldr r4, datP
        ldr r5, buffP


        @ Read first input line

        mov r0, r5
        mov r1, #256
        bl get_line


        @ Call gettranslation(dp, buff)

        mov r0, r4
        mov r1, r5
        bl gettranslation


        @ Print inchar and outchar

        ldr r0, char_fmtP
        ldr r1, [r4, #_inchar]
        ldr r2, [r4, #_outchar]
        bl printf


        @ Read second input line

        mov r0, r5
        mov r1, #256
        bl get_line


        @ Call translate(dp, buff)

        mov r0, r4
        mov r1, r5
        bl translate


        @ Print translated line

        mov r1, r0
        ldr r0, str_fmtP
        bl printf


        @ Call print_summary(dp)

        mov r0, r4
        bl print_summary


        @ Return 0

        mov r0, #0

        pop {r4, r5}
        sub sp, fp, #4
        pop {fp, pc}


/* Pointer variables */
        .align 2

datP:
        .word dat

buffP:
        .word buff

char_fmtP:
        .word char_fmt

str_fmtP:
        .word str_fmt

summaryP:
        .word summary_fmt
