local s = require 'settings'
local Sprite = require 'sprite.Sprite'

function Player(boss, x, y, color)
    local player = Sprite(boss, x, y, color)
    player.dx = 0
    player.dy = 0

    width = 40
    height = 20

    function player.input(message)
        local up, down, left, right = message:sub(1,1) == '1', message:sub(2,2) == '1', message:sub(3,3) == '1', message:sub(4,4) == '1'
        player.dy = (down and 1 or 0) - (up and 1 or 0)
        player.dx = (right and 1 or 0) - (left and 1 or 0)
    end



    return player
end

return Player