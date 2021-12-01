#Expect: 0x02352A26

.text
.globl main
main: 
    subi	$v0, $v0, var1        
    bne		$v0, $v1, L1

L1:
    addi	$v0, $v0, var1
    bne		$v0, $v1, L2
    addi	$v0, $v0, var2
L2:
    lw      $v0, var3

.data

var1: .word 0x00002345
var2: .word 0x02352A26
var3: .word 0x92736593
