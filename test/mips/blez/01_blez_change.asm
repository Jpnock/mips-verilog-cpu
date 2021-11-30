#expect the address to change to (current address + 4 + 72 = current address + 76)

addi	$v0, $v0, -4         # $v0 = $v0 + 14

blez    $v0, 18

jr $ra
sll $zero, $zero, 0