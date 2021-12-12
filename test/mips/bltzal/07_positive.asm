# Expect: 0x00001234

.text
.globl main
main: 
    addiu $t1, $zero, 1
    bltzal $t1, incorrect
    addiu $v0, $v0, 0x1234
    jr $zero
incorrect:
    jr $zero
