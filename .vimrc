" rjh .vimrc

" get vim-plug yourself
if empty(glob('~/.vim/autoload/plug.vim'))
  sil !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
  Plug 'sirver/ultisnips'
  Plug 'ron89/thesaurus_query.vim'
  Plug 'altercation/vim-colors-solarized'
  " Plug 'dracula/vim', {'as':'dracula'}
call plug#end()

filet plugin indent off

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" LaTeX snippets
let g:tex_flavor = "latex"

" colo dracula
se background=light
colo solarized

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

se ml
syn on
se cul
se bs=2
se wmnu
"se noai nosi
se tf lz
se fo-=q
se smc=90
se shm+=I
se sb spr
se nu rnu
se fdm=marker
se fmr=*{{,}}*
nn <space> za
se lbr nowrap
se nocp t_RV=
se fcs+=vert:│
"se vi=                " dont write viminfo file
se vi+=n~/.vim/vi     " write inside ~/.vim/vi
se cb=unnamedplus
se nowb nobk noswf
se et ts=2 ls=2 sw=2
se ww+=<,>,[,]
se list lcs=tab:\│\ "
"se sbr=~              " not showing wraps...

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

" Return to cursor location
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
  \ exe "norm! g`\"" | en

let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
au BufNewFile * :Lexplore
let g:netrw_browse_split = 3

let mapleader = ","

nn : ;
nn ; :
nn vw viw
ino () ()<Left>
ino [] []<Left>
ino {} {}<Left>
ino <> <><Left>
nn <leader>wp Vapgq
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
  exe 'norm!' a:key
  wh line(".")>1&&(strlen(getline("."))<col(".")||getline(".")[col(".")-1]=~'\s')
    exe 'norm!' a:key
  endw
endf
nn <silent> <C-Up> :call Float('k')<CR>
nn <silent> <C-Down> :call Float('j')<CR>

" Highlight any actual char beyond 80. Don't highlight when a char is next to
" line 81, but still on line 80.
hi CColumn ctermbg=1 ctermfg=0
cal matchadd('CColumn','\%81v.',100)

" If config item c present, return key k. Else, return empty string.
fu! IsX(c,k)
  if a:c|retu a:k|el|retu ''|en
endf

fu! Fsz()
  retu printf('%.2gkB',abs(0.001*getfsize(expand(@%))))
endf

hi StatusLine cterm=BOLD ctermfg=8
hi finfo cterm=BOLD ctermbg=5 ctermfg=0
hi sinfo cterm=BOLD ctermbg=6 ctermfg=0
hi cinfo cterm=BOLD ctermbg=3 ctermfg=0
hi pinfo cterm=BOLD ctermbg=2 ctermfg=0
se stl=%#finfo#
se stl+=\ %f%M%R\ %#sinfo#   " hl group for file
se stl+=\ %{Fsz()}           " hl group for file size
se stl+=\ %#StatusLine#\ "   " back to normal hl group
se stl+=\%{IsX(&paste,'P')} " are various things toggled?
se stl+=\%{IsX(&hls,'H')}
se stl+=\%{IsX(!&et,'T')}
se stl+=\%=
se stl+=%#cinfo#\ \c%v\ "    " hl group char count
se stl+=%#pinfo#\ \%p%%\ "   " hl group progress through file

