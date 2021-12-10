# Expect: 0xFF00427A

.text
.globl main
main:   
    addiu    $v0, $v0, 0x2137	
    li      $t1, 0xFF00427A
    beq     $v0, $t1, L3
    
L1: 
    addiu    $v0, $v0, 0xC	
    li      $t0, 0xFF000000
    addu    $v0, $v0, $t0
    blez	$v0, main

L3:
    jr      $zero
