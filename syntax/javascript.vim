" Vim syntax file
" Language:	JavaScript
" Maintainer:	Claudio Fleiner <claudio@fleiner.com>
" Updaters:	Scott Shattuck (ss) <ss@technicalpursuit.com>
" URL:		http://www.fleiner.com/vim/syntax/javascript.vim
" Changes:	(ss) added keywords, reserved words, and other identifiers
"		(ss) repaired several quoting and grouping glitches
"		(ss) fixed regex parsing issue with multiple qualifiers [gi]
"		(ss) additional factoring of keywords, globals, and members
" Last Change:	2018 Jul 28
" 		2013 Jun 12: adjusted javaScriptRegexpString (Kevin Locke)
" 		2018 Apr 14: adjusted javaScriptRegexpString (LongJohnCoder)

" tuning parameters:
" unlet javaScript_fold

if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
elseif exists("b:current_syntax") && b:current_syntax == "javascript"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


" Missing:   void await async yield globalThis of
" Types:     Infinity NaN BigInt Math Date Symbol (Weak)?(Map|Set) JSON
" Errors:    Error AggregateError EvalError RangeError InternalError
"            ReferenceError SyntaxError TypeError URIError   
" Additions: XMLHttpRequest 

" Omissions: (I|Ui)nt(8|16|32)Array Float(32|64)Array Big(I|Ui)nt64Array 
" Uint8ClampedArray (Shared)?ArrayBuffer Atomics DataView

" Patch: JS Embeds are more powerful

syn iskeyword @,48-57,_,192-255,$ 

ab Arr Array
ab Obj Object
ab Inf Infinity
ab Infty Infinity



"syn match   javaScriptProperty		/[^.]\.[a-zA-Z\$_][a-zA-Z\$_0-9]*\([(a-zA-Z\$_0-9]\)\@!/ms=s+2 contains=javaScriptContRes
"syn match   javaScriptObject		/.[a-zA-Z\$_][a-zA-Z\$_0-9]/

syn match   javaScriptTagTemp		/[a-zA-Z\$_][a-zA-Z\$_0-9]*`/ nextgroup=javaScriptStringT
syn match   javaScriptLpLbl		/[a-zA-Z\$_][a-zA-Z\$_0-9]*:/
syn match   javaScriptDocTag		/@[a-zA-Z\$_][a-zA-Z\$_0-9]*/ containedin=javaScriptComment contained
" Works, no highlighting...
" This could be cleaner but this is literally every operator so I'm happy
" BUG: Breaks multi-line comments.
" FIXED: Inverted

syn match   javaScriptSymbol		/@@[a-zA-Z]+/


syn match   javaScriptOps		"\(//\|/\*\|\*/\|#!\)\@![%+\-*/><!&|?~\^=:.;,]\="

syn region  javaScriptHBang		start="^#!" end="$"
syn keyword javaScriptCommentTodo      TODO FIXME XXX TBD contained
syn match   javaScriptLineComment      "\/\/.*" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  javaScriptComment	       start="/\*"  end="\*/" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptSpecial	       "\\\d\d\d\|\\."
syn region  javaScriptStringD	       start=+"+  skip=+\\\\\|\\"+   end=+"\|$+	contains=javaScriptSpecial,@htmlPreproc
syn region  javaScriptStringS	       start=+'+  skip=+\\\\\|\\'+   end=+'\|$+	contains=javaScriptSpecial,@htmlPreproc
syn region  javaScriptStringT	       start=+`+  skip=+\\\\\|\\`+   end=+`+	contains=javaScriptSpecial,javaScriptEmbed,@htmlPreproc
" syn match   javaScriptFCall		/[a-zA-Z$_][a-zA-Z0-9$_]*/

" FIX: Forced JavaScript embeds to be contained inside a tick-notated string.
syn region  javaScriptEmbed	       start=+${+  end=+}+	contains=@javaScriptEmbededExpr contained

syn match   javaScriptFCall		/[\h\$][\h\d\$]*\(\s*(\)\@=/ contains=javaScriptContRes
syn match   javaScriptSpecialCharacter "'\\.'"
syn match   javaScriptNumber	       "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region  javaScriptRegexpString     start=+[,(=+]\s*/[^/*]+ms=e-1,me=e-1 skip=+\\\\\|\\/+ end=+/[gimuys]\{0,2\}\s*$+ end=+/[gimuys]\{0,2\}\s*[+;.,)\]}]+me=e-1 end=+/[gimuys]\{0,2\}\s\+\/+me=e-1 contains=@htmlPreproc,javaScriptComment oneline
" Note: Why does this contain comments? is this a legit thing?

syn keyword javaScriptConditional	if else switch
syn keyword javaScriptRepeat		while for do in of
syn keyword javaScriptBranch		break continue
syn keyword javaScriptOperator		new delete instanceof typeof
syn keyword javaScriptType		Array Boolean Date Function Number Object String RegExp Int8Array Uint8Array Int16Array Uint16Array Int32Array Uint32Array Float32Array Float64Array BigInt64Array BigUint64Array Infinity NaN
"syn match   javaScriptError		/\([A-Z][a-zA-Z]*\)\=Error/
syn keyword javaScriptStatement		return with
syn keyword javaScriptBoolean		true false
syn keyword javaScriptNull		null undefined
syn keyword javaScriptIdentifier	arguments this var let thisArg
syn keyword javaScriptLabel		case default
syn keyword javaScriptException		try catch finally throw
syn keyword javaScriptMessage		alert confirm prompt status
syn keyword javaScriptGlobal		self window top parent
syn keyword javaScriptMember		document event location
syn keyword javaScriptDeprecated	escape unescape
syn keyword javaScriptReserved		abstract boolean byte char class const debugger double enum extends final float goto implements int interface long native package private protected public short static super synchronized throws transient volatile 
syn keyword javaScriptModules		import export from as

syn cluster  javaScriptComment		contains=javaScriptLineComment,javaScriptComment

syn cluster  javaScriptEmbededExpr	contains=TOP,javaScriptStringT,javaScriptBrackets
" syn cluster  javaScriptEmbededExpr	remove=javaScriptStringT,javaScriptBracket

if exists("javaScript_fold")
    syn match	javaScriptFunction	"\<function\>"
    syn region	javaScriptFunctionFold	start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match javaScriptSync	grouphere javaScriptFunctionFold "\<function\>"
    syn sync match javaScriptSync	grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword javaScriptFunction	function
    " Todo: Add function keyword arrow notation? (=>)
    syn match	javaScriptBrackets	"[{}]"
    syn match	javaScriptBraces	"[\[\]]"
    syn match	javaScriptParens	"[()]"
endif

syn sync fromstart
syn sync maxlines=100

if main_syntax == "javascript"
  syn sync ccomment javaScriptComment
endif

hi def link javaScriptModules		Operator
hi def link javaScriptBrackets		Function
" Define the default highlighting.
" Only when an item doesn't have highlighting yet
hi def link javaScriptComment		Comment
hi def link javaScriptLineComment	Comment
hi def link javaScriptCommentTodo	Todo
hi def link javaScriptSpecial		Special
hi def link javaScriptStringS		String
hi def link javaScriptStringD		String
hi def link javaScriptStringT		String
hi def link javaScriptCharacter		Character
hi def link javaScriptSpecialCharacter	javaScriptSpecial
hi def link javaScriptNumber		javaScriptValue
hi def link javaScriptConditional	Conditional
hi def link javaScriptRepeat		Repeat
hi def link javaScriptBranch		Conditional
hi def link javaScriptOperator		Operator
hi def link javaScriptType		Type
hi def link javaScriptStatement		Statement
hi def link javaScriptFunction		Function	
hi def link javaScriptBraces		Function
hi def link javaScriptError		Error
hi def link javaScrParenError		javaScriptError
hi def link javaScriptNull		Keyword
hi def link javaScriptBoolean		Boolean
hi def link javaScriptRegexpString	String

hi def link javaScriptIdentifier	Identifier
hi def link javaScriptLabel		Label
hi def link javaScriptException		Exception
hi def link javaScriptMessage		Keyword
hi def link javaScriptGlobal		Keyword
hi def link javaScriptMember		Keyword
hi def link javaScriptDeprecated	Exception 
hi def link javaScriptReserved		Keyword
hi def link javaScriptDebug		Debug
hi def link javaScriptConstant		Label
hi def link javaScriptEmbed		Special



let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save

" vim:ts=8
