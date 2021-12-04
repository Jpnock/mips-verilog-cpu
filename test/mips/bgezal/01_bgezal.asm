# Expect: 0x0000CF03

.text
.globl main
main: 
    lw      $v0, var1  
    addi    $v0, $v0, 0x47A3
    bgezal	$v0, L1
    jr		$zero	


L1: 
    addi    $v0, $v0, 0x000F
    addi    $v0, $v0, 0x6400
    jr      $ra
    


.data
var1: .word 0x00002351
