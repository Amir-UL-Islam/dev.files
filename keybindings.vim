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
