# Expect: 0x2B55

.text
.globl main
main:   
    addi    $v0, $v0, 0x47A3
    

L1: 
    addi    $v0, $v0, 0x000F
    la		$t0, -0x6400		
    addu    $v0, $v0, $t0
    bltzal	$v0, main
    jr      $zero


