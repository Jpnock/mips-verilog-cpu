#expect the address to change to (current address + 4 + 68 = current address + 72)

addi	$v0, $v0, 3         # $v0 = $v0 + 3
addi	$v1, $v1, 4 		# $v1 = $v1 + 4

beq		$v0, $v1, 0x17	# if $v0 == $v1 then target

jr $ra
sll $zero, $zero, 0