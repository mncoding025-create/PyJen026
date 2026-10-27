def add(a, b):
    """บวกเลขสองจำนวน"""
    return a + b


def main():
    a = float(input("ใส่เลขตัวที่ 1: "))
    b = float(input("ใส่เลขตัวที่ 2: "))
    print(f"ผลบวก = {add(a, b)}")


if __name__ == "__main__":
    main()
