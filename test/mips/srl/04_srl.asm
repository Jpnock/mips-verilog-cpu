# Expect: 0x1

.text
.globl main
main:
    la		$v0,  0xFFF164AC
    srl		$v0, $v0, 31
    jr      $zero	
