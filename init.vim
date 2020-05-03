call plug#begin()
" themes
Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'

" deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" language client
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
\ }

" language
Plug 'dense-analysis/ale'
Plug 'google/vim-maktaba'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" build
Plug 'bazelbuild/vim-bazel'

" utils
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary' " gcc to comment out a line or gc to comment out section in visual mode
" Figure out Ag
" Plug 'rking/ag.vim'
call plug#end()

" set the numbers and relative line numbers
set number relativenumber
set nu rnu

set tabstop=2    " number of columns occupied by a tab character
set shiftwidth=2 " width for autoindents
set ignorecase   " case insensitive matching
set hlsearch     " highlight search results
set noshowmode   " remove the INSERT line to allow for lightline

set showmatch    " show matching brackets
syntax on        " syntax highlighting

set termguicolors " enable true colors support
colorscheme onedark  " sets the color

" depoplete 
let g:deoplete#enable_at_startup = 1

" language server
let g:LanguageClient_serverCommands = {
	\ 'go': ['gopls']
\ }

"Ale linters
let b:ale_linters = {
\	'javascript': ['flow-language-server'],
\}

" Ale Fixers
let g:ale_fixers = {'javascript': ['prettier', 'eslint']}

" Use ALE as completion sources for all code other than javascript
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})

" Don't allow Ale to lint any other time
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

" Always keep the gutter open
let g:ale_sign_column_always = 1

" Format the error message on the sightline
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Fixes files when you save them
let g:ale_fix_on_save = 1

" Lightline
let g:lightline = {
\ 'colorscheme': 'onedark',
\ }

" Commands

" go-to def mapped to ctrl-g
map <c-g> :ALEGoToDefinitionInVSplit<ENTER> 

" find references mapped to ctrl-f
map <c-f> :ALEFindReferences<ENTER> 

" fzf mapped to ctrl-p
map <c-p> :Files<ENTER> 

" open nerd tree with ctrl-e
map <c-e> :NERDTreeToggle<CR>

" Language Server mappings
nnoremap <leader>l :call LanguageClient_contextMenu()<CR>
nnoremap K :call LanguageClient#textDocument_hover()<CR>
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

