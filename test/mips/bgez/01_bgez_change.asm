#Expect: 0xF0000000

.text
.globl main
main: 
    lw      $v0, var1   
    bgez	$v0, L1

L1: 
    addi    $v0, $v0, var2
    bgez	$v0, L2

L2: 
    lw      $v0, var3
    bgez	$v0, main

.data
var1: .word 0x00000000
var2: .word 0x0000000F
var3: .word 0xF0000000