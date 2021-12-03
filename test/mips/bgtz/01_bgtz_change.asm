# Expect: 0x35829502

.text
.globl main
main: 
    lw      $v0, var1   
    bgtz	$v0, L1

L1: 
    lw      $v0, var2
    bgtz	$v0, L2
    subi	$v0, $v0, var3
    bgtz    bgez	$v0, L2
    lw      $v0, var4
    

L2: 
    lw      $v0, var3
    bgtz	$v0, main

.data
var1: .word 0x00003452
var2: .word 0x00000000
var3: .word 0xF0000000
var4: .word 0x35829502
