let mapleader=","

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

set nu
"set clipboard+=unnamed   " share window clipboard

set nocompatible " explicitly get out of vi-compatible mode
set noexrc " don't use local version of .(g)vimrc, .exrc
set background=dark " we plan to use a dark background
syntax on " syntax highlighting on

" Search {
set hlsearch    " highlight search result.
set incsearch   " do search as you type your search phrase
set ignorecase smartcase    " smart ignore case when searching.
" }

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

set expandtab " user space instead of tab
set tabstop=4 " set tab to four spaces
set shiftwidth=4 " 自动缩进的宽度。

"pydiction 1.2 python auto complete
set nocp
filetype plugin on

let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'
let g:pydiction_menu_height = 15
let g:pydiction_menu_height = 20

set showmode
set helplang=cn

let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>
let g:winManagerWidth = 40

:set cscopequickfix=s-,c-,d-,i-,t-,e- "set cscope

filetype plugin indent on

let g:winManagerWindowLayout='NERDTree|TagList,BufExplorer'

" Key mappings {
"
"http://markmail.org/message/xquyuriysxd45m6n#query:vim%20alt%20konsole+page:1+mid:xquyuriysxd45m6n+state:results
map q :q <CR>
map Q :qa <CR>
map W :w <CR>
map <S-CR> o<Esc>
map <C-S-CR> O<Esc>
inoremap <S-CR> <ESC>$o
inoremap <C-S-CR> <ESC>$O

inoremap <C-a> <ESC>:r!date<CR>iCalvin.Lee<lihao921@gmail.com> @ <ESC>kJA<CR>

"自动补全成对的括号和引号
"@http://blog.hotoo.me/vim-autocomplete-pairs.html
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap < <><ESC>i
inoremap > <c-r>=ClosePair('>')<CR>
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
"@http://oldj.net/article/vim-parenthesis/
"inoremap <BS> <ESC>:call RemovePairs()<CR>a
""
" format all of text
nnoremap <s-f> gg=G<C-o><C-o>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map f/ <esc>:grep

" open bufexplorer
map <s-b> \be

map <S-Insert> <MiddleMouse>

map <C-a> :A <CR>

" generate tags file with C-F12
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" }

let g:debuggerMaxDepth = 5

" 允许backspace和光标键跨越行边界
:set whichwrap+=<,>,h,l

" 记住上次离开的的位置
" 注意：保证.viminfo目录可写
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    "hignlight current line
    :set cursorline
    ":set cursorcolumn

    :set clipboard=unnamed

    :set go+=a

    "自动载入 .vimrc，修改后不需要重启
    autocmd! bufwritepost .vimrc source %

    function! ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf

function! RemovePairs()
	let l:line = getline(".")
	let l:previous_char = l:line[col(".")-1] " 取得当前光标前一个字符

	if index(["(", "[", "{"], l:previous_char) != -1
		let l:original_pos = getpos(".")
		execute "normal %"
		let l:new_pos = getpos(".")

		" 如果没有匹配的右括号
		if l:original_pos == l:new_pos
			execute "normal! a\<BS>"
			return
		end

		let l:line2 = getline(".")
		if len(l:line2) == col(".")
			" 如果右括号是当前行最后一个字符
			execute "normal! v%xa"
		else
			" 如果右括号不是当前行最后一个字符
			execute "normal! v%xi"
		end

	else
		execute "normal! a\<BS>"
	end
endfunction

    ":set mouse=v
    "
    " no swap file please
    :set noswapfile

    :set cscopequickfix=s-,c-,d-,i-,t-,e-

    :set iskeyword+=-

    " transfer/read and write one block of text between vim sessions
    " Usage:
    " `from' session:
    " ma
    " move to end-of-block
    " xw
    "
    " `to' session:
    " move to where I want block inserted
    " xr
    "
    if has("unix")
        nmap xr :r $HOME/.vimxfer<CR>
        nmap xw :'a,.w! $HOME/.vimxfer<CR>
        vmap xr c<esc>:r $HOME/.vimxfer<CR>
        vmap xw :w! $HOME/.vimxfer<CR>
    else
        nmap xr :r c:/.vimxfer<CR>
        nmap xw :'a,.w! c:/.vimxfer<CR>
        vmap xr c<esc>:r c:/.vimxfer<cr>
        vmap xw :w! c:/.vimxfer<CR>
    endif

    function! Do_CsTag()
        if(executable('cscope') && has("cscope") )
            if(g:iswindows!=1)
                silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' -o -name '*.cxx' -o -name '*.hxx'> cscope.files"
            else
                silent! execute "!dir /b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
            endif
            silent! execute "!cscope -bq"
            if filereadable("cscope.out")
                execute "cs add cscope.out"
            endif
        endif
    endf

    map <F<F6>> :call Do_CsTag()

" markdown syntax settings
augroup mkd
    autocmd BufNewFile,BufRead *.md set ai formatoptions=tcroqn2 comments=n:>
    autocmd BufNewFile,BufRead *.md set wrap nonumber
augroup END
" set column cursor on when editing markdown files
au FileType mkd set cursorcolumn

" Removes trailing spaces
" @http://vim.wikia.com/wiki/Remove_unwanted_spaces#Automatically_removing_all_trailing_whitespace
function! TrimWhiteSpace()
  %s/\s*$//
  ''
:endfunction

" set list listchars=trail:.,extends:>
" TODO: When I am writting markdown, I do need trailing spaces to break lines...
"autocmd FileWritePre * :call TrimWhiteSpace()
"autocmd FileAppendPre * :call TrimWhiteSpace()
"autocmd FilterWritePre * :call TrimWhiteSpace()
"autocmd BufWritePre * :call TrimWhiteSpace()

" generating and markdown image tag
command! -nargs=1 -complete=file Mkdimg :r!echo "[[/<args>](/<args>)](/<args>)"

" http://naseer.in/use-cscope-to-browse-the-android-source-code
set nocsverb  
 if filereadable("cscope.out")   
 else   
     if $ANDROID_BUILD_TOP !=""  
         "This assumes you have sourced the Android build environment  
         cscope add $ANDROID_BUILD_TOP/cscope.out      
  else  
         "Or, you can point to your android source directory in $ANDROID_DIR   
         cscope add $ANDROID_DIR/cscope.out  
     endif   
 endif  

" shortcut for quickfix window
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cw :cw 10<cr> 


""""""""""""""""""""""""""""""
" lookupfile setting
" http://easwy.com/blog/archives/advanced-vim-skills-lookupfile-plugin/
""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")               "设置tag文件的名字
let g:LookupFile_TagExpr = '"./filenametags"'
endif
"映射LookupFile为lf
"nmap <silent> lf :LUTags<cr>
"映射LUBufs为,ll
nmap <silent> <leader>ll :LUBufs<cr>
"映射LUWalk为,lw
nmap <silent> <leader>lw :LUWalk<cr>

" lookup file with ignore case
function! LookupFile_IgnoreCaseFunc(pattern)
    let _tags = &tags
    try
        let &tags = eval(g:LookupFile_TagExpr)
        let newpattern = '\c' . a:pattern
        let tags = taglist(newpattern)
    catch
        echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
        return ""
    finally
        let &tags = _tags
    endtry

    " Show the matches for what is typed so far.
    let files = map(tags, 'v:val["filename"]')
    return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc' 
