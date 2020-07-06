import csv

if __name__ == "__main__":
    with open("mfp_table.csv", "r") as rfile:
        table = csv.reader(rfile)
        table = list(table)
    table  = [(float(item1), float(item2)) for item1, item2 in table  ]
    

    with open("mfp_table.py", "w") as wfile:
        wfile.write("MACHMFP_TAB = [\n")
        for item1, item2 in table:
            wfile.write(f"({item1}, {item2}),\n")
        wfile.write("]")
        