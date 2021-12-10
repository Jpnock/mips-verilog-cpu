# Expect: 0x1aee5

.text
.globl main
main:   
    addi    $v0, $v0, 0x8164
    la      $t0, 0x1aee5
    beq     $v0, $t1, L3
    
L1: 
    addi    $v0, $v0, 0xAC1D
    la      $t1, 0x12D81
    beq 	$v0, main
    

L3:
    jr      $zero