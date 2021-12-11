# Expect: 0x0000468A

.text
.globl main
main: 
    addiu	$v0, $v0, 0x2345   
    addiu	$v1, $v1, 0x2345   
    beq		$v0, $v1, L1
    addiu	$v0, $v0, 0x2345       
    addiu	$v0, $v0, 0x2345 
    jr		$zero				

L1: 
    addiu	$v0, $v0, 0x2345
    jr		$zero
