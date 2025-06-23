local Gamepad = {}
Gamepad.__index = Gamepad

function Gamepad:press_attack1()
    return self.attack1
end

function Gamepad:press_attack2()
    return self.attack2
end

function Gamepad:press_reload()
    return self.reload
end

function Gamepad:press_forward()
    return self.forward
end

function Gamepad:press_backward()
    return self.backward
end

function Gamepad:press_run()
    return self.run
end

function Gamepad:press_stop()
    return not self.forward and not self.backward
end

function Gamepad:tick(std)
    self.run = false
    self.reload = false
    self.forward = false
    self.backward = false
    self.attack1 = false
    self.attack2 = false

    if not self.press_left and std.key.press.left then
        self.timer_left = std.milis
        self.press_left = true
    end

    if not self.press_up and std.key.press.up then
        self.timer_up = std.milis
        self.press_up = true
    end

    if std.key.axis.x ~= 0 then
        self.backward = std.key.press.left
        self.forward = std.key.press.right
    else
        self.press_left = false
    end

    if std.key.axis.y ~= 0 then
        self.attack1 = std.key.press.up
        self.attack2 = std.key.press.down
    else
        self.press_up = false
    end

    if std.key.press.right and (std.milis - self.timer_left) < 600 then
        self.run = true
    end

    if std.key.press.down and (std.milis - self.timer_up) < 600 then
        self.reload = true
    end

    if std.key.press.a then
        self.attack1 = true
    end

    if std.key.press.b then
        self.attack2 = true
    end

    if std.key.press.c then
        self.reload = true
    end
end

function Gamepad:new()
    local self = setmetatable({}, Gamepad)
    self.timer_left = 0
    self.timer_up = 0
    return self
end

return Gamepad
