#define H264E_API(type, name, args) type name args; \
type name##_sse2 args;  \
type name##_arm11 args; \
type name##_neon args;
// h264e_qpel
H264E_API(void, h264e_qpel_interpolate_chroma, (const uint8_t *src,int src_stride, uint8_t *h264e_restrict dst,point_t wh, point_t dxdy))
H264E_API(void, h264e_qpel_interpolate_luma, (const uint8_t *src,int src_stride, uint8_t *h264e_restrict dst,point_t wh, point_t dxdy))
H264E_API(void, h264e_qpel_average_wh_align, (const uint8_t *p0, const uint8_t *p1, uint8_t *h264e_restrict d, point_t wh))
// h264e_deblock
H264E_API(void, h264e_deblock_chroma, (uint8_t *pSrcDst, int32_t srcdstStep, const deblock_params_t *par))
H264E_API(void, h264e_deblock_luma, (uint8_t *pSrcDst, int32_t srcdstStep, const deblock_params_t *par))
// h264e_intra
H264E_API(void, h264e_intra_predict_chroma,  (pix_t *predict, const pix_t *left, const pix_t *top, int mode))
H264E_API(void, h264e_intra_predict_16x16, (pix_t *predict, const pix_t *left, const pix_t *top, int mode))
H264E_API(int,  h264e_intra_choose_4x4, (const pix_t *blockin, pix_t *blockpred, int avail, const pix_t *edge, int mpred, int penalty))
// h264e_cavlc
H264E_API(void,     h264e_bs_put_bits, (bs_t *bs, unsigned n, unsigned val))
H264E_API(void,     h264e_bs_flush, (bs_t *bs))
H264E_API(unsigned, h264e_bs_get_pos_bits, (const bs_t *bs))
H264E_API(unsigned, h264e_bs_byte_align, (bs_t *bs))
H264E_API(void,     h264e_bs_put_golomb, (bs_t *bs, unsigned val))
H264E_API(void,     h264e_bs_put_sgolomb, (bs_t *bs, int val))
H264E_API(void,     h264e_bs_init_bits, (bs_t *bs, void *data))
H264E_API(void,     h264e_vlc_encode, (bs_t *bs, int16_t *quant, int maxNumCoeff, uint8_t *nz_ctx))
// h264e_sad
H264E_API(int,  h264e_sad_mb_unlaign_8x8, (const pix_t *a, int a_stride, const pix_t *b, int sad[4]))
H264E_API(int,  h264e_sad_mb_unlaign_wh, (const pix_t *a, int a_stride, const pix_t *b, point_t wh))
H264E_API(void, h264e_copy_8x8, (pix_t *d, int d_stride, const pix_t *s))
H264E_API(void, h264e_copy_16x16, (pix_t *d, int d_stride, const pix_t *s, int s_stride))
H264E_API(void, h264e_copy_borders, (unsigned char *pic, int w, int h, int guard))
// h264e_transform
H264E_API(void, h264e_transform_add, (pix_t *out, int out_stride, const pix_t *pred, quant_t *q, int side, int32_t mask))
H264E_API(int,  h264e_transform_sub_quant_dequant, (const pix_t *inp, const pix_t *pred, int inp_stride, int mode, quant_t *q, const uint16_t *qdat))
H264E_API(void, h264e_quant_luma_dc, (quant_t *q, int16_t *deq, const uint16_t *qdat))
H264E_API(int,  h264e_quant_chroma_dc, (quant_t *q, int16_t *deq, const uint16_t *qdat))
// h264e_denoise
H264E_API(void, h264e_denoise_run, (unsigned char *frm, unsigned char *frmprev, int w, int h, int stride_frm, int stride_frmprev))
#undef H264E_API
