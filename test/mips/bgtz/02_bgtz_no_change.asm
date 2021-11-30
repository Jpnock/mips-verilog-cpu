#expect the address to change to (current address + 4)


bgtz	$v0, 0x17	# if $v0 == $v1 then target

jr $ra
sll $zero, $zero, 0
