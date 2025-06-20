local Animator = {}
Animator.__index = Animator

function Animator.new()
  return setmetatable({
    animations = {},
    current = nil,
    count = 0,
    time = 0,
    frame = 0,
    old_frame = -1,
  }, Animator)
end

function Animator:add(name, start_frame, end_frame, duration_ms, image_format)
  local count = math.abs(end_frame - start_frame) + 1
  local forward = end_frame >= start_frame
  self.animations[name] = {
    start = start_frame,
    finish = end_frame,
    count = count,
    duration = duration_ms,
    image_format = image_format or "%d.png",
    forward = forward,
  }
  return name
end

function Animator:play(name)
  if self.current ~= name then
    self.current = name
    self.time = 0
    self.frame = 0
    self.old_frame = -1
  end
end

function Animator:update(dt_ms)
  if not self.current then return end
  local anim = self.animations[self.current]
  self.time = self.time + dt_ms

  local frame_duration = anim.duration / anim.count
  local f = math.floor(self.time / frame_duration)
  local offset = f % anim.count

  if anim.forward then
    self.frame = anim.start + offset
  else
    self.frame = anim.start - offset
  end
  if self.frame ~= self.old_frame then
    self.old_frame = self.frame
    self.count = 1
  else
    self.count = self.count + 1
  end
end

function Animator:get_frame()
  return self.frame
end

function Animator:is_first_display_frame()
  if not self.current then return false end
  return self.count == 1
end

function Animator:is_last_frame()
  if not self.current then return false end
  local anim = self.animations[self.current]
  return self.frame == (anim.forward and anim.finish or anim.start)
end

function Animator:get_frame_name()
  if not self.current then return nil end
  local anim = self.animations[self.current]
  return string.format(anim.image_format, self.frame)
end

return Animator
