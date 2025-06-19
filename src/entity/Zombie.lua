local Animator = require('src/shared/Animator')

local function update(self, std)
    local new_state = self.state
    
    if self.state == 0 then
        new_state = 4
    end

    if new_state ~= self.state then
        self.state = new_state
        self.anim:play(self.state_to_anim[self.state])
    end

    self.anim:update(std.delta)
end

local function draw(self, std)
    local x, y = self.pos.x, self.pos.y
    std.draw.image(self.anim:get_frame_name(), x, y)
end

local function Player()
    local anim = Animator.new()
    local pos = {x=400, y=500}
    local sta = {
        anim:add('attack', 4, 0, 600, 'zombie_1_%d.png'),
        anim:add('death', 4, 0, 800, 'zombie_2_%d.png'),
        anim:add('hurt', 3, 0, 800, 'zombie_3_%d.png'),
        anim:add('idle', 5, 0, 800, 'zombie_4_%d.png'),
        anim:add('walk', 9, 0, 800, 'zombie_5_%d.png')
    }
    
    return {
        state = 0,
        pos = pos,
        state_to_anim = sta,
        update = update,
        anim = anim,
        draw = draw
    }
end

return Player
