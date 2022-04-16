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
nnoremap <C-v> "+p

"===BUFFERS, WINDOWS & TABS==="
"---Navigation---"
" Windows
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
nnoremap <Leader><Tab> :FzfBuffers<CR>
" List windows to navigate to them
nnoremap <leader><S-Tab> :FzfWindows<CR>
"---Closing---"
" Close this buffer
nnoremap <Leader>q :bd<CR>
" Close this window
nnoremap <leader>d :close<CR>
" Close this tab
nnoremap <leader>D :tabclose<CR>
"---Opening---"
" Use fuzzy finder to open new buffer
nnoremap <Leader>o :FzfFiles<CR>
" Open new empty buffer
nnoremap <Leader>n :new<CR>
" Open new windows
nnoremap <leader>- :split<CR>
nnoremap <leader>_ :vsplit<CR>
" Open new tab
nnoremap <leader>O :tabnew<CR>

"===PLUGINS==="
" File-type specific ones are all mapped to function keys

"---Tab completion---" ddc.vim
" For insert mode, shift-tab moves through completion in the back order
inoremap <silent><expr> <Tab> ddc#map#pum_visible() ?
    \ '<C-n>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
        \ '<Tab>' :
        \ ddc#map#manual_complete()
inoremap <expr> <S-Tab> ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

" Ultisnips (FUNDAMENTAL)
let g:UltiSnipsExpandTrigger = '<c-Space>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-h>'
nnoremap <C-j> :FzfSnippets<CR>

" NERDTree
map <Leader>t :NERDTreeToggle<CR>

" Ale
nmap <silent> <Leader>[ <Plug>(ale_previous_wrap)
nmap <silent> <Leader>] <Plug>(ale_next_wrap)

" Fzf
nnoremap <silent> <Leader>p :FzfBLines<CR>
nnoremap <silent> <Leader>P :FzfLines<CR>
nnoremap <silent> <Leader>c :FzfAg<space>
nnoremap <silent> <Leader>g :FzfRg<space>
nnoremap <silent> <Leader>m :FzfMarks<CR>

" Gitgutter; with leader-g
nnoremap <silent> <Leader>gl :FzfGfiles<CR>
nnoremap <silent> <Leader>gL :FzfGfiles?<CR>
nmap <Leader>gt <Plug>(GitGutterBufferToggle)
nmap <Leader>Gt <Plug>(GitGutterToggle)
nmap <Leader>g/ <Plug>(GitGutterLineNrHighlightsToggle)
nmap <Leader>G/ <Plug>(GitGutterLineHighlightsToggle)
nmap <Leader>gv <Plug>(GitGutterSignsToggle)
nmap <Leader>gw <Plug>(GitGutterStageHunk)
nmap <Leader>gW <Plug>(GitGutterPreviewHunk)
nmap <Leader>gd <Plug>(GitGutterUndoHunk)
nmap <Leader>g- <Plug>(GitGutterFold)
nmap <Leader>gj <Plug>(GitGutterNextHunk)
nmap <Leader>gk <Plug>(GitGutterPrevHunk)

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
