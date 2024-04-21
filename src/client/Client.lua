local enet = require 'enet'

function Client(boss)
    local c = enet.host_create()
    local client = {
        connection = c:connect("127.0.0.1:7612")
    }

    function client.receive()
        local event = client.connection:service(0) 
        if event then
            if event.type == "receive" then
                boss.input(event.data)
            elseif event.type == "disconnect" then
                print("connection lost")
            end
        end
    end
    
    function client.quit()
        client.connection:send('quit') 
        client.connection:disconnect_now() 
        love.event.quit()
    end
    
    function client.update(dt)
        local event = c:service()
        if event then
            if event.type == "connect" then
                client.connection:send("Ciao, sono il client1!")
            elseif event.type == "receive" then
                print("Messaggio dal server:", event.data)
            end
        end
    end

    function client.send(data)
        client.connection:send(data)
    end

    return client
end

return Client