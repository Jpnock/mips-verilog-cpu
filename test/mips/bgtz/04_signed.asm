# Expect: 0x00001234

.text
.globl main
main: 
    li $t1, 0x80000000
    bgtz $t1, incorrect
    addiu $v0, $v0, 0x1234
    jr $zero
incorrect: 
    jr $zero
