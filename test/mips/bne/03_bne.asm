# Expect: 0x9174

.text
.globl main

main:
    li      $v1, 0x8164DAC2
    bne     $v0, $v1, L1
    li      $v0, 0x8164DAC2
    bne     $v0, $v1, L1
    jr		$zero

L1:
    addiu	$v0, $v0, 0x9174	
    jr		$zero		
