# Expect: 0x159C6B00

.text
.globl main
main:
    lw		$v0,  0x5671AC00
    srl		$v0, $v0, 0x10
    jr      $zero		
