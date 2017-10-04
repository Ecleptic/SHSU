public class Crypto
{
	public static void main(String [] args)
	{
		String message = "We attack at dawn!";

		char [] ciphertext;

		ciphertext = message.toCharArray();

		short key = 0x000F;

		for(int i = 0; i<ciphertext.length; i++)
		{
			ciphertext[i] = (char)((short) ciphertext[i] ^ key);
		}
		for(int i = 0; i<ciphertext.length; i++)
		{
			System.out.print(ciphertext[i]);
		}
		System.out.println();

		for(int i = 0; i<ciphertext.length; i++)
		{
			ciphertext[i] = (char)((short) ciphertext[i] ^ key);
		}
		for(int i = 0; i<ciphertext.length; i++)
		{
			System.out.print(ciphertext[i]);
		}
		System.out.println();

	}

}