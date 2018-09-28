_FILENAME=${0##*/}
CUR_DIR=${0/${_FILENAME}}
CUR_DIR=$(cd $(dirname ${CUR_DIR}); pwd)/$(basename ${CUR_DIR})/

pushd $CUR_DIR/..

gcc -flto -O3 -m32 -std=gnu11 -DH264E_MAX_THREADS=4 -DH264E_SVC_API=1 -DNDEBUG \
-Wall -Wextra \
-fno-stack-protector -ffunction-sections -fdata-sections -Wl,--gc-sections \
-o h264enc_x86 minih264e_test.c system.c -lm -lpthread

gcc -flto -O3 -std=gnu11 -DH264E_MAX_THREADS=4 -DH264E_SVC_API=1 -DNDEBUG \
-Wall -Wextra \
-fno-stack-protector -ffunction-sections -fdata-sections -Wl,--gc-sections \
-o h264enc_x64 minih264e_test.c system.c -lm -lpthread