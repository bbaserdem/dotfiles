"-----------------"
"-----PLUGINS-----"
"-----------------"
scriptencoding utf-8

"------------"
"---CONFIG---"
"------------"

"---VS Code---"
let g:vscode_style = 'dark'
let g:vscode_transparency = 1
let g:vscode_italic_comment = 1
let g:vscode_disable_nvimtree_bg = v:true

"---Markdown Preview---"
let g:nvim_markdown_preview_theme = 'solarized-dark'
let g:nvim_markdown_preview_format = 'gfm'

"---Mkdnflow.nvim---"
augroup MkdnflowWriteMarkdown
    autocmd!
    autocmd FileType markdown set autowriteall
augroup end

"---echodoc.vim---"
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
highlight link EchoDocFloat Identifier

"---Vimtex---"
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_progname = 'nvr'          " For callback functionality
let g:tex_flavor = 'latex'                      " No plaintex
"let g:vimtex_complete_enabled = 1              " Enable omnifunc
