# Expect: 0x132D2

.text
.globl main
main:   
    addi    $v0, $v0, 0x9559
    la		$t1, -0x9561	
    addu    $t1, $t1, $v0
    bgtz    $t1, L3
    
L1: 
    addi    $v0, $v0, 0xA		
    addi    $v0, $v0, 0x816
    bne	    $v0, main
    

L3:
    jr      $zero

