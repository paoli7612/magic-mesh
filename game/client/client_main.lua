local Client = require('game.client.Client')


local client = Client('usr_'..love.math.random(1, 1000000))

function love.load()
    client.load()
end

function love.update(dt)
    client.update(dt)
end

function love.draw()
    client.draw()
end

function love.keypressed(key)
    client.keyUpdate(key)
end

function love.keyreleased(key)
    client.keyUpdate(key)
end

function love.quit()
    client.quit()
end