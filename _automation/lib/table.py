class Row:
    def __init__(self, value, runtime, file_size, stripped_size):
        self.compile_cmd = value
        self.mean, self.stddev = runtime
        self.file_size = file_size
        self.stripped_size = stripped_size

    def __str__(self):
        sb = []
        sb.append("| ")
        text = self.compile_cmd
        if "`" in self.compile_cmd:
            text = f"``{text}``"
        else:
            text = f"`{text}`"
        #
        sb.append(text)
        sb.append(" | ")
        sb.append(f"{self.mean} ± {self.stddev}")
        sb.append(" | ")
        #
        if self.file_size == "--":
            sb.append("--")
        else:
            sb.append("{:,}".format(self.file_size))
        sb.append(" | ")
        #
        if self.stripped_size == "--":
            sb.append("--")
        else:
            sb.append("{:,}".format(self.stripped_size))
        sb.append(" |")
        #
        sb.append("\n")
        #
        return "".join(sb)


class Table:
    def __init__(self):
        self.top = []
        self.rows = []

    def build_headers_part(self, config):
        sb = []
        headers = config["table_headers"]
        # row 1
        sb.append("|")
        for h in headers:
            sb.append(" ")
            sb.append(h)
            sb.append(" |")
        sb.append("\n")
        # row 2
        line = "|-----|"
        for i in range(len(headers) - 1):
            line += ":---:|"
        line += "\n"
        sb.append(line)
        # sb.append("|-----|:---:|:---:|:---:|\n")
        #
        self.top = sb

    def get_headers_part(self):
        return "".join(self.top)

    def add_row(self, value, runtime, file_size="--", stripped_size="--"):
        self.rows.append(Row(value, runtime, file_size, stripped_size))

    def sort(self):
        self.rows.sort(key=lambda row: row.mean, reverse=True)

    def __str__(self):
        sb = []
        sb.append(self.get_headers_part())
        for row in self.rows:
            sb.append(str(row))
        #
        return "".join(sb)
