for f in mips/**/*.asm
do
    mips-linux-gnu-as -R -mips1 -o "$f.out" "$f"
    mips-linux-gnu-objcopy -O binary -j .text "$f.out" "$f.bin"
    rm "$f.out"
    od -An -t x1 "$f.bin" | awk '{$1=$1};1' > "$f.hex"
    rm "$f.bin"
done
