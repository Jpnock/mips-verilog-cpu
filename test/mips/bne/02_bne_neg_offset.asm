# Expect: 0x132D2

.text
.globl main
main:   
    addi    $v0, $v0, 0x9559
    li		$t1, -0x9561	
    addu    $t1, $t1, $v0
    bgtz    $t1, L3
    
L1: 
    addi    $v0, $v0, 0xA		
    addi    $v0, $v0, 0x816
    li      $v1, 0x9D79
    bne	    $v0, $v1, main
    

L3:
    jr      $zero

