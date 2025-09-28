"General adjustments
syntax on
filetype plugin indent on
set number
set visualbell
set wrap
set noshowcmd
set noshowmode
set smartindent
set mouse=a
set laststatus=2
set statusline=%#StatusBoxA#--[%{ModeStatus()}]%*\%#StatusBoxB#[%{GitBranch()}]%*\[File:\ %F]\ [L:%l,C:%c/%L\ %p%%] 
hi StatusLine ctermfg=DarkGray ctermbg=White
set shortmess+=F
set noruler

" NERDTree configs 
autocmd VimEnter * NERDTree | wincmd p 
autocmd BufWritePost,ShellCmdPost,FileChangedShellPost  * if exists("t:NERDTreeBufName") | execute 'NERDTreeRefreshRoot' | endif
autocmd BufEnter,WinEnter,TabEnter * if !empty(filter(range(1, winnr('$')), 'getbufvar(winbufnr(v:val), "&filetype") ==# "nerdtree"')) | silent! NERDTreeRefreshRoot | endif
let g:NERDTreeFileLines = 1
let g:NERDTreeShowHidden = 1
augroup DirAsBuffer
	autocmd!
	autocmd VimEnter * if argc() > 0 && isdirectory(argv(0)) | execute 'cd' fnameescape(argv(0)) | enew | endif
augroup END

" Function to get git branch
augroup GitBranchStatus
	autocmd!
	autocmd BufEnter * let b:gitbranch = system("git -C " . expand('%:p:h') . " rev-parse --abbrev-ref HEAD 2>/dev/null")[:-2]
augroup END

function! GitBranch() abort
	let label = 'null'
	if exists("b:gitbranch") && !empty(b:gitbranch)
		let label = '  ' . b:gitbranch 
	" elseif empty(b:gitbranch)
	else
		let label = ' ?.NO-REPO '
	endif
return label
endfunction

" Change mode color and text
function! ModeStatus()
 	let mode = mode()
 	if mode == 'n'
		hi StatusBoxA ctermfg=Black ctermbg=Yellow
  		return 'NORMAL'
	elseif mode == 'i'
		hi StatusBoxA ctermfg=Black ctermbg=Green
		return 'INSERT'
	elseif mode ==# 'v' || mode ==# 'V'
		hi StatusBoxA ctermfg=Black ctermbg=Blue
		return 'VISUAL'
	elseif mode == 'c'
		hi StatusBoxA ctermfg=Black ctermbg=Magenta
		return 'COMMAND'
	else
		hi StatusBoxA ctermfg=White ctermbg=Red
		return 'UNKNOWN'
	endif
endfunction

" Code indent and copy/paste
set tabstop=4
set shiftwidth=4

" Auto close brackets, curly brackts, parenthesis
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" General remaps
let mapleader = " "
noremap <C-s> :update<CR>
inoremap <C-s> <Esc>:update<CR>
nnoremap <silent> <leader>q :silent! NERDTreeClose \| wa \|qall<CR>
nnoremap <Tab> >>
nnoremap <S-Tab> <<
noremap <leader>l :ls<CR>
vnoremap y :w !pbcopy<CR><CR>
xnoremap ∆ :m '<+1<CR>gv=gv
nnoremap ˚ :m .-2<CR>==
nnoremap ∆ :m .+1<CR>==
xnoremap ˚ :m '<-2<CR>gv=gv

" Comment/Uncomment line 
function! ToggleComment() range
  let l:cs = substitute(&commentstring, '%s', '', '')
  if empty(l:cs)
   let l:cs = '#'
  endif
  for lnum in range(a:firstline, a:lastline)
    let l:line = getline(lnum)
    if l:line =~ '^\s*' . escape(l:cs, '\')
     call setline(lnum, substitute(l:line, '^\(\s*\)' . escape(l:cs, '\') . '\s\?', '\1', ''))
    else
  	 call setline(lnum, substitute(l:line, '^\s*', '\0' . l:cs . ' ', ''))
    endif
  endfor
endfunction
nnoremap <C-\> :call ToggleComment()<CR>
xnoremap <C-\> :call ToggleComment()<CR>

" Keep a buffer open to preserve view
function! SmartCloseBuffer() abort
	let cur = bufnr('%')
	let listed = filter (range(1, bufnr('$')), 'buflisted(v:val)')
	let idx = index(listed, cur)

	if idx < 0
		enew
		execute 'bd!' cur
		return
	endif

	if len(listed) == 1 || idx == len(listed) - 1
		enew
		execute 'bd!' cur
		return
	endif

	let nextbuf = listed[idx +1]
	execute 'buffer' nextbuf
	execute 'bd!' cur
endfunction
nnoremap <silent> <leader>Q :call SmartCloseBuffer()<CR>

" Toggle focus between NERDTree and last buffer
function! ToggleNERDTreeFocus() abort
  if &filetype ==# 'nerdtree'
    " If we are in NERDTree, go back to the previous window
    wincmd p
  else
    " Try to find a nerdtree window and jump there
    for w in range(1, winnr('$'))
      if getbufvar(winbufnr(w), '&filetype') ==# 'nerdtree'
        execute w . 'wincmd w'
        return
      endif
    endfor
  endif
endfunction
nnoremap <silent> <leader><Space> :call ToggleNERDTreeFocus()<CR>

" Plugins
call plug#begin()
  Plug 'preservim/nerdtree'
call plug#end()
