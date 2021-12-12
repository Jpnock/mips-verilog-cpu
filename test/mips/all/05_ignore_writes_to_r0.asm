# Expect: 0x0

.text
.globl main
main:
    addiu $t0, $t0, 1
    la $t1, var1
    addiu $t2, $t2, 2

    addiu $zero, $zero, 1
    or $v0, $v0, $zero

    addu $zero, $zero, $t0
    or $v0, $v0, $zero

    and $zero, $t0, $t0
    or $v0, $v0, $zero

    andi $zero, $t0, 1
    or $v0, $v0, $zero

    div $zero, $t0, $t0
    or $v0, $v0, $zero

    divu $zero, $t0, $t0
    or $v0, $v0, $zero

    divu $zero, $t0, $t0
    or $v0, $v0, $zero

    lb $zero, 3($t1)
    or $v0, $v0, $zero

    lbu $zero, 3($t1)
    or $v0, $v0, $zero

    lh $zero, 2($t1)
    or $v0, $v0, $zero

    lhu $zero, 2($t1)
    or $v0, $v0, $zero

    lui $zero, 1
    or $v0, $v0, $zero

    lw $zero, var1
    or $v0, $v0, $zero

    lwl $zero, 0($t1)
    or $v0, $v0, $zero

    lwr $zero, 3($t1)
    or $v0, $v0, $zero

    mthi $t0
    nop
    nop    
    mfhi $zero
    nop
    nop
    or $v0, $v0, $zero

    mtlo $t0
    nop
    nop
    mflo $zero
    nop
    nop
    or $v0, $v0, $zero

    mult $t0, $t0
    nop
    nop
    mflo $zero
    nop
    nop
    or $v0, $v0, $zero

    multu $t0, $t0
    nop
    nop
    mflo $zero
    nop
    nop    
    or $v0, $v0, $zero

    or $zero, $t0, $t0
    or $v0, $v0, $zero

    ori $zero, $t0, 1
    or $v0, $v0, $zero

    sll $zero, $t0, 0
    or $v0, $v0, $zero

    sllv $zero, $t0, $t3
    or $v0, $v0, $zero

    slt $zero, $t0, $t2
    or $v0, $v0, $zero

    slti $zero, $t0, 2
    or $v0, $v0, $zero

    sltiu $zero, $t0, 2
    or $v0, $v0, $zero

    sltu $zero, $t0, $t2
    or $v0, $v0, $zero

    sra $zero, $t0, 0
    or $v0, $v0, $zero

    srav $zero, $t0, $t3
    or $v0, $v0, $zero

    srl $zero, $t0, 0
    or $v0, $v0, $zero

    srlv $zero, $t0, $t3
    or $v0, $v0, $zero

    subu $zero, $t0, $t3
    or $v0, $v0, $zero

    xor $zero, $t0, $t3
    or $v0, $v0, $zero

    xori $zero, $t0, 0
    or $v0, $v0, $zero

    jr $ra

.data
    var1: .word 0x1
