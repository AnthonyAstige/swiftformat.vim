autocmd BufWritePost *.swift silent! call s:format(@%)

function! s:noautoread(timerid)
	:setl noautoread
endfunction

function! s:format(path)
	" Hack on autoread
	" * Prevents W11 warning - https://stackoverflow.com/a/17597664
	" * Reloads the file after it's changed
	" * Keeps the cursor position
	:setl autoread

	execute "!swiftformat " . a:path . " >/dev/null 2>&1"

	" Disable hack, now that formatting done and read should be done too
	call timer_start(1, function("s:noautoread"))
endfunction
