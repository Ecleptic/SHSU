// import java.util.Scanner;

import java.io.*;
import java.lang.*;

public class ReadBin {
    public static void main(String[] args) throws IOException {
        String Source = Paths.get("").toAbsolutePath() + "/numbers.bin";
        ArrayList<Integer> numbersToConvert = new ArrayList<Integer>();
        try {
            if (args.length > 0) {
                source = Paths.get("").toAbsolutePath() + "/" + args[0];
                File numberFile = new File(source);
                FileInputStream in = new FileInputStream(numberFile);
                DataInputStream dis = new DataInputStream(in);
                while (!endOfFile) {
                    Integer number = Byte.toUnsignedInt(scan.nextByte());
                    numbersToConvert.add(number);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }
}
