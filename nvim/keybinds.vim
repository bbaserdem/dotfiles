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

" Deoplete
inoremap <expr><tab>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-Space>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" Vim-Matlab
nnoremap <buffer>         <leader>rn :MatlabRename
nnoremap <buffer><silent> <leader>fn :MatlabFixName<CR>
vnoremap <buffer><silent> <C-m> <ESC>:MatlabCliRunSelection<CR>
nnoremap <buffer><silent> <C-m> <ESC>:MatlabCliRunCell<CR>
nnoremap <buffer><silent> <C-h> :MatlabCliRunLine<CR>
nnoremap <buffer><silent> ,i <ESC>:MatlabCliViewVarUnderCursor<CR>
vnoremap <buffer><silent> ,i <ESC>:MatlabCliViewSelectedVar<CR>
nnoremap <buffer><silent> ,h <ESC>:MatlabCliHelp<CR>
nnoremap <buffer><silent> ,e <ESC>:MatlabCliOpenInMatlabEditor<CR>
nnoremap <buffer><silent> <leader>c :MatlabCliCancel<CR>
nnoremap <buffer><silent> <C-l> :MatlabNormalModeCreateCell<CR>
vnoremap <buffer><silent> <C-l> :<C-u>MatlabVisualModeCreateCell<CR>
inoremap <buffer><silent> <C-l> <C-o>:MatlabInsertModeCreateCell<CR>

" Vimtex
nmap <Leader>vl <Plug>(vimtex-compile)
nmap <Leader>ve <Plug>(vimtex-errors)
nmap <Leader>vq <Plug>(vimtex-stop-all)
nmap <Leader>vh <Plug>(vimtex-info)
nmap <Leader>vH <Plug>(vimtex-info-full)
