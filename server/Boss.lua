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
            player.draw()
        end
        boss.walls[0].draw()
    end

    function boss.input(clientID, message)
        print(clientID, message)
        boss.players[clientID].input(message)
    end

    function boss.update(dt)
        boss.server.receive() -- input from clients
        for k, player in pairs(boss.players) do
            player.update(dt)
        end
    end


    return boss
end

return Boss