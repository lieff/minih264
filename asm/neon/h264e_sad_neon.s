        .arm
        .text
        .align 2

        .type  h264e_sad_mb_unlaign_wh_neon, %function
h264e_sad_mb_unlaign_wh_neon:
        TST             r3,     #0x008
        BNE             local_sad_2_0
        VLDMIA          r2!,    {q8-q15}
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABDL.U8                q0,     d16,    d4
        VABAL.U8                q0,     d17,    d5
        VABAL.U8                q0,     d18,    d6
        VABAL.U8                q0,     d19,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d20,    d4
        VABAL.U8                q0,     d21,    d5
        VABAL.U8                q0,     d22,    d6
        VABAL.U8                q0,     d23,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d24,    d4
        VABAL.U8                q0,     d25,    d5
        VABAL.U8                q0,     d26,    d6
        VABAL.U8                q0,     d27,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d28,    d4
        VABAL.U8                q0,     d29,    d5
        VABAL.U8                q0,     d30,    d6
        VABAL.U8                q0,     d31,    d7
        TST             r3,     #0x00100000
        BEQ             local_sad_1_0
        VLDMIA          r2!,    {q8-q15}
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d16,    d4
        VABAL.U8                q0,     d17,    d5
        VABAL.U8                q0,     d18,    d6
        VABAL.U8                q0,     d19,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d20,    d4
        VABAL.U8                q0,     d21,    d5
        VABAL.U8                q0,     d22,    d6
        VABAL.U8                q0,     d23,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d24,    d4
        VABAL.U8                q0,     d25,    d5
        VABAL.U8                q0,     d26,    d6
        VABAL.U8                q0,     d27,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d28,    d4
        VABAL.U8                q0,     d29,    d5
        VABAL.U8                q0,     d30,    d6
        VABAL.U8                q0,     d31,    d7
local_sad_1_0:
        VPADDL.U16              q0,     q0
        VPADDL.U32              q0,     q0
        VADD.U64                d0,     d1
        VMOV            r0,     r1,     d0
        BX              lr
local_sad_2_0:
        VLDMIA          r2!,    {q8-q15}
        VLD1.8          {d4},   [r0],   r1
        VLD1.8          {d5},   [r0],   r1
        VABDL.U8                q0,     d16,    d4
        VABAL.U8                q0,     d18,    d5
        VLD1.8          {d4},   [r0],   r1
        VLD1.8          {d5},   [r0],   r1
        VABAL.U8                q0,     d20,    d4
        VABAL.U8                q0,     d22,    d5
        VLD1.8          {d4},   [r0],   r1
        VLD1.8          {d5},   [r0],   r1
        VABAL.U8                q0,     d24,    d4
        VABAL.U8                q0,     d26,    d5
        VLD1.8          {d4},   [r0],   r1
        VLD1.8          {d5},   [r0],   r1
        VABAL.U8                q0,     d28,    d4
        VABAL.U8                q0,     d30,    d5
        TST             r3,     #0x00100000
        BEQ             local_sad_1_1
        VLDMIA          r2!,    {q8-q15}
        VLD1.8          {d4},   [r0],   r1
        VLD1.8          {d5},   [r0],   r1
        VABAL.U8                q0,     d16,    d4
        VABAL.U8                q0,     d18,    d5
        VLD1.8          {d4},   [r0],   r1
        VLD1.8          {d5},   [r0],   r1
        VABAL.U8                q0,     d20,    d4
        VABAL.U8                q0,     d22,    d5
        VLD1.8          {d4},   [r0],   r1
        VLD1.8          {d5},   [r0],   r1
        VABAL.U8                q0,     d24,    d4
        VABAL.U8                q0,     d26,    d5
        VLD1.8          {d4},   [r0],   r1
        VLD1.8          {d5},   [r0],   r1
        VABAL.U8                q0,     d28,    d4
        VABAL.U8                q0,     d30,    d5
local_sad_1_1:
        VPADDL.U16              q0,     q0
        VPADDL.U32              q0,     q0
        VADD.U64                d0,     d1
        VMOV            r0,     r1,     d0
        BX              lr
        .size  h264e_sad_mb_unlaign_wh_neon, .-h264e_sad_mb_unlaign_wh_neon

        .type  h264e_sad_mb_unlaign_8x8_neon, %function
h264e_sad_mb_unlaign_8x8_neon:
        VLDMIA          r2!,    {q8-q15}
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABDL.U8                q0,     d16,    d4
        VABDL.U8                q1,     d17,    d5
        VABAL.U8                q0,     d18,    d6
        VABAL.U8                q1,     d19,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d20,    d4
        VABAL.U8                q1,     d21,    d5
        VABAL.U8                q0,     d22,    d6
        VABAL.U8                q1,     d23,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d24,    d4
        VABAL.U8                q1,     d25,    d5
        VABAL.U8                q0,     d26,    d6
        VABAL.U8                q1,     d27,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d28,    d4
        VABAL.U8                q1,     d29,    d5
        VABAL.U8                q0,     d30,    d6
        VABAL.U8                q1,     d31,    d7
        VLDMIA          r2!,    {q8-q15}
        VPADDL.U16              q0,     q0
        VPADDL.U16              q1,     q1
        VPADDL.U32              q0,     q0
        VPADDL.U32              q1,     q1
        VADD.U64                d0,     d1
        VADD.U64                d2,     d3
        VTRN.32         d0,     d2
        VSTMIA          r3!,    {d0}
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABDL.U8                q0,     d16,    d4
        VABDL.U8                q1,     d17,    d5
        VABAL.U8                q0,     d18,    d6
        VABAL.U8                q1,     d19,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d20,    d4
        VABAL.U8                q1,     d21,    d5
        VABAL.U8                q0,     d22,    d6
        VABAL.U8                q1,     d23,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d24,    d4
        VABAL.U8                q1,     d25,    d5
        VABAL.U8                q0,     d26,    d6
        VABAL.U8                q1,     d27,    d7
        VLD1.8          {d4,    d5},    [r0],   r1
        VLD1.8          {d6,    d7},    [r0],   r1
        VABAL.U8                q0,     d28,    d4
        VABAL.U8                q1,     d29,    d5
        VABAL.U8                q0,     d30,    d6
        VABAL.U8                q1,     d31,    d7
        VPADDL.U16              q0,     q0
        VPADDL.U16              q1,     q1
        VPADDL.U32              q0,     q0
        VPADDL.U32              q1,     q1
        VADD.U64                d0,     d1
        VADD.U64                d2,     d3
        VTRN.32         d0,     d2
        VSTMIA          r3!,    {d0}
        LDMDB           r3,     {r0-r3}
        ADD             r0,     r0,     r1
        ADD             r0,     r0,     r2
        ADD             r0,     r0,     r3
        BX              lr
        .size  h264e_sad_mb_unlaign_8x8_neon, .-h264e_sad_mb_unlaign_8x8_neon

        .type  h264e_copy_8x8_neon, %function
h264e_copy_8x8_neon:
        VLDR.64         d0,     [r2,    #0*16]
        VLDR.64         d1,     [r2,    #1*16]
        VLDR.64         d2,     [r2,    #2*16]
        VLDR.64         d3,     [r2,    #3*16]
        VLDR.64         d4,     [r2,    #4*16]
        VLDR.64         d5,     [r2,    #5*16]
        VLDR.64         d6,     [r2,    #6*16]
        VLDR.64         d7,     [r2,    #7*16]
        VST1.32         {d0},   [r0:64],        r1
        VST1.32         {d1},   [r0:64],        r1
        VST1.32         {d2},   [r0:64],        r1
        VST1.32         {d3},   [r0:64],        r1
        VST1.32         {d4},   [r0:64],        r1
        VST1.32         {d5},   [r0:64],        r1
        VST1.32         {d6},   [r0:64],        r1
        VST1.32         {d7},   [r0:64],        r1
        BX              lr
        .size  h264e_copy_8x8_neon, .-h264e_copy_8x8_neon

        .type  h264e_copy_16x16_neon, %function
h264e_copy_16x16_neon:
        MOV             r12,    #4
local_sad_1_2:
        VLD2.32         {d0-d1},        [r2:64],        r3
        VLD2.32         {d2-d3},        [r2:64],        r3
        VLD2.32         {d4-d5},        [r2:64],        r3
        VLD2.32         {d6-d7},        [r2:64],        r3
        SUBS            r12,    r12,    #1
        VST2.32         {d0-d1},        [r0:64],        r1
        VST2.32         {d2-d3},        [r0:64],        r1
        VST2.32         {d4-d5},        [r0:64],        r1
        VST2.32         {d6-d7},        [r0:64],        r1
        BNE             local_sad_1_2
        BX              lr
        .size  h264e_copy_16x16_neon, .-h264e_copy_16x16_neon

        .type  h264e_copy_borders_neon, %function
h264e_copy_borders_neon:
        PUSH            {r4-r12,        lr}
        ADD             r4,     r1,     r3,     lsl #1
        MUL             r5,     r3,     r4
        MLA             r6,     r2,     r4,     r0
        SUB             r8,     r1,     #4
        MOV             lr,     r5
        ADD             r12,    lr,     #4
        SUB             r7,     r6,     r4
        SUB             r5,     r0,     r5
        ADD             r5,     r5,     r8
        ADD             r6,     r6,     r8
local_sad_2_1:
        LDR             r10,    [r0,    r8]
        LDR             r11,    [r7,    r8]
        MOV             r9,     r3
local_sad_1_3:
        SUBS            r9,     r9,     #1
        STR             r10,    [r5],   r4
        STR             r11,    [r6],   r4
        BGT             local_sad_1_3
        SUBS            r8,     r8,     #4
        SUB             r5,     r5,     r12
        SUB             r6,     r6,     r12
        BGE             local_sad_2_1
        SUB             r0,     r0,     lr
        SUB             r5,     r0,     r3
        ADD             r6,     r0,     r1
        SUB             r7,     r6,     #1
        ADD             r9,     r2,     r3,     lsl #1
        LDR             r1,     =0x1010101
        RSB             r12,    r3,     r4,     lsl #1
local_sad_2_2:
        LDRB            lr,     [r0,    r4]
        LDRB            r2,     [r7,    r4]
        LDRB            r10,    [r0],   r4,     lsl #1
        LDRB            r11,    [r7],   r4,     lsl #1
        SUB             r8,     r3,     #4
        MUL             lr,     lr,     r1
        MUL             r2,     r2,     r1
        MUL             r10,    r10,    r1
        MUL             r11,    r11,    r1
local_sad_1_4:
        SUBS            r8,     r8,     #4
        STR             lr,     [r5,    r4]
        STR             r2,     [r6,    r4]
        STR             r10,    [r5],   #4
        STR             r11,    [r6],   #4
        BGE             local_sad_1_4
        SUBS            r9,     r9,     #2
        ADD             r5,     r5,     r12
        ADD             r6,     r6,     r12
        BGT             local_sad_2_2
        POP             {r4-r12,        pc}
        .size  h264e_copy_borders_neon, .-h264e_copy_borders_neon

        .global         h264e_sad_mb_unlaign_8x8_neon
        .global         h264e_sad_mb_unlaign_wh_neon
        .global         h264e_copy_borders_neon
        .global         h264e_copy_8x8_neon
        .global         h264e_copy_16x16_neon
