# Expect: 0x00001234

.text
.globl main
main: 
    li $t1, 0x80000000
    bltzal $t1, correct
    jr $zero
correct:
    addiu $v0, $v0, 0x1234
    jr $zero
