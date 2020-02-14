" rjh .vimrc

se ml
syn on
se bs=2
se ai si
se tf lz
se fo-=q
se smc=90
se sb spr
se nu rnu
se lbr wrap
se nocp t_RV=
se fcs+=vert:│
se et ts=2 ls=2
se vi+=n~/.vim/vi
se nowb nobk noswf
se list lcs=tab:\│\ "
se sbr=↪
filetype plugin indent on
au ColorScheme * hi VertSplit cterm=NONE ctermfg=white

let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
au BufNewFile * :Lexplore
let g:netrw_browse_split = 3

nn : ;
nn ; :
nn vw viw
se pt=<leader>p
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

