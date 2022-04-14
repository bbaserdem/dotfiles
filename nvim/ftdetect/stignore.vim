function! DetectStignore()
  if expand('%:p:h:t')==?'Stignore'
    setfiletype stignore
  endif
endfunction

augroup filetypedetect 
  au BufRead,BufNewFile * call DetectStignore()
augroup END
