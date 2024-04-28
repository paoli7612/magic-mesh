local enet = require 'enet'
local Player = require 'game.Player'
local Map = require 'game.Map'
local Wall = require 'game.Wall'

function Server()
    local server = {
        players = {},
        connection = enet.host_create("127.0.0.1:9988")
    }

    server.map = Map(server,'Spawn', 20, 20)
    love.window.setTitle('[Server] Magic Mesh')
    for x=1, server.map.w-1, server.map.w-2 do
        for y=1, server.map.h-1 do
            table.insert(server.map.walls, Wall(server, x, y))
        end
    end
    print('Start server: localhost:9988')
    
    server.time = 0
    function server.update(dt)
        server.time = server.time + dt
        if server.time > 1 then
            server.time = server.time - 1
            server.update_clients()
        end
        local event = server.connection:service(1) 
        if event then
            local clientID = event.peer:index()
            if event.type == "receive" then
                server.players[clientID].receive(event.data)
                print("[!] Messaggio dal client:", event.data)
            elseif event.type == "connect" then
                server.players[clientID] = Player(server, event.peer)
                print("[!] Nuova connessione da parte di " .. clientID)
                print("[!] Nuovo Player: " .. server.players[clientID].to_string())
            elseif event.type == "disconnect" then
                server.players[clientID] = nil
                print("[!] Disconnesione da parte di " .. clientID)
            end
        end
    end

    function server.draw()
        server.map.draw()
    end

    function server.quit()
    end

    function server.update_clients()
        for i, p in pairs(server.players) do
            for i, player in pairs(server.players) do
                if not p.username == player.username then 
                    p.send('PLR>' .. player.to_string())
                end
            end
        end
    end

    return server
end

return Server