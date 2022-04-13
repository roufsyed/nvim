"-----------------------------------------------------------------------------------------------------------------------------------------------
"Hotkey configurations
"-----------------------------------------------------------------------------------------------------------------------------------------------

"remap to jj to esc and to get into normal mode in terminal
imap jj <Esc>
tnoremap jj <C-\><C-n>

"remap semicolon to colon for normal mode
" nnoremap ; :

"Toggle for vertical and horizontal terminal
nmap <silent><F4> :split term://bash<CR><C-w>L:vertical resize 60<CR>i
tnoremap <silent><F4> <Esc><C-\><C-n>:bd!<CR>
nmap <silent><F3> :split term://bash<CR><C-w>J:resize 10<CR>i
tnoremap <silent><F3> <Esc><C-\><C-n>:bd!<CR>

"copy, paste, select all and delete current line
map <C-c> "+y
map <C-v> "+p
nnoremap <C-a> ggVG

"Delete entire line
nnoremap <silent>X Vx 
"Copy entire line
nnoremap <silent>Y Vy 

nnoremap <silent><leader>n :bn<cr>
nnoremap <silent><leader>p :bp<cr>
nnoremap <silent><leader>d :bd<cr>
" nnoremap <silent><leader>dd :bd!<cr> "Disabled because it creates a 200ms delay

"save and quit
nnoremap <leader>w :update<CR>
nnoremap <leader>q :q<CR>

"Search and replace
" c : confirm before deleting
" g : global edit
nnoremap <leader>sr :%s/<C-r>+//gc

"to open init and source
function! Init()
    cd ~/.config/nvim/
    :e init.vim
endfunction

nnoremap <silent><F8> :call Init()<cr>
nnoremap ss :source %<cr>

"opens netrw in right vsplit
nnoremap <leader>e :Explore<cr>
nnoremap <leader>v :Vexplore!<cr>
nnoremap <leader>t :Texplore<cr>

"Resize window
nnoremap <silent><leader>- :vertical resize -5<CR>
nnoremap <silent><leader>= :vertical resize +5<CR>
nnoremap <silent><leader>0 :vertical resize 100<CR>

"cnext, cprevios and copen
nmap <C-[> :cnext<cr>
nmap <C-]> :cprev<cr>
nmap <C-q> :copen<cr>

"Move texts around
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
inoremap <C-j> <esc>:m .+1<CR>i
inoremap <C-k> <esc>:m .-2<CR>i

"To move to a different window
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"To move windows around
nnoremap <A-k> <C-w>K
nnoremap <A-j> <C-w>J
nnoremap <A-h> <C-w>H
nnoremap <A-l> <C-w>L

" Git Shortcuts
nnoremap <leader>ga :Git add %<cr>
nnoremap <leader>gc :Git commit<cr>
nnoremap <leader>gp :Git push origin 
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>gd :Git diff<cr>
nnoremap <leader>gdt :Git difftool<cr>
nnoremap <leader>gs :Git status<cr>
nnoremap <leader>gm :Git merge<cr>
nnoremap <leader>gmt :git mergetool<cr>

" Compilations hotkeys
autocmd filetype python map <F2> :w<CR>:vsplit term://python3 %<CR><C-w>L
autocmd filetype cpp map <F2> :w<CR>:vsplit term://g++ -std=c++14 % && ./a.out<CR><C-w>L
autocmd filetype java map <F2> :w<CR>:vsplit term://javac % && java %:r <CR><C-w>L

autocmd BufReadPost *.js setlocal filetype=javascript "vim was not recognizing javascript file by default so had to explicitly define it.
autocmd filetype javascript map <F2> :w<CR>:vsplit term://node % <CR><C-w>L

autocmd BufReadPost *.kt setlocal filetype=kotlin "vim was not recognizing kotlin file by default so had to explicitly define it.
autocmd filetype kotlin map <F2> :w<CR>:vsplit term://kotlinc % -include-runtime -d a.jar && java -jar a.jar<CR><C-w>L

"THE CODE BELOW IS NOT OPTIMIZED FOR NVIM, IT ONLY WORKS FOR VIM
"Specific to /home/cp.cpp for competitive programming. n"
"Note: does not work without a file type. tried $
" function! CP()
" 	:w
" 	:bel vert term
" 	:vertical resize 60
" endfunction 
" autocmd filetype cpp map <F12> :call CP()<CR>clear && g++ -std=c++14 cp.cpp && ./a.out <input.txt<CR>
" autocmd filetype cpp map <F10> :call CP()<CR>clear && g++ -std=c++14 asd.cpp && ./a.out<CR>

