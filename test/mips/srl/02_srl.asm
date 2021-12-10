# Expect: 0x003592D1

.text
.globl main
main:
    lw		$v0,  0x1AC968F1
    srl		$v0, $v0, 0x111
    jr      $zero	
