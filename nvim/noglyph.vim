" Settings for non-glyph setup

" Airline;
let g:airline_theme = 'term'
let g:airline_powerline_fonts = 0

" Indentline
let g:indentLine_char = '|'

" GitGutter
let g:gitgutter_sign_added = 'xx'
let g:gitgutter_sign_modified = 'yy'
let g:gitgutter_sign_removed = 'zz'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = 'ww'

" ddc.vim
call ddc#custom#patch_global('sourceOptions', {
    \ 'around'      : {'mark' : 'Arn'},
    \ 'nvim-lsp'    : {'mark' : 'LSP'},
    \ 'omni'        : {'mark' : 'Omn'},
\ })

" Ale
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_echo_msg_format = '%linter% says %s'
