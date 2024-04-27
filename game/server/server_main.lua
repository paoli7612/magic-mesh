local Server = require('game.server.Server')

function love.load()
    server = Server()
end

function love.update(dt)
    server.update(dt)
end

function love.draw()
    server.draw()
end

function love.quit()
    server.quit()
end