" -----------------------------------------------------------------
" Sensibles
" -----------------------------------------------------------------
autocmd FileType netrw setlocal signcolumn=no  " Disable signcolumn in netrw
" Hide top banner
let g:netrw_banner = 0 

autocmd FileType netrw setlocal signcolumn=no  " Disable signcolumn in netrw

" Tree style
let g:netrw_liststyle = 3 

" when browsing, <cr> will open the file by:
" =0: re-using the same window  (default)
" =1: horizontally splitting the window first
" =2: vertically   splitting the window first
" =3: open file in new tab
" =4: act like "P" (ie. open previous window)
"     Note that |g:netrw_preview| may be used
"     to get vertical splitting instead of
"     horizontal splitting.
" =[servername,tab-number,window-number]
"     Given a |List| such as this, a remote server
"     named by the "servername" will be used for
"     editing.  It will also use the specified tab
let g:netrw_browse_split = 0 "open file in what split

" Netrw preview
let g:netrw_preview = 1

" -----------------------------------------------------------------
" Movements
" -----------------------------------------------------------------
" l to enter
nmap <buffer> l <CR>

" h to go back
nmap <buffer> h -^

" -----------------------------------------------------------------
" Sensibles
" -----------------------------------------------------------------
" hidden files
nmap <buffer> . gh

" previous buffer
nmap <buffer> P <C-w>z

" mark file
nmap <buffer> <TAB> mf

" remove mark
nmap <buffer> <S-TAB> mF

" remove all marks
nmap <buffer> <Leader><TAB> mu

" create a empty file
nmap <buffer> ff %:w<CR>:buffer #<CR>

" edit file name
nmap <buffer> fe R

" Copy marked file
nmap <buffer> fc mc

" We will use this to "skip" a step. After you mark your files you can put
" the cursor in a directory and this will assign the target directory and
" copy in one step.
nmap <buffer> fC mtmc

" move marked file
nmap <buffer> fx mm

"skip target and move just like fC
nmap <buffer> fX mtmm

" run external commands on marked files
nmap <buffer> f; mx

" list marked files
nmap <buffer> fl :echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>

" list target directory
nmap <buffer> fq :echo 'Target:' . netrw#Expose("netrwmftgt")<CR>

nmap <buffer> fd mtfq

" bookmark
nmap <buffer> bb mb

" delete recent bookmark
nmap <buffer> bd mB

" jump to recent bookmark
nmap <buffer> bl gb

" Recursive delete function
function! NetrwRemoveRecursive()
  if &filetype ==# 'netrw'
    cnoremap <buffer> <CR> rm -r<CR>
    normal mu
    normal mf
    
    try
      normal mx
    catch
      echo "Canceled"
    endtry

    cunmap <buffer> <CR>
  endif
endfunction

" Delete a folder
nmap <buffer> FF :call NetrwRemoveRecursive()<CR>
