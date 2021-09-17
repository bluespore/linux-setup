set number
let mapleader = " "

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")

  " fzf fuzzy search implementation for vim
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Highlight hex codes and named colours
  Plug 'chrisbra/Colorizer'

  " Colour highlighting for matching open-close pairs
  Plug 'junegunn/rainbow_parentheses.vim'

  " Syntax highlighting for CSS in template literal strings
  Plug 'styled-components/vim-styled-components'

  " Easy multi-cursor edit 
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}

  " Syntax for Vue
  Plug 'leafoftree/vim-vue-plugin'

  " Icons for files 
	Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

  " Similar to Docblockr - Auto annotated comments
  Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
	Plug 'pangloss/vim-javascript'    " JavaScript support
	Plug 'leafgarland/typescript-vim' " TypeScript syntax
	Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
	Plug 'jparise/vim-graphql'        " GraphQL syntax

  " Prettier formatter 
  Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] 
  \ }

  " Color schemes
  "Plug 'sainnhe/sonokai'
  Plug 'embark-theme/vim', { 'as': 'embark' }

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

	Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
	Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-tslint', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'} " mru and stuff
	Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'} " color highlighting

call plug#end()

" --------------------------------------------------------------
"  Key binds
" --------------------------------------------------------------

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

" DoGe (Document Generator)
nmap <S-C> :DogeGenerate<CR>

" Open err list 
nmap <C-L> :lopen<CR><S-Tab>

" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>

" --------------------------------------------------------------
"  Theme
" --------------------------------------------------------------
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if (has("termguicolors"))
 set termguicolors
endif

set encoding=UTF-8

" GH style syntax highlighting for codeblocks in markdown files
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" applying schemes 
syntax enable 
colorscheme embark
let g:airline_theme = 'embark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" remove background color on theme
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! EndOfBuffer ctermbg=NONE guibg=NONE

" --------------------------------------------------------------
"  Formatting
" --------------------------------------------------------------
let g:prettier#autoformat = 1
let g:prettier#autoformat_config_present = 1
let g:prettier#quickfix_enabled = 0
autocmd BufWritePre *.js,*.jsx,*.vue,*.mjs,*.ts,*.tsx,*.css,*.json,*.html PrettierAsync

" --------------------------------------------------------------
"  Layout
" --------------------------------------------------------------
let g:NERDTreeIgnore = ['^node_modules$']
let NERDTreeShowHidden = 1
let g:NERDTreeWinPos = "right"
let g:fzf_layout = { 'down': '20' }

" --------------------------------------------------------------
"  General config
" --------------------------------------------------------------

set undodir=~/.cache/nvim/undofile
set norelativenumber
set lz " lazy redraw
set ai " enable auto indent
set si " enable smart indent
set ts=2 " spaces a <Tab> creates
set sw=2 " spaces an auto indent creates 
set guifont="Fira Code"
set cursorline
set mouse=a
set showmatch

" https://stackoverflow.com/questions/2169645/vims-autocomplete-is-excruciatingly-slow
set complete-=i

" CoC extensions
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

" Check if NERDTree is open or active
function! IsNTOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncNT()
  if &modifiable && IsNTOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncNT()
