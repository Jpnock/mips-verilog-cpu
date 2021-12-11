# Expect: 0x00266593

.text
.globl main
main: 
    lw      $v0, var1        
    bne		$v0, $v1, L1
    jr      $zero
L1:
    addiu	$v0, $v0, var2
    bne		$v0, $v1, L2
    addiu	$v0, $v0, var3
    jr      $zero
L2:
    lw      $v0, var3
    jr      $zero

.data

var1: .word 0xF0002345
var2: .word 0x0001
var3: .word 0x00266593
