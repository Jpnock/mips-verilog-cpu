# Expect: 0x1

.text
.globl main
main:
    lw		$v0,  0xFFF164AC
    srl		$v0, $v0, 0x11111
    jr      $zero	
