const request = require('supertest')
const assert = require('assert')
const app = require('./server')

// This test ensures the endpoint returns a 200, json and has a status and message properties
// TODO: Add a test of the content itself?
describe('Testing XYZ Endpoint', function() {
    it('GETs the endpoint', function(done) {
        request('http://127.0.0.1:3001')
        .get('/')
        .expect(200)
        .expect('Content-Type', 'json')
        .expect(function(res) {
            assert(res.body.hasOwnProperty('status'));
            assert(res.body.hasOwnProperty('message'));
        })
        done()
    })
})