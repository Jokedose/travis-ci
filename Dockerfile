FROMnode:7
EXPOSE8080
COPY./travis-ci
WORKDIR/travis-ci
CMD["node","src/server.js"]