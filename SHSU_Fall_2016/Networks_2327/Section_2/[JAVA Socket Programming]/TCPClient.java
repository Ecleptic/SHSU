import java.io.*;
import java.net.*;

class TCPClient 
{
	public static void main(String args[]) throws Exception
	{
		String sentence;
		String modifiedSentence;				
		
		// Creat Client's socket which will knock the door (whose port # is 6789, and ip address is 158.135.13.18)
		Socket clientSocket = new Socket("158.135.13.18", 6789); // knocked the door		
		System.out.println( "ClientSocket to be connected to the server has been created.");
		
		// Read a message from keyboard to be sent to server
		System.out.print("Message to send: " );
		BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
		sentence = inFromUser.readLine();
		
		// Send request (i.e., the message) using 'clientSocket' 
		DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());
		outToServer.writeBytes(sentence + '\n');
		
		// Read reply from 'clientSocket'
		BufferedReader inFromServer = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));				
		modifiedSentence = inFromServer.readLine();		

		// Show the message on the screen.
		System.out.println("FROM SERVER: " + modifiedSentence);		

		// The socket is closed, and hence the connection between the client and the server is closed.
		clientSocket.close();
	}
}