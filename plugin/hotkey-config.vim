"-----------------------------------------------------------------------------------------------------------------------------------------------
"Hotkey configurations
"-----------------------------------------------------------------------------------------------------------------------------------------------

"remap to jj to esc and to get into normal mode in terminal
imap jj <Esc>
imap JJ <Esc>
tnoremap jj <C-\><C-n>

" Specific to toggleterm plugin
nmap <silent><F4> :ToggleTerm direction=vertical size=75 hide=1<CR>
tnoremap <silent><F4> :ToggleTerm hide<CR>

"Toggle vertical and horizontal built-in terminal
" nmap <silent><F4> :split term://bash<CR>jj<C-w>L:vertical resize 60<CR>iclear<CR>
" tnoremap <silent><F4> <Esc><C-\><C-n>:bd!<CR>

" nmap <silent><F3> :split term://bash<CR>jj<C-w>J:resize 14<CR>iclear<CR>
" tnoremap <silent><F3> <Esc><C-\><C-n>:bd!<CR>

" Select all
nnoremap <C-a> ggVG

" Delete line 
nnoremap X Vx

" Register
nnoremap <silent><leader>R :registers<CR>

" Macros for adding, removing checklist, putting tick and removing it
" [ ] testing
let @a='^ca[jjx$' " Remove checkbox
let @b='^ jj$'    " Add checkbox
let @c='^ci[✓jj$' " Tick checkbox
let @d='^ci[ jj$' " Clear checkbox
let @e='^ci[!jj$' " Partially done
let @x='^ci[✕jj$' " Not done

" Buffer navigations
nnoremap <silent><leader>n :bn<cr>
nnoremap <silent><leader>p :bp<cr>
nnoremap <silent><leader>d :bd<cr>

"Disabled because it creates a 200ms delay due to ,d is reserved to delete buffer
" nnoremap <silent><leader>dd :bd!<cr> 

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
nnoremap ss :source %<CR>

"nvim-tree toggle
nnoremap <silent><leader>e :NvimTreeToggle<cr>

" opens a new tab
nnoremap <silent><leader>t :tabnew<cr>
nnoremap <silent><leader>v :vsp<cr>
nnoremap <silent><leader>S :sp<cr>

" Quickfix list: cnext, cprevious and copen
nmap <Down> :cnext<cr>
nmap <Up> :cprevious<cr>
nmap <left> :cclose<cr>
nmap <right> :copen<cr>

"Move texts around
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

"To move to a different window in terminal and terminal buffer
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Git Shortcuts
nnoremap <leader>gg  : Git<cr>
nnoremap <leader>ga  : Git add %<cr>
nnoremap <leader>gc  : Git commit<cr>
nnoremap <leader>gp  : Git push origin
nnoremap <leader>gl  : Gclog<cr>
nnoremap <leader>gd  : Git diff<cr>
nnoremap <leader>gdv : Gvdiffsplit<cr><A-l>
nnoremap <leader>gds : Gdiffsplit<cr><A-l>
nnoremap <leader>gdt : Git difftool<cr>
nnoremap <leader>gs  : Git status<cr>
nnoremap <leader>gm  : Git merge<cr>
nnoremap <leader>gmt : Git mergetool<cr>
nnoremap <leader>gd  : GDelete<cr>
nnoremap <leader>gb  : GBrowse<cr>

" Compilations hotkeys
" autocmd filetype python     map <F2> :w<CR>:vsplit term://python3 %<CR><C-w>L
" autocmd filetype cpp        map <F2> :w<CR>:vsplit term://g++ -std=c++14 % && ./a.out<CR><C-w>L
" autocmd filetype java       map <F2> :w<CR>:vsplit term://javac % && java %:r <CR><C-w>L
" autocmd filetype javascript map <F2> :w<CR>:vsplit term://node % <CR><C-w>L
" autocmd filetype kotlin     map <F2> :w<CR>:vsplit term://kotlinc % -include-runtime -d a.jar && java -jar a.jar<CR><C-w>L

" ToggleTerm
autocmd filetype java map       <F2> :w<CR>:2TermExec direction=float hide=1 cmd="javac % && java %:r"<CR>
autocmd filetype cpp map        <F2> :w<CR>:2TermExec direction=float hide=1 cmd="g++ -std=c++14 % && ./a.out"<CR>
autocmd filetype python map     <F2> :w<CR>:2TermExec direction=float hide=1 cmd="python3 %"<CR>
autocmd filetype javascript map <F2> :w<CR>:2TermExec direction=float hide=1 cmd="node %"<CR>
autocmd filetype kotlin map     <F2> :w<CR>:2TermExec direction=float hide=1 cmd="kotlinc % -include-runtime -d a.jar && java -jar a.jar"<CR>

" Todo plugin hotkey
nnoremap <leader>N :TodoQuickFix<CR>

" Easy align plugin
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
