# Expect: 0xFFFECABD

.text
.globl main
main:
    lw		$v0,  0xD957AC1F
    lw		$t0,  0x00001101
    srlv    $v0, $v0, $t0
    jr      $zero	
