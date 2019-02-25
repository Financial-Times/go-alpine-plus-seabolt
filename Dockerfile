FROM circleci/golang:1.10.0

RUN sudo apt-get update -y\
  && sudo apt-get install -y  --no-install-recommends\
    ca-certificates cmake make g++ libssl-dev  \
    git curl pkg-config wget

# Removing the old cmake
RUN sudo apt purge cmake
RUN sudo apt autoremove

RUN wget https://cmake.org/files/v3.11/cmake-3.11.1-Linux-x86_64.sh
RUN sudo mkdir /opt/cmake
RUN sudo sh cmake-3.11.1-Linux-x86_64.sh --prefix=/opt/cmake --skip-license

RUN sudo update-alternatives --install /usr/bin/cmake cmake /opt/cmake/bin/cmake 1 --force

# clone seabolt-1.7.2 source code > master
RUN sudo git clone https://github.com/neo4j-drivers/seabolt.git /seabolt

WORKDIR /seabolt

RUN sudo git checkout 1e1f827dbed2bf15c1e2a438a3c45311e54f70f6

WORKDIR /seabolt/build

USER root

RUN sudo chown -R root:root /seabolt/build/ && chmod 755 /seabolt/build

# CMAKE_INSTALL_LIBDIR=lib is a hack where we override default lib64 to lib to workaround a defect
# in our generated pkg-config file
# source https://medium.com/neo4j/neo4j-go-driver-is-out-fbb4ba5b3a30
RUN sudo cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_LIBDIR=lib .. && cmake --build . --target install
