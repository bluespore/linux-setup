"=============================================================================
" init.vim --- Entry file for neovim
" Copyright (c) 2016-2020 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg@outlook.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

" Load space vim setup
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/main.vim'

" Enable automatic plugin management with vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ========================================
" Define plugins
" ========================================

call plug#begin('~/.SpaceVim/bundle')
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhartington/nvim-typescript', { 'build': './install.sh' }
Plug 'majutsushi/tagbar'
Plug 'chrisbra/Colorizer'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'styled-components/vim-styled-components'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'leafoftree/vim-vue-plugin'
" Plug 'sbdchd/neoformat'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
" Plug 'alvan/vim-closetag'
" Color schemes
Plug 'haishanh/night-owl.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'KeitaNakamura/neodark.vim'
Plug 'zeis/vim-kolor'
call plug#end()

set nonu nornu " disable relative numbering
set ai " enable auto indent
set si " enable smart indent
set ts=4 " spaces a <Tab> creates
set sw=4 " spaces an auto indent creates 
set cc=80 " render vertical rule N columns in
" set cursorcolumn
" set cursorline
set guifont="JetBrains Mono"

" ========================================
" Key remapping
" ========================================

" ctrl+p fzf files, not gitignored
nmap <C-P> :GFiles<CR>
" ctrl+shift+f fzf project files, for search term
nmap <C-d> :Rg<CR>
" ctrl+f fzf lines in current file
nmap <C-F> :BLines<CR>
" ctrl+h fzf recent files
nmap <C-H> :History<CR>
" undo
nmap <C-Z> :undo<CR>
" redo
nmap <C-R> :redo<CR>
" search open buffers
nmap <C-B> :Buffer<CR>
" ========================================
" Color preferences
" ========================================

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"let g:neodark#use_256color = 1
"let g:neodark#background = '#21252f'

" GH style syntax highlighting for codeblocks in markdown files
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Set the default load color scheme
syntax enable
colorscheme night-owl

" Remove background color on theme
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! EndOfBuffer ctermbg=NONE guibg=NONE

" Ensure Prettier runs on save
" autocmd BufWritePre *.js Neoformat

let g:prettier#autoformat = 1
let g:prettier#autoformat_config_present = 1
let g:prettier#quickfix_enabled = 0
autocmd TextChanged,InsertLeave *.js,*.jsx,*.vue,*.mjs,*.ts,*.tsx,*.css,*.json,*.html PrettierAsync
