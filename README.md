# go-plus-seabolt
Base image providing compiled seabolt on top of debian + go

##Use case
We are going to gradually update our neo4j go driver to the latest
[neo4j-go-driver](https://github.com/neo4j/neo4j-go-driver) which is relying on [seabolt](https://github.com/neo4j-drivers/seabolt) 
Since seabolt is expected to be in the OS by the driver we decided to provide it as base image.

The intent is to use seabolt as statically linked dependency in order 
the output to not have any runtime dependency to seabolt or or openssl.
You can just pass ```--tags seabolt_static``` to your ```go``` toolset like (like ```go build --tags seabolt_static```)

For questions or support reach @semantic in slack
