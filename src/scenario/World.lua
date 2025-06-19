local Player = require("src/entity/Player")
local Zombie = require("src/entity/Zombie")
local Parallax = require("src/shared/Parallax")

local World = {}
World.__index = World

function World:new(configs)
    local self = setmetatable({}, World)
    self.state = 0
    self.camera_x = 0
    self.camera_y = 0
    self.world_size = 1000
    self.player = Player()
    self.zombie_count = configs.zombies or 0
    return self
end

function World:loadParallax()
    local parallax = Parallax.new(576, 324)
    parallax:add('city_1_%d.png', 150, 1, 1, 0.1, 0.01)
    parallax:add('city_1_%d.png', 70, 2, 2, 0.3)
    parallax:add('city_1_%d.png', 30, 3, 3, 0.5)
    parallax:add('city_1_%d.png', 20, 4, 4, 0.7)
    parallax:add('city_1_%d.png', 0, 5, 5, 0.9)
    self.parallax = parallax
end

function World:spawnZombies(std)
    local index = 1
    self.zombies = {}
    self.zombies_pos = {}
    while index <= self.zombie_count do
        self.zombies[index] = Zombie()
        self.zombies_pos[index] = std.math.random((std.app.width/3) * 2, self.world_size)
        index = index + 1
    end
end

function World:update(std)
    if self.state == 0 then
        self:spawnZombies(std)
        self:loadParallax(std)
        self.state = 1
    end

    self.parallax:position(0, 0, std.app.width, std.app.height)
    self.parallax:update(std.delta)

    self.player:update(std)

    std.array.from(self.zombies):each(function(zombie)
        zombie:update(std)
    end)
end

function World:draw(std)
    local base_y = std.app.height - 180

    self.parallax:draw(function(src, x, y)
        std.draw.image(src, x, y)
    end)

    self.player:draw(function(src)
        std.draw.image(src, 80, base_y)
    end)

    std.array.from(self.zombies):each(function(zombie, index)
        zombie:draw(function(src)
            std.draw.image(src, self.zombies_pos[index], base_y)
        end)
    end)
end

function World:delete()
    self.player = nil
    self.zombies = {}
    self.parallax = nil
end

return World