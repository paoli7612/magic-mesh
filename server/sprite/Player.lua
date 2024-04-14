local Sprite = require 'sprite.Sprite'

function Player(boss, x, y, color)
    local player = Sprite(boss, x, y, color)
    player.dx = 0
    player.dy = 0

    function player.input(message)
        -- Parse the key states from the message
        local up, down, left, right = message:sub(1,1) == '1', message:sub(2,2) == '1', message:sub(3,3) == '1', message:sub(4,4) == '1'
    
        -- Update the player's movement direction based on key states
        player.dy = (down and 1 or 0) - (up and 1 or 0)
        player.dx = (right and 1 or 0) - (left and 1 or 0)
    end

    local t = 0
    function player.update(dt)
        t = t + dt
        if t > 0.1 then
            t = 0
            player.x = player.x + player.dx
            player.y = player.y + player.dy
        end
    end

    return player
end

return Player