# Expect: 0xffff2d81

.text
.globl main
main:   
    addiu    $v0, $v0, 0x8164
    li      $t0, 0x0001aee5
    beq     $v0, $t0, L3
    
L1: 
    addiu    $v0, $v0, 0xAC1D
    li      $t1, 0x00012D81
    beq 	$v0, $t1, main
    

L3:
    jr      $zero