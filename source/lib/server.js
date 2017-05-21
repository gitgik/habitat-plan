var http = require('http'),
    nconf = require('nconf');

nconf.file({ file: 'config/config.json' });

const port = nconf.get('port');

let handleRequest = (request, response) => {
  response.writeHead(200, {'Content-Type': 'text/plain'})
  response.end(nconf.get('message'));
}

var www = http.createServer(handleRequest);

www.listen(port, () => {
  console.log(`Server running on http://0.0.0.0:${port}`);
});
