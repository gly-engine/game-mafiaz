local Zombie = require("src/entity/Zombie")
local Parallax = require("src/shared/Parallax")

local World = {}
World.__index = World

function World:new(configs)
    local self = setmetatable({}, World)
    self.state = 0
    self.world_size = 1000
    self.player = configs.player
    self.pos_player = 80
    self.pos_camera = 0
    self.pos_zombie = {}
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
    while index <= self.zombie_count do
        self.zombies[index] = Zombie()
        self.pos_zombie[index] = std.math.random((std.app.width/3) * 2, self.world_size)
        index = index + 1
    end
end

function World:update(std)
    local deadzone_1 = std.app.width / 16
    local deadzone_2 = deadzone_1 * 4


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

    self.player:action(function(walking, attacking)
        if walking ~= 0 then
            self.pos_player = self.pos_player + walking

            local new_position_camera = self.pos_camera
            local position_player_in_cam = self.pos_player - self.pos_camera

            if position_player_in_cam < deadzone_1 then
                new_position_camera = self.pos_player - deadzone_1
            elseif position_player_in_cam > deadzone_2 then
                new_position_camera = self.pos_player - deadzone_2
            end

            if new_position_camera ~= self.pos_camera then
                self.pos_camera = new_position_camera
                self.parallax:rotate(walking)
            end
        end
        if attacking ~= 0 then
            local hited = false
            local fists_range = 50
            local shoot_range = std.app.width - (self.pos_player - self.pos_camera)
            local ranges = {self.pos_player + fists_range, self.pos_player + shoot_range}
            std.array.from(self.zombies):each(function(zombie, index)
                if self.pos_zombie[index] <= ranges[attacking] and not hited then
                    hited = zombie:hit(self.player)
                end
            end)
        end
    end)
end

function World:draw(std)
    local paralax_height = self.parallax:draw(function(src, x, y)
        std.draw.image(src, x, y)
    end)

    local base_y = std.math.max(paralax_height - 128, std.app.height - 180)

    self.player:draw(function(src)
        std.draw.image(src, self.pos_player - self.pos_camera, base_y)
    end)

    std.array.from(self.zombies):each(function(zombie, index)
        zombie:draw(function(src)
            std.draw.image(src, self.pos_zombie[index] - self.pos_camera, base_y)
        end)
    end)
end

function World:delete()
    self.player = nil
    self.zombies = {}
    self.parallax = nil
end

return World