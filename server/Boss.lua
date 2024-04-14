local s = require 'settings'
local Server = require 'Server'
local Player = require 'sprite.Player'

function Boss()
    local boss = {}
    boss.server = Server(boss)
    boss.clients = {}
    boss.players = {}
    
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
    end

    function boss.input(clientID, message)
        print(clientID, message)
        boss.players[clientID].input(message)
    end

    return boss
end

return Boss