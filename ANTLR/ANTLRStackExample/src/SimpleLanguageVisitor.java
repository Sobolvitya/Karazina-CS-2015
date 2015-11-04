// Generated from D:\Bogdan\Eclipse\ANTLRStackExample\src\SimpleLanguage.g4 by ANTLR 4.1
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link SimpleLanguageParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface SimpleLanguageVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link SimpleLanguageParser#val}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVal(@NotNull SimpleLanguageParser.ValContext ctx);

	/**
	 * Visit a parse tree produced by {@link SimpleLanguageParser#init}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInit(@NotNull SimpleLanguageParser.InitContext ctx);

	/**
	 * Visit a parse tree produced by {@link SimpleLanguageParser#print}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPrint(@NotNull SimpleLanguageParser.PrintContext ctx);

	/**
	 * Visit a parse tree produced by {@link SimpleLanguageParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(@NotNull SimpleLanguageParser.ExprContext ctx);
}