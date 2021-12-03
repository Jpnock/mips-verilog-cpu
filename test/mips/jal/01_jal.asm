# Expect: 0x042DCF03

.text
.globl main
main: 
    lw      $v0, var1   
    j       L1
    addi    $v0, $v0, var4


L1: 
    addi    $v0, $v0, var2
    addi    $v0, $v0, var3
    


.data
var1: .word 0x00002351
var2: .word 0x0000000F
var3: .word 0x04056400
var4: .word 0x002847A3