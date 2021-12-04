# Expect: 0xFFFFA91F

.text
.globl main
main: 
    addi    $v0, $v0, 0xA910   
    j	    L1
    jr      $zero

L1: 
    addi    $v0, $v0, 0x0000F
    jr      $zero
