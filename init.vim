" Imbedded terminal
source ~/.config/nvim/terminal.vim

" Packages
set nocompatible

call plug#begin("~/.vim/plugged")
	Plug 'ryanoasis/vim-devicons'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'joshdick/onedark.vim'
	Plug 'jackguo380/vim-lsp-cxx-highlight'
	Plug 'honza/vim-snippets'
	Plug 'preservim/nerdtree'
	Plug 'jonsmithers/vim-html-template-literals'
	Plug 'lervag/vimtex'
	Plug 'vim-airline/vim-airline'
	Plug 'arrufat/vala.vim'
	Plug 'puremourning/vimspector'
	Plug 'liuchengxu/vista.vim'
call plug#end()

packadd! termdebug

nmap <leader>br :call feedkeys(":", "m")

" Syntax and theme
syntax on
colorscheme onedark

" C highlight
hi link LspCxxHlSymUnknown Constant
hi link LspCxxHlSymMacro Constant

" Mouse and visual
set mouse=a
set number
set ignorecase
set fileencodings=ucs-bom,utf-8,cp1251,cp1252,default,latin9
set guifont=ubuntu\ mono:h12

" Tab size and indetion
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set cindent

" Some other settings
set encoding=utf-8
set hidden
set splitright
set splitbelow
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=750
set shortmess+=c
set signcolumn=yes

let g:airline_powerline_fonts = 1
let g:coc_snippet_next = '<tab>'
let g:termdebug_wide=1

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [ 'CodeLLDB']

nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutput
nmap <Leader>di <Plug>VimspectorBalloonEval

" Vista
let g:vista_default_executive = 'coc'
nnoremap <leader>vi :Vista!!<CR>

function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" Help snippet
nmap gV `[V`]

" Human mappings
vmap <C-c> "+yi
vmap <C-v> c<C-\><C-n>"+p=`]`]
vmap <C-x> "+c<C-\><C-n>
vmap <Tab> >gV
vmap <S-Tab> <gV
vmap <C-z> <C-\><C-n>u

imap <C-v> <C-\><C-n>"+p=`]`]a
imap <C-z> <C-\><C-n>ui<right>
imap <C-y> <C-\><C-n><C-r>$i<right>
imap <C-f> <C-\><C-n>:/
imap <C-s> <C-\><C-n><S-s>

nmap <C-f> :/
nmap <TAB> v>
nmap <S-TAB> v<
nmap <C-a> ggVG<CR>
nmap <C-v> "+p=`]`]
nmap <C-z> u
nmap <C-y> <C-r>$

nmap <silent> gb <C-o>
nnoremap <C-Tab> <C-w>w
nnoremap <C-S-Tab> <C-w>W

nnoremap <silent> <S-Tab> :GuiTreeviewSwitch<CR>

" Tabs mappings
nmap <silent> tt :tabnext<CR>
nmap <silent> tp :tabprev<CR>
nmap <silent> tn :tabnew<CR>
nmap <silent> tq :tabclose<CR>

" Coc mappings
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

xmap <leader>a  <Plug>(coc-codeaction-selected)
xmap <leader>f  <Plug>(coc-format-selected)

map <leader>ac  <Plug>(coc-codeaction)

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

inoremap <silent> <expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent> <expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Coc commands
command! -nargs=0 Format :call 	 CocAction('format')
command! -nargs=? Fold 	 :call   CocAction('fold', <f-args>)
command! -nargs=0 OR     :call   CocAction('runCommand', 'editor.action.organizeImport')

" Coc functions
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Autocmd
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
au FileType scss setl iskeyword+=@-@
au VimEnter * call IsGui()

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function IsGui()
	if exists('g:GuiLoaded')
		" NVim-Qt
		GuiTabline 1
		GuiLinespace 1
		GuiPopupmenu 0

		vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
		nnoremap <silent> <RightMouse> :call GuiShowContextMenu()<CR>
		inoremap <silent> <RightMouse> <C-\><C-n>:call GuiShowContextMenu()<CR>

		nnoremap <silent> <C-b> :GuiTreeviewToggle<CR>
		tnoremap <silent> <C-b> <C-\><C-n>:GuiTreeviewToggle<CR>
	else
		" Nvim
		let g:NERDTreeShowHidden = 1
		let g:NERDTreeIgnore = []
		let g:NERDTreeStatusLine = ''
		let g:NERDTreeMinimalUI = 1
		let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
		let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''

		nnoremap <silent> <C-b> :NERDTreeToggleVCS <bar> :NERDTreeRefreshRoot<CR>
		tnoremap <silent> <C-b> <C-\><C-n>:NERDTreeToggleVCS<CR>

		if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	endif
endfunction
