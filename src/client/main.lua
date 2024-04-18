
local s = require 'settings'
local Boss = require 'Boss'

function love.load()
    love.window.setTitle("Client")
    boss = Boss()
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