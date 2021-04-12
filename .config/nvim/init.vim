" rjh init.vim

let mapleader = ","

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  sil !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" termguicolors + dracula.
"se tgc
let g:dracula_colorterm=0
colo dracula

" Use K to show documentation in preview window.
nn <silent> K :cal <SID>show_doc()<CR>
ino <silent><expr> <c-space> coc#refresh()

se ut=300
nmap <leader>d <Plug>(coc-definition)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

fu! s:show_doc()
  if ( index(['vim', 'help'], &filetype) >= 0 )
    exe 'h '.expand('<cword>')
  elsei ( coc#rpc#ready() )
    cal CocActionAsync('doHover')
  el
    exe '!' . &keywordprg . " " . expand('<cword>')
  en
endf

se guicursor=

filet plugin indent off
se ml
syn on
se cul
se bs=2
se wmnu
"se noai nosi
se nohls
se tf lz
se fo-=q
se smc=90
se shm+=I
se sb spr
se nu rnu
se mouse=a
se scl=number
se fdm=marker
se fmr=*{{,}}*
nn <space> za
se lbr nowrap
se nocp t_RV=
se fcs+=vert:\ "┆
"se vi=                      " dont write viminfo file
se vi+=n~/.config/nvim/nvi   " write inside ~/.config/nvim/vi
se cb=unnamedplus
se nowb nobk noswf
se et ts=2 ls=2 sw=2
se ww+=<,>,[,]
se list lcs=tab:\│\ "
"se sbr=~              " not showing wraps...

hi CursorLine ctermbg=NONE
hi VertSplit cterm=NONE ctermbg=0

hi TabLine cterm=NONE
hi TabLineFill cterm=NONE

hi! link Folded Normal
" Highlight only last space. Saves lcs 'trail' chars looking ugly.
hi ExtraWhitespace ctermbg=2
mat ExtraWhitespace /\s\{1}$/

" Return to cursor location
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
  \ exe "norm! g`\"" | en

let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 0
au BufNewFile * :Lexplore
let g:netrw_browse_split = 3

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

" Highlight any actual char beyond 80. Don't highlight when a char is next to
" line 81, but still on line 80.
hi ColorColumn ctermbg=1 ctermfg=0
cal matchadd('ColorColumn','\%81v.',100)

" If config item c present, return key k. Else, return empty string.
fu! IsX(c,k)
  if a:c|retu a:k|el|retu ''|en
endf

fu! Fsz()
  retu printf('%.2gk',abs(0.001*getfsize(expand(@%))))
endf

hi StatusLine ctermbg=NONE ctermbg=0
hi finfo cterm=BOLD ctermbg=5 ctermfg=0
hi sinfo cterm=BOLD ctermbg=6 ctermfg=0
hi cinfo cterm=BOLD ctermbg=3 ctermfg=0
hi pinfo cterm=BOLD ctermbg=2 ctermfg=0
se stl=%#finfo#
se stl+=\ %f%M%R\ %#sinfo#   " hl group for file
se stl+=\ %{Fsz()}           " hl group for file size
se stl+=\ %#StatusLine#\ "   " back to normal hl group
se stl+=\%{IsX(&paste,'📋')} " are various things toggled?
se stl+=\%{IsX(&hls,'🔍')}
se stl+=\%{IsX(!&et,'➡️')}
se stl+=\%=
se stl+=%#cinfo#\ ᶜ%v\ "    " hl group char count
se stl+=%#pinfo#\ \%p﹪      " hl group progress through file
