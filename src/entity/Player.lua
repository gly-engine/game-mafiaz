local Animator = require('src/shared/Animator')

--! @startuml
--! hide empty description
--! state 1 as "idle1"
--! state 2 as "forward"
--! state 3 as "backward"
--! state 4 as "running"
--! state 5 as "jumping"
--! state 6 as "hurting"
--! state 7 as "deathing"
--! state 8 as "attack1"
--! state 9 as "attack2"
--! state 10 as "reloading"
--! 
--! [*] --> 1
--! 1 --> 2
--! 2 --> 1
--! 1 --> 3
--! 3 --> 1
--! 3 --> 4
--! 4 --> 5
--! 4 --> 1
--! 5 --> 4
--! 1 --> 8
--! 1 --> 9
--! 8 --> 1
--! 9 --> 1
--! 1 --> 6
--! 6 --> 7
--! 1 --> 10
--! 10 --> 1
--! 7 --> [*]
--! @enduml

local function update(self, std)
    local old_state, old_state_time = self.fsm_state[3], self.fsm_time[3]
    local cur_state = self.fsm_state[1]
    local new_state = cur_state

    if cur_state == 0 then
        new_state = 1
    elseif cur_state == 1 and std.key.press.right then
        new_state = 2
    elseif cur_state == 1 and std.key.press.left then
        new_state = 3
    elseif (cur_state == 2 or cur_state == 3) and std.key.axis.x == 0 then
        new_state = 1
    elseif ((old_state == 3 and (std.milis - old_state_time) < 600) or cur_state == 3) and std.key.press.right then
        new_state = 4
    elseif cur_state == 4 and std.key.press.left then
        new_state = 1
    elseif cur_state == 4 and std.key.press.up then
        new_state = 5
    elseif cur_state == 5 and self.anim:is_last_frame() then
        new_state = 4
    elseif ((old_state == 8 and (std.milis - old_state_time) < 600) or cur_state == 8) and std.key.press.down then
        new_state = 10
    elseif cur_state == 1 and (std.key.press.a or std.key.press.up) then
        new_state = 8
    elseif cur_state == 1 and (std.key.press.b or std.key.press.down) then
        new_state = 9
    elseif cur_state == 1 and std.key.press.c then
        new_state = 10
    elseif (cur_state == 8 or cur_state == 9) and self.anim:is_last_frame() then
        new_state = 1
    elseif cur_state == 10 and self.anim:is_last_frame() then
        new_state = 1
    end

    if cur_state ~= new_state then
        self.fsm_state[3], self.fsm_time[3] = self.fsm_state[2], self.fsm_time[2]
        self.fsm_state[2], self.fsm_time[2] = self.fsm_state[1], self.fsm_time[1]
        self.fsm_state[1], self.fsm_time[1] = new_state, std.milis
        self.anim:play(self.state_to_anim[new_state])
    end

    self.anim:update(std.delta)
end

local function action(self, callback)
    local state = self.fsm_state[1]
    local anim = self.state_to_anim[state]
    local walking = ({walk1 = 1, walk2 = -1, run = 2})[anim] or 0
    local attacking = ({attack1 = 1, attack2 = 2})[anim] or 0
    
    if attacking ~= 0 and (self.anim:get_frame() ~= 1 or not self.anim:is_first_display_frame()) then
        attacking = 0
    end

    callback(walking, attacking)
end

local function draw(self, callback)
    callback(self.anim:get_frame_name())
end

local function Player()
    local anim = Animator.new()
    local sta = {
        anim:add('idle', 0, 5, 850, 'player_4_%d.png'),
        anim:add('walk1', 0, 9, 850, 'player_10_%d.png'),
        anim:add('walk2', 9, 0, 850, 'player_10_%d.png'),
        anim:add('run', 0, 9, 800, 'player_8_%d.png'),
        anim:add('jump', 2, 9, 600, 'player_6_%d.png'),
        anim:add('hurt', 0, 4, 600, 'player_3_%d.png'),
        anim:add('death', 0, 4, 600, 'player_2_%d.png'),
        anim:add('attack1', 0, 2, 350, 'player_1_%d.png'),
        anim:add('attack2', 0, 3, 300, 'player_9_%d.png'),
        anim:add('reload', 0, 16, 1200, 'player_7_%d.png'),
    }
    
    return {
        fsm_state = {0, 0, 0},
        fsm_time = {0, 0, 0},
        state = 0,
        state_to_anim = sta,
        update = update,
        action = action,
        anim = anim,
        draw = draw
    }
end

return Player
