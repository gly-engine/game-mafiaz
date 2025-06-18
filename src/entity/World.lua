local Parallax = require('src/shared/Parallax')

local function update(self, std)
    self.parallax:position(0, 0, std.app.width, std.app.height)
    self.parallax:update(std.delta)
end

local function draw(self, std)
    self.parallax:draw(function(src, x, y)
        std.draw.image(src, x, y)
    end)
end

local function World()
    local parallax = Parallax.new(576, 324)
    parallax:add('city_1_%d.png', 150, 1, 1, 0.1, 0.01)
    parallax:add('city_1_%d.png', 70, 2, 2, 0.3)
    parallax:add('city_1_%d.png', 30, 3, 3, 0.5)
    parallax:add('city_1_%d.png', 20, 4, 4, 0.7)
    parallax:add('city_1_%d.png', 0, 5, 5, 0.9)

    return {
        parallax = parallax,
        update = update,
        draw = draw
    }
end

return World
