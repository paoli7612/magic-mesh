local Server = require 'Server'

function Boss()
    local boss = {}
    boss.server = Server()
    boss.clients = {}

    function boss.receive()
        local event = boss.server:service(0) 
        if event then
            local clientID = event.peer:index()
            if event.type == "receive" then
                print("Messaggio ricevuto dal client", clientID .. ":", event.data)
            elseif event.type == "connect" then
                boss.clients[clientID] = true
                print("Nuovo client connesso:", clientID)
            elseif event.type == "disconnect" then
                boss.clients[clientID] = nil
                print("Client disconnesso:", clientID)
            end
        end
    end

    
    function boss.quit()
        if server then
            boss.server:flush()
            boss.server:destroy()
        end
    end


    return boss
end

return Boss