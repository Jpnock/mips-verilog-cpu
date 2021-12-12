# Expect: 0x14

.text
.globl main
main:
    li $t1, 0xFF00001F
    andi $v0, $t1, 0xFF14
    jr $zero
