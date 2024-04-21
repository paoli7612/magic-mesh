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



    return sprite
end

return Sprite