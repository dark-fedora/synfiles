" Missing:   void await async yield globalThis of
" Types:     Infinity NaN BigInt Math Date Symbol (Weak)?(Map|Set) JSON
" Errors:    Error AggregateError EvalError RangeError InternalError
"            ReferenceError SyntaxError TypeError URIError   
" Additions: XMLHttpRequest URL Worker SharedWorker
" 
" Omissions: (I|Ui)nt(8|16|32)Array Float(32|64)Array Big(I|Ui)nt64Array 
" Uint8ClampedArray (Shared)?ArrayBuffer Atomics DataView
" 
" Patch: JS Embeds are more powerful
" 
" Previously in the before file; not even sure if this works

syn match   javaScriptSMode		/\([\s\t ]\{0,}\)\@<=\(['"]\)use strict\2;/me=e-1 " works
syn keyword javaScriptContRes		prototype constructor globalThis console
syn keyword javaScriptRes		of async await yield void get set module
syn keyword javaScriptType		XMLHttpRequest Infinity NaN Math Date Symbol WeakMap WeakSet Map Set JSON Intl URL Worker SharedWorker
syn keyword javaScriptEType		Error AggregateError EvalError RangeError InternalError ReferenceError SyntaxError TypeError URIError Warning
syn match   javaScriptRArgs		/\(\.\{3}\)\@<=\h\w\{0,}/
syn match   javaScriptFCall		/\h\w\{0,}(/me=e-1
syn match   javaScriptObj		/\h\w\{0,}\(?\.\|\.\)\@=/
syn match   javaScriptAnnotation	/@\h\w\{0,}/ containedin=javaScriptComment,javaScriptLineComment
syn keyword blaseballModel		Player Game Team

syn match   javaScriptEndProp		/\([^.]\.\)\@<=\h\w\{0,}[^\.a-zA-Z_0-9(]/me=e-1
syn match   javaScriptEndProp		/\([^.]\.\)\@<=\h\w\{0,}$/

syn match   javaScriptDocArgName	/$\h\w\{0,}/ contained containedin=@javaScriptComment

syn match   javaScriptCTypeName		/\([([.{]\|\s\|\t\|^\)\@<=[A-Z][a-zA-Z0-9]\{0,}/
hi link javaScriptCTypeName	Comment

hi def link blaseballModel	Type

hi def link javaScriptEndProp	Special

hi link javaScriptDocArgName	Type
hi link javaScriptLpLbl		Identifier
hi link javaScriptLbl		Special
hi link javaScriptObj		Constant
hi link javaScriptDocTag	Special
hi link javaScriptAnnotation	Special
hi link javaScriptHBang		PreProc
hi link javaScriptTagTemp	Comment
hi link javaScriptSMode		PreProc
hi link javaScriptContRes	Keyword
hi link javaScriptRes		Keyword
hi link javaScriptFCall		Comment
hi link javaScriptProperty	Constant
hi link javaScriptOps		Operator
hi link javaScriptEType		Type
hi link javaScriptValue		Constant



hi link javaScriptRArgs		Identifier
" vim:ts=8
