local s = require 'src.client.settings'
local Player = require 'src.sprite.Player'
local Wall = require 'src.sprite.Wall'
local Client = require 'src.client.Client'

function Boss()
    local boss = {}
    local client = Client()
    boss.player = Player(boss, 9, 9, {1, 0, 0})

    love.window.setMode(s.WINDOW.WIDTH, s.WINDOW.HEIGHT, {resizable=false})

    function boss.quit()
        client.quit()
    end

    function boss.draw()
        boss.player.draw()
    end

    function boss.input(clientID, message)
        if message == 'quit' then
            table.remove(boss.players, clientID)
        else
            boss.players[clientID].input(message)
        end
    end

    function boss.update(dt)
        client.update(dt)
    end

    function boss.sendKeyState()
        local up = love.keyboard.isDown('up') and '1' or '0'
        local down = love.keyboard.isDown('down') and '1' or '0'
        local left = love.keyboard.isDown('left') and '1' or '0'
        local right = love.keyboard.isDown('right') and '1' or '0'
        
        local state = up .. down .. left .. right
        client.send(state)
    end


    return boss
end

return Boss