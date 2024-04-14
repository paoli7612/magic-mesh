local enet = require 'enet'

function Server(boss)
    local server = {
        connection = enet.host_create("127.0.0.1:7612")
    }

    function server.receive()
        local event = server.connection:service(0) 
        if event then
            local clientID = event.peer:index()
            if event.type == "receive" then
                boss.input(clientID, event.data)
            elseif event.type == "connect" then
                boss.clients[clientID] = true
                boss.new_user(clientID, event.peer)
                print("Nuovo client connesso:", clientID)
            elseif event.type == "disconnect" then
                boss.clients[clientID] = nil
                print("Client disconnesso:", clientID)
            end
        end
    end

    return server
end

return Server