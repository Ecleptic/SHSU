/**
 *
 * Match copares lookahead value to the value you want.
 *
 */

class Parser {
    Lex lex = new Lex();
    int lookahead = lex.getToken();


    program(){
        match (Token.BEGIN);
        stmt_list();
        match(Token.END);
    }

    stmtList(){
        stmtList(); // TODO: need to get rid of left recursion.
        match(semicolon);
        stmt();
        // after the second thing start printing maybe.
    }

    match(int i){
        if(i == lookahead ){
            lookahead = lex.getToken();

        }else{
            // syntax error
        }
    }

}

//     <expr>=><expr>+<term>

//     <expr>=><term><exprPrime><exprPrime>=>+<term><exprPrime>|Epison

// expr(){
//     term();
//     exprPrime();
// }

// exprPrime(){
//     if (lookahead = Tokens.PLUSSYM){
//       match(+)
//       term()
//       exprPrime()
//     }else if (if minus,){
//         match (-)
//         term()
//         exprPrime();
//     }

}