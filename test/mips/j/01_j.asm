#Expect: 0x0075A91F

.text
.globl main
main: 
    addi    $v0, $v0, var1   
    j	    L1

L1: 
    addi    $v0, $v0, var2


.data
var1: .word 0x0075A910
var2: .word 0x0000000F
