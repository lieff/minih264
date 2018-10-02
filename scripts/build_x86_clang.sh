_FILENAME=${0##*/}
CUR_DIR=${0/${_FILENAME}}
CUR_DIR=$(cd $(dirname ${CUR_DIR}); pwd)/$(basename ${CUR_DIR})/

pushd $CUR_DIR/..

clang -flto -O3 -std=gnu11 -DH264E_MAX_THREADS=4 -DH264E_SVC_API=1 -DNDEBUG \
-Wall -Wextra \
-ffast-math -fno-stack-protector -fomit-frame-pointer -ffunction-sections -fdata-sections -Wl,--gc-sections \
-o h264enc_x64_clang minih264e_test.c system.c -lm -lpthread