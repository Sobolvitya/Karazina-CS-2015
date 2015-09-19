// Generated from D:\Bogdan\ANTLR\TestGrammar\TestGrammar.g4 by ANTLR 4.1
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link TestGrammarParser}.
 */
public interface TestGrammarListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link TestGrammarParser#init}.
	 * @param ctx the parse tree
	 */
	void enterInit(@NotNull TestGrammarParser.InitContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestGrammarParser#init}.
	 * @param ctx the parse tree
	 */
	void exitInit(@NotNull TestGrammarParser.InitContext ctx);

	/**
	 * Enter a parse tree produced by {@link TestGrammarParser#value}.
	 * @param ctx the parse tree
	 */
	void enterValue(@NotNull TestGrammarParser.ValueContext ctx);
	/**
	 * Exit a parse tree produced by {@link TestGrammarParser#value}.
	 * @param ctx the parse tree
	 */
	void exitValue(@NotNull TestGrammarParser.ValueContext ctx);
}