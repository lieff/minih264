        .arm
        .text
        .align 2

        .type  hadamar4_2d_neon, %function
hadamar4_2d_neon:
        VLD4.16         {d0,    d1,     d2,     d3},    [r0]
        VADD.S16                q2,     q0,     q1
        VSUB.S16                q3,     q0,     q1
        VSWP            d5,     d6
        VADD.S16                q0,     q2,     q3
        VSUB.S16                q1,     q2,     q3
        VSWP            d2,     d3
        VTRN.S16                d0,     d1
        VTRN.S16                d2,     d3
        VTRN.S32                q0,     q1
        VADD.S16                q2,     q0,     q1
        VSUB.S16                q3,     q0,     q1
        VSWP            d5,     d6
        VADD.S16                q0,     q2,     q3
        VSUB.S16                q1,     q2,     q3
        VSWP            d2,     d3
        VSTMIA          r0,     {q0-q1}
        BX              lr
        .size  hadamar4_2d_neon, .-hadamar4_2d_neon

        .type  hadamar2_2d_neon, %function
hadamar2_2d_neon:
        LDMIA           r0,     {r1,    r2}
        SADDSUBX                r1,     r1,     r1
        SADDSUBX                r2,     r2,     r2
        SSUB16          r3,     r1,     r2
        SADD16          r2,     r1,     r2
        MOV             r2,     r2,     ror #16
        MOV             r3,     r3,     ror #16
        STMIA           r0,     {r2,    r3}
        BX              lr
        .size  hadamar2_2d_neon, .-hadamar2_2d_neon

        .type  h264e_quant_luma_dc_neon, %function
h264e_quant_luma_dc_neon:
        PUSH            {r4-r6, lr}
        SUB             sp,     sp,     #0x28
        MOV             r6,     r1
        MOV             r4,     r2
        MOV             r5,     r0
        SUB             r0,     r5,     #16*2
        BL              hadamar4_2d_neon
        MOV             r3,     #0x20000
        STR             r3,     [sp,    #0]
        LDRSH           r2,     [r4,    #0]
        MOV             r3,     #0x10
        MOV             r1,     r6
        SUB             r0,     r5,     #16*2
        BL              quant_dc
        SUB             r0,     r5,     #16*2
        BL              hadamar4_2d_neon
        LDRH            r0,     [r4,    #2]
        MOV             r3,     #0x10
        SUB             r1,     r5,     #16*2
        MOV             r2,     r0,     lsr #2
        MOV             r0,     r5
        BL              dequant_dc
        ADD             sp,     sp,     #0x28
        POP             {r4-r6, pc}
        .size  h264e_quant_luma_dc_neon, .-h264e_quant_luma_dc_neon

        .type  h264e_quant_chroma_dc_neon, %function
h264e_quant_chroma_dc_neon:
        PUSH            {r3-r7, lr}
        MOV             r6,     r1
        MOV             r4,     r2
        MOV             r5,     r0
        SUB             r0,     r5,     #16*2
        BL              hadamar2_2d_neon
        LDR             r3,     =0x0000aaaa
        MOV             r1,     r6
        STR             r3,     [sp,    #0]
        LDRH            r0,     [r4,    #0]
        MOV             r3,     #4
        MOV             r2,     r0,     lsl #17
        MOV             r2,     r2,     asr #16
        SUB             r0,     r5,     #16*2
        BL              quant_dc
        SUB             r0,     r5,     #16*2
        BL              hadamar2_2d_neon
        LDRH            r0,     [r4,    #2]
        MOV             r3,     #4
        SUB             r1,     r5,     #16*2
        MOV             r2,     r0,     lsr #1
        MOV             r0,     r5
        BL              dequant_dc
        SUB             r1,     r5,     #16*2
        LDMIA           r1,     {r2,    r3}
        ORRS            r0,     r2,     r3
        MOVNE           r0,     #1
        POP             {r3-r7, pc}
        .size  h264e_quant_chroma_dc_neon, .-h264e_quant_chroma_dc_neon

        .type  is_zero4_neon, %function
is_zero4_neon:
        PUSH            {r4-r6, lr}
        MOV             r4,     r0
        MOV             r5,     r1
        MOV             r6,     r2
        ADD             r0,     r0,     #(0+16*2)
        BL              is_zero_neon
        POPNE           {r4-r6, pc}
        MOV             r2,     r6
        MOV             r1,     r5
        ADD             r0,     r4,     #(0+16*2)+((0+16*2)+16*2)
        BL              is_zero_neon
        POPNE           {r4-r6, pc}
        MOV             r2,     r6
        MOV             r1,     r5
        ADD             r0,     r4,     #(0+16*2)+4*((0+16*2)+16*2)
        BL              is_zero_neon
        POPNE           {r4-r6, pc}
        MOV             r2,     r6
        MOV             r1,     r5
        ADD             r0,     r4,     #(0+16*2)+5*((0+16*2)+16*2)
        BL              is_zero_neon
        POP             {r4-r6, pc}
        .size  is_zero4_neon, .-is_zero4_neon

        .type  h264e_transform_sub_quant_dequant_neon, %function
h264e_transform_sub_quant_dequant_neon:
        PUSH            {r0-r12,        lr}
        MOV             r6,     r1
        MOV             r5,     r0
        MOV             r8,     r3,     asr #1
        LDR             r1,     [sp,    #8]
        MOV             r0,     r3,     asr #1
        LDR             r4,     [sp,    #0x38]
        MOV             r9,     r3
        MOV             r7,     r8
        SUB             r10,    r1,     r0
        RSB             r11,    r0,     #0x10
l0.660:
        LDR             r2,     [sp,    #8]
        ADD             r3,     r4,     #0x20
        MOV             r1,     r6
        MOV             r0,     r5
        BL              fwdtransformresidual4x42_neon
        SUBS            r7,     r7,     #1
        ADD             r5,     r5,     #4
        ADD             r6,     r6,     #4
        ADD             r4,     r4,     #((0+16*2)+16*2)
        BNE             l0.660
        SUBS            r8,     r8,     #1
        MOV             r7,     r9,     asr #1
        ADD             r5,     r5,     r10,    lsl #2
        ADD             r6,     r6,     r11,    lsl #2
        BNE             l0.660
        MOVS            r7,     r9,     lsr #1
        BCC             local_transform_10_0
        MUL             r7,     r7,     r7
        LDR             r5,     [sp,    #0x38]
        SUB             r0,     r5,     #16*2
        ADD             r1,     r5,     #(0+16*2)
local_transform_1_0:
        LDRH            r2,     [r1],   #((0+16*2)+16*2)
        SUBS            r7,     r7,     #1
        STRH            r2,     [r0],   #2
        BNE             local_transform_1_0
local_transform_10_0:
        ADD             r3,     sp,     #0x38
        MOV             r1,     r9
        LDMIA           r3,     {r0,    r2}
        BL              zero_smallq_neon
        ADD             r4,     sp,     #0x38
        MOV             r3,     r0
        MOV             r1,     r9
        LDMIA           r4,     {r0,    r2}
        ADD             sp,     sp,     #0x10
        POP             {r4-r12,        lr}
        B               quantize_neon
        .size  h264e_transform_sub_quant_dequant_neon, .-h264e_transform_sub_quant_dequant_neon

        .type  h264e_transform_add_neon, %function
h264e_transform_add_neon:
        LDR             r12,    [sp]
        SUB             r12,    r12,    r12,    lsl #16
        ADD             r3,     r3,     #(0+16*2)
        PUSH            {r0-r12,        lr}
local_transform_1_1:
        LDR             r12,    [sp,    #0+4+4+4+4+4*8+4+4+4]
        MOV             lr,     #0
        MOVS            r12,    r12,    lsl #1
        STR             r12,    [sp,    #0+4+4+4+4+4*8+4+4+4]
        BCC             copy_block
        VLD1.16         {d0,    d1,     d2,     d3},    [r3]
        ADD             r3,     r3,     #((0+16*2)+16*2)
        VTRN.16         d0,     d1
        VTRN.16         d2,     d3
        VTRN.32         q0,     q1
        VADD.S16                d4,     d0,     d2
        VSUB.S16                d5,     d0,     d2
        VSHR.S16                d31,    d1,     #1
        VSHR.S16                d30,    d3,     #1
        VSUB.S16                d6,     d31,    d3
        VADD.S16                d7,     d1,     d30
        VADD.S16                d0,     d4,     d7
        VADD.S16                d1,     d5,     d6
        VSUB.S16                d2,     d5,     d6
        VSUB.S16                d3,     d4,     d7
        VTRN.16         d0,     d1
        VTRN.16         d2,     d3
        VTRN.32         q0,     q1
        VADD.S16                d4,     d0,     d2
        VSUB.S16                d5,     d0,     d2
        VSHR.S16                d31,    d1,     #1
        VSHR.S16                d30,    d3,     #1
        VSUB.S16                d6,     d31,    d3
        VADD.S16                d7,     d1,     d30
        VADD.S16                d0,     d4,     d7
        VADD.S16                d1,     d5,     d6
        VSUB.S16                d2,     d5,     d6
        VSUB.S16                d3,     d4,     d7
        LDR             r4,     [r2],   #16
        LDR             r5,     [r2],   #16
        VMOV            d20,    r4,     r5
        LDR             r4,     [r2],   #16
        LDR             r5,     [r2],   #4-16*3
        VMOV            d21,    r4,     r5
        VSHLL.U8                q2,     d20,    #6
        VADD.S16                q0,     q0,     q2
        VSHLL.U8                q3,     d21,    #6
        VADD.S16                q1,     q1,     q3
        VQRSHRUN.S16            d0,     q0,     #6
        VQRSHRUN.S16            d1,     q1,     #6
        VMOV            r4,     r5,     d0
        STR             r4,     [r0],   r1
        STR             r5,     [r0],   r1
        VMOV            r4,     r5,     d1
        STR             r4,     [r0],   r1
        STR             r5,     [r0],   r1
copy_block_ret:
        LDR             lr,     [sp,    #0+4+4+4+4+4*8]
        SUB             r0,     r0,     r1,     lsl #2
        ADD             r0,     r0,     #4
        ADDS            lr,     lr,     #0x10000
        STRMI           lr,     [sp,    #0+4+4+4+4+4*8]
        BMI             local_transform_1_1
        SUBS            lr,     lr,     #1
        POPEQ           {r0-r12,        pc}
        LDR             r4,     [sp,    #0+4+4+4+4+4*8+4+4]
        SUB             lr,     lr,     r4,     lsl #16
        STR             lr,     [sp,    #0+4+4+4+4+4*8]
        ADD             r0,     r0,     r1,     lsl #2
        SUB             r0,     r0,     r4,     lsl #2
        ADD             r2,     r2,     #16*4
        SUB             r2,     r2,     r4,     lsl #2
        B               local_transform_1_1
copy_block:
        LDR             r4,     [r2],   #16
        LDR             r5,     [r2],   #16
        LDR             r6,     [r2],   #16
        LDR             r7,     [r2],   #4-16*3
        ADD             r3,     r3,     #((0+16*2)+16*2)
        STR             r4,     [r0],   r1
        STR             r5,     [r0],   r1
        STR             r6,     [r0],   r1
        STR             r7,     [r0],   r1
        B               copy_block_ret
dequant_dc:
        PUSH            {lr}
        ADD             r0,     r0,     #(0+16*2)
local_transform_1_2:
        LDR             lr,     [r1],   #4
        SUBS            r3,     r3,     #2
        SMULBB          r12,    r2,     lr
        SMULBT          lr,     r2,     lr
        STRH            r12,    [r0],   #((0+16*2)+16*2)
        STRH            lr,     [r0],   #((0+16*2)+16*2)
        BNE             local_transform_1_2
        POP             {pc}
quant_dc:
        PUSH            {r4-r6, lr}
        CMP             r3,     #4
        LDR             r5,     [sp,    #0x10]
        LDRNE           r12,    =iscan16
        LDREQ           r12,    =iscan4
        RSB             r6,     r5,     #0x40000
local_transform_1_3:
        LDRSH           lr,     [r0]
        CMP             lr,     #0
        MOVGE           r4,     r5
        MOVLT           r4,     r6
        MLA             lr,     r2,     lr,     r4
        MOV             lr,     lr,     asr #18
        STRH            lr,     [r0],   #2
        LDRB            r4,     [r12],  #1
        SUBS            r3,     r3,     #1
        ADD             r4,     r1,     r4,     lsl #1
        STRH            lr,     [r4,    #0]
        BNE             local_transform_1_3
        POP             {r4-r6, pc}
        .size  h264e_transform_add_neon, .-h264e_transform_add_neon

        .type  fwdtransformresidual4x42_neon, %function
fwdtransformresidual4x42_neon:
        PUSH            {lr}
        LDR             r12,    [r0],   r2
        LDR             lr,     [r0],   r2
        VMOV            d16,    r12,    lr
        LDR             r12,    [r0],   r2
        LDR             lr,     [r0],   r2
        VMOV            d17,    r12,    lr
        LDR             r12,    [r1],   #16
        LDR             lr,     [r1],   #16
        VMOV            d20,    r12,    lr
        LDR             r12,    [r1],   #16
        LDR             lr,     [r1],   #16
        VMOV            d21,    r12,    lr
        VSUBL.U8                q0,     d16,    d20
        VSUBL.U8                q1,     d17,    d21
        VTRN.16         d0,     d1
        VTRN.16         d2,     d3
        VTRN.32         q0,     q1
        VADD.S16                d4,     d0,     d3
        VSUB.S16                d5,     d0,     d3
        VADD.S16                d6,     d1,     d2
        VSUB.S16                d7,     d1,     d2
        VADD.S16                q0,     q2,     q3
        VADD.S16                d1,     d1,     d5
        VSUB.S16                q1,     q2,     q3
        VSUB.S16                d3,     d3,     d7
        VTRN.16         d0,     d1
        VTRN.16         d2,     d3
        VTRN.32         q0,     q1
        VADD.S16                d4,     d0,     d3
        VSUB.S16                d5,     d0,     d3
        VADD.S16                d6,     d1,     d2
        VSUB.S16                d7,     d1,     d2
        VADD.S16                q0,     q2,     q3
        VADD.S16                d1,     d1,     d5
        VSUB.S16                q1,     q2,     q3
        VSUB.S16                d3,     d3,     d7
        VST1.16         {q0,    q1},    [r3]
        POP             {pc}
        .size  fwdtransformresidual4x42_neon, .-fwdtransformresidual4x42_neon

        .type  is_zero_neon, %function
is_zero_neon:
        VLD1.16         {d0-d3},        [r0]
        VABS.S16                q0,     q0
        VABS.S16                q1,     q1
        VCGT.U16                q0,     q0,     q15
        VCGT.U16                q1,     q1,     q15
        VBIC            d0,     d0,     d29
        VORR            q0,     q0,     q1
        VORR            d0,     d0,     d1
        VMOV            r0,     r1,     d0
        ORRS            r0,     r0,     r1
        BX              lr
        .size  is_zero_neon, .-is_zero_neon

        .type  zero_smallq_neon, %function
zero_smallq_neon:
        PUSH            {r4-r12,        lr}
        TST             r1,     #1
        VMOV.I64                d29,    #0xffff
        BNE             local_transform_10_1
        VMOV.I64                d29,    #0
local_transform_10_1:
        CMP             r1,     #8
        MOV             r8,     r0
        MOV             r6,     r1
        MOV             r0,     r1,     asr #1
        CMPNE           r6,     #5
        MOV             r7,     r2
        ADD             r2,     r2,     #0x14
        VLD1.16         {q15},  [r2]
        MOV             r4,     #0
        MULEQ           r9,     r0,     r0
        AND             r10,    r1,     #1
        MOVEQ           r5,     #0
        MOVEQ           r11,    #1
        BNE             l0.1964
        MOV             r12,    #((0+16*2)+16*2)
        MLA             r8,     r12,    r9,     r8
        ADD             r8,     r8,     #(0+16*2)
local_transform_1_4:
        SUB             r8,     r8,     #(((0+16*2)+16*2))
        VLD1.16         {d0-d3},        [r8]
        VABS.S16                q0,     q0
        VABS.S16                q1,     q1
        VCGT.U16                q0,     q0,     q15
        VCGT.U16                q1,     q1,     q15
        VBIC            d0,     d0,     d29
        VORR            q0,     q0,     q1
        VORR            d0,     d0,     d1
        VMOV            r0,     r1,     d0
        ORRS            r0,     r0,     r1
        ADD             r4,     r4,     r4
        ORREQ           r4,     r4,     #1
        SUBS            r9,     r9,     #1
        BNE             local_transform_1_4
        SUB             r8,     r8,     #(0+16*2)
        ADD             r2,     r2,     #0x10
        VLD1.16         {q15},  [r2]
        CMP             r6,     #8
        BNE             l0.1964
        MOV             r0,     #0x33
        BICS            r0,     r0,     r4
        BEQ             l0.1856
        ADD             r2,     r7,     #0x24
        MOV             r1,     r10
        MOV             r0,     r8
        BL              is_zero4_neon
        ORREQ           r4,     r4,     #0x33
l0.1856:
        MOV             r0,     #0xcc
        BICS            r0,     r0,     r4
        BEQ             l0.1892
        ADD             r2,     r7,     #0x24
        MOV             r1,     r10
        ADD             r0,     r8,     #2*((0+16*2)+16*2)
        BL              is_zero4_neon
        ORREQ           r4,     r4,     #0xcc
l0.1892:
        MOV             r0,     #0x3300
        BICS            r0,     r0,     r4
        BEQ             l0.1928
        ADD             r2,     r7,     #0x24
        MOV             r1,     r10
        ADD             r0,     r8,     #8*((0+16*2)+16*2)
        BL              is_zero4_neon
        ORREQ           r4,     r4,     #0x3300
l0.1928:
        MOV             r0,     #0xcc00
        BICS            r0,     r0,     r4
        BEQ             l0.1964
        ADD             r2,     r7,     #0x24
        MOV             r1,     r10
        ADD             r0,     r8,     #10*((0+16*2)+16*2)
        BL              is_zero4_neon
        ORREQ           r4,     r4,     #0xcc00
l0.1964:
        MOV             r0,     r4
        POP             {r4-r12,        pc}
        .size  zero_smallq_neon, .-zero_smallq_neon

        .type  quantize_neon, %function
quantize_neon:
        PUSH            {r3-r11,        lr}
        AND             r4,     r1,     #1
        MOV             r5,     r1,     asr #1
        MOV             r7,     #0
        MOV             lr,     r5
        STR             r4,     [sp,    #0]
local_transform_1_5:
        TST             r3,     #1
        MOV             r6,     #0
        BEQ             nonzero
        VMOV.U8         q0,     #0
        VMOV.U8         q1,     #0
        VST1.16         {q0,    q1},    [r0]
qloop_next:
        CMP             r6,     #0
        MOV             r7,     r7,     lsl #1
        ORRNE           r7,     r7,     #1
        SUBS            r5,     r5,     #1
        MOVEQ           r5,     r1,     asr #1
        SUBEQS          lr,     lr,     #1
        MOV             r3,     r3,     asr #1
        ADD             r0,     r0,     #((0+16*2)+16*2)
        MOVEQ           r0,     r7
        BNE             local_transform_1_5
        POP             {r3-r11,        pc}
nonzero:
        LDR             r4,     [sp,    #0]
        LDRH            r12,    [r2,    #0xc]
        CMP             r4,     #0
        ADD             r4,     r0,     #(0+16*2)
        VLD1.16         {q0,    q1},    [r4]
        VDUP.16         q15,    r12
        VCLT.S16                q8,     q0,     #0
        VCLT.S16                q9,     q1,     #0
        VEOR            q8,     q15,    q8
        VEOR            q9,     q15,    q9
        LDR             r12,    [r2,    #4]
        VDUP.16         d4,     r12
        VDUP.16         d6,     r12
        MOV             r12,    r12,    asr #16
        VDUP.16         d5,     r12
        VDUP.16         d7,     r12
        LDR             r12,    [r2,    #0]
        VMOV.16         d4[0],  r12
        VMOV.16         d4[2],  r12
        MOV             r12,    r12,    asr #16
        VMOV.16         d5[0],  r12
        VMOV.16         d5[2],  r12
        LDR             r12,    [r2,    #8]
        VMOV.16         d6[1],  r12
        VMOV.16         d6[3],  r12
        MOV             r12,    r12,    asr #16
        VMOV.16         d7[1],  r12
        VMOV.16         d7[3],  r12
        VMULL.S16               q10,    d0,     d4
        VADDW.U16               q10,    d16
        VQSHRN.S32              d22,    q10,    #16
        VMUL.S16                d26,    d22,    d5
        VMULL.S16               q10,    d1,     d6
        VADDW.U16               q10,    d17
        VQSHRN.S32              d23,    q10,    #16
        VMUL.S16                d27,    d23,    d7
        VMULL.S16               q10,    d2,     d4
        VADDW.U16               q10,    d18
        VQSHRN.S32              d24,    q10,    #16
        VMUL.S16                d28,    d24,    d5
        VMULL.S16               q10,    d3,     d6
        VADDW.U16               q10,    d19
        VQSHRN.S32              d25,    q10,    #16
        VMUL.S16                d29,    d25,    d7
        ADD             r4,     r0,     #(0+16*2)
        LDRNEH          r12,    [r4]
        VST1.16         {d26-d29},      [r4]
        STRNEH          r12,    [r4]
        LDR             r4,     [sp,    #0]
        CMP             r4,     #0
        LDR             r12,    =iscan16_neon
        VLD1.8          {q8,    q9},    [r12]
        VTBL.8          d0,     {d22-d25},      d16
        VTBL.8          d1,     {d22-d25},      d17
        VTBL.8          d2,     {d22-d25},      d18
        VTBL.8          d3,     {d22-d25},      d19
        LDRNEH          r4,     [r0]
        VST1.16         {d0-d3},        [r0]
        STRNEH          r4,     [r0]
        LDR             r12,    =imask16_neon
        VLD1.8          {q8,    q9},    [r12]
        VCEQ.I16                q0,     q0,     #0
        VCEQ.I16                q1,     q1,     #0
        VAND            q0,     q0,     q8
        VAND            q1,     q1,     q9
        VORR            q0,     q0,     q1
        VORR            d0,     d0,     d1
        VPADD.U16               d0,     d0,     d0
        VPADD.U16               d0,     d0,     d0
        VMOV.U16                r12,    d0[0]
        MVN             r6,     r12,    lsl #16
        MOV             r6,     r6,     lsr #16
        BICNE           r6,     r6,     #1
        B               qloop_next
        .size  quantize_neon, .-quantize_neon

        .section        .rodata
        .align 2
iscan4:
        .byte           0x00,   0x01,   0x02,   0x03
iscan16:
        .byte           0x00,   0x01,   0x05,   0x06
        .byte           0x02,   0x04,   0x07,   0x0c
        .byte           0x03,   0x08,   0x0b,   0x0d
        .byte           0x09,   0x0a,   0x0e,   0x0f
imask16_neon:
        .short          0x0001, 0x0002, 0x0004, 0x0008
        .short          0x0010, 0x0020, 0x0040, 0x0080
        .short          0x0100, 0x0200, 0x0400, 0x0800
        .short          0x1000, 0x2000, 0x4000, 0x8000
iscan16_neon:
        .byte           0x00,   0x01,   0x02,   0x03,   0x08,   0x09,   0x10,   0x11
        .byte           0x0a,   0x0b,   0x04,   0x05,   0x06,   0x07,   0x0c,   0x0d
        .byte           0x12,   0x13,   0x18,   0x19,   0x1a,   0x1b,   0x14,   0x15
        .byte           0x0e,   0x0f,   0x16,   0x17,   0x1c,   0x1d,   0x1e,   0x1f
        .global         h264e_quant_luma_dc_neon
        .global         h264e_quant_chroma_dc_neon
        .global         h264e_transform_sub_quant_dequant_neon
        .global         h264e_transform_add_neon
