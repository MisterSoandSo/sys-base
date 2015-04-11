"Andrew So's Vim configs
"
"Recommended Options
set hidden
set history=700
set wildmenu
set showcmd
set visualbell
set smartcase
set confirm
set nomodeline	" modeline known security vunerablilty
"
"tab and spacing
"
set shiftwidth=4	"1 tab == 4 spaces
set tabstop=4		"<tab> == 4 spaces
set softtabstop=4	"<tab> and backspace
set smarttab		"smart tab
set ai				" set auto  indent
set si				" set smart indent
set wrap
set preserveindent	"save as much  indent structure as possible
"
"UI config
"
set number			"show number line
set showcmd			"display incomplete command in the lower right coner of the console
set ruler
set encoding=utf8
set ffs=unix,dos,mac

syntax enable

"Movement
set mouse=a	"mouse support in console
set mousehide

"GI configs
set background=dark 	"dark backround
colorscheme evening

".vimrc config
filetype plugin on
filetype indent on

"Misc
noremap <Leader>m mmHmnt:%s/<C-V><cr>//ge<cr>'tzt'm
