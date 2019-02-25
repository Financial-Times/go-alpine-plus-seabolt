FROM golang:1.10-alpine

#add cgo dependencies deps
RUN apk --no-cache add ca-certificates cmake make g++ openssl-dev git curl pkgconfig

# clone seabolt-1.7.2 source code > master
RUN git clone https://github.com/neo4j-drivers/seabolt.git /seabolt

WORKDIR /seabolt

RUN git checkout 1e1f827dbed2bf15c1e2a438a3c45311e54f70f6

WORKDIR /seabolt/build

# CMAKE_INSTALL_LIBDIR=lib is a hack where we override default lib64 to lib to workaround a defect
# in our generated pkg-config file
# source https://medium.com/neo4j/neo4j-go-driver-is-out-fbb4ba5b3a30
RUN cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_LIBDIR=lib .. && cmake --build . --target install
