#include <assert.h>
#include <stdint.h>
#include <string.h>

#define MINIH264_IMPLEMENTATION
#include "minih264e.h"

static void check_sps(int profile_idc, int width, int height,
                      int vbv_size_bytes, uint8_t expected_constraints,
                      uint8_t expected_level)
{
    uint32_t output_words[64] = {0};
    uint8_t *output = (uint8_t *)output_words;
    h264e_enc_t enc;

    memset(&enc, 0, sizeof(enc));
    enc.out = output;
    enc.frame.w = width;
    enc.frame.h = height;
    enc.frame.nmb = (width / 16) * (height / 16);
    enc.param.width = width;
    enc.param.height = height;
    enc.param.vbv_size_bytes = vbv_size_bytes;

    encode_sps(&enc, profile_idc);

    assert(enc.out_pos > 8);
    assert(output[0] == 0 && output[1] == 0 && output[2] == 0 &&
           output[3] == 1);
    assert(output[4] == (profile_idc == SCALABLE_BASELINE ? 0x6f : 0x67));
    assert(output[5] == profile_idc);
    assert(output[6] == expected_constraints);
    assert(output[7] == expected_level);
}

int main(void)
{
    check_sps(66, 320, 240, 0, 0xc0, 11);
    check_sps(66, 160, 128, 30000, 0xc0, 10);
    check_sps(83, 320, 240, 0, 0, 11);
    return 0;
}
