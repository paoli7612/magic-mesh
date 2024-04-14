local enet = require "enet"

local client = enet.host_create()

local server = client:connect("127.0.0.1:7612")

function love.load()
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
end

function love.keypressed(key)
    server:send(key)
end