# Expect: 0x12D2

.text
.globl main
main:   
<<<<<<< HEAD
    addiu    $v0, $v0, 0x0559
    li		 $t1, 0x12D2
    beq      $v0, $t1, L2
=======
    addiu    $v0, $v0, 0x9559
    li		 $v1, 0x9559
    beq      $v0, $v1, L2
>>>>>>> ecf7f64865f601b8830ac6431a6042d340255570
     
L1: 
    addiu    $v0, $v0, 0x000A		
    addiu    $v0, $v0, 0x0816
    li       $v1, 0x5137
    bne	     $v0, $v1, main
    
L2:
    jr       $zero
