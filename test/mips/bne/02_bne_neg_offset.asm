# Expect: 0x132D2

.text
.globl main
main:   
    addiu    $v0, $v0, 0x9559
    li		 $t1, 0x132d2	
    beq      $v0, $t1, L3
     
L1: 
    addiu    $v0, $v0, 0xA		
    addiu    $v0, $v0, 0x816
    li       $v1, 0x9D79
    bne	     $v0, $v1, main
    

L3:
    jr       $zero
