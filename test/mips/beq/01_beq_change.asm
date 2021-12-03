# Expect: 0x0000468A

.text
.globl main
main: 
    addi	$v0, $v0, var1   
    addi	$v1, $v1, var1   
    beq		$v0, $v1, L1
    addi	$v0, $v0, var1       
    addi	$v0, $v0, var1 
    jr		$zero				
    
    

L1: 
    addi	$v0, $v0, var1
    jr		$zero	
.data

var1: .word 0x00002345
