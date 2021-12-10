# Expect: 0x0

.text
.globl main
main:
    la		$v0,  0x1AC968F1
    srl		$v0, $v0, 0x11111
    jr      $zero	
