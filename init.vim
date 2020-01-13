set nocompatible
" filetype off " required
filetype plugin on 
set mouse=a
" set number
" set relativenumber
set number relativenumber
" 开启高亮显示
syntax on
" 设置leader
let mapleader=","
set rtp+=~/.vim/bundle/Vundle.vim

" 高亮焦点
" set cursorcolumn
" set cursorline
" Max pattern match memory
set maxmempattern=5000
set lazyredraw
" set autoreaiC
set hlsearch
set showmode
" Code fold
set foldmethod=indent
set foldlevel=99
" Default tab width = 4 space
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
" backspace
set backspace=indent,eol,start " backspace over everything in insert mode
" time in milliseconds to wait for a mapped sequence to complete
set timeoutlen=700
" 共享系统剪贴板
set clipboard=unnamed
set encoding=UTF-8

" use ,w save file
nnoremap <leader> w :w <CR>
" 再次打开跳到上次编辑位置
if has("autocmd")                                                          
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif                                                        
endif 

call plug#begin('~/.config/nvim/plugged')

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Plug 'CodeFalling/fcitx-vim-osx'
" 设置自动语言
Plug 'VundleVim/Vundle.vim'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'rakr/vim-one'
Plug 'beikome/cosme.vim'
Plug 'KeitaNakamura/neodark.vim'

Plug 'kien/ctrlp.vim'
Plug 'Shougo/neocomplete.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'justinmk/vim-sneak'
Plug 'scrooloose/nerdcommenter'
" Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'sheerun/vim-polyglot'
" Plug 'vimwiki/vimwiki'
Plug 'jiangmiao/auto-pairs'
" 无干扰写作
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
" search status
" Plug 'osyo-manga/vim-anzu'
Plug 'joker1007/vim-markdown-quote-syntax'

" let g:deoplete#enable_at_startup = 1

Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'

Plug 'jiangmiao/auto-pairs'
" 缩进
Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['¦', '┆', '┊']
" 开始页面
Plug 'mhinz/vim-startify'
" Plug 'lyokha/vim-xkbswitch'
Plug 'brglng/vim-im-select'
"
Plug 'majutsushi/tagbar'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" nerdtree
Plug 'scrooloose/nerdtree'
" Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'  " display git status within Nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'Chiel92/vim-autoformat'
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'airblade/vim-rooter'
" Plug 'artur-shaik/vim-javacomplete2'
"
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" ============================================================================
" vim Markdown 配置
" ============================================================================
" 配置tagbar支持markdown
let g:tagbar_type_markdown = {
            \ 'ctagstype' : 'markdown',
            \ 'kinds' : [
            \ 'h:headings',
            \ ],
            \ 'sort' : 0
            \ }

nnoremap <leader>tb :TagbarToggle <CR>
nnoremap <leader>go :Goyo <CR>
let g:tagbar_width = 30
" let g:tagbar_left = 1
set conceallevel=1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" LimeLight 高亮 方便编辑
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" map <leader>md :InstantMarkdownPreview<CR>
nmap  <leader>md :MarkdownPreview <CR>
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_autowrite = 1
let g:mkdp_refresh_slow = 1

let g:mkdp_auto_close = 1

" nmap <silent> StopMarkdownPreview    " for normal mode
" ============================================================================
" FZF 配置
" ============================================================================

" 打开 fzf 的方式选择 floating window
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([60, &columns - 40])])
    let height = min([&lines - 4, max([15, &lines - 15])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

if has('nvim') || has('gui_running')
    " let $FZF_DEFAULT_OPTS .= ' --inline-info'
    let $FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
endif

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Hide statusline of terminal buffer
" autocmd! FileType fzf
" autocmd  FileType fzf set laststatus=0 noshowmode noruler
"             \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }


nnoremap <silent> <Leader>O       :Files<CR>
" nnoremap <silent> <Leader>F :Files  <CR>
" nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
" nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader>E        :Buffers<CR>
nnoremap <silent> <Leader>F        :Ag<CR>
nnoremap <silent> <Leader>L        :Lines<CR>

" 配合vim-rooter
" 自定义项目根目录在目录下面添加.vimroot
let g:rooter_patterns = ['.vimroot', '.git/', '.svn/']

augroup vimrc_rooter
    autocmd VimEnter * :Rooter
augroup END

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
            \ call fzf#vim#grep(
            \   'git grep --line-number '.shellescape(<q-args>), 0,
            \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

command! -bang Colors
            \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>,
            \                 <bang>0 ? fzf#vim#with_preview('up:60%')
            \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
            \                 <bang>0)

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)


" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

function! s:plug_help_sink(line)
    let dir = g:plugs[a:line].dir
    for pat in ['doc/*.txt', 'README.md']
        let match = get(split(globpath(dir, pat), "\n"), 0, '')
        if len(match)
            execute 'tabedit' match
            return
        endif
    endfor
    tabnew
    execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))

" filetype plugin indent on
" let g:airline_powerline_fonts = 1

map <c-n> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1

" ===========================================
" incsearch config 
" ===========================================
" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)


function! s:config_fuzzyall(...) abort
return extend(copy({
\   'converters': [
\     incsearch#config#fuzzy#converter(),
\     incsearch#config#fuzzyspell#converter()
\   ],
\ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> z/ incsearch#go(<SID>config_fuzzyall())
noremap <silent><expr> z? incsearch#go(<SID>config_fuzzyall({'command': '?'}))
noremap <silent><expr> zg? incsearch#go(<SID>config_fuzzyall({'is_stay': 1}))


" =======================================
" smooth-scroll
" =======================================
function SmoothScroll(up)
    if a:up
        let scrollaction="^Y"
    else
        let scrollaction="^E"
    endif
    exec "normal " . scrollaction
    redraw
    let counter=1
    while counter<&scroll
        let counter+=1
        sleep 10m
        redraw
        exec "normal " . scrollaction
    endwhile
endfunction
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 15, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 15, 2)<CR>
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
"高亮错误
let g:syntastic_enable_highlighting=1

" =======================================
" colorscheme
" =======================================
" set termguicolors
if has("termguicolors")
    " enable true color
    set termguicolors
endif

" colorscheme neodark
" let g:neodark#use_256color = 1 " default: 0
colorscheme one
let g:one_allow_italics = 1
set background=dark " for the dark version
" set background=light " for the light version
"
" colorscheme onedark
" syntax on
" let g:onedark_termcolors=16
" let g:onedark_hide_endofbuffer=1
" let g:onedark_terminal_italics=1
"
" =======================================
" 启动自动切换输入法
" =======================================
let g:XkbSwitchEnabled = 1
set iminsert=0
set imsearch=0

" ===================================
" vimviki
" ===================================

" let g:vimwiki_list = [{'path': '/Users/gaoguoxing/Nutstore\ Files/Wiki/','ext': '.md', 'syntax': 'markdown',
"             \ 'custom_wiki2html': 'vimwiki_markdown'}]

" let g:vimwiki_list = [{'path': '/Users/gaoguoxing/Nutstore\ Files/Wiki/'}]

" let g:vimwiki_list = [{'path': '/Users/gaoguoxing/Nutstore\ Files/Wiki/', 'template_path': '/Users/gaoguoxing/Nutstore\ Files/Wiki/',
"           \ 'template_default': 'default', 'syntax': 'markdown', 'ext': '.md',
"           \ 'path_html': '/Users/gaoguoxing/Nutstore\ Files/Wiki_html/', 'custom_wiki2html': 'vimwiki_markdown',
"           \ 'html_filename_parameterization': 1,
"           \ 'template_ext': '.tpl'}]

" let g:vimwiki_table_mappings = 0
" let g:vimwiki_global_ext = 0

" map <F6> :VimwikiAll2HTML <CR>

" ==================================
" startify 页面
" ==================================
"
let g:startify_custom_header = [
\'',
\'-------------------------------------------- ',
\'         / | / /___ ____\ \/ (_)___          ',
\'        /  |/ / __ \ / __ \  / / __ \        ',
\'       / /|  / /_/ / / / / / / / / /         ',
\'      /_/ |_/\__,_/_/ /_/_/_/_/ /_/          ',
\'-------------------------------------------- ',
\'',
\'「https://nanyiniu.space」',
\]


" ==================================
" easyMotion 快速移动
" s <char> <char>
" f <char>
" jk line motions
" ,w word
" ==================================
"
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" <Leader>f{char} to move to {char}
map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" " Move to word
" map  <Leader>w <Plug>(easymotion-bd-w)
" nmap <Leader>w <Plug>(easymotion-overwin-w)

noremap <f3> :Autoformat<CR>


" ==================================
" coc 默认设置
" ==================================
"
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
" set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
" set shortmess+=c

" always show signcolumns
" set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" Remap for format selected region
xmap <leader>l  <Plug>(coc-format-selected)
nmap <leader>l  <Plug>(coc-format-selected)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
"
" ==================================
" NerdTree 设置
" ==================================
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"设置树的显示图标
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"let g:NERDTreeShowLineNumbers=1  " 是否显示行号
let g:NERDTreeHidden=0     "不显示隐藏文件
"Making it prettier
let NERDTreeQuitOnOpen=1   " Close NERDtree when files was opened
" let NERDTreeMinimalUI=1    " Start NERDTree in minimal UI mode (No help lines)
let NERDTreeDirArrows=1    " Display arrows instead of ascii art in NERDTree
let NERDTreeChDirMode=2    " Change current working directory based on root directory in NERDTree

" ==================================
" ultiSnips 
" ==================================
"设置文件目录
" let g:UltiSnipsEditSplit="vertical"
" Trigger configuration. Do not use <tab> if you use
let g:UltiSnipsExpandTrigger='<tab>'
" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<tab>'
" shortcut to go to previous position
" let g:UltiSnipsJumpBackwardTrigger='<c-k>'
" let g:airline_theme='one'
"" === Lightline options ===
set laststatus=2
set noshowmode " turn off extra -- INSERT --

" Change colors to be darker for status bar and tab bar
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
 
