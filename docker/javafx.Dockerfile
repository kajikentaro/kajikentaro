FROM dorowu/ubuntu-desktop-lxde-vnc:focal
WORKDIR /root
RUN apt update
RUN apt install -y git zip at-spi2-core

# java install
ADD https://download.java.net/java/GA/jdk17/0d483333a00540d886896bac774ff48b/35/GPL/openjdk-17_linux-x64_bin.tar.gz .
RUN tar xf openjdk-17_linux-x64_bin.tar.gz
RUN mv jdk-17/ /usr/local/lib
RUN ln -s /usr/local/lib/jdk-17/bin/javac /usr/local/bin/javac
RUN ln -s /usr/local/lib/jdk-17/bin/java /usr/local/bin/java

# javafx install
ADD https://download2.gluonhq.com/openjfx/17.0.0.1/openjfx-17.0.0.1_linux-x64_bin-sdk.zip .
RUN unzip openjfx-17.0.0.1_linux-x64_bin-sdk.zip
RUN mv javafx-sdk-17.0.0.1/ /usr/local/lib/
RUN echo 'export PATH_TO_FX=/usr/local/lib/javafx-sdk-17.0.0.1/lib' >> /root/.javarc
RUN echo 'export JAVA_HOME=/usr/local/lib/jdk-17' >> /root/.javarc
RUN echo 'alias javac="javac -encoding utf8 --module-path $PATH_TO_FX --add-modules javafx.controls"' >> /root/.javarc
RUN echo 'alias java="java --module-path $PATH_TO_FX --add-modules javafx.controls"' >> /root/.javarc

# apache darby install
ADD https://dlcdn.apache.org//db/derby/db-derby-10.15.2.0/db-derby-10.15.2.0-bin.tar.gz .
RUN tar xf db-derby-10.15.2.0-bin.tar.gz
RUN mv db-derby-10.15.2.0-bin/ /usr/local/lib
RUN echo 'export DARBY_INSTALL=/usr/local/lib/db-derby-10.15.2.0-bin' >> /root/.javarc
RUN echo 'export CLASSPATH=$CLASSPATH:$DARBY_INSTALL/lib/darby.jar' >> /root/.javarc
RUN echo 'export CLASSPATH=$CLASSPATH:$DARBY_INSTALL/lib/derbytools.jar' >> /root/.javarc
RUN echo 'export PATH=$PATH:$DARBY_INSTALL/bin' >> /root/.javarc

# delete tmpfile
RUN rm -r *

# setup japanese(must)
# https://qiita.com/n_oshiumi/items/cfe91c60730f602b38eb
# https://blog.nocorica.jp/2017/01/docker-ubuntu-japanese-input/
RUN apt-get install -y language-pack-ja-base language-pack-ja
ENV LANG=ja_JP.UTF-8

RUN sed -i '1isource /root/.javarc' /etc/profile
RUN sed -i '1isource /root/.javarc' /root/.bashrc
