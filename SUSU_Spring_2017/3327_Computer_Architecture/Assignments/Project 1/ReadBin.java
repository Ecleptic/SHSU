import java.util.Scanner;
import java.io.*;
import java.lang.*;

public class ReadBin {
public static void main(String[] args) throws IOException {
        int number;
        String numBin = "";
        int num6 = 0;
        int num16 = 0;
        boolean endOfFile = false;
        int power;


        // Scanner keyboard = new Scanner(System.in);
        // System.out.print("Type Filename Here: \n");
        // String file = keyboard.next();
        String file = "numbers.bin";
        FileInputStream fstream = new FileInputStream(file);
        DataInputStream inputFile = new DataInputStream(fstream);

        // System.out.println();
        System.out.println("Reading numbers from the file:");
        System.out.println(" \t 32-bit Binary\t\t       8-digit hex \t  6-bit unsigned      16-bit ");
        while (!endOfFile) {
                try {
                        number = inputFile.readInt();
                        numBin = Integer.toBinaryString(number);

                        while(numBin.length() != 32) {
                                numBin = "0" + numBin;
                        }
                        power = 5; // add the leading zeroes so that they're the same thing.
                        for (int i=10; i<=15; i++) {
                                if(numBin.charAt(i)=='1') {
                                        num6 = num6 + (int)Math.pow(2, power);
                                }
                                power--;
                        }

                        power = 15;   //
                        for (int i = 16; i <= 31; i++) {  //
                                if (numBin.charAt(i) == '1') {
                                        num16 = num16 + (int)Math.pow(2, power);
                                }
                                power--;
                        }
                        System.out.printf(numBin+"\t"+"%08x \t\t"+num6+"\t\t"+num16+"\n",number);
                        num6 = 0;
                        num16 = 0;


                } catch (Exception ex) {
                        System.out.println("");
                        endOfFile = true;
                        // ex.printStackTrace();
                }
        }
        inputFile.close();

}
}
