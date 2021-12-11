# Expect: 0x1F8B

.text
.globl main
main:   
    addiu    $v0, $v0, 0x0FC0
    li      $t1, 0x1F8B
    beq     $v0, $t1, L3

   
L1: 
    addiu   $v0, $v0, 0xB
    bgtz	$v0, main
    

L3:
    jr      $zero

