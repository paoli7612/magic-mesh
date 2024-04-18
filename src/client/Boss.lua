local s = require 'settings'
local Player = require 'sprite.Player'
local Wall = require 'sprite.Wall'
local enet = require "enet"

function Boss()
    local boss = {}
    local client = enet.host_create()
    local server = client:connect("127.0.0.1:7612")
    boss.clients = {}
    boss.players = {}
    boss.walls = {}

    function boss.quit()
        server:send('quit')
        client:flush()
        love.event.quit()
    end

    function boss.draw()

    end

    function boss.input(clientID, message)
        if message == 'quit' then
            table.remove(boss.players, clientID)
        else
            boss.players[clientID].input(message)
        end
    end

    function boss.update(dt)
        local event = client:service()
        if event then
            if event.type == "connect" then
                server:send("Ciao, sono il client1!")
            elseif event.type == "receive" then
                print("Messaggio dal server:", event.data)
            end
        end
    end

    function boss.sendKeyState()
        local up = love.keyboard.isDown('up') and '1' or '0'
        local down = love.keyboard.isDown('down') and '1' or '0'
        local left = love.keyboard.isDown('left') and '1' or '0'
        local right = love.keyboard.isDown('right') and '1' or '0'
        
        local state = up .. down .. left .. right
        server:send(state)
        print(state)
    end


    return boss
end

return Boss