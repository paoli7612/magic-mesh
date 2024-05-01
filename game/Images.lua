function Images()
    local images = {}
    local image = love.graphics.newImage("assets/images/sprite.png")
    images.quads = {}

    function get_image(x,y)
        return love.graphics.newQuad(x*32, y*32, 32, 32, image:getDimensions())
    end

    function images.draw(quad, x, y)
        love.graphics.draw(image, quad, x, y, 0, 1, 1) -- correct for float to int
    end

    images.quads["down"] = {}
    images.quads["down"]["stand"] = {get_image(1,0)}
    images.quads["down"]["walk"] = {get_image(0,0),get_image(2,0)}
    images.quads["right"] = {}
    images.quads["right"]["stand"] = {get_image(1,2)}
    images.quads["right"]["walk"] = {get_image(0,2),get_image(2,2)}
    images.quads["left"] = {}
    images.quads["left"]["stand"] = {get_image(1,1)}
    images.quads["left"]["walk"] = {get_image(0,1),get_image(2,1)}
    images.quads["up"] = {}
    images.quads["up"]["stand"] = {get_image(1,3)}
    images.quads["up"]["walk"] = {get_image(0,3),get_image(2,3)}

    return images
end

return Images