FROM node:7
EXPOSE 8080
COPY . /travis-ci
WORKDIR /travis-ci
CMD ["node", "src/server.js"]
