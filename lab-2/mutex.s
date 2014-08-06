	.syntax unified
	.arch armv7-a
	.text

	.equ locked, 1
	.equ unlocked, 0

	.global lock_mutex
	.type lock_mutex, function
lock_mutex:
        @ INSERT CODE BELOW
	ldr r1, =locked		@Load the locked to register1

     .LOOP:			@Crital section
	ldrex r2, [r0]		@Load register exclusive form address [r0] to r2
	cmp r2, #0		@if register1 != unlocked
	bne .LOOP		@Stay in crital section

	strex r2, r1, [r0]	@Try to write the value of r1, to the address of r0, r2 will be 0 if succeed
	cmp r2, #0
	bne .LOOP		@If failes, then loop

        @ END CODE INSERT
	bx lr

	.size lock_mutex, .-lock_mutex

	.global unlock_mutex
	.type unlock_mutex, function
unlock_mutex:
	@ INSERT CODE BELOW
	ldr r1, =unlocked	@Let the register1 be unlocked
	str r1, [r0]		@Let the unlocked value store back

        @ END CODE INSERT
	bx lr
	.size unlock_mutex, .-unlock_mutex

	.end
