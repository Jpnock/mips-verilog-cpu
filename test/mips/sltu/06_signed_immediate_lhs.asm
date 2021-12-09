# Expect: 0x00000000

.text
.globl main
main: 
    addiu $t1, $t1, 0x000A  # 10 u, 10 s
    addiu $t0, $t0, 0xFFFF  # 65535 u, -1 s
    sltu $v0, $t0, $t1      # will break if signed compare is used
    jr $zero


