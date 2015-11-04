// Generated from D:\Bogdan\Eclipse\ANTLRStackExample\src\SimpleLanguage.g4 by ANTLR 4.1
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link SimpleLanguageParser}.
 */
public interface SimpleLanguageListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link SimpleLanguageParser#val}.
	 * @param ctx the parse tree
	 */
	void enterVal(@NotNull SimpleLanguageParser.ValContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleLanguageParser#val}.
	 * @param ctx the parse tree
	 */
	void exitVal(@NotNull SimpleLanguageParser.ValContext ctx);

	/**
	 * Enter a parse tree produced by {@link SimpleLanguageParser#init}.
	 * @param ctx the parse tree
	 */
	void enterInit(@NotNull SimpleLanguageParser.InitContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleLanguageParser#init}.
	 * @param ctx the parse tree
	 */
	void exitInit(@NotNull SimpleLanguageParser.InitContext ctx);

	/**
	 * Enter a parse tree produced by {@link SimpleLanguageParser#print}.
	 * @param ctx the parse tree
	 */
	void enterPrint(@NotNull SimpleLanguageParser.PrintContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleLanguageParser#print}.
	 * @param ctx the parse tree
	 */
	void exitPrint(@NotNull SimpleLanguageParser.PrintContext ctx);

	/**
	 * Enter a parse tree produced by {@link SimpleLanguageParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(@NotNull SimpleLanguageParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimpleLanguageParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(@NotNull SimpleLanguageParser.ExprContext ctx);
}