syn match ftERRCHAR /\v\_./
syn match ftWS /\v%(%([\ \t])|%([\r\n\x0c])){1,}/ contains=ftWs__0
syn match ftID /\v%(%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])%(%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])|[0-9]|%(_)|%\u00B7|[\u0300-\u036F]|[\u203F-\u2040]){0,})/ contains=ftId__0
syn match ftNOT /\v%(\~)/ contains=ftTilde
syn match ftPOUND /\v%(\#)/ contains=ftPound__0
syn match ftAT /\v%(\@)/ contains=ftAt__0
syn match ftDOT /\v%(\.)/ contains=ftDot__0
syn match ftRANGE /\v%(\.\.)/ contains=ftRange__0
syn match ftDOLLAR /\v%(\$)/ contains=ftDollar__0
syn match ftOR /\v%(\|)/ contains=ftPipe
syn match ftPLUS /\v%(\+)/ contains=ftPlus__0
syn match ftPLUS_ASSIGN /\v%(\+\=)/ contains=ftPlusAssign
syn match ftSTAR /\v%(\*)/ contains=ftStar__0
syn match ftQUESTION /\v%(\?)/ contains=ftQuestion__0
syn match ftASSIGN /\v%(\=)/ contains=ftEqual
syn match ftGT /\v%(\>)/ contains=ftGt__0
syn match ftLT /\v%(\<)/ contains=ftLt__0
syn match ftRARROW /\v%(\-\>)/ contains=ftRArrow__0
syn match ftRBRACE /\v%(\})/ contains=ftRBrace__0
syn match ftLBRACE /\v%(\{)/ contains=ftLBrace__0
syn match ftRPAREN /\v%(\))/ contains=ftRParen__0
syn match ftLPAREN /\v%(\()/ contains=ftLParen__0
syn match ftSEMI /\v%(\;)/ contains=ftSemi__0
syn match ftCOMMA /\v%(\,)/ contains=ftComma__0
syn match ftCOLONCOLON /\v%(\:\:)/ contains=ftDColon
syn match ftCOLON /\v%(\:)/ contains=ftColon__0
syn match ftMODE /\vmode/
syn match ftFINALLY /\vfinally/
syn match ftCATCH /\vcatch/
syn match ftTHROWS /\vthrows/
syn match ftLOCALS /\vlocals/
syn match ftRETURNS /\vreturns/
syn match ftPRIVATE /\vprivate/
syn match ftPUBLIC /\vpublic/
syn match ftPROTECTED /\vprotected/
syn match ftGRAMMAR /\vgrammar/
syn match ftPARSER /\vparser/
syn match ftLEXER /\vlexer/
syn match ftFRAGMENT /\vfragment/
syn match ftIMPORT /\vimport/
syn match ftCHANNELS /\vchannels/
syn match ftTOKENS /\vtokens/
syn match ftOPTIONS /\voptions/
syn match ftBEGIN_ACTION /\v%(\{)/ contains=ftLBrace__0
syn match ftBEGIN_ARGUMENT /\v%(\[)/ contains=ftLBrack
syn match ftUNTERMINATED_STRING_LITERAL /\v%(%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|))|[^\'\r\n\\]){0,})/ contains=ftUSQuoteLiteral
syn match ftSTRING_LITERAL /\v%(%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|))|%([^\'\r\n\\])){0,}%(\'))/ contains=ftSQuoteLiteral
syn match ftINT /\v%(0|[1-9]%([0-9]){0,})/ contains=ftDecimalNumeral
syn match ftLINE_COMMENT /\v%(\/\/[^\r\n]{0,})/ contains=ftLineComment
syn match ftBLOCK_COMMENT /\v%(\/\*\_.{-0,}%(\*\/|))/ contains=ftBlockComment
syn match ftDOC_COMMENT /\v%(\/\*\*\_.{-0,}%(\*\/|))/ contains=ftDocComment
syn match ftTilde /\v\~/ contained
syn match ftPound__0 /\v\#/ contained
syn match ftAt__0 /\v\@/ contained
syn match ftRange__0 /\v\.\./ contained
syn match ftDot__0 /\v\./ contained
syn match ftSemi__0 /\v\;/ contained
syn match ftComma__0 /\v\,/ contained
syn match ftDollar__0 /\v\$/ contained
syn match ftPipe /\v\|/ contained
syn match ftUnderscore /\v_/ contained
syn match ftPlusAssign /\v\+\=/ contained
syn match ftPlus__0 /\v\+/ contained
syn match ftStar__0 /\v\*/ contained
syn match ftQuestion__0 /\v\?/ contained
syn match ftEqual /\v\=/ contained
syn match ftGt__0 /\v\>/ contained
syn match ftLt__0 /\v\</ contained
syn match ftRArrow__0 /\v\-\>/ contained
syn match ftRBrack /\v\]/ contained
syn match ftLBrack /\v\[/ contained
syn match ftRBrace__0 /\v\}/ contained
syn match ftLBrace__0 /\v\{/ contained
syn match ftRParen__0 /\v\)/ contained
syn match ftLParen__0 /\v\(/ contained
syn match ftDQuote /\v\"/ contained
syn match ftSQuote /\v\'/ contained
syn match ftDColon /\v\:\:/ contained
syn match ftColon__0 /\v\:/ contained
syn match ftEsc /\v\\/ contained
syn match ftInt__0 /\vint/ contained
syn match ftNameStartChar /\v[A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD]/ contained
syn match ftNameChar /\v%([A-Z]|[a-z]|[\u00C0-\u00D6]|[\u00D8-\u00F6]|[\u00F8-\u02FF]|[\u0370-\u037D]|[\u037F-\u1FFF]|[\u200C-\u200D]|[\u2070-\u218F]|[\u2C00-\u2FEF]|[\u3001-\uD7FF]|[\uF900-\uFDCF]|[\uFDF0-\uFFFD])|[0-9]|%(_)|%\u00B7|[\u0300-\u036F]|[\u203F-\u2040]/ contained contains=ftUnderscore,ftNameStartChar
syn match ftUSQuoteLiteral /\v%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|))|[^\'\r\n\\]){0,}/ contained contains=ftEscSeq,ftSQuote
syn match ftDQuoteLiteral /\v%(\")%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|))|[^\"\r\n\\]){0,}%(\")/ contained contains=ftEscSeq,ftDQuote
syn match ftSQuoteLiteral /\v%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|))|%([^\'\r\n\\])){0,}%(\')/ contained contains=ftEscSeq,ftSQuote
syn match ftCharLiteral /\v%(\')%(%(%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|))|[^\'\r\n\\])%(\')/ contained contains=ftEscSeq,ftSQuote
syn match ftBoolLiteral /\vtrue|false/ contained
syn match ftDecDigit /\v[0-9]/ contained
syn match ftHexDigit /\v[0-9a-fA-F]/ contained
syn match ftDecimalNumeral /\v0|[1-9]%([0-9]){0,}/ contained contains=ftDecDigit
syn match ftUnicodeEsc /\vu%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1}/ contained contains=ftHexDigit
syn match ftEscAny /\v%(\\)\_./ contained contains=ftEsc
syn match ftEscSeq /\v%(\\)%([btnfr\"\'\\]|%(u%(%([0-9a-fA-F])%(%([0-9a-fA-F])%(%([0-9a-fA-F])%([0-9a-fA-F]){0,1}){0,1}){0,1}){0,1})|\_.|)/ contained contains=ftEsc,ftUnicodeEsc
syn match ftLineComment /\v\/\/[^\r\n]{0,}/ contained
syn match ftDocComment /\v\/\*\*\_.{-0,}%(\*\/|)/ contained
syn match ftBlockComment /\v\/\*\_.{-0,}%(\*\/|)/ contained
syn match ftVws /\v[\r\n\x0c]/ contained
syn match ftHws /\v[\ \t]/ contained
syn match ftWs__0 /\v%([\ \t])|%([\r\n\x0c])/ contained contains=ftHws,ftVws

hi def link ftColon__0 ftCOLON
hi def link ftCOLON Delimiter
hi def link ftSemi__0 ftSEMI
hi def link ftSEMI Delimiter
hi def link ftLineComment Comment
hi def link ftDocComment Comment
hi def link ftBlockComment Comment
hi def link ftEscSeq Special
hi def link ftSQuoteLiteral Constant
hi def link ftSQuote Delimiter
hi def link ftGRAMMAR Keyword
hi def link ftFRAGMENT Keyword
