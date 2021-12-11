# Expect: 0x35829502

.text
.globl main
main: 
    lw      $v0, var1   
    bgtz	$v0, L1
    jr		$zero	

L1: 
    lw      $v0, var2
    bgtz	$v0, L2
    lw	    $v0, var3
    bgtz   	$v0, L2
    lw      $v0, var4
    jr		$zero	
    

L2: 
    lw      $v0, var3
    bgtz	$v0, main
    jr		$zero	

.data
var1: .word 0x00003452
var2: .word 0x00000000
var3: .word 0xF0000000
var4: .word 0x35829502
