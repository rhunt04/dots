" rjh .vimrc

let mapleader = ","
se nocp
filet plugin indent off

" *{{ Plugins
" auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  sil !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
  Plug 'sirver/ultisnips'
  Plug 'dense-analysis/ale'
  Plug 'ron89/thesaurus_query.vim'
  Plug 'altercation/vim-colors-solarized'
call plug#end()

" *{{ ALE
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

" When should we lint? Save only.
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'never'

" Symbol definitions.
let g:ale_sign_error = "⚠"
let g:ale_sign_warning = "⚐"

" Fixers.
let g:ale_fix_on_save = 1
let g:ale_floating_preview = 1
let g:ale_completion_enabled = 1

" Errors in tray.
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

nn <silent> K :ALEDetail<CR>
" }}*

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" termguicolors + dracula.
"se tgc
"let g:dracula_colorterm=0
"colo dracula
se bg=light
colo solarized

hi! Pmenu cterm=NONE

" Thesaurus info:
" Backend mthesaur:
"   Download from:
"   https://www.gutenberg.org/files/3202/files/mthesaur.txt
"   then
let g:tq_mthesaur_file="~/.config/nvim/thesaurus/mthesaur.txt"

" Backend openoffice (if not locally available):
" Download from:
" https://www.openoffice.org/lingucomponent/MyThes-1.zip
" (or get locally!)
" then
" let g:tq_openoffice_en_file="~/.config/nvim/thesaurus/MyThes-1.0/th_en_US_new"
" The one on my machine (found by locate):
let g:tq_openoffice_en_file="/usr/share/mythes/th_en_US_v2"
let g:tq_enabled_backends=["datamuse_com","openoffice_en","mthesaur_txt"]
let g:tq_language=['en']

nn <silent><leader>th :ThesaurusQueryReplaceCurrentWord<CR>

" }}*

" *{{ Sets
se ml
syn on
se cul
se acd
se bs=2
se gcr=
se wmnu
se nohls
se tf lz
se fo-=q
se t_RV=
se smc=90
se shm+=I
se sb spr
se nu rnu
se mouse=a
se scl=number
se fdm=marker
se fmr=*{{,}}*
se lbr nowrap
se fcs+=vert:\ "
se vi+=n~/.vim/vi
se cb=unnamedplus
se nowb nobk noswf
se et ts=2 ls=2 sw=2
se ww+=<,>,[,]
se list lcs=tab:\│\ "
" }}*

" *{{ Highlights
hi CursorLine ctermbg=7
hi CursorLineNR ctermbg=7 cterm=BOLD
hi VertSplit cterm=NONE ctermbg=0
hi Folded cterm=NONE ctermbg=7 ctermfg=5
hi TabLineFill cterm=NONE ctermbg=0
hi TabLine cterm=BOLD ctermbg=0 ctermfg=2
hi TabLineSel cterm=BOLD ctermbg=2 ctermfg=0

hi TrailSpaces ctermbg=3
mat TrailSpaces /\s\{1}$/ " highlight only last space.

" Highlight any actual char beyond 80. Don't highlight when a char is next to
" line 81, but still on line 80.
hi CColumn ctermbg=1 ctermfg=0
cal matchadd('CColumn','\%81v.',100)

" }}*

" *{{ Auto commands
" Return to cursor location
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
  \ exe "norm! g`\"" | en
" Open folds at cursor location (if folded)
au BufReadPost * if (foldlevel('.') > 0) | exe "norm! za" | en

" New file netrw
au BufNewFile * :Lexplore
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 0
let g:netrw_browse_split = 3

" LaTeX
let g:tex_flavor = "latex"
au FileType latex,tex,md,markdown setl spell spl=en_us tw=80

" git
au FileType gitcommit setl spell spl=en_us tw=80
" }}*

" *{{ Keymaps
nn : ;
nn ; :
nn vw viw
nn <space> za
ino () ()<Left>
ino [] []<Left>
ino {} {}<Left>
ino <> <><Left>
nn <leader>wp Vapgq
nn <leader>wl gqq
nn <leader>. dEi.<Esc>
nn <leader>s i<space><Esc>
nn <C-w>n :tabnew<CR>
nn <C-Left> :tabp<CR>
nn <C-Right> :tabn<CR>
ino {<CR> {<CR>}<Esc>ko<Tab>
ino <<CR> <<CR>><Esc>ko<Tab>
ino (<CR> (<CR>)<Esc>ko<Tab>
ino [<CR> [<CR>]<Esc>ko<Tab>
vn <C-r> "ry:%s/<C-r>r//gc<C-f>3h<C-c>
nn <leader>h :se hls! hls?<CR>:ec " Toggled hls."<CR>
nn <leader>p :se paste! paste?<CR>:ec " Toggled paste."<CR>
no <silent><C-S> :update<CR>:ec " Saved '".expand('%:t')."'."<CR>
nn <leader>t :%s/\s\+$//e<CR>:ec " Trimmed '".expand('%:t')."'."<CR>

fu! Float(key)
  " Run a key once, but if you find the cursor under whitespace, run it again
  " - repeat.
  " WARNING: only use this on actions which can terminate... no maxiter or
  " check or anything.
  " WIP: variant which allows for detection of "change" under cursor: store
  " initial cursor value, compare to this instead of looking for space. Bit
  " odd at times, disabling for now.
  " let l:myChar = strcharpart(getline('.')[col('.') - 1:], 0, 1)
  exe 'norm!' a:key
  wh line(".")>1&&(strlen(getline("."))<col(".")||getline(".")[col(".")-1]=~'\s')
  "wh line(".") > 1 && (strlen(getline(".")) < col(".") || getline(".")[col(".") - 1] =~ l:myChar)
    exe 'norm!' a:key
  endw
endf
nn <silent> <C-Up> :call Float('k')<CR>
nn <silent> <C-Down> :call Float('j')<CR>
" }}*

" *{{ Statusline
" If config item c present, return key k. Else, return empty string.
fu! IsX(c,k)
  if a:c|retu a:k|el|retu ''|en
endf

fu! Fsz()
  let l:fs = getfsize(expand(@%))
  if fs<0
    retu printf('-')
  elsei fs<1.0e3
    retu printf('%ib',fs)
  elsei  fs<1.0e6
    retu printf('%.1gk',1.0e-3*fs)
  el
    retu printf('%.1gm',1.0e-6*fs)
  en
endf

fu! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '✓' :
    \ printf('%d⚠ %d⚐', all_errors, all_non_errors)
endfunction

hi StatusLine ctermbg=0 ctermfg=15
hi finfo cterm=BOLD ctermbg=5 ctermfg=0
hi sinfo cterm=BOLD ctermbg=6 ctermfg=0
hi cinfo cterm=BOLD ctermbg=3 ctermfg=0
hi linfo cterm=BOLD ctermbg=4 ctermfg=0
hi pinfo cterm=BOLD ctermbg=2 ctermfg=0
se stl=%#finfo#
se stl+=\ %f%M%R\ %#sinfo#   " hl group for file
se stl+=\ %{Fsz()}           " hl group for file size
se stl+=\ %#StatusLine#\ "   " back to normal hl group this
se stl+=\%{IsX(&paste,'paste\ ')} " are various things toggled?
se stl+=\%{IsX(&hls,'hls\ ')}
se stl+=\%{IsX(!&et,'et\ ')}
se stl+=\%=
se stl+=%#linfo#\ %{LinterStatus()}\ "    " lint info
se stl+=%#cinfo#\ c%v\ "                  " hl group char count
se stl+=%#pinfo#\ \%p%%\ "                " hl group progress through file
" }}*
