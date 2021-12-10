# Expect: 0x1F8B

.text
.globl main
main:   
    addi    $v0, $v0, 0x0FC0
    la      $t1, 0x1F8B
    beq     $v0, $t1, L3
    
L1: 
    addi    $v0, $v0, 0xB
    bgtz	$v0, main
    

L3:
    jr      $zero