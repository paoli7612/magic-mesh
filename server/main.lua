-- settings
TILE = 50
WINDOW = {X = 1200, Y = 900}

local Boss = require 'Boss'

function love.load()
    love.window.setMode(WINDOW.X, WINDOW.Y)
    boss = Boss()
end

function love.update(dt)
    boss.receive()
end

function love.quit()
    boss.quit()
end

function love.draw()
    love.graphics.setColor(0.5, 0.5, 0.5) -- Imposta il colore della linea a grigio
    for y=0, WINDOW.Y, TILE do
        for x=0, WINDOW.X, TILE do
            love.graphics.rectangle("line", x, y, TILE, TILE)
        end
    end
end

