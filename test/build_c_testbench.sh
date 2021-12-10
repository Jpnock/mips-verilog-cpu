for f in mips/**/*.c
do
    mips-linux-gnu-gcc -O1 -fno-toplevel-reorder -ffreestanding -nostdlib -fno-pie -EB -mips1 -mfp32 -Wa,"-R,-mips1,-march=mips1,-mfp32" -Wl,"-e 0xBFC00008,-Ttext=0xBFC00008" -o "$f.out" "$f"
    mips-linux-gnu-objcopy -O binary -j .text "$f.out" "$f.bin"
    rm "$f.out"
    # Initialise the stack pointer (requires a 4KiB RAM)
    od -An -t x1 "$f.bin" | { echo -n "3c 1d bf c0 37 bd 0f fc "; awk '{$1=$1};1'; } > "$f.hex"
    rm "$f.bin"
done
