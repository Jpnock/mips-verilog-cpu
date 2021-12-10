# Expect: 0xBFC00005

.text
.globl main
main: 
    lw      $v0, var1   
    addi    $v0, $v0, 0x1
    bgezal	$v0, L1
    addu    $v0, $v0, $ra
    jr		$zero	

L1: 
    addi    $v0, $v0, 0x000F
    addi    $v0, $v0, 0x6400
    jr      $ra

.data
var1: .word -0x12