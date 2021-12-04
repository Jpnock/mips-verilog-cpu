# Expect: 0x0334AF70

.text
.globl main
main: 
    lw      $v0, var1   
    blez	$v0, L1
    jr		$zero	

L1: 
    addi    $v0, $v0, var3
    blez	$v0, L2
    jr		$zero	

L2: 
    lw      $v0, var2
    blez	$v0, main
    jr		$zero	

.data
var1: .word 0x00000000
var2: .word 0x0334AF70
var3: .word 0xF0000000
