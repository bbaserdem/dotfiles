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
nnoremap <Leader>d :Bdelete<CR>
" Close this window
nnoremap <leader>q :close<CR>
" Close this tab
nnoremap <leader>Q :tabclose<CR>
"---Opening---"
" Use fuzzy finder to open new buffer
nnoremap <Leader>o :Telescope find_files<CR>
" Open new empty buffer
nnoremap <Leader>O :new<CR>
" Open new tab
nnoremap <leader>n :tabnew<CR>
" Open new windows
nnoremap <leader>, :split<CR>
nnoremap <leader>. :vsplit<CR>

" LSP functions
nnoremap <leader>c :vim.lsp.buf.clear_references()<CR>
nnoremap <leader>r :vim.lsp.buf.code_action()<CR>
nnoremap <leader>w :vim.lsp.buf.declaration()<CR>
nnoremap <leader>? :vim.lsp.buf.definition()<CR>
nnoremap <leader>f :vim.lsp.buf.document_symbol()<CR>
nnoremap <leader>' :vim.lsp.buf.hover()<CR>
nnoremap <leader>i :vim.lsp.buf.references()<CR>
nnoremap <leader>I :vim.lsp.buf.declaration()<CR>
nnoremap <leader>u :vim.lsp.buf.incoming_calls()<CR>
nnoremap <leader>U :vim.lsp.buf.outgoing_calls()<CR>
nnoremap <leader>a :vim.lsp.buf.signature_help()<CR>
nnoremap <leader>A :vim.lsp.buf.type_definition()<CR>
nnoremap <leader><Enter> :vim.lsp.buf.rename()<CR>

" Function keys (1 is default help)

" 2: Documentation
nnoremap <F2>   :TroubleToggle lsp_definitions<CR>
nnoremap <S-F2> :TroubleToggle lsp_references<CR>
nnoremap <C-F2> :TroubleToggle lsp_type_definitions<CR>

" 3: File browser
nnoremap <F3> :NvimTreeToggle<CR>

" 4: ???

" 5: Build (this is individual to file-type)

" 6: Preview (this is individual to file-type)

" 7: Server log (this can be overwritten)
nnoremap <F7> :LspInfo<CR>

" 8: Errors
nnoremap <F8>   :TroubleToggle document_diagnostics<CR>
nnoremap <S-F8> :TroubleToggle workspace_diagnostics<CR>
nnoremap <C-F8> :TroubleToggle quickfix<CR>

" 9: Snippets
let g:UltiSnipsExpandTrigger = '<F10>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-h>'

" 10: Git actions?

" Git actions with g
"---Tab completion---" ddc.vim and pum.vim
"===PLUGINS==="
" File-type specific ones are all mapped to function keys

"---Tab completion : INSERT---" ddc.vim and pum.vim
"inoremap <silent><expr> <Tab>       ddc#map#pum_visible()
"    \ ? pum#map#insert_relative(+1)
"    \ : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s')
"        \ ? '<Tab>'
"        \ : ddc#map#manual_complete()
"inoremap <silent><expr> <S-Tab>     ddc#map#pum_visible()
"    \ ? pum#map#insert_relative(-1)
"    \ : '<C-h>'
"inoremap <silent><expr> <C-n>       ddc#map#pum_visible()
"    \ ? pum#map#insert_relative(+1)
"    \ : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s')
"        \ ? '<C-n>'
"        \ : ddc#map#manual_complete()
"inoremap <silent><expr> <C-p>       ddc#map#pum_visible()
"    \ ? pum#map#insert_relative(-1)
"    \ : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s')
"        \ ? '<C-p>'
"        \ : ddc#map#manual_complete()
"inoremap <silent><expr> <C-y>       ddc#map#pum_visible()
"    \ ? pum#map#confirm()
"    \ : '<C-y>'
"inoremap <silent><expr> <C-e>       ddc#map#pum_visible()
"    \ ? pum#map#cancel()
"    \ : '<C-e>'
"inoremap <silent><expr> <PageDown>  ddc#map#pum_visible()
"    \ ? pum#map#insert_relative_page(+1)
"    \ : '<PageDown>'
"inoremap <silent><expr> <PageUp>    ddc#map#pum_visible()
"    \ ? pum#map#insert_relative_page(-1)
"    \ : '<PageUp>'

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
