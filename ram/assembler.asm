; Define constants

.equ ADDR_VAR1, 0x2000

.equ ADDR_VAR2, 0x2004

.equ ADDR_VAR3, 0x2008


; Define variables

.global var1

.global var2

.global var3

var1: .word 0

var2: .word 0

var3: .word 0


; Define functions

.global load_var

.global store_var

.global add_vars

.global sub_vars

.global mul_vars

.global div_vars

.global mod_vars


; Load a variable from memory into a register

load_var:

    stmfd sp!, {r1, r2, lr}

    ldr r1, [r0] ; Load address of variable into r1

    ldr r2, [r1] ; Load value of variable into r2

    mov pc, lr ; Return to caller


; Store a variable into memory from a register

store_var:

    stmfd sp!, {r1, r2, lr}

    ldr r1, [r0] ; Load address of variable into r1

    str r1, [r1, #4] ; Store value of r1 into memory

    mov pc, lr ; Return to caller


; Add two variables and store the result in the first variable

add_vars:

    stmfd sp!, {r1, r2, r3, lr}

    ldr r1, =ADDR_VAR1 ; Load address of var1 into r1

    ldr r2, =ADDR_VAR2 ; Load address of var2 into r2

    ldr r3, [r1] ; Load value of var1 into r3

    add r3, [r2] ; Add value of var2 to r3

    str r3, [r1] ; Store result in var1

    mov pc, lr ; Return to caller


; Subtract two variables and store the result in the first variable

sub_vars:

    stmfd sp!, {r1, r2, r3, lr}

    ldr r1, =ADDR_VAR1 ; Load address of var1 into r1

    ldr r2, =ADDR_VAR2 ; Load address of var2 into r2

    ldr r3, [r1] ; Load value of var1 into r3

    sub r3, [r2] ; Subtract value of var2 from r3

    str r3, [r1] ; Store result in var1

    mov pc, lr ; Return to caller


; Multiply two variables and store the result in the first variable

mul_vars:

    stmfd sp!, {r1, r2, r3, lr}

    ldr r1, =ADDR_VAR1 ; Load address of var1 into r1

    ldr r2, =ADDR_VAR2 ; Load address of var2 into r2

    ldr r3, [r1] ; Load value of var1 into r3

    mul r3, [r2] ; Multiply r3 by value of var2

    str r3, [r1] ; Store result in var1

    mov pc, lr ; Return to caller


; Divide two variables and store the result in the first variable

div_vars:

    stmfd sp!, {r1, r2, r3, lr}

    ldr r1, =ADDR_VAR1 ; Load address of var1 into r1

    ldr r2, =ADDR_VAR2 ; Load address of var2 into r2

    ldr r3, [r1] ; Load value of var1 into r3

    sdiv r3, [r2] ; Divide r3 by value of var2

    str r3, [r1] ; Store result in var1

    mov pc, lr ; Return to caller
