# Expect: 0xFE

.text
.globl main
main: 
    lw      $v0, var1   
    bgez	$v0, L1
    jr		$zero	

L1: 
    la      $v0, -0x1
    bgez	$v0, L2
    addiu   $v0, $v0, 0x00FF
    jr		$zero	

L2: 
    lw      $v0, var3
    bgez	$v0, main
    jr		$zero	

.data
var1: .word 0x009785FC
var3: .word 0xF0000000
