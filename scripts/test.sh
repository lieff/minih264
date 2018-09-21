_FILENAME=${0##*/}
CUR_DIR=${0/${_FILENAME}}
CUR_DIR=$(cd $(dirname ${CUR_DIR}); pwd)/$(basename ${CUR_DIR})/

pushd $CUR_DIR/..

./h264enc_x86 vectors/foreman.cif
if ! cmp ./out.264 vectors/out_ref.264 >/dev/null 2>&1
then
    echo test failed
    exit 1
fi
rm out.264
qemu-arm ./h264enc_arm_gcc8 vectors/foreman.cif
if ! cmp ./out.264 vectors/out_ref.264 >/dev/null 2>&1
then
    echo test failed
    exit 1
fi
rm out.264
echo test passed
