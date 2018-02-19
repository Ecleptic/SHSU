readFile = "./i.txt"


def getNextChar():
    with open(readFile) as fileobj:
        for line in fileobj:
            for ch in line:
                print(ch)
