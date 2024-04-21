local s = require 'src.server.settings'
local Server = require 'src.server.Server'
local Player = require 'src.sprite.Player'
local World = require 'src.server.World'

function Boss()
    local boss = {}
    boss.server = Server(boss)
    boss.world = World(boss)
    boss.players = {}

    function boss.update(dt)
        boss.world.update(dt)
        boss.server.update()
    end

    function boss.draw()
        boss.world.draw()
    end

    function new_player()
        local p = Player(boss, x, y)
        return p
    end

    function boss.input(clientID, message) -- ricevo un input da un client
        print("Boss.input", clientID, message)
        if message == 'quit' then
            table.remove(boss.players, clientID)
        else
            boss.players[clientID].input(message)
            if message == '1000' then print("su") 
            elseif message == '0100' then print("giu")
            end
        end
    end




    return boss
end

return Boss