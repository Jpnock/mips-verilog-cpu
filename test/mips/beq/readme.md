For branch and jump instruction I decided to initialize registers $v0 and $v1
with values needed to evaluate the branch conditions. Therefore the branch 
instructions should only be tested when the addi is known to be working
correctly. 