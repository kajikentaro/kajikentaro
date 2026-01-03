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
