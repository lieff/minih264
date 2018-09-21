_FILENAME=${0##*/}
CUR_DIR=${0/${_FILENAME}}
CUR_DIR=$(cd $(dirname ${CUR_DIR}); pwd)/$(basename ${CUR_DIR})/

pushd $CUR_DIR/..

qemu-arm -d in_asm,exec,nochain ./h264enc_clang vectors/foreman.cif 2>&1 | ./qemu-prof