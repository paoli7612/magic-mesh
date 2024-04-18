
function Spritesheet()
    local spritesheet = {
        quads = {}
    }
    local image = love.graphics.newImage("spritesheet.png")
    local size = 32

    function spritesheet.get_image(x, y)
        return love.graphics.newQuad(x * size, y * size, size, size, image:getDimensions())
    end

    function spritesheet.draw_image(x, y, quad)
        love.graphics.draw(image, quad, x, y, 0) 
    end

    return spritesheet
end

return Spritesheet
