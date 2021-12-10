# Expect: 0x1673

.text
.globl main
main:
    bne     $v0, L1
    addi    $v0, $v0, 0x1673
    bne     $v0, L1
    jr		$zero

L1:
    addi	$v0, $v0, 0x9174	
    jr		$zero		
