# Expect: 0xFF00427A

.text
.globl main
main:   
    addi    $v0, $v0, 0x2137	
    la      $t1, 0xFF00427A
    beq     $v0, $t1, L3
    
L1: 
    addi    $v0, $v0, 0xC	
    la      $t0, 0xFF000000
    addu    $v0, $v0, $t0
    blez	$v0, main

L3:
    jr      $zero
