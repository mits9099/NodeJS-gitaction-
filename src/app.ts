import * as http from 'http';

const server = http.createServer((req: http.IncomingMessage, res: http.ServerResponse) => {
  if (req.url === '/health' && req.method === 'GET') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'UP', timestamp: new Date().toISOString() }));
  } else {
    res.writeHead(404).end();
  }
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => console.log(`Service listening on port ${PORT}`));
