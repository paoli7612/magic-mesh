local enet = require "enet"

local client = enet.host_create()
local server = client:connect("127.0.0.1:7612")

function love.load()
    love.window.setTitle("Client")
    print('Premi un tasto')
end

function love.update(dt)
    local event = client:service()
    if event then
        if event.type == "connect" then
            server:send("Ciao, sono il client1!")
        elseif event.type == "receive" then
            print("Messaggio dal server:", event.data)
        end
    end

    -- Check the state of the arrow keys and send their state
end

function love.keypressed(key)
    sendKeyState()
end

function love.keyreleased(key)
    sendKeyState()
end

function sendKeyState()
    local up = love.keyboard.isDown('up') and '1' or '0'
    local down = love.keyboard.isDown('down') and '1' or '0'
    local left = love.keyboard.isDown('left') and '1' or '0'
    local right = love.keyboard.isDown('right') and '1' or '0'
    
    local state = up .. down .. left .. right
    server:send(state)
end