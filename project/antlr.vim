syn match antlrId /\v%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])%(%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])|[0-9]|%(_)|%\u00B7|[\u0300-\u036F]|[\u203F-\u2040]){0,}/ contained contains=antlrNameChar,antlrNameStartChar
syn match antlrUNTERMINATED_CHAR_SET /\v%$/ contained transparent
syn match antlrLEXER_CHAR_SET /\v%(\])/ contained contains=antlrRBrack transparent
syn match antlrLEXER_CHAR_SET_BODY /\v%([^\]\\]|%(%(\\)\_.)){1,}/ contained contains=antlrEscAny transparent
syn match antlrCHN_WS /\v%(%([\ \t])|%([\r\n\x0c])){1,}/ contained contains=antlrWs transparent
syn match antlrCHN_COMMA /\v%(\,)/ contained contains=antlrComma transparent
syn match antlrCHN_DOT /\v%(\.)/ contained contains=antlrDot transparent
syn match antlrCHN_ID /\v%(%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])%(%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])|[0-9]|%(_)|%\u00B7|[\u0300-\u036F]|[\u203F-\u2040]){0,})/ contained contains=antlrId transparent
syn match antlrCHN_RBRACE /\v%(\})/ contained contains=antlrRBrace transparent
syn match antlrCHN_LBRACE /\v%(\{)/ contained contains=antlrLBrace transparent
syn match antlrCHN_LINE_COMMENT /\v%(\/\/[^\r\n]{0,})/ contained contains=antlrLineComment transparent
syn match antlrCHN_BLOCK_COMMENT /\v%(\/\*\_.{-0,}%(\*\/|%$))/ contained contains=antlrBlockComment transparent
syn match antlrCHN_DOC_COMMENT /\v%(\/\*\*\_.{-0,}%(\*\/|%$))/ contained contains=antlrDocComment transparent
syn match antlrTOK_WS /\v%(%([\ \t])|%([\r\n\x0c])){1,}/ contained contains=antlrWs transparent
syn match antlrTOK_COMMA /\v%(\,)/ contained contains=antlrComma transparent
syn match antlrTOK_DOT /\v%(\.)/ contained contains=antlrDot transparent
syn match antlrTOK_ID /\v%(%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])%(%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])|[0-9]|%(_)|%\u00B7|[\u0300-\u036F]|[\u203F-\u2040]){0,})/ contained contains=antlrId transparent
syn match antlrTOK_RBRACE /\v%(\})/ contained contains=antlrRBrace transparent
syn match antlrTOK_LBRACE /\v%(\{)/ contained contains=antlrLBrace transparent
syn match antlrTOK_LINE_COMMENT /\v%(\/\/[^\r\n]{0,})/ contained contains=antlrLineComment transparent
syn match antlrTOK_BLOCK_COMMENT /\v%(\/\*\_.{-0,}%(\*\/|%$))/ contained contains=antlrBlockComment transparent
syn match antlrTOK_DOC_COMMENT /\v%(\/\*\*\_.{-0,}%(\*\/|%$))/ contained contains=antlrDocComment transparent
syn match antlrOPT_WS /\v%(%([\ \t])|%([\r\n\x0c])){1,}/ contained contains=antlrWs transparent
syn match antlrOPT_SEMI /\v%(\;)/ contained contains=antlrSemi transparent
syn match antlrOPT_STAR /\v%(\*)/ contained contains=antlrStar transparent
syn match antlrOPT_INT /\v%(0|[1-9]%([0-9]){0,})/ contained contains=antlrDecimalNumeral transparent
syn match antlrOPT_STRING_LITERAL /\v%(%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$))|%([^\'\r\n\\])){0,}%(\'))/ contained contains=antlrSQuoteLiteral transparent
syn match antlrOPT_ASSIGN /\v%(\=)/ contained contains=antlrEqual transparent
syn match antlrOPT_DOT /\v%(\.)/ contained contains=antlrDot transparent
syn match antlrOPT_ID /\v%(%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])%(%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])|[0-9]|%(_)|%\u00B7|[\u0300-\u036F]|[\u203F-\u2040]){0,})/ contained contains=antlrId transparent
syn match antlrOPT_RBRACE /\v%(\})/ contained contains=antlrRBrace transparent
syn match antlrOPT_LBRACE /\v%(\{)/ contained contains=antlrLBrace transparent
syn match antlrOPT_LINE_COMMENT /\v%(\/\/[^\r\n]{0,})/ contained contains=antlrLineComment transparent
syn match antlrOPT_BLOCK_COMMENT /\v%(\/\*\_.{-0,}%(\*\/|%$))/ contained contains=antlrBlockComment transparent
syn match antlrOPT_DOC_COMMENT /\v%(\/\*\*\_.{-0,}%(\*\/|%$))/ contained contains=antlrDocComment transparent
syn match antlrACTION_CONTENT /\v\_./ contained transparent
syn match antlrUNTERMINATED_ACTION /\v%$/ contained transparent
syn match antlrEND_ACTION /\v%(\})/ contained contains=antlrRBrace transparent
syn match antlrACTION_LINE_COMMENT /\v%(\/\/[^\r\n]{0,})/ contained contains=antlrLineComment transparent
syn match antlrACTION_BLOCK_COMMENT /\v%(\/\*\_.{-0,}%(\*\/|%$))/ contained contains=antlrBlockComment transparent
syn match antlrACTION_DOC_COMMENT /\v%(\/\*\*\_.{-0,}%(\*\/|%$))/ contained contains=antlrDocComment transparent
syn match antlrACTION_CHAR_LITERAL /\v%(%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$))|%([^\'\r\n\\])){0,}%(\'))/ contained contains=antlrSQuoteLiteral transparent
syn match antlrACTION_STRING_LITERAL /\v%(%(\")%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$))|[^\"\r\n\\]){0,}%(\"))/ contained contains=antlrDQuoteLiteral transparent
syn match antlrACTION_ESCAPE /\v%(%(\\)\_.)/ contained contains=antlrEscAny transparent
syn region antlrAction matchgroup=antlrBEGIN_ACTION start=/\v%(\{)/ matchgroup=antlrNESTED_ACTION start=/\v%(\{)/ matchgroup=antlrUNTERMINATED_ACTION end=/\v%$/ contains=antlrACTION_BLOCK_COMMENT,antlrAction,antlrACTION_STRING_LITERAL,antlrACTION_ESCAPE,antlrACTION_CHAR_LITERAL,antlrEND_ACTION,antlrUNTERMINATED_ACTION,antlrACTION_CONTENT,antlrACTION_DOC_COMMENT,antlrACTION_LINE_COMMENT transparent
syn match antlrARGUMENT_CONTENT /\v\_./ contained transparent
syn match antlrUNTERMINATED_ARGUMENT /\v%$/ contained transparent
syn match antlrEND_ARGUMENT /\v%(\])/ contained contains=antlrRBrack transparent
syn match antlrARGUMENT_CHAR_LITERAL /\v%(%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$))|%([^\'\r\n\\])){0,}%(\'))/ contained contains=antlrSQuoteLiteral transparent
syn match antlrARGUMENT_STRING_LITERAL /\v%(%(\")%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$))|[^\"\r\n\\]){0,}%(\"))/ contained contains=antlrDQuoteLiteral transparent
syn match antlrARGUMENT_ESCAPE /\v%(%(\\)\_.)/ contained contains=antlrEscAny transparent
syn region antlrArgument matchgroup=antlrNESTED_ARGUMENT start=/\v%(\[)/ matchgroup=antlrUNTERMINATED_ARGUMENT end=/\v%$/ contains=antlrArgument,antlrARGUMENT_CHAR_LITERAL,antlrARGUMENT_ESCAPE,antlrEND_ARGUMENT,antlrARGUMENT_STRING_LITERAL,antlrARGUMENT_CONTENT,antlrUNTERMINATED_ARGUMENT transparent
syn match antlrERRCHAR /\v\_./ transparent
syn match antlrWS__0 /\v%(%([\ \t])|%([\r\n\x0c])){1,}/ contains=antlrWs transparent
syn match antlrID__0 /\v%(%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])%(%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])|[0-9]|%(_)|%\u00B7|[\u0300-\u036F]|[\u203F-\u2040]){0,})/ contains=antlrId transparent
syn match antlrNOT /\v%(\~)/ contains=antlrTilde
syn match antlrPOUND /\v%(\#)/ contains=antlrPound__0 transparent
syn match antlrAT /\v%(\@)/ contains=antlrAt__0 transparent
syn match antlrDOT__0 /\v%(\.)/ contains=antlrDot transparent
syn match antlrRANGE /\v%(\.\.)/ contains=antlrRange__0
syn match antlrDOLLAR /\v%(\$)/ contains=antlrDollar__0 transparent
syn match antlrOR /\v%(\|)/ contains=antlrPipe
syn match antlrPLUS /\v%(\+)/ contains=antlrPlus__0
syn match antlrPLUS_ASSIGN /\v%(\+\=)/ contains=antlrPlusAssign transparent
syn match antlrSTAR__0 /\v%(\*)/ contains=antlrStar
syn match antlrQUESTION /\v%(\?)/ contains=antlrQuestion__0
syn match antlrASSIGN /\v%(\=)/ contains=antlrEqual transparent
syn match antlrGT /\v%(\>)/ contains=antlrGt__0 transparent
syn match antlrLT /\v%(\<)/ contains=antlrLt__0 transparent
syn match antlrRARROW /\v%(\-\>)/ contains=antlrRArrow__0
syn match antlrRBRACE__0 /\v%(\})/ contains=antlrRBrace
syn match antlrLBRACE__0 /\v%(\{)/ contains=antlrLBrace
syn match antlrRPAREN /\v%(\))/ contains=antlrRParen__0 transparent
syn match antlrLPAREN /\v%(\()/ contains=antlrLParen__0 transparent
syn match antlrSEMI__0 /\v%(\;)/ contains=antlrSemi
syn match antlrCOMMA__0 /\v%(\,)/ contains=antlrComma transparent
syn match antlrCOLONCOLON /\v%(\:\:)/ contains=antlrDColon transparent
syn match antlrCOLON /\v%(\:)/ contains=antlrColon__0
syn match antlrMODE /\vmode/
syn match antlrFINALLY /\vfinally/ transparent
syn match antlrCATCH /\vcatch/ transparent
syn match antlrTHROWS /\vthrows/ transparent
syn match antlrLOCALS /\vlocals/ transparent
syn match antlrRETURNS /\vreturns/
syn match antlrPRIVATE /\vprivate/ transparent
syn match antlrPUBLIC /\vpublic/ transparent
syn match antlrPROTECTED /\vprotected/ transparent
syn match antlrGRAMMAR /\vgrammar/
syn match antlrPARSER /\vparser/
syn match antlrLEXER /\vlexer/
syn match antlrFRAGMENT /\vfragment/
syn match antlrIMPORT /\vimport/
syn region antlrChannels matchgroup=antlrCHANNELS__0 start=/\vchannels/ matchgroup=antlrCHN_RBRACE end=/\v%(\})/ contains=antlrCHN_ID,antlrCHN_DOT,antlrCHN_WS,antlrCHN_RBRACE,antlrCHN_LINE_COMMENT,antlrCHN_COMMA,antlrCHN_BLOCK_COMMENT,antlrCHN_LBRACE,antlrCHN_DOC_COMMENT transparent
syn region antlrTokens matchgroup=antlrTOKENS__0 start=/\vtokens/ matchgroup=antlrTOK_RBRACE end=/\v%(\})/ contains=antlrTOK_RBRACE,antlrTOK_COMMA,antlrTOK_LBRACE,antlrTOK_ID,antlrTOK_BLOCK_COMMENT,antlrTOK_LINE_COMMENT,antlrTOK_DOC_COMMENT,antlrTOK_WS,antlrTOK_DOT transparent
syn region antlrOptions matchgroup=antlrOPTIONS__0 start=/\voptions/ matchgroup=antlrOPT_RBRACE end=/\v%(\})/ contains=antlrOPT_LINE_COMMENT,antlrOPT_BLOCK_COMMENT,antlrOPT_INT,antlrOPT_DOT,antlrOPT_STRING_LITERAL,antlrOPT_WS,antlrOPT_ID,antlrOPT_LBRACE,antlrOPT_ASSIGN,antlrOPT_STAR,antlrOPT_RBRACE,antlrOPT_DOC_COMMENT,antlrOPT_SEMI transparent
syn match antlrBEGIN_ARGUMENT /\v%(\[)/ contains=antlrLBrack transparent
syn match antlrUNTERMINATED_STRING_LITERAL /\v%(%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$))|[^\'\r\n\\]){0,})/ contains=antlrUSQuoteLiteral transparent
syn match antlrSTRING_LITERAL /\v%(%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$))|%([^\'\r\n\\])){0,}%(\'))/ contains=antlrSQuoteLiteral transparent
syn match antlrINT /\v%(0|[1-9]%([0-9]){0,})/ contains=antlrDecimalNumeral transparent
syn match antlrLINE_COMMENT /\v%(\/\/[^\r\n]{0,})/ contains=antlrLineComment transparent
syn match antlrBLOCK_COMMENT /\v%(\/\*\_.{-0,}%(\*\/|%$))/ contains=antlrBlockComment transparent
syn match antlrDOC_COMMENT /\v%(\/\*\*\_.{-0,}%(\*\/|%$))/ contains=antlrDocComment transparent
syn match antlrTilde /\v\~/ contained transparent
syn match antlrPound__0 /\v\#/ contained transparent
syn match antlrAt__0 /\v\@/ contained transparent
syn match antlrRange__0 /\v\.\./ contained transparent
syn match antlrDot /\v\./ contained transparent
syn match antlrSemi /\v\;/ contained transparent
syn match antlrComma /\v\,/ contained transparent
syn match antlrDollar__0 /\v\$/ contained transparent
syn match antlrPipe /\v\|/ contained transparent
syn match antlrUnderscore /\v_/ contained transparent
syn match antlrPlusAssign /\v\+\=/ contained transparent
syn match antlrPlus__0 /\v\+/ contained transparent
syn match antlrStar /\v\*/ contained transparent
syn match antlrQuestion__0 /\v\?/ contained transparent
syn match antlrEqual /\v\=/ contained transparent
syn match antlrGt__0 /\v\>/ contained transparent
syn match antlrLt__0 /\v\</ contained transparent
syn match antlrRArrow__0 /\v\-\>/ contained transparent
syn match antlrRBrack /\v\]/ contained
syn match antlrLBrack /\v\[/ contained
syn match antlrRBrace /\v\}/ contained transparent
syn match antlrLBrace /\v\{/ contained transparent
syn match antlrRParen__0 /\v\)/ contained
syn match antlrLParen__0 /\v\(/ contained
syn match antlrDQuote /\v\"/ contained transparent
syn match antlrSQuote /\v\'/ contained
syn match antlrDColon /\v\:\:/ contained transparent
syn match antlrColon__0 /\v\:/ contained transparent
syn match antlrEsc /\v\\/ contained transparent
syn match antlrInt__0 /\vint/ contained transparent
syn match antlrNameStartChar /\v[A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD]/ contained transparent
syn match antlrNameChar /\v%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])|[0-9]|%(_)|%\u00B7|[\u0300-\u036F]|[\u203F-\u2040]/ contained contains=antlrNameStartChar,antlrUnderscore transparent
syn match antlrUSQuoteLiteral /\v%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$))|[^\'\r\n\\]){0,}/ contained contains=antlrEscSeq,antlrSQuote transparent
syn match antlrDQuoteLiteral /\v%(\")%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$))|[^\"\r\n\\]){0,}%(\")/ contained contains=antlrDQuote,antlrEscSeq transparent
syn match antlrSQuoteLiteral /\v%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$))|%([^\'\r\n\\])){0,}%(\')/ contained contains=antlrEscSeq,antlrSQuote
syn match antlrCharLiteral /\v%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$))|[^\'\r\n\\])%(\')/ contained contains=antlrEscSeq,antlrSQuote transparent
syn match antlrBoolLiteral /\vtrue|false/ contained transparent
syn match antlrDecDigit /\v[0-9]/ contained transparent
syn match antlrHexDigit /\v[0-9a-fA-F]/ contained transparent
syn match antlrDecimalNumeral /\v0|[1-9]%([0-9]){0,}/ contained contains=antlrDecDigit transparent
syn match antlrUnicodeEsc /\vu%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1}/ contained contains=antlrHexDigit transparent
syn match antlrEscAny /\v%(\\)\_./ contained contains=antlrEsc transparent
syn match antlrEscSeq /\v%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|%$)/ contained contains=antlrEsc,antlrUnicodeEsc
syn match antlrLineComment /\v\/\/[^\r\n]{0,}/ contained
syn match antlrDocComment /\v\/\*\*\_.{-0,}%(\*\/|%$)/ contained
syn match antlrBlockComment /\v\/\*\_.{-0,}%(\*\/|%$)/ contained
syn match antlrVws /\v[\r\n\x0c]/ contained transparent
syn match antlrHws /\v[\ \t]/ contained transparent
syn match antlrWs /\v%([\ \t])|%([\r\n\x0c])/ contained contains=antlrVws,antlrHws transparent

hi def link antlrRBrack Delimiter
hi def link antlrDocComment Comment
hi def link antlrMODE Keyword
hi def link antlrSEMI__0 Delimiter
hi def link antlrTOKENS__0 Keyword
hi def link antlrLBrack Delimiter
hi def link antlrLineComment Comment
hi def link antlrEscSeq Special
hi def link antlrQUESTION Operator
hi def link antlrLexerCharSet Constant
hi def link antlrIMPORT Keyword
hi def link antlrFRAGMENT Keyword
hi def link antlrRParen__0 Delimiter
hi def link antlrCHANNELS__0 Keyword
hi def link antlrLParen__0 Delimiter
hi def link antlrBlockComment Comment
hi def link antlrPARSER Keyword
hi def link antlrOR Operator
hi def link antlrLEXER Keyword
hi def link antlrSQuote Delimiter
hi def link antlrRETURNS Keyword
hi def link antlrCOLON Delimiter
hi def link antlrOPTIONS__0 Keyword
hi def link antlrRARROW Operator
hi def link antlrNOT Operator
hi def link antlrSTAR__0 Operator
hi def link antlrRBRACE__0 Delimiter
hi def link antlrGRAMMAR Keyword
hi def link antlrSQuoteLiteral Constant
hi def link antlrId Identifier
hi def link antlrPLUS Operator
hi def link antlrRANGE Operator
hi def link antlrLBRACE__0 Delimiter
