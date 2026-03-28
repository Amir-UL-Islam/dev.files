" Options
let mapleader = ","
syntax on
"set hidden
set relativenumber
set splitbelow splitright
set title
set ttimeoutlen=0
set nowrap

set number
"set wrap!
" For Copping between System and Vim
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set encoding=UTF-8
set scrolloff=10
set incsearch
set expandtab
set autoindent
set softtabstop=4
set shiftwidth=4
set tabstop=4
set ignorecase 
set showmode
set hlsearch
set wildmenu

filetype plugin indent on

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

set guifont=JetBrains\ Mono:h16

"Enable mouse click for nvim
" Setting the mouse for Normal Mode only
set mouse=a


"Fix cursor replacement after closing nvim
"Shift + Tab does inverse tab
inoremap <S-Tab> <C-d>

"for Insert mode
let &t_SI = "\e[5 q"

" everything else
let &t_EI = "\e[1 q"

" Source sibling config files relative to this script, not current working dir.
let s:config_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! s:source_sibling(filename) abort
	let l:path = s:config_dir . '/' . a:filename
	if filereadable(l:path)
		execute 'source' fnameescape(l:path)
	else
		echohl WarningMsg
		echom 'Config file not found: ' . l:path
		echohl None
	endif
endfunction

call s:source_sibling('plugins.vim')
call s:source_sibling('keybindings.vim')
call s:source_sibling('coc.vim')

"Statusber Settings
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'

"for tabbar
let g:numbers_exclude = ['tagbar', 'gundo', 'minibufexpl', 'nerdtree']

"for fiz finder 
"to move the window to the middle, increasing the size of the preview window
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

"for fonts
let g:airline_powerline_fonts = 1

" open new split panes to right and below
set splitright
set splitbelow

"for gitgutter
set updatetime=50

"for snippets
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger=",<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

""See invisible characters
"Setting background
highlight! Normal guifg=#BCBEC4 guibg=#1e1f22 ctermfg=145 ctermbg=235

""For darcula.vim 
"let g:solarized_termcolors=256
set background=dark
try
	colorscheme darcula
catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme default
endtry
