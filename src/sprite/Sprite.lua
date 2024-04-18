local s = require 'settings'

function Sprite(boss, x, y, color)
    
    local sprite = {
        x = x,
        y = y,
        color = color
    }

    function sprite.draw()
        love.graphics.setColor(sprite.color)
        love.graphics.rectangle('fill', sprite.x * s.TILE, sprite.y * s.TILE, s.TILE, s.TILE)
    end

    local t = 0
    function sprite.update(dt)
        t = t + dt
        if t > 0.1 then
            t = 0
            sprite.x = (sprite.x + sprite.dx) % s.TILE_X
            sprite.y = (sprite.y + sprite.dy) % s.TILE_Y
        end
    end

    return sprite
end

return Sprite