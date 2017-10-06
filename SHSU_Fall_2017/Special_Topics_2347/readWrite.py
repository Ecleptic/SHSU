def main():
    infile = open('philosophers.txt','r') # r = read # w = write
    line1 = infile.readline()
    line2 = infile.readline()
    line3 = infile.readline()

    infile.close()


outfile = open('philosophers2.txt','a') # a = append

outfile.write('JohnLocke Again\n')
outfile.write('David Hume Again\n')
outfile.write('Edmund Burke Again\n')

    print(infile)

    print(line1)
    print(line2)
    print(line3)

main()