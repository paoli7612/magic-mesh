function Wall(boss, x, y)
    local wall = {
        x = x,
        y = y
    }

    function wall.draw()
        local tile = boss.map.tile
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.rectangle('fill', wall.x*tile, wall.y*tile, tile, tile)
    end

    function wall.to_string()
        local x = string.format("%02d", wall.x)
        local y = string.format("%02d", wall.y)
        return x .. y
    end

    return wall
end


return Wall