local assets = require('src/shared/assets')
local World = require('src/scenario/World')
local Player = require('src/entity/Player')
local PlayerGamepad = require('src/control/PlayerGamepad')

local App = {
    meta = {
        title='MafiaZ',
        author='RodrigoDornelles',
        description='extremely generic game about zombies and mafia to demonstrate gly engine.',
        version='1.0.0'
    },
    config = {
        require = 'math.random'
    },
    assets = assets,
    callbacks = {}
}

function App.callbacks:init(std)
    local controller = PlayerGamepad:new()
    local player = Player:new({
        controller = controller,
    })
    self.world = World:new({
        player = player,
        zombies = 5
    })
end

function App.callbacks:loop(std)
    self.world:update(std)
end

function App.callbacks:draw(std)
    self.world:draw(std)
end

function App.callbacks:exit(std)
    self.world:delete()
    self.world = nil
end

return App;
