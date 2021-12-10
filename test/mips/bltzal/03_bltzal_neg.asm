# Expect: 0x002123A6

.text
.globl main
main:   
    addi    $v0, $v0, 0x47A3
    

L1: 
    addi    $v0, $v0, 0x000F
    addi    $v0, $v0, 0x6400
    bltzal	$v0, main
    jr      $zero


