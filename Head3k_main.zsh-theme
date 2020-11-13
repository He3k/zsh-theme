local resetColor="%{$reset_color%}"
local logo="%{$fg_bold[white]%}▲$resetColor$resetColor"
local hostname="%{$fg[green]%}%m$reset_color"
local dir="%{$fg_bold[white]%}%c$resetColor$resetColor"
TIME="%{$fg_bold[blue]%}%D %{$fg_bold[blue]%}%T$reset_color"
NAME="%{$fg_bold[green]%}%m$reset_color"
LOCA="%{$fg_bold[cyan]%}%~$reset_color"
ENT="%{$fg_bold[magenta]%} >> $fg_bold[white]%}"

GIT_PROMPT_PREFIX="[%{$fg_bold[white]%}"
GIT_PROMPT_SUFFIX="$resetColor] "
GIT_PROMPT_DIRTY="%{$fg_bold[red]%}"
GIT_PROMPT_CLEAN="%{$fg_bold[green]%}"

# modified from https://github.com/robbyrussell/oh-my-zsh/blob/576ada138fc5eed3f58a4aff8141e483310c90fb/lib/git.zsh#L12
function branch_is_dirty() {
  local STATUS=''
  local -a FLAGS
  FLAGS=('--porcelain')
  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi
  if [[ -n $STATUS ]]; then
    return 0
  else
    return 1
  fi
}

function git_prompt() {
  branch=`git_current_branch`
  if [ "$branch" = '' ]; then
    # not a git repo
    echo ''
  else
    if branch_is_dirty; then
      echo "$GIT_PROMPT_PREFIX$GIT_PROMPT_DIRTY$branch$GIT_PROMPT_SUFFIX"
    else
      echo "$GIT_PROMPT_PREFIX$GIT_PROMPT_CLEAN$branch$GIT_PROMPT_SUFFIX"
    fi
  fi

}
PROMPT='$TIME| $NAME $logo $LOCA$(git_prompt)$ENT '
