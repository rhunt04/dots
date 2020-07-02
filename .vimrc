" rjh .vimrc

filetype plugin indent on

se ml
syn on
se cul
se bs=2
se ai si
se tf lz
se fo-=q
se smc=90
se shm+=I
se sb spr
se nu rnu
se lbr nowrap
se nocp t_RV=
se fcs+=vert:│
se et ts=2 ls=2
se vi+=n~/.vim/vi
se cb=unnamedplus
se nowb nobk noswf
se list lcs=tab:\│\ ,trail:%
set whichwrap+=<,>,[,]
"se sbr=~ " not showing wraps...

hi CursorLine cterm=NONE
hi CursorLineNr ctermbg=3 ctermfg=1 cterm=bold
au ColorScheme * hi VertSplit cterm=NONE ctermfg=white

hi ExtraWhitespace cterm=bold ctermfg=white
match ExtraWhitespace /\s\+$/

let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
au BufNewFile * :Lexplore
let g:netrw_browse_split = 3

nn : ;
nn ; :
nn vw viw
se pt=<leader>p
nn <leader>t :%s/\s\+$//e<CR>
nn <leader>wp Vapgq
nn <C-Left> :tabp<CR>
nn <C-Right> :tabN<CR>
nn <leader>h :se hls! hls?<CR>
vn <C-r> "ry:%s/<C-r>r//gc<C-f>3h<C-c>

cal matchadd('ColorColumn','\%81v',1)

fu! IsP()
  if &paste|retu 'p)'|el|retu ''|en
endf

fu! Fsz()
  retu printf('%.2gkB)',abs(0.001*getfsize(expand(@%))))
endf

se stl=\ %f%M%R)\ \%{Fsz()}\ \%{IsP()}\%=\(\c%v\ (\%p%%\ "

