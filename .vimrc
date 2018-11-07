set nocompatible " be iMproved, required
filetype off " required
set number
let mapleader=","
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'junegunn/fzf'
Plugin 'Shougo/neocomplete.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'justinmk/vim-sneak'
Plugin 'powerline/fonts'
Plugin 'scrooloose/nerdcommenter' 
Plugin 'suan/vim-instant-markdown'
call vundle#end()            " required
filetype plugin indent on
" let g:airline_powerline_fonts = 1
map <C-n> :NERDTreeToggle<CR>
" smooth-scroll
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
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 4)<CR>
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
"高亮错误
" let g:syntastic_enable_highlighting=1
" 快速选中
let g:expand_region_use_select_mode = 1
map w <Plug>(expand_region_expand)
map W <Plug>(expand_region_shrink)
" markdown setting
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_folding_disabled = 1
