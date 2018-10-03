_FILENAME=${0##*/}
CUR_DIR=${0/${_FILENAME}}
CUR_DIR=$(cd $(dirname ${CUR_DIR}); pwd)/$(basename ${CUR_DIR})/

pushd $CUR_DIR/..

# why pthreads broken?
clang -static -O3 -std=gnu11 -target arm-linux-gnueabihf -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=hard -marm \
-Wall -Wextra \
-ffast-math -fno-stack-protector -fomit-frame-pointer -ffunction-sections -fdata-sections -Wl,--gc-sections -ftree-vectorize \
-DH264E_MAX_THREADS=0 -DH264E_SVC_API=0 -DNDEBUG -D__NO_MATH_INLINES \
-o h264enc_arm_clang minih264e_test.c -lm

arm-linux-gnueabihf-gcc -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=hard -c asm/neon/*.s

clang -static -O3 -std=gnu11 -target arm-linux-gnueabihf -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=hard -marm \
-Wall -Wextra \
-ffast-math -fno-stack-protector -fomit-frame-pointer -ffunction-sections -fdata-sections -Wl,--gc-sections -ftree-vectorize \
-DH264E_MAX_THREADS=0 -DH264E_SVC_API=0 -DNDEBUG -D__NO_MATH_INLINES -DMINIH264_ASM \
-o h264enc_arm_clang_asm minih264e_test.c *.o -lm
rm *.o

clang -static -O3 -std=gnu11 -target aarch64-linux-gnu -mfpu=neon -mfloat-abi=hard \
-Wall -Wextra \
-ffast-math -fno-stack-protector -fomit-frame-pointer -ffunction-sections -fdata-sections -Wl,--gc-sections -ftree-vectorize \
-DH264E_MAX_THREADS=0 -DH264E_SVC_API=0 -DNDEBUG -D__NO_MATH_INLINES \
-o h264enc_arm64_clang minih264e_test.c -lm
