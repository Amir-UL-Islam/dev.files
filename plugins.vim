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

" Markdown rendering plugin
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'Amir-UL-Islam/darcula-vim-jetbrain'
call plug#end()

lua << EOF
-- Check if treesitter is installed before configuring
local ts_status, ts = pcall(require, "nvim-treesitter.configs")
if ts_status then
    ts.setup({
        ensure_installed = { "markdown", "markdown_inline" },
        highlight = { enable = true },
    })
end

-- Check if render-markdown is installed before configuring
local rm_status, rm = pcall(require, "render-markdown")
if rm_status then
    rm.setup({})
end
EOF


" CoC extensions to install automatically
let g:coc_global_extensions = [
    \ 'coc-clangd',
    \ 'coc-go',
    \ 'coc-java',
    \ 'coc-json',
    \ 'coc-pyright',
    \ 'coc-sh',
    \ 'coc-tsserver',
    \ 'coc-yaml',
    \ 'coc-python',
    \ 'coc-highlight',
    \ 'coc-sql',
    \ 'coc-metals',
    \ ]
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

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Use a line cursor within insert mode and a block cursor everywhere else.
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).

"
":RainbowParenthesesToggle       " Toggle it on/off
":RainbowParenthesesLoadRound    " (), the default when toggling
":RainbowParenthesesLoadSquare   " []
":RainbowParenthesesLoadBraces   " {}
":RainbowParenthesesLoadChevrons " <>

"languageTool
"Not using Any More
"If I need to Use this Plug, I have to add this version of file at $HOME
"location
"let g:languagetool_jar='$HOME/LanguageTool-5.2/languagetool-commandline.jar'
