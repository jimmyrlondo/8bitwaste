;This is pretty much copypasta from the nerdy nights week 3 tutorial for us to play with and modify


;==========iNES HEADER===================================

.inesprg 1   ; 1x 16KB bank of PRG code
  .ineschr 1   ; 1x 8KB bank of CHR data
  .inesmap 0   ; mapper 0 = NROM, no bank swapping
  .inesmir 1   ; background mirroring (ignore for now)
  
  ;===========BANKING=====================================
  
    .bank 0
  .org $C000
;some code here

  .bank 1
  .org $E000
; more code here

  .bank 2
  .org $0000
; graphics here

;==============ADDING BINARY FILES=============================

  .bank 2
  .org $0000
  .incbin "mario.chr"   ;includes 8KB graphics file from SMB1
  
  ;==============VECORS==========================================
  
  .bank 1
  .org $FFFA     ;first of the three vectors starts here
  .dw NMI        ;when an NMI happens (once per frame if enabled) the 
                   ;processor will jump to the label NMI:
  .dw RESET      ;when the processor first turns on or is reset, it will jump
                   ;to the label RESET:
  .dw 0          ;external interrupt IRQ is not used in this tutorial

  ;================RESET CODE===================================
  
  .bank 0
  .org $C000
RESET:
  SEI        ; disable IRQs
  CLD        ; disable decimal mode
  
  ;==================COMPLETION===================================
  
  PPUMASK ($2001)

76543210
||||||||
|||||||+- Grayscale (0: normal color; 1: AND all palette entries
|||||||   with 0x30, effectively producing a monochrome display;
|||||||   note that colour emphasis STILL works when this is on!)
||||||+-- Disable background clipping in leftmost 8 pixels of screen
|||||+--- Disable sprite clipping in leftmost 8 pixels of screen
||||+---- Enable background rendering
|||+----- Enable sprite rendering
||+------ Intensify reds (and darken other colors)
|+------- Intensify greens (and darken other colors)
+-------- Intensify blues (and darken other colors)