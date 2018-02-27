/**
 * symTable
 */
public class Symbol {
    String lexeme;
    String type;
    int address;

    public Symbol(String lexeme, String type, int address) {
        this.lexeme = lexeme;
        this.type = type;
        this.address = address;
    }

    public String toString(){
        return lexeme +"\t"+ type +"\t"+ address;
    }
}
