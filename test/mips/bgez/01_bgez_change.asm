# Expect: 0xF0000000

.text
.globl main
main: 
    lw      $v0, var1   
    bgez	$v0, L1
    jr		$zero	

L1: 
    addiu   $v0, $v0, var2
    bgez	$v0, L2
    jr		$zero	

L2: 
    lw      $v0, var3
    bgez	$v0, main
    jr		$zero	

.data
var1: .word 0x00000000
var2: .word 0x000F
var3: .word 0xF0000000
