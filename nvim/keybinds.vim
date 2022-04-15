"------------------"
"-----Keybinds-----"
"------------------"

"-----LEADER-----"
" For plugins; a f g v t are taken
" Leader key
let mapleader="\<Space>"

" Search and replace
nmap <leader>s :%s///g<Left><Left><Left>
" Reload config
nnoremap <leader>r :source $MYVIMRC<CR>
" Clear search highlight
nnoremap <silent> <leader>/ :nohlsearch<CR>
" Disable EX mode
nnoremap Q <nop>
" Copy paste functionality with the clipboard
vnoremap <C-c> "+y
nnoremap <C-v> "+p

"-----NAVIGATION-----"
" Navigation uses fzf to a degree
"===BUFFERS===(Ctrl)
" Navigate buffers
nnoremap <leader><C-j> :bnext<CR>
nnoremap <leader><C-k> :bprev<CR>
" List buffers
nnoremap <Leader><C-l> :FzfBuffers<CR>
" Use fuzzy finder to open new buffer
nnoremap <Leader><C-o> :FzfFiles<CR>
" Open new empty buffer
nnoremap <Leader><C-n> :new<CR>
" Close this buffer
nnoremap <Leader><C-q> :bd<CR>
"===WINDOWS===(-N/A-)
" Navigate windows
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>h :wincmd h<CR>
" Open new split windows
nnoremap <leader>n :split<CR>
nnoremap <leader>N :vsplit<CR>
" Search windows
nnoremap <leader>o :FzfWindows<CR>
" Close window
nnoremap <leader>q :close<CR>
"===TABS===(Shift)
" Navigate tabs using leader and shifted up/down
nnoremap <leader>J :tabnext<CR>
nnoremap <leader>K :tabprev<CR>
" Open/close new tabs
nnoremap <leader>O :tabnew<CR>
nnoremap <leader>Q :tabclose<CR>

"-----PLUGINS-----"
" Most plugins are accessed through leader key and their first letter
" Except autocomplete; these are built in for easier access

" Deoplete (FUNDAMENTAL)
inoremap <expr><tab>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"

" Ultisnips (FUNDAMENTAL)
let g:UltiSnipsExpandTrigger = '<c-Space>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-h>'
nnoremap <C-j> :FzfSnippets<CR>

" Ale; with leader-a
nmap <silent> <Leader>aj <Plug>(ale_previous_wrap)
nmap <silent> <Leader>ak <Plug>(ale_next_wrap)

" Fzf; with leader-f
nnoremap <silent> <Leader>f/ :FzfBLines<CR>
nnoremap <silent> <Leader>f\ :FzfLines<CR>
nnoremap <silent> <Leader>fc :FzfAg<space>
nnoremap <silent> <Leader>fw :FzfRg<space>
nnoremap <silent> <Leader>fm :FzfMarks<CR>
nnoremap <silent> <Leader>fg :FzfGfiles<CR>
nnoremap <silent> <Leader>fG :FzfGfiles?<CR>

" Gitgutter; with leader-g
nmap <Leader>gq <Plug>(GitGutterBufferToggle)
nmap <Leader>g/ <Plug>(GitGutterLineNrHighlightsToggle)
nmap <Leader>gj <Plug>(GitGutterNextHunk)
nmap <Leader>gk <Plug>(GitGutterPrevHunk)
nmap <Leader>gd <Plug>(GitGutterFold)
nmap <Leader>gs <Plug>(GitGutterStageHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap <Leader>gp <Plug>(GitGutterPreviewHunk)

" NERDTree; with t
map <Leader>tt :NERDTreeToggle<CR>

" Vimtex; with leader v
nmap <Leader>vl <Plug>(vimtex-compile)
nmap <Leader>ve <Plug>(vimtex-errors)
nmap <Leader>vq <Plug>(vimtex-stop-all)
nmap <Leader>vh <Plug>(vimtex-info)
nmap <Leader>vH <Plug>(vimtex-info-full)

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
