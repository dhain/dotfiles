call pathogen#runtime_append_all_bundles()

set nocompatible

" system stuff
set history=1000
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set hidden      " switch buffers without saving
set switchbuf=useopen,usetab

runtime macros/matchit.vim

" searching
set incsearch
set ignorecase
set smartcase

" tab and backspace
set wildignore=.git,env,*.pyc,*.egg-info,_build,node_modules
set wildmenu    " make tab completion work like bash
set backspace=indent,eol,start
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Map key to toggle opt
function MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)


" display setup
set ruler       " show cusor position
set showcmd     " display incomplete commands
set scrolloff=3
set cmdheight=2
set winwidth=84
set winheight=25
set winminheight=10

set number              " turn on line numbering
set list                " show invisibles
MapToggle <f2> number
MapToggle <f4> list


set laststatus=2        " always show status line
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position

colorscheme grb256

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
    set guioptions-=m
    set guioptions-=T
endif

"set cursorline     # higlight current line

" customize tab labels
function! MyTabLabel(n)
    let label = '[' . (a:n)
    let buflist = tabpagebuflist(a:n)
    for bufnr in buflist
        if getbufvar(bufnr, '&modified')
            let label .= '*'
            break
        endif
    endfor
    let label .= ']'
    let m = bufname(buflist[tabpagewinnr(a:n) - 1])
    let label .= fnamemodify(m, ':t')
    return label
endfunction

function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'
        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} |'
    endfor
    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999X X'
    endif
    return s
endfunction

set tabline=%!MyTabLine()
hi TabLine cterm=underline ctermbg=none
hi TabLineFill cterm=underline
hi TabLineSel cterm=underline ctermbg=0*

" save and restore window state when switching buffers
if v:version >= 700
    au BufLeave * let b:winview = winsaveview()
    au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" keys and mappings
let mapleader=","
map <leader>\dontstealmymapsmakegreen :w\|:call MakeGreen('spec')<cr>
nnoremap <cr> :nohlsearch<cr>/<bs>
nnoremap <leader><leader> <C-^>
vnoremap <leader>y "*y

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-n> :let &wh = (&wh == 999 ? 10 : 999)<CR><C-W>=

if &diff
  nmap <c-h> :diffget LOCAL<cr>
  nmap <c-l> :diffget REMOTE<cr>
  nmap <c-k> [cz.
  nmap <c-j> ]cz.
  set nonumber
endif

" Make <leader>' switch between ' and "
nnoremap <leader>' ""yls<c-r>={'"': "'", "'": '"'}[@"]<cr><esc>

command! W :w
command! Wq :wq
command! Wqa :wqa
command! Tabnew :tabnew

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" file types
if has("autocmd")
    filetype plugin indent on
    au BufRead,BufNewFile triage.txt set ft=cstriage
    au BufRead,BufNewFile *.tac set ft=python
    au BufRead,BufNewFile *.json set filetype=json
    au BufRead,BufNewFile *.pde set filetype=arduino
    au BufRead,BufNewFile *.ino set filetype=arduino
    au FileType text setlocal textwidth=78

    augroup arduino_autocmd
        autocmd!
        autocmd FileType arduino setlocal cindent
        autocmd FileType arduino setlocal shiftwidth=2
    augroup END

    augroup js_autocmd
        autocmd!
        autocmd FileType javascript setlocal autoindent
        autocmd FileType javascript setlocal formatoptions=tcql
        autocmd FileType javascript setlocal textwidth=78 shiftwidth=2
        autocmd FileType javascript setlocal softtabstop=2 tabstop=8
        autocmd FileType javascript setlocal expandtab
    augroup END

    augroup json_autocmd
        autocmd!
        autocmd FileType json setlocal autoindent
        autocmd FileType json setlocal formatoptions=tcq2l
        autocmd FileType json setlocal textwidth=78 shiftwidth=2
        autocmd FileType json setlocal softtabstop=2 tabstop=8
        autocmd FileType json setlocal expandtab
    augroup END

    augroup cucumber_autocmd
        autocmd!
        autocmd FileType cucumber setlocal autoindent
        autocmd FileType cucumber setlocal textwidth=78 shiftwidth=2
        autocmd FileType cucumber setlocal softtabstop=2 tabstop=8
        autocmd FileType cucumber setlocal expandtab
    augroup END
endif


" syntastic options
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
