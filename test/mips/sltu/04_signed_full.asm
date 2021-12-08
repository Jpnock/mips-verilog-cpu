# Expect: 0x00000000

.text
.globl main
main: 
    lw $t1, large
    lw $t0, small
    #sltu $v0, $t1, $t0 # will break if signed compare is used
    jr $zero


.data
large: .word 0xFFFFFFFF
small: .word 0x0000000F