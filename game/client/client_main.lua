local Client = require('game.client.Client')

local client = Client()

function love.update(dt)
    client.update(dt)
end

function love.draw()
    client.draw()
end

function love.quit()
    client.quit()
end