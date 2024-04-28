local enet = require 'enet'
local Player = require 'game.Player'
local Wall = require 'game.Wall'
local Map = require 'game.Map'

function Client(username)
    local c = enet.host_create()
    local client = {
        username = username,
        players = {},
        map = nil
    }
    client.map = Map(client, 'Lobby', 3, 3)
    client.connection = c:connect("127.0.0.1:9988")
    client.players[username] = Player(client, client.connection)
    client.players[username].color = {0, 0, 1}
    
    function client.load()
        print('Trying to connect: localhost:9988')
    end
    
    function client.update(dt)
        client.players[username].update(dt)
        local event = c:service()
        if event then
            if event.type == "connect" then -- quando il client si connette manda il primo CON<[username]
                client.players[username].send("CON<" .. username)
            elseif event.type == "receive" then
                client.players[username].receive(event.data)
            end
        end
    end

    function client.setMap(name, w, h)
        love.window.setTitle('Magic Mesh - ' .. name)
        client.map = Map(client, name, w, h)
    end

    function client.addWall(x, y)
        table.insert(client.map.walls, Wall(client, x, y))
    end

    function client.addPlayer(username, x, y)
        if client.players[username] then
            client.players[username].x = x
            client.players[username].y = y
            client.players[username].username = username
        else
            local player = Player(client, nil, x, y)
            player.username = username
            client.players[username] = player
        end
    end

    function client.keyUpdate(key)
        local dx, dy = 0, 0
        if love.keyboard.isDown("right") then dx = dx + 1 end
        if love.keyboard.isDown("left") then dx = dx - 1 end
        if love.keyboard.isDown("up") then dy = dy - 1 end
        if love.keyboard.isDown("down") then dy = dy + 1 end
        client.players[username].dx, client.players[username].dy = dx, dy
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