# Expect: 0x5671

.text
.globl main
main:
    la		$v0,  0x5671AC00
    srl		$v0, $v0, 0x10
    jr      $zero		
