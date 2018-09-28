        .text
        .align 2                
deblock_luma_h_s4:                      
        VPUSH           {q4-q7}
        SUB             r0,     r0,     r1,     lsl #2
        VLD1.8          {q8},   [r0],   r1 
        VLD1.8          {q9},   [r0],   r1 
        VLD1.8          {q10},  [r0],   r1 
        VLD1.8          {q11},  [r0],   r1 
        VLD1.8          {q12},  [r0],   r1 
        VLD1.8          {q13},  [r0],   r1 
        VLD1.8          {q14},  [r0],   r1 
        VLD1.8          {q15},  [r0],   r1 
        VDUP.8          q3,     r2  
        VABD.U8         q0,     q11,    q12 
        VCLT.U8         q2,     q0,     q3 
        VDUP.8          q3,     r3  
        VABD.U8         q1,     q11,    q10 
        VCLT.U8         q1,     q1,     q3 
        VAND            q2,     q2,     q1
        VABD.U8         q1,     q12,    q13 
        VCLT.U8         q1,     q1,     q3 
        VAND            q2,     q2,     q1 
        MOV             r12,    r2,     lsr #2
        ADD             r12,    r12,    #2
        VDUP.8          q4,     r12 
        VCLT.U8         q1,     q0,     q4 
        VAND            q1,     q1,     q2 
        VABD.U8         q0,     q9,     q11 
        VCLT.U8         q0,     q0,     q3 
        VAND            q0,     q0,     q1 
        VABD.U8         q7,     q14,    q12 
        VCLT.U8         q3,     q7,     q3 
        VAND            q3,     q3,     q1 
        VHADD.U8                q4,     q9,     q10
        VHADD.U8                q5,     q11,    q12
        VRHADD.U8               q6,     q9,     q10
        VRHADD.U8               q7,     q11,    q12
        VSUB.I8         q6,     q6,     q4
        VSUB.I8         q7,     q7,     q5
        VHADD.U8                q6,     q6,     q7
        VRHADD.U8               q7,     q4,     q8 
        VHADD.U8                q4,     q4,     q8 
        VSUB.I8         q7,     q7,     q4 
        VADD.I8         q6,     q6,     q7 
        VRHADD.U8               q7,     q5,     q9
        VHADD.U8                q5,     q5,     q9
        VSUB.I8         q7,     q7,     q5
        VHADD.U8                q6,     q6,     q7
        VRHADD.U8               q7,     q4,     q5
        VHADD.U8                q4,     q4,     q5
        VSUB.I8         q7,     q7,     q4
        VRHADD.U8               q6,     q6,     q7
        VADD.I8         q4,     q4,     q6
        VMOV            q6,     q9
        VBIT            q6,     q4,     q0
        VPUSH           {q6}
        VHADD.U8                q4,     q14,    q13
        VHADD.U8                q5,     q12,    q11
        VRHADD.U8               q6,     q14,    q13
        VRHADD.U8               q7,     q12,    q11
        VSUB.I8         q6,     q6,     q4
        VSUB.I8         q7,     q7,     q5
        VHADD.U8                q6,     q6,     q7
        VRHADD.U8               q7,     q4,     q15
        VHADD.U8                q4,     q4,     q15
        VSUB.I8         q7,     q7,     q4
        VADD.I8         q6,     q6,     q7
        VRHADD.U8               q7,     q5,     q14
        VHADD.U8                q5,     q5,     q14
        VSUB.I8         q7,     q7,     q5
        VHADD.U8                q6,     q6,     q7
        VRHADD.U8               q7,     q4,     q5
        VHADD.U8                q4,     q4,     q5
        VSUB.I8         q7,     q7,     q4
        VRHADD.U8               q6,     q6,     q7
        VADD.I8         q4,     q4,     q6
        VMOV            q6,     q14
        VBIT            q6,     q4,     q3
        VPUSH           {q6}
        VHADD.U8                q1,     q9,     q13
        VRHADD.U8               q4,     q1,     q10
        VRHADD.U8               q5,     q11,    q12
        VHADD.U8                q6,     q1,     q10
        VHADD.U8                q7,     q11,    q12
        VHADD.U8                q4,     q4,     q5
        VRHADD.U8               q6,     q6,     q7
        VRHADD.U8               q1,     q4,     q6
        VRHADD.U8               q4,     q9,     q10
        VRHADD.U8               q5,     q11,    q12
        VHADD.U8                q6,     q9,     q10
        VHADD.U8                q7,     q11,    q12
        VHADD.U8                q4,     q4,     q5
        VRHADD.U8               q6,     q6,     q7
        VRHADD.U8               q4,     q4,     q6
        VHADD.U8                q5,     q11,    q13
        VRHADD.U8               q5,     q5,     q10
        VBIF            q1,     q5,     q0 
        VBSL            q0,     q4,     q10 
        VHADD.U8                q7,     q14,    q10
        VRHADD.U8               q4,     q7,     q13
        VRHADD.U8               q5,     q11,    q12
        VHADD.U8                q6,     q7,     q13
        VHADD.U8                q7,     q11,    q12
        VHADD.U8                q4,     q4,     q5
        VRHADD.U8               q6,     q6,     q7
        VRHADD.U8               q4,     q4,     q6
        VRHADD.U8               q6,     q14,    q13
        VRHADD.U8               q5,     q11,    q12
        VHADD.U8                q5,     q6,     q5
        VHADD.U8                q6,     q14,    q13
        VHADD.U8                q7,     q11,    q12
        VRHADD.U8               q6,     q6,     q7
        VRHADD.U8               q5,     q5,     q6
        VHADD.U8                q6,     q12,    q10
        VRHADD.U8               q6,     q6,     q13
        VBIF            q4,     q6,     q3 
        VBSL            q3,     q5,     q13 
        VPOP            {q14}
        VPOP            {q9}
        VBIT            q10,    q0,     q2 
        VBIT            q11,    q1,     q2 
        VBIT            q12,    q4,     q2 
        VBIT            q13,    q3,     q2 
        SUB             r0,     r0,     r1,     lsl #3
        VST1.8          {q8},   [r0],   r1 
        VST1.8          {q9},   [r0],   r1 
        VST1.8          {q10},  [r0],   r1 
        VST1.8          {q11},  [r0],   r1 
        VST1.8          {q12},  [r0],   r1 
        VST1.8          {q13},  [r0],   r1 
        VST1.8          {q14},  [r0],   r1 
        VST1.8          {q15},  [r0],   r1 
        VPOP            {q4-q7}
        BX              lr
deblock_luma_v_s4:                      
        VPUSH           {q4-q7}
        SUB             r0,     r0,     #4
        VLD1.8          {d16},  [r0],   r1
        VLD1.8          {d18},  [r0],   r1
        VLD1.8          {d20},  [r0],   r1
        VLD1.8          {d22},  [r0],   r1
        VLD1.8          {d24},  [r0],   r1
        VLD1.8          {d26},  [r0],   r1
        VLD1.8          {d28},  [r0],   r1
        VLD1.8          {d30},  [r0],   r1
        VLD1.8          {d17},  [r0],   r1
        VLD1.8          {d19},  [r0],   r1
        VLD1.8          {d21},  [r0],   r1
        VLD1.8          {d23},  [r0],   r1
        VLD1.8          {d25},  [r0],   r1
        VLD1.8          {d27},  [r0],   r1
        VLD1.8          {d29},  [r0],   r1
        VLD1.8          {d31},  [r0],   r1
        VTRN.32         q8,     q12
        VTRN.32         q9,     q13
        VTRN.32         q10,    q14
        VTRN.32         q11,    q15
        VTRN.16         q8,     q10
        VTRN.16         q9,     q11
        VTRN.16         q12,    q14
        VTRN.16         q13,    q15
        VTRN.8          q8,     q9
        VTRN.8          q10,    q11
        VTRN.8          q12,    q13
        VTRN.8          q14,    q15
        VDUP.8          q3,     r2  
        VABD.U8         q0,     q11,    q12 
        VCLT.U8         q2,     q0,     q3 
        VDUP.8          q3,     r3  
        VABD.U8         q1,     q11,    q10 
        VCLT.U8         q1,     q1,     q3 
        VAND            q2,     q2,     q1
        VABD.U8         q1,     q12,    q13 
        VCLT.U8         q1,     q1,     q3 
        VAND            q2,     q2,     q1 
        MOV             r12,    r2,     lsr #2
        ADD             r12,    r12,    #2
        VDUP.8          q4,     r12 
        VCLT.U8         q1,     q0,     q4 
        VAND            q1,     q1,     q2 
        VABD.U8         q0,     q9,     q11 
        VCLT.U8         q0,     q0,     q3 
        VAND            q0,     q0,     q1 
        VABD.U8         q7,     q14,    q12 
        VCLT.U8         q3,     q7,     q3 
        VAND            q3,     q3,     q1 
        VHADD.U8                q4,     q9,     q10
        VHADD.U8                q5,     q11,    q12
        VRHADD.U8               q6,     q9,     q10
        VRHADD.U8               q7,     q11,    q12
        VSUB.I8         q6,     q6,     q4
        VSUB.I8         q7,     q7,     q5
        VHADD.U8                q6,     q6,     q7
        VRHADD.U8               q7,     q4,     q8 
        VHADD.U8                q4,     q4,     q8 
        VSUB.I8         q7,     q7,     q4 
        VADD.I8         q6,     q6,     q7 
        VRHADD.U8               q7,     q5,     q9
        VHADD.U8                q5,     q5,     q9
        VSUB.I8         q7,     q7,     q5
        VHADD.U8                q6,     q6,     q7
        VRHADD.U8               q7,     q4,     q5
        VHADD.U8                q4,     q4,     q5
        VSUB.I8         q7,     q7,     q4
        VRHADD.U8               q6,     q6,     q7
        VADD.I8         q4,     q4,     q6
        VMOV            q6,     q9
        VBIT            q6,     q4,     q0
        VPUSH           {q6}
        VHADD.U8                q4,     q14,    q13
        VHADD.U8                q5,     q12,    q11
        VRHADD.U8               q6,     q14,    q13
        VRHADD.U8               q7,     q12,    q11
        VSUB.I8         q6,     q6,     q4
        VSUB.I8         q7,     q7,     q5
        VHADD.U8                q6,     q6,     q7
        VRHADD.U8               q7,     q4,     q15
        VHADD.U8                q4,     q4,     q15
        VSUB.I8         q7,     q7,     q4
        VADD.I8         q6,     q6,     q7
        VRHADD.U8               q7,     q5,     q14
        VHADD.U8                q5,     q5,     q14
        VSUB.I8         q7,     q7,     q5
        VHADD.U8                q6,     q6,     q7
        VRHADD.U8               q7,     q4,     q5
        VHADD.U8                q4,     q4,     q5
        VSUB.I8         q7,     q7,     q4
        VRHADD.U8               q6,     q6,     q7
        VADD.I8         q4,     q4,     q6
        VMOV            q6,     q14
        VBIT            q6,     q4,     q3
        VPUSH           {q6}
        VHADD.U8                q1,     q9,     q13
        VRHADD.U8               q4,     q1,     q10
        VRHADD.U8               q5,     q11,    q12
        VHADD.U8                q6,     q1,     q10
        VHADD.U8                q7,     q11,    q12
        VHADD.U8                q4,     q4,     q5
        VRHADD.U8               q6,     q6,     q7
        VRHADD.U8               q1,     q4,     q6
        VRHADD.U8               q4,     q9,     q10
        VRHADD.U8               q5,     q11,    q12
        VHADD.U8                q6,     q9,     q10
        VHADD.U8                q7,     q11,    q12
        VHADD.U8                q4,     q4,     q5
        VRHADD.U8               q6,     q6,     q7
        VRHADD.U8               q4,     q4,     q6
        VHADD.U8                q5,     q11,    q13
        VRHADD.U8               q5,     q5,     q10
        VBIF            q1,     q5,     q0 
        VBSL            q0,     q4,     q10 
        VHADD.U8                q7,     q14,    q10
        VRHADD.U8               q4,     q7,     q13
        VRHADD.U8               q5,     q11,    q12
        VHADD.U8                q6,     q7,     q13
        VHADD.U8                q7,     q11,    q12
        VHADD.U8                q4,     q4,     q5
        VRHADD.U8               q6,     q6,     q7
        VRHADD.U8               q4,     q4,     q6
        VRHADD.U8               q6,     q14,    q13
        VRHADD.U8               q5,     q11,    q12
        VHADD.U8                q5,     q6,     q5
        VHADD.U8                q6,     q14,    q13
        VHADD.U8                q7,     q11,    q12
        VRHADD.U8               q6,     q6,     q7
        VRHADD.U8               q5,     q5,     q6
        VHADD.U8                q6,     q12,    q10
        VRHADD.U8               q6,     q6,     q13
        VBIF            q4,     q6,     q3 
        VBSL            q3,     q5,     q13 
        VPOP            {q14}
        VPOP            {q9}
        VBIT            q10,    q0,     q2 
        VBIT            q11,    q1,     q2 
        VBIT            q12,    q4,     q2 
        VBIT            q13,    q3,     q2 
        VTRN.8          q8,     q9
        VTRN.8          q10,    q11
        VTRN.8          q12,    q13
        VTRN.8          q14,    q15
        VTRN.16         q8,     q10
        VTRN.16         q9,     q11
        VTRN.16         q12,    q14
        VTRN.16         q13,    q15
        VTRN.32         q8,     q12
        VTRN.32         q9,     q13
        VTRN.32         q10,    q14
        VTRN.32         q11,    q15
        SUB             r0,     r0,     r1,     lsl #4
        VST1.8          {d16},  [r0],   r1
        VST1.8          {d18},  [r0],   r1
        VST1.8          {d20},  [r0],   r1
        VST1.8          {d22},  [r0],   r1
        VST1.8          {d24},  [r0],   r1
        VST1.8          {d26},  [r0],   r1
        VST1.8          {d28},  [r0],   r1
        VST1.8          {d30},  [r0],   r1
        VST1.8          {d17},  [r0],   r1
        VST1.8          {d19},  [r0],   r1
        VST1.8          {d21},  [r0],   r1
        VST1.8          {d23},  [r0],   r1
        VST1.8          {d25},  [r0],   r1
        VST1.8          {d27},  [r0],   r1
        VST1.8          {d29},  [r0],   r1
        VST1.8          {d31},  [r0],   r1
        VPOP            {q4-q7}
        BX              lr
deblock_luma_v:                 
        VPUSH           {q4-q7}
        SUB             r0,     r0,     #4
        VLD1.8          {d16},  [r0],   r1
        VLD1.8          {d18},  [r0],   r1
        VLD1.8          {d20},  [r0],   r1
        VLD1.8          {d22},  [r0],   r1
        VLD1.8          {d24},  [r0],   r1
        VLD1.8          {d26},  [r0],   r1
        VLD1.8          {d28},  [r0],   r1
        VLD1.8          {d30},  [r0],   r1
        VLD1.8          {d17},  [r0],   r1
        VLD1.8          {d19},  [r0],   r1
        VLD1.8          {d21},  [r0],   r1
        VLD1.8          {d23},  [r0],   r1
        VLD1.8          {d25},  [r0],   r1
        VLD1.8          {d27},  [r0],   r1
        VLD1.8          {d29},  [r0],   r1
        VLD1.8          {d31},  [r0],   r1
        VTRN.32         q8,     q12
        VTRN.32         q9,     q13
        VTRN.32         q10,    q14
        VTRN.32         q11,    q15
        VTRN.16         q8,     q10
        VTRN.16         q9,     q11
        VTRN.16         q12,    q14
        VTRN.16         q13,    q15
        VTRN.8          q8,     q9
        VTRN.8          q10,    q11
        VTRN.8          q12,    q13
        VTRN.8          q14,    q15
        ADR             r12,    g_unzip2
        VDUP.8          q3,     r2  
        VABD.U8         q1,     q11,    q12 
        VLD1.8          {q4},   [r12]
        VCLT.U8         q2,     q1,     q3 
        VDUP.8          q3,     r3  
        LDR             r12,    [sp,    #4+16*4] 
        VABD.U8         q1,     q11,    q10 
        VABD.U8         q5,     q12,    q13 
        VMAX.U8         q1,     q1,     q5
        LDR             r12,    [r12]
        VCLT.U8         q1,     q1,     q3 
        VAND            q2,     q2,     q1
        VMOV.32         d2[0],  r12
        VTBL.8          d3,     {d2},   d9
        VTBL.8          d2,     {d2},   d8
        VCGT.S8         q1,     q1,     #0
        VAND            q2,     q2,     q1 
        VMOV.I8         q6,     #1
        LDR             r12,    [sp,    #0+16*4] 
        VHSUB.U8                q7,     q10,    q13 
        VSHR.S8         q7,     q7,     #1 
        VEOR            q0,     q12,    q11
        VAND            q6,     q6,     q0 
        VHSUB.U8                q0,     q12,    q11 
        LDR             r12,    [r12]
        VRHADD.S8               q7,     q7,     q6 
        VQADD.S8                q7,     q0,     q7 
        VAND            q7,     q7,     q2
        VMOV.32         d2[0],  r12
        VTBL.8          d3,     {d2},   d9
        VTBL.8          d2,     {d2},   d8
        VAND            q1,     q1,     q2 
        VABD.U8         q0,     q9,     q11 
        VCLT.U8         q0,     q0,     q3 
        VAND            q4,     q0,     q2 
        VABD.U8         q0,     q14,    q12 
        VCLT.U8         q0,     q0,     q3 
        VAND            q3,     q0,     q2 
        VRHADD.U8               q0,     q11,    q12 
        VHADD.U8                q0,     q0,     q9 
        VAND            q5,     q1,     q4
        VQADD.U8                q6,     q10,    q5 
        VMIN.U8         q0,     q0,     q6
        VQSUB.U8                q6,     q10,    q5 
        VMAX.U8         q10,    q0,     q6
        VRHADD.U8               q0,     q11,    q12 
        VHADD.U8                q0,     q0,     q14 
        VAND            q5,     q1,     q3
        VQADD.U8                q6,     q13,    q5 
        VMIN.U8         q0,     q0,     q6
        VQSUB.U8                q6,     q13,    q5 
        VMAX.U8         q13,    q0,     q6
        VSUB.I8         q1,     q1,     q3
        VSUB.I8         q1,     q1,     q4 
        VAND            q1,     q1,     q2 
        VEOR            q6,     q6,     q6
        VMAX.S8         q5,     q6,     q7 
        VSUB.S8         q7,     q6,     q7
        VMAX.S8         q6,     q6,     q7 
        VMIN.U8         q5,     q1,     q5
        VMIN.U8         q6,     q1,     q6
        VQADD.U8                q11,    q11,    q5
        VQSUB.U8                q11,    q11,    q6
        VQSUB.U8                q12,    q12,    q5
        VQADD.U8                q12,    q12,    q6
        VTRN.8          q8,     q9
        VTRN.8          q10,    q11
        VTRN.8          q12,    q13
        VTRN.8          q14,    q15
        VTRN.16         q8,     q10
        VTRN.16         q9,     q11
        VTRN.16         q12,    q14
        VTRN.16         q13,    q15
        VTRN.32         q8,     q12
        VTRN.32         q9,     q13
        VTRN.32         q10,    q14
        VTRN.32         q11,    q15
        SUB             r0,     r0,     r1,     lsl #4
        VST1.8          {d16},  [r0],   r1
        VST1.8          {d18},  [r0],   r1
        VST1.8          {d20},  [r0],   r1
        VST1.8          {d22},  [r0],   r1
        VST1.8          {d24},  [r0],   r1
        VST1.8          {d26},  [r0],   r1
        VST1.8          {d28},  [r0],   r1
        VST1.8          {d30},  [r0],   r1
        VST1.8          {d17},  [r0],   r1
        VST1.8          {d19},  [r0],   r1
        VST1.8          {d21},  [r0],   r1
        VST1.8          {d23},  [r0],   r1
        VST1.8          {d25},  [r0],   r1
        VST1.8          {d27},  [r0],   r1
        VST1.8          {d29},  [r0],   r1
        VST1.8          {d31},  [r0],   r1
        VPOP            {q4-q7}
        BX              lr
g_unzip2:                       
        .quad           0x0101010100000000
        .quad           0x0303030302020202
deblock_luma_h:                 
        VPUSH           {q4-q7}
        SUB             r0,     r0,     r1
        SUB             r0,     r0,     r1,     lsl #1
        VLD1.8          {q9 },  [r0],   r1 
        VLD1.8          {q10},  [r0],   r1 
        VLD1.8          {q11},  [r0],   r1 
        VLD1.8          {q12},  [r0],   r1 
        VLD1.8          {q13},  [r0],   r1 
        VLD1.8          {q14},  [r0] 
        ADR             r12,    g_unzip2
        VDUP.8          q3,     r2  
        VABD.U8         q1,     q11,    q12 
        VLD1.8          {q4},   [r12]
        VCLT.U8         q2,     q1,     q3 
        VDUP.8          q3,     r3  
        LDR             r12,    [sp,    #4+16*4] 
        VABD.U8         q1,     q11,    q10 
        VABD.U8         q5,     q12,    q13 
        VMAX.U8         q1,     q1,     q5
        LDR             r12,    [r12]
        VCLT.U8         q1,     q1,     q3 
        VAND            q2,     q2,     q1
        VMOV.32         d2[0],  r12
        VTBL.8          d3,     {d2},   d9
        VTBL.8          d2,     {d2},   d8
        VCGT.S8         q1,     q1,     #0
        VAND            q2,     q2,     q1 
        VMOV.I8         q6,     #1
        LDR             r12,    [sp,    #0+16*4] 
        VHSUB.U8                q7,     q10,    q13 
        VSHR.S8         q7,     q7,     #1 
        VEOR            q0,     q12,    q11
        VAND            q6,     q6,     q0 
        VHSUB.U8                q0,     q12,    q11 
        LDR             r12,    [r12]
        VRHADD.S8               q7,     q7,     q6 
        VQADD.S8                q7,     q0,     q7 
        VAND            q7,     q7,     q2
        VMOV.32         d2[0],  r12
        VTBL.8          d3,     {d2},   d9
        VTBL.8          d2,     {d2},   d8
        VAND            q1,     q1,     q2 
        VABD.U8         q0,     q9,     q11 
        VCLT.U8         q0,     q0,     q3 
        VAND            q4,     q0,     q2 
        VABD.U8         q0,     q14,    q12 
        VCLT.U8         q0,     q0,     q3 
        VAND            q3,     q0,     q2 
        VRHADD.U8               q0,     q11,    q12 
        VHADD.U8                q0,     q0,     q9 
        VAND            q5,     q1,     q4
        VQADD.U8                q6,     q10,    q5 
        VMIN.U8         q0,     q0,     q6
        VQSUB.U8                q6,     q10,    q5 
        VMAX.U8         q10,    q0,     q6
        VRHADD.U8               q0,     q11,    q12 
        VHADD.U8                q0,     q0,     q14 
        VAND            q5,     q1,     q3
        VQADD.U8                q6,     q13,    q5 
        VMIN.U8         q0,     q0,     q6
        VQSUB.U8                q6,     q13,    q5 
        VMAX.U8         q13,    q0,     q6
        VSUB.I8         q1,     q1,     q3
        VSUB.I8         q1,     q1,     q4 
        VAND            q1,     q1,     q2 
        VEOR            q6,     q6,     q6
        VMAX.S8         q5,     q6,     q7 
        VSUB.S8         q7,     q6,     q7
        VMAX.S8         q6,     q6,     q7 
        VMIN.U8         q5,     q1,     q5
        VMIN.U8         q6,     q1,     q6
        VQADD.U8                q11,    q11,    q5
        VQSUB.U8                q11,    q11,    q6
        VQSUB.U8                q12,    q12,    q5
        VQADD.U8                q12,    q12,    q6
        SUB             r0,     r0,     r1,     lsl #2
        VST1.8          {q10},  [r0],   r1 
        VST1.8          {q11},  [r0],   r1 
        VST1.8          {q12},  [r0],   r1 
        VST1.8          {q13},  [r0],   r1 
        VPOP            {q4-q7}
        BX              lr
deblock_chroma_v:                       
        VPUSH           {q4-q7}
        SUB             r0,     r0,     #2
        VLD1.8          {d16},  [r0],   r1
        VLD1.8          {d18},  [r0],   r1
        VLD1.8          {d20},  [r0],   r1
        VLD1.8          {d22},  [r0],   r1
        VLD1.8          {d17},  [r0],   r1
        VLD1.8          {d19},  [r0],   r1
        VLD1.8          {d21},  [r0],   r1
        VLD1.8          {d23},  [r0],   r1
        VTRN.32         d16,    d17
        VTRN.32         d18,    d19
        VTRN.32         d20,    d21
        VTRN.32         d22,    d23
        VTRN.16         q8,     q10
        VTRN.16         q9,     q11
        VTRN.8          q8,     q9
        VTRN.8          q10,    q11
        LDR             r12,    [sp,    #4+16*4] 
        VDUP.8          q3,     r2  
        VABD.U8         q1,     q10,    q9 
        VCLT.U8         q2,     q1,     q3 
        VDUP.8          q3,     r3  
        VABD.U8         q1,     q8,     q9 
        VABD.U8         q4,     q10,    q11 
        VMAX.U8         q4,     q1,     q4
        VLD1.8          {d2 },  [r12] 
        VCLT.U8         q4,     q4,     q3 
        VAND            q2,     q2,     q4
        LDR             r12,    [sp,    #0+16*4] 
        VMOV            d0,     d2
        VZIP.8          q1,     q0
        VLD1.8          {d0 },  [r12] 
        VCGT.S8         q3,     q1,     #0 
        VSHR.U8         q1,     q1,     #2 
        VCGT.S8         q1,     q1,     #0 
        VAND            q2,     q2,     q3 
        VMOV            d8,     d0
        VMOV.I8         q6,     #1
        VZIP.8          q0,     q4
        VADD.I8         q0,     q0,     q6 
        VAND            q0,     q0,     q2 
        VHSUB.U8                q7,     q8,     q11 
        VSHR.S8         q7,     q7,     #1 
        VEOR            q4,     q10,    q9
        VAND            q6,     q6,     q4 
        VHSUB.U8                q4,     q10,    q9 
        VRHADD.S8               q7,     q7,     q6 
        VQADD.S8                q7,     q4,     q7 
        VEOR            q4,     q4,     q4
        VMAX.S8         q5,     q4,     q7 
        VSUB.S8         q7,     q4,     q7
        VMAX.S8         q4,     q4,     q7 
        VMIN.U8         q5,     q0,     q5
        VMIN.U8         q4,     q0,     q4
        VQADD.U8                q0,     q9,     q5
        VQSUB.U8                q0,     q0,     q4
        VQSUB.U8                q3,     q10,    q5
        VQADD.U8                q3,     q3,     q4
        VHADD.U8                q6,     q9,     q11
        VRHADD.U8               q6,     q6,     q8
        VHADD.U8                q7,     q8,     q10
        VRHADD.U8               q7,     q7,     q11
        VBIT            q0,     q6,     q1
        VBIT            q3,     q7,     q1
        VBIT            q9,     q0,     q2
        VBIT            q10,    q3,     q2
        VTRN.8          q8,     q9
        VTRN.8          q10,    q11
        VTRN.16         q8,     q10
        VTRN.16         q9,     q11
        VTRN.32         d16,    d17
        VTRN.32         d18,    d19
        VTRN.32         d20,    d21
        VTRN.32         d22,    d23
        SUB             r0,     r0,     r1,     lsl #3
        VMOV.32         r12,    d16[0]
        STR             r12,    [r0],   r1
        VMOV.32         r12,    d18[0]
        STR             r12,    [r0],   r1
        VMOV.32         r12,    d20[0]
        STR             r12,    [r0],   r1
        VMOV.32         r12,    d22[0]
        STR             r12,    [r0],   r1
        VMOV.32         r12,    d17[0]
        STR             r12,    [r0],   r1
        VMOV.32         r12,    d19[0]
        STR             r12,    [r0],   r1
        VMOV.32         r12,    d21[0]
        STR             r12,    [r0],   r1
        VMOV.32         r12,    d23[0]
        STR             r12,    [r0],   r1
        VPOP            {q4-q7}
        BX              lr
deblock_chroma_h:                       
        VPUSH           {q4-q7}
        SUB             r0,     r0,     r1,     lsl #1
        VLD1.8          {q8 },  [r0],   r1 
        VLD1.8          {q9 },  [r0],   r1 
        VLD1.8          {q10},  [r0],   r1 
        VLD1.8          {q11},  [r0] 
        LDR             r12,    [sp,    #4+16*4] 
        VDUP.8          q3,     r2  
        VABD.U8         q1,     q10,    q9 
        VCLT.U8         q2,     q1,     q3 
        VDUP.8          q3,     r3  
        VABD.U8         q1,     q8,     q9 
        VABD.U8         q4,     q10,    q11 
        VMAX.U8         q4,     q1,     q4
        VLD1.8          {d2 },  [r12] 
        VCLT.U8         q4,     q4,     q3 
        VAND            q2,     q2,     q4
        LDR             r12,    [sp,    #0+16*4] 
        VMOV            d0,     d2
        VZIP.8          q1,     q0
        VLD1.8          {d0 },  [r12] 
        VCGT.S8         q3,     q1,     #0 
        VSHR.U8         q1,     q1,     #2 
        VCGT.S8         q1,     q1,     #0 
        VAND            q2,     q2,     q3 
        VMOV            d8,     d0
        VMOV.I8         q6,     #1
        VZIP.8          q0,     q4
        VADD.I8         q0,     q0,     q6 
        VAND            q0,     q0,     q2 
        VHSUB.U8                q7,     q8,     q11 
        VSHR.S8         q7,     q7,     #1 
        VEOR            q4,     q10,    q9
        VAND            q6,     q6,     q4 
        VHSUB.U8                q4,     q10,    q9 
        VRHADD.S8               q7,     q7,     q6 
        VQADD.S8                q7,     q4,     q7 
        VEOR            q4,     q4,     q4
        VMAX.S8         q5,     q4,     q7 
        VSUB.S8         q7,     q4,     q7
        VMAX.S8         q4,     q4,     q7 
        VMIN.U8         q5,     q0,     q5
        VMIN.U8         q4,     q0,     q4
        VQADD.U8                q0,     q9,     q5
        VQSUB.U8                q0,     q0,     q4
        VQSUB.U8                q3,     q10,    q5
        VQADD.U8                q3,     q3,     q4
        VHADD.U8                q6,     q9,     q11
        VRHADD.U8               q6,     q6,     q8
        VHADD.U8                q7,     q8,     q10
        VRHADD.U8               q7,     q7,     q11
        VBIT            q0,     q6,     q1
        VBIT            q3,     q7,     q1
        VBIT            q9,     q0,     q2
        VBIT            q10,    q3,     q2
        SUB             r0,     r0,     r1,     lsl #1
        VST1.8          {d18 }, [r0],   r1 
        VST1.8          {d20},  [r0],   r1 
        VPOP            {q4-q7}
        BX              lr
h264e_deblock_chroma_neon:                      
        PUSH            {r2-r10,        lr}
        MOV             r8,     r0
        LDRB            r0,     [r2,    #0x40]
        MOV             r9,     r1
        LDRB            r1,     [r2,    #0x44]
        ADD             r5,     r2,     #0x40
        ADD             r6,     r2,     #0x44
        ADD             r10,    r2,     #0x20
        MOV             r7,     r2
        MOV             r4,     #0
l1.2056:                        
        LDR             r2,     [r7,    r4]
        CMP             r2,     #0
        CMPNE           r0,     #0
        BEQ             l1.2108
        ADD             r3,     r7,     r4
        ADD             r2,     r10,    r4
        ADD             r12,    r8,     r4,     asr #1
        STRD            r2,     r3,     [sp,    #0]
        MOV             r3,     r1
        MOV             r2,     r0
        MOV             r1,     r9
        MOV             r0,     r12
        BL              deblock_chroma_v
l1.2108:                        
        LDRB            r0,     [r5,    #1]
        ADD             r4,     r4,     #8
        LDRB            r1,     [r6,    #1]
        CMP             r4,     #0x10
        BLT             l1.2056
        LDRB            r0,     [r5,    #2]
        LDRB            r1,     [r6,    #2]
        ADD             r10,    r10,    #0x10
        ADD             r7,     r7,     #0x10
        MOV             r4,     #0
l1.2148:                        
        LDR             r2,     [r7,    r4]
        CMP             r2,     #0
        CMPNE           r0,     #0
        BEQ             l1.2196
        ADD             r3,     r7,     r4
        ADD             r2,     r10,    r4
        STRD            r2,     r3,     [sp,    #0]
        MOV             r3,     r1
        MOV             r2,     r0
        MOV             r1,     r9
        MOV             r0,     r8
        BL              deblock_chroma_h
l1.2196:                        
        LDRB            r0,     [r5,    #3]
        ADD             r4,     r4,     #8
        LDRB            r1,     [r6,    #3]
        CMP             r4,     #0x10
        ADD             r8,     r8,     r9,     lsl #2
        BLT             l1.2148
        POP             {r2-r10,        pc}
h264e_deblock_luma_neon:                        
        PUSH            {r2-r10,        lr}
        MOV             r7,     r0
        LDRB            r0,     [r2,    #0x40]
        MOV             r9,     r1
        LDRB            r1,     [r2,    #0x44]
        ADD             r5,     r2,     #0x40
        ADD             r6,     r2,     #0x44
        ADD             r10,    r2,     #0x20
        MOV             r8,     r2
        MOV             r4,     #0
l1.2264:                        
        LDR             r2,     [r8,    r4]
        AND             r3,     r2,     #0xff
        CMP             r3,     #4
        BEQ             l1.2456
        CMP             r2,     #0
        CMPNE           r0,     #0
        BEQ             l1.2328
        ADD             r3,     r8,     r4
        ADD             r2,     r10,    r4
        ADD             r12,    r7,     r4
        STRD            r2,     r3,     [sp,    #0]
        MOV             r3,     r1
        MOV             r2,     r0
        MOV             r1,     r9
        MOV             r0,     r12
        BL              deblock_luma_v
l1.2328:                        
        LDRB            r0,     [r5,    #1]
        ADD             r4,     r4,     #4
        LDRB            r1,     [r6,    #1]
        CMP             r4,     #0x10
        BLT             l1.2264
        LDRB            r0,     [r5,    #2]
        LDRB            r1,     [r6,    #2]
        ADD             r10,    r10,    #0x10
        ADD             r8,     r8,     #0x10
        MOV             r4,     #0
l1.2368:                        
        LDR             r2,     [r8,    r4]
        AND             r3,     r2,     #0xff
        CMP             r3,     #4
        BEQ             l1.2484
        CMP             r2,     #0
        CMPNE           r0,     #0
        BEQ             l1.2428
        ADD             r3,     r8,     r4
        ADD             r2,     r10,    r4
        STRD            r2,     r3,     [sp,    #0]
        MOV             r3,     r1
        MOV             r2,     r0
        MOV             r1,     r9
        MOV             r0,     r7
        BL              deblock_luma_h
l1.2428:                        
        LDRB            r0,     [r5,    #3]
        ADD             r4,     r4,     #4
        LDRB            r1,     [r6,    #3]
        CMP             r4,     #0x10
        ADD             r7,     r7,     r9,     lsl #2
        BLT             l1.2368
        POP             {r2-r10,        pc}
l1.2456:                        
        ADD             r12,    r7,     r4
        MOV             r3,     r1
        MOV             r2,     r0
        MOV             r1,     r9
        MOV             r0,     r12
        BL              deblock_luma_v_s4
        B               l1.2328
l1.2484:                        
        MOV             r3,     r1
        MOV             r2,     r0
        MOV             r1,     r9
        MOV             r0,     r7
        BL              deblock_luma_h_s4
        B               l1.2428
        .global         deblock_luma_h_s4
        .global         h264e_deblock_chroma_neon
        .global         h264e_deblock_luma_neon
