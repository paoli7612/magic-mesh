local WINDOW_WIDTH = love.graphics.getWidth()
local WINDOW_HEIGHT = love.graphics.getHeight()

function Map(boss, name, w, h)
    local map = {
        name = name,
        w = w,
        h = h,
        walls = {}, -- [1, 2, 3, ...] = Player()
        players = {} --[username] = Player()
    }
    map.tile = 32

    function map.to_string()
        local name = map.name .. string.rep(" ", 12 - #map.name)
        local w_str = string.format("%02d", map.w)
        local h_str = string.format("%02d", map.h)
        return name .. w_str .. h_str
    end

    function map.draw()
        love.graphics.setColor(0.5, 0.5, 0.5) 
        for y = 0,map.h do
            for x = 0,map.w do
                love.graphics.rectangle("line", x*map.tile, y*map.tile, map.tile, map.tile)
            end
        end
        for i, wall in pairs(map.walls) do
            wall.draw()
        end
        if boss.players then
            for i, player in pairs(boss.players) do
                player.draw()
            end
        end
    end

    return map
end

return Map