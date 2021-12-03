# Expect: 0x0000468A

.text
.globl main
main: 
    addi	$v0, $v0, var1        
    lw	    $v1, $v1, var2
    beq		$v0, $v1, main	

.data

var1: .word 0x00002345
var2: .word 0x00002345
