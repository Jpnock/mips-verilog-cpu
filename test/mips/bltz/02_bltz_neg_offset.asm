# Expect: 0xffff9559

.text
.globl main
main:   
    addiu    $v0, $v0, 0x9559	
    bltz    $v0, L3
    
L1: 
    addiu    $v0, $v0, 0xA	
    li      $t0, 0xF0000000
    addu    $v0, $v0, $t0
    bltz	$v0, main
    

L3:
    jr      $zero
