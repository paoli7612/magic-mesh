local Sprite = require 'sprite.Sprite'

function Player(boss, x, y, color)
    local player = Sprite(boss, x, y, color)

    function player.input(message)
        if message == 'down' then
            player.y  = player.y + 1
        elseif message == 'up' then
            player.y = player.y - 1
        elseif message == 'left' then
            player.x = player.x - 1
        elseif message == 'right' then
            player.x = player.x + 1
        end
    end

    return player
end

return Player