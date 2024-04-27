local enet = require 'enet'
local Player = require 'game.Player'
local Map = require 'game.Map'

function Client()
    local c = enet.host_create()
    local client = {}

    function client.load()
        print('Trying to connect: localhost:7612')
        client.connection = c:connect("127.0.0.1:7612")
        client.player = Player(client, client.connection) 
    end
    
    function client.update(dt)
        local event = c:service()
        if event then
            if event.type == "connect" then -- quando il client si connette manda il primo CON<[username]
                client.player.send("CON<Tommaso")
            elseif event.type == "receive" then
                print("Messaggio dal server:", event.data)
                client.player.receive(event.data)
            end
        end
    end

    function client.setMap(name, w, h)
        love.window.setTitle('Magic Mesh - ' .. name)
        client.map = Map(name, tonumber(w), tonumber(h))
    end

    function client.draw()
        if client.map then
            client.map.draw()
        end
    end

    function client.quit()
        client.connection:send('quit') 
        client.connection:disconnect_now() 
        love.event.quit()
    end

    return client
end

return Client