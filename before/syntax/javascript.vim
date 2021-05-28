"
"
"

ab Arr Array
ab Obj Object
ab Inf Infinity
ab Infty Infinity

syn match   javaScriptEndProp		/[^.]\.\h\w\{0,}[^?.(]/ms=s+2,me=e-1

syn match   javaScriptProperty		/[^.]\.[a-zA-Z$_][a-zA-Z$_0-9]*\((\)\@!/ms=s+2 contains=javaScriptContRes
syn match   javaScriptFName		/[a-zA-Z$_][a-zA-Z$_0-9]*\(\s*(\)\@=/ contains=javaScriptContRes
syn match   javaScriptTagTemp		/[a-zA-Z$_][a-zA-Z$_0-9]/ nextgroup=javaScriptStringT
syn match   javaScriptRArgs		/\.\.\.[a-zA-Z$_][a-zA-Z$_0-9]*/
syn match   javaScriptSymbol		/@@[a-zA-Z]+/
syn match   javaScriptLpLbl		/[a-zA-Z$_][a-zA-Z$_0-9]*:/
syn match   javaScriptHBang		+^#!.*+
syn match   javaScriptDocTag		/@[a-zA-Z$_][a-zA-Z$_0-9]*/ contained

syn match   javaScriptOps		"[+\-*/><!&|?~\^=:.]\+"
" This could be cleaner but this is literally every operator so I'm happy
