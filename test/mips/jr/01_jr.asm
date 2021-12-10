# Expect: 0x13

.text
.globl main
main: 
    la      $ra, 0xBFC00014     #bfc00000
    addu    $v0, $v0, $ra       #bfc00004
    jr      $ra                 #bfc00008
    addi    $ra, 0x4            #bfc00010
    addi    $v0, 0x13           #bfc00014
    subu    $v0, $v0, $ra       #bfc00018
    jr      $zero               #bfc0001C
