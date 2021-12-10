# Expect: 0xABB2

.text
.globl main
main:   
    addiu    $v0, $v0, 0x47A3
    li		$t1, -0x47A4	
    addu    $t1, $t1, $v0
    bgtz    $t1, L3
    
    

L1: 
    addiu    $v0, $v0, 0x000F		
    addiu    $v0, $v0, 0x6400
    bltzal	$v0, main
    jr      $zero

L3:
    jr      $ra

