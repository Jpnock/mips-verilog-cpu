#expect the address to change to (current address + 4)

addi	$v0, $v0, 14         # $v0 = $v0 + 14

bgez    $v0, 18

jr $ra
sll $zero, $zero, 0
