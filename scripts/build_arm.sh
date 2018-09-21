_FILENAME=${0##*/}
CUR_DIR=${0/${_FILENAME}}
CUR_DIR=$(cd $(dirname ${CUR_DIR}); pwd)/$(basename ${CUR_DIR})/

pushd $CUR_DIR/..

arm-linux-gnueabihf-gcc -static -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=hard \
-flto -O3 -std=gnu11 -ffast-math -fomit-frame-pointer -ftree-vectorize \
-DH264E_MAX_THREADS=4 -DH264E_SVC_API=1 -DNDEBUG -D__arm \
-o h264enc_arm_gcc8 minih264e_test.c system.c -lm -lpthread