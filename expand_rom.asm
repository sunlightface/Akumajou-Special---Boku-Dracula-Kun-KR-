.create "Akumajou Special - Boku Dracula Kun (J)_expanded.nes", 0

.nes2
.mapper 23
.submapper 2

.prgrom 0x40000
.chrrom 0x40000

.prgram 0
.prgnvram 0
.chrram 0
.chrnvram 0

.mirroring horizontal
.timing ntsc

.prg

.bank 0x00, 0x8000
.incbin "Akumajou Special - Boku Dracula Kun (J).nes", 0x000010, 0x01C000

.bank 0x1E, 0xC000
.incbin "Akumajou Special - Boku Dracula Kun (J).nes", 0x01C010, 0x004000

.chr

.bank 0x00, 0x0000
.incbin "Akumajou Special - Boku Dracula Kun (J).nes", 0x020010, 0x020000

.close