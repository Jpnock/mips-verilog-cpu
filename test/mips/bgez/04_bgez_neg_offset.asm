# Expect: 0x2f61

.text
.globl main
main:   
    addiu   $v0, $v0, 0xFCB
    la      $t1, 0x2f61
    beq     $v0, $t1, L3
    
L1: 
    addiu   $v0, $v0, 0xFCB
    bgez	$v0, main
    

L3:
    jr      $zero

