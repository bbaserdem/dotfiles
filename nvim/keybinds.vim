"------------------"
"-----Keybinds-----"
"------------------"

" Leader key
let mapleader="\<Space>"

" Search and replace
nmap <leader>s :%s///g<Left><Left><Left>

" Clear search highlight
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Disable EX mode
nnoremap Q <nop>

" Navigate splits easier
nnoremap <leader>j <C-w><C-j>
nnoremap <leader>k <C-w><C-k>
nnoremap <leader>l <C-w><C-l>
nnoremap <leader>h <C-w><C-h>

" Copy paste functionality with the clipboard
noremap <C-c> "+y
noremap <C-v> "+p

" Fzf File finder when pressing space+f
nnoremap <silent> <Leader>f :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>

" NERDTree; with leader n
map <Leader>n :NERDTreeToggle<CR>

" Gitgutter; with leader g
nmap <Leader>gq :GitGutterBufferToggle<CR>
nmap <Leader>g/ :GitGutterLineNrHighlightsToggle<CR>
nmap <Leader>gj <Plug>(GitGutterNextHunk)
nmap <Leader>gk <Plug>(GitGutterPrevHunk)
nmap <Leader>gd <Plug>(GitGutterFold)
nmap <Leader>gs <Plug>(GitGutterStageHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap <Leader>gp <Plug>(GitGutterPreviewHunk)

" Ale; with leader a
nmap <silent> <Leader>aj <Plug>(ale_previous_wrap)
nmap <silent> <Leader>ak <Plug>(ale_next_wrap)

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

" Vimtex; with leader v
nmap <Leader>vl <Plug>(vimtex-compile)
nmap <Leader>ve <Plug>(vimtex-errors)
nmap <Leader>vq <Plug>(vimtex-stop-all)
nmap <Leader>vh <Plug>(vimtex-info)
nmap <Leader>vH <Plug>(vimtex-info-full)

" Deoplete
inoremap <expr><tab>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"

" Ultisnips
let g:UltiSnipsExpandTrigger = '<c-Space>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-h>'
