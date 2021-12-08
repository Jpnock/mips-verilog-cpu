# Expect: 0x00000000

.text
.globl main
main: 
    lw $v0, overwrite
    lw $t1, large
    lw $t0, small
    sltu $v0, $t1, $t0
    jr $zero

.data
overwrite: .word 0x6FA1F25F
large: .word 0xFFFFFFFF
small: .word 0x0000000F