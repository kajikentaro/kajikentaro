all: install-oh-my-zsh install-fzf install-auto-suggestions install-z append-zshrc

apt-update:
	sudo apt update
	touch apt-update

install-zsh: apt-update
	sudo apt install -y zsh
	touch install-zsh

install-oh-my-zsh: install-zsh
	sh -c "$$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	touch install-oh-my-zsh

install-fzf: install-zsh
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
	touch install-fzf

install-auto-suggestions: install-zsh install-oh-my-zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	sed -ie 's/plugins=(/plugins=(zsh-autosuggestions /' ~/.zshrc
	touch install-auto-suggestions

install-z: install-zsh install-oh-my-zsh
	sed -ie 's/plugins=(/plugins=(z /' ~/.zshrc
	touch install-z

append-zshrc: install-zsh
	cat ./resources/.zshrc >> ~/.zshrc
	touch append-zshrc

append-tmux-conf:
	cat ./resources/.tmux.conf >> ~/.tmux.conf
	touch append-tmux-conf

append-mod-rc: install-zsh
	cat ./resources/.modrc >> ~/.modrc
	echo "source ~/.modrc" >> ~/.zshrc
	touch append-mod-rc
