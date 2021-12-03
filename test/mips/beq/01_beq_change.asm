# Expect: 0x0000468A

.text
.globl main
main: 
    addi	$v0, $v0, var1        
    beq		$v0,  L1

L1: 
    addi	$v0, $v0, var1

.data

var1: .word 0x00002345
