# Expect: 0x2f61

.text
.globl main
main:   
    addi    $v0, $v0, 0xFCB
    la      $t1, 0x2f61
    beq     $v0, $t1, L3
    
L1: 
    addi    $v0, $v0, 0xFCB
    bgez	$v0, main
    

L3:
    jr      $zero