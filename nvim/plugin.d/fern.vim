function! s:fern_init() abort
  if has('mac') && !exists('$SSH_CONNECTION')
    let g:fern#renderer = 'nerdfont'
  endif
  let g:fern#keepalt_on_edit = 1
  let g:fern#smart_cursor = has('nvim-0.5.0') ? 'hide' : 'stick'
  let g:fern#scheme#bookmark#store#file = expand('~/Documents/vim/fern/bookmark.json')
  "let g:fern#disable_drawer_distinguish_tabpage = 1
  "let g:fern#loglevel = g:fern#DEBUG
endfunction

function! s:fern_local_init() abort
  nmap <buffer>
        \ <Plug>(fern-my-enter-and-tcd)
        \ <Plug>(fern-action-enter)<Plug>(fern-wait)<Plug>(fern-action-tcd:root)
  nmap <buffer>
        \ <Plug>(fern-my-leave-and-tcd)
        \ <Plug>(fern-action-leave)<Plug>(fern-wait)<Plug>(fern-action-tcd:root)
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-or-enter-and-tcd)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open)",
        \   "\<Plug>(fern-my-enter-and-tcd)",
        \ )
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-or-enter)
        \ fern#smart#drawer(
        \   "\<Plug>(fern-my-open-or-enter-and-tcd)",
        \   "\<Plug>(fern-action-open-or-enter)",
        \ )
  nmap <buffer><expr>
        \ <Plug>(fern-my-leave)
        \ fern#smart#drawer(
        \   "\<Plug>(fern-my-leave-and-tcd)",
        \   "\<Plug>(fern-action-leave)",
        \ )
  nmap <buffer><nowait> <C-m> <Return>
  nmap <buffer><nowait> <C-h> <Backspace>
  nmap <buffer><nowait> <Return>    <Plug>(fern-my-open-or-enter)
  nmap <buffer><nowait> <Backspace> <Plug>(fern-my-leave)
  nmap <buffer><nowait> T <Plug>(fern-action-terminal)
  nnoremap <buffer><nowait> ~ :<C-u>Fern ~<CR>
  nnoremap <buffer><nowait> I :<C-u>FzfMrr<CR>
endfunction

augroup my-fern
  autocmd! *
  autocmd VimEnter * call s:fern_init()
  autocmd FileType fern call s:fern_local_init()
augroup END

function! s:smart_path() abort
  if !empty(&buftype) || bufname('%') =~# '^[^:]\+://'
    return fnamemodify('.', ':p')
  endif
  return fnamemodify(expand('%'), ':p:h')
endfunction

nnoremap <silent> <Leader>ee :<C-u>Fern <C-r>=<SID>smart_path()<CR> -reveal=%<CR>
nnoremap <silent> <Leader>EE :<C-u>Fern . -drawer -toggle -reveal=%<CR>
nnoremap <silent> <Leader>ii :<C-u>Fern bookmark:/// -wait<CR><BAR>:Fin -after=\\<lt>CR><CR>
nnoremap <silent> <Leader>JJ :<C-u>Fern <C-r>=expand(g:junkfile#directory)<CR> -wait<CR>
