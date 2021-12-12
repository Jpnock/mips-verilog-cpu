# Expect: 0xFFFECABD

.text
.globl main
main:
    li		$v0,  0xD957AC1F
    li		$t0,  13
    srav    $v0, $v0, $t0
    jr      $zero	
