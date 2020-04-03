"------------------"
"-----Keybinds-----"
"------------------"

" Leader key
let mapleader="\<Space>"

" Search and replace
nmap <leader>s :%s///g<Left><Left><Left>

" Clear search highlight
nnoremap <silent> <leader>/ :nohlsearch<CR>

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

" NERDTree
map <Leader>n :NERDTreeToggle<CR>

" Gitgutter
nmap <Leader>gq :GitGutterBufferToggle<CR>
nmap <Leader>g/ :GitGutterLineNrHighlightsToggle<CR>
nmap <Leader>gn <Plug>(GitGutterNextHunk)
nmap <Leader>gN <Plug>(GitGutterPrevHunk)
nmap <Leader>gs <Plug>(GitGutterStageHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap <Leader>gp <Plug>(GitGutterPreviewHunk)
nmap <Leader>gG <Plug>(GitGutterFold)
