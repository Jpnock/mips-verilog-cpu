# Expect: 0x00000001

.text
.global main
main: 
    addiu $t1, $t1, 0xA69F
    slti $v0, $t1, 0x000F
    jr $zero
