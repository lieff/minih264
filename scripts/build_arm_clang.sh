_FILENAME=${0##*/}
CUR_DIR=${0/${_FILENAME}}
CUR_DIR=$(cd $(dirname ${CUR_DIR}); pwd)/$(basename ${CUR_DIR})/

pushd $CUR_DIR/..

# why pthreads broken?
clang -static -target arm-linux-gnueabihf -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=hard \
-O3 -std=gnu11 -ffast-math -fomit-frame-pointer -ftree-vectorize \
-DH264E_MAX_THREADS=0 -DH264E_SVC_API=0 -DNDEBUG -D__arm -D__NO_MATH_INLINES \
-o h264enc_clang minih264e_test.c -lm
