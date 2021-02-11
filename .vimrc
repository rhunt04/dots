" rjh .vimrc

filetype plugin indent on

" Plugins: vim-plug junegunn
call plug#begin('~/.vim/plugged')
Plug 'sirver/ultisnips'
call plug#end()

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" LaTeX snippets
let g:tex_flavor = "latex"

se ml
syn on
se cul
se bs=2
se wmnu
se ai si
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

hi CursorLine cterm=NONE
hi CursorLineNr ctermfg=5 cterm=BOLD
au ColorScheme * hi VertSplit cterm=NONE ctermfg=white

hi! link Folded Normal
" Highlight only last space. Saves lcs 'trail' chars looking ugly.
hi ExtraWhitespace ctermfg=2 ctermbg=1
mat ExtraWhitespace /\s\{1}$/

au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

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
nn <C-Right> :tabn<CR>
nn <leader>t :%s/\s\+$//e<CR>
no <silent> <C-S> :update<CR>
nn <leader>h :se hls! hls?<CR>
vn <C-r> "ry:%s/<C-r>r//gc<C-f>3h<C-c>

" Highlight any actual char beyond 80. Don't highlight when a char is next to
" line 81, but still on line 80.
hi ColorColumn ctermbg=1 ctermfg=0
cal matchadd('ColorColumn','\%81v.',100)

fu! IsP()
  if &paste|retu 'p)'|el|retu ''|en
endf

fu! Fsz()
  retu printf('%.2gkB)',abs(0.001*getfsize(expand(@%))))
endf

hi StatusLine term=NONE cterm=BOLD ctermfg=5
se stl=\ %f%M%R)\ \%{Fsz()}\ \%{IsP()}\%=\(\c%v\ (\%p%%\ "
