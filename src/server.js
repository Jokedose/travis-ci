"usestrict";

consthttp = require("http");

constserver = http.createServer((request, response) => {
  console.log(`ReceivedrequestforURL:${request.url}`);
  response.writeHead(200);
  response.end("Hello guys!test test test");
});

server.listen(8080);
