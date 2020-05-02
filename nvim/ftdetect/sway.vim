function! DetectSway()
  if expand('%:e')=='sway' || expand('%:p:h:h:t')=='sway' || ((expand('%:p:h:t')=='sway')&&(expand('%:t'=='config')))
    setfiletype sway
  endif
endfunction
function! DetectWaybar()
  if expand('%:p:h:t')=='waybar'
    if expand('%:t')=='config'
      setfiletype json
    elseif expand('%:t')=='style.css'
      setfiletype css
    endif
  endif
endfunction

augroup filetypedetect 
  au BufRead,BufNewFile * call DetectSway()
  au BufRead,BufNewFile * call DetectWaybar()
augroup END
