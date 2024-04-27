local WINDOW_WIDTH = love.graphics.getWidth()
local WINDOW_HEIGHT = love.graphics.getHeight()

function Map(name, w, h)
    local map = {name = name, w = w, h = h, t=WINDOW_WIDTH/w}

    function map.to_string()
        local name = map.name .. string.rep(" ", 12 - #map.name)
        local w_str = string.format("%03d", map.w)
        local h_str = string.format("%03d", map.h)
        return name .. w_str .. h_str
    end

    function map.draw()
        local T = WINDOW_WIDTH/map.w
        love.graphics.setColor(0.5, 0.5, 0.5) 
        for y = 0,WINDOW_HEIGHT,T do
            for x = 0,WINDOW_WIDTH,T do
                love.graphics.rectangle("line", x, y, T, T)
            end
        end
    end

    return map
end

return Map