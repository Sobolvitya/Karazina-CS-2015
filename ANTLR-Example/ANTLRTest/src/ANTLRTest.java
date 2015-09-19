
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class ANTLRTest {
	public static void main(String[] args) throws Exception {
			// create a CharStream that reads from standard input
			ANTLRInputStream input = new ANTLRInputStream("{1,{5,6},3}");
			// create a lexer that feeds off of input CharStream
			TestGrammarLexer lexer = new TestGrammarLexer(input);
			// create a buffer of tokens pulled from the lexer
			CommonTokenStream tokens = new CommonTokenStream(lexer);
			// create a parser that feeds off the tokens buffer
			TestGrammarParser parser = new TestGrammarParser(tokens);
			ParseTree tree = parser.init(); // begin parsing at init rule
			System.out.println(tree.toStringTree(parser)); // print LISP-style tree
	}

}
