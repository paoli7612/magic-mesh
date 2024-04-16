local s = require 'settings'
local Server = require 'Server'
local Player = require 'sprite.Player'
local Wall = require 'sprite.Wall'

function Boss()
    local boss = {}
    boss.server = Server(boss)
    boss.clients = {}
    boss.players = {}
    boss.walls = {}

    boss.walls[0] = Wall(boss, 2, 2)

    function boss.quit()
        if server then
            boss.server:flush()
            boss.server:destroy()
        end
    end

    function boss.new_user(id, player)
        local x = love.math.random(0, s.TILE_X)
        local y = love.math.random(0, s.TILE_Y)
        player:send(x)
        player:send(y)
        boss.players[id] = Player(boss, x, y)
    end

    function boss.draw()
        for k, player in pairs(boss.players) do
            if player then                
                player.draw()
            end
        end
        boss.walls[0].draw()
    end

    function boss.input(clientID, message)
        if message == 'quit' then
            table.remove(boss.players, clientID)
        else
            boss.players[clientID].input(message)
        end
    end

    function boss.update(dt)
        for k, player in pairs(boss.players) do
            player.update(dt)
        end
        boss.server.receive() -- input from clients
    end


    return boss
end

return Boss