_FILENAME=${0##*/}
CUR_DIR=${0/${_FILENAME}}
CUR_DIR=$(cd $(dirname ${CUR_DIR}); pwd)/$(basename ${CUR_DIR})/

pushd $CUR_DIR/..

arm-linux-gnueabihf-gcc -static -flto -O3 -std=gnu11 -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=hard \
-Wall -Wextra \
-ffast-math -fomit-frame-pointer -ffunction-sections -fdata-sections -Wl,--gc-sections -ftree-vectorize \
-DH264E_MAX_THREADS=4 -DH264E_SVC_API=1 -DNDEBUG \
-o h264enc_arm_gcc minih264e_test.c system.c -lm -lpthread

arm-linux-gnueabihf-gcc -static -flto -O3 -std=gnu11 -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=hard \
-Wall -Wextra \
-ffast-math -fomit-frame-pointer -ffunction-sections -fdata-sections -Wl,--gc-sections -ftree-vectorize \
-DH264E_MAX_THREADS=4 -DH264E_SVC_API=1 -DNDEBUG -DMINIH264_ASM \
-o h264enc_arm_gcc_asm minih264e_test.c system.c asm/neon/*.s -lm -lpthread

aarch64-linux-gnu-gcc -static -flto -O3 -std=gnu11 \
-Wall -Wextra \
-ffast-math -fomit-frame-pointer -ffunction-sections -fdata-sections -Wl,--gc-sections -ftree-vectorize \
-DH264E_MAX_THREADS=4 -DH264E_SVC_API=1 -DNDEBUG \
-o h264enc_arm64_gcc minih264e_test.c system.c -lm -lpthread
