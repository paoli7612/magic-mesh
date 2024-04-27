local enet = require "enet"
local s = require 'src.server.settings'
local clients = {}  

function love.load()
    host = enet.host_create("localhost:6789")
    print("Server started on localhost:6789")
end

function love.update(dt)
    local event = host:service(100)
    while event do
        if event.type == "connect" then
            print("Client connected from " .. tostring(event.peer))
            clients[event.peer:index()] = event.peer 
            event.peer:send("Welcome to the server!")
        elseif event.type == "receive" then
            print("Received message:", event.data, event.peer)
            event.peer:send("Echo: " .. event.data)
        elseif event.type == "disconnect" then
            print("Client disconnected:", event.peer)
            clients[event.peer:index()] = nil  -- Rimuovi il client dalla lista
        end
        event = host:service()
    end
end

function love.draw()
    love.graphics.print("Client connessi:", 10, 10)
    local y = 30
    for index, peer in pairs(clients) do
        love.graphics.print("Client " .. index .. " - IP: " .. tostring(peer), 10, y)
        y = y + 20
    end
end

function love.quit()
    if host then
        host:flush()
    end
    print("Server quitting")
end