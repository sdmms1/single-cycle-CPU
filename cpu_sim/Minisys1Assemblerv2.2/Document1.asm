.data  0x0000              		        # 数据定义的首地址
.text 0x0000						        # 代码段定义开始
start:	lui $28,0xFFFF 
		ori $28,$28,0XF000

loop:	lw $a1,0XC72($28)	#switch
		srl $t0,$a1,5

		ori $t1,$zero,1
		beq $t0,$t1,assign
		ori $t1,$zero,2
		beq $t0,$t1,incre
		ori $t1,$zero,3
		beq $t0,$t1,decre
		ori $t1,$zero,5
		beq $t0,$t1,sfll
		ori $t1,$zero,6
		beq $t0,$t1,sfra
		ori $t1,$zero,7
		beq $t0,$t1,sfrl

		#switch[22:21]=00
inti:		ori $t2,$zero,0xAAAA
		bne $a2,$t2,change
		ori $a2,$zero,0x5555
		j store

change:	ori $a2,$zero,0xAAAA
		j store
		
		#switch[23:21]=1
assign:	lw $a2,0XC70($28)
		j store

		#switch[23:21]=2
incre:	addi $a2,$a2,1
		j store

		#switch[23:21]=3
decre:	addi $a2,$a2,-1
		j store

		#switch[23:21]=5
sfll:		sll $a2,$a2,1
		andi $a2,$a2,0xFFFF
		j store

		#switch[23:21]=6
sfra:		sll $a2,$a2,16
		sra $a2,$a2,17
		andi $a2,$a2,0xFFFF
		j store

		#switch[23:21]=7
sfrl:		andi $a2,$a2,0xFFFF
		srl $a2,$a2,1
		j store


store:	sw $a2,0XC60($28)
		j loop