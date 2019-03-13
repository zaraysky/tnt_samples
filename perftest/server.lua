#!/usr/bin/env tarantool
local http = require('http.server')
box.cfg {
    listen = 3301,
    log_level = 1,
    readahead = 1280000,
}
box.once('init_security', function()
    box.schema.user.grant('guest', 'read,write,execute', 'universe', nil, { if_not_exists = true })
    box.schema.func.create('process_request', { setuid = true, if_not_exists = true })
    box.schema.user.grant('guest', 'execute', 'function', 'process_request', { if_not_exists = true })
end)
local status = 200
local headers = {}
local body = 'ok'
function process_request()
    return status, headers, body
end
local http_response = {
    status = status,
    headers = headers,
    body = body,
}
local function http_handler()
    return http_response
end

local httpd = http.new('0.0.0.0', 8089)
httpd:route({ path = '/', method = 'GET'}, http_handler)
httpd:start()
