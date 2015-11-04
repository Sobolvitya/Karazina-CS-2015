
import java.io.File;
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class ANTLRStackExample  {
	
	public static String spaces(Integer n){
		String res="";
		for (int i = 0; i<n; i++){res+=" ";}
		return res;
	}
	
	public static class MemoryStack{
		private class Pair {
		    public String value;
		    public Integer depth;
		    public Pair(String value, Integer depth) {this.value = value; this.depth=depth;};

		    @Override   
		    public boolean equals(Object obj) {
		       if (!(obj instanceof Pair))
		         return false;
		       Pair ref = (Pair) obj;
		       return this.value.equals(ref.value) && 
		           this.depth.equals(ref.depth);
		    }

		     @Override
		     public int hashCode() {
		         return value.hashCode() ^ depth.hashCode();
		     }
		}
		private Map <Pair, Integer> memory = new HashMap<Pair, Integer>();

		
		public int depth=-1; 
		public void push() {
			depth++;
		}
		public void pop() {
			for (Entry<Pair, Integer> entry : memory.entrySet()) 
		        if (entry.getKey().depth == depth)
		        	memory.remove(entry);
			depth--;
		}
		
		public void put(String id, Integer value){
			memory.put(new Pair(id, depth), value);
		}
		
		public boolean containsKey(String id){
			for (Integer i=depth; i>-1; i--)
				if (memory.containsKey(new Pair(id, i))) return true;
			return false;
		}

		public Integer get(String id){
			for (Integer i=depth; i>-1; i--)
				if (memory.containsKey(new Pair(id, i))) 
					return memory.get(new Pair(id, i));
			return 0;
		}
	}

	public static class EvalVisitor extends SimpleLanguageBaseVisitor<Integer> {
		MemoryStack memory = new MemoryStack();
		@Override public Integer visitVal(SimpleLanguageParser.ValContext ctx) { 
			if (ctx.ID() != null) {
				String id = ctx.ID().getText();
				return memory.get(id);								
			} else {
				return Integer.valueOf(ctx.INT().getText());
			}
		}
		
		@Override public Integer visitInit(SimpleLanguageParser.InitContext ctx) { 
			String id = ctx.ID().getText(); // id is left-hand side of '='
			int value = visit(ctx.val()); // compute value of expression on right
			memory.put(id, value); // store it in our memory
			return 0;
		}
		@Override public Integer visitPrint(SimpleLanguageParser.PrintContext ctx) { 
			Integer value = visit(ctx.val());
			System.out.println(
						spaces(memory.depth*4) + ctx.val().getText() + "="+ value); 
			return 0;
		}
		@Override public Integer visitExpr(SimpleLanguageParser.ExprContext ctx) {			
			memory.push();
			Integer val = visitChildren(ctx); 
			memory.pop();
			return val;
		}
	};
	
	public static void main(String[] args) throws Exception {
		String appPath = new File("").getAbsolutePath();
		String fName = appPath + "\\test.txt";
		System.out.println("FILE: " + fName);
		
		//Import file and print its contents 
		String expr = "";
		String sCurrentLine;
		BufferedReader  br = new BufferedReader(new FileReader(appPath + "\\test.txt"));
		
		while ((sCurrentLine = br.readLine()) != null) {
			expr += sCurrentLine + "\n";
		}		
		System.out.println(expr);
		
		//Tokenizing and printing tokens 
		ANTLRInputStream input = new ANTLRInputStream(expr);
		SimpleLanguageLexer lexer = new SimpleLanguageLexer(input);
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		tokens.fill();
		System.out.print("TOKENS: ");
		for (Token t : tokens.getTokens())
			{if (t.getType() > -1) System.out.print(SimpleLanguageLexer.tokenNames[t.getType()] + " ");}; 
		System.out.println();
		
		
		// create a parser that feeds off the tokens buffer
		SimpleLanguageParser parser = new SimpleLanguageParser(tokens);
		ParseTree tree = parser.expr(); // begin parsing at init rule
		ParseTreeWalker walker = new ParseTreeWalker();
//			walker.walk( new ToStr(), tree);
		System.out.println(tree.toStringTree(parser)); // print LISP-style tree
		
		//Processing program using visitor
		EvalVisitor visitor = new EvalVisitor();
		visitor.visit(tree);
	}

}
