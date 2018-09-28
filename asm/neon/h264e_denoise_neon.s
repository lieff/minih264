        .text
        .align 2                
memcpy_align3:                  
        ldr             r12,    [r1,    #-3]!
local_denoise_1_0:                       
        mov             r3,     r12,    lsr #24
        ldr             r12,    [r1,    #4]!
        subs            r2,     r2,     #4
        orr             r3,     r3,     r12,    lsl #32-24
        str             r3,     [r0],   #4
        bcs             local_denoise_1_0
        b               _memcpy_lastbytes_skip3
memcpy_align2:                  
        ldr             r12,    [r1,    #-2]!
local_denoise_1_1:                       
        mov             r3,     r12,    lsr #16
        ldr             r12,    [r1,    #4]!
        subs            r2,     r2,     #4
        orr             r3,     r3,     r12,    lsl #32-16
        str             r3,     [r0],   #4
        bcs             local_denoise_1_1
        b               _memcpy_lastbytes_skip2
memcpy_align1:                  
        ldr             r12,    [r1,    #-1]!
local_denoise_1_2:                       
        mov             r3,     r12,    lsr #8
        ldr             r12,    [r1,    #4]!
        subs            r2,     r2,     #4
        orr             r3,     r3,     r12,    lsl #32-8
        str             r3,     [r0],   #4
        bcs             local_denoise_1_2
        b               _memcpy_lastbytes_skip1
__rt_memcpy_w:                  
        subs            r2,     r2,     #0x10-4 
local_denoise_1_3:                       
        ldmcsia         r1!,    {r3,    r12}
        stmcsia         r0!,    {r3,    r12}
        ldmcsia         r1!,    {r3,    r12}
        stmcsia         r0!,    {r3,    r12}
        subcss          r2,     r2,     #0x10
        bcs             local_denoise_1_3
        movs            r12,    r2,     lsl #29 
        ldmcsia         r1!,    {r3,    r12}
        stmcsia         r0!,    {r3,    r12}
        ldrmi           r3,     [r1],   #4
        strmi           r3,     [r0],   #4
        moveq           pc,     lr
        sub             r1,     r1,     #3
_memcpy_lastbytes_skip3:                        
        add             r1,     r1,     #1
_memcpy_lastbytes_skip2:                        
        add             r1,     r1,     #1
_memcpy_lastbytes_skip1:                        
        add             r1,     r1,     #1
_memcpy_lastbytes:                      
        movs            r2,     r2,     lsl #31
        ldrmib          r2,     [r1],   #1
        ldrcsb          r3,     [r1],   #1
        ldrcsb          r12,    [r1],   #1
        strmib          r2,     [r0],   #1
        strcsb          r3,     [r0],   #1
        strcsb          r12,    [r0],   #1
        bx              lr
my_memcpy:                      
        cmp             r2,     #3  
        bls             _memcpy_lastbytes
        rsb             r12,    r0,     #0
        movs            r12,    r12,    lsl #31
        ldrcsb          r3,     [r1],   #1
        ldrcsb          r12,    [r1],   #1
        strcsb          r3,     [r0],   #1
        strcsb          r12,    [r0],   #1
        ldrmib          r3,     [r1],   #1
        subcs           r2,     r2,     #2
        submi           r2,     r2,     #1
        strmib          r3,     [r0],   #1
_memcpy_dest_aligned:                   
        subs            r2,     r2,     #4
        bcc             _memcpy_lastbytes
        adr             r12,    __rt_memcpy_w
        and             r3,     r1,     #3
        sub             pc,     r12,    r3,     lsl #5
h264e_denoise_run_neon:                 
        CMP             r2,     #2
        CMPGT           r3,     #2
        BXLE            lr
        PUSH            {r0-r11,        lr}
        SUB             sp,     sp,     #0xc
        SUB             r1,     r2,     #2 
        SUB             r0,     r3,     #2 
        STR             r0,     [sp,    #0+4+4]
        LDR             r4,     [sp,    #0+4+4+4+4+4+4+4+4*9+4]
        LDR             r5,     [sp,    #0+4+4+4+4+4+4+4+4*9]
        STR             r1,     [sp,    #0+4+4+4+4+4]
local_denoise_2_0:                       
        LDR             r0,     [sp,    #0+4+4+4]
        LDR             r1,     [sp,    #0+4+4+4+4]
        ADD             r0,     r0,     r5
        ADD             r1,     r1,     r4
        STR             r0,     [sp,    #0+4+4+4]
        STR             r1,     [sp,    #0+4+4+4+4]
        LDRB            r3,     [r0],   #1
        SUB             r12,    r1,     r4
        STRB            r3,     [r12,   #0]
        ADD             r1,     r1,     #1
        LDR             r12,    [sp,    #0+4+4+4+4+4]
        MOVS            r12,    r12,    lsr #3 
        BEQ             local_denoise_10_0
local_denoise_1_4:                       
        VLD1.U8         {d16},  [r0]
        VLD1.U8         {d17},  [r1]
        SUB             lr,     r0,     #1
        VLD1.U8         {d18},  [lr]
        SUB             lr,     r1,     #1
        VLD1.U8         {d19},  [lr]
        SUB             lr,     r0,     r5
        VLD1.U8         {d20},  [lr]
        SUB             lr,     r1,     r4
        VLD1.U8         {d21},  [lr]
        ADD             lr,     r0,     #1
        VLD1.U8         {d22},  [lr]
        ADD             lr,     r1,     #1
        VLD1.U8         {d23},  [lr]
        ADD             lr,     r0,     r5
        VLD1.U8         {d24},  [lr]
        ADD             lr,     r1,     r4
        VLD1.U8         {d25},  [lr]
        VABDL.U8                q0,     d16,    d17
        VADDL.U8                q1,     d18,    d20
        VADDW.U8                q1,     q1,     d22
        VADDW.U8                q1,     q1,     d24
        VADDL.U8                q2,     d19,    d21
        VADDW.U8                q2,     q2,     d23
        VADDW.U8                q2,     q2,     d25
        VABD.U16                q1,     q1,     q2
        VSHR.U16                q1,     q1,     #2
        VMOV.I16                q2,     #1
        VADD.S16                q0,     q0,     q2
        VADD.S16                q1,     q1,     q2
        VQSHL.S16               q0,     q0,     #7
        VCLS.S16                q2,     q0
        VSHL.S16                q0,     q0,     q2
        VQDMULH.S16             q0,     q0,     q0
        VCLS.S16                q15,    q0
        VSHL.S16                q0,     q0,     q15
        VADD.S16                q2,     q2,     q2
        VADD.S16                q2,     q2,     q15
        VQDMULH.S16             q0,     q0,     q0
        VCLS.S16                q15,    q0
        VSHL.S16                q0,     q0,     q15
        VADD.S16                q2,     q2,     q2
        VADD.S16                q2,     q2,     q15
        VQDMULH.S16             q0,     q0,     q0
        VCLS.S16                q15,    q0
        VSHL.S16                q0,     q0,     q15
        VADD.S16                q2,     q2,     q2
        VADD.S16                q2,     q2,     q15
        VQDMULH.S16             q0,     q0,     q0
        VCLS.S16                q15,    q0
        VADD.S16                q2,     q2,     q2
        VADD.S16                q2,     q2,     q15
        VMOV.I16                q15,    #127
        VSUB.S16                q2,     q15,    q2
        VQSHL.S16               q1,     q1,     #7
        VCLS.S16                q3,     q1
        VSHL.S16                q1,     q1,     q3
        VQDMULH.S16             q1,     q1,     q1
        VCLS.S16                q15,    q1
        VSHL.S16                q1,     q1,     q15
        VADD.S16                q3,     q3,     q3
        VADD.S16                q3,     q3,     q15
        VQDMULH.S16             q1,     q1,     q1
        VCLS.S16                q15,    q1
        VSHL.S16                q1,     q1,     q15
        VADD.S16                q3,     q3,     q3
        VADD.S16                q3,     q3,     q15
        VQDMULH.S16             q1,     q1,     q1
        VCLS.S16                q15,    q1
        VSHL.S16                q1,     q1,     q15
        VADD.S16                q3,     q3,     q3
        VADD.S16                q3,     q3,     q15
        VQDMULH.S16             q1,     q1,     q1
        VCLS.S16                q15,    q1
        VADD.S16                q3,     q3,     q3
        VADD.S16                q3,     q3,     q15
        VMOV.I16                q15,    #127
        VSUB.S16                q3,     q15,    q3
        VQSHL.U16               q3,     q3,     #10
        VSHR.U16                q3,     q3,     #8
        VMOV.I16                q15,    #255
        VSUB.S16                q2,     q15,    q2
        VSUB.S16                q3,     q15,    q3
        VMUL.U16                q2,     q2,     q3
        VMOVL.U8                q0,     d17
        VMULL.U16               q10,    d0,     d4
        VMULL.U16               q11,    d1,     d5
        VMOV.I8         q15,    #255
        VSUB.S16                q2,     q15,    q2
        VMOVL.U8                q0,     d16
        VMLAL.U16               q10,    d0,     d4
        VMLAL.U16               q11,    d1,     d5
        VRSHRN.I32              d0,     q10,    #16
        VRSHRN.I32              d1,     q11,    #16
        VMOVN.I16               d0,     q0
        SUB             r3,     r1,     r4
        VST1.U8         {d0},   [r3]
        ADD             r0,     r0,     #8
        ADD             r1,     r1,     #8
        SUBS            r12,    r12,    #1
        BNE             local_denoise_1_4
local_denoise_10_0:                      
        LDR             r12,    [sp,    #0+4+4+4+4+4]
        ANDS            r12,    r12,    #7
        BNE             tail
tail_ret:                       
        LDRB            r0,     [r0,    #0]
        SUB             r1,     r1,     r4
        STRB            r0,     [r1,    #0]
        LDR             r0,     [sp,    #0+4+4]
        SUBS            r0,     r0,     #1
        STR             r0,     [sp,    #0+4+4]
        BNE             local_denoise_2_0
        LDR             r0,     [sp,    #0+4+4+4]
        LDR             r2,     [sp,    #0+4+4+4+4+4]
        ADD             r1,     r0,     r5
        LDR             r0,     [sp,    #0+4+4+4+4]
        ADD             r2,     r2,     #2
        ADD             r0,     r0,     r4
        BL              my_memcpy
        LDR             r11,    [sp,    #0+4+4+4+4+4+4]
        SUB             r11,    r11,    #2
local_denoise_1_5:                       
        LDR             r0,     [sp,    #0+4+4+4+4]
        SUB             r7,     r0,     r4
        LDR             r0,     [sp,    #0+4+4+4+4+4]
        MOV             r1,     r7
        ADD             r2,     r0,     #2
        LDR             r0,     [sp,    #0+4+4+4+4]
        BL              my_memcpy
        STR             r7,     [sp,    #0+4+4+4+4]
        SUBS            r11,    r11,    #1
        BNE             local_denoise_1_5
        LDR             r0,     [sp,    #0+4+4+4+4+4+4]
        RSB             r1,     r0,     #2
        LDR             r0,     [sp,    #0+4+4+4]
        MLA             r1,     r5,     r1,     r0
        LDR             r0,     [sp,    #0+4+4+4+4+4]
        ADD             r2,     r0,     #2
        LDR             r0,     [sp,    #0+4+4+4+4]
        ADD             sp,     sp,     #0x1c
        POP             {r4-r11,        lr}
        B               my_memcpy
tail:                   
local_denoise_1_6:                       
        LDRB            r3,     [r0,    #-1]
        LDRB            r9,     [r1,    #-1]
        LDRB            r6,     [r0,    #1]
        LDRB            r10,    [r1,    #1]
        SUB             r3,     r3,     r9
        SUB             r9,     r0,     r5
        SUB             r6,     r6,     r10
        ADD             r3,     r3,     r6
        SUB             r6,     r1,     r4
        LDRB            r9,     [r9,    #0]
        LDRB            r10,    [r6,    #0]
        LDRB            r7,     [r0,    #0]
        LDRB            r8,     [r1,    #0]
        LDRB            r11,    [r0,    r5]
        LDRB            lr,     [r1,    r4]
        SUB             r9,     r9,     r10
        SUBS            r2,     r7,     r8
        RSBLT           r2,     r2,     #0
        ADD             r3,     r3,     r9
        SUB             r9,     r11,    lr
        ADDS            r3,     r3,     r9
        RSBLT           r3,     r3,     #0
        MOV             r10,    r3,     asr #2
        LDR             r3,     =g_diff_to_gainQ8
        LDRB            r9,     [r3,    r2]
        LDRB            r2,     [r3,    r10]
        ADD             r0,     r0,     #1
        ADD             r1,     r1,     #1
        MOV             r2,     r2,     lsl #2
        CMP             r2,     #0xff
        MOVHI           r2,     #0xff
        RSB             r3,     r2,     #0xff
        RSB             r2,     r9,     #0xff
        MUL             r2,     r3,     r2
        RSB             r3,     r2,     #0x00010000
        SUB             r3,     r3,     #1
        MUL             r3,     r7,     r3
        MLA             r3,     r8,     r2,     r3
        ADD             r3,     r3,     #0x00008000
        MOV             r3,     r3,     lsr     #16
        STRB            r3,     [r6,    #0]
        SUBS            r12,    r12,    #1
        BNE             local_denoise_1_6
        B               tail_ret

        .global         h264e_denoise_run_neon  
