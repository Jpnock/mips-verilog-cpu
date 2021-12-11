# Expect: 0x12D2

.text
.globl main
main:   
    addiu    $v0, $v0, 0x0559
    li		 $t1, 0x12D2
    beq      $v0, $t1, L2
    
L1: 
    addiu    $v0, $v0, 0x000A		
    addiu    $v0, $v0, 0x0816
    li       $v1, 0x5137
    bne	     $v0, $v1, main
    
L2:
    jr       $zero
