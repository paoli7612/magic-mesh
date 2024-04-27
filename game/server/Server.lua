local enet = require 'enet'
local Player = require 'game.Player'
local Map = require 'game.Map'
local Wall = require 'game.Wall'

function Server()
    local server = {
        players = {},
        connection = enet.host_create("127.0.0.1:7612")
    }
    server.map = Map(server,'Spawn', 12, 9)

    table.insert(server.map.walls, Wall(server, 2, 2))
    table.insert(server.map.walls, Wall(server, 2, 3))
    table.insert(server.map.walls, Wall(server, 4, 5))
    print('Start server: localhost:7612')
    
    function server.update(dt)
        local event = server.connection:service(1) 
        if event then
            local clientID = event.peer:index()
            if event.type == "receive" then
                server.players[clientID].receive(event.data)
                print("Messaggio dal client:", event.data)
            elseif event.type == "connect" then
                server.players[clientID] = Player(server, event.peer)
                print("Nuova connessione da parte di " .. clientID)
            elseif event.type == "disconnect" then
                server.players[clientID] = nil
                print("Disconnesione da parte di " .. clientID)
            end
        end
    end

    function server.draw()
        server.map.draw()
    end

    function server.quit()
    end


    return server
end

return Server