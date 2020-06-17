'usestrict'

consthttp=require('http')

constserver=http.createServer((request,response)=>{
console.log(`ReceivedrequestforURL:${request.url}`)
response.writeHead(200)
response.end('Helloguys!testtesttest')
})

server.listen(8080)
