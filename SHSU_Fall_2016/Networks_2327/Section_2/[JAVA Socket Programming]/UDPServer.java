/*** Socket Programming with UDP ***/

import java.io.*;
import java.net.*;

class UDPServer
{
	public static void main(String args[]) throws Exception
	{
		byte[] receiveData = new byte[1024];
		byte[] sendData = new byte[1024];

		// Creat a socket for port # 9876
		DatagramSocket serverSocket = new DatagramSocket(9876);		
		
		while(true)
		{
			DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);

			// Read request (message) from 'connectionSocket'
			serverSocket.receive(receivePacket);

			String sentence = new String( receivePacket.getData() ); // extract the data from the packet and place the data in the String 'sentence'
			System.out.println("RECEIVED: " + sentence);
			InetAddress IPAddress = receivePacket.getAddress(); // extract client's (source's) IP address 
			int port = receivePacket.getPort(); // extract client's (source's) port #
			
			/* It is necessary for the server to obtain the address (IP address, Port #) of the client,
			so that it can send the capitalized sentence back to the client. */
			
			// Write reply to 'connectionSocket'
			String capitalizedSentence = sentence.toUpperCase();
			sendData = capitalizedSentence.getBytes();
			DatagramPacket sendPacket =	new DatagramPacket(sendData, sendData.length, IPAddress, port);
			serverSocket.send(sendPacket);
		}
	}
}