        .text
        .align 2                
        .global         h264e_qpel_average_wh_align_neon
        .global         h264e_qpel_interpolate_luma_neon
        .global         h264e_qpel_interpolate_chroma_neon
h264e_qpel_average_wh_align_neon:                       
        MOVS            r3,     r3,     lsr #5
        BCC             local_qpel_20_0
local_qpel_1_0:                       
        VLDMIA          r0!,    {q0-q3}
        VLDMIA          r1!,    {q8-q11}
        SUBS            r3,     r3,     #4<<11
        VRHADD.U8               q0,     q0,     q8
        VRHADD.U8               q1,     q1,     q9
        VRHADD.U8               q2,     q2,     q10
        VRHADD.U8               q3,     q3,     q11
        VSTMIA          r2!,    {q0-q3}
        BNE             local_qpel_1_0
        BX              lr
local_qpel_20_0:                      
        MOV             r12,    #16
local_qpel_1_1:                       
        VLD1.8          {d0},   [r0],   r12
        VLD1.8          {d1},   [r1],   r12
        SUBS            r3,     r3,     #1<<11
        VRHADD.U8               d0,     d0,     d1
        VST1.8          {d0},   [r2],   r12
        BNE             local_qpel_1_1
        BX              lr
copy_w8or4:                     
        MOVS            r12,    r3,     lsr #4 
        MOV             r3,     r3,     asr #16 
        BCS             copy_w8
copy_w4:                        
local_qpel_1_2:                       
        LDR             r12,    [r0],   r1
        SUBS            r3,     r3,     #1
        STR             r12,    [r2],   #16
        BNE             local_qpel_1_2
        BX              lr
copy_w16or8:                    
        MOVS            r12,    r3,     lsr #5 
        MOV             r3,     r3,     asr #16 
        BCC             copy_w8
copy_w16:                       
        VLD1.8          {q0},   [r0],   r1
        VLD1.8          {q1},   [r0],   r1
        VLD1.8          {q2},   [r0],   r1
        VLD1.8          {q3},   [r0],   r1
        SUBS            r3,     r3,     #4
        VSTMIA          r2!,    {q0-q3}
        BNE             copy_w16
        BX              lr
copy_w8:                        
        MOV             r12,    #16
local_qpel_1_3:                       
        VLD1.8          {d0},   [r0],   r1
        VLD1.8          {d1},   [r0],   r1
        SUBS            r3,     r3,     #2
        VST1.8          {d0},   [r2],   r12
        VST1.8          {d1},   [r2],   r12
        BNE             local_qpel_1_3
        BX              lr
h264e_qpel_interpolate_chroma_neon:                     
        LDR             r12,    [sp]
        VMOV.I8         d5,     #8
        CMP             r12,    #0
        BEQ             copy_w8or4
        VDUP.8          d0,     r12
        MOV             r12,    r12,    asr #16 
        VDUP.8          d1,     r12
        VSUB.I8         d2,     d5,     d0
        VSUB.I8         d3,     d5,     d1
        VMUL.I8         d28,    d2,     d3
        VMUL.I8         d29,    d0,     d3
        VMUL.I8         d30,    d2,     d1
        VMUL.I8         d31,    d0,     d1
        MOVS            r12,    r3,     lsr #4 
        MOV             r3,     r3,     asr #16 
        BCS             interpolate_chroma_w8
interpolate_chroma_w4:                  
        VLD1.8          {d0},   [r0],   r1
        VEXT.8          d1,     d0,     d0,     #1
local_qpel_1_4:                       
        VLD1.8          {d2},   [r0],   r1
        SUBS            r3,     r3,     #1
        VEXT.8          d3,     d2,     d2,     #1
        VMULL.U8                q2,     d0,     d28
        VMLAL.U8                q2,     d1,     d29
        VMLAL.U8                q2,     d2,     d30
        VMLAL.U8                q2,     d3,     d31
        VQRSHRUN.S16            d4,     q2,     #6
        VMOV            r12,    d4[0]
        STR             r12,    [r2],   #16
        VMOV            q0,     q1
        BNE             local_qpel_1_4
        BX              lr
interpolate_chroma_w8:                  
        VLD1.8          {q0},   [r0],   r1
        MOV             r12,    #16
        VEXT.8          d1,     d0,     d1,     #1
local_qpel_1_5:                       
        VLD1.8          {q1},   [r0],   r1
        SUBS            r3,     r3,     #1
        VEXT.8          d3,     d2,     d3,     #1
        VMULL.U8                q2,     d0,     d28
        VMLAL.U8                q2,     d1,     d29
        VMLAL.U8                q2,     d2,     d30
        VMLAL.U8                q2,     d3,     d31
        VQRSHRUN.S16            d4,     q2,     #6
        VST1.8          {d4},   [r2],   r12
        VMOV            q0,     q1
        BNE             local_qpel_1_5
        BX              lr
h264e_qpel_interpolate_luma_neon:                       
        LDR             r12,    [sp]
        VMOV.I8         d0,     #5
        CMP             r12,    #0
        BEQ             copy_w16or8
        PUSH            {r4,    r7,     r10,    r11,    lr}
        MOV             lr,     #16
        MOV             r4,     sp
        SUB             sp,     sp,     #16*16
        MOV             r7,     sp
        BIC             r7,     r7,     #15
        MOV             sp,     r7
        PUSH            {r2,    r4}
        MOV             r11,    #1
        ADD             r10,    r12,    #0x00010000
        ADD             r10,    r10,    r11
        ADD             r12,    r12,    r12,    lsr #14
        MOV             r11,    r11,    lsl r12
        LDR             r12,    =0xbbb0e0ee
        MOV             r7,     r0
        TST             r12,    r11
        BEQ             local_qpel_10_0
        TST             r10,    #0x00040000
        ADDNE           r0,     r0,     r1
        MOVS            r4,     r3,     lsr #5 
        MOV             r4,     r3,     asr #16 
        VSHL.I8         d1,     d0,     #2
        SUB             r0,     r0,     #2
        BCC             flt_luma_hor_w8
local_qpel_1_6:                       
        VLD1.8          {q8,    q9},    [r0],   r1
        SUBS            r4,     r4,     #1
        VEXT.8          q11,    q8,     q9,     #1
        VEXT.8          q12,    q8,     q9,     #2
        VEXT.8          q13,    q8,     q9,     #3
        VEXT.8          q14,    q8,     q9,     #4
        VEXT.8          q15,    q8,     q9,     #5
        VADDL.U8                q1,     d16,    d30
        VADDL.U8                q2,     d17,    d31
        VMLSL.U8                q1,     d22,    d0
        VMLSL.U8                q2,     d23,    d0
        VMLAL.U8                q1,     d24,    d1
        VMLAL.U8                q2,     d25,    d1
        VMLAL.U8                q1,     d26,    d1
        VMLAL.U8                q2,     d27,    d1
        VMLSL.U8                q1,     d28,    d0
        VMLSL.U8                q2,     d29,    d0
        VQRSHRUN.S16            d2,     q1,     #5
        VQRSHRUN.S16            d3,     q2,     #5
        VSTMIA          r2!,    {q1}
        BNE             local_qpel_1_6
        B               flt_luma_hor_end
flt_luma_hor_w8:                        
local_qpel_1_7:                       
        VLD1.8          {q8},   [r0],   r1
        SUBS            r4,     r4,     #1
        VEXT.8          d22,    d16,    d17,    #1
        VEXT.8          d24,    d16,    d17,    #2
        VEXT.8          d26,    d16,    d17,    #3
        VEXT.8          d28,    d16,    d17,    #4
        VEXT.8          d30,    d16,    d17,    #5
        VADDL.U8                q1,     d16,    d30
        VMLSL.U8                q1,     d22,    d0
        VMLAL.U8                q1,     d24,    d1
        VMLAL.U8                q1,     d26,    d1
        VMLSL.U8                q1,     d28,    d0
        VQRSHRUN.S16            d2,     q1,     #5
        VST1.8          {d2},   [r2],   lr
        BNE             local_qpel_1_7
flt_luma_hor_end:                       
        SUB             r2,     r3,     asr #12 
        MOV             r0,     r7
        ADD             r2,     sp,     #4*2
local_qpel_10_0:                      
        TST             r11,    r12,    lsr #16
        BEQ             local_qpel_10_1
        MOV             r0,     r7
        TST             r10,    #0x0004
        ADDNE           r0,     r0,     #1
        MOVS            r4,     r3,     lsr #5 
        MOV             r4,     r3,     asr #16 
        VMOV.I8         d0,     #5
        VSHL.I8         d1,     d0,     #2
        SUB             r0,     r0,     r1,     lsl #1
        BCC             flt_luma_ver_w8
        VLD1.8          {q10},  [r0],   r1
        VLD1.8          {q11},  [r0],   r1
        VLD1.8          {q12},  [r0],   r1
        VLD1.8          {q13},  [r0],   r1
        VLD1.8          {q14},  [r0],   r1
local_qpel_1_8:                       
        VLD1.8          {q15},  [r0],   r1
        VADDL.U8                q1,     d20,    d30
        VADDL.U8                q2,     d21,    d31
        VMLSL.U8                q1,     d22,    d0
        VMLSL.U8                q2,     d23,    d0
        VMLAL.U8                q1,     d24,    d1
        VMLAL.U8                q2,     d25,    d1
        VMLAL.U8                q1,     d26,    d1
        VMLAL.U8                q2,     d27,    d1
        VMLSL.U8                q1,     d28,    d0
        VMLSL.U8                q2,     d29,    d0
        VQRSHRUN.S16            d2,     q1,     #5
        VQRSHRUN.S16            d3,     q2,     #5
        VSTMIA          r2!,    {q1}
        VMOV            q10,    q11
        VMOV            q11,    q12
        VMOV            q12,    q13
        VMOV            q13,    q14
        VMOV            q14,    q15
        SUBS            r4,     r4,     #1
        BNE             local_qpel_1_8
        B               flt_luma_ver_end
flt_luma_ver_w8:                        
        VLD1.8          {d20},  [r0],   r1
        VLD1.8          {d22},  [r0],   r1
        VLD1.8          {d24},  [r0],   r1
        VLD1.8          {d26},  [r0],   r1
        VLD1.8          {d28},  [r0],   r1
local_qpel_1_9:                       
        VLD1.8          {d30},  [r0],   r1
        VADDL.U8                q1,     d20,    d30
        VMLSL.U8                q1,     d22,    d0
        VMLAL.U8                q1,     d24,    d1
        VMLAL.U8                q1,     d26,    d1
        VMLSL.U8                q1,     d28,    d0
        VQRSHRUN.S16            d2,     q1,     #5
        VST1.8          {d2},   [r2],   lr
        VMOV            d20,    d22
        VMOV            d22,    d24
        VMOV            d24,    d26
        VMOV            d26,    d28
        VMOV            d28,    d30
        SUBS            r4,     r4,     #1
        BNE             local_qpel_1_9
flt_luma_ver_end:                       
        SUB             r2,     r3,     asr #12 
        MOV             r0,     r7
        ADD             r2,     sp,     #4*2
local_qpel_10_1:                      
        LDR             r12,    =0xfafa4e40
        TST             r12,    r11
        BEQ             local_qpel_10_2
        MOV             r0,     r7
        SUB             sp,     sp,     #(8) 
        VPUSH           {q4-q7}
        MOVS            r4,     r3,     lsr #5 
        MOV             r4,     r3,     asr #16 
        VMOV.I8         d0,     #5
        VSHL.I8         d1,     d0,     #2
        SUB             r0,     r0,     #2
        SUB             r0,     r0,     r1,     lsl #1
        ADD             r2,     r2,     r4,     lsl #4 
        ADD             r4,     r4,     #5 
        BCC             flt_luma_diag_w8
local_qpel_1_10:                      
        VLD1.8          {q8,    q9},    [r0],   r1
        VMOV            q10,    q8
        VEXT.8          q11,    q8,     q9,     #1
        VEXT.8          q12,    q8,     q9,     #2
        VEXT.8          q13,    q8,     q9,     #3
        VEXT.8          q14,    q8,     q9,     #4
        VEXT.8          q15,    q8,     q9,     #5
        VADDL.U8                q1,     d20,    d30
        VADDL.U8                q2,     d21,    d31
        VMLSL.U8                q1,     d22,    d0
        VMLSL.U8                q2,     d23,    d0
        VMLAL.U8                q1,     d24,    d1
        VMLAL.U8                q2,     d25,    d1
        VMLAL.U8                q1,     d26,    d1
        VMLAL.U8                q2,     d27,    d1
        VMLSL.U8                q1,     d28,    d0
        VMLSL.U8                q2,     d29,    d0
        VPUSH           {q1,    q2}
        SUBS            r4,     r4,     #1
        BNE             local_qpel_1_10
        MOV             r4,     r3,     asr #16 
        VPOP            {q4-q9}
        VPOP            {q10-q15}
local_qpel_1_11:                      
        SUBS            r4,     r4,     #1
        SUB             r2,     r2,     #16
        VADD.S16                q4,     q4,     q14
        VADD.S16                q5,     q5,     q15
        VADD.S16                q2,     q6,     q12
        VADD.S16                q3,     q7,     q13
        VADD.S16                q0,     q8,     q10
        VADD.S16                q1,     q9,     q11
        VSUB.S16                q4,     q4,     q2
        VSUB.S16                q5,     q5,     q3
        VSUB.S16                q2,     q2,     q0
        VSUB.S16                q3,     q3,     q1
        VSHR.S16                q4,     q4,     #2
        VSHR.S16                q5,     q5,     #2
        VSUB.S16                q4,     q4,     q2
        VSUB.S16                q5,     q5,     q3
        VSHR.S16                q4,     q4,     #2
        VSHR.S16                q5,     q5,     #2
        VADD.S16                q4,     q4,     q0
        VADD.S16                q5,     q5,     q1
        VQRSHRUN.S16            d2,     q4,     #6
        VQRSHRUN.S16            d3,     q5,     #6
        VST1.8          {q1},   [r2]
        VMOV            q4,     q6
        VMOV            q5,     q7
        VMOV            q6,     q8
        VMOV            q7,     q9
        VMOV            q8,     q10
        VMOV            q9,     q11
        VMOV            q10,    q12
        VMOV            q11,    q13
        VMOV            q12,    q14
        VMOV            q13,    q15
        VPOPNE          {q14,   q15}
        BNE             local_qpel_1_11
        B               flt_luma_diag_end
flt_luma_diag_w8:                       
local_qpel_1_12:                      
        VLD1.8          {q8},   [r0],   r1
        VMOV            d20,    d16
        VEXT.8          d22,    d16,    d17,    #1
        VEXT.8          d24,    d16,    d17,    #2
        VEXT.8          d26,    d16,    d17,    #3
        VEXT.8          d28,    d16,    d17,    #4
        VEXT.8          d30,    d16,    d17,    #5
        VADDL.U8                q1,     d20,    d30
        VMLSL.U8                q1,     d22,    d0
        VMLAL.U8                q1,     d24,    d1
        VMLAL.U8                q1,     d26,    d1
        VMLSL.U8                q1,     d28,    d0
        VPUSH           {q1}
        SUBS            r4,     r4,     #1
        BNE             local_qpel_1_12
        MOV             r4,     r3,     asr #16 
        VPOP            {q4}
        VPOP            {q6}
        VPOP            {q8}
        VPOP            {q10}
        VPOP            {q12}
local_qpel_1_13:                      
        VPOP            {q14}
        SUBS            r4,     r4,     #1
        SUB             r2,     r2,     #16
        VADD.S16                q4,     q4,     q14
        VADD.S16                q2,     q6,     q12
        VADD.S16                q0,     q8,     q10
        VSUB.S16                q4,     q4,     q2
        VSUB.S16                q2,     q2,     q0
        VSHR.S16                q4,     q4,     #2
        VSUB.S16                q4,     q4,     q2
        VSHR.S16                q4,     q4,     #2
        VADD.S16                q4,     q4,     q0
        VQRSHRUN.S16            d2,     q4,     #6
        VST1.8          {d2},   [r2]
        VMOV            q4,     q6
        VMOV            q6,     q8
        VMOV            q8,     q10
        VMOV            q10,    q12
        VMOV            q12,    q14
        BNE             local_qpel_1_13
flt_luma_diag_end:                      
        VPOP            {q4-q7}
        ADD             sp,     sp,     #(8) 
        ADD             r2,     sp,     #4*2
local_qpel_10_2:                      
        TST             r11,    r12,    lsr #16
        BEQ             local_qpel_10_3
        LDR             r12,    =0xeae0
        TST             r12,    r11
        LDR             r2,     [sp]
        BEQ             local_qpel_20_1
        ADD             r0,     sp,     #4*2
        LDR             r3,     =0x00100010
        MOV             r1,     r2
        BL              h264e_qpel_average_wh_align_neon
        B               local_qpel_10_3
local_qpel_20_1:                      
        MOV             r0,     r7
        TST             r10,    #0x0004
        ADDNE           r0,     r0,     #1
        TST             r10,    #0x00040000
        ADDNE           r0,     r0,     r1
        LDR             r2,     [sp]
        MOV             r12,    #4
local_qpel_1_14:                      
        VLD1.8          {q8},   [r0],   r1
        VLD1.8          {q9},   [r0],   r1
        VLD1.8          {q10},  [r0],   r1
        VLD1.8          {q11},  [r0],   r1
        SUBS            r12,    r12,    #1
        VLDMIA          r2,     {q0-q3}
        VRHADD.U8               q0,     q8
        VRHADD.U8               q1,     q9
        VRHADD.U8               q2,     q10
        VRHADD.U8               q3,     q11
        VSTMIA          r2!,    {q0-q3}
        BNE             local_qpel_1_14
local_qpel_10_3:                      
        LDR             sp,     [sp,    #4]
        POP             {r4,    r7,     r10,    r11,    pc}
