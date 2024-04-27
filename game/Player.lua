
function Player(boss, peer)
    local player = {}

    player.x = 4
    player.y = 8
    player.peer = peer
    player.username = '[username]'

    function player.receive(data)
        type, dest, msg = data:sub(1, 3), data:sub(4, 4), data:sub(5)
        if dest == '>' then -- per il client
            if type == 'INI' then 
                love.window.setTitle(msg)
            elseif type == 'MAP' then
                name, w, h = msg:sub(1, 12), msg:sub(13, 15), msg:sub(16, 18)
                boss.setMap(name, tonumber(w), tonumber(g))
            end
        elseif dest == '<' then -- per il server
            if type == 'CON' then
                player.username = msg
                player.send('MAP>' .. boss.map.to_string())
            end
        end
    end

    function player.send(msg)
        player.peer:send(msg)
    end


    return player
end


return Player