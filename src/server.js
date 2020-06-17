'use strict'

const http = require('http')

const server = http.createServer((request, response) => {
  console.log(`Received request for URL: ${request.url}`)
  response.writeHead(200)
  response.end('Hello guys! B6016357 นายไตรรงค์ บำรุงเกตุอุดม')
})

server.listen(8080)
