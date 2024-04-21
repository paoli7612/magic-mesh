
local s = require 'src.client.settings'
local Boss = require 'src.client.Boss'

function love.load()
    love.window.setTitle("Client")
    boss = Boss()
end

function love.draw()
    love.graphics.setColor(0.5, 0.5, 0.5) 
    for y=0, s.WINDOW.HEIGHT, s.TILE do
        for x=0, s.WINDOW.WIDTH, s.TILE do
            love.graphics.rectangle("line", x, y, s.TILE, s.TILE)
        end
    end
    boss.draw()
end

function love.update(dt)
    boss.update(dt)
end

function love.keypressed(key)
    boss.sendKeyState()
end

function love.keyreleased(key)
    boss.sendKeyState()
end

function love.quit()
    boss.quit()
end