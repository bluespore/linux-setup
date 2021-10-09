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

	" Configure custom leader menus
	Plug 'dpretet/vim-leader-mapper'

	" Git
	Plug 'tpope/vim-fugitive'

	" Open file to last known line
	Plug 'farmergreg/vim-lastplace'

	" NERDTree
	Plug 'scrooloose/nerdtree'

	" Highlight files open in buffer, in NERDTree
	Plug 'PhilRunninger/nerdtree-buffer-ops'

	" Indicate git status of files in NERDTree
	Plug 'Xuyuanp/nerdtree-git-plugin'

  " Icons for files 
	Plug 'ryanoasis/vim-devicons'

  " Similar to Docblockr - Auto annotated comments
  Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

	" Syntax support
	Plug 'pangloss/vim-javascript'    " JavaScript support
	Plug 'leafgarland/typescript-vim' " TypeScript syntax
	Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
	Plug 'jparise/vim-graphql'        " GraphQL syntax

  " Prettier formatter 
  Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] 
  \ }

  " Embark colour scheme
  Plug 'embark-theme/vim', { 'as': 'embark' }

	" Airline for status
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

	" Highlight closing tags
  Plug 'leafOfTree/vim-matchtag'

	" Vertical blocks with alternating colours for tab indents
	Plug 'nathanaelkane/vim-indent-guides'

  Plug 'edkolev/tmuxline.vim'

	" CoC & plugins
	Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
	Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-git', { 'do': 'yarn install --frozen-lockfile' }
	Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-tslint', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'} " mru and stuff
	Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'} " color highlighting
	Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

" --------------------------------------------------------------
"  Theme
" --------------------------------------------------------------
syntax enable 
set encoding=UTF-8
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if (has("termguicolors"))
 set termguicolors
endif

" GH style syntax highlighting for codeblocks in markdown files
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
	au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
augroup END

" applying schemes 
colorscheme embark
let g:airline_theme = 'embark'

" airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#coc#enabled = 1
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}%{get(b:,'coc_git_blame','')}}

" remove background color on theme to use terminal theme bg / transparency
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
let g:vim_jsx_pretty_highlight_close_tag = 1
let g:import_sort_auto = 1

" --------------------------------------------------------------
"  Layout
" --------------------------------------------------------------
let g:NERDTreeIgnore = ['^node_modules$']
let NERDTreeShowHidden = 1
let g:NERDTreeWinPos = "right"

" fzf window tethered to base of screen, rather than floating
let g:fzf_layout = { 'down': '20' }
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 5
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" --------------------------------------------------------------
"  Leader key mappings
" --------------------------------------------------------------
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>

" file actions
let fMenu = {'name': 'File',
			\'f': [':Rg', 'rg project lines'],
			\'t': [':call NTToggle()', 'NERDTree'],
			\'h': [':History', 'fzf recent files'],
			\}

" buffer actions
let bMenu = {'name': 'Buffer',
			\'s': [":Buffer", 'fzf buffers'],
			\'l': [":BLines", 'fzf lines'],
			\'d': [":bd", 'Delete current'],
			\'c': ['%bdelete|edit #|normal `"', 'Close all but current']
			\}

" git actions
let gitMenu = {'name': 'Git',
			\'u': [':CocCommand git.copyUrl', 'url for line'],
			\'c': [':CocCommand git.showCommit', 'commit for line'],
			\}

" leader menu root
let g:leaderMenu = {'name': 'Global',
			\'1': [":source ~/.config/nvim/init.vim \| :PlugInstall", 'PlugInstall'],
			\'b': [bMenu, 'Buffer'],
			\'f': [fMenu, 'File'],
			\'G': [gitMenu, 'Git']
			\}

" ctrl p fuzzy search files that aren't git-ignored
nmap <C-P> :GFiles<CR>

" undo
nmap <C-Z> :undo<CR>

" redo
nmap <C-R> :redo<CR>

" DoGe (Document Generator)
nmap <S-C> :DogeGenerate<CR>

" --------------------------------------------------------------
"  General config
" --------------------------------------------------------------
set ai " enable auto indent
set autoread " reload files if changed externally 
set cursorline
set expandtab
set guifont="Fira Code"
set hidden " should allow buffer change with unsaved changes ('hides' it)
set history=999 " increase history levels from default of 20
set lz " lazy redraw
set mouse=a " enable mouse input everywhere
set norelativenumber
set number
set shiftwidth=2
set showmatch
set si " enable smart indent
set softtabstop=2
set sw=2 " spaces an auto indent creates 
set tabstop=2
set ts=2 " spaces a <Tab> creates
set ttyfast
set undodir=~/.cache/nvim/undofile
set undolevels=999 " increase undo levels from default of 100
set nobackup 
set nowritebackup
set noswapfile
set hlsearch " highlight searches
set ignorecase smartcase " searches are case-insensitive unless they include a capital letter

" https://stackoverflow.com/questions/2169645/vims-autocomplete-is-excruciatingly-slow
set complete-=i

" CoC extensions
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

" --------------------------------------------------------------
"  NERDTree functions
" --------------------------------------------------------------
"  open nt to the current buffer file or close it already open
function NTToggle()
    if &filetype == 'nerdtree' || exists("g:NERDTree") && g:NERDTree.IsOpen()
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

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
