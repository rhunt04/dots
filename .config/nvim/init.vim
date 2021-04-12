" rjh init.vim

let mapleader = ","
filet plugin indent off

" *{{ Plugins
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
au CursorHold * silent call CocActionAsync('highlight')

fu! s:show_doc()
  if ( index(['vim', 'help'], &filetype) >= 0 )
    exe 'h '.expand('<cword>')
  elsei ( coc#rpc#ready() )
    cal CocActionAsync('doHover')
  el
    exe '!' . &keywordprg . " " . expand('<cword>')
  en
endf
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
se smc=90
se shm+=I
se sb spr
se nu rnu
se mouse=a
se scl=number
se fdm=marker
se fmr=*{{,}}*
se lbr nowrap
se nocp t_RV=
se fcs+=vert:\ "
se cb=unnamedplus
se nowb nobk noswf
se et ts=2 ls=2 sw=2
se ww+=<,>,[,]
se list lcs=tab:\│\ "
se shada+=n~/.config/nvim/nvi   " write inside ~/.config/nvim/nvi
" }}*

" *{{ Highlights
"hi link Folded Normal
hi CursorLine ctermbg=NONE
hi VertSplit cterm=NONE ctermbg=0
hi TabLine cterm=BOLD ctermbg=0 ctermfg=2
hi TabLineSel cterm=BOLD ctermbg=2 ctermfg=0
hi TabLineFill cterm=NONE ctermbg=0
hi TrailSpaces ctermbg=2
mat TrailSpaces /\s\{1}$/ " highlight only last space.

" Highlight any actual char beyond 80. Don't highlight when a char is next to
" line 81, but still on line 80.
hi ColorColumn ctermbg=1 ctermfg=0
cal matchadd('ColorColumn','\%81v.',100)

" }}*

" *{{ au commands
" Return to cursor location
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
  \ exe "norm! g`\"" | en

" New file netrw
au BufNewFile * :Lexplore
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 0
let g:netrw_browse_split = 3
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
" }}*

" *{{ My statusline
" If config item c present, return key k. Else, return empty string.
fu! IsX(c,k)
  if a:c|retu a:k|el|retu ''|en
endf

fu! Fsz()
  let l:fs = getfsize(expand(@%))
  if fs<0
    retu printf('-')
  elsei fs<1.0e3
    retu printf('%i',fs)
  elsei  fs<1.0e6
    retu printf('%.1gk',1.0e-3*fs)
  el
    retu printf('%.1gm',abs(1.0e-6*fs)
  en
endf

hi StatusLine ctermbg=0
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
" }}*
