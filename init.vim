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

" open new split panes to right and below
set splitright
set splitbelow

"Fix cursor replacement after closing nvim
"Shift + Tab does inverse tab
inoremap <S-Tab> <C-d>


"Setting plugs
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'raimondi/delimitmate'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf'
Plug 'airblade/vim-gitgutter'

"For making the vim-devicons work, you should have a font file in /.local/share/fonts this location
"
"In Mac Use this Process
"Run These Commands
"brew tap homebrew/cask-fonts
"brew install --cask font-hack-nerd-font
Plug 'ryanoasis/vim-devicons'

"Auto Pair Brackets
Plug 'jiangmiao/auto-pairs'

"Brackets
Plug 'kien/rainbow_parentheses.vim'

"For Indentation 
Plug 'yggdroot/indentline'

" For AutoComplete with COC
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'npm ci' }

Plug 'doums/darcula'
call plug#end()

"coc setups
source ~/vim.kitty.tmux/coc.vim




" Use a line cursor within insert mode and a block cursor everywhere else.
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).

"for Insert mode
let &t_SI = "\e[5 q"

" everything else
let &t_EI = "\e[1 q"


" rainbow options
let g:rbpt_colorpairs = [
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ]

let g:rbpt_max = 11
let g:rbpt_loadcmd_toggle = 0

"Make Available Hidden File in NerdTree
let NERDTreeShowHidden=1

"
":RainbowParenthesesToggle       " Toggle it on/off
":RainbowParenthesesLoadRound    " (), the default when toggling
":RainbowParenthesesLoadSquare   " []
":RainbowParenthesesLoadBraces   " {}
":RainbowParenthesesLoadChevrons " <>

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"languageTool
"Not using Any More
"If I need to Use this Plug, I have to add this version of file at $HOME
"location
"let g:languagetool_jar='$HOME/LanguageTool-5.2/languagetool-commandline.jar'

"Autocmd configurations
autocmd filetype c map ,r :w <CR> :!clear<CR><CR> :term gcc % -o %< && ./%< <CR>

"Configuration for Haskell
autocmd filetype haskell map ,r :w <CR> :!clear<CR><CR> :term ghc % && ./%< <CR>

"for memory lose in c
autocmd filetype c map v,r :w <CR> :!clear<CR><CR> :term gcc % -o %< && valgrind ./%< <CR>
autocmd filetype cpp map ,r :w <CR> :!clear<CR><CR> :term make %< && ./%<<CR>

autocmd filetype python map ,r :w <CR> :!clear<CR><CR> :term python3 % <CR>
autocmd BufRead, *.rb nmap ,r :silent !{ruby %}<cr>


" For java 
autocmd filetype java map <buffer> ,bc :w<CR>:split<CR>:wincmd h<CR>:wincmd l<CR>:setlocal nowrap<CR>:term javac % && javap -c -p %:r<CR>
autocmd filetype java map <buffer> ,r :w<CR>:split<CR>:wincmd h<CR>:wincmd l<CR>:setlocal nowrap<CR>:term javac % && java %:r<CR>
autocmd filetype java map ,bcv :w <CR> :!clear<CR><CR> :term javac % && javap -v %:r <CR>
autocmd filetype go map ,r :w <CR> :!clear<CR><CR> :term go run % <CR>

autocmd filetype markdown map ,r :w <CR> :!clear<CR><CR> :term pandoc -t plain `find . -maxdepth 1 -iname "${1:-readme.md}"` % <CR>

nnoremap <Leader>ht :GhcModType<cr>
nnoremap <Leader>htc :GhcModTypeClear<cr>
autocmd FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>

" FOR UNIT TESTING
map ,pn :! python -m unittest <CR>

"Custom Mapping
"for Commmenting
map <leader>cc \cc

"for Unconsenting
map <leader>cu \cu

"for NERDTree
map ,nt :NERDTree<CR>

"for resizing the window
map ,re :vertical resize 

"for clearing console
map ,ar :!clear<CR><CR>

"for Tagbar
map <F8> :TagbarToggle<CR>

"for changing the window
map ,w <C-w><C-w> 

"buffer switch
map gn :bnext<cr>
map gp :bprevious<cr>
map ggd :bdelete<cr>  
map <leader>n :bnext<cr>
map <leader>p :bprevious<cr>
" map <leader>d :bdelete<cr>

"Clear Buffer Except this
map cb :w <bar> %bd <bar> e# <bar> bd# <CR>

" Code Format
map <leader>f :Format<cr>




" Folding
map ff zf
map fo zo
map fc zc
map fa za




"for FZF
map ,s :FZF<CR>

"for clearing search
map ,cs :noh<CR>

"for error messages
map ,msg :messages <CR>

"for snippets
map ,us :UltiSnipsEdit<CR>

"maps the key in insert mode
"for Personalization
inoremap ,o <CR><CR><up><space><space><space> 

"for buffer management
nnoremap ,b :buffers<CR>:buffer <Space>

"for pasting the same thing again and again
xnoremap p "0p


""For darcula.vim 
"let g:solarized_termcolors=256
set background=dark
colorscheme darcula

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


"for gitgutter
set updatetime=50

"for snippets
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger=",<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Emoji shortcuts
ab :white_check_mark: ✅
ab :warning: ⚠️
ab :bulb: 💡
ab :pushpin: 📌
ab :bomb: 💣
ab :pill: 💊
ab :construction: 🚧
ab :pencil: 📝
ab :point_right: 👉
ab :thumb: 👍
ab :book: 📖
ab :link: 🔗
ab :wrench: 🔧
ab :info: 🛈
ab :telephone: 📞
ab :email: 📧
ab :computer: 💻
ab :sandclock: ⏳
ab :stopwatch: ⏱
ab :arrow_right: ➡️
ab :arrow_left: ⬅️
ab :arrow_up: ⬆️
ab :arrow_down: ⬇️
ab :arrow_sides: ↔️
ab :arrow_updown: ↕️
ab :arrow_upleft: ↖️
ab :arrow_upright: ↗️
ab :arrow_downleft: ↘️
ab :arrow_downright: ↙️
ab :arrow_returnup: ⤴️
ab :arrow_returndown: ⤵️
ab :arrow_returnright: ↪️
ab :arrow_returnleft: ↩️
ab :rose: 🌹
ab :sad: ☹️
ab :mad: 😤
ab :purpel_heart: 💜

"See invisible characters
"Setting background
highlight! Normal guifg=#BCBEC4 guibg=#1e1f22 ctermfg=145 ctermbg=235
