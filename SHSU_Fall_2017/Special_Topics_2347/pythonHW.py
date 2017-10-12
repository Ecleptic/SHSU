file = 'numbers.txt'
avg = 0
count = 0
with open(file) as f:
    try:
        for line in (f):
            avg += int(line)
            count +=1
    except IOError:
        print('An error occured trying to read the file.')

    except ValueError:
        print('Non-numeric data found in the file.')

    finally:
        print (avg/count)

