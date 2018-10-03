        .arm
        .text
        .align 2
        .type  h264e_bs_put_sgolomb_arm11, %function
h264e_bs_put_sgolomb_arm11:
        MVN             r2,     #0
        ADD             r1,     r2,     r1,     lsl #1
        EOR             r1,     r1,     r1,     asr #31
        .size  h264e_bs_put_sgolomb_arm11, .-h264e_bs_put_sgolomb_arm11

        .type  h264e_bs_put_golomb_arm11, %function
h264e_bs_put_golomb_arm11:
        ADD             r2,     r1,     #1
        CLZ             r1,     r2
        MOV             r3,     #63
        SUB             r1,     r3,     r1,     lsl #1
        .size  h264e_bs_put_golomb_arm11, .-h264e_bs_put_golomb_arm11

        .type  h264e_bs_put_bits_arm11, %function
h264e_bs_put_bits_arm11:
        LDMIA           r0,     {r3,    r12}
        SUBS            r3,     r3,     r1
        BMI             local_cavlc_1_0
        ORR             r12,    r12,    r2,     lsl r3
        STMIA           r0,     {r3,    r12}
        BX              lr
local_cavlc_1_0:
        RSB             r1,     r3,     #0
        ORR             r12,    r12,    r2,     lsr r1
        LDR             r1,     [r0,    #8]
        REV             r12,    r12
        ADD             r3,     r3,     #32
        STR             r12,    [r1],   #4
        MOV             r12,    r2,     lsl r3
        STMIA           r0,     {r3,    r12}
        STR             r1,     [r0,    #8]
        BX              lr
        .size  h264e_bs_put_bits_arm11, .-h264e_bs_put_bits_arm11

        .type  h264e_bs_flush_arm11, %function
h264e_bs_flush_arm11:
        LDMIB           r0,     {r0,    r1}
        REV             r0,     r0
        STR             r0,     [r1]
        BX              lr
        .size  h264e_bs_flush_arm11, .-h264e_bs_flush_arm11

        .type  h264e_bs_get_pos_bits_arm11, %function
h264e_bs_get_pos_bits_arm11:
        LDMIA           r0,     {r0-r3}
        SUB             r2,     r2,     r3
        RSB             r0,     r0,     #0x20
        ADD             r0,     r0,     r2,     lsl #3
        BX              lr
        .size  h264e_bs_get_pos_bits_arm11, .-h264e_bs_get_pos_bits_arm11

        .type  h264e_bs_byte_align_arm11, %function
h264e_bs_byte_align_arm11:
        PUSH            {r0,    lr}
        BL              h264e_bs_get_pos_bits_arm11
        RSB             r1,     r0,     #0
        AND             r1,     r1,     #7
        ADD             r3,     r0,     r1
        MOV             r2,     #0
        LDR             r0,     [sp]
        STR             r3,     [sp]
        BL              h264e_bs_put_bits_arm11
        POP             {r0,    pc}
        .size  h264e_bs_byte_align_arm11, .-h264e_bs_byte_align_arm11

        .type  h264e_bs_init_bits_arm11, %function
h264e_bs_init_bits_arm11:
        MOV             r12,    r1
        MOV             r3,     r1
        MOV             r2,     #0
        MOV             r1,     #32
        STMIA           r0,     {r1-r3, r12}
        BX              lr
        .size  h264e_bs_init_bits_arm11, .-h264e_bs_init_bits_arm11

        .type  h264e_vlc_encode_arm11, %function
h264e_vlc_encode_arm11:
        PUSH            {r4-r11,        lr}
        CMP             r2,     #4
        MOVNE           r4,     #0x10
        MOVEQ           r4,     #4
        LDMIA           r0,     {r10-r12}
        SUB             sp,     sp,     #0x10
        MOV             r8,     #0
        ADD             r4,     r1,     r4,     lsl #1
        MOV             r9,     r8
        MOV             r5,     sp
        MOV             r1,     r4
        MOV             lr,     r2
local_cavlc_1_1:
        LDRSH           r7,     [r4,    #-2]!
        MOVS            r7,     r7,     lsl #1
        STRNEH          r7,     [r1,    #-2]!
        STRNEB          lr,     [r5],   #1
        SUBS            lr,     lr,     #1
        BNE             local_cavlc_1_1
        ADD             r4,     r4,     r2,     lsl #1
        SUB             r5,     r4,     r1
        MOVS            r5,     r5,     asr #1
        BEQ             no_nz1
        CMP             r5,     #3
        MOVLE           r6,     r5
        MOVGT           r6,     #3
        SUB             r1,     r4,     #2
local_cavlc_1_2:
        LDRSH           r4,     [r1,    #0]
        ADD             r7,     r4,     #2
        CMP             r7,     #4
        BHI             no_nz1
        MOV             r7,     r9,     lsl #1
        SUBS            r6,     r6,     #1
        ORR             r9,     r7,     r4,     lsr #31
        SUB             r1,     r1,     #2
        ADD             r8,     r8,     #1
        BNE             local_cavlc_1_2
no_nz1:
        LDRB            r4,     [r3,    #-1]
        LDRB            r7,     [r3,    #1]
        STRB            r5,     [r3,    #0]
        SUB             r6,     r5,     r8
        ADD             r3,     r4,     r7
        CMP             r3,     #0x22
        ADDLE           r3,     r3,     #1
        LDR             r4,     =h264e_g_coeff_token
        MOVLE           r3,     r3,     asr #1
        AND             r3,     r3,     #0x1f
        MOV             r7,     #6
        LDRB            r3,     [r4,    r3]
        ADD             lr,     r3,     r8
        ADD             lr,     lr,     r6,     lsl #2
        CMP             r3,     #0xe6
        LDRB            r4,     [r4,    lr]
        ANDNE           r3,     r4,     #0xf
        ADDNE           r7,     r3,     #1
        MOVNE           r4,     r4,     lsr #4
        SUBS            r10,    r10,    r7
        BLMI            bs_flush_sub
        ORR             r11,    r11,    r4,     lsl r10
        CMP             r5,     #0
        BEQ             l1.1272
        CMP             r8,     #0
        BEQ             l1.864
        SUBS            r10,    r10,    r8
        MOV             r4,     r9
        BLMI            bs_flush_sub
        ORR             r11,    r11,    r4,     lsl r10
l1.864:
        CMP             r6,     #0
        BEQ             l1.1120
        LDRSH           r7,     [r1,    #0]
        SUB             lr,     r1,     #2
        MVN             r4,     #2
        SUBS            r1,     r7,     #2
        SUBMI           r1,     r4,     r1
        CMP             r1,     #6
        MOV             r9,     #1
        MOVGE           r9,     #2
        CMP             r8,     #3
        BGE             l1.952
        CMP             r5,     #0xa
        SUB             r1,     r1,     #2
        BLE             l1.952
        MOV             r7,     r1,     asr #1
        CMP             r7,     #0xf
        MOVGE           r7,     #0xf
        MOV             r8,     #1
        MOVGE           r8,     #0xc
        SUB             r1,     r1,     r7,     lsl #1
        RSB             r7,     #2
        B               loop_enter
l1.952:
        CMP             r1,     #0xe
        MOVLT           r7,     r1
        MOVLT           r1,     #0
        MOVLT           r8,     r1
        RSBLT           r7,     #2
        BLT             loop_enter
        CMP             r1,     #0x1e
        MOVGE           r9,     #1
        BGE             escape
        MOV             r7,     #0xe
        MOV             r8,     #4
        SUB             r1,     r1,     #0xe
        RSB             r7,     #2
        B               loop_enter
local_cavlc_1_3:
        SUBS            r1,     r1,     #2
        SUBMI           r1,     r4,     r1
        MOV             r7,     r1,     asr r9
        CMP             r7,     #0xf
        MOV             r8,     r9
escape:
        MOVGE           r7,     #0xf
        MOVGE           r8,     #0xc
        SUB             r1,     r1,     r7,     lsl r9
        RSBS            r7,     #2
        CMPLT           r9,     #6
        ADDLT           r9,     r9,     #1
loop_enter:
        MOV             r3,     #1
        ORR             r1,     r1,     r3,     lsl r8
        RSB             r7,     r7,     #3
        ADD             r7,     r7,     r8
        SUBS            r10,    r10,    r7
        BMI             bs_flush_1
bs_flush_1_return:
        ORR             r11,    r11,    r1,     lsl r10
        SUBS            r6,     r6,     #1
        LDRNESH         r1,     [lr],   #-2
        BNE             local_cavlc_1_3
l1.1120:
        CMP             r5,     r2
        BGE             l1.1272
        LDRB            r8,     [sp,    #0]
        CMP             r2,     #4
        ADD             r6,     sp,     #1
        SUB             r1,     r8,     r5
        SUB             r9,     r5,     #1
        LDRNE           r7,     =h264e_g_total_zeros
        LDREQ           r7,     =h264e_g_total_zeros_cr_2x2
        ADD             r5,     r5,     r6
        MVN             r2,     #0
        MOV             lr,     #0x10
        ADD             r2,     r2,     r1,     lsl #1
        STRB            lr,     [r5,    #-1]
l1.1176:
        LDRB            r5,     [r7,    r9]
        ADD             r7,     r7,     r1
        LDRB            r5,     [r5,    r7]
        AND             r7,     r5,     #0xf
        SUBS            r10,    r10,    r7
        MOV             r4,     r5,     lsr #4
        BLMI            bs_flush_sub
        ORR             r11,    r11,    r4,     lsl r10
        SUBS            r2,     r2,     r1
        BMI             l1.1272
        LDRB            r1,     [r6],   #1
        MOV             r5,     r8
        MOV             r8,     r1
        SUB             r1,     r5,     r1
        SUBS            r1,     r1,     #1
        LDRPL           r7,     =h264e_g_run_before
        MOVPL           r9,     r2
        BPL             l1.1176
l1.1272:
        STMIA           r0,     {r10,   r11,    r12}
        ADD             sp,     sp,     #0x10
        POP             {r4-r11,        pc}
bs_flush_sub:
        RSB             r7,     r10,    #0
        ADD             r10,    r10,    #0x20
        ORR             r11,    r11,    r4,     asr r7
        REV             r11,    r11
        STR             r11,    [r12],  #4
        MOV             r11,    #0
        BX              lr
bs_flush_1:
        RSB             r7,     r10,    #0
        ADD             r10,    r10,    #0x20
        ORR             r11,    r11,    r1,     asr r7
        REV             r11,    r11
        STR             r11,    [r12],  #4
        MOV             r11,    #0
        B               bs_flush_1_return
        .size  h264e_vlc_encode_arm11, .-h264e_vlc_encode_arm11

        .global         h264e_bs_put_bits_arm11
        .global         h264e_bs_flush_arm11
        .global         h264e_bs_get_pos_bits_arm11
        .global         h264e_bs_byte_align_arm11
        .global         h264e_bs_put_golomb_arm11
        .global         h264e_bs_put_sgolomb_arm11
        .global         h264e_bs_init_bits_arm11
        .global         h264e_vlc_encode_arm11
