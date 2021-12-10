# Expect: 0x002123A6

.text
.globl main
main: 
    lw      $v0, var1   
    addiu    $v0, $v0, 0x47A3
    bltzal	$v0, L1
    jr		$zero	

L1: 
    addiu    $v0, $v0, 0x000F
    addiu    $v0, $v0, 0x6400
    jr      $ra

.data
var1: .word 0x0020DC03
