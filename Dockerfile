FROM ubuntu:xenial@sha256:45415347f7e26415834d185cddbe8467b6c8af67452d16df8704f0ecdfea3c9a

# Fixes some weird terminal issues such as broken clear / CTRL+L
ENV TERM=linux
ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i 's@archive.ubuntu.com@mirrors.163.com@g' /etc/apt/sources.list
RUN sed -i 's@security.ubuntu.com@mirrors.163.com@g' /etc/apt/sources.list
# install php
RUN apt-get update && apt-get install php -y

# install quick depends
RUN apt-get install libx11-dev libxmu-dev libglu1-mesa-dev libgl2ps-dev libxi-dev libzip-dev libpng12-dev libcurl4-gnutls-dev libfontconfig1-dev libsqlite3-dev libglew*-dev libssl-dev gnutls-dev ncurses-dev -y

# install lua5.1
COPY lua-5.1.5 /opt/lua-5.1.5
RUN apt-get install libreadline-dev -y
RUN cd /opt/lua-5.1.5 && make linux test && make install

# install quick
COPY quick-3.3 /opt/quick-3.3
RUN apt-get clean \
       && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# set luac
RUN mv /opt/quick-3.3/quick/bin/mac/luac /opt/quick-3.3/quick/bin/mac/luac.mac
RUN ln -sv /usr/local/bin/luac /opt/quick-3.3/quick/bin/mac/luac

CMD ["/opt/quick-3.3/quick/bin/compile_scripts.sh"]
