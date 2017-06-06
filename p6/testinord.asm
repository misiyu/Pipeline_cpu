	j main
	nop
save:	addi,$27,$27,4	#±£¥Ê1-9 2
	sw $1,0($27)	#3
	addi,$27,$27,4	
	sw $2,0($27)
	addi,$27,$27,4
	sw $3,0($27)
	addi,$27,$27,4
	sw $4,0($27)
	addi,$27,$27,4
	sw $5,0($27)
	addi,$27,$27,4
	sw $6,0($27)
	addi,$27,$27,4
	sw $7,0($27)
	addi,$27,$27,4
	sw $8,0($27)
	addi,$27,$27,4
	sw $9,0($27)
	jr $ra	#4
	nop
test1:	j ss			#sb,sh¿‡÷∏¡Ó≤‚ ‘
	add $19,$0,$ra
s1:	jr $ra
	nop
ss:	addi $1,$0,9
	addi $2,$0,5
	div $1,$2
	mflo $3
	sb $3,3($0)
	sh $3,0($0)
	sra $4,$1,2
	sh $4,6($0)
	slti $5,$1,10
	sb $5,8
	jal s1
	nop
	addi $6,$ra,12
	jalr $7,$6
	sh $7,10($0)
	jr $19
	nop
test2:	j l1
	nop
l2:	jr $ra
	add $19,$0,$ra
l1:	addi $1,$0,-1
	sw $1,0($0)
	lb $2,1($0)
	lbu $3,1($0)
	mult $2,$3
	mflo $4
	sw $4,0($0)
	lh $5,0($0)
	lhu $6,0($0)
	sllv $7,$5,$6
	sw $7,0($0)
	lw $8,0($0)
	bgez $8,l1
	nop
	jal l2
	nop
	addi $9,$31,20
	sw $9,0($0)
	lw $10,0($0)
	jalr $19,$10
	nop
	addi $19,$19,36
	jr $19
	nop
test3:	addi $1,$0,0xffffffff
loop1:	sll $1,$1,1
	bltz $1,loop1
	nop
	nor $2,$0,$1
	slt $3,$2,$1
	blez $3,loop1
	nop
	xori $4,$0,3
	nop
	bgtz $4,loop2
	nop
	andi $5,$4,5
loop2:	andi $5,$4,3
	addi $6,$0,0x00003000
	addi $6,$6,72
	jalr $7,$6
	nop
	blez $7,loop2
	nop
	jr $ra
	nop
main:	jal test1
	nop
	jal save
	nop
	jal test3
	nop
	jal save
	nop
