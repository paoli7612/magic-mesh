local Sprite = require 'sprite.Sprite'

function Player(boss, x, y, color)
    local player = Sprite(boss, x, y, color)
    player.dx = 0
    player.dy = 0

    function player.input(message)
        local action = message:sub(1,1)  -- Get first character as action
        local key = message:sub(2)       -- Get rest of the string as key
        print('key', key)
        if action == 'p' then  -- Key press
            if key == 'down' then
                player.dy = 1
            elseif key == 'up' then
                player.dy = -1
            elseif key == 'left' then
                player.dx = -1
            elseif key == 'right' then
                player.dx = 1
            end
        elseif action == 'r' then  -- Key release
            if key == 'down' or key == 'up' then
                player.dy = 0
            elseif key == 'left' or key == 'right' then
                player.dx = 0
            end
        end
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