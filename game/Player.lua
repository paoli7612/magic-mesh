
function generateRandomUsername()
    adjectives = {"Swift", "Lazy", "Crazy", "Jolly", "Mighty", "Silent", "Happy", "Gentle", "Furious", "Wise"}
    names = {"Fox", "Panda", "Rabbit", "Tiger", "Dragon", "Snake", "Eagle", "Bear", "Wolf", "Lion"}
   local adj = adjectives[love.math.random(#adjectives)]
   local name = names[love.math.random(#names)]
   local num = love.math.random(10, 99)
   return adj .. name .. tostring(num)
end

function Player(boss, peer, x, y, username)
    local player = {}
    
    player.x = x or love.math.random(1, 10)
    player.y = y or love.math.random(1, 10)
    player.peer = peer or nil
    player.dx, player.dy = 0, 0
    player.username = username or generateRandomUsername()
    player.username = string.gsub(player.username, "%s+$", "")
    player.color = {0.5, 1, 0}
    
    player.time = 0
    function player.update(dt)
        if player.x and player.y then
            player.time = player.time + dt
            if player.time > 0.5 then
                if player.dx ~= 0 or player.dy ~= 0 then    
                    player.time = 0
                    player.x = player.x + player.dx
                    player.y = player.y + player.dy
                    player.send('PLR<' .. player.to_string())
                end
            end
        end
    end

    function player.receive(data)
        type, dest, msg = data:sub(1, 3), data:sub(4, 4), data:sub(5)
        if dest == '>' then -- per il client
            if type == 'MAP' then -- Comincia a ricevere la mappa (titolo [12], w[2], h[2])
                local name, w, h = msg:sub(1, 12), msg:sub(13, 14), msg:sub(15, 16)
                w, h = tonumber(w, 10), tonumber(h, 10)
                boss.setMap(name, w, h)
            elseif type == 'WLL' then -- Riceve la posizione di un muro (x [2], y[2])
                local x, y = msg:sub(1, 2), msg:sub(3, 4)
                x, y = tonumber(x, 10), tonumber(y, 10)
                boss.addWall(x, y)
            elseif type == 'PLR' then -- Riceve i dati di un player (username [12], x[2], y[2])
                local username, x, y = msg:sub(1, 18), msg:sub(19, 20), msg:sub(21, 22)
                username = string.gsub(username, "%s+$", "")
                x, y = tonumber(x, 10), tonumber(y, 10)
                boss.addPlayer(username, x, y)
            end
        elseif dest == '<' then -- per il server
            if type == 'CON' then
                player.username = msg
                player.send('MAP>' .. boss.map.to_string())
                for k, wall in pairs(boss.map.walls) do player.send('WLL>' .. wall.to_string()) end
                for k, p in pairs(boss.players) do player.send('PLR>' .. p.to_string()) end
            elseif type == 'PLR' then
                local username, x, y = msg:sub(1, 18), msg:sub(19, 20), msg:sub(21, 22)
                player.x, player.y = tonumber(x, 10), tonumber(y, 10)
                for i, p in pairs(boss.players) do
                    p.send('PLR>' .. player.to_string())
                end
            end
        end
    end

    function player.send(msg)
        player.peer:send(msg)
    end

    function player.to_string()
        local username = player.username .. string.rep(" ", 18 - #player.username)
        local x = string.format("%02d", player.x)
        local y = string.format("%02d", player.y)
        return username .. x .. y
    end

    function player.draw()
        if player.x and player.y then
            local tile = boss.map.tile
            love.graphics.setColor(player.color)

            love.graphics.rectangle('fill', player.x*tile, player.y*tile, tile, tile)
            love.graphics.printf(player.username, player.x*tile, (player.y-1)*tile, 100)
        end
    end
    
    return player
end


return Player