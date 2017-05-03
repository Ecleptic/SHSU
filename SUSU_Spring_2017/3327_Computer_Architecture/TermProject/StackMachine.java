import java.util.Stack;
import java.io.*;
import java.util.Scanner;


// here's a start of a program in case you don't know where to begin;

public class StackMachine {
    final int MAX_CODE = 65536;    // size of code memory
    final int MAX_DATA = 65536;        // size of data memory

    final int HALT = 0;            // a few opcodes defined
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
    final int ASGN = 36;

    static String fileName;
    int[] code;                    // reference for the memory modules
    int[] data;
    int PC;                            // we need a couple of registers
    int IR;
    boolean run;
    Stack<Integer> stack;            // data stack
    Stack<Integer> callStack;        // call stack
    int opValueL;
    int opValueR;

    public StackMachine() {

        code = new int[MAX_CODE];        // constructor initializes the stack machine;
        data = new int[MAX_DATA];
        PC = 0;
        run = true;
        stack = new Stack<Integer>();
        callStack = new Stack<Integer>();

    }

    public void readBin() throws IOException {
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
            } catch (EOFException e) {
                endOfFile = true;
            }
        }
    }

    public void execute() {
        while (run)                            // the old fetch-execute cycle
        {
            getNextInstruction();
            decodeAndRunInstruction();
        }
    }

    public void getNextInstruction() {
        IR = code[PC++];                    // fetching is straighforward
    }

    public void decodeAndRunInstruction() {
        int opcode = IR >> 16;                // pull of the opcode and the operands
        int operand = IR & 0xFFFF;

        switch (opcode)                        // what we do depends on what opcode we have
        {                                    // most of these are pretty straight forward
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
                opValueR = stack.pop();
                opValueL = stack.pop();
                data[opValueL] = opValueR;
                break;

            case STO:
                stack.push(operand);
                break;

            case COPY:
                opValueR = stack.pop();
                opValueL = stack.pop();
                data[opValueL] = opValueR;
                stack.push(opValueR);
                break;

            case ADD:
                opValueR = stack.pop();
                opValueL = stack.pop();
                int add = (opValueR + opValueL);
                stack.push(add);
                break;

            case SUB:
                opValueR = stack.pop();
                opValueL = stack.pop();
                int sub = (opValueR - opValueL);
                stack.push(sub);
                break;

            case MPY:
                opValueR = stack.pop();
                opValueL = stack.pop();
                int mpy = (opValueR * opValueL);
                stack.push(mpy);
                break;

            case DIV:
                opValueR = stack.pop();
                opValueL = stack.pop();
                if (opValueL == 0) {
                    System.out.println("Can not divide by zero");
                    break;
                }
                int div = (opValueR / opValueL);
                stack.push(div);
                break;

            case MOD:
                opValueR = stack.pop();
                opValueL = stack.pop();
                int mod = (opValueR % opValueL);
                stack.push(mod);
                break;

            case NEG:
                opValueR = stack.pop();
                int neg = (opValueR * -1);
                stack.push(neg);
                break;


            case NOT:
                String opValueRString = Integer.toBinaryString(stack.pop());
                String not = opValueRString;
                not = opValueRString.replaceAll("0", "x");
                not = opValueRString.replaceAll("1", "0");
                not = opValueRString.replaceAll("x", "1");
                stack.push(Integer.parseInt(not));
                break;

            case OR:
// pop the top two values off the stack, compute the logical OR, and push the result
                opValueR = stack.pop();
                opValueL = stack.pop();
                if (opValueL != 0 || opValueR != 0) {
                    stack.push(1);
                } else {
                    stack.push(0);
                    stack.push(opValueR & opValueL);
                }
                break;
            case AND:
// pop the top two values off the stack, compute the logical AND, and push the result            
                opValueR = stack.pop();
                opValueL = stack.pop();
                if (opValueL != 0 && opValueR != 0) {
                    stack.push(1);
                } else {
                    stack.push(0);
                    stack.push(opValueR & opValueL);
                }
                break;
            case EQ:
// pop the top two values off the stack, compare them, and push a 1 if they are equal, and a 0 if they are not
                opValueR = stack.pop();
                opValueL = stack.pop();
                if (opValueR == opValueL) {
                    stack.push(1);
                } else {
                    stack.push(0);
                }
                break;


            case NE:
                opValueR = stack.pop();
                opValueL = stack.pop();
                if (opValueR != opValueL) {
                    stack.push(1);
                } else {
                    stack.push(0);
                }
                break;
            case GT:
                opValueR = stack.pop();
                opValueL = stack.pop();
                if (opValueR > opValueL) {
                    stack.push(1);
                } else {
                    stack.push(0);
                }
                break;

            case GE:
                opValueR = stack.pop();
                opValueL = stack.pop();
                if (opValueR >= opValueL) {
                    stack.push(1);
                } else {
                    stack.push(0);
                }
                break;

            case LT:
                opValueR = stack.pop();
                opValueL = stack.pop();
                if (opValueR < opValueL) {
                    stack.push(1);
                } else {
                    stack.push(0);
                }
                break;

            case LE:
                opValueR = stack.pop();
                opValueL = stack.pop();
                if (opValueR <= opValueL) {
                    stack.push(1);
                } else {
                    stack.push(0);
                }
                break;
            case LABEL:
                //  serves as the target of jumps to n; has no other effect
                /** 
                 * TODO: 
                 * Finish here.
                 */
                break;
            case GOTO:
                // the next instruction is taken from statement with label n
                PC = operand;
                break;
            case GOFALSE:
                // pop the top value; jump if it is zero
                opValueR = stack.pop();
                if (opValueR == 0) {
                    break;
                }
//				break;
            case GOTRUE:
                // pop the top value; jump  if it is nonzero
                opValueR = stack.pop();
                if (opValueR != 0) {
                    break;
                }
//				break;
            case PRINT:
                // pop the top value off the stack and display it as a base 10 integer
                opValueR = stack.pop();
                System.out.println("top of stack: " + opValueR);
                break;

            case READ:
                // read a base 10 integer from the keyboard and push its value on the stack
                Scanner keyboard = new Scanner(System.in);
                System.out.println("enter a base 10 integer");
                opValueR = keyboard.nextInt();
                stack.push(opValueR);
                break;

            case GOSUB:
                // push the current value of the program counter on the call stack and transfer control to the      statement with label 'l'
                callStack.push(PC);
                PC = operand;
                break;
            case RET:
                // pop the top value off the call stack and store it in the program counter
                PC = stack.pop();
                break;

            case ORB:
                // pop the top two values off the stack, compute the bitwise OR, and push the result
                opValueL = stack.pop();
                opValueR = stack.pop();
                int orb = (opValueL | opValueR);
                stack.push(orb);
                break;

            case ANDB:
                // pop the top two values off the stack, compute the bitwise AND, and push the result
                opValueL = stack.pop();
                opValueR = stack.pop();
                int andb = (opValueL & opValueR);
                stack.push(andb);

                break;

            case XORB:
                //pop the top two values off the stack, compute the bitwise XOR, and push the result
                opValueL = stack.pop();
                opValueR = stack.pop();
                int xorb = (opValueL ^ opValueR);
                stack.push(xorb);
                break;

            case SHL:
                // pop the top value off the stack, logical shift the bits left by 1 bit, and push the result
                opValueL = stack.pop();
                opValueR = opValueL << 1;
                stack.push(opValueR);
                break;

            case SHR:
                opValueL = stack.pop();
                opValueR = opValueL >> 1;
                stack.push(opValueR);
                break;

            case SAR:
                opValueL = stack.pop();
                opValueR = opValueL >>> 1;
                stack.push(opValueR);
                break;

            case ASGN:
                // store the value on top of the stack in the address directly below it on the stack
                opValueR = stack.pop();
                opValueL = stack.pop();
                data[opValueL] = opValueR;
                final int POP = 4;
                break;


            default:                        // oops!
                System.err.println("Unimplemented opcode");
                System.exit(opcode);
        }
        if (IR == 0) run = false;            // Isn't this redundant?  Oh, well leave it in for now
    }


    public static void main(String[] args) {
        StackMachine vm = new StackMachine();            // create our virtual stack machine


        System.out.println("Beginning Execution...");

        fileName = args[0];

        try {
            vm.readBin();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        vm.execute();                                    // and, let it go, let it go .....
        System.out.println("Done");
    }


}
