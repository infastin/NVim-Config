source ~/.config/nvim/terminal.vim

set nocompatible
call plug#begin("~/.vim/plugged")
	Plug 'ryanoasis/vim-devicons'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'joshdick/onedark.vim'
	Plug 'jackguo380/vim-lsp-cxx-highlight'
	Plug 'honza/vim-snippets'
	Plug 'preservim/nerdtree'
	Plug 'jonsmithers/vim-html-template-literals'
call plug#end()

syntax on
colorscheme onedark

hi link LspCxxHlSymUnknown Constant
hi link LspCxxHlSymMacro Constant

set mouse=a
set number
set ignorecase
set fileencodings=ucs-bom,utf-8,cp1251,cp1252,default,latin9
set guifont=ubuntu\ mono:h12

set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set cindent

set splitright
set splitbelow
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=750
set shortmess+=c
set signcolumn=yes

let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusLine = ''
let g:NERDTreeMinimalUI = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:coc_snippet_next = '<tab>'

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
nmap gV `[V`]
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

nnoremap <silent> <RightMouse> :call GuiShowContextMenu()<CR>
nnoremap <silent> <C-,> :tabnew<CR>
nnoremap <silent> <C-.> :tabclose<CR>
nnoremap <silent> <C-b> :NERDTreeToggleVCS<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
nnoremap <C-Tab> <C-w>w
nnoremap <C-S-Tab> <C-w>W

vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv

inoremap <silent> <expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent> <RightMouse> <C-\><C-n>:call GuiShowContextMenu()<CR>
inoremap <silent> <expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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

au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
au FileType scss setl iskeyword+=@-@

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
