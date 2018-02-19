import java.io.*;

public class Lex {
    Lex(FileReader filereader) {
        fr = filereader;
    }

    private FileReader fr;
    int i;
    char c;
    String iden;
    private final String EMPTY_STRING = "";

    // public  void main(String[] args) throws Exception {
    //     fr = new FileReader(args[0]);
    //     getNextChar();
    //     getToken();
    // }

    public void getNextChar() {
        try {
            i = fr.read();
            c = ((char) i);
        } catch (Exception e) {
        }
    }

    public boolean isNumOrChar(char character) {
        int i = (int) character;
        System.out.println(i);
        if ((i >= 65 && i <= 90) || (i >= 97 && i <= 122) || (i >= 48 && i <= 57)) {
            return true;
        } else {
            return false;
        }
    }

    public int getToken() {
        int state = 0;
        boolean loop = true;

        while (loop) {
            switch (state) {
            case 0:
                switch (c) {
                case 'b': // begin
                    getNextChar();
                    state = 1;
                    break;
                case 'e': // end
                    getNextChar();
                    state = 6;
                    break;
                case ':':
                    getNextChar();
                    state = 8;
                    break;
                case ';':
                    getNextChar();
                    state = 9;
                    break;
                case '*':
                    getNextChar();
                    state = 10;
                    break;
                case '+':
                    getNextChar();
                    state = 11;
                    break;
                case '-':
                    getNextChar();
                    state = 12;
                    break;
                case 'd': // div
                    getNextChar();
                    state = 13;
                    break;
                case 'm': // mod
                    getNextChar();
                    break;
                case '^':
                    getNextChar();
                    break;
                case ' ':
                case '\t':
                case '\n':
                    getNextChar();
                    break;
                default:
                    getNextChar();
                    state = 100;
                    break;
                }
                break;

            case 1:
                if (c == 'e') {
                    getNextChar();
                    state = 2;
                } else {
                    getNextChar();
                    state = 100;
                }
                break;
            case 2:
                if (c == 'g') {
                    getNextChar();
                    state = 3;
                } else {
                    state = 100;
                }
                break;
            case 3:
                if (c == 'i') {
                    getNextChar();
                    state = 4;
                } else {
                    getNextChar();
                    state = 100;
                }
                break;
            case 4: // begin
                if (c == 'n') {
                    getNextChar();
                    state = 5;
                    // check isNum or character
                    if (!isNumOrChar(c)) {
                        getNextChar();
                        return Tokens.BEGIN;
                    }
                } else {
                    getNextChar();
                    state = 100;
                }
                break;
            case 5:
                // getNextChar();
                state = 0;
                // sent after begin
                break;
            case 6: // end
                if (c == 'n') {
                    getNextChar();
                    state = 7;
                } else {
                    getNextChar();
                    state = 100;
                }
                break;
            case 7: // end
                if (c == 'd') {
                    getNextChar();
                    state = 8;
                    if (!isNumOrChar(c)) {
                        getNextChar();
                        return Tokens.END;
                    }
                } else {
                    state = 100;
                }
                break;
            case 8:
                // getNextChar();
                state = 0;
                // sent here because end works
                break;
            case 9: // colon
                if (c == '=') {
                    getNextChar();
                    state = 0;
                    if (!isNumOrChar(c)) {
                        getNextChar();
                        return Tokens.EQUAL;
                    } else {
                        state = 100;
                    }
                }
                break;
            case 10: // semicolon
                getNextChar();
                return Tokens.SEMICOLON;
            // break;
            case 11:
                getNextChar();
                return Tokens.MULTSYM;
            case 12:
                getNextChar();
                return Tokens.PLUSSYM;
            case 13:
                getNextChar();
                return Tokens.MINUSSYM;
            case 14: // div
                if (c == 'i') {
                    getNextChar();
                    state = 14;
                } else {
                    state = 100;
                }
            case 15: // div
                if (c == 'v') {
                    getNextChar();
                    state = 16;
                    if (!isNumOrChar(c)) {
                        return Tokens.DIVSYM;
                    }
                } else {
                    getNextChar();
                    state = 100;
                }
            case 16: // finished div
                getNextChar();
                break;
            case 17: // mod
                if (c == 'o') {
                    getNextChar();
                    state = 18;
                } else {
                    getNextChar();
                    state = 100;
                }
                break;
            case 18: // mod
                if (c == 'd') {
                    getNextChar();
                    state = 19;
                    if (!isNumOrChar(c)) {
                        return Tokens.MODSYM;
                    }
                } else {
                    getNextChar();
                    state = 100;
                }
                break;
            case 19:
                // getNextChar();
                state = 0;
                // sent here because mod works
                break;
            case 20:
                getNextChar();
                state = 21;
                break;

            case 100:
                // TODO: check if letter or digit. return boolean
                // if letter or digit, go to the next one
                // else return tokens.identifier.
                //
                if (isNumOrChar(c)) {
                    getNextChar();
                    // TODO: concat item
                    iden = new StringBuilder().append(iden).append(c).toString();
                } else {
                    // String newIden = iden;
                    // iden.setText("");
                    // return newIden;
                    return Tokens.IDENTIFIER;
                }
                return 100;
            default:
                loop = false;
                return 100;
            }
        }
        return -666;
    }

}
