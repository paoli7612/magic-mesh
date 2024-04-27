local enet = require 'enet'

function Server()
    local server = {
        connection = enet.host_create("127.0.0.1:7612")
    }
    print('Start server: localhost:7612')
    
    function server.update()
        local event = server.connection:service(0) 
        if event then
            local clientID = event.peer:index() -- da chi arriva l'event
            if event.type == "receive" then -- ricevuto un messaggio
                print(event.data)
            elseif event.type == "connect" then -- connesso un nuovo client
                print("connect")
            elseif event.type == "disconnect" then -- disconnesso un client
                print("disconnect")
            end
        end
    end

    function server.draw()
    end

    function server.quit()
    end


    return server
end

return Server