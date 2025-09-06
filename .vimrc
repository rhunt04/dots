" rjh .vimrc

let mapleader = ','
se nocp
filet plugin indent off

" *{{ Plugins
" auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  sil !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf.vim'
  Plug 'dense-analysis/ale'
  Plug 'tpope/vim-fugitive'
  Plug 'voldikss/vim-floaterm'
  Plug 'zirrostig/vim-schlepp'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'Exafunction/windsurf.vim', { 'branch': 'main' }
  "Plug 'sirver/ultisnips'
  "Plug 'ron89/thesaurus_query.vim'
  "Plug 'altercation/vim-colors-solarized'
  "Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" *{{ ALE
let g:ale_completion_enabled = 1

" When should we lint? Save only.
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 0
"let g:ale_lint_on_text_changed = 'never'

" Symbol definitions.
let g:ale_sign_error = "⚠"
let g:ale_sign_warning = "⚐"

" Fixers.
let g:ale_fix_on_save = 1
let g:ale_set_balloons = 1
let g:ale_cursor_detail = 1
let g:ale_floating_preview = 1
let g:ale_detail_to_floating_preview = 1

" Errors in tray.
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linters = {
  \ 'python': ['ruff', 'pylsp', 'bandit', 'pydocstyle'],
  \ 'yaml': ['yamllint'],
  \ 'markdown': ['markdownlint', 'writegood', 'alex', 'proselint', 'cspell'],
  \ 'vim': ['vint', 'vimls', 'cspell'],
  \ 'bash': ['bash-language-server', 'shellcheck'],
  \ 'latex': ['lacheck'],
  \ 'docker': ['hadolint'],
  \ 'terraform': ['tflint', 'checkov', 'terraform'],
\}

let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'python': ['isort', 'black'],
  \ 'c': ['clang-format'],
  \ 'terraform': ['terraform'],
\}

let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']

nn <silent> H :ALEHover<CR>
nn <silent> K :ALEDetail<CR>
" }}*

" *{{ Floaterm
hi FloatermBorder ctermfg=4

nn <silent><C-h> :FloatermToggle<CR>
tno <silent><C-h> <C-\><C-n>:FloatermToggle<CR>

let g:floaterm_width=0.8
let g:floaterm_height=0.5
let g:floaterm_autoclose=2
let g:floaterm_wintype='float'
let g:floaterm_title=' ʕ•ᴥ•ʔ '
let g:floaterm_position='bottom'
let g:floaterm_titleposition='center'
let g:floaterm_borderchars='═║═║╔╗╝╚'
" }}*

" *{{ FZF
nn <silent><C-f> :FZF<CR>
" }}*

" *{{ GitGutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = 'Δ'
let g:gitgutter_sign_removed = '-'
" }}*

" *{{ Schlepp
vmap <unique> <C-up>    <Plug>SchleppUp
vmap <unique> <C-down>  <Plug>SchleppDown
vmap <unique> <C-left>  <Plug>SchleppLeft
vmap <unique> <C-right> <Plug>SchleppRight
" }}*

" *{{ Codeium
" Disable by default:
let g:codeium_filetypes_disabled_by_default = v:true

" enable for specific filetypes
let g:codeium_filetypes = {
\ 'bash': v:true,
\ 'python': v:true,
\ 'vim': v:true
\ }

" }}*

"let g:UltiSnipsExpandTrigger='<tab>'
"let g:UltiSnipsJumpForwardTrigger='<tab>'
"let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" termguicolors + dracula.
" se tgc
"let g:dracula_colorterm=0
"colo dracula

se bg=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"colo solarized

hi! Pmenu cterm=NONE

" Thesaurus info:
" Backend mthesaur:
"   Download from:
"   https://www.gutenberg.org/files/3202/files/mthesaur.txt
"   then
"let g:tq_mthesaur_file='~/.config/nvim/thesaurus/mthesaur.txt'

" Backend openoffice (if not locally available):
" Download from:
" https://www.openoffice.org/lingucomponent/MyThes-1.zip
" (or get locally!)
" then
" let g:tq_openoffice_en_file="~/.config/nvim/thesaurus/MyThes-1.0/th_en_US_new"
" The one on my machine (found by locate):
"let g:tq_openoffice_en_file="/usr/share/mythes/th_en_US_v2"
"let g:tq_enabled_backends=['datamuse_com','openoffice_en','mthesaur_txt']
"let g:tq_language=['en']

"nn <silent><leader>th :ThesaurusQueryReplaceCurrentWord<CR>

" }}*

" *{{ Sets
se ml
se sms
se cul
syn on
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
se wop=pum
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
hi BoldHL gui=BOLD cterm=BOLD
hi LineNR ctermfg=240
hi Folded cterm=NONE ctermbg=235 ctermfg=3
hi TabLine cterm=NONE
hi TabLineFill cterm=NONE
" hi CursorLineNR cterm=BOLD ctermbg=187 ctermfg=240 " light
hi CursorLineNR cterm=BOLD ctermbg=235 ctermfg=240 " dark
hi CursorLine cterm=NONE ctermbg=235 " dark
" hi TabLineSel cterm=BOLD ctermfg=2 ctermbg=187 " light
hi TabLineSel cterm=BOLD ctermfg=2 ctermbg=235 " dark

hi GitGutterAdd cterm=BOLD ctermfg=2
hi GitGutterChange cterm=BOLD ctermfg=4
hi GitGutterDelete cterm=BOLD ctermfg=1

hi SpellBad cterm=underline ctermfg=NONE ctermbg=NONE
hi SpellCap cterm=underline ctermfg=NONE ctermbg=NONE
hi SpellRare cterm=underline ctermfg=NONE ctermbg=NONE
hi SpellLocal cterm=underline ctermfg=NONE ctermbg=NONE

hi TrailSpaces ctermbg=3
mat TrailSpaces /\s\{1}$/ " highlight only last space.

" Highlight any actual char beyond 80. Don't highlight when a char is next to
" line 81, but still on line 80.
hi CColumn ctermbg=1 ctermfg=0
cal matchadd('CColumn','\%81v.',100)

" }}*

" *{{ Auto Commands
" Return to cursor location
au BufReadPost * if line('''"') > 1 && line('''"') <= line("$") |
  \ exe 'norm! g`"' | en
" Open folds at cursor location (if folded)
au BufReadPost * if (foldlevel('.') > 0) | exe 'norm! za' | en

" New file netrw
au BufNewFile * :Lexplore
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 0
let g:netrw_browse_split = 3

" LaTeX
let g:tex_flavor = 'latex'
au FileType latex,tex,md,markdown setl spell spl=en_us tw=80

" git
au FileType gitcommit setl spell spl=en_us tw=80
" }}*

" *{{ Keymaps
nn : ;
nn ; :
nn vw viw
nn <Tab> >>
vn <Tab> >gv
nn <S-Tab> <<
vn <S-Tab> <gv
nn <space> za
ino () ()<Left>
ino [] []<Left>
ino {} {}<Left>
ino ... …
ino <> <><Left>
nn <leader>wp Vapgq
nn <leader>wl gqq
nn <leader>. dEi.<Esc>
nn <leader>s i<space><Esc>
nn <C-w>n :tabnew<CR>
nn <C-w>t :tab ter<CR>
nn <C-Left> :tabp<CR>
nn <C-Right> :tabn<CR>
ino {<CR> {<CR>}<Esc>ko<Tab>
ino <<CR> <<CR>><Esc>ko<Tab>
ino (<CR> (<CR>)<Esc>ko<Tab>
ino [<CR> [<CR>]<Esc>ko<Tab>
vn <C-r> "ry:%s/<C-r>r//gc<C-f>3h<C-c>
nn <leader>h :se hls! hls?<CR>:ec ' Toggled hls.'<CR>
nn <leader>p :se paste! paste?<CR>:ec ' Toggled paste.'<CR>
" Handy for re-formatting current paragraph with `column`.
nn <leader>ct Vap : !column -te \| sed '/^\#/ s/ \{1,\}/ /g'<CR>
no <silent><C-S> :update<CR>:ec ' Saved '''.expand('%:t').'''.'<CR>
" nn <leader>t :%s/\s\+$//e<CR>:ec ' Trimmed '''.expand('%:t').'''.'<CR>


fu! Float(key) abort
  " Whilst the cursor is on a character which matches the character the
  " function was initiated on, keep running an action. If land on a space,
  " keep running. Helpful for moving up/down indented regions.
  " WARNING: only use this on actions which can terminate... no maxiter or
  " check or anything. We currently only use it to float up/down a file.
  " let l:FC = 0
  let l:myChar = strcharpart(getline('.')[col('.') - 1:], 0, 1)
  wh strlen(getline('.')) < col('.') ||
    \ getline('.')[col('.') - 1] =~ l:myChar ||
    \ getline('.')[col('.') - 1] =~ ' '

    " Execute the key in normal mode.
    exe 'norm!' a:key
    " let FC = FC + 1

    " If at start/end of file, stop floating.
    if line('.') == 1
      echoh BoldHL | ec ' ⚠ Top of file: can''t float higher!' | echoh None
      brea
    elsei line('.') == line('$')
      echoh BoldHL | ec ' ⚠ End of file: can''t float lower!' | echoh None
      brea
    en

    " Don't enter a loop on closed folds...
    if foldclosed('.') > -1
      echoh BoldHL | ec ' ⚐ Not going into a fold.' | echoh None
      brea
    en

  endw

  " In principle, could echo the number of lines floated here.
  " Seems a little buggy - when screen redraws we can lose what is
  " printed in the info bar.

endf

" Map arrow keys explicitly: sometimes these sequences are missed.
map <Esc>[1;5D <C-Left>
map <Esc>[1;5C <C-Right>
map <Esc>[1;5A <C-Up>
map <Esc>[1;5B <C-Down>

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
  if fs < 0
    retu printf('-')
  elsei fs < 1.0e3
    retu printf('%ib',fs)
  elsei  fs < 1.0e6
    retu printf('%.1gk', 1.0e-3 * fs)
  el
    retu printf('%.1gm', 1.0e-6 * fs)
  en
endf

fu! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  retu l:counts.total == 0 ? '✓' :
  \ printf('%d⚠ %d⚐', all_errors, all_non_errors)
endf

fu! GitStatus()
  let [a, m, r] = GitGutterGetHunkSummary()
  let output = ''

  if a > 0
    let output .= '+' . a . ' '
  en

  if m > 0
    let output .= 'Δ' . m . ' '
  en

  if r > 0
    let output .= '-' . r . ' '
  en

  " Trim any trailing space
  let output = trim(output)

  retu output
endf

" hi StatusLine ctermbg=3 ctermfg=187 " light
hi StatusLine ctermbg=3 ctermfg=235 " dark
hi finfo cterm=NONE ctermbg=5 ctermfg=0
hi sinfo cterm=NONE ctermbg=6 ctermfg=0
hi cinfo cterm=NONE ctermbg=3 ctermfg=0
hi linfo cterm=NONE ctermbg=4 ctermfg=0
hi pinfo cterm=NONE ctermbg=2 ctermfg=0
hi ginfo cterm=NONE ctermbg=1 ctermfg=0
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
se stl+=%#ginfo#\%{GitStatus()}           " git info
" }}*

" *{{ Startup Splash

" *{{ StartMap
fun! StartMap(Map)
  if a:Map
    " 'map' => set Start mode mappings
    sil! setl ft=startup
      \ bh=wipe
      \ nobl
      \ nocuc
      \ nocul
      \ nonu
      \ nornu
      \ nosc
      \ nosmd
      \ syn=OFF
      \ t_ve=
      \ gcr=a:xxx
      \ ls=0
      "\ statusline=\ [RJH\ Startup\ Tool]

    nn <buffer><nowait><silent> i :enew <bar> startinsert<CR>
    nn <buffer><nowait><silent> e :enew <bar><CR>
    nn <buffer><nowait><silent> t :tabnew <bar> startinsert<CR>
    nn <buffer><nowait><silent> y :tabnew <bar><CR>
    nn <buffer><nowait><silent> q :exit<CR>

    hi CColumn NONE
    hi TrailSpaces NONE
  el
    " 'not map' => unmap
    sil! setl
      \ bh=
      \ bl
      \ cuc
      \ cul
      \ nu
      \ rnu
      \ sc
      \ smd
      \ syn=ON
      \ t_ve=[?12;25h
      \ gcr=
      \ ls=2

    " output of $(tput cvvis), counters $(tput civis)

    hi CColumn ctermbg=1 ctermfg=0
    hi TrailSpaces ctermbg=3
  en
endf

" }}*

" *{{ NotSplashing
fun! NotSplashing()
  " Don't run if:
  " - commandline arguments, or
  " - if start in insert mode, or
  " - non-empty buffer, or
  " - not invoked as vim or gvim
  retu
    \ argc()               ||
    \ &insertmode          ||
    \ line2byte('$') != -1 ||
    \ v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$'
endf
" }}*

" *{{ Splash
fun! Splash()

  if NotSplashing() | retu | en

  " Call buffer '[Startup]'; set ft; set maps
  edit [Startup]
  call StartMap(1)

  let l:splash =
    \ [
    \   '╔═════════════════════════════════╗',
    \   '║    ┏━┓╻ ╻┏━┓┏┓╻╻┏━┓   ╻ ╻╻┏┳┓   ║',
    \   '║    ┣┳┛┗┳┛┣━┫┃┗┫ ┗━┓   ┃┏┛┃┃┃┃   ║',
    \   '║    ╹┗╸ ╹ ╹ ╹╹ ╹ ┗━┛   ┗┛ ╹╹ ╹   ║',
    \   '╠═════════════════════════════════╣',
    \   '║   i) new buffer    insert mode  ║',
    \   '║   e) new buffer    normal mode  ║',
    \   '║   t) new tab buf   insert mode  ║',
    \   '║   y) new tab buf   normal mode  ║',
    \   '║   q) quit                       ║',
    \   '╚═════════════════════════════════╝'
    \ ]

  " Centre the box print.
  " Now we can just write to the buffer, whatever you want.

  let l:boxlwidth = len(l:splash)
  let l:boxhwidth = strdisplaywidth(l:splash[0])
  " command line, statusline offset vertical count(s).
  let l:boxloffset = (&lines - l:boxlwidth) / 2
  let l:boxhoffset = (&columns - l:boxhwidth) / 2

  let l:vtopbias = 4

  call append('$', repeat([' '], l:boxloffset - l:vtopbias))
  for line in l:splash
    call append('$', repeat(' ', l:boxhoffset) . l:line)
  endfor
  call append('$', repeat([' '], &lines - l:boxlwidth - l:vtopbias - 4))

  " Prevent modification(s).
  setl nomod noma

endf
" }}*

" On starts, call Splash().
au VimEnter * call Splash()

" On leaving the splash screen, reinstate globals.
au FileType startup au BufLeave * call StartMap(0)
" On return to the splash screen, reinstate buffer specifics.
au FileType startup au BufEnter <buffer> call StartMap(1)

" }}*

" *{{ Folding
se foldtext=FoldText()
fu! FoldText()
  let l:line = getline(v:foldstart)
  let l:sub = substitute(l:line, '" .{{[ ]*', '', 'g')
  let l:nlines = v:foldend - v:foldstart
  let l:indent = repeat(' ', 2 * (v:foldlevel - 1))
  retu $'{l:indent}~ [ {l:sub} ] ({l:nlines} lines) ' . repeat(' ', &columns)
endf
" }}*
