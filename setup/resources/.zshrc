function redraw-prompt() {
  local f
  for f in chpwd "${chpwd_functions[@]}" precmd "${precmd_functions[@]}"; do
    [[ "${+functions[$f]}" == 0 ]] || "$f" &>/dev/null || true
  done
  p10k display -r
}

function cd_target(){
  d=$(find -type d | fzf )

  if [[ $d = "" ]]; then
    return
  fi

  cd $d
  redraw-prompt
}

zle -N cd_target
bindkey "^l" cd_target

function cd_recent(){
  d=$( \
    z \
    | awk '{print $2}' \
    | tac \
    | fzf )

  if [[ $d = "" ]]; then
    return
  fi

  cd $d
  redraw-prompt
}

zle -N cd_recent
bindkey "^o" cd_recent
