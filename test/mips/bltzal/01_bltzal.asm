# Expect: 0x0000CF03

.text
.globl main
main: 
    lw      $v0, var1   
    bltzal	$v0, L1
    addi    $v0, $v0, var4
    jr		$zero	

L1: 
    addi    $v0, $v0, var2
    addi    $v0, $v0, var3
    jr		$zero	


.data
var1: .word 0xF0002351
var2: .word 0x000F
var3: .word 0x6400
var4: .word 0x47A3
