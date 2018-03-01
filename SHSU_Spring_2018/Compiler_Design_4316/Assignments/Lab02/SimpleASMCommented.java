import java.util.*;
import java.io.*;

//  Storing my names as enums for comparison.
public class SimpleAsm {
	public enum opcodeNums {
		HALT, PUSH, RVALUE, LVALUE, POP, STO, COPY, ADD, SUB, MPY, DIV, MOD, NEG, NOT, OR, AND, EQ, NE, GT, GE, LT, LE, LABEL, GOTO, GOFALSE, GOTRUE, PRINT, READ, GOSUB, RET
	};

	// creating my output stream so I can access it outside of the main function

	public static FileOutputStream writer = null;

	public static String[] opcodes = { "HALT", "PUSH", "RVALUE", "LVALUE", "POP", "STO", "COPY", "ADD", "SUB", "MPY",
			"DIV", "MOD", "NEG", "NOT", "OR", "AND", "EQ", "NE", "GT", "GE", "LT", "LE", "LABEL", "GOTO", "GOFALSE",
			"GOTRUE", "PRINT", "READ", "GOSUB", "RET" };

	public static void main(String[] args) throws IOException {
		try {
			// named it .bin but it will write in ascii by default
			writer = (new FileOutputStream("output.bin"));
		} catch (Exception e) {
		}

		// get filename
		String filename;
		// symtab is a list of symbols and an array list.
		List<Symbol> symTab = new ArrayList<>();

		// what the filename will be written to
		if (args.length != 0) {
			filename = args[0];
		} else {
			filename = "lab1.asm";
		}

		// Open file for input
		Scanner infile = new Scanner(new File(filename));

		// pass 1 -- build symbol table
		pass1(infile, symTab);
		dumpSymbolTable(symTab);
		infile.close();

		// pass 2 -- assemble
		// reopen source file
		infile = new Scanner(new File(filename));

		// pass 2 -- output binary code
		pass2(infile, symTab);
		infile.close();

		// print symbol table
		dumpSymbolTable(symTab);

		// close writer
		writer.close();

		System.out.println("Done");

	}

	// figures out where in the opcode string list the searched opcode is.
	public static int lookUpOpcode(String s) {
		for (int i = 0; i < opcodes.length; i++) {
			if (s.equalsIgnoreCase(opcodes[i])) {
				return i;
			}
		}
		System.err.println("\nInvalid opcode:" + s);
		return -1;
	}

	/**
	 * PASS 1
	 */
	public static void pass1(Scanner infile, List<Symbol> tab) {
		// initialize location counter, etc.
		int locationCounter = 0;
		String line;
		Scanner input;
		String lexeme;

		// find start of data section
		// if there's no ".data" then it closes the program
		do {
			line = infile.nextLine();
			System.out.println(line);
			input = new Scanner(line);
		} while (!input.next().equalsIgnoreCase("Section"));
		if (!input.next().equalsIgnoreCase(".data")) {
			System.err.println("Error:  Missing 'Section .data' directive");
			System.exit(1);
		} else {
			System.out.println("Parsing data section, pass 1");
		}

		// build symbol table from variable declarations
		line = infile.nextLine();
		input = new Scanner(line);

		// data section ends where code section begins
		while (!(lexeme = input.next()).equalsIgnoreCase("Section")) {
			// look for labels (they end with a colon)
			int pos = lexeme.indexOf(':');
			// if label exists, place it in our lexeme
			if (pos > 0) {
				lexeme = lexeme.substring(0, pos);
			} else {
				System.err.println("error parsing " + line);
			}
			// insert the lexeme, the type, and its address into the symbol table list
			tab.add(new Symbol(lexeme, "Int", locationCounter));
			locationCounter++;
			line = infile.nextLine();
			input = new Scanner(line);
		}

		// Now, parse the code section, looking for the label directive
		System.out.println("Parsing code section, pass 1");
		locationCounter = 0;
		while (infile.hasNext()) {
			line = infile.nextLine();
			input = new Scanner(line);
			lexeme = input.next();
			// when a label is found, place it and its code offset in the symbol table
			if (lexeme.equalsIgnoreCase("label")) {
				lexeme = input.next();
				tab.add(new Symbol(lexeme, "Code", locationCounter));
			}
			locationCounter++;
		}
	}

	/**
	 * PASS 2
	 *
	 * generate the code
	 */
	public static void pass2(Scanner infile, List<Symbol> tab) {
		// initialize location counter, etc.
		int locationCounter = 0;
		String line;
		Scanner input;
		String lexeme;
		int symTabPtr;
		Symbol entry;
		final int NULL = -1;
		// find start of next section
		do {
			line = infile.nextLine();
			input = new Scanner(line);

		} while (!input.next().equalsIgnoreCase("Section"));
		if (!input.next().equalsIgnoreCase(".data")) {
			System.err.println("Error:  Missing 'Section .data' directive");
			System.exit(1);
		} else {
			System.out.println("Parsing data section, pass 2");
		}
		line = infile.nextLine();
		input = new Scanner(line);

		while (!(lexeme = input.next()).equalsIgnoreCase("Section")) {
			// data section has been processed in previous pass, so skip this
			line = infile.nextLine();
			input = new Scanner(line);
		}

		// Now, let's generate some code
		System.out.println("Parsing code section, pass 2");
		locationCounter = 0;
		// while not end of file keep parsing
		while (infile.hasNext()) {
			line = infile.nextLine();
			input = new Scanner(line);
			lexeme = input.next();
			int ptr;
			//	lookup opcode and generate appropriate instructions
			opcodeNums opcode = opcodeNums.values()[lookUpOpcode(lexeme)];
			switch (opcode) {
			case HALT:
			case POP:
			case STO:
			case COPY:
			case ADD:
			case SUB:
			case MPY:
			case DIV:
			case MOD:
			case NEG:
			case NOT:
			case OR:
			case AND:
			case EQ:
			case NE:
			case GT:
			case GE:
			case LT:
			case LE:
			case LABEL:
			case PRINT:
			case READ:
			case RET:
				insertCode(locationCounter, opcode.ordinal());
				break;
			case PUSH:
				lexeme = input.next();
				insertCode(locationCounter, opcode.ordinal(), Integer.parseInt(lexeme));
				break;
			case RVALUE:
			case LVALUE:
			case GOTO:
			case GOFALSE:
			case GOTRUE:
			case GOSUB:
				lexeme = input.next();
				// System.out.println("lexeme:" + lexeme);
				ptr = lookup(tab, lexeme);
				insertCode(locationCounter, opcode.ordinal(), tab.get(ptr).address);
				break;
			default:
				System.err.println("Unimplemented opcode:  " + opcode);
				System.exit(opcode.ordinal());
			}
			locationCounter++;
		}
	}

	public static void insertCode(int loc, int opcode, int operand) {
		// System.out.println(Integer.toHexString(opcode) + "\t" + Integer.toHexString(operand));

		try {
			// write the opcodes then operands
			writer.write(toBytes(opcode), 2, 2);
			writer.write(toBytes(operand), 2, 2);

		} catch (Exception err) {
		}
	}

	public static void insertCode(int loc, int opcode) {
		insertCode(loc, opcode, 0);
	}

	public static int lookup(List<Symbol> symtab, String lexeme) {
		// loop through symtab and try to match a lexeme. return the number address in the symbol table
		// if not, return -1
		for (int i = 0; i < symtab.size(); i++) {
			if (symtab.get(i).lexeme.equals(lexeme)) {
				return i;
			}
		}
		return -1;
	}

	public static void dumpSymbolTable(List<Symbol> tab) {
		System.out.println("\nlexeme \ttype \taddress");
		System.out.println("-----------------------------------------");
		for (int i = 0; i < tab.size(); i++) {
			System.out.println(tab.get(i));
		}
	}

	static byte[] toBytes(int i) {
		byte[] result = new byte[4];

		result[0] = (byte) (i >> 24);
		result[1] = (byte) (i >> 16);
		result[2] = (byte) (i >> 8);
		result[3] = (byte) (i /*>> 0*/);

		return result;
	}
}
