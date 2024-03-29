/*
 * [The "BSD license"]
 *  Copyright (c) 2012-2014 Terence Parr
 *  Copyright (c) 2012-2014 Sam Harwell
 *  Copyright (c) 2015 Gerald Rosenberg
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  3. The name of the author may not be used to endorse or promote products
 *     derived from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 *  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*	A grammar for ANTLR v4 written in ANTLR v4.
 *
 *	Modified 2015.06.16 gbr
 *	-- update for compatibility with Antlr v4.5
 *	-- add mode for channels
 *	-- moved members to LexerAdaptor
 * 	-- move fragments to imports
 */
parser grammar ANTLRv4Parser;


options { tokenVocab = ANTLRv4Lexer; }

@parser::header {
import java.util.*;
import java.util.stream.*;
import java.io.*;
}

@parser::members {
	static final List<String> rulesOrder = new ArrayList<String>();
	static final Set<String> fragmentTokens = new HashSet<String>();
	//static final Map<String, List<String>> nextItems = new HashMap<String, List<String>>(); 
	static final Map<String, ModeContainer> lexerModes = new HashMap<String, ModeContainer>(); 
	static ModeContainer currentMode = null;
	static final Set<String> tokensNotTopMode = new HashSet<String>();
	static final Map<String, String> modeStarts = new HashMap<String, String>(); 
	static final Map<String, String> lexerVimPatterns = new HashMap<String, String>(); 
	static final Map<String, String> antlrToVimNames = new HashMap<String, String>(); 
	static final Set<String> usedVimNames = new HashSet<String>();
	static final Map<String, String> hiLinks = new HashMap<String, String>(); 
	static String filetype = null;
	static String grammarName = null;
	
	static final List<String> filenames = new ArrayList<String>();
	static String highlightFilename = null;
	
	public static void main(String[] args) {
		final String help = "Usage: java ANTLRv4Parser [<options...>] [--] <grammarFilenames>...\n" +
			"\t-f, --filetype <filetype>\tvim 'filetype' option and output filename (without extension)\n" +
			"\t-h, --help\tshow this message and exit\n" +
			"\t-H, --highlight <filename>\tfile with highlighting links\n" +
			"\t-o, --output <directory>\toutput directory\n" +
			"\t-\tread grammar from stdin\n" +
			"\n" +
			"Highlighting file structure:\n" +
			"Two space-separated columns, left is antlr identifier, right is vim standart group or '#' + antlr identifier. If first character of the line is '#', it is treated as comment.";
		if(args.length == 0) {
			System.err.println(help);
			return;
		}
		boolean endOfOptions = false;
		String outDir = ".";
		for(int i = 0; i < args.length; i++) {
			if(!endOfOptions && args[i].length() != 0 && args[i].charAt(0) == '-') {
				if(args[i].equals("-")) {
					filenames.add("/dev/stdin"); //TODO: use "con" in Windows
					continue;
				}
				if(args[i].equals("--")) {
					endOfOptions = true;
					continue;
				}
				int newI = i, j = 1;
				boolean parsingShortOpts = args[i].charAt(1) != '-';
				do {
					if(args[i].equals("--filetype") || parsingShortOpts && args[i].charAt(j) == 'f') {
						filetype = args[++newI];
					} else if(args[i].equals("--help") || parsingShortOpts && args[i].charAt(j) == 'h') {
						System.out.println(help);
						return;
					} else if(args[i].equals("--highlight") || parsingShortOpts && args[i].charAt(j) == 'H') {
						highlightFilename = args[++newI];
					} else if(args[i].equals("--output") || parsingShortOpts && args[i].charAt(j) == 'o') {
						outDir = args[++newI];
					} else {
						System.err.print("Unknown option: '");
						if(parsingShortOpts) {
							System.out.print("-" + args[i].charAt(j));
						} else {
							System.out.print(args[i]);
						}
						System.err.println("'");
						return;
					}
				} while(parsingShortOpts && ++j < args[i].length());
				i = newI;
			} else {
				filenames.add(args[i]);
			}
		}
		if(filenames.size() == 0)
			filenames.add("/dev/stdin");
		try {
			for(String fn: filenames) {
				CharStream streamInput = CharStreams.fromFileName(fn);
				TokenSource lexerAntlr = new ANTLRv4Lexer(streamInput);
				TokenStream flowTokens = new CommonTokenStream(lexerAntlr);
				ANTLRv4Parser parser = new ANTLRv4Parser(flowTokens);
				
				System.err.println("Started parser");
				
				parser.grammarSpec();
			}
			
			if(filetype == null)
				filetype = grammarName.toLowerCase();
			
			if(highlightFilename != null) {
				BufferedReader reader = new BufferedReader(new FileReader(highlightFilename));
				String line;
				while((line = reader.readLine()) != null) {
					line = line.trim();
					if(line.length() == 0 || line.charAt(0) == '#')
						continue;
					String[] cols = line.split("[\\s\\t]+");
					switch(cols.length) {
						case 0:
							continue;
						case 1:
							hiLinks.put(cols[0], "");
							break;
						default:
							hiLinks.put(cols[0], cols[1]);
							break;
					}
				}
			} else {
				System.err.println("Highlighting filename not specified");
			}
			
			System.setOut(new PrintStream(new File(outDir, filetype + ".vim")));
			
			DependentRegexpResolver resolver = new DependentRegexpResolver(lexerVimPatterns);
			System.err.println("Started resolver");
			resolver.resolve();
			System.err.println("Ended resolver");
			
			/*for(String ident: rulesOrder) {
				if(identifierIsLexer(ident) && tokenIsFragment(ident))
					System.out.print("fragment ");
				System.out.println(ident);
				if(identifierIsLexer(ident))
					System.out.println(resolver.resolved.get(ident));
			}*/
			for(int i = rulesOrder.size() - 1; i >= 0; i--) {
				String ident = rulesOrder.get(i);
				if(identifierIsLexer(ident)) {
					if(modeStarts.containsKey(ident)) {
						ModeContainer mode = getModeContainer(modeStarts.get(ident));
						if(mode.mainStartRule.equals(ident)) {
							System.out.print("syn region " + getVimName(mode.getName()));
							for(String startIdent: mode.startRules) {
								System.out.print(" matchgroup=" + getVimName(startIdent) + " start=/\\v" + postprocessVimPattern(resolver.resolved.get(startIdent)) + "/");
							}
							for(String endIdent: mode.endRules) {
								System.out.print(" matchgroup=" + getVimName(endIdent) + " end=/\\v" + postprocessVimPattern(resolver.resolved.get(endIdent)) + "/");
							}
							writeContainsEntry(mode.lexerRules);
							if(!hiLinks.containsKey(mode.name)) {
								System.out.print(" transparent");
							}
							System.out.println("");
						}
						continue;
					}
					
					System.out.print("syn match " + getVimName(ident) + " /\\v" + postprocessVimPattern(resolver.resolved.get(ident)) + "/");
					if(tokenIsFragment(ident) || tokensNotTopMode.contains(ident)) {
						System.out.print(" contained");
					}
					writeContainsEntry(resolver.contains.get(ident));
					if(!hiLinks.containsKey(ident)) {
						System.out.print(" transparent");
					}
					System.out.println("");
				}
			}
			System.out.println("");
			for(String ident: hiLinks.keySet()) {
				String value = hiLinks.get(ident);
				if(value.length() == 0)
					continue;
				if(value.charAt(0) == '#') {
					value = getVimName(value.substring(1));
				}
				System.out.println("hi def link " + getVimName(ident) + " " + value);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void writeContainsEntry(Collection<String> containedRules) {
		Set<String> groups = containedRules.stream().map(ANTLRv4Parser::tryConverToMode).map(ANTLRv4Parser::getVimName).collect(Collectors.toSet());
		if(groups.size() > 0) {
			System.out.print(" contains=" + String.join(",", groups));
		}
	}
	
	public static String tryConverToMode(String ident) {
		String mode = modeStarts.get(ident);
		if(mode == null)
			return ident;
		return mode;
	}
	
	public static void handleLexerCommand(String ident, String method, String... args) {
		if(method.equals("pushMode")) {
			if(args.length < 1) {
				System.err.println("pushMode requires 1 argument in " + ident + "definition");
				return;
			}
			ModeContainer mode = getModeContainer(args[0]);
			mode.startRules.add(ident);
			mode.mainStartRule = ident;
			modeStarts.put(ident, args[0]);
		}
		if(method.equals("popMode")) {
			ModeContainer mode = currentMode;
			if(mode == null) {
				System.err.println("popMode should be called inside mode definition in " + ident + "definition");
				return;
			}
			mode.endRules.add(ident);
		}
	}
	
	public static void setCurrentMode(String modeName) {
		currentMode = getModeContainer(modeName);
	}
	
	public static ModeContainer getModeContainer(String modeName) {
		if(!lexerModes.containsKey(modeName)) {
			lexerModes.put(modeName, new ModeContainer(modeName));
		}
		return lexerModes.get(modeName);
	}
	
	public static String postprocessVimPattern(String ptn) {
		int brackdepth = 0;
		StringBuilder result = new StringBuilder();
		for(int i = 0; i < ptn.length(); i++) {
			final char c = ptn.charAt(i);
			if(c == '\\') {
				i++;
				result.append('\\');
				result.append(ptn.charAt(i));
				continue;
			}
			switch(c) {
				case '[':
					if(brackdepth++ == 0)
						result.append('[');
					break;
				case ']':
					if(brackdepth-- == 1)
						result.append(']');
					break;
				case '|':
				case '%':
				case '(':
				case ')':
					if(brackdepth == 0)
						result.append(c);
					break;
				default:
					result.append(c); //TODO: handling '^' and '.'
					break;
			}
		}
		return result.toString();
	}
	
	public static String getVimName(String ident) {
		if(antlrToVimNames.containsKey(ident))
			return antlrToVimNames.get(ident);
		String vimName = filetype + ident;
		int i = 0;
		while(usedVimNames.contains(vimName.toLowerCase())) {
			vimName = filetype + ident + "__" + (i++);
		}
		antlrToVimNames.put(ident, vimName);
		usedVimNames.add(vimName.toLowerCase());
		return vimName;
	}
	
	public static void setPattern(String ident, String ptn) {
		lexerVimPatterns.put(ident, ptn);
		if(currentMode != null && !fragmentTokens.contains(ident)) {
			currentMode.lexerRules.add(ident);
			tokensNotTopMode.add(ident);
		}
	}
	
	public static boolean identifierIsLexer(String ident) {
		char c = ident.charAt(0);
		return (c >= 'A') && (c <= 'Z');
	}
	
	public static void tokenSetFragment(String ident) {
		fragmentTokens.add(ident);
	}
	
	public static boolean tokenIsFragment(String ident) {
		return fragmentTokens.contains(ident);
	}
	
	static boolean isHexDigit(char c) {
		return (c >= '0' && c <= '9') || (c >= 'A' && c <= 'F') || (c >= 'a' && c <= 'f');
	}
	
	public static String stringLiteralToPattern(String lit, boolean insideBrackets) {
		lit = lit.substring(1, lit.length() - 1);
		StringBuilder result = new StringBuilder();
		for(int i = 0; i < lit.length(); i++) {
			char c = lit.charAt(i);
			if(c == '\\') {
				char next = lit.charAt(i + 1);
				switch(next) {
					case 'u':
						if(!insideBrackets)
							result.append("%");
						result.append("\\u");
						i++;
						break;
					case 'f':
						if(!insideBrackets)
							result.append("%");
						result.append("\\x0c");
						i++;
						break;
					case 'b':
					case 't':
					case 'n':
					case 'r':
						result.append("\\");
						result.append(next);
						i++;
						break;
					default:
						result.append(escapeRegexpChar(next));
						i++;
						break;
				}
			} else {
				result.append(escapeRegexpChar(c));
			}
		}
		return result.toString();
	}
	
	public static String unpackBrackets(String expr) {
		if(expr.charAt(0) != '[' || expr.charAt(expr.length() - 1) != ']')
			return expr;
		return expr.substring(1, expr.length() - 1);
	}
	
	public static String invertSetPattern(String expr) {
		expr = unpackBrackets(expr);
		if(expr.charAt(0) == '^') {
			return "[" + expr.substring(1) + "]";
		} else {
			return "[^" + expr + "]";
		}
	}
	
	public static String parseLexerCharSet(String expr) {
		expr = expr.substring(1, expr.length() - 1);
		StringBuilder result = new StringBuilder();
		result.append("[");
		for(int i = 0; i < expr.length(); i++) {
			char c = expr.charAt(i);
			if(c == '\\') {
				char next = expr.charAt(i + 1);
				switch(next) {
					case 'f':
						result.append("\\x0c");
						i++;
						break;
					case 'u':
					case 'b':
					case 't':
					case 'n':
					case 'r':
						result.append("\\");
						result.append(next);
						i++;
						break;
					default:
						result.append(escapeRegexpChar(next));
						i++;
						break;
				}
			} else {
				if(c == '-')
					result.append("-");
				else
					result.append(escapeRegexpChar(c));
			}
		}
		result.append("]");
		return result.toString();
	}
	
	public static String escapeRegexpChar(char ch) {
		if((ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z') || (ch >= '0' && ch <= '9') || ch == '_')
			return "" + ch;
		return "\\" + ch;
	}
}

// The main entry point for parsing a v4 grammar.
grammarSpec
   : DOC_COMMENT* grammarDecl prequelConstruct* rules modeSpec* EOF
   ;

grammarDecl
   : grammarType identifier {grammarName = $identifier.text;} SEMI
   ;

grammarType
   : (LEXER GRAMMAR | PARSER GRAMMAR | GRAMMAR)
   ;
   // This is the list of all constructs that can be declared before
   // the set of rules that compose the grammar, and is invoked 0..n
   // times by the grammarPrequel rule.

prequelConstruct
   : optionsSpec
   | delegateGrammars
   | tokensSpec
   | channelsSpec
   | action_
   ;
   // ------------
   // Options - things that affect analysis and/or code generation

optionsSpec
   : OPTIONS LBRACE (option SEMI)* RBRACE
   ;

option
   : identifier ASSIGN optionValue
   ;

optionValue
   : identifier (DOT identifier)*
   | STRING_LITERAL
   | actionBlock
   | INT
   ;
   // ------------
   // Delegates

delegateGrammars
   : IMPORT delegateGrammar (COMMA delegateGrammar)* SEMI
   ;

delegateGrammar
   : identifier ASSIGN identifier
   | identifier
   ;
   // ------------
   // Tokens & Channels

tokensSpec
   : TOKENS LBRACE idList? RBRACE
   ;

channelsSpec
   : CHANNELS LBRACE idList? RBRACE
   ;

idList
   : identifier (COMMA identifier)* COMMA?
   ;
   // Match stuff like @parser::members {int i;}

action_
   : AT (actionScopeName COLONCOLON)? identifier actionBlock
   ;
   // Scope names could collide with keywords; allow them as ids for action scopes

actionScopeName
   : identifier
   | LEXER
   | PARSER
   ;

actionBlock
   : BEGIN_ACTION ACTION_CONTENT* END_ACTION
   ;

argActionBlock
   : BEGIN_ARGUMENT ARGUMENT_CONTENT* END_ARGUMENT
   ;

modeSpec
   : MODE identifier {setCurrentMode($identifier.text);} SEMI lexerRuleSpec*
   ;

rules
   : ruleSpec*
   ;

ruleSpec returns [String identName]
   : parserRuleSpec {$identName = $parserRuleSpec.identName;}
   | lexerRuleSpec {$identName = $lexerRuleSpec.identName;}
   ;

parserRuleSpec returns [String identName]
   : DOC_COMMENT* ruleModifiers? RULE_REF {$identName = $RULE_REF.text;} argActionBlock? ruleReturns? throwsSpec? localsSpec? rulePrequel* COLON ruleBlock SEMI exceptionGroup
   ;

exceptionGroup
   : exceptionHandler* finallyClause?
   ;

exceptionHandler
   : CATCH argActionBlock actionBlock
   ;

finallyClause
   : FINALLY actionBlock
   ;

rulePrequel
   : optionsSpec
   | ruleAction
   ;

ruleReturns
   : RETURNS argActionBlock
   ;
   // --------------
   // Exception spec

throwsSpec
   : THROWS identifier (COMMA identifier)*
   ;

localsSpec
   : LOCALS argActionBlock
   ;

/** Match stuff like @init {int i;} */ ruleAction
   : AT identifier actionBlock
   ;

ruleModifiers
   : ruleModifier+
   ;
   // An individual access modifier for a rule. The 'fragment' modifier
   // is an internal indication for lexer rules that they do not match
   // from the input but are like subroutines for other lexer rules to
   // reuse for certain lexical patterns. The other modifiers are passed
   // to the code generation templates and may be ignored by the template
   // if they are of no use in that language.

ruleModifier
   : PUBLIC
   | PRIVATE
   | PROTECTED
   | FRAGMENT
   ;

ruleBlock
   : ruleAltList
   ;

ruleAltList
   : labeledAlt (OR labeledAlt)*
   ;

labeledAlt
   : alternative (POUND identifier)?
   ;
   // --------------------
   // Lexer rules

lexerRuleSpec returns [String identName]
   : {boolean isFragment = false;} DOC_COMMENT* (FRAGMENT {isFragment = true;})? TOKEN_REF {$identName = $TOKEN_REF.text; if(isFragment) tokenSetFragment($TOKEN_REF.text);} COLON lexerRuleBlock[$identName] {setPattern($identName, $lexerRuleBlock.pattern); rulesOrder.add($identName);} SEMI
   ;

lexerRuleBlock [String identName] returns [String pattern]
   : lexerAltList[$identName] {$pattern = $lexerAltList.pattern;}
   ;

lexerAltList [String identName] returns [String pattern]
   : a=lexerAlt[$identName] {$pattern = $a.pattern;} (OR b=lexerAlt[$identName] {$pattern += "|" + $b.pattern;})*
   ;

lexerAlt [String identName] returns [String pattern]
   : lexerElements {$pattern = $lexerElements.pattern;} lexerCommands[$identName]?
   | {$pattern = "";}
   // explicitly allow empty alts
   ;

lexerElements returns [String pattern]
   : {$pattern = "";} (lexerElement {$pattern += $lexerElement.pattern;})+
   ;

lexerElement returns [String pattern]
   : labeledLexerElement {$pattern = $labeledLexerElement.pattern;} (ebnfSuffix {$pattern += $ebnfSuffix.pattern;})?
   | lexerAtom {$pattern = $lexerAtom.pattern;} (ebnfSuffix {$pattern += $ebnfSuffix.pattern;})?
   | lexerBlock {$pattern = $lexerBlock.pattern;} (ebnfSuffix {$pattern += $ebnfSuffix.pattern;})?
   | actionBlock QUESTION? {$pattern = "";}
   ;
   // but preds can be anywhere

labeledLexerElement returns [String pattern]
   : identifier (ASSIGN | PLUS_ASSIGN) (lexerAtom {$pattern = $lexerAtom.pattern;} | lexerBlock {$pattern = $lexerBlock.pattern;})
   ;

lexerBlock returns [String pattern]
   : LPAREN lexerAltList[null] RPAREN {$pattern = "%(" + $lexerAltList.pattern + ")";}
   ;
   // E.g., channel(HIDDEN), skip, more, mode(INSIDE), push(INSIDE), pop

lexerCommands [String identName]
   : RARROW lexerCommand[$identName] (COMMA lexerCommand[$identName])*
   ;

lexerCommand [String identName]
   : lexerCommandName LPAREN lexerCommandExpr RPAREN {handleLexerCommand($identName, $lexerCommandName.text, $lexerCommandExpr.text);}
   | lexerCommandName {handleLexerCommand($identName, $lexerCommandName.text);}
   ;

lexerCommandName
   : identifier
   | MODE
   ;

lexerCommandExpr
   : identifier
   | INT
   ;
   // --------------------
   // Rule Alts

altList
   : alternative (OR alternative)*
   ;

alternative
   : elementOptions? element+
   |
   // explicitly allow empty alts
   ;

element
   : labeledElement (ebnfSuffix |)
   | atom (ebnfSuffix |)
   | ebnf
   | actionBlock QUESTION?
   ;

labeledElement
   : identifier (ASSIGN | PLUS_ASSIGN) (atom | block)
   ;
   // --------------------
   // EBNF and blocks

ebnf
   : block blockSuffix?
   ;

blockSuffix
   : ebnfSuffix
   ;

ebnfSuffix returns [String pattern]
   : {String minCnt = "", maxCnt = ""; boolean isLazy = false;} (QUESTION {minCnt = "0"; maxCnt = "1";} (QUESTION {isLazy = true;})?
   | STAR {minCnt = "0";} (QUESTION {isLazy = true;})?
   | PLUS {minCnt = "1";} (QUESTION {isLazy = true;})?)
   {$pattern = "{" + (isLazy ? "-" : "") + minCnt + "," + maxCnt + "}";}
   ;

lexerAtom returns [String pattern]
   : characterRange {$pattern = $characterRange.pattern;}
   | terminal {$pattern = $terminal.pattern;}
   | notSet {$pattern = $notSet.pattern;}
   | LEXER_CHAR_SET {$pattern = parseLexerCharSet($LEXER_CHAR_SET.text);}
   | DOT {$pattern = "\\_.";} (elementOptions {$pattern += $elementOptions.pattern;})?
   ;

atom
   : terminal
   | ruleref
   | notSet
   | DOT elementOptions?
   ;
   // --------------------
   // Inverted element set

notSet returns [String pattern]
   : NOT setElement {$pattern = invertSetPattern($setElement.pattern);}
   | NOT blockSet {$pattern = invertSetPattern($blockSet.bracketedPattern);}
   ;

blockSet returns [String pattern, String bracketedPattern]
   : LPAREN setElement {$bracketedPattern = "[" + $setElement.bracketedPattern; $pattern = "%(" + $setElement.pattern;} (OR setElement {$bracketedPattern += $setElement.bracketedPattern; $pattern += "|" + $setElement.pattern;})* {$bracketedPattern += "]"; $pattern += ")";} RPAREN
   ;

setElement returns [String pattern, String bracketedPattern]
   : TOKEN_REF {$bracketedPattern = $pattern = "/" + $TOKEN_REF.text + "/";} (elementOptions {$pattern += $elementOptions.pattern;})?
   | STRING_LITERAL {$pattern = stringLiteralToPattern($STRING_LITERAL.text, false); $bracketedPattern = stringLiteralToPattern($STRING_LITERAL.text, true);} (elementOptions {$pattern += $elementOptions.pattern;})?
   | characterRange {$bracketedPattern = unpackBrackets($pattern = $characterRange.pattern);}
   | LEXER_CHAR_SET {$bracketedPattern = unpackBrackets($pattern = parseLexerCharSet($LEXER_CHAR_SET.text));}
   ;
   // -------------
   // Grammar Block

block
   : LPAREN (optionsSpec? ruleAction* COLON)? altList RPAREN
   ;
   // ----------------
   // Parser rule ref

ruleref
   : RULE_REF argActionBlock? elementOptions?
   ;
   // ---------------
   // Character Range

characterRange returns [String pattern]
   : a=STRING_LITERAL RANGE b=STRING_LITERAL {$pattern = "[" + stringLiteralToPattern($a.text, true) + "-" + stringLiteralToPattern($b.text, true) + "]";}
   ;

terminal returns [String pattern]
   : TOKEN_REF {$pattern = "/" + $TOKEN_REF.text + "/";} (elementOptions {$pattern += $elementOptions.pattern;})?
   | STRING_LITERAL {$pattern = stringLiteralToPattern($STRING_LITERAL.text, false);} (elementOptions {$pattern += $elementOptions.pattern;})?
   ;
   // Terminals may be adorned with certain options when
   // reference in the grammar: TOK<,,,>

elementOptions returns [String pattern]
   : LT elementOption (COMMA elementOption)* GT {$pattern = "";}
   ;

elementOption
   : identifier
   | identifier ASSIGN (identifier | STRING_LITERAL)
   ;

identifier
   : RULE_REF
   | TOKEN_REF
   ;

