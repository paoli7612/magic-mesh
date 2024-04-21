local Sprite = require 'src.sprite.Sprite'

function Wall(boss, x, y)
    local wall = Sprite(boss, x, y, {0.2, 0.5, 0.9})

    return wall
end

return Wall