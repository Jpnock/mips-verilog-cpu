# Expect: 0xABB2

.text
.globl main
main:   
    addi    $v0, $v0, 0x47A3
    la		$t1, -0x47A4	
    addu    $t1, $t1, $v0
    bgtz    $t1, L3
    
    

L1: 
    addi    $v0, $v0, 0x000F		
    addi    $v0, $v0, 0x6400
    bltzal	$v0, main
    jr      $zero

L3:
    jr      $ra

