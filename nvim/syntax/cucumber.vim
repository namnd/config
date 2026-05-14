" Vim syntax file for Gherkin/Karate DSL feature files
" Language: Gherkin/Karate DSL
" Maintainer: Auto-generated
" Latest Revision: 2026-05-04

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword karateKeyword Feature Background Scenario ScenarioOutline Examples Given When Then And But
syn keyword karateKeyword contained def url path request method status header headers cookie cookies
syn keyword karateKeyword contained param params form formField multipart assert match print
syn keyword karateKeyword contained table replace set remove karate call callonce read get configure
syn keyword karateKeyword contained retry eval json jsonPath xml xmlPath text driver screenshot
"syn keyword karateKeyword contained contains only notContains schema type each

" Operators and symbols
syn match karateOperator "\*"
syn match karateOperator "="
syn match karateOperator "=="
syn match karateOperator "!="
syn match karateOperator "<"
syn match karateOperator ">"
syn match karateOperator ">="
syn match karateOperator "<="

" Comments
syn match karateComment "#.*$"

" Strings
syn region karateString start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline
syn region karateString start=+'+ skip=+\\\\\|\\'+ end=+'+ oneline

" Triple quoted strings
syn region karateMultilineString start=+"""+ end=+"""+ 
syn region karateMultilineString start=+'''+ end=+'''+ 

" Numbers
syn match karateNumber "\<\d\+\>"
syn match karateNumber "\<\d\+\.\d\+\>"
syn match karateNumber "\<\d\+[eE][+-]\?\d\+\>"

" Booleans and null
syn keyword karateBoolean true false null

" Variables - highlight identifiers after 'def'
syn match karateVariable "\(def\s\+\)\@<=\w\+"
syn match karateVariable "\${\@<=\w\+}\@="

" Function calls
syn match karateFunction "\w\+\ze\s*("

" Special Karate objects
syn keyword karateSpecial karate response responseHeaders responseStatus responseCookies
syn keyword karateSpecial request requestHeaders session
syn keyword karateSpecial driver locate locateAll

" Tags
syn match karateTag "@\w\+"

" JSON/XML embedded
syn region karateJson matchgroup=karateBracket start="{" end="}" fold transparent contains=ALL
syn region karateArray matchgroup=karateBracket start="\[" end="\]" fold transparent contains=ALL

" Define the default highlighting
hi def link karateKeyword      Keyword
hi def link karateOperator     Operator
hi def link karateComment      Comment
hi def link karateString       String
hi def link karateMultilineString String
hi def link karateNumber       Number
hi def link karateBoolean      Boolean
hi def link karateVariable     Identifier
hi def link karateFunction     Function
hi def link karateSpecial      Special
hi def link karateTag          PreProc
hi def link karateBracket      Delimiter

let b:current_syntax = "cucumber"
