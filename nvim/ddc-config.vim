"-------------------"
"-----DCC CONFIG----"
"-------------------"
" This is me trying to configure ddc.vim for autocompletion
" omnifunc screws some stuff
" nvim-lsp depreciated in favor of vim-lsp
" Example config options
"    \ 'sourceOptions' : {
"        \ 'nvim-lsp' : {
"            \ 'mark' : 'lsp',
"            \ 'forceCompletionPattern': '\.\w*|:\w*|->\w*',
"        \ },
"        \ 'omni' : {
"            \ 'mark' : 'omni',
"        \ },
"    \ 'sourceParams' : {
"        \ 'nvim-lsp': {'kindLabels': {'Class': 'c'}},
call ddc#custom#patch_global({
    \ 'sources'         : [
        \ 'around',
        \ 'ale',
        \ 'vim-lsp',
    \ ],
    \ 'sourceOptions' : {
        \ '_' : {
            \ 'matchers' : ['matcher_head'],
            \ 'sorters' : ['sorter_rank'],
        \ },
        \ 'around' : {'mark': 'Arn'},
        \ 'ale' : {
            \ 'mark' : 'ALE',
            \ 'cleanResultsWhitespace' : 'v:false',
        \ },
        \ 'vim-lsp' : {
            \ 'mark' : 'lsp',
        \ },
    \ },
    \ 'sourceParams' : {
        \ 'around': {'maxSize': 500},
        \ 'vim-lsp': {'ignoreCompleteProvider': 'v:true'},
    \ },
    \ 'completionMode' : 'popupmenu',
    \ 'completionMenu' : 'pum.vim',
    \ 'autoCompleteEvents' : [
        \ 'InsertEnter',
        \ 'TextChangedI',
        \ 'TextChangedP',
        \ 'CmdlineChanged',
    \ ],
    \ 'autoCompleteDelay' : 100,
\ })

"-----FILETYPES----"

" C and C++
call ddc#custom#patch_filetype(['c', 'cpp'], {
    \ 'sources' : [
        \ 'around',
        \ 'clangd',
    \ ],
    \ 'sourceOptions' : {
        \ 'clangd': {'mark': 'C'},
    \ },
\ })

" Markdown
call ddc#custom#patch_filetype(['markdown'], {
    \ 'sourceParams' : {
        \ 'around': {'maxSize': 100},
    \ },
\ })

" LaTeX
"call vimtex#init()
"call ddc#custom#patch_filetype(['tex'], {
"    \ 'sourceOptions' : {
"        \ 'omni': {'forceCompletionPattern': g:vimtex#re#deoplete},
"    \ },
"    \ 'sourceParams' : {
"        \ 'omni': {'omnifunc': 'vimtex#complete#omnifunc'},
"    \ },
"\ })

"-----COMMANDLINE-----"
" Command line completion functions
function! CommandlinePre() abort
    " Overwrite sources
    if !exists('b:prev_buffer_config')
        let b:prev_buffer_config = ddc#custom#get_buffer()
    endif
    call ddc#custom#patch_buffer('sources', ['necovim', 'around'])
    " Autoguards
    autocmd User           DDCCmdlineLeave ++once call CommandlinePost()
    autocmd InsertEnter    <buffer>        ++once call CommandlinePost()
    " Enable command line completion
    call ddc#enable_cmdline_completion()
    call ddc#enable()
endfunction
function! CommandlinePost() abort
    " Restore sources
    if exists('b:prev_buffer_config')
        call ddc#custom#set_buffer(b:prev_buffer_config)
        unlet b:prev_buffer_config
    else
        call ddc#custom#set_buffer({})
    endif
endfunction

" For command mode, can't get this to work
"cnoremap <Tab>      <Cmd>call pum#map#insert_relative(+1)<CR>
"cnoremap <S-Tab>    <Cmd>call pum#map#insert_relative(-1)<CR>
"cnoremap <C-n>      <Cmd>call pum#map#insert_relative(+1)<CR>
"cnoremap <C-p>      <Cmd>call pum#map#insert_relative(+1)<CR>
"cnoremap <C-y>      <Cmd>call pum#map#confirm()<CR>
"cnoremap <C-e>      <Cmd>call pum#map#cancel()<CR>
"nnoremap :          <Cmd>call CommandlinePre()<CR>:
"nnoremap ;; :

"-----TOGGLES-----"
" Enable ddc for commandline
"call ddc#enable_cmdline_completion()
" Use ddc.
call ddc#enable()
