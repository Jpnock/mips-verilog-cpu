# Expect: 0xD64

.text
.globl main
main:
    la		$v0,  0x1AC968F1
    srl		$v0, $v0, 17
    jr      $zero	
