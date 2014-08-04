bind -f ~/.inputrc

alias slime='open -a "Sublime Text"'
alias pg-start='pg_ctl -D /usr/local/var/postgres/ start'
alias ll='/bin/ls -AFGHhl'
alias ls='/bin/ls -FGH'
alias be='bundle exec'
alias reload='source ~/.bashrc'
alias rs='rails'
alias server='python -m SimpleHTTPServer 1337'

# Git completion
[[ -s "$HOME/.git-completion.sh" ]] && source "$HOME/.git-completion.sh"

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
else
  color_prompt=
fi

function parse_git_deleted {
  [[ $(git status 2> /dev/null | grep deleted:) != "" ]] && echo "-"
}
function parse_git_added {
  [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo '+'
}
function parse_git_modified {
  [[ $(git status 2> /dev/null | grep modified:) != "" ]] && echo "*"
}
function parse_git_dirty {
  #[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "☠"
  echo "$(parse_git_added)$(parse_git_modified)$(parse_git_deleted)"
}
function git_branch {
  BRANCH=$(__git_ps1)
  if [ -z $BRANCH ]
  then
    echo ""
  else
    echo " "
  fi
}
function parse_git_branch {
  echo "$(git_branch)$(__git_ps1 '%s')$(parse_git_dirty)"
}

export LSCOLORS='Exfxcxdxbxegedabagacad'

if [ "$color_prompt" = yes ]; then
  #PS1="\[$(tput)\]\[$(tput setaf 2)\]\u@\h \[$(tput setaf 4)\]\w\[$(tput setaf 3)\] \$(parse_git_branch)\[$(tput sgr0)\]\[$(tput bold)\]\[$(tput setaf 1)\]\[$(tput sgr0)\]> "
  PS1="\[$(tput setaf 2)\]\u@\h \[$(tput setaf 4)\]\w\[$(tput setaf 3)\] \$(parse_git_branch)\[$(tput sgr0)\]\[$(tput bold)\]\[$(tput setaf 1)\]\[$(tput sgr0)\]  "
else
  PS1="\u@\h \w \$(parse_git_branch) > "
fi
unset color_prompt

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:$HOME/go/build
export GOPATH=$HOME/go
