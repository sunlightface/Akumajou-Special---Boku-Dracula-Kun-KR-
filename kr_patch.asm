.nes2
.mapper 23
.submapper 2
.open "Akumajou Special - Boku Dracula Kun (J)_expanded.nes", "Akumajou Special - Boku Dracula Kun (KR).nes"
.prg

.include "script_kr.asm"

.bank $0E, $8000
.include "prg_groups.asm"

.include "hook/bank_4.asm"
.include "hook/bank_5.asm"
.include "hook/bank_7.asm"
.include "hook/bank_b.asm"
.include "hook/bank_1e.asm"
.include "hook/bank_1f.asm"
.include "code_cave/bank_10.asm"

.bank $01, $A000
.org $B18D
.incbin "32_chr_rom_map.bin"

.chr

.bank $27
.incbin "27_chr_rom.bin"

.bank $28
.incbin "28_chr_rom.bin"

.bank $32
.incbin "32_chr_rom.bin"

.bank $3C
.incbin "3C_chr_rom.bin"

.bank $36
.incbin "36_chr_rom.bin"

.bank $38
.incbin "38_chr_rom.bin"

.bank $41
.incbin "41_chr_rom.bin"

.bank $42
.incbin "42_chr_rom.bin"

.bank $45
.incbin "45_chr_rom.bin"

.bank $46
.incbin "46_chr_rom.bin"

.bank $7D
.incbin "7D_chr_rom.bin"

.bank $BA
.incbin "BA_chr_rom.bin"

.bank $BB
.incbin "BB_chr_rom.bin"

.include "chr_groups.asm"

.close
