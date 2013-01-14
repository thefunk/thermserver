#!/usr/bin/env coffee

https = require 'https'
fs = require 'fs'

options = {
    key: fs.readFileSync 'Sunspear_private_key.pem'
    cert: fs.readFileSync 'Sunspear_cert.pem'
}

server = https.createServer options, (req, res) ->
    console.log "new request #{req.url}"
    req.connection.on 'close', ->
        console.log "connection closed"
    res.writeHead 200
    res.end "hello world\n"

server.on 'secureConnection', (stream) ->
    console.log 'new secure connection'

server.listen 8443, ->
    console.log "Listening on port 8443"
