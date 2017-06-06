	j main
	ori $27,$0,0	#27号寄存器用来做地址，下面不得使用1
save1:	addi,$27,$27,4	#保存1-9 2
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
test1:	ori $1,$0,1
	ori $1,$0,1
	ori $1,$0,1
	sb $1,3($0)
	lb $2,3($0)
	addi,$27,$27,4
	sw $2,0($27)
	jr $ra
	nop
test2:	ori $1,$0,1
	sll $2,$1,2
	srl $3,$2,2
	sllv $4,$1,$3
	srlv $5,$4,$3
	ori $6,$0,0xfffffff0
	sra $7,$6,10
	srav $8,$6,$3
	jalr $9,$ra
	nop
test3:  addi $1,$0,3
	xori $2,$1,4
	addi $3,$1,2
	nor $4,$2,$3
	xor $5,$2,$3
	slt $6,$4,$5
	ori $7,$0,-2
	sltu $8,$6,$7
	sltiu $9,$7,-1
	jr $ra
	nop
test4:	ori $1,$0,6
	ori $2,$0,1
	addiu $3,$0,1
	add $5,$1,$3
loop1:	subu $5,$5,$3
	bgez $5,loop1
	nop
	add $6,$1,$3
loop2:	subu $6,$6,$3
	bgtz $6,loop2
	nop
	ori $7,$0,-6
loop3:	addi $7,$7,1
	bltz $7,loop3
	nop
	ori $8,$0,-6
loop4:	addi $8,$8,1
	blez $8,loop4
	nop
	jr $ra
	nop
test5:	ori $2,$0,2
	ori $1,$0,-1
	sb $1,0($0)
	sb $1,1($0)
	sb $1,2($0)
	sb $2,3($0)
	sh $1,4($0)
	sh $2,6($0)
	lb $3,1($0)
	lbu $4,1($0)
	lh $5,2($0)
	lhu $5,2($0)
	jr $ra
test6:	ori $1,$0,3
	mult $1,$1
	mflo $2
	addi $2,$2,2
	div $2,$1
	addi $8,$0,-1
	mflo $3
	mfhi $4
	ori $5,$0,5
	mthi $5
	mtlo $5
	mfhi $6
	mflo $7
	divu $8,$7
	mfhi $10
	mflo $9
	jalr $10,$ra
	nop
test7:	jal lop1
	ori $1,$0,16
	add $2,$ra,$1
	jalr $2
	nop
lop1:	jr $ra
	nop
	addi $3,$0,0xffffff3f
	addi $4,$0,-1
	mult $3,$4
	mflo $5
	bltz $5,lop1
	nop
	sb $4,1($0)
	lb $6,1($0)
	mthi $6
	mfhi $7
	lbu $8,1($0)
	mthi $8
	mfhi $9
	jr $ra
	nop
main:	jal test1
	nop
	jal test2
	nop
	jal save1
	nop
	jal test3
	nop
	jal save1
	nop
	jal test4
	nop
	jal save1
	nop
	jal test5
	nop
	jal save1
	nop
	jal test6
	nop
	jal save1
	nop
	jal test7
	nop
	jal save1
	nop
