"colorscheme winter 
"colorscheme default
colorscheme molokai
set guioptions-=m
set guioptions-=T

set guifont=Yahei\ Consolas\ Hybrid\ 12
map <M-q> :q <CR>
"Toggle Menu and Toolbar with F2
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=m <bar>
            \else <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=m <Bar>
            \endif<CR>

" Do not use modal alert dialogs! (Prefer Vim style prompt.)
" http://stackoverflow.com/questions/4193654/using-vim-warning-style-in-gvim
set guioptions+=c

" 最大化窗口
function Maximize_Window()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction
