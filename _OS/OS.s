@@@@@ SWI_readChar @@@@@

mov r0, #0
ldr r0, [r0, #4095]
@SWI_ret

@@@@@ SWI_writeChar @@@@@

mov r1, #0
str r0, [r1, #4095]
@SWI_ret

@@@@@ SWI_readLine @@@@@

mov r0, r13	@starting address
mov r2, #0
mov r3, r0	@iterator	
ReadLoop:
ldr r1, [r2, #4095]
str r1, [r3]
add r3, r3, #4
cmp r1, #13
bne ReadLoop
add r13, r3, #4
@SWI_ret

@@@@@ SWI_writeLine @@@@@

mov r1, r0
mov r2, #0
WriteLoop:
ldr r0, [r1]
str r0, [r2, #4095]
add r1,r1,#4
cmp r0,#13
bne WriteLoop
@SWI_ret

mov r0,#0

@OS startup begins after 25 instructions
@@@@@ Text displayed on startup @@@@@

mov r0, #0
@SWI_writeLine

Start:

@@@@@ Displaying options to load file and execute program  @@@@@

mov r0, #180
@SWI_writeLine
mov r0, #0	@replacement for SWI

@@@@@ Reading user input @@@@@

@SWI_readChar
mov r0, #0	@replacement for SWI
cmp r0, #49
beq LoadFile
cmp r0, #50
beq Execute
cmp r0, #113
beq Exit
mov r0, #13
@SWI_writeChar
mov r0, #0	@replacement for SWI
b Start

@@@@@ Program to load user file @@@@@

LoadFile:

mov r0, #13
@SWI_writeChar
mov r0, #0	@replacement for SWI
mov r1, #400
mov r2, #0

LoadLoop:
mov r0, #0
ldr r3, [r2, #4095]
cmp r3, #4
beq LoadDone
mov r3, r3, LSL #24
orr r0,r0,r3
ldr r3, [r2, #4095]
mov r3, r3, LSL #16
orr r0,r0,r3
ldr r3, [r2, #4095]
mov r3, r3, LSL #8
orr r0,r0,r3
ldr r3, [r2, #4095]
orr r0,r0,r3

@SWI_saveIns
mov r0, #0 	@replacement for SWI
add r1,r1,#4
b LoadLoop

LoadDone:
mov r0, #288
@SWI_writeLine
mov r0, #0	@replacement for SWI
b Start

@@@@@ Program to execute the user code @@@@@

Execute:
mov r0, #13
@SWI_writeChar
mov r0, #0	@replacement for SWI
@SWI_execute
mov r0, #0	@replacement for SWI
b Start

@@@@@ Exit @@@@@

Exit:

mov r0, #101
@SWI_writeChar
mov r0, #120
@SWI_writeChar
mov r0, #105
@SWI_writeChar
mov r0, #116
@SWI_writeChar
@SWI_exit

@user program begins after 100 instructions, user data begins after 100 locations
