" Settings for unique glyph setup
scriptencoding utf-8

" Airline;
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16'

" Indentline;
let g:indentLine_char_list = ['▏', '│', '¦', '┆', '┊']

" Gitgutter;
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

" ddc.vim
call ddc#custom#patch_global('sourceOptions', {
    \ 'around'      : {'mark' : ''},
    \ 'nvim-lsp'    : {'mark' : ''},
    \ 'omni'        : {'mark' : ''},
\ })

" Null-ls
"lua defaults["diagnostics_format"] = "[#{c}] #{m} (#{s})"

" Ale;
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_echo_msg_format = '﫢%linter%  %s'
let g:ale_virtualtext_prefix = ' '
