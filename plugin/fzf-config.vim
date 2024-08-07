"FZF config
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --preview="bat --theme={ansi} --color always --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow'.shellescape(<q-args>), 1, <bang>0)

set timeoutlen=500 "Set timeout length to 500 ms

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" /* " Command	List */
" /* " :Files [PATH]	Files (runs $FZF_DEFAULT_COMMAND if defined) */
" /* " :GFiles [OPTS]	Git files (git ls-files) */
" /* " :GFiles?	Git files (git status) */
" /* " :Buffers	Open buffers */
" /* " :Colors	Color schemes */
" /* " :Ag [PATTERN]	ag search result (ALT-A to select all, ALT-D to deselect all) */
" /* " :Rg [PATTERN]	rg search result (ALT-A to select all, ALT-D to deselect all) */
" /* " :Lines [QUERY]	Lines in loaded buffers */
" /* " :BLines [QUERY]	Lines in the current buffer */
" /* " :Tags [QUERY]	Tags in the project (ctags -R) */
" /* " :BTags [QUERY]	Tags in the current buffer */
" /* " :Marks	Marks */
" /* " :Windows	Windows */
" /* " :Locate PATTERN	locate command output */
" /* " :History	v:oldfiles and open buffers */
" /* " :History:	Command history */
" /* " :History/	Search history */
" /* " :Snippets	Snippets (UltiSnips) */
" /* " :Commits	Git commits (requires fugitive.vim) */
" /* " :BCommits	Git commits for the current buffer; visual-select lines to track changes in the range */
" /* " :Commands	Commands */
" /* " :Maps	Normal mode mappings */
" /* " :Helptags	Help tags 1 */
" /* " :Filetypes	File types */

nnoremap <leader>f :Files<cr>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>b :Windows<cr>
nnoremap <leader><S-b> :Buffers<cr>
nnoremap <leader>s :BLines<cr>
nnoremap <leader>l :Lines<cr>
nnoremap <leader>m :Marks<cr>
nnoremap <leader>M :Maps<cr>
