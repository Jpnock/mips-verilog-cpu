# Expect: 0xBFC00008

.text
.globl main
main: 
    bltzal $v0, L1
    addu $v0, $v0, $ra
L1: jr $zero
