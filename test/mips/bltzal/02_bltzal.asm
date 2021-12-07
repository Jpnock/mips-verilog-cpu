# Expect: 0xC

.text
.globl main
main: 
    lw      $v0, var1   
    addi    $v0, $v0, 0x47A3
    bltzal	$v0, L1
    lw		$v0, 32($ra)
    jr		$zero	


L1: 
    addi    $v0, $ra, 0x0
    addi    $v0, $v0, 0x000F
    addi    $v0, $v0, 0x6400
    jr      $ra

.data
var1: .word 0x00002351