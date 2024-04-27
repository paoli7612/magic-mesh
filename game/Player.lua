
function Player(boss, peer)
    local player = {}

    player.x = love.math.random(1, 10)
    player.y = love.math.random(1, 10)
    player.peer = peer
    player.username = '[uname]'
    player.dx, player.dy = 0, 0

    player.time = 0
    function player.update(dt)
        player.time = player.time + dt
        if player.time > 0.5 then
            player.time = 0
            player.x = player.x + player.dx
            player.y = player.y + player.dy
            player.send_update()
        end
    end

    function player.send_update()
        player.peer:send('UPD<' .. player.to_string())
    end

    function player.receive(data)
        type, dest, msg = data:sub(1, 3), data:sub(4, 4), data:sub(5)
        if dest == '>' then -- per il client
            if type == 'INI' then 
                love.window.setTitle(msg)
            elseif type == 'MAP' then
                local name, w, h = msg:sub(1, 12), msg:sub(13, 14), msg:sub(15, 16)
                w, h = tonumber(w, 10), tonumber(h, 10)
                boss.setMap(name, w, h)
            elseif type == 'PLR' then
                local username, x, y = msg:sub(1, 12), msg:sub(13, 14), msg:sub(15, 16)
                player.x, player.y = tonumber(x, 10), tonumber(y, 10)
                player.username = username
            elseif type == 'SPR' then
                local sprite, x, y = msg:sub(1, 6), msg:sub(7, 9), msg:sub(10, 12)
                x, y = tonumber(x, 10), tonumber(y, 10)
                boss.addSprite(sprite, x, y)
            end
        elseif dest == '<' then -- per il server
            if type == 'CON' then
                player.username = msg
                player.send('MAP>' .. boss.map.to_string())
                player.send('PLR>' .. player.to_string())
                for k, wall in pairs(boss.map.walls) do
                    player.send('SPR>' .. wall.to_string())
                end
            elseif type == 'UPD' then
                local username, x, y = msg:sub(1, 12), msg:sub(13, 14), msg:sub(15, 16)
                player.x, player.y = tonumber(x, 10), tonumber(y, 10)
            end
        end
    end

    function player.send(msg)
        player.peer:send(msg)
    end

    function player.to_string()
        local username = player.username .. string.rep(" ", 12 - #player.username)
        local x = string.format("%02d", player.x)
        local y = string.format("%02d", player.y)
        return username .. x .. y
    end

    function player.draw()
        local tile = boss.map.tile
        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.rectangle('fill', player.x*tile, player.y*tile, tile, tile)
    end
    
    return player
end


return Player