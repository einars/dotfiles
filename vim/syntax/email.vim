"
" I'm reading my emails in my own colors. And I hate all the syntax colours.
"
" Scratching teh itches. Yes, I'm aware of mail.vim.
"
" Einar Lielmanis, einars@gmail.com, 2009
"

"if exists("b:current_syntax")
    "finish
"endif

syn clear

syn match  emailHeaderName /^.\{-}:/ contained display
syn region emailSubject matchgroup=emailHeaderName start=/^Subject:\s*/ end="$" contained
syn region emailFrom matchgroup=emailHeaderName start=/^From:/ end="$" contained
syn region emailTo matchgroup=emailHeaderName start=/^\(To\|Cc\|Bcc\):/ end="$" contained
syn region emailHeader start="\%^" end="\n\n" contains=emailHeaderName,emailSubject,emailFrom,emailTo,emailCc contained
syn region emailText start=/\%^/ end=/\%$/ contains=emailHeader,emailQuote,emailEmail

"syn match  emailEmail  "<.\{-}>" contained
syn match  emailEmail   /[a-z0-9.+\-]\+@[a-z0-9.+\-]\+/ contained
syn match  emailQuote   /^>.\{-}$/ contained

hi def link emailHeader Normal
hi def link emailHeaderName Statement

syn sync fromstart

let b:current_syntax = "email"
