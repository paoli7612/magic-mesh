local s = require 'settings'
local o = require 'src.opt'
local Sprite = require 'src.sprite.Sprite'

function Player(boss, x, y, peer)
    color = o.colors[math.random(#o.colors)]
    local player = Sprite(boss, x, y, color)

    player.dx = 0
    player.dy = 0

    function player.input(message)
        local up, down = message:sub(1,1) == '1', message:sub(2,2) == '1'
        local left, right =  message:sub(3,3) == '1', message:sub(4,4) == '1'
        player.dy = (down and 1 or 0) - (up and 1 or 0)
        player.dx = (right and 1 or 0) - (left and 1 or 0)
    end

    function player.color_str()
        return string.format("%d %d %d", 
        math.floor(player.color[1] * 255), 
        math.floor(player.color[2] * 255), 
        math.floor(player.color[3] * 255)) 
    end

    local t = 0
    function player.update(dt)
        t = t + dt
        if t > 0.1 then
            t = 0
            player.x = (player.x + player.dx) % s.TILE_X
            player.y = (player.y + player.dy) % s.TILE_Y
        end
    end

    return player
end

return Player