# Expect: 0x8164DAC2

.text
.globl main

main:
    la      $v1, 0x8164DAC2
    bne     $v0, $v1, L1
    la      $v0, 0x8164DAC2
    bne     $v0, L1
    jr		$zero

L1:
    addi	$v0, $v0, 0x9174	
    jr		$zero		
