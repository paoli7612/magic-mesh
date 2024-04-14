-- settings
local settings = require 'settings'
local Boss = require 'Boss'

function love.load()
    love.window.setTitle("Server")
    -- move on second screen
    local numberOfMonitors = love.window.getDisplayCount()
    if numberOfMonitors >= 2 then
        local firstMonitorWidth, firstMonitorHeight = love.window.getDesktopDimensions(1)
        love.window.setMode(settings.WINDOW.WIDTH, settings.WINDOW.HEIGHT, {display=1, x = firstMonitorWidth, y = 0})
    end

    boss = Boss()
end

function love.update(dt)
    boss.server.receive() -- input from clients
end

function love.draw()
    love.graphics.setColor(0.5, 0.5, 0.5) 
    for y=0, settings.WINDOW.HEIGHT, settings.TILE do
        for x=0, settings.WINDOW.WIDTH, settings.TILE do
            love.graphics.rectangle("line", x, y, settings.TILE, settings.TILE)
        end
    end
    boss.draw()
end




function love.quit()
    boss.quit()
end