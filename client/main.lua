local enet = require "enet"

function love.load()
    -- Crea un host ENet per il client
    host = enet.host_create()
    -- Connetti al server
    server = host:connect("localhost:6789")

    connected = false
end

function love.update(dt)
    -- Servizio host per eventi in arrivo
    local event = host:service(100)
    if event then
        if event.type == "connect" then
            print("Connected to server")
            connected = true
            -- Invia un messaggio al server
            server:send("Hello server!")
        elseif event.type == "receive" then
            print("Received message from server:", event.data)
        elseif event.type == "disconnect" then
            print("Disconnected from server")
            connected = false
        end
    end
end

function love.draw()
    if connected then
        love.graphics.print("Connected to server", 10, 10)
    else
        love.graphics.print("Disconnected from server", 10, 10)
    end
end

function love.keypressed(key)
    if key == "escape" then -- Premendo il tasto 'Escape' il client si disconnette
        if connected then
            server:disconnect()
            host:flush()
            connected = false
        end
        love.event.quit()
    end
end

function love.quit()
    if connected then
        server:disconnect()
        host:flush()
    end
end