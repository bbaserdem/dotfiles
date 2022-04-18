"-------------------"
"-----DCC CONFIG----"
"-------------------"
" This is me trying to configure ddc.vim for autocompletion
call ddc#custom#patch_global({
    \ 'sources'         : [
        \ 'around',
        \ 'nvim-lsp',
        \ 'omni',
    \ ],
    \ 'sourceOptions' : {
        \ '_' : {
            \ 'matchers' : ['matcher_head'],
            \ 'sorters' : ['sorter_rank'],
        \ },
        \ 'nvim-lsp' : {'forceCompletionPattern': '\.\w*|:\w*|->\w*'},
    \ },
    \ 'sourceParams' : {
        \ 'around': {'maxSize': 500},
        \ 'nvim-lsp': {'kindLabels': {'Class': 'c'}},
    \ },
    \ 'completionMenu' : 'pum.vim',
    \ 'completionMode' : 'popupmenu',
    \ 'autoCompleteEvents' : [
        \ 'InsertEnter',
        \ 'TextChangedI',
        \ 'TextChangedP',
        \ 'CmdlineChanged',
    \ ],
    \ 'autoCompleteDelay' : 100,
\ })

"---TAB COMPLETION---"

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
call vimtex#init()
call ddc#custom#patch_filetype(['tex'], {
    \ 'sourceOptions' : {
        \ 'omni': {'forceCompletionPattern': g:vimtex#re#deoplete},
    \ },
    \ 'sourceParams' : {
        \ 'omni': {'omnifunc': 'vimtex#complete#omnifunc'},
    \ },
\ })

"-----COMMANDLINE-----"
" Command line completion functions
function! CommandlinePre() abort
    " Overwrite sources
    if !exists('b:prev_buffer_config')
        let b:prev_buffer_config = ddc#custom#get_buffer()
    endif
    call ddc#custom#patch_buffer('sources', ['necovim', 'around'])
    " Autoguards
    augroup pomPostGuardUser
        autocmd!
        autocmd User           DDCCmdlineLeave ++once call CommandlinePost()
    augroup end
    augroup pomPostGuardInsert
        autocmd!
        autocmd InsertEnter    <buffer>        ++once call CommandlinePost()
    augroup end
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

"-----TOGGLES-----"
" Enable ddc for commandline
"call ddc#enable_cmdline_completion()
" Use ddc.
call ddc#enable()
