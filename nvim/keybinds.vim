"------------------"
"-----Keybinds-----"
"------------------"
" Disable EX mode
nnoremap Q <nop>

"-----LEADER-----"
" Leader key
let mapleader="\<Space>"

"---CONVENIENCE---"
" Search and replace
nnoremap <leader>s :%s///g<Left><Left><Left>
" Reload config
nnoremap <leader>r :source $MYVIMRC<CR>
" Clear search highlight
nnoremap <silent> <leader>/ :nohlsearch<CR>
" Copy paste functionality with the clipboard
vnoremap <C-c> "+y
vnoremap <C-v> "+p
nnoremap <C-v> "+p

"===BUFFERS, WINDOWS & TABS==="
"---Navigation---"
" Window navigation
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>h :wincmd h<CR>
" Buffers
nnoremap <leader>L :bnext<CR>
nnoremap <leader>H :bprev<CR>
" Tabs
nnoremap <leader>J :tabnext<CR>
nnoremap <leader>K :tabprev<CR>
"---Seeking---" (this mostly uses fzf to seek open files or windows)
" List buffers to navigate current window to them
nnoremap <Leader><Tab> :Telescope buffers<CR>
"---Closing---"
" Close this buffer
nnoremap <Leader>q :Bdelete<CR>
" Close this window
nnoremap <leader>d :close<CR>
" Close this tab
nnoremap <leader>D :tabclose<CR>
"---Opening---"
" Use fuzzy finder to open new buffer
nnoremap <Leader>o :Telescope find_files<CR>
" Open new empty buffer
nnoremap <Leader>n :new<CR>
" Open new windows
nnoremap <leader>- :split<CR>
nnoremap <leader>_ :vsplit<CR>
" Open new tab
nnoremap <leader>O :tabnew<CR>

"===PLUGINS==="
" File-type specific ones are all mapped to function keys

"---Tab completion : INSERT---" ddc.vim and pum.vim
inoremap <silent><expr> <Tab>       ddc#map#pum_visible()
    \ ? pum#map#insert_relative(+1)
    \ : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s')
        \ ? '<Tab>'
        \ : ddc#map#manual_complete()
inoremap <silent><expr> <S-Tab>     ddc#map#pum_visible()
    \ ? pum#map#insert_relative(-1)
    \ : '<C-h>'
inoremap <silent><expr> <C-n>       ddc#map#pum_visible()
    \ ? pum#map#insert_relative(+1)
    \ : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s')
        \ ? '<C-n>'
        \ : ddc#map#manual_complete()
inoremap <silent><expr> <C-p>       ddc#map#pum_visible()
    \ ? pum#map#insert_relative(-1)
    \ : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s')
        \ ? '<C-p>'
        \ : ddc#map#manual_complete()
inoremap <silent><expr> <C-y>       ddc#map#pum_visible()
    \ ? pum#map#confirm()
    \ : '<C-y>'
inoremap <silent><expr> <C-e>       ddc#map#pum_visible()
    \ ? pum#map#cancel()
    \ : '<C-e>'
inoremap <silent><expr> <PageDown>  ddc#map#pum_visible()
    \ ? pum#map#insert_relative_page(+1)
    \ : '<PageDown>'
inoremap <silent><expr> <PageUp>    ddc#map#pum_visible()
    \ ? pum#map#insert_relative_page(-1)
    \ : '<PageUp>'
"---Tab completion : COMMAND---" ddc.vim and pum.vim
"cnoremap <Tab>      <Cmd>call pum#map#insert_relative(+1)<CR>
"cnoremap <S-Tab>    <Cmd>call pum#map#insert_relative(-1)<CR>
"cnoremap <C-n>      <Cmd>call pum#map#insert_relative(+1)<CR>
"cnoremap <C-p>      <Cmd>call pum#map#insert_relative(+1)<CR>
"cnoremap <C-y>      <Cmd>call pum#map#confirm()<CR>
"cnoremap <C-e>      <Cmd>call pum#map#cancel()<CR>
"nnoremap :          <Cmd>call CommandlinePre()<CR>:
" Debugging; use this for non-pum commands
"nnoremap ;; :

"---Tab completion---" ddc.vim and pum.vim
"
" Ultisnips (FUNDAMENTAL)
let g:UltiSnipsExpandTrigger = '<c-Space>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-h>'
nnoremap <C-j> :FzfSnippets<CR>

" NERDTree
nnoremap <F3> :NvimTreeToggle<CR>

" Ale
nnoremap <silent> <Leader>[ <Plug>(ale_previous_wrap)
nnoremap <silent> <Leader>] <Plug>(ale_next_wrap)

" Fzf
nnoremap <silent> <Leader>p :FzfBLines<CR>
nnoremap <silent> <Leader>P :FzfLines<CR>
nnoremap <silent> <Leader>c :FzfAg<space>
nnoremap <silent> <Leader>g :FzfRg<space>
nnoremap <silent> <Leader>m :FzfMarks<CR>

" Gitgutter; with leader-g
nnoremap <silent> <Leader>gl :FzfGfiles<CR>
nnoremap <silent> <Leader>gL :FzfGfiles?<CR>
nnoremap <Leader>gt :GitGutterBufferToggle<CR>
nnoremap <Leader>Gt :GitGutterToggle<CR>
nnoremap <Leader>g/ :GitGutterLineNrHighlightsToggle<CR>
nnoremap <Leader>G/ :GitGutterLineHighlightsToggle<CR>
nnoremap <Leader>gv :GitGutterSignsToggle<CR>
nnoremap <Leader>gw :GitGutterStageHunk<CR>
nnoremap <Leader>gW :GitGutterPreviewHunk<CR>
nnoremap <Leader>gd :GitGutterUndoHunk<CR>
nnoremap <Leader>g- :GitGutterFold<CR>
nnoremap <Leader>gj :GitGutterNextHunk<CR>
nnoremap <Leader>gk :GitGutterPrevHunk<CR>

" Vimgrammarous
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
endfunction
function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
endfunction
