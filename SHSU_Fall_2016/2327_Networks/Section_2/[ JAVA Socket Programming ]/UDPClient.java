/*** Socket Programming with UDP ***/

import java.io.*;
import java.net.*;
import java.util.Scanner;

class UDPClient
{
	public static void main(String args[]) throws Exception
	{		
		byte[] sendData = new byte[1024];
		byte[] receiveData = new byte[1024];

		DatagramSocket clientSocket = new DatagramSocket(); // create a socket for the client. port # is automatically assigned in this case.

		// Read a message from keyboard to be sent to server
		BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
		String sentence = inFromUser.readLine();
		sendData = sentence.getBytes();

		// Send request (i.e., the message) using 'clientSocket' 
		InetAddress IPAddress = InetAddress.getByName("158.135.13.18"); // IP address of host (server)
		DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, IPAddress, 9876);
		clientSocket.send(sendPacket);

		// Read reply from 'clientSocket'
		DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
		clientSocket.receive(receivePacket);
		String modifiedSentence = new String(receivePacket.getData());

		// Show the message on the screen.
		System.out.println("FROM SERVER:" + modifiedSentence);
		
		// The socket is closed.
		clientSocket.close();
	}
}