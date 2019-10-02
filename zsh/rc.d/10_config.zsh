# ls - use GNU ls when available.
# ps - display processes related to the user
if __rook::is_osx; then
  if __rook::has 'gnuls'; then
      alias ls="gnuls --color=always"
      alias la="ls -lhAF"
  else
      alias ls="ls -G -w"
      alias la="ls -lhAFG"
  fi
  alias ps="ps -fU$(whoami)"
else
  alias ls="ls --color=always"
  alias la="ls -lhAF"
  alias ps="ps -fU$(whoami) --forest"
  alias ll="ls -lhAF --color=always | less -iMRS"
fi

# less
#   M - display percentage and filename
#   i - ignore case in search
#   R - display ANSI color escape sequence as colors
#   N - show linenumber (heavy)
#   S - do not wrap long lines
export LESS="-iMRS"

# lv
export LV="-c"
if __rook::has 'lv'; then
    alias less=lv
fi

# vim
if __rook::has 'vim'; then
  export EDITOR=vim
  export MANPAGER="vim -c MANPAGER -"
  alias vimm="vim -u ~/.vim/vimrc.min -i NONE"
fi

if __rook::has 'nvim'; then
  export EDITOR=nvim
  export MANPAGER="nvim -c MANPAGER -"
  alias nvimm="nvim -u ~/.vim/vimrc.min -i NONE"
fi

# hub
if __rook::has 'hub' && [[ ! -v __hub_initialized ]]; then
  __hub_initialized=1
  hub() {
    unset -f hub
    eval "$(hub alias -s)"
    hub "$@"
  }
  alias git=hub
fi

# xdg-open
if __rook::has 'xdg-open'; then
  open() {
    xdg-open $@ >/dev/null 2>&1
  }
fi

# circlip
if __rook::has 'circlip' && [[ ! -v __circlip_initialized ]]; then
  __circlip_initialized=1
  circlip() {
    unset -f circlip
    eval "$(circlip init)"
    circlip "$@"
  }
fi

# # lemonade
# if ! __rook::is_ssh_running && __rook::has 'lemonade' && ! __rook::is_process_running 'lemonade server'; then
#   # Start lemonade server (&! := background & disown)
#   lemonade server > /dev/null 2>&1 &!
# fi

# anyenv
if __rook::has 'anyenv' && [[ ! -v __anyenv_initialized ]]; then
  __anyenv_initialized=1
  __anyenv::init() {
    unset -f pyenv
    unset -f python
    unset -f nodenv
    unset -f node
    unset -f npm
    unset -f goenv
    unset -f go
    eval "$(anyenv init - --no-rehash)"
  }
  pyenv() {
    __anyenv::init
    # https://github.com/pyenv/pyenv/issues/1219
    alias pyenv="CFLAGS='-I$(xcrun --show-sdk-path)/usr/include' pyenv"
    pyenv "$@"
  }
  python() {
    __anyenv::init
    python "$@"
  }
  nodenv() {
    __anyenv::init
    nodenv "$@"
  }
  node() {
    __anyenv::init
    node "$@"
  }
  npm() {
    __anyenv::init
    npm "$@"
  }
  goenv() {
    __anyenv::init
    goenv "$@"
  }
  go() {
    __anyenv::init
    go "$@"
  }
fi

# go
export GOPATH="$HOME/.go"

# ghq
if __rook::has 'ghq'; then
  fpath=(
      $GOPATH/src/github.com/motemen/ghq/zsh/_ghq(N-/)
      $fpath
  )
fi

# pip
if __rook::has 'pip'; then
  pip::cache() {
    mkdir ~/.cache/pip
    pip completion --zsh > ~/.cache/pip/init.zsh
  }
  if [[ ! -f ~/.cache/pip/init.zsh ]]; then
    pip::cache
  fi
  __rook::source ~/.cache/pip/init.zsh
fi
if __rook::has 'pip2'; then
  pip2::cache() {
    mkdir ~/.cache/pip2
    pip2 completion --zsh > ~/.cache/pip2/init.zsh
  }
  if [[ ! -f ~/.cache/pip2/init.zsh ]]; then
    pip2::cache
  fi
  __rook::source ~/.cache/pip2/init.zsh
fi
if __rook::has 'pip3'; then
  pip3::cache() {
    mkdir ~/.cache/pip3
    pip3 completion --zsh > ~/.cache/pip3/init.zsh
  }
  if [[ ! -f ~/.cache/pip3/init.zsh ]]; then
    pip3::cache
  fi
  __rook::source ~/.cache/pip3/init.zsh
fi

# pipenv
if __rook::has 'pipenv'; then
  pipenv::cache() {
    mkdir ~/.cache/pipenv
    pipenv --completion > ~/.cache/pipenv/init.zsh
  }
  if [[ ! -f ~/.cache/pipenv/init.zsh ]]; then
    pipenv::cache
  fi
  __rook::source ~/.cache/pipenv/init.zsh
fi

# poetry
if [ -f ~/.poetry/env ]; then
  __rook::source ~/.poetry/env
fi

# direnv
if __rook::has 'direnv'; then
  direnv::cache() {
    mkdir ~/.cache/direnv
    direnv hook zsh > ~/.cache/direnv/init.zsh
  }
  if [[ ! -f ~/.cache/direnv/init.zsh ]]; then
    direnv::cache
  fi
  __rook::source ~/.cache/direnv/init.zsh
fi

# GPG
# https://github.com/GPGTools/pinentry-mac/blob/b34748f3e443d8f4f90e720d0eddc32510550397/Source/main.m#L52-L73
if [[ -n "$SSH_CONNECTION" ]]; then
    export GPG_TTY=$(tty)
    export PINENTRY_USER_DATA="USE_CURSES=1"
fi

# Miniconda
if [[ -f "/usr/local/miniconda3/etc/profile.d/conda.sh" ]]; then
    source "/usr/local/miniconda3/etc/profile.d/conda.sh"
fi
