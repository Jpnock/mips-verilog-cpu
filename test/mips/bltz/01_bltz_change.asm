#Expect: 0x0F000000

.text
.globl main
main: 
    lw      $v0, var1   
    bgez	$v0, L1

L1: 
    lw      $v0, var2
    bltz	$v0, L2
    subi	$v0, $v0, var3
    bltz    bgez	$v0, L2
    lw      $v0, var4
    

L2: 
    lw      $v0, var3
    bltz	$v0, main

.data
var1: .word 0xF0003452
var2: .word 0x00000000
var3: .word 0x0F000000
var4: .word 0x35829502