function! PutTermPanel(buf) abort
	sp bufname(a:buf)
	term
	resize 10
	startinsert
endfunction

function! s:ToggleTerminal() abort
	let closed = 0
	let tpbl = tabpagebuflist()
	" hide visible terminals
	for buf in filter(range(1, bufnr('$')), 'bufexists(bufname(v:val)) && index(tpbl, v:val)>=0')
		if getbufvar(buf, '&buftype') ==? 'terminal'
			silent execute bufwinnr(buf) . "hide"
			let closed += 1
		endif
	endfor
	if closed > 0
		return
	endif
	" open first hidden terminal
	for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)<0')
		if getbufvar(buf, '&buftype') ==? 'terminal'
			call PutTermPanel(buf)
			return
		endif
	endfor
	" open new terminal
	call PutTermPanel(0)
endfunction


tnoremap <C-v> <C-\><C-n>"+pi
tnoremap <Esc> <C-\><C-n>
tnoremap <C-Tab> <C-\><C-n><C-w>w
tnoremap <C-S-Tab> <C-\><C-n><C-w>W
tnoremap <silent> <C-b> <C-\><C-n>:NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR>
tnoremap <silent> <C-N> <C-\><C-n>:call <SID>ToggleTerminal()<CR>

nnoremap <silent> <C-N> :call <SID>ToggleTerminal()<CR>
