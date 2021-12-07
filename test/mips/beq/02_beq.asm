# Expect: 0x00003F11

.text
.globl main
main: 
    addi	$v0, $v0, 0x1957 
    addi	$v1, $v1, 0x0275   
    beq		$v0, $v1, L1
    addi	$v0, $v0, 0x0275  
    addi	$v0, $v0, 0x2345       
    jr		$zero				

L1: 
    addi	$v0, $v0, 0x1345
    jr		$zero
