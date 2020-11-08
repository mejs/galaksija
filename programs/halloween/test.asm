include "galaksija.inc"

	org g_user_mem
		
	jp start
	
msg:	db "TEST PUMPKIN!\r"

start:		
        ld hl,g_video_mem

        ld hl,banner
        add hl,bc
        ld a,8


banner: 
include "pumpkin-full.inc"
