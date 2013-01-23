#!/usr/bin/env coffee

https = require 'https'
fs = require 'fs'

options =
    key: fs.readFileSync 'Sunspear_private_key.pem'
    cert: fs.readFileSync 'Sunspear_cert.pem'

server = https.createServer options, (req, res) ->
    console.log "new request #{req.url}"
    
    # Set up close handler
    req.connection.on 'close', ->
        console.log "connection closed"

    # Is this request an alias?
    reqString = req.url[1..]
    aliases =
    	"" : "test.html"
    alias = aliases[reqString]
    reqString = alias if alias?
    console.log "reqString is #{reqString}"

    # Try and load a file
    fs.exists reqString, (exists) ->
        if exists
            try
                console.log "trying to pipe #{reqString}"
                res.writeHead 200
                fs.createReadStream(reqString, {flags:'r'}).pipe res
            catch error
                console.log "Error #{error} piping file #{reqString}"
                res.end
        else
            console.log "Couldn't find file #{reqString}"
		    res.writeHead 404
		    #res.end "Nothing here"

server.on 'secureConnection', (stream) ->
    console.log 'new secure connection'

server.listen 8443, ->
    console.log "Listening on port 8443"
