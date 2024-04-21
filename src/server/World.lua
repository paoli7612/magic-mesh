local Player = require 'src.sprite.Player'
local Wall = require 'src.sprite.Wall'

function World(boss)
    world = {}
    world.walls = {}
    world.walls[0] = Wall(boss, 2, 2)

    function world.new_user(id, player)
        local x = love.math.random(0, s.TILE_X)
        local y = love.math.random(0, s.TILE_Y)
        local p = Player(boss, x, y)
        player:send(p.color_str())
        boss.players[id] = p
    end

    function world.draw()
        for k, player in pairs(boss.players) do
            if player then                
                player.draw()
            end
        end
        world.walls[0].draw()
    end

    function world.update(dt)
        for k, player in pairs(boss.players) do
            player.update(dt)
        end
    end

    function world.empty_pos()
        local x, y
        x = love.math.random(0, s.TILE_X)
        y = love.math.random(0, s.TILE_Y)
        return x, y
    end

    return world
end

return World