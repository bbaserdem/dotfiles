" Make function keys to be vimtex commands
" Help
nnoremap <F2> <Plug>(vimtex-context-menu)
" Log
nnoremap <F3> <Plug>(vimtex-doc-package)
" Clean
nnoremap <F4> <Plug>(vimtex-clean)
" Build (ctrl for one-shot, shift for doing selection)
nnoremap <F5> <Plug>(vimtex-compile)
nnoremap <F29> <Plug>(vimtex-compile-ss)
vnoremap <F17> <Plug>(vimtex-compile-selected)
" Open file
nnoremap <F7> <Plug>(vimtex-view)
" Error logs
nnoremap <F9> <Plug>(vimtex-errors)
