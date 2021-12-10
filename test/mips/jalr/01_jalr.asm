# Expect: 0x00089098

.text
.globl main
main: 
    lw      $v0, var1  
    addiu   $v0, $v0, 0x15AD
    li		$t1, 0xbfc0001c  
    jalr	$t1
    jr		$zero	

L1: 
    addiu    $v0, $v0, 0x000F
    addiu    $v0, $v0, 0x6400
    jr      $ra
    


.data
var1: .word 0x000816DC
