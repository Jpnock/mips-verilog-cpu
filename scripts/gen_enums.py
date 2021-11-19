
def gen_3x3(file_name, prefix):
    with open(file_name) as f:
        raw = f.read()
    lines = raw.split('\n')
    for i, line in enumerate(lines):
        row_entries = line.split(' ')
        for j, entry in enumerate(row_entries):
            if entry == "*":
                continue
            print(f"{prefix}_{entry} = 6'b{i:03b}{j:03b},")

#gen_3x3("function_table.ssv", "FUNC")
gen_3x3("opcode_table.ssv", "OP")