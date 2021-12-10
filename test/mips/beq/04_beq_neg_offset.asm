# Expect: 0x1aee5

.text
.globl main
main:   
    addiu    $v0, $v0, 0x8164
    li      $t0, 0x1aee5
    beq     $v0, $t0, L3
    
L1: 
    addiu    $v0, $v0, 0xAC1D
    li      $t1, 0x12D81
    beq 	$v0, $t1, main
    

L3:
    jr      $zero