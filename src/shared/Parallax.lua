local Parallax = {}
Parallax.__index = Parallax

function Parallax.new(tile_w, tile_h)
  return setmetatable({
    tile_w = tile_w,
    tile_h = tile_h,
    viewport_x = 0,
    viewport_y = 0,
    viewport_w = tile_w,
    viewport_h = tile_h,
    layers = {},
    total_offset_y = 0,
  }, Parallax)
end

function Parallax:position(x, y, w, h)
  self.viewport_x = x
  self.viewport_y = y
  self.viewport_w = w
  self.viewport_h = h
end

function Parallax:add(pattern, max_offset_y, start_id, end_id, speed_word, speed_inertial)
  max_offset_y = max_offset_y or 0
  
  table.insert(self.layers, {
    pattern = pattern,
    start_id = start_id,
    end_id = end_id,
    count = end_id - start_id + 1,
    speed_word = speed_word or 0,
    speed_inertial = speed_inertial or 0,
    offset = 0,
    max_offset_y = max_offset_y,
  })
  
  self.total_offset_y = self.total_offset_y + max_offset_y
  
  return self
end

function Parallax:rotate(dx)
  for _, layer in ipairs(self.layers) do
    layer.offset = layer.offset + dx * layer.speed_word
  end
end

function Parallax:update(dt)
  for _, layer in ipairs(self.layers) do
    layer.offset = layer.offset + layer.speed_inertial * dt
  end
end

function Parallax:draw(callback)
  local accumulated_offset = 0
  local ratio = math.min(1, math.max(0, (self.viewport_h - self.tile_h) / (self.total_offset_y)))
  
  for i, layer in ipairs(self.layers) do
    local tw = self.tile_w
    local th = self.tile_h
    local ids = layer.count
    local start_id = layer.start_id

    local vx = self.viewport_x
    local vy = self.viewport_y
    local vw = self.viewport_w

    local tiles_needed = math.ceil(vw / tw) + 2
    local offset_x = layer.offset % (ids * tw)
    local start_x = vx - (offset_x % tw)

    local base_tile_index = math.floor(offset_x / tw)

    for j = 0, tiles_needed do
      local tile_index = (base_tile_index + j) % ids
      local id = start_id + tile_index
      local src = string.format(layer.pattern, id)
      callback(src, start_x + j * tw, vy + accumulated_offset)
    end

    accumulated_offset = accumulated_offset + (layer.max_offset_y * ratio)
  end
end

return Parallax