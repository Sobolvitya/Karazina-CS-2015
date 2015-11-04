// Generated from D:\Bogdan\Eclipse\ANTLRStackExample\src\SimpleLanguage.g4 by ANTLR 4.1
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class SimpleLanguageParser extends Parser {
	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__4=1, T__3=2, T__2=3, T__1=4, T__0=5, ID=6, INT=7, WS=8;
	public static final String[] tokenNames = {
		"<INVALID>", "'print'", "';'", "'{'", "'='", "'}'", "ID", "INT", "WS"
	};
	public static final int
		RULE_expr = 0, RULE_init = 1, RULE_val = 2, RULE_print = 3;
	public static final String[] ruleNames = {
		"expr", "init", "val", "print"
	};

	@Override
	public String getGrammarFileName() { return "SimpleLanguage.g4"; }

	@Override
	public String[] getTokenNames() { return tokenNames; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public ATN getATN() { return _ATN; }

	public SimpleLanguageParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}
	public static class ExprContext extends ParserRuleContext {
		public PrintContext print(int i) {
			return getRuleContext(PrintContext.class,i);
		}
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public InitContext init(int i) {
			return getRuleContext(InitContext.class,i);
		}
		public List<InitContext> init() {
			return getRuleContexts(InitContext.class);
		}
		public List<PrintContext> print() {
			return getRuleContexts(PrintContext.class);
		}
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleLanguageListener ) ((SimpleLanguageListener)listener).enterExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleLanguageListener ) ((SimpleLanguageListener)listener).exitExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof SimpleLanguageVisitor ) return ((SimpleLanguageVisitor<? extends T>)visitor).visitExpr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ExprContext expr() throws RecognitionException {
		ExprContext _localctx = new ExprContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_expr);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(14); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				setState(14);
				switch (_input.LA(1)) {
				case ID:
					{
					setState(8); init();
					}
					break;
				case 1:
					{
					setState(9); print();
					}
					break;
				case 3:
					{
					setState(10); match(3);
					setState(11); expr();
					setState(12); match(5);
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				setState(16); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << 1) | (1L << 3) | (1L << ID))) != 0) );
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class InitContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(SimpleLanguageParser.ID, 0); }
		public ValContext val() {
			return getRuleContext(ValContext.class,0);
		}
		public InitContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_init; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleLanguageListener ) ((SimpleLanguageListener)listener).enterInit(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleLanguageListener ) ((SimpleLanguageListener)listener).exitInit(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof SimpleLanguageVisitor ) return ((SimpleLanguageVisitor<? extends T>)visitor).visitInit(this);
			else return visitor.visitChildren(this);
		}
	}

	public final InitContext init() throws RecognitionException {
		InitContext _localctx = new InitContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_init);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(18); match(ID);
			setState(19); match(4);
			setState(20); val();
			setState(21); match(2);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ValContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(SimpleLanguageParser.ID, 0); }
		public TerminalNode INT() { return getToken(SimpleLanguageParser.INT, 0); }
		public ValContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_val; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleLanguageListener ) ((SimpleLanguageListener)listener).enterVal(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleLanguageListener ) ((SimpleLanguageListener)listener).exitVal(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof SimpleLanguageVisitor ) return ((SimpleLanguageVisitor<? extends T>)visitor).visitVal(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ValContext val() throws RecognitionException {
		ValContext _localctx = new ValContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_val);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(23);
			_la = _input.LA(1);
			if ( !(_la==ID || _la==INT) ) {
			_errHandler.recoverInline(this);
			}
			consume();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PrintContext extends ParserRuleContext {
		public ValContext val() {
			return getRuleContext(ValContext.class,0);
		}
		public PrintContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_print; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleLanguageListener ) ((SimpleLanguageListener)listener).enterPrint(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof SimpleLanguageListener ) ((SimpleLanguageListener)listener).exitPrint(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof SimpleLanguageVisitor ) return ((SimpleLanguageVisitor<? extends T>)visitor).visitPrint(this);
			else return visitor.visitChildren(this);
		}
	}

	public final PrintContext print() throws RecognitionException {
		PrintContext _localctx = new PrintContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_print);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(25); match(1);
			setState(26); val();
			setState(27); match(2);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static final String _serializedATN =
		"\3\uacf5\uee8c\u4f5d\u8b0d\u4a45\u78bd\u1b2f\u3378\3\n \4\2\t\2\4\3\t"+
		"\3\4\4\t\4\4\5\t\5\3\2\3\2\3\2\3\2\3\2\3\2\6\2\21\n\2\r\2\16\2\22\3\3"+
		"\3\3\3\3\3\3\3\3\3\4\3\4\3\5\3\5\3\5\3\5\3\5\2\6\2\4\6\b\2\3\3\2\b\t\36"+
		"\2\20\3\2\2\2\4\24\3\2\2\2\6\31\3\2\2\2\b\33\3\2\2\2\n\21\5\4\3\2\13\21"+
		"\5\b\5\2\f\r\7\5\2\2\r\16\5\2\2\2\16\17\7\7\2\2\17\21\3\2\2\2\20\n\3\2"+
		"\2\2\20\13\3\2\2\2\20\f\3\2\2\2\21\22\3\2\2\2\22\20\3\2\2\2\22\23\3\2"+
		"\2\2\23\3\3\2\2\2\24\25\7\b\2\2\25\26\7\6\2\2\26\27\5\6\4\2\27\30\7\4"+
		"\2\2\30\5\3\2\2\2\31\32\t\2\2\2\32\7\3\2\2\2\33\34\7\3\2\2\34\35\5\6\4"+
		"\2\35\36\7\4\2\2\36\t\3\2\2\2\4\20\22";
	public static final ATN _ATN =
		ATNSimulator.deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}