/* stage1.s - Project Stage 1, Part B */

/* Data structure */
        .data
        .align 2

dat:
        .word 0                 @ inchar: character to be replaced
        .word 0                 @ outchar: replacement character
        .word 0                 @ charct: character count
        .word 0                 @ wordct: word count
        .word 0                 @ linect: line count

/* Offsets for accessing members of dat */
_inchar = 0
_outchar = 4
_charct = 8
_wordct = 12
_linect = 16


/* Input buffer */
        .align 2
buff:
        .space 256              @ Reserve 256 bytes for input text


/* Format strings */
        .section .rodata
        .align 2

char_fmt:
        .asciz "%c%c\n"         @ Print inchar and outchar

        .align 2
str_fmt:
        .asciz "%s"             @ Print a string

        .align 2
summary_fmt:
        .asciz "Summary:\n"     @ Print summary header
        .align 2
count_fmt:
        .asciz "  %d characters\n"


/* ============================================================
   gettranslation(dp, buff)

   Arguments:
       r0 = dp, pointer to data structure dat
       r1 = buff, pointer to input buffer

   Function:
       Extract the first and third characters from buff.
       Store them in dp->inchar and dp->outchar.

   Return:
       1 (success)
   ============================================================ */

        .text
        .align 2

gettranslation:
        push {fp, lr}           
        add fp, sp, #4          
                                
        push {r4, r5, r6, r7}   @ Save registers (4 registers maintain alignment)

        mov r4, r0              @ r4 = address of dat
        mov r5, r1              @ r5 = address of input string / buff

        /* Get first character of buff */

        mov r0, r5              @ First arg - buff
        mov r1, #0              @ Second argument - index 0
        bl get_byte             @ Read buff[0], return character in r0
	
	cmp r0, #0		@ is it null byte
	beq invalid_translation @ if yes, error
	
        str r0, [r4, #_inchar]  @ Store character in dp->inchar

	@ Verify that the second character is a space character
        mov r0, r5		@ buff
        mov r1, #1		@ index 1
        bl get_byte		@read buff[1]

        cmp r0, #' '		@ is space?
        bne invalid_translation	@ if yes, error

        /* Get third character of buff */
        mov r0, r5              @ buff
        mov r1, #2              @ index 2
        bl get_byte             @ read buff [2]

	cmp r0, #0		@ is buff[2] a nullbyte?
	beq invalid_translation @ if yes, error

        str r0, [r4, #_outchar] @ Store character in dp->outchar

	@ Verify that the fourth character is a newline
        mov r0, r5 		@ buff
        mov r1, #3		@ index 3
        bl get_byte		@ read buff[3]

        cmp r0, #10             @ is it newline?
        bne invalid_translation @ if yes, error

	@ Verify that the input ends after the newline
        mov r0, r5		@ buff
        mov r1, #4		@ index 4
        bl get_byte		@ read buff[4]

        cmp r0, #0		@ is it not null byte?
        bne invalid_translation @ if yes, error

        /* Success - Return 1 */

        mov r0, #1              @ Return value = 1 (success)
	b gettranslation_end	@ skip error
	
invalid_translation:
	mov r0, #0

gettranslation_end:
        pop {r4, r5, r6, r7}    
        sub sp, fp, #4          
        pop {fp, pc}            

/* ============================================================
   translate(dp, buff)

   Arguments:
       r0 = dp, pointer to data structure dat
       r1 = buff, pointer to input buffer

   Function:
       Replace the first character of buff with '*'.

   Return:
       Address of buff (modified string)
   ============================================================ */

        .text
        .align 2

translate:
        push {fp, lr}           
        add fp, sp, #4          
        sub sp, sp, #8          @ Allocate space for indx and alignment
	push {r4, r5, r6, r7}   @ Save registers and maintain stack alignment
	mov r4, r0              @ r4 = pointer to dat
        mov r7, r1              @ r7 = pointer to buff
        ldr r5, [r4, #_inchar]  @ r5 = character to replace
        ldr r6, [r4, #_outchar] @ r6 = replacement character
        @ Initialize index to the first character
        mov r0, #0
        str r0, [fp, #-8]

translate_loop:
        @ Read character at current index
        mov r0, r7
        ldr r1, [fp, #-8]
        bl get_byte

        @ Stop when reaching null terminator
        cmp r0, #0
        beq translate_end

        @ Check whether the character matches inchar
        cmp r0, r5
        bne translate_next

        @ Replace the matching character with outchar
        mov r0, r7
        ldr r1, [fp, #-8]

        mov r2, r6
        bl put_byte

translate_next:
        @ Increment the total character count
        ldr r0, [r4, #_charct]
        add r0, r0, #1
        str r0, [r4, #_charct]

        @ Advance to the next character
        ldr r0, [fp, #-8]
        add r0, r0, #1
        str r0, [fp, #-8]

        b translate_loop	
        
	mov r0, r4              @ First argument: buff
        mov r1, #0              @ Second argument: index 0
        mov r2, #'*'            @ Third argument: replacement character '*'
        bl put_byte             @ Replace buff[0] with '*'

        /* Return buff */
translate_end:
        @ Return the address of the translated buffer
        mov r0, r7              @ Return address of modified buffer

        pop {r4, r5, r6, r7}            @ Restore saved registers
        sub sp, fp, #4          @ Tear down stack frame
        pop {fp, pc}            @ Restore fp and return to caller


/* ============================================================
   print_summary(dp)

   Arguments:
       r0 = dp, pointer to data structure dat

   Function:
       Print the summary header.
       Character, word, and line counts will be added later.
   ============================================================ */

        .text
        .align 2

print_summary:
        push {fp, lr}           
        add fp, sp, #4         
	
	push {r4, r5}
	mov r4, r0              @ Save pointer to dat

        @ Print summary header
        ldr r0, summaryP
        bl printf

        @ Print character count
        ldr r0, count_fmtP
        ldr r1, [r4, #_charct]
        bl printf	
       
	pop {r4, r5}
        sub sp, fp, #4          @ Tear down stack frame
        pop {fp, pc}            @ Restore fp and return to caller


/* ============================================================
   main()

   Function:
       1. Read translation characters.
       2. Call gettranslation().
       3. Print the translation characters.
       4. Read a second line of text.
       5. Call translate().
       6. Print modified text.
       7. Call print_summary().
   ============================================================ */

        .text
        .align 2
        .global main

main:
        push {fp, lr}           @ Save frame pointer and return address
        add fp, sp, #4          @ Set up stack frame
                                @ No local variables; no stack space needed

        push {r4, r5}           @ Save registers used by main

        /* Initialize pointers */

        @ r4 holds dp, the address of dat
        @ r5 holds the address of buff

        ldr r4, datP            @ r4 = address of data structure dat
        ldr r5, buffP           @ r5 = address of input buffer buff


        /* Read first input line (translation rule) */

        mov r0, r5              @ First argument: buff
        mov r1, #256            @ Second argument: buffer size
        bl get_line             @ Read input into buff


        /* Call gettranslation(dp, buff) */

        mov r0, r4              @ First argument: dp
        mov r1, r5              @ Second argument: buff
        bl gettranslation       @ Extract and store translation characters
	
	@ Exit if the translation rule is invalid
        cmp r0, #0
        beq main_end

        /* Read second input line (text to translate) */

        mov r0, r5              @ First argument: buff
        mov r1, #256            @ Second argument: buffer size
        bl get_line             @ Read new input into buff


        /* Call translate(dp, buff) */

        mov r0, r4              @ First argument: dp
        mov r1, r5              @ Second argument: buff
        bl translate            @ Replace first character with '*'


        /* Print modified string */

        mov r1, r0              @ Second argument: modified buff
        ldr r0, str_fmtP        @ First argument: format string "%s"
        bl printf               @ Print modified text


        /* Call print_summary(dp) */

        mov r0, r4              @ First argument: dp
        bl print_summary        @ Print summary header

main_end:
        /* Return 0 from main */
        mov r0, #0              @ Return 0 (successful execution)
        pop {r4, r5}            @ Restore saved registers
        sub sp, fp, #4          @ Tear down stack frame
        pop {fp, pc}            @ Restore fp and return


/* ============================================================
   Pointer variables

   These store addresses of data structures, buffers,
   and format strings so they can be loaded into registers.
   ============================================================ */

        .align 2

datP:
        .word dat               @ Pointer to data structure dat

buffP:
        .word buff              @ Pointer to input buffer

char_fmtP:
        .word char_fmt          @ Pointer to character format string

str_fmtP:
        .word str_fmt           @ Pointer to string format

summaryP:
        .word summary_fmt       @ Pointer to summary header

count_fmtP: 
	.word count_fmt
