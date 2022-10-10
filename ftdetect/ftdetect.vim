" For generating basic skeleton
autocmd BufNewFile *.cpp r ~/.config/nvim/templates/skeleton.cpp
autocmd BufNewFile *.java r ~/.config/nvim/templates/skeleton.java

" explicit filetype detect
autocmd BufReadPost *.js setlocal filetype=javascript
autocmd BufReadPost *.kt setlocal filetype=kotlin
