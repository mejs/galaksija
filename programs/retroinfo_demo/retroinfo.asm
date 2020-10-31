include "galaksija.inc"

	org g_user_mem

	jp main

xpos:	db 200
xvel:	db 1
ypos:	db 0

ycnt:	db 0

; BLIT
; ====

blit:
	; DE = dest address, video mem
	ld hl,g_video_mem

	ld a,(ypos)

	ld bc,32

	and a
blit_vert_pos_loop:
	jr z,blit_vert_pos_loop_end
	add hl,bc
	dec a
	jr blit_vert_pos_loop
blit_vert_pos_loop_end:

	ex de,hl

	; HL = source address, frame
	ld b,0
	ld a,(xpos)
	ld c,a

	ld hl,banner
	add hl,bc

	ld a,8

blit_loop:
	ld c,32
	ldir

	ld c,256-32
	add hl,bc

	dec a
	jr nz,blit_loop

	ret

; MAIN
; ====

main:
end:
	halt

	; clear screen
	ld hl,g_video_mem
	ld b,0
	ld a,0x20
loop1:
	ld (hl),a
	inc hl
	djnz loop1
loop2:
	ld (hl),a
	inc hl
	djnz loop2

	; y movement
	ld hl,sin_table

	ld a,(ycnt)

	ld b,0
	ld c,a

	inc a
	inc a
	ld (ycnt),a

	add hl,bc

	ld a,(hl)
	ld (ypos), a

	inc hl

	ld a,(hl)
	ld (g_scroll_cnt),a

	call blit

	; x movement
	ld a,(xvel)
	ld b,a

	ld a,(xpos)
	add b

	ld (xpos),a

	cp 224
	jr nz,next_1
	ld a,0xff
	ld (xvel),a
	jr next_2
next_1:
	cp 0
	jr nz,next_2
	ld a,1
	ld (xvel),a
next_2:

	jp end


banner:
include "retroinfo-banner.inc"

sin_table:
include "retroinfo-sin.inc"
