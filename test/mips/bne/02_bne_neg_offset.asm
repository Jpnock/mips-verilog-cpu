# Expect: 0x132D2

.text
.globl main
main:   
    addiu    $v0, $v0, 0x9559
    li		 $v1, 0x9559
    beq      $v0, $v1, L2
     
L1: 
    addiu    $v0, $v0, 0xA		
    addiu    $v0, $v0, 0x816
    li       $v1, 0x5137
    bne	     $v0, $v1, main
    
L2:
    jr       $zero
