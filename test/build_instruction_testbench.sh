set -euo pipefail

rm -f mips/**/*.hex

for f in mips/**/*.asm
do
    mips-linux-gnu-as -R -mips1 -mfix7000 -o "$f.out" "$f"
    mips-linux-gnu-ld -e 0xBFC00000 -Ttext 0xBFC00000 -o "$f.out.reloc" "$f.out"
    rm "$f.out"
    mips-linux-gnu-objcopy -O binary -j .text "$f.out.reloc" "$f.bin"
    rm "$f.out.reloc"
    od -An -t x1 "$f.bin" | awk '{$1=$1};1' > "$f.hex"
    rm "$f.bin"
done
