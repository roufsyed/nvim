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
