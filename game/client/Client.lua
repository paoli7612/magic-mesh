local enet = require 'enet'

function Client()
    local c = enet.host_create()
    local client = {
        connection = c:connect("127.0.0.1:7612")
    }
    print('Trying to connect: localhost:7612')
    
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

    function client.draw()
    end

    function client.quit()
    end


    return client
end

return Client