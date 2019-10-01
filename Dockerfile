FROM golang:1-alpine

#add cgo dependencies deps
RUN apk --no-cache add ca-certificates cmake make g++ openssl-dev git pkgconfig curl

# clone seabolt-1.7.4 source code
RUN git clone -b v1.7.4 https://github.com/neo4j-drivers/seabolt.git /seabolt

WORKDIR /seabolt/build

# CMAKE_INSTALL_LIBDIR=lib is a hack where we override default lib64 to lib to workaround a defect
# in our generated pkg-config file
# source https://medium.com/neo4j/neo4j-go-driver-is-out-fbb4ba5b3a30
RUN cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_LIBDIR=lib .. && cmake --build . --target install
