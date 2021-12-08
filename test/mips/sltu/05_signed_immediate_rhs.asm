# Expect: 0x00000001

.text
.globl main
main: 
    addiu $t1, $t1, 0xFFFF  # 65535 u, -1 s
    addiu $t0, $t0, 0x000A  # 10 u, 10 s
    sltu $v0, $t0, $t1      # will break if signed compare is used
    jr $zero


