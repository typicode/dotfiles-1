let s:script = expand('<sfile>')

if exists('*minpac#init')
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  call minpac#add('AndrewRadev/linediff.vim')
  call minpac#add('Bakudankun/BackAndForward.vim')
  call minpac#add('Konfekt/FastFold')
  call minpac#add('PProvost/vim-ps1')
  call minpac#add('Shougo/context_filetype.vim')
  call minpac#add('Shougo/junkfile.vim')
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('c000/rapidfire.vim')
  call minpac#add('cespare/vim-toml')
  call minpac#add('cocopon/colorswatch.vim')
  call minpac#add('cocopon/iceberg.vim')
  call minpac#add('elzr/vim-json')
  call minpac#add('hail2u/vim-css3-syntax')
  call minpac#add('hynek/vim-python-pep8-indent')
  call minpac#add('itchyny/vim-cursorword')
  call minpac#add('itchyny/vim-parenmatch')
  call minpac#add('junegunn/vim-emoji')
  call minpac#add('jxnblk/vim-mdx-js')
  call minpac#add('kana/vim-altr')
  call minpac#add('kana/vim-operator-replace')
  call minpac#add('kana/vim-operator-user')
  call minpac#add('kana/vim-repeat')
  call minpac#add('kana/vim-textobj-indent')
  call minpac#add('kana/vim-textobj-line')
  call minpac#add('kana/vim-textobj-user')
  call minpac#add('lambdalisue/battery.vim')
  call minpac#add('lambdalisue/compl-local-filename.vim')
  call minpac#add('lambdalisue/edita.vim')
  call minpac#add('lambdalisue/fern-bookmark.vim')
  call minpac#add('lambdalisue/fern-comparator-lexical.vim')
  call minpac#add('lambdalisue/fern-mapping-project-top.vim')
  call minpac#add('lambdalisue/fern-renderer-devicons.vim')
  call minpac#add('lambdalisue/fern.vim')
  call minpac#add('lambdalisue/gina.vim')
  call minpac#add('lambdalisue/grea.vim')
  call minpac#add('lambdalisue/lista.vim')
  call minpac#add('lambdalisue/mr.vim')
  call minpac#add('lambdalisue/qfloc.vim')
  call minpac#add('lambdalisue/readablefold.vim')
  call minpac#add('lambdalisue/reword.vim')
  call minpac#add('lambdalisue/suda.vim')
  call minpac#add('lambdalisue/trimmer.vim')
  call minpac#add('lambdalisue/vim-backslash')
  call minpac#add('lambdalisue/vim-findent')
  call minpac#add('lambdalisue/vim-foldround')
  call minpac#add('lambdalisue/vim-gista')
  call minpac#add('lambdalisue/vim-manpager')
  call minpac#add('lambdalisue/vim-marron')
  call minpac#add('lambdalisue/vim-operator-breakline')
  call minpac#add('lambdalisue/vim-quickrun-neovim-job')
  call minpac#add('lambdalisue/vital-Data-String-Formatter')
  call minpac#add('lambdalisue/vital-Whisky')
  call minpac#add('lambdalisue/wifi.vim')
  call minpac#add('leafgarland/typescript-vim')
  call minpac#add('machakann/vim-sandwich')
  call minpac#add('mattn/vim-goimports')
  call minpac#add('mattn/vim-lexiv')
  call minpac#add('mattn/vim-textobj-url')
  call minpac#add('mattn/webapi-vim')
  call minpac#add('mbbill/undotree')
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
  call minpac#add('neovimhaskell/haskell-vim')
  call minpac#add('osyo-manga/vim-textobj-multiblock')
  call minpac#add('othree/es.next.syntax.vim')
  call minpac#add('othree/html5.vim')
  call minpac#add('othree/javascript-libraries-syntax.vim')
  call minpac#add('othree/yajs.vim')
  call minpac#add('peitalin/vim-jsx-typescript')
  call minpac#add('posva/vim-vue')
  call minpac#add('previm/previm')
  call minpac#add('rbtnn/vim-vimscript_lasterror')
  call minpac#add('rust-lang/rust.vim')
  call minpac#add('ryanoasis/vim-devicons')
  call minpac#add('sgur/vim-textobj-parameter')
  call minpac#add('t9md/vim-quickhl')
  call minpac#add('thinca/vim-prettyprint')
  call minpac#add('thinca/vim-qfreplace')
  call minpac#add('thinca/vim-quickrun')
  call minpac#add('thinca/vim-template')
  call minpac#add('thinca/vim-themis')
  call minpac#add('thinca/vim-zenspace')
  call minpac#add('tweekmonster/helpful.vim')
  call minpac#add('tyru/capture.vim')
  call minpac#add('tyru/caw.vim')
  call minpac#add('tyru/current-func-info.vim')
  call minpac#add('tyru/open-browser.vim')
  call minpac#add('vim-jp/syntax-vim-ex')
  call minpac#add('vim-jp/vimdoc-ja')
  call minpac#add('vim-jp/vital-complete')
  call minpac#add('vim-jp/vital.vim')
  call minpac#add('vim-scripts/python_match.vim')

  " Optional
  call minpac#add('itchyny/lightline.vim', {'type': 'opt'})
  call minpac#add('itchyny/vim-gitbranch', {'type': 'opt'})
  call minpac#add('tpope/vim-fugitive', {'type': 'opt'})
  call minpac#add('lambdalisue/seethrough.vim', {'type': 'opt'})
endif
packloadall

" Load plugin.d/*.vim
function! s:load_configurations() abort
  for path in glob('$VIMHOME/plugin.d/*.vim', 1, 1, 1)
    execute printf('source %s', fnameescape(path))
  endfor
endfunction
call s:load_configurations()

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
if !exists('*s:init')
  function! s:init() abort
    packadd minpac
    execute 'source' fnameescape(s:script)
  endfunction
endif
command! PackUpdate call s:init() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call s:init() | call minpac#clean()
command! PackStatus call s:init() | call minpac#status()
