# Expect: 0x00002345

.text
.globl main
main: 
    beq		$v0,  L1
    addi	$v0, $v0, var1        
    

L1: 
    addi	$v0, $v0, var1

.data

var1: .word 0x00002345
