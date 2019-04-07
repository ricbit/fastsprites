; Fast pi calculation
; by Ricardo Bittencourt 2016

        output  sprites.com

        org     0100h

; ----------------------------------------------------------------
; Constants


; ----------------------------------------------------------------
; MSX bios
openmsx_control equ     0002Eh  ; OpenMSX debug control port
openmsx_data    equ     0002Fh  ; OpenMSX debug data port


enemy_data_color equ 0

; ----------------------------------------------------------------
; Initialization.

global_init:
        ld      a, 16 + 4
        out     (openmsx_control), a

        ld      bc, 0
        ld      ix, enemydata

loop:
        push bc
        ld        hl,(xmap)
        ld        de,-32
        add       hl,de
        ld        (tempx),hl
        ld        h, b
        ld        l, c
        ld        a, l
        out       (openmsx_data), a
        ld        a, h
        out       (openmsx_data), a

        or        a
        ;call      original
        call      refac

        out       (openmsx_data), a
        ld        a, l
        out       (openmsx_data), a
        ld        a, e
        out       (openmsx_data), a

        pop bc
        inc bc
        ld  a, b
        or  c
        jr  nz, loop

        jp  0xffff

; ----------------------------------------------------------------

; x - xmap < -32      ; 28 clocks
; -32 <= x - xmap < 0 ; 134 clocks
; 0 <= x - xmap < 256 ; 114 clocks
; x - xmap >= 256     ; 114 clocks 

original:
	ld	de,(tempx)

	sbc hl,de		    ; 17	
	jp	m,invisible	; 11

	ld	de,32       ; 11
	sbc hl,de		    ; 17

	ld	a,(ix+enemy_data_color) ; 21
	jp nc,noec		; 11
	or	128			  ; 8
	add	hl,de		  ; 12
noec:
	ld	e,a       ; 5
	ld	a,h       ; 5
	and a         ; 5
	jp	nz,invisible	; 11
  ; do something
  xor a
  ret
invisible:
  ld a,255
  ld e,0
  ld l,0
  ret
  

; ----------------------------------------------------------------

; x - xmap < -32      ; 28 clocks
; -32 <= x - xmap < 0 ; 109 clocks
; 0 <= x - xmap < 256 ; 125 clocks
; x - xmap >= 256     ; 81 clocks 

refac:
	ld	de,(tempx)

	sbc hl,de		      ; 17	
	jp	c,invisible1	; 11

  ld  a, l ; 5
  sub 32   ; 8
  ld  e, a ; 5 
  ld  a, h ; 5 
  sbc a, 0 ; 8
  jp  c, skip ; 11
  jp  nz, invisible1 ; 11

  ld  l, e ; 5

skip:
  sbc a,a ; 5
  and 128 ; 8
  or (ix+enemy_data_color) ; 21
  ld  e, a ; 5
  ; do something
  xor a
  ret

invisible1:
  ld a,255
  ld e,0
  ld l,0
  ret
  

; ----------------------------------------------------------------

; ----------------------------------------------------------------

xmap dw 12345
tempx dw 0
enemydata db 0xf

vector_r:

        end

