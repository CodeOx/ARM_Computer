mov r0, #0
ldr r0, [r0, #4095]
@SWI_ret

mov r1, #0
str r0, [r1, #4095]
@SWI_ret

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

mov r0, #0
@SWI_writeLine

Start:

mov r0, #180
@SWI_writeLine
mov r0, #0	@replacement for SWI

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

LoadFile:

mov r0, #13
@SWI_writeChar
mov r0, #0	@replacement for SWI
mov r1, #400
mov r2, #0
LoadLoop:
ldr r0, [r2, #4095]
str r0, [r1]
add r1, r1, #4
cmp r0, #4
bne LoadLoop
mov r0, #288
@SWI_writeLine
mov r0, #0	@replacement for SWI
b Start

Execute:
mov r0, #13
@SWI_writeChar
mov r0, #0	@replacement for SWI
@SWI_execute
b Start

Exit:

@user program begins after 100 instructions, user data begins after 100 locations

mov r1, #1
mov r0, #0
str r1,[r0,#4094]
str r1,[r0,#4093]
@SWI_readChar
@SWI_writeChar
@SWI_readLine
@SWI_writeLine
mov r1,#0
Here:
ldr r0, [r1, #4095]
str r0, [r1, #4095]
cmp r0, #4
bne Here
mov r0, #0
mov r1,#4
str r1,[r0,#4094]
@SWI_exit