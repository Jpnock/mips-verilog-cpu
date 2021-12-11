# Expect: 0x0

.text
.globl main
main:
    la		$v0,  0x18472DFC
    srl		$v0, $v0, 31
    jr      $zero	
