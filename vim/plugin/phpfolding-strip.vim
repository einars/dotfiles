" Plugin for automatic folding of PHP functions
" Based on a heavily revamped phpfolding.vim
" Trashed up by Einar Lielmanis <einars@gmail.com>


if exists('loaded_phpfolding')
    finish
endif

let loaded_phpfolding = 1

command! EnableFastPHPFolds call <SID>EnableFastPHPFolds()


function! s:EnableFastPHPFolds()

	" Remember cursor
    normal mY
    let cursor_line = line('.')

	set foldmethod=manual
	set foldtext=PHPFoldText()

    " remove folds
    normal zE
	call s:PHPFoldFunctions()

	" Restore cursor
    normal `Y

    " open cursor fold, if any
    if foldlevel(cursor_line) > 0
        normal zo
    endif


endfunction


function! PHPFoldText()
	let lineString = getline(v:foldstart)

    " get rid of /* */ comments
    let lineString = substitute(lineString, '/\*\|\*/', ' ', 'g')
    " leading space
    let lineString = substitute(lineString, '^\s\+', '', 'g')
    " trailing space (and trailing hanging { )
    let lineString = substitute(lineString, '{ \*$', '', 'g')
    " remove leading comma whitespace (may occur after removing /* */ comments)
    let lineString = substitute(lineString, '\s\+,', ',', 'g')
    " remove leading closing-paren whitespace
    let lineString = substitute(lineString, '\s\+)', ')', 'g')
    " fix duplicate spaces
    let lineString = substitute(lineString, '\s\+', ' ', 'g')
    " multiline parameter line flag
    let lineString = substitute(lineString, '($', '(..);', 'g')

	return "+-- ". lineString . " "
endfunction


function! s:PHPFoldFunctions()

    " search from bottom up
    normal G

	while 1
		let s:lineStart = s:FindFunctionStart()

		if s:lineStart != 0

			let s:lineStop = s:FindBraceRange()

			if s:lineStop == 0
				break
			endif

			call s:HandleFold()

		else
			break
		endif

		exec s:lineStart
	endwhile

endfunction


function! s:HandleFold()
    " Correct lineStop if needed (the script might have mistaken lines  beyond the file's scope for trailing empty lines)
    if s:lineStop > line("$")
        let s:lineStop = '$'
    endif

    " create the actual fold
    exec s:lineStart . "," . s:lineStop . "fold"

endfunction


function! s:FindFunctionStart()
    " matches:
	" function foo($bar) {			function foo($bar)
	" {
	"
	" function foo($bar)			function foo($bar1,
	" .. {								$bar2)
	"								{
	"
	" [WTF? But this is needed]
    " This function can match the line its on *again* if the cursor was
	" restored.. hence we search twice if needed..
	let currentLine = line('.')
	let line = search('function .*\%[\n].*\%[\n].*{', 'bW')
	if currentLine == line
	    let line = search('function .*\%[\n].*\%[\n].*{', 'bW')
	endif
	return line
endfunction


function! s:FindBraceRange()
    let line = search('{', 'W')
    let line = searchpair('{', '', '}', 'W')
	if line < 1
        " failed
		return 0
	endif

    " search extra trailing lines
	let foldExceedsOneLine = line - s:lineStart >= 1
    if foldExceedsOneLine
        let counter = 0
        while counter < 3
            let linestr = getline(line + 1)
            if (matchstr(linestr, '^\s*$') == linestr)
                let line = line + 1
            endif
            let counter = counter + 1
        endwhile
    endif

	return line
endfunction
