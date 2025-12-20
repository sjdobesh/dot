"------------------------------------------------------------------------------"
"         _____                             __  __                             "
"        / ___/____ _____ ___  ____ _____  / /_/ /_  ____ _                    "
"        \__ \/ __ `/ __ `__ \/ __ `/ __ \/ __/ __ \/ __ `/                    "
"       ___/ / /_/ / / / / / / /_/ / / / / /_/ / / / /_/ /                     "
"      /____/\__,_/_/ /_/ /_/\__,_/_/ /_/\__/_/ /_/\__,_/                      "
"                                                                              "
"             __                _          _       _ __        _               "
"            / /___ _____  ___ ( )_____   (_)___  (_) /__   __(_)___ ___       "
"       __  / / __ `/ __ \/ _ \|// ___/  / / __ \/ / __/ | / / / __ `__ \      "
"      / /_/ / /_/ / / / /  __/ (__  )  / / / / / / /__| |/ / / / / / / /      "
"      \____/\__,_/_/ /_/\___/ /____/  /_/_/ /_/_/\__(_)___/_/_/ /_/ /_/       "
"                                                                              "
"------------------------------------------------------------------------------"

set nocompatible
set hidden
filetype plugin indent on


" PLUGS ------------------------------------------------------------------------

call plug#begin()

" core
Plug 'tpope/vim-fugitive'             " git gutter
Plug 'tpope/vim-surround'             " vim (s)urround commands
Plug 'tpope/vim-commentary'           " vim (s)urround commands
Plug 'mbbill/undotree'                " undo tree for tidal

"syntax & colorschemes
Plug 'sainnhe/sonokai'                " sonokai colorscheme and variants
Plug 'sainnhe/everforest'             " summer var
Plug 'tidalcycles/vim-tidal'          " tidal support
" Plug 'sophacles/vim-processing'       " processing syntax
" Plug 'lervag/vimtex'                  " latex support
" Plug 'jdonaldson/vaxe'                " haxe syntax
" Plug 'udalov/kotlin-vim'              " kotlin syntax
" Plug 'tikhomirov/vim-glsl'            " glsl (and other shader) syntax
" Plug 'plasticboy/vim-markdown'        " markdown syntax
" Plug 'sterpe/vim-algol68'             " algol68 syntax
" Plug 'ap/vim-css-color'               " css syntax

" util
Plug 'vim-airline/vim-airline'        " airline
Plug 'godlygeek/tabular'              " airline tabs
Plug 'vim-airline/vim-airline-themes' " airline themes
Plug 'mhinz/vim-startify'             " start page
Plug 'ntpeters/vim-better-whitespace' " whitespace management
" Plug 'davidgranstrom/scnvim'          " super collider
" Plug 'vhdirk/vim-cmake'               " cmake vim integration
" Plug 'dhruvasagar/vim-table-mode'     " quick markdown tables
" Plug 'vim-scripts/HTML-AutoCloseTag'  " html auto close
" Plug 'preservim/nerdtree'             " filetree
" Plug 'preservim/tagbar'               " tagbar
" Plug 'chrisbra/vim-autosave'          " auto save files

" linters and snips
Plug 'rafamadriz/friendly-snippets'   " premade snippet set
Plug 'neovim/nvim-lspconfig'          " lsp server
Plug 'hrsh7th/cmp-nvim-lsp'           " <-+
Plug 'hrsh7th/cmp-buffer'             "   |
Plug 'hrsh7th/cmp-path'               "   |
Plug 'hrsh7th/cmp-cmdline'            "   |
Plug 'hrsh7th/nvim-cmp'               " auto complete
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'saadparwaiz1/cmp_luasnip'

call plug#end()

" PLUGS SETTINGS-----------------------------------------------------------

" WINDOWS SETTINGS
if has('win64') || has ('win32')
  " tidal settings
  let g:tidal_boot = '~\AppData\Local\nvim-data\plugged\vim-tidal\Tidal.ghci'
  "processing hack
  function! ProcessingFunc()
    let processingdir = getcwd()
    let command = ":!processing cli --sketch=" . processingdir . " --run\<CR>"
    call feedkeys(command)
  endfunction
  nmap <C-M> :call ProcessingFunc()<CR>

" LINUX SETTINGS
else
  let g:tidal_boot = '~.config/nvim/plugged/vim-tidal/Tidal.ghci'
endif

" startify
let g:startify_fortune_use_unicode = 0
let g:ascii = ['â €',
       \' ._____.                                     ._____.',
       \' | ._. |                                     | ._. |',
       \' | !_|_|_____________________________________|_|_! |',
       \' !_________________________________________________!',
       \'     | |    ____      _  ___   ________  ___ | |',
       \'     | |   / __/     / |/ / | / /  _/  |/  / | |',
       \'     | |  _\ \  _   /    /| |/ // // /|_/ /  | |',
       \'     | | /___/ (_) /_/|_/ |___/___/_/  /_/   | |',
       \' .___| |_____________________________________| |___.',
       \' | ._| |_____________________________________| |_. |',
       \' | !_! |                                     | !_! |',
       \' !_____!                                     !_____!',
       \'â €',
       \'â €']
let g:startify_custom_header =
      \ 'startify#pad(g:ascii + startify#fortune#boxed())'

" visible whitespace
let g:better_whitespace_ctermcolor='darkgreen'

" airline settings
let g:airline_extensions = ['branch', 'tabline']
let g:airline#extensions#tabline#enabled = 1
" let g:airline_left_sep = 'î‚°'
" let g:airline_right_sep = 'î‚²'
" let g:airline#extensions#tabline#left_sep = 'î‚°'
" let g:airline#extensions#tabline#left_alt_sep = 'ï½œ'
let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'

" auto save
" let g:autosave_extensions = '.backup'
" let g:autosave_backup     = '~/.vim/backup'
" let g:autosave_max_copies = 10
" let g:autosave_timer      = 5*60*1000 " min x sec x msec

" GENERAL SETTINGS --------------------------------------------------------

" colorscheme
" set background="dark"
set t_Co=16
set termguicolors
colorscheme sonokai
if !exists("g:syntax_on")
    syntax enable
endif
" force italicized
command IC highlight Comment cterm=italic gui=italic
command IS highlight Statement cterm=italic gui=italic
autocmd FileType c IC
autocmd FileType c IS

" toggle hint inlays from coc
" command IH CocCommand clangd.inlayHints.toggle

" general settings
set wrap!           " line wrap
set number          " line numbers
set mouse=a         " mouse
set hidden path+=** " better file nav
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab " tab settings
set foldmethod=syntax foldcolumn=1 foldlevelstart=7         " code folding

" MAPPINGS----------------------------------------------------------------------

" new terminal
nmap <C-t> :term<CR>:set nonumber<CR>

" branching undoo
nmap <C-u> :UndotreeToggle<CR>

" remove all white swpace
nmap <C-s><C-w> :StripWhitespace<CR>

" file nav
" nmap <C-f> :NERDTree<CR>

" tag bar
" nmap <M-t> :TagbarToggle<CR>


" quick buffer navigation
nmap <M-l> :bnext<CR>
nmap <M-h> :bprevious<CR>
nmap <C-q> :bdelete!<CR>

" window nav commands
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <m-o> <C-W><
map <m-y> <C-W>>
map <m-u> <C-W>+
map <m-i> <C-W>-
map <m-=> <C-W>=
map <m-_> <C-W>_
map <M-\|> <C-W>|

" hold alt and move a line up or down
nnoremap <M-j> :m+<cr>
nnoremap <M-k> :m-2<cr>

" escape a terminal
tnoremap <C-q> <C-\><C-N>

" tidal fixes
function! FixTidalHush()
  unmap <buffer> <C-h>
  map <C-h> <C-W>h
endfunction
command FH call FixTidalHush()
command Hush TidalHush
let maplocalleader=","

" open startify screen
command S Startify
map <C-h> <C-W>h

" start super collider
command SC SCNvimStart

" add tidal comments to vim-commentary
autocmd FileType tidal setlocal commentstring=--\ %s

" LUA SNIP CONFIG

" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'

" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'


" LUA CONFIG---------------------------------------------------------------

lua << EOF
local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1

-- set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<m-k>'] = cmp.mapping.scroll_docs(-4),
    ['<m-j>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    -- if cmp.visible() then
    --   cmp.select_next_item()
    --   -- If no completion, fall through to default behavior (e.g., indentation)
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' })
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})




local ls = require("luasnip")

ls.config.set_config({
   history = true,
   enable_autosnippets = true,
})

-- Load friendly-snippets (VS Code format)
require("luasnip.loaders.from_vscode").lazy_load()

if is_windows then
  require("luasnip.loaders.from_vscode").lazy_load({ paths = {"~/AppData/Local/nvim/custom-snippets"}})
end

-- local scnvim = require 'scnvim'
-- local map = scnvim.map
-- local map_expr = scnvim.map_expr
-- require('scnvim').setup({
--   sclang = {cmd = 'C:/Program Files/SuperCollider-3.12.1/sclang.exe'},
--   keymaps = {
--     ['<M-e>'] = map('editor.send_line', {'i', 'n'}),
--     ['<C-e>'] = {
--       map('editor.send_block', {'i', 'n'}),
--       map('editor.send_selection', 'x'),
--     },
--     ['<CR>'] = map('postwin.toggle'),
--     ['<M-CR>'] = map('postwin.toggle', 'i'),
--     ['<M-L>'] = map('postwin.clear', {'n', 'i'}),
--     -- ['<C-k>'] = map('signature.show', {'n', 'i'}),
--     ['<F12>'] = map('sclang.hard_stop', {'n', 'x', 'i'}),
--     -- ['<leader>st'] = map('sclang.start'),
--     -- ['<leader>sk'] = map('sclang.recompile'),
--     ['<leader>sc'] = map_expr('s.boot'),
--     ['<leader>sm'] = map_expr('s.meter'),
--   }
-- })

EOF
