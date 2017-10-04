import java.io.*;
import java.net.*;

class TCPServer 
{
	public static void main(String argv[]) throws Exception
	{
		String clientSentence;
		String capitalizedSentence;

		// Creat 'Welcome Socket' for port # 6789
		ServerSocket welcomeSocket = new ServerSocket(6789);

		while(true) 
		{
			// When a client knocks the door, open the door
			// i.e., Open connection, and creat a new socket 'Connection Socket'
			Socket connectionSocket = welcomeSocket.accept();
			System.out.println("Socket created.");

			// Read request (message) from 'connectionSocket'
			BufferedReader inFromClient = new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
			clientSentence = inFromClient.readLine();
			System.out.println("Message received from the client: " + clientSentence);
			
			// Write reply to 'connectionSocket'
			DataOutputStream outToClient =	new DataOutputStream(connectionSocket.getOutputStream());
			capitalizedSentence = clientSentence.toUpperCase() + '\n';
			outToClient.writeBytes(capitalizedSentence);
		}
	}
}
