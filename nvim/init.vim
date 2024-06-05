" {{{ vim plug

let mapleader = " "
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif
" vim plug es un package manager esencialmente
call plug#begin('~/.vim/plugged')
Plug 'plasticboy/vim-markdown'
Plug 'kshenoy/vim-signature'
Plug 'lilydjwg/colorizer'
Plug 'chrisbra/csv.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ferrine/md-img-paste.vim', {'for':['md','wiki','R']}
Plug 'vim-python/python-syntax'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
Plug 'sirver/ultisnips'
Plug 'lervag/vimtex'
Plug 'lervag/lists.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'tpope/vim-fugitive'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp', { 'do': 'pip install -r requirements.txt' }
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'jpalardy/vim-slime', { 'for': ['python','r','rmd']}
Plug 'ttdduu/vim-ipython-cell', { 'for': 'python' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'szw/vim-maximizer'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'lervag/wiki.vim', {'commit': '96bb3c921d369df3e089ff6af677b53fe8146166'}
"Plug 'lervag/wiki-ft.vim', {'commit': '5d3624c1c88758a1db49b7b86ff930c54c6b2e42'}
Plug 'ttdduu/wiki-ft.vim'
Plug 'ttdduu/wiki.vim'
Plug 'dyng/ctrlsf.vim' " para usar con ripgrep en wiki.vim
Plug 'rbgrouleff/bclose.vim'
Plug 'vifm/vifm.vim'
Plug 'gcmt/taboo.vim'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'gennaro-tedesco/nvim-peekup'
call plug#end()

" }}}

" {{{ Function to set the foldtext

function! MyFoldText()
    let line = getline(v:foldstart)
	let name = substitute(line, '\(.*\)', '\1', '')
    return name
endfunction

" }}}

" {{{ basic set

	set foldtext=MyFoldText()
	set autochdir
	set foldmethod=marker
	set shellcmdflag=-ic " shell interactiva xaq me lea los alias
	colorscheme nord
	set termguicolors " No tener colores chotos
	set bg=dark
	set nocompatible
	filetype plugin on
	filetype plugin indent on
	syntax on
	set encoding=utf-8
	set number relativenumber
	set foldlevel=0
	"set nohlsearch
	set path +=**
	set mouse=a
	set tabstop=4
	set shiftwidth=4
	set gdefault
	set inccommand=nosplit
	let g:netrw_dirhistmax = 0
	set splitbelow splitright
	set linebreak
	set pumblend=40
	set cursorline
	set clipboard+=unnamedplus
    set wildignore=*.o,*~,*.pyc
    set ignorecase
    set smartcase
	set noshowmode
	se go=a
	set wrap
	set shell=/usr/bin/zsh
	"set shell=/usr/bin/bash

" }}}

" {{{ Relevant config

" Return to last edit position when opening files
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  autocmd TermOpen * setlocal nonumber norelativenumber

" set n lines to the cursor n=7
  "set so=2

" Automatically deletes all trailing whitespace on save.
  autocmd BufWritePre * %s/\s\+$//e

  " Set undodir persist
  if !isdirectory("/tmp/undo-dir")
    call mkdir("/tmp/undo-dir", "", 0700)
  endif
  set undodir=/tmp/.vim-undo-dir
  set undofile

"cada vez que guardo con vim se actualiza el soruceo de X
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"}}}

" {{{ general mappings


" yankear un [[bla.pdf]] en algún texto tipo .wiki y abrir un bla.wiki
nmap <c-a> f]?pdf<esc>hyT[ll:tabnew <C-R>".wiki<cr>
nmap . /
nmap ñ .<cr>
nmap Ñ N
" yankear link con corchetes para pdfs con anki_to_source, con n de no pierdas más tiempo forro
nmap n f]F[hvt]lly<esc><esc>

nmap <leader>v :so $MYVIMRC<CR>
nmap <leader>a :above split<cr><c-j>
nmap Y 0y$
nmap <leader>fv :Vifm<cr>
nmap yw F<space>yf<space>

vmap <leader>s y<esc><esc><c-j><esc>pa<cr><cr>
map $ g_
vmap * c*<c-r>"*<esc>
nmap * 0vg_*
vmap _ c_<c-r>"_<esc>
vmap ` c`<c-r>"`<esc>
nmap _ 0vg__
nmap C 0vg_`<esc>

imap <c-s> σ2
imap <c-b> β
imap <c-e> ε
imap <c-u> μ
imap <c-a> α
imap <c-d> δ
cmap <c-s> σ2
cmap <c-b> β
cmap <c-e> ε
cmap <c-u> μ
cmap <c-a> α
cmap <c-d> δ

command! Curr mks! $HOME/currently.session


" }}}

" {{{ buffers y tabs
nmap ,j :bnext<cr>
nmap ,k :bprevious<cr>
nmap ,b :ls<CR>:b<Space>
" del plugin bclose.vim
nmap ,d <leader>bd
" Map :wqa to :wa|qa
command! -nargs=0 W wa|qa
command! -nargs=0 T sp|terminal

nmap tr :TabooRename<space>
nmap tn :tabnew<cr>,dtr
"nmap gz f]F[lyt\|tn<esc>:e <C-R>"<CR>
nnoremap gn f]F[lyt\|:tabnew <C-R>"<cr>
nmap \| :tabnext<cr>
nmap tc :tabclose<cr>
nmap 1\| :tabprevious<cr>
nmap t<cr> <plug>(wiki-link-follow-tab)tr
" Go to tab by number
noremap t1 1gt
noremap t2 2gt
noremap t3 3gt
noremap t4 4gt
noremap t5 5gt
noremap t6 6gt
noremap t7 7gt
noremap t8 8gt
noremap t9 9gt

nmap gv f]F[lyt\|:!vlc <C-R>"\|st sw & <CR><CR>
" }}}

" {{{ CtrlSF usado con wiki.vim xa buscar texto dentro de file
nmap <leader>fs <Plug>CtrlSFPrompt
function! g:CtrlSFAfterMainWindowInit()
    setl wrap
endfunction
nmap <leader>ff :CtrlSFToggle<CR>
let g:ctrlsf_mapping = {"open":"","split":"<CR>"}

""}}}

" {{{ ultisnips

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/my-snippets/UltiSnips']
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
"}}}

" {{{ Ale linting con flake8

let g:ale_sign_column_always=1
let g:ale_lint_on_enter=1
let g:ale_lint_on_text_changed='always'
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_format='[%linter%] %s [%severity%]: [%...code...%]'
let g:ale_linters={'python': ['flake8'], 'r': ['lintr']}
let g:ale_fixers={'python': ['black']}
"}}}

" {{{ vim-fugitive

nmap <leader>gg :term git status<CR>
nmap <leader>ga :G add %<CR>
nmap <leader>gA :G add -A<CR>
nmap <leader>gcm :G commit<CR>

"nmap <leader>gp :G push origin HEAD<CR>
function! GetFirstRemote()
    let remotes = systemlist('git remote')
	return remotes[0]
endfunction
command! -nargs=0 GitPushFirstRemote :execute 'Git push '.GetFirstRemote().' HEAD'
nmap <leader>gp :GitPushFirstRemote<CR>

" git branch checkout:
nmap <leader>gch :G checkout
" generar nueva branch e ir a ella
nmap <leader>gm :G merge
" log y graph son terminals que las saco con ,d. es mejor esto que que sea un scratch buffer porque acá puedo navegar line by line y yankear un hash
nmap <leader>gl :term git log --name-status<cr>
nmap <leader>gG :term git graph<cr>
nmap <leader>gcb :G checkout -b
" generar la git branch description
nmap <leader>gbD :G branch --edit-description<cr>
" dame la git branch description con alias de zsh que overridea el del plugin de git de ohmy (hay que comentarlo en .ohmy):
nmap <leader>gbd :!gbd<cr>
" }}}

" {{{ ncm2

"let g:python3_host_prog='/home/ttdduu/miniconda3/envs/pytom/bin/python'            " ncm2-jedi
let g:python3_host_prog='/home/ttdduu/miniconda3/envs/pytom-sioyek/bin/python'            " ncm2-jedi
"autocmd filetype python BufEnter * call ncm2#enable_for_buffer()      " enable ncm2 for all buffers
set completeopt=noinsert,menuone,noselect             " IMPORTANT: :help Ncm2PopupOpen for more information
"" para no tener que escribir 3 caracteres antes de que aparezca el autocomplete. esto a su vez renders useless la utilizacion de wiki.vim del omnicomplete.
"let g:ncm2#complete_length=[[1,3],[7,2]]

set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:ncm2#auto_popup=0
inoremap <C-space> <c-r>=ncm2#manual_trigger()<cr>
let g:ncm2#manual_complete_length=2
" }}}

" {{{ navegación y resizing windows y terminal

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-j> <esc><C-j>
" resizing gradual
noremap <silent> <leader>- :resize -3<CR>
noremap <silent> <leader>+ :resize +3<CR>

" Change 2 split windows from vert to horiz or horiz to vert
map <Leader>h <C-w>t<C-w>H
map <Leader>k <C-w>t<C-w>K

" }}}

" {{{ markdown

autocmd FileType markdown nmap <buffer> <Leader><Leader><CR> :! pandoc % -o %:r.pdf; okular --fork %:r.pdf<CR><CR>
autocmd FileType markdown nmap <buffer> <Leader><CR> :w<CR>
autocmd FileType markdown,wiki nmap <buffer><silent> <Leader>p :call mdip#MarkdownClipboardImage()<CR>

"}}}

" {{{ python + terminal


autocmd filetype python,R set colorcolumn=89
autocmd filetype python,R set textwidth=88
autocmd filetype python,R nmap # gqj
" abrir nueva term split
"autocmd filetype python map <Leader>P :new term://zsh<CR>iipython3 --matplotlib<CR><C-\><C-n><C-w>k"<CR>
"autocmd filetype python map <Leader>P :new term://ipython3 --matplotlib<CR><C-\><C-n><C-w>k"<CR>

" 2024 agrego que me tome el mismo env con el que abro el .py a partir del cual abro ipython. imp xq otherwise por default me abre zsh con pytom o el env que sea default.
autocmd filetype python map <Leader>P :let @e = $CONDA_PREFIX\|:new term://zsh<CR>:sleep800ms<cr>iconda activate <esc>"epi && ipython --matplotlib<cr>


" navegación
autocmd filetype python nnoremap <C-j> <C-w>j <c-w>=
tmap <C-h> <esc><C-h>
tmap <C-k> <esc><C-k>
tnoremap <esc> <c-\><c-n>
nmap <c-w><c-l> :set scrollback=1 \| sleep 100m \| set scrollback=10000<CR>
tmap <c-w><c-l> <c-\><c-n><c-w><c-l>i<c-l>

" maximizar o poner mitad-mitad
map <Leader>m :MaximizerToggle<CR>
map <Leader>0 <C-w>=<esc>

" lead-enter
autocmd Filetype python nmap <buffer> <Leader><CR> :update<bar>!python3 %<CR>
"dato: esto de aca arriba genera el mismo resultado que esto:
"nmap <Leader><CR> :w<CR>:!python3 %<CR>

" lead-lead-enter
autocmd FileType python nmap <buffer> <Leader><Leader><CR> :update<bar>vs<Space>\|<Space>terminal ipython -i -c "\%run %"<CR>\|:let t:term_id = b:terminal_job_id<CR>\|:execute 'let b:slime_config = {"jobid": "'.t:term_id . '"}'<CR>i

" slime + ipython cells

let g:ipython_cell_send_cell_headers = 1
let g:slime_target = 'neovim' " con solo esta linea slime anda bien con binds default.
" let g:slime_dont_ask_default = 1 si agrego esto tira error
let g:slime_no_mappings = 1
nmap <c-c>v     <Plug>SlimeConfig
"el segundo CR es para hacer enter luego de que me pregunte por el job id
autocmd filetype python nmap <Leader><Leader>r <esc><C-k> :IPythonCellRun<CR><CR>
autocmd filetype python nmap <Leader>r :IPythonCellExecuteCell<CR><CR><c-j>G<c-k>
let g:ipython_cell_tag = ['##']

augroup ipython_cell_highlight
    autocmd!
	autocmd filetype python highlight IPythonCell cterm=bold guifg=Black guibg=white
augroup END

autocmd filetype python,r command! H normal! 0y$?{{{<cr>$a<space><esc>p
" }}}
" }}}

" {{{ airline

function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode','branch'])
  let g:airline_section_c = airline#section#create(['path'])
  "let g:airline_section_x = airline#section#create([system('source /home/ttdduu/code/misc/env')])
  let g:airline#extensions#default#layout = [ [ 'a', 'b', 'c'], [ 'error', 'warning' ] ]
endfunction

call AirlineInit() " Call the function immediately when sourcing the init file

" }}}

" {{{ R

autocmd BufEnter *r,*rmd nnoremap <leader>R :above split<cr>:term R<cr> <c-w>r<c-w>k
autocmd BufEnter *r,*rmd nnoremap <leader>r V<Plug>SlimeRegionSend<CR><c-w>ja<esc><c-k>
autocmd BufEnter *r,*rmd vmap <leader>r <Plug>SlimeRegionSend<CR><c-w>ja<esc><c-k>

autocmd filetype r,rmd nnoremap <leader>R :above split<cr>:term R<cr> <c-w>r<c-w>k
autocmd filetype r,rmd nnoremap <leader>r V<Plug>SlimeRegionSend<CR><c-w>ja<esc><c-k>
autocmd filetype r,rmd vmap <leader>r <Plug>SlimeRegionSend<CR><c-w>ja

" }}}

" {{{ wiki.vim

let g:wiki_filetypes = ['wiki', 'md']
let g:wiki_link_extension = '.wiki'
let g:wiki_link_target_type = 'wiki'
autocmd filetype wiki setlocal wrap
autocmd filetype wiki let wiki_export['output'] = $PWD

" {{{ mappings

autocmd filetype wiki nmap <s-tab> <plug>(wiki-link-prev)
autocmd FileType wiki imap <S-tab> <esc>Ea<space>
nmap <leader>E :WikiExport<cr>\| sleep 120m \| u\| :!dropbox start<cr><cr>

" go link: para cuando quiero ir a sección de misma page en wiki pero esa sección es > 6
autocmd filetype wiki nmap gl f]F~lyt].#<C-R>"<esc>:noh<cr>

"autocmd filetype wiki nmap <leader>wp <leader>wp:wq<cr>
" resumen de estos yanks: estoy en un link. ese link es de un TOC. si quiero llevar ese link a anki hago yk --> controlV en anki. si quiero llevar ese link a otro file en la misma wiki hago yr (relative ponele) --> fsp en el otro file. si quiero agarrar este link de toc para usarlo para referenciar esa sección, hago yl --> "lp

" yank filename del archivo en el que estoy (tipo teorica.wiki) al register f
noremap <silent> yf :let @f=expand("%:t")<CR>
" yank header (solo el header actual, no todo desde el 1er header, al register normal
autocmd filetype wiki nmap yh $F#y$gg/<C-R>"<CR>
" dentro de un [[teorica.wiki#seccion1#seccion1.1|teorica]], yank link al register l --> teorica.wiki#seccion1#seccion1.1
autocmd filetype wiki nmap yl f]F[lvt\|"ly<esc><esc>f\|


autocmd filetype wiki nmap yH $F#y$

" anki: estoy en una seccion de un buffer, hice yh y llegué a un link del TOC, estoy sobre el link [[#seccion1#seccion1.1|blabla]]
" yankeo el path completo tipo /home/tdu.../teorica.wiki y lo guardo en reg p
noremap yp :let @p = expand('%:p')<CR>:<esc>
" defino que en el clipboard normal se guarde /home/tdu/wiki/teorica.wiki#seccion1#seccion1.1
noremap +k :let @+ = @p.@l<CR>:<esc>
" ejecuto los dos yanks y guardo todo en en clipboard normal
nmap yk ylyp+k

" para linkear a file dentro de una wiki (paths relativos, no absolutos como en anki)
" en el TOC de teorica.wiki me paro en [[#seccion1#seccion1.1|blabla]] y hago yr --> tengo teorica.wiki en reg f y #seccion1#seccion1.1 en reg l.
nmap yn yfyl
nmap yr f]F/lyt.
" file section paste --> pego lo de un register y luego lo del otro: teorica.wiki#seccion1#seccion1.1
" nmap fsp "fp"lp
nmap fsp i[[<esc>"fp"lp]]<c-o>

" desde un quote en la wiki de un pdf a ese mismo pdf en sioyek
nnoremap N Y:let @+ = @+.expand('\ ').expand('%:p')<CR>:<esc>
" i[[<Esc>"xp]]

nmap <leader>wfp <plug>(wiki-fzf-pages)
let g:wiki_fzf_pages_opts = '--preview "cat {1}"'


nnoremap gs :let w1_bufnr = bufnr('%')<bar>let w1_pos = getpos('.')<bar>wincmd w<bar>execute 'buffer '.w1_bufnr<bar>call setpos('.', w1_pos)<bar>wincmd p<bar>execute 'normal! zz'<CR>:wincmd w<CR><CR>zR


" Mapping to jump to the next header
autocmd filetype wiki nnoremap L :call search('^#', 'W')<CR>

" Mapping to jump to the previous header
autocmd filetype wiki nnoremap K :call search('^#', 'bW')<CR>

" VBox {{{
"autocmd FileType wiki vmap b :VBox<cr>
"autocmd FileType wiki nmap Bb :set ve=all<cr>
"nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
" }}}
" }}}

" {{{ create page

"let g:wiki_map_create_page = 'MyFunction'

function MyFunction(name) abort
  let l:name = wiki#get_root() . '/' . a:name

  " If the file is new, then append the current date
  return filereadable(l:name)
        "\ ? a:name
        "\ : a:name . '_' . strftime('%Y%m%d%H%M%S')
		"return [strftime('%A-%d-%m-%Y-%H%M%S') . '_' . a:name, a:name]
endfunction
" }}}

" {{{ text to link
" esto viene de una modicicación que le hice a este comment de lervag: https://github.com/lervag/wiki.vim/issues/240#issuecomment-1195354202
let g:wiki_map_text_to_link = 'MyTextToLink'
function MyTextToLink(text) abort
  return [strftime('%Y-%m-%d-%A-%H%M%S') . '_' . a:text, a:text]
endfunction


let g:wiki_file_handler = 'WikiFileHandler'
function! WikiFileHandler(...) abort dict
  if self.path =~# 'png$'
	silent execute '!sxiv' fnameescape(self.path) '&'
	return 1
  endif
  return 0
endfunction

" }}}

" {{{ omnicomplete
"esto es copiado de wiki.vim. es para usar omnicomplete de links luego de [[. lo que tiene es que te hace omnicomplete desde el working dir hacia abajo, pero no viceversa hasta el index.wiki. entonces la unica ventjaa que tiene respecto de ncm2-path es lo primero que hace, dado que ncm2 solo se fija en el wd.
augroup my_cm_setup
autocmd!
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd User WikiBufferInitialized call ncm2#register_source({
		\ 'name': 'wiki',
		\ 'priority': 9,
		\ 'scope': ['wiki'],
		\ 'word_pattern': '\w+',
		\ 'complete_pattern': '\[\[',
		\ 'on_complete': ['ncm2#on_complete#delay', 200,
		\                 'ncm2#on_complete#omni',
		\                 'wiki#complete#omnicomplete'],
		\})
augroup END
" }}}

" }}}

" {{{ todo lists


autocmd FileType wiki,python ListsEnable

"let g:lists_todos = [strftime('(%d-%m-%y) ') . 'TODO', strftime('(%d-%m-%y) ') . 'CURRENTLY', strftime('(%d-%m-%y) ') . 'NEXT',strftime('(%d-%m-%y) ') . 'STANDBY', strftime('(%d-%m-%y) ') . 'RETOMAR EN', strftime('(%d-%m-%y) ') . 'DONE']

let g:lists_todos = ['TODO', 'CURRENTLY', 'DONE','NEXT','STANDBY']

let g:lists_maps_default_override = {'<plug>(lists-toggle)': '<leader>l'}

" {{{ chat me dio UpdateDate
"nnoremap <leader>D :call UpdateDate()<CR>

"function! UpdateDate()
  "let today = strftime("%d-%m-%y")
  "let line = getline('.')
  "let date_regex = '\d\{2}-\d\{2}-\d\{2}'
  "let new_line = substitute(line, date_regex, today, '')
  "if new_line != line
    "call setline('.', new_line)
  "endif
"endfunction

"" }}}
"nmap <leader>l <leader>D<leader>L

"nmap <leader>d "=strftime('(%d-%m-%y)')<CR>p

" }}}

" {{{ Vimtex
" let g:vimtex_compiler_latexmk_engines = {'pdflatex': '-pdf'}
let g:vimtex_compiler_latexmk_engines = {'latexmk': '-pdf'}
let g:tex_flavor = "latex"
let g:vimtex_view_method='sioyek'
let g:vimtex_quickfix_mode=1

" Visible code only when hover
set conceallevel=1
let g:tex_conceal='abdmg'
hi clear Conceal


augroup vimtex_config
    au!
    au User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END
" autocmd FileType tex nmap <buffer> <Leader><CR> :w<CR>
autocmd FileType tex nmap <buffer> <Leader><Leader><CR> :update<bar>:VimtexCompile<CR>


"}}}

map s <Plug>(easymotion-s)
autocmd FileType csv nmap <buffer> <Leader><Leader> :Tabularize /,<CR>
"let g:csv_autocmd_arrange = 1
"let g:csv_autocmd_arrange_size = 1024*1024


" vim-markdown para latex
" lo de tex no se paque sirve
"let g:tex_conceal = ""
let g:vim_markdown_math = 1

"algo que le gusta a lervag
let g:vim_markdown_conceal = 2

" keyword highlights {{{

highlight MyGroupTODO ctermbg=LightRed guibg=LightRed ctermfg=black guifg=black
autocmd VimEnter * autocmd WinEnter * let m1 = matchadd("MyGroupTODO", "TODO")
let m1 = matchadd("MyGroupTODO", "TODO")

highlight MyGroupCURR ctermbg=cyan guibg=cyan ctermfg=black guifg=black
autocmd VimEnter * autocmd WinEnter * let m2 = matchadd("MyGroupCURR", "CURRENTLY")
let m2 = matchadd("MyGroupCURR", "CURRENTLY")

highlight MyGroupSBY ctermbg=magenta guibg=magenta ctermfg=black guifg=black
autocmd VimEnter * autocmd WinEnter * let m3 = matchadd("MyGroupSBY", "STANDBY")
let m3 = matchadd("MyGroupSBY", "STANDBY")

highlight MyGroupIMP ctermbg=red guibg=red ctermfg=white guifg=white
autocmd VimEnter * autocmd WinEnter * let m4 = matchadd("MyGroupIMP", "IMP")
let m4 = matchadd("MyGroupIMP", "IMP")

highlight MyGroupDONE ctermbg=LightGreen guibg=LightGreen ctermfg=black guifg=black
autocmd VimEnter * autocmd WinEnter * let m5 = matchadd("MyGroupDONE", "DONE")
let m5 = matchadd("MyGroupDONE", "DONE")

highlight MyGroupREVISAR ctermbg=Yellow guibg=Yellow ctermfg=black guifg=black
autocmd VimEnter * autocmd WinEnter * let m7 = matchadd("MyGroupREVISAR", "REVISAR")
let m7 = matchadd("MyGroupREVISAR", "REVISAR")

highlight MyGroupVER ctermbg=Yellow guibg=Yellow ctermfg=black guifg=black
autocmd VimEnter * autocmd WinEnter * let m6 = matchadd("MyGroupVER", "VER")
let m6 = matchadd("MyGroupVER", "VER")

highlight MyGroupRESULT ctermbg=LightGreen guibg=LightGreen ctermfg=black guifg=black
autocmd VimEnter * autocmd WinEnter * let m9 = matchadd("MyGroupRESULT", "RESULT")
let m9 = matchadd("MyGroupRESULT", "RESULT")

highlight MyGroupflechita ctermfg=yellow guifg=yellow
autocmd VimEnter * autocmd WinEnter * let m8 = matchadd("MyGroupflechita", "-->")
let m8 = matchadd("MyGroupflechita", "-->")

" }}}


function! SearchYankedContent()
    " Get yanked content
    let yanked_content = getreg('"')

    " Split yanked content into file path and the rest
    let first_space = stridx(yanked_content, ' ')
    let file_path = strpart(yanked_content, 0, first_space)
    let rest = strpart(yanked_content, first_space + 1)

    " Open the file
    execute "edit " . file_path

    " If there's a search pattern, perform the search
    if len(rest) > 0
        let search_pattern = escape(rest, '/')
        execute "normal :exe '/" . search_pattern . "'\<CR>"
        " Set cursor at the start of the search result
        normal n
    endif
endfunction

augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
  "autocmd BufWritePre *.py execute ':!black --preview %'
augroup end




autocmd filetype r,python nmap <tab> /[[<cr>:noh<cr>

autocmd filetype python set wrap!


lua require('nvim-peekup.config').on_keystroke["paste_reg"] = '+'
lua require('nvim-peekup.config').on_keystroke["delay"] = ''


function! MySubstitution()
    " Substitute [' with nothing
    "%s/\[//

    " Substitute ' with nothing
    "%s/]//
    "%s/'//

	%s/   /,/
    " Substitute three spaces with nothing
    "%s/ //

	%s/--undefined--/nan/
endfunction

nmap yp :let @+ = expand('%:p')<cr>
nmap < V<
nmap > V>
"autocmd filetype python,r command! Ww execute 'w' | normal! gqj
" Remap :w to our custom :W command
"autocmd filetype python,r cnoreabbrev w Ww<esc>

nnoremap -- :vertical resize -10<cr>
nnoremap ++ :vertical resize +10<cr>

