# Expect: 0x00009957
.text
.globl main
main: 
    addiu	$v0, $v0, 0x1957 
    addiu	$v1, $v1, 0x1957  
    beq		$v0, $v1, L1
    addiu	$v0, $v0, 0x0275  
    addiu	$v0, $v0, 0x2345       
    jr		$zero				

L1: 
    addiu	$v0, $v0, 0x7FFF
    addiu	$v0, $v0, 0x1
    jr		$zero
