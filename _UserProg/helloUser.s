mov r0, #101
@SWI_writeChar
mov r0, #110
@SWI_writeChar
mov r0, #116
@SWI_writeChar
mov r0, #101
@SWI_writeChar
mov r0, #114
@SWI_writeChar
mov r0, #32
@SWI_writeChar
mov r0, #121
@SWI_writeChar
mov r0, #111
@SWI_writeChar
mov r0, #117
@SWI_writeChar
mov r0, #114
@SWI_writeChar
mov r0, #32
@SWI_writeChar
mov r0, #110
@SWI_writeChar
mov r0, #97
@SWI_writeChar
mov r0, #109
@SWI_writeChar
mov r0, #101
@SWI_writeChar
mov r0, #32
@SWI_writeChar

@SWI_readLine
mov r4, r0

mov r0, #104
@SWI_writeChar
mov r0, #101
@SWI_writeChar
mov r0, #108
@SWI_writeChar
mov r0, #108
@SWI_writeChar
mov r0, #111
@SWI_writeChar
mov r0, #32
@SWI_writeChar

mov r0, r4
@SWI_writeLine

@SWI_done