FROM ubuntu:18.04
RUN apt-get update && \
  apt-get install -y libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev python-zmq zlib1g-dev wget curl bsdmainutils automake cmake clang libsodium-dev libcurl4-gnutls-dev libssl-dev git unzip python jq htop

RUN mkdir /opt/komodo
WORKDIR /opt/komodo

RUN git clone https://github.com/komodoplatform/komodo.git && \
  cd komodo && \
  git checkout master && \
  ./zcutil/build.sh -j4 && \
  ./zcutil/fetch-params.sh

# from https://rtfm.co.ua/en/docker-configure-tzdata-and-timezone-during-build/
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone

RUN apt-get install -y php php-gmp

RUN mkdir -p /var/data/komodo/coindata/
