# Expect: 0x3817FF05

.text
.globl main
main: 
    lw      $v0, var1   
    blez	$v0, L1
    lw	    $v0, var3
    blez   	$v0, L2
    lw      $v0, var5 
    blez	$v0, L2
    jr		$zero	

L1: 
    lw      $v0, var2
    blez	$v0, L2
    lw	    $v0, var3
    blez   	$v0, L2
    lw      $v0, var4
    jr		$zero	
    

L2: 
    lw      $v0, var4
    jr		$zero	

.data
var1: .word 0x00A57DC2
var2: .word 0xEF000000
var3: .word 0x00000000
var4: .word 0x3817FF05
var5: .word 0x0817FF05
