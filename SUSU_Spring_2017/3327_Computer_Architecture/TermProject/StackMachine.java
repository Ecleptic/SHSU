import java.util.Stack;
import java.io.*;
import java.util.Scanner;


// here's a start of a program in case you don't know where to begin;

public class StackMachine
{
	final int MAX_CODE = 65536;   	// size of code memory
	final int MAX_DATA = 65536;		// size of data memory

	final int HALT = 0;			// a few opcodes defined
	final int PUSH = 1;
	final int RVALUE = 2;
	final int LVALUE = 3;
	final int POP = 4;
	final int STO = 5;
	final int COPY = 6;
	final int ADD = 7;
	final int SUB = 8;
	final int MPY = 9;
	final int DIV = 10;
	final int MOD = 11;
	final int NEG = 12;
	final int NOT = 13;
	final int OR = 14;
	final int AND = 15;
	final int EQ = 16;
	final int NE = 17;
	final int GT = 18;
	final int GE = 19;
	final int LT = 20; 
	final int LE = 21;
	final int LABEL = 22;
	final int GOTO = 23;
	final int GOFALSE = 24;
	final int GOTRUE = 25;
	final int PRINT = 26;
	final int READ = 27;
	final int GOSUB = 28;
	final int RET = 29;
	final int ORB = 30;
	final int ANDB = 31;
	final int XORB = 32;
	final int SHL = 33;
	final int SHR = 34;
	final int SAR = 35;
	final int ASGN 	= 36;

    static String fileName;

	int [] code;					// reference for the memory modules
	int [] data;
	int PC;							// we need a couple of registers
	int IR;
	boolean run;
	Stack<Integer> stack;			// data stack
	Stack<Integer> callStack;		// call stack

	public StackMachine()
	{

		code = new int[MAX_CODE];		// constructor initializes the stack machine;
		data = new int[MAX_DATA];
		PC = 0;
		run = true;
		stack = new Stack<Integer>();
		callStack = new Stack<Integer>();

	}

    public void loadInstructions() throws IOException
	{
		FileInputStream fstream = new FileInputStream(fileName);
		DataInputStream inputFile = new DataInputStream(fstream);
		boolean endOfFile = false;
		int number;
		int count = 0;
		
		while (!endOfFile) {
			try {
				number = inputFile.readInt();
				code[count] = number;
				count++;
			}
			catch (EOFException e) {
				endOfFile = true;
			}
		}
	}

	public void execute()
	{
		while(run)							// the old fetch-execute cycle
		{
			getNextInstruction();
			decodeAndRunInstruction();
		}
	}

	public void getNextInstruction()
	{
		IR = code[PC++];					// fetching is straighforward
	}

	public void decodeAndRunInstruction()
	{
		int opcode = IR >> 16;				// pull of the opcode and the operands
		int	operand   = IR & 0xFFFF;

		switch(opcode)						// what we do depends on what opcode we have
		{									// most of these are pretty straight forward
			case HALT:
				run = false;
				break;
			case PUSH:						
			// push a literal value
				stack.push(operand);
				break;
			case RVALUE:					
			// push the contents of a memory address
				stack.push(data[operand]);
				break;
			case LVALUE:					
			// push the address (which, come to think of it, is exactly the same as pushing a literal)
				stack.push(operand);
				break;

			case POP:						
			// store the value on top of the stack in the address directly below it on the stack
				int rvalue4 = stack.pop();
				int lvalue4 = stack.pop();
				data[lvalue4] = rvalue4;
				break;

			case STO:
				stack.push(operand);
				break;

			case COPY:
				int rvalue6 = stack.pop();
				int lvalue6 = stack.pop();
				data[lvalue6] = rvalue6;
				stack.push(rvalue6);
				break;

			case ADD:
				int rvalue7 = stack.pop();
				int lvalue7 = stack.pop();
				int add7 = (rvalue7 + lvalue7);
				stack.push(add7);
				break;

			case SUB:
				int rvalue8 = stack.pop();
				int lvalue8 = stack.pop();
				int sub8 = (rvalue8 - lvalue8);
				stack.push(sub8);
				break;

			case MPY:
				int rvalue9 = stack.pop();
				int lvalue9 = stack.pop();
				int mpy9 = (rvalue9 * lvalue9);
				stack.push(mpy9);
				break;

			case DIV:
				int rvalue10 = stack.pop();
				int lvalue10 = stack.pop();
				int div10 = (rvalue10 / lvalue10);
				stack.push(div10);
				break;

			case MOD:
				int rvalue11 = stack.pop();
				int lvalue11 = stack.pop();
				int mod11 = (rvalue11% lvalue11);
				stack.push(mod11);
				break;

			case NEG:
				int rvalue12 = stack.pop();
				int neg12 = (rvalue12 * -1);
				stack.push(neg12);
				break;

				
			case NOT:
			    String rvalue13 = Integer.toBinaryString(stack.pop());
				String not13 = rvalue13;
				not13 = rvalue13.replaceAll("0", "x");
				not13 = rvalue13.replaceAll("1", "0");
				not13 = rvalue13.replaceAll("x", "1");
				stack.push(Integer.parseInt(not13));
			break;

			case  OR:
				// pop the top two values off the stack, compute the logical OR, and push the result
				break;
			case AND:
			     int rvalue15 = stack.pop();
			     int lvalue15 = stack.pop();
			     if ( lvalue15 != 0 && rvalue15 != 0 )
			     { 
			         stack.push( 1 );
			     }
			     else
			     {
			         stack.push(0);
			         stack.push( rvalue15 & lvalue15 );
			     }
				// pop the top two values off the stack, compute the logical AND, and push the result
				break;
			case EQ:
			  int rvalue16 = stack.pop();
			 int lvalue16 = stack.pop();
			 if(rvalue16 == lvalue16){
			   stack.push(1);
}
			 else{
				stack.push(0);
			}
			break;
			   
			   
			   // pop the top two values off the stack, compare them, 
//				                                  and push a 1 if they are equal, and a 0 if they are not 

			case NE:
		      int rvalue17 = stack.pop();
			 int lvalue17 = stack.pop();
			 if(rvalue17 != lvalue17){
			   stack.push(1);
}
			 else{
				stack.push(0);
			}
			break;
//				break;
			case GT:
			int rvalue18 = stack.pop();
			int lvalue18 = stack.pop();
			if(rvalue18 > lvalue18){
			  stack.push(1);
						}
			else{
			stack.push(0);
					}
			break;

			case GE:
			int rvalue19 = stack.pop();
			int lvalue19 = stack.pop();
			if(rvalue19 >= lvalue19){
			  stack.push(1);
									}
			else{
			stack.push(0);
					}
			break;

			case LT:
			int rvalue20 = stack.pop();
			int lvalue20 = stack.pop();
			if(rvalue20 < lvalue20){
			stack.push(1);
									}
			else{
			stack.push(0);
					}
			break;

			case LE:
			int rvalue21 = stack.pop();
			int lvalue21 = stack.pop();
			if(rvalue21 <= lvalue21){
			stack.push(1);
				}
						else{
			stack.push(0);
					}
			break;
			case LABEL:
				//  serves as the target of jumps to n; has no other effect
				break;
			case GOTO:
				// the next instruction is taken from statement with label n
				break;
			case GOFALSE:
				// pop the top value; jump if it is zero
				int rvalue24 = stack.pop();
				if(rvalue24 == 0){
				    break;
				} 
//				break;
			case GOTRUE:
				// pop the top value; jump  if it is nonzero
				int rvalue25 = stack.pop();
				if(rvalue25 != 0){
				    break;
				}
//				break;
			case PRINT:
				// pop the top value off the stack and display it as a base 10 integer
				int rvalue26 = stack.pop();
				System.out.println(rvalue26);	
				break;

			case READ:
				// read a base 10 integer from the keyboard and push its value on the stack
				Scanner keyboard = new Scanner(System.in);
                System.out.println("enter a base 10 integer");
                int rvalue27 = keyboard.nextInt(); 
                stack.push(rvalue27);
				break;
				
			case GOSUB:
				// push the current value of the program counter on the call stack and transfer control to the      statement with label 'l'
				
				break;
			case RET:
				// pop the top value off the call stack and store it in the program counter
				PC = stack.pop();
				break;
				
			case ORB:
				// pop the top two values off the stack, compute the bitwise OR, and push the result
				int lvalue30 = stack.pop();
				int rvalue30 = stack.pop();
				int andb30 = (lvalue30 | rvalue30);
				stack.push(andb30);
				break;
				
			case ANDB:
				// pop the top two values off the stack, compute the bitwise AND, and push the result
				int lvalue31 = stack.pop();
				int rvalue31 = stack.pop();
				int andb31 = (lvalue31 & rvalue31);
				stack.push(andb31);

				break;
				
			case XORB:
				 //pop the top two values off the stack, compute the bitwise XOR, and push the result
				 int lvalue32 = stack.pop();
				int rvalue32 = stack.pop();
				int andb32 = (lvalue32 ^ rvalue32);
				stack.push(andb32);
				break;
				
			case SHL:
				// pop the top value off the stack, logical shift the bits left by 1 bit, and push the result
				int lvalue33 = stack.pop();
				int rvalue33 << lvalue33;
				stack.push(rvalue33);

				break;
				
			case SHR:
				// pop the top value off the stack, logical shift the bits right by 1 bit, and push the result
				break;
				
			case SAR:
				// pop the top value off the stack, arithmetic shift the bits right by 1 bit, and push the result
				break;
				
			case ASGN:						
			    // store the value on top of the stack in the address directly below it on the stack
				int rvalue36 = stack.pop();
				int lvalue36 = stack.pop();
				data[lvalue36] = rvalue36;
				final int POP = 4;
				break;


			default:						// oops!
				System.err.println("Unimplemented opcode");
				System.exit(opcode);
		}
		if (IR == 0) run = false; 			// Isn't this redundant?  Oh, well leave it in for now
	}


	public static void main(String [] args)
	{
		StackMachine vm = new StackMachine();			// create our virtual stack machine


		System.out.println("Beginning Execution...");
		
		fileName = args[0];
		
		try {
			vm.loadInstructions(); //cameron's naming it readbin
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		vm.execute();									// and, let it go, let it go .....
		System.out.println("Done");
	}
	

}
