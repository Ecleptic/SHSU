import urllib.request

keywords = ["sale","discount"]
sale = False



while (sale == False):
    address = input("url address from store including the http \n" )
    
    opener = urllib.request.FancyURLopener({})
    webFile = opener.open(address)
    segment = str(webFile.read(500))

    segList = segment.split(" ")

    for i in segList:
        for j in keywords:
            if(i == j):
                print("I think the store has items on sale")
                sale = True

    if(sale == False):
        print("I do not think the store has items on sale")


