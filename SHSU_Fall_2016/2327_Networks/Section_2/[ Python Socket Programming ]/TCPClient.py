#TCP client program
import sys
from socket import *

serverName = '127.0.0.1'
serverPort = 12000

# create a socket and connect to server
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((serverName, serverPort))


# get the data from user via stdin
sentence = raw_input('Input in lower case sentence:\n')
clientSocket.send(sentence)
modifiedSentence = clientSocket.recv(1024)
print "From server: ", modifiedSentence
clientSocket.close()