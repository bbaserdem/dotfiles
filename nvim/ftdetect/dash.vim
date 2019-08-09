function! DetectDash()
   if getline(1) =~ '#!\/bin\/dash' || getline(1) =~ '#!\/usr\/bin\/dash'
     setfiletype sh
   endif
endfunction

augroup filetypedetect
  au BufRead,BufNewFile * call DetectDash()
augroup END
