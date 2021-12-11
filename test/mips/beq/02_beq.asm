# Expect: 0x00003F11

.text
.globl main
main: 
    addiu	$v0, $v0, 0x1957 
    addiu	$v1, $v1, 0x0275   
    beq		$v0, $v1, L1
    addiu	$v0, $v0, 0x0275  
    addiu	$v0, $v0, 0x2345       
    jr		$zero				

L1: 
    addiu	$v0, $v0, 0x1345
    jr		$zero
