/***************************************************************
Title:	  SAW_StackMachine
Purpose:  Develop an emulator for a hypothetical stack machine operating on 32 bit integers
Author:   Shelby Wagner
date:     5-2-17
Version:  1.0
Additional instructions:  Should read a set of machine instructions from a binary file, program should stop upon a HALT instruction.
*****************************************************************/

import java.util.Stack;
import java.util.Scanner;
import java.io.*;

public class SAW_StackMachine
{
	final int MAX_CODE = 65536;   	// size of code memory
	final int MAX_DATA = 65536;		// size of data memory

	final int HALT 	= 0;// let's define our opcodes

	final int PUSH 	= 1;

	final int RVALUE = 2;

	final int LVALUE = 3;

	final int POP = 4;

	final int STO = 5;

	final int COPY = 6;

	final int ADD = 7;

	final int SUB = 8;

	final int MPY = 9;

	final int DIV  = 10;

	final int MOD  = 11;

	final int NEG  = 12;

	final int NOT = 13;

	final int OR = 14;

	final int AND = 15;

	final int EQ  = 16;

	final int NE  = 17;

	final int GT  = 18;

	final int GE = 19;

	final int LT = 20;

	final int LE = 21;

	final int LABEL = 22;

	final int GOTO	= 23;

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

	int [] code;					// reference for the memory modules
	int [] data;
	int PC;							// we need a couple of registers
	int IR;
	boolean run;
	Stack<Integer> stack;			// data stack
	Stack<Integer> callStack;		// call stack

	public SAW_StackMachine()throws IOException //throws IOException needed for input files
	{
		Scanner sc = new Scanner(System.in);
		int x = 0; //so we can fill our code array in with input
		boolean EOF = false;

		code = new int[MAX_CODE];		// constructor initializes the stack machine;
		data = new int[MAX_DATA];
		PC = 0;
		run = true;
		stack = new Stack<Integer>();
		callStack = new Stack<Integer>();


		//need to get input file for test
		System.out.print("Please enter .bin file you wish to read: "); //get file for our instructions
		String FileToInput = sc.nextLine();

		//Declare input stream where we will get our numbers

		FileInputStream fstream = new FileInputStream(FileToInput); //Numbers.bin

		//FileInputStream fstream = new FileInputStream("Numbers.bin"); //Numbers.bin
		DataInputStream inputFile = new DataInputStream(fstream);

		while(!EOF) //while NOT EOF read in an inputfile
		{
			try
			{
			//will fill code array with instructions from .bin file
			 int number = inputFile.readInt();
			 code[x] = number;
			 x++;
		 	}//end of try

		 catch (EOFException e)
		 {
			 EOF = true;
		 }//end of catch

		 }//end of while


	}//end of SAW_StackMachine


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
		Scanner sc = new Scanner(System.in);
		int opcode = IR >> 16;				// pull of the opcode and the operands
		int	operand = IR & 0xFFFF;

		int N;
		int value1;
		int value2;
		int result;
		String binstring;

		switch(opcode)						// what we do depends on what opcode we have
		{									// most of these are pretty straight forward
			case HALT:
				run = false;
				break;

			case PUSH:						// push a literal value
				stack.push(operand);
				break;

			case POP:						//pop value off stack and throw it away
				stack.pop();
				break;

			case LVALUE:					// push the contents of a memory address
				stack.push(data[operand]);
				break;

			case RVALUE:					// push the address
				stack.push(operand);
				break;

			case STO:						// store the value on top of the stack in the address directly below it on the stack
				int rvalue = stack.pop();
				int lvalue = stack.pop();
				data[lvalue] = rvalue;
				break;

			case ADD:						//pop two values off the stack add them then push result
				value1 = stack.pop();
				value2 = stack.pop();
				result = value1 + value2;
				stack.push(result);
				break;

			case SUB:
				value1 = stack.pop();
				value2 = stack.pop();
				result = value1 - value2;
				stack.push(result);
				break;

			case MPY:
				value1 = stack.pop();
				value2 = stack.pop();
				result = value1 * value2;
				stack.push(result);
				break;

			case DIV:
				value1 = stack.pop();
				value2 = stack.pop();
				if(value2 == 0){
					System.out.println("Error division by zero!");
				}
				else{
					result = value1 / value2;
					stack.push(result);
				}
				break;

			case MOD:
				value1 = stack.pop();
				value2 = stack.pop();
				result = value1 % value2;
				stack.push(result);
				break;

			case COPY:
				value1 = stack.get(0);
				stack.push(value1);
				break;

			case NEG:
				value1 = stack.pop();
				result = value1 * -1;
				stack.push(result);
				break;

			case NOT:
				value1 = stack.pop();
				value1 = ~value1;
				stack.push(value1);
				break;

			case OR:
				value1 = stack.pop();
				value2 = stack.pop();
				if(value1 != 0 || value2 != 0){
					stack.push(1);
				}
				else{
					stack.push(0);
				}
				break;

			case AND:
				value1 = stack.pop();
				value2 = stack.pop();
				if(value1 != 0 && value2 != 0){
					stack.push(1);
				}
				else{
					stack.push(0);
				}
				break;


			case ORB:
				value1 = stack.pop();
				value2 = stack.pop();
				result = value1 | value2;
				stack.push(result);
				break;

			case ANDB:
				value1 = stack.pop();
				value2 = stack.pop();
				result = value1 & value2;
				stack.push(result);
				break;

			case XORB:
				value1 = stack.pop();
				value2 = stack.pop();
				result = value1 ^ value2;
				stack.push(result);
				break;

			case EQ:
				value1 = stack.pop();
				value2 = stack.pop();

				if (value1 == value2){
					stack.push(1);
				}
				else{
					stack.push(0);
				}
				break;

			case NE:
				value1 = stack.pop();
				value2 = stack.pop();

				if (value1 != value2){
					stack.push(1);
				}
				else{
					stack.push(0);
				}
				break;

			case GT:
				value1 = stack.pop();
				value2 = stack.pop();

			 	if (value1 > value2){
					stack.push(1);
				}
				else{
					stack.push(0);
				}
				break;

			case GE:
				value1 = stack.pop();
				value2 = stack.pop();

				if (value1 >= value2){
					stack.push(1);
				}
				else{
					stack.push(0);
				}
				break;

			case LT:
				value1 = stack.pop();
				value2 = stack.pop();

				if (value1 < value2){
					stack.push(1);
					}
				else{
					stack.push(0);
				}
				break;

			case LE:
				value1 = stack.pop();
				value2 = stack.pop();

				if (value1 <= value2){
					stack.push(1);
					}
				else{
					stack.push(0);
				}
				break;

			case LABEL:
				//null opcode
				break;

			case GOTO:
				PC = operand++;
				break;

			case GOFALSE:
				value1 = stack.pop();
				if (value1 == 0){
					N = operand;
					PC = N;
				}
				else{
					System.out.println("Gofalse did not work");
				}
				break;

			case GOTRUE:
				value1 = stack.pop();
				if (value1 == 1){
					N = operand;
					PC = N;
				}
				else{
					System.out.println("Gotrue did not work");
				}
				break;

			case PRINT:
				value1 = stack.pop();
				System.out.println(value1);
				break;

			case RET:
				PC = callStack.pop();
				break;

			case READ:

				System.out.print("Enter a base 10 number: ");
       			value1 = sc.nextInt();
       			stack.push(value1);
       			break;

       		case GOSUB:
       			callStack.push(PC);
       			PC = operand;
       			break;

       		case SHL:
       			value1 = stack.pop();
       			value1 = value1 << 1;
       			stack.push(value1);
       			break;

       		case SHR:
			    value1 = stack.pop();
			    value1 = value1 >>> 1;
			    stack.push(value1);
       			break;

			case SAR:
				value1 = stack.pop();
				value1 = value1 >> 1;
				stack.push(value1);
       			break;

			default:						// exception for unimplemented opcode
				System.err.println("Unimplemented opcode");
				System.exit(opcode);
		}

	}


	public static void main(String [] args) throws IOException //throws IOException needed for input files
	{
		SAW_StackMachine vm = new SAW_StackMachine();			// create our virtual stack machine

		System.out.println("Beginning Execution...");
		vm.execute();									// [insert frozen reference here]
		System.out.println("Done");



	}

}