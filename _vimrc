if has('win32')
    set guifont=Consolas:h12
endif

set noswapfile
set ttimeoutlen=0

filetype plugin on
filetype indent on

set expandtab
set autoindent
set tabstop=4
set shiftwidth=4

set hidden
set backspace=start,indent,eol

set wildmenu wildoptions=pum
set guicursor+=a:blinkon0
set number

set incsearch
set hlsearch

augroup spell
    autocmd!
    autocmd FileType gitcommit setlocal spell
augroup END

runtime macros/matchit.vim
packadd fileswitch
packadd lsp
call LspOptionsSet(#{ autoComplete: v:false, omniComplete: v:false, semanticHighlight: v:false, showInlayHints: v:false, showSignature: v:true })
call LspAddServer([#{name: 'pyright', filetype: 'python', path: 'pyright-langserver', args: ['--stdio'], workspaceConfig: #{ python: #{ pythonPath: 'py' }} }])

syntax on
set background=dark

function! s:HighlightClear(syntax)
    execute 'highlight clear ' . a:syntax
endfunction

function! s:HighlightsClear(syntaxes)
    for syntax in a:syntaxes
        call s:HighlightClear(syntax)
    endfor
endfunction

function! s:HighlightAdd(syntax, foregroundColor, backgroundColor)
    execute 'highlight ' . a:syntax . ' guifg=' . a:foregroundColor . ' guibg=' . a:backgroundColor
endfunction

let syntaxesToClear = ['Normal', 'Comment', 'Constant', 'Identifier', 'Statement', 'PreProc', 'Type', 'Special', 'Underlined', 'Ignore', 'Error', 'Todo', 'Search', 'IncSearch', 'Visual', 'LineNr', 'SignColumn', 'EndOfBuffer', 'Pmenu', 'PmenuSel']
call s:HighlightsClear(syntaxesToClear)
call s:HighlightAdd('Normal', '#DCDCDC', '#1E1E1E')
call s:HighlightAdd('Comment', '#57A64A', 'NONE')
call s:HighlightAdd('Todo', '#57A64A', 'NONE')
call s:HighlightAdd('Search', 'NONE', '#453B32')
call s:HighlightAdd('IncSearch', 'NONE', '#515C6A')
call s:HighlightAdd('Visual', 'NONE', '#264F78')
call s:HighlightAdd('LineNr', '#8A8A8A', 'NONE')
call s:HighlightAdd('SignColumn', 'NONE', '#1E1E1E')
call s:HighlightAdd('EndOfBuffer', '#1E1E1E', 'NONE')
call s:HighlightAdd('Pmenu', '#FAFAFA', '#2E2E2E')
call s:HighlightAdd('PmenuSel', '#FAFAFA', '#424242')
call s:HighlightAdd('Terminal', '#FAFAFA', '#282828')

" https://stackoverflow.com/a/43001535
augroup python
    autocmd!
    autocmd FileType python syntax region pythonDocString start=+^\s*"""+ end=+"""+ keepend contains=...
    autocmd FileType python highlight link pythonDocString Comment
augroup END
