local Animator = require('src/shared/Animator')

local function update(self, std)
    local new_state = self.state
    
    if self.state == 0 then
        new_state = 4
    elseif self.state == 2 and self.anim:is_last_frame() then
        new_state = 6
    elseif self.state == 3 and self.anim:is_last_frame() then
        self.lifes = self.lifes - 1
        new_state = 4
    elseif self.state == 4 and self.lifes <= 0 then
        new_state = 2
    end

    if new_state ~= self.state then
        self.state = new_state
        self.anim:play(self.state_to_anim[self.state])
    end

    self.anim:update(std.delta)
end

local function hit(self)
    if self.state == 6 or self.state == 2 or self.state == 3 then return false end
    self.state = 3
    self.anim:play(self.state_to_anim[self.state])
    return true
end

local function draw(self, callback)
    callback(self.anim:get_frame_name())
end

local function Player()
    local anim = Animator.new()
    local sta = {
        anim:add('attack', 4, 0, 600, 'zombie_1_%d.png'),
        anim:add('dying', 4, 0, 800, 'zombie_2_%d.png'),
        anim:add('hurt', 3, 0, 800, 'zombie_3_%d.png'),
        anim:add('idle', 5, 0, 800, 'zombie_4_%d.png'),
        anim:add('walk', 9, 0, 800, 'zombie_5_%d.png'),
        anim:add('death', 0, 0, 800, 'zombie_2_%d.png'),
    }
    
    return {
        lifes = 3,
        state = 0,
        state_to_anim = sta,
        update = update,
        anim = anim,
        hit = hit,
        draw = draw
    }
end

return Player
