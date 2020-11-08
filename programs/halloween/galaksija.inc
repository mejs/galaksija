; *****************************************************************************
; Memory areas

g_roma_base:	equ	0x0000		; start of the ROM A area
					; (length 4096 bytes)

g_romb_base:	equ	0x1000		; start of the ROM B area
					; (length 4096 bytes)

g_kbd_base:	equ	0x2000		; keyboard base address (56 bytes)

g_latch_base:	equ	0x2038		; latch base address (1 byte)

g_user_mem:	equ	0x2c3a		; start of the user memory area
					; usually BASIC program starts here

g_video_mem:	equ	0x2800		; start of the video memory area
					; (length 512 bytes)

; *****************************************************************************
; ROM functions

g_rnd_f:	equ	0x0c8f		; generates a pseudo-random number
					; end writes it to memory location
					; pointed by IX

g_printstr_f:	equ	0x0937		; prints a string pointed by DE
					; to the screen at current
					; cursor location.

					; string must be terminated with
					; 0x00 (NUL) or 0x0d (CR)

g_print_word_f:	equ	0x08ed		; prints a 16-bit number pointed
					; by DE to the screen at the current
					; cursor location.
			

g_find_line:	equ	0x07f2		; finds a BASIC line with number 
					; equal or greater than HL.

					; Pointer to the line is returned in 
					; DE. If Cf is set, line was not found.
					; If Zf is set, line number is equal
					; to HL.

g_putchr_rst_f:	equ	0x0020		; prints a character in A to the 
					; screen at current cursor location.

					; special characters recognized:
					;   0x0d (CR) start a new line
					;   0x0c (FF) clears screen
					;   0x1d (GS) backspace

; *****************************************************************************
; BASIC interpreter

g_y_str:	equ	0x2a80		; BASIC string Y$ (16 bytes)

; *****************************************************************************
; System variables

; Two-byte values are little-endian.

g_basic_var:	equ	0x2a00		; base address for BASIC variables
					; from A to Z (4 * 26 bytes)

g_cursor_pos:	equ	0x2a68		; memory address (inside video
					; memory block) of the current
					; cursor position (2 bytes)

g_ram_top:	equ	0x2a6a		; last address in RAM + 1
					; detected at boot (2 bytes)

g_window_len:	equ	0x2a6c		; length (in characters) of a static 
					; area on the top of the screen that
					; does not scroll (2 bytes).

g_array_len:	equ	0x2a99		; length of the BASIC array at the
					; top of RAM (2 bytes).

g_next_var:	equ	0x2a9b		; pointer to the variable for the
					; BASIC "for" loop (2 bytes).

g_basic_line:	equ	0x2a9f		; address of the current BASIC line.
					; (2 bytes)

g_key_diff:	equ	0x2aa5		; Codes of keys that were last seen
					; pressed are stored in these two
					; bytes. (2 bytes)

g_rnd_seed:	equ	0x2aa7		; seed for the pseudo-random generator
					; (3 bytes) FIXME: 5 bytes maybe?

g_arithm_stack:	equ	0x2aac		; arithmetic stack
					; (252 bytes)

g_horiz_pos:	equ	0x2ba8		; horizontal position of display
					; default 11 (1 byte)

g_basic_link:	equ	0x2ba9		; a call to this address is executed
					; when recognizing BASIC commands.
					; (default value returns immediately)
					; (3 bytes)

g_video_link:	equ	0x2bac		; each time a character is printed
					; to the screen a call to this
					; address is executed with the
					; character to be printed in A
					; (default value returns immediately)
					; (3 bytes)

g_clock_on:	equ	0x2baf		; real-time clock enable (1 byte)

					; setting the MSB bit will enable
					; a real-time clock in BASIC 
					; string Y$

g_scroll_cnt:	equ	0x2bb0		; soft scroll counter (1 byte)

g_scroll_flag:	equ	0x2bb1		; soft scroll flag (1 byte)

g_last_key:	equ	0x2bb4		; code of the last key pressed (1 byte)

g_input_buffer:	equ	0x2bb6		; input buffer for command line	
					; and BASIC interpreter (128 bytes)

g_basic_start:	equ	0x2c36		; address of the first byte of the
					; BASIC program (2 bytes)

g_basic_end:	equ	0x2c38		; address of the last byte of the
					; BASIC program + 1 (2 bytes)

; Layout of Galaksija BASIC program in memory
;
; AA AA BB BB .. BB 0D AA AA BB BB .. 0D
; ^                                      ^ 
; |                                      |
; g_basic_start                          g_basic_end
;
; AA AA : Line number (two bytes)
; BB BB : Line contents in ASCII


