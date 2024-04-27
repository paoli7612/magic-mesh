local enet = require 'enet'

function Server(boss)
    local server = {
        connection = enet.host_create("127.0.0.1:7612")
    }

    function server.update()
        local event = server.connection:service(0) 
        if event then
            local clientID = event.peer:index() -- da chi arriva l'event
            if event.type == "receive" then -- ricevuto un messaggio
                boss.input(clientID, event.data)
            elseif event.type == "connect" then -- connesso un nuovo client
                local x, y = boss.world.empty_pos()
                boss.players[clientID] = Player(boss, x, y, event.peer)
                boss.players[clientID].is_server = true
            elseif event.type == "disconnect" then -- disconnesso un client
                boss.clients[clientID] = nil
            end
        end
    end

    return server
end

return Server