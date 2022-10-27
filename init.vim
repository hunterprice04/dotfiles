:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

" ###################################################################
" COMMON COMMANDS
" :PlugInstall		Installs Plugins
" :PlugClean		Removes Unused Plugins
" Cntr-f			Focus on FileTree
" Cntr-t			Toggle FileTree
" Cntr-n
" gcc				comment line
" gc				while highlighting lines will comment out selection
" gcp				comment out paragraph
"

" ###################################################################
" FUTURE PLUGINS
" https://github.com/rockerBOO/awesome-neovim - big list of plugins
" https://github.com/kevinhwang91/nvim-ufo
"

" ###################################################################
" PLUGIN INSTALLS
" plugged directory -> /home/hp/.local/share/nvim/plugged/
call plug#begin()
	
	" GUI
	Plug 'vim-airline/vim-airline' " Status Bar
	Plug 'preservim/nerdtree' " File Tree
	Plug 'vim-airline/vim-airline-themes' " Status Bar Themes
	Plug 'ap/vim-css-color' " CSS Color Preview
	Plug 'rafi/awesome-vim-colorschemes' " Retro Scheme
	Plug 'ryanoasis/vim-devicons' " Developer Icons
	Plug 'preservim/tagbar' " Tagbar for code navigation
	
	" AUTO COMPLETE
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " Auto Completion
	Plug 'github/copilot.vim' " Copilot because why not
	
	" FUZZY SEARCH
	Plug 'nvim-lua/plenary.nvim' " Required for telescope
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } " Fuzzy Finder
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
	
	" UTILTIY PLUGINS
	Plug 'tpope/vim-surround' " Surrounding ysw)
	Plug 'tpope/vim-commentary' " For Commenting gcc & gc
	Plug 'mg979/vim-visual-multi', {'branch': 'master'} " CTRL + N for multiple cursors
	Plug 'jghauser/mkdir.nvim' " Create Directory similar to mkdir -p
	Plug 'matbme/JABS.nvim' " minimal buffer switcher
	Plug 'sudormrfbin/cheatsheet.nvim' " cheatsheet for nvim
	Plug 'stevearc/dressing.nvim' " 
	Plug 'ggandor/lightspeed.nvim' " quickly moving around
	Plug 'tpope/vim-repeat' " repeat plugin with .
	Plug 'cappyzawa/trim.nvim' " trim trailing whitespace
	Plug 'sindrets/winshift.nvim' " Moving windows around

	" MARKDOWN/LATEX
	Plug 'ellisonleao/glow.nvim' " Markdown Preview
	Plug 'lervag/vimtex' " Vim Latex
	"	Plug 'sheerun/vim-polyglot'
	if has('nvim')
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/deoplete.nvim'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif

	set encoding=UTF-8

call plug#end()

" ###################################################################

" COPILOT
imap <silent> <C-j> <Plug>(copilot-next)
imap <silent> <C-k> <Plug>(copilot-previous)

" ###################################################################

" TAGBAR
nmap <F8> :TagbarToggle<CR>
:set completeopt-=preview " For No Previews

" ###################################################################

" COLORSCHEME
:colorscheme deus


" ###################################################################

" TELESCOPE
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ###################################################################

" NERD TREE
nnoremap <C-f> :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ###################################################################
" AIRLINE

" Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1

" Path formatter
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

let g:airline_theme='deus'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" ###################################################################
" VimTeX

" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

let g:tex_flavor = "latex"

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexrun'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","
nmap <localleader>v <plug>(vimtex-view)
"let g:polyglot_disabled = ['latex']

call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" ###################################################################
" WIN-MOVE

" Start Win-Move mode:
nnoremap <C-W><C-M> <Cmd>WinShift<CR>
nnoremap <C-W>m <Cmd>WinShift<CR>

" Swap two windows:
nnoremap <C-W>X <Cmd>WinShift swap<CR>

" If you don't want to use Win-Move mode you can create mappings for calling the
" move commands directly:
nnoremap <C-M-H> <Cmd>WinShift left<CR>
nnoremap <C-M-J> <Cmd>WinShift down<CR>
nnoremap <C-M-K> <Cmd>WinShift up<CR>
nnoremap <C-M-L> <Cmd>WinShift right<CR>

