" Make function keys to be vimtex commands
" Help
nnoremap <F2>   :help vimtex<CR>
" Clean
nnoremap <F4>   :VimtexClean<CR>
" Build (ctrl for one-shot, shift for doing selection)
nnoremap <F5>   :VimtexCompile<CR>
vnoremap <F5>   :VimtexCompileSelected<CR>
nnoremap <F29>  :VimtexCompileSS<CR>
" Open file
nnoremap <F6>   :VimtexView<CR>
" Build log
nnoremap <F7>   :VimtexLog<CR>
" Error logs
nnoremap <F8>   :VimtexErrors<CR>
" Query the used package
nnoremap <F9>   :VimtexDocPackage<CR>
