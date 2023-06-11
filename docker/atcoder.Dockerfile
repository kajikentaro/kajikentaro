# Ubuntuの公式コンテナを軸に環境構築
FROM ubuntu:20.04

# インタラクティブモードにならないようにする
ARG DEBIAN_FRONTEND=noninteractive
# タイムゾーンを日本に設定
ENV TZ=Asia/Tokyo

# インフラを整備
RUN apt-get update && \
  apt-get install -y zsh time tzdata tree git curl

# C++, Python3, PyPy3の3つの環境想定
RUN apt-get update && \
  apt-get install -y gcc-9 g++-9 python3.8 python3-pip pypy3 nodejs npm

# 一般的なコマンドで使えるように設定
# e.g. python3.8 main.py => python main.py
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 30 && \
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 30 && \
  update-alternatives --install /usr/bin/python python /usr/bin/python3.8 30 && \
  update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 30 && \
  update-alternatives --install /usr/bin/pypy pypy /usr/bin/pypy3 30 && \
  update-alternatives --install /usr/bin/node node /usr/bin/nodejs 30

# AtCoderでも使えるPythonライブラリをインストール
RUN pip install numpy==1.18.2 && \
  pip install scipy==1.4.1 && \
  pip install scikit-learn==0.22.2.post1 && \
  pip install numba==0.48.0 && \
  pip install networkx==2.4

# C++でAtCoder Library(ACL)を使えるようにする
RUN git clone --depth 1 https://github.com/atcoder/ac-library.git /lib/ac-library
ENV CPLUS_INCLUDE_PATH /lib/ac-library

# Pythonでの競技プログラミング用データ構造をインストール
RUN pip install git+https://github.com/hinamimi/ac-library-python && \
  pip install git+https://github.com/hinamimi/python-sortedcontainers

# コンテスト補助アプリケーションをインストール
RUN pip install online-judge-tools==11.3.0
RUN npm install -g atcoder-cli@2.1.1

# AHC用のRustのinstall
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH $PATH:/home/root/.cargo/bin

# 多倍長整数をインストール
RUN apt-get install -y libboost-all-dev

# GDB をインストール
RUN apt install -y gdb

# 日本語化
RUN apt-get -y install locales-all
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

# atcoder-cliの設定
RUN acc config default-template cpp
RUN acc config default-test-dirname-format test
COPY atcoder_template /tmp/atcoder_template
RUN mv /tmp/atcoder_template $(acc config-dir)/cpp
RUN echo "alias codea='CPP_FILES=\$(find ./*/main.cpp) && code \$CPP_FILES'" >> /root/.bashrc
RUN echo "alias c='g++ main.cpp && oj test'" >> /root/.bashrc
# run these commands before you start
# $ acc login
# $ oj login https://beta.atcoder.jp/

CMD ["/bin/bash"]
