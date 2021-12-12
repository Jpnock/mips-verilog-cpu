# Expect: 0x1234
# Args: -DPC_PLUS_FOUR_REL_TEST -DPC_PLUS_FOUR_REL_TEST_J

.text
.globl main
main:
    # Expect 0xBFC00000-0xFC00004=0xAFFFFFFC to contain J 0x30
    li $t0, 0xAFFFFFFC
    jr $t0
    # NOP sled down to 0x30
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    addiu $v0, $zero, 0x1234
    jr $zero
