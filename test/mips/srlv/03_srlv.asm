# Expect: 0x0

.text
.globl main
main:
    la		$v0,  0x9175FAC1
    la		$t0,  0x00011111
    srlv    $v0, $v0, $t0
    jr      $zero	
