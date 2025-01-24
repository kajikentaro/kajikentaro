# ZSH Setting

## 各種インストール

```
# install zsh
sudo apt install -y zsh

# oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# auto suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -ie 's/plugins=(/plugins=(zsh-autosuggestions /' ~/.zshrc

# z
sed -ie 's/plugins=(/plugins=(z /' ~/.zshrc
```

## zshrc 追加

```
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
```
## .tmux.conf

```
# vimのキーバインドでペインを移動する
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# コピーモードを設定する
# コピーモードでvimキーバインドを使う
setw -g mode-keys vi

# 'v' で選択を始める
bind -T copy-mode-vi v send -X begin-selection

# clipboardを連携
# sudo apt install xclip が必要
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -i -sel clip > /dev/null"

```


# next.js のサーバーにアクセスできない問題

```
# 3000を使用中のプロセスIDを調べる
netstat -nao | find "3000"

# プロセスIDが4104のプロセスを調べる
tasklist | find "4104"

# プロセスIDが4104のプロセスを調べる(詳細)
tasklist /fi "PID eq 4104" /svc /fo list

# iphlpsvcが起動していたので止める
net stop iphlpsvc
```

# GIT

下記のコマンドで、リモートブランチを削除することができます。コロンの前に何も指定しないことで、「空」を push する、という意味合いになります。

```
// リモートの feature/a を削除する
git push origin :feature/a
```

```
git config --system core.longpaths true
git config --global core.protectNTFS false
```

# docker

--force-recreate 設定やイメージに変更がなくても、コンテナを再作成する

# bash

以下二つは同じ

```
docker logs app 2>&1 | grep "test"
docker logs app |& grep "test"
```

# Docker compose

docker compose で以下のように指定したときに何も出力されない

```
  ngrok:
    image: ngrok/ngrok:3
    environment:
      - NGROK_AUTHTOKEN=$NGROK_AUTHTOKEN
    network_mode: host
    entrypoint: "/bin/bash"
    command: [-c, "ngrok http 3001 --log stdout | grep http"]
```

```
  ngrok:
    image: ngrok/ngrok:3
    environment:
      - NGROK_AUTHTOKEN=$NGROK_AUTHTOKEN
    network_mode: host
    entrypoint: "/bin/bash"
    command: [-c, "ngrok http 3001 --log stdout | grep --line-buffered http"]
```

# vscode recommended extension

https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-database-client2

# powershell update

```
# Setting & Policy update
Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# git 補完
Install-Module -Name posh-git -AllowPrerelease
"Import-Module posh-git" | Add-Content $PROFILE

# PSReadLine
Install-Module -Name PSReadLine -AllowClobber -Force
Set-PSReadLineOption -PredictionSource History
```
