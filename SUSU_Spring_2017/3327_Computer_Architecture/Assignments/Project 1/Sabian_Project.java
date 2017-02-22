import java.io.*;
import java.util.Scanner;

public class Sabian_Project {
	public static void main(String[] args) throws IOException {
		int number;
		boolean endOfFile = false;
		String binNum = "";
		int num6Bit = 0;
		int num16Bit = 0;
		int power;

		Scanner keyboard = new Scanner(System.in);
		System.out.print("Enter name of file to read including extension: ");
		String fileName = keyboard.next();
		FileInputStream fstream = new FileInputStream(fileName);
		DataInputStream inputFile = new DataInputStream(fstream);

		System.out.println();

		while (!endOfFile) {
			try {
				number = inputFile.readInt();
				binNum = Integer.toBinaryString(number);

				while (binNum.length() != 32) {		//add leading zeros
					binNum = "0" + binNum;
				}

				power = 5;		//set count up for 6-bit
				for (int i = 10; i <= 15; i++) {	//form base 10 for 6-bit number
					if (binNum.charAt(i) == '1') {
						num6Bit = num6Bit + (int)Math.pow(2, power);
					}
					power--;
				}

				power = 15;		//set count up for 16-bit
				for (int i = 16; i <= 31; i++) {	//form base 10 for 16-bit number
					if (binNum.charAt(i) == '1') {
						num16Bit = num16Bit + (int)Math.pow(2, power);
					}
					power--;
				}

				System.out.printf(binNum + "\t" + "%08x \t" + num6Bit + "\t" + num16Bit + "\n", number);
				num6Bit = 0;
				num16Bit = 0;
			}
			catch (EOFException e) {
				endOfFile = true;
			}
		}

		System.out.println("\nDone!");
		inputFile.close();
	}
}
