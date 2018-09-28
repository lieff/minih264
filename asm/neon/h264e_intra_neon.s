        .text
        .align 2                
intra_predict_dc4:                      
        MOV             r3,     #0
        VEOR            q1,     q1,     q1
        CMP             r0,     #0x20
        BCC             local_intra_10_0
        VLD1.8          {d0},   [r0]
        ADD             r3,     r3,     #2
        VPADAL.U8               q1,     q0
local_intra_10_0:                      
        CMP             r1,     #0x20
        BCC             local_intra_10_1
        VLD1.8          {d0},   [r1]
        ADD             r3,     r3,     #2
        VPADAL.U8               q1,     q0
local_intra_10_1:                      
        VPADDL.U16              q1,     q1
        VMOV.32         r12,    d2[0]
        ADD             r0,     r12,    r3
        CMP             r3,     #4
        MOVEQ           r0,     r0,     lsr #1
        MOV             r0,     r0,     lsr #2
        CMP             r3,     #0
        MOVEQ           r0,     #0x80
        ADD             r0,     r0,     r0,     lsl #16
        ADD             r0,     r0,     r0,     lsl #8
        BX              lr
h264e_intra_predict_16x16_neon:                 
        CMP             r3,     #1
        BEQ             h_pred_16x16
        BLT             v_pred_16x16
        MOV             r3,     #0
        VEOR            q1,     q1,     q1
        CMP             r1,     #0x20
        BCC             local_intra_10_2
        VLD1.8          {q2},   [r1]
        ADD             r3,     r3,     #8
        VPADAL.U8               q1,     q2
local_intra_10_2:                      
        CMP             r2,     #0x20
        BCC             local_intra_10_3
        VLD1.8          {q0},   [r2]
        ADD             r3,     r3,     #8
        VPADAL.U8               q1,     q0
local_intra_10_3:                      
        VPADDL.U16              q1,     q1
        VPADDL.U32              q1,     q1
        VADD.I64                d2,     d2,     d3
        VMOV.32         r12,    d2[0]
        ADD             r2,     r12,    r3
        CMP             r3,     #16
        MOVEQ           r2,     r2,     lsr #1
        MOV             r2,     r2,     lsr #4
        CMP             r3,     #0
        MOVEQ           r2,     #0x80
        VDUP.I8         q0,     r2
save_q0:                        
        VMOV            q1,     q0
        VMOV            q2,     q0
        VMOV            q3,     q0
        VSTMIA          r0!,    {q0-q3}
        VSTMIA          r0!,    {q0-q3}
        VSTMIA          r0!,    {q0-q3}
        VSTMIA          r0!,    {q0-q3}
        BX              lr
v_pred_16x16:                   
        VLD1.8          {q0},   [r2]
        B               save_q0
h_pred_16x16:                   
        MOV             r2,     #16
local_intra_1_0:                       
        LDRB            r3,     [r1],   #1
        VDUP.I8         q0,     r3
        SUBS            r2,     r2,     #1
        VSTMIA          r0!,    {q0}
        BNE             local_intra_1_0
        BX              lr
h264e_intra_predict_chroma_neon:                        
        PUSH            {r4-r8, lr}
        MOV             r6,     r2
        CMP             r3,     #1
        LDMLT           r6,     {r2,    r3,     r12,    lr}
        MOV             r4,     r0
        MOVGT           r7,     #2
        MOV             r5,     r1
        MOV             r0,     #8
        MOVGT           r8,     r7
        BEQ             h_pred_chroma
        BGT             dc_pred_chroma
v_pred_chroma:                  
        SUBS            r0,     r0,     #1
        STMIA           r4!,    {r2,    r3,     r12,    lr}
        BNE             v_pred_chroma
        POP             {r4-r8, pc}
h_pred_chroma:                  
        LDRB            r12,    [r5,    #8]
        LDRB            r2,     [r5],   #1
        SUBS            r0,     r0,     #1
        ADD             r12,    r12,    r12,    lsl #16
        ADD             r2,     r2,     r2,     lsl #16
        ADD             r12,    r12,    r12,    lsl #8
        ADD             r2,     r2,     r2,     lsl #8
        MOV             lr,     r12
        MOV             r3,     r2
        STMIA           r4!,    {r2,    r3,     r12,    lr}
        BNE             h_pred_chroma
        POP             {r4-r8, pc}
dc_pred_chroma:                 
        MOV             r1,     r6
        MOV             r0,     r5
        BL              intra_predict_dc4
        STR             r0,     [r4,    #0x40]
        STR             r0,     [r4,    #4]
        STR             r0,     [r4,    #0]
        ADD             r1,     r6,     #4
        ADD             r0,     r5,     #4
        BL              intra_predict_dc4
        CMP             r6,     #0x20
        STR             r0,     [r4,    #0x44]
        BCC             local_intra_10_4
        ADD             r1,     r6,     #4
        MOV             r0,     #0
        BL              intra_predict_dc4
        STR             r0,     [r4,    #4]
local_intra_10_4:                      
        CMP             r5,     #0x20
        BCC             local_intra_11_0
        ADD             r1,     r5,     #4
        MOV             r0,     #0
        BL              intra_predict_dc4
        STR             r0,     [r4,    #0x40]
local_intra_11_0:                      
        SUBS            r8,     r8,     #1
        ADD             r4,     r4,     #8
        ADD             r5,     r5,     #8
        ADD             r6,     r6,     #8
        BNE             dc_pred_chroma
        LDMDB           r4,     {r0-r3}
        STMIA           r4!,    {r0-r3}
        STMIA           r4!,    {r0-r3}
        STMIA           r4!,    {r0-r3}
        LDMIA           r4!,    {r0-r3}
        STMIA           r4!,    {r0-r3}
        STMIA           r4!,    {r0-r3}
        STMIA           r4!,    {r0-r3}
        POP             {r4-r8, pc}
save_best:                      
        CMP             r1,     r10
        MOVNE           r0,     r11 
        MOVEQ           r0,     #0
        VABD.U8         q2,     q1,     q15
        VPADDL.U8               q2,     q2
        VPADDL.U16              q2,     q2
        VPADDL.U32              q2,     q2
        VADD.I64                d4,     d4,     d5
        VMOV.32         d5[0],  r0
        VADD.U32                d4,     d4,     d5
        VMOV.32         r0,     d4[0]
        CMP             r0,     r9
        BXGE            lr
        VMOV            q3,     q1
        STR             r1,     [sp,    #0+4+4+4]
        MOV             r9,     r0
        BX              lr
h264e_intra_choose_4x4_neon:                    
        PUSH            {r0-r11,        lr}
        SUB             sp,     sp,     #5*4
        LDR             r9,     [r0],   #0x10
        LDR             r10,    [r0],   #0x10
        LDR             r11,    [r0],   #0x10
        LDR             r12,    [r0],   #0x10
        VMOV            d30,    r9,     r10
        VMOV            d31,    r11,    r12
        LDR             r10,    [sp,    #0+4+4+4+4+4+4+4+4+4+4*8+4]
        LDR             r11,    [sp,    #0+4+4+4+4+4+4+4+4+4+4*8+4+4]
        MOV             r9,     #0x10000000
        TST             r2,     #1
        MOVNE           r1,     r3
        MOVEQ           r1,     #0
        TST             r2,     #2
        SUBNE           r0,     r3,     #5
        MOVEQ           r0,     #0
        BL              intra_predict_dc4
        VDUP.8          q1,     r0
        MOV             r1,     #2
        BL              save_best
        LDR             r2,     [sp,    #0+4+4+4+4+4+4+4+4]
        SUB             r12,    r2,     #5
        VLD1.8          {q0},   [r12]
        LDR             r0,     [sp,    #0+4+4+4+4+4+4+4]
        VMOV.U8         lr,     d1[4]
        ORR             lr,     lr,     lr,     lsl #8
        ORR             lr,     lr,     lr,     lsl #16
        VMOV.32         d1[1],  lr
        TST             r0,     #1
        BEQ             not_avail_t
        TST             r0,     #8
        BNE             local_intra_10_5
        VDUP.8          d1,     d1[0]
local_intra_10_5:                      
        VEXT.8          q1,     q0,     q0,     #5
        VMOV            q2,     q1
        VZIP.32         q1,     q2
        VMOV            q2,     q1
        VZIP.32         q1,     q2
        MOV             r1,     #0
        BL              save_best
        VEXT.8          q10,    q0,     q0,     #5
        VEXT.8          q11,    q0,     q0,     #6
        VEXT.8          q12,    q0,     q0,     #7
        VHADD.U8                q1,     q10,    q12
        VRHADD.U8               q1,     q1,     q11
        VEXT.8          q10,    q1,     q1,     #1
        VEXT.8          d3,     d2,     d2,     #2
        VEXT.8          d4,     d2,     d2,     #3
        VZIP.32         d2,     d20
        VZIP.32         d3,     d4
        VMOV            d24,    d2
        MOV             r1,     #3
        BL              save_best
        VEXT.8          q10,    q0,     q0,     #5
        VEXT.8          q11,    q0,     q0,     #6
        VRHADD.U8               q1,     q10,    q11
        VEXT.8          q10,    q1,     q1,     #1
        VZIP.32         q1,     q10
        VZIP.32         q1,     q12
        MOV             r1,     #7
        BL              save_best
        LDR             r0,     [sp,    #0+4+4+4+4+4+4+4]
local_intra_10_6:                      
not_avail_t:                    
        TST             r0,     #2
        BEQ             not_avail_l
        VREV32.8                q8,     q0
        VREV32.8                q1,     q0
        VZIP.8          q8,     q1
        VMOV            q1,     q8
        VZIP.8          q1,     q8
        MOV             r1,     #1
        BL              save_best
        VREV32.8                q2,     q0  
        VREV32.8                q1,     q0
        VREV32.8                q8,     q0
        VZIP.8          q8,     q1
        VMOV.U16                lr,     d16[3]
        VMOV.16         d4[2],  lr  
        VMOV.16         d17[0], lr  
        VEXT.8          q9,     q2,     q2,     #14
        VHADD.U8                q10,    q9,     q2
        VZIP.8          q9,     q10
        VEXT.8          q11,    q8,     q8,     #14
        VRHADD.U8               q10,    q9,     q11
        ADD             lr,     lr,     lr,     lsl #16
        VEXT.8          q1,     q10,    q10,    #4
        VEXT.8          q9,     q10,    q10,    #6
        VZIP.32         q1,     q9
        VMOV.32         d3[1],  lr
        MOV             r1,     #8
        BL              save_best
        LDR             r0,     [sp,    #0+4+4+4+4+4+4+4]
not_avail_l:                    
        AND             r0,     r0,     #7
        CMP             r0,     #7
        BNE             not_avail_diag
        VEXT.8          q10,    q0,     q0,     #1
        VEXT.8          q11,    q0,     q0,     #2
        VHADD.U8                q1,     q0,     q11
        VRHADD.U8               q2,     q1,     q10
        VMOV            q11,    q2
        VEXT.8          d3,     d4,     d4,     #1
        VEXT.8          d5,     d4,     d4,     #2
        VEXT.8          d2,     d4,     d4,     #3
        VZIP.32         d3,     d4
        VZIP.32         d2,     d5
        MOV             r1,     #4
        BL              save_best
        VRHADD.U8               q1,     q0,     q10
        VMOV            q12,    q1
        VMOV            q2,     q11
        VZIP.8          q1,     q2
        VEXT.8          q2,     q1,     q1,     #2
        VZIP.32         q1,     q2
        VREV64.32               q1,     q1
        VSWP            d2,     d3
        VMOV.U16                lr,     d22[2]
        VMOV.16         d2[1],  lr
        MOV             r1,     #6
        BL              save_best
        VEXT.8          q11,    q11,    q11,    #1
        VEXT.8          q1,     q12,    q12,    #4
        VEXT.8          q2,     q11,    q11,    #2
        VZIP.32         q1,     q2
        VMOV.U16                lr,     d22[0]
        VMOV.16         d24[1], lr
        MOV             lr,     lr,     lsl #8
        VMOV.16         d22[0], lr
        VEXT.8          d3,     d24,    d24,    #3
        VEXT.8          d22,    d22,    d22,    #1
        VZIP.32         d3,     d22
        MOV             r1,     #5
        BL              save_best
not_avail_diag:                 
        LDR             r0,     [sp,    #0+4+4+4]
        MOV             r3,     r9
        LDR             r4,     [sp,    #0+4+4+4+4+4+4]
        VMOV            r5,     r6,     d6
        STR             r5,     [r4]
        STR             r6,     [r4,    #0x10]
        VMOV            r5,     r6,     d7
        STR             r5,     [r4,    #0x20]
        STR             r6,     [r4,    #0x30]
        ADD             sp,     sp,     #4*9
        ADD             r0,     r0,     r3,     lsl #4
        POP             {r4-r11,        pc}
        .global         h264e_intra_predict_16x16_neon
        .global         h264e_intra_predict_chroma_neon
        .global         h264e_intra_choose_4x4_neon
