import http from 'http';
import assert from 'assert';

import "../lib/server.js";


descripe('Node server', () => {
  it('should return 200', done => {
    http.get('http://0.0.0.0:8080', res => {
      assert.equal(200, res.statusCode);
      done();
    })
  })
})
