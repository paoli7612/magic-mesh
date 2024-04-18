local s = require 'settings'
local o = require 'opt'
local Sprite = require 'sprite.Sprite'

function Player(boss, x, y, color)
    color = o.colors[math.random(#o.colors)]
    local player = Sprite(boss, x, y, color)
    player.dx = 0
    player.dy = 0

    function player.input(message)
        local up, down, left, right = message:sub(1,1) == '1', message:sub(2,2) == '1', message:sub(3,3) == '1', message:sub(4,4) == '1'
        player.dy = (down and 1 or 0) - (up and 1 or 0)
        player.dx = (right and 1 or 0) - (left and 1 or 0)
    end

    function player.color_str()
        return string.format("%d %d %d", 
        math.floor(player.color[1] * 255), 
        math.floor(player.color[2] * 255), 
        math.floor(player.color[3] * 255)) 
    end

    return player
end

return Player