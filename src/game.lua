local assets = require('src/shared/assets')
local World = require('src/scenario/World')

local function init(std, game)
    game.world = World:new({
        zombies = 5
    })
end

local function loop(std, game)
    game.world:update(std)
end

local function draw(std, game)
    game.world:draw(std)
end

local function exit(std, game)
    game.world:delete()
    game.world = nil
end

local P = {
    meta={
        title='MafiaZ',
        author='RodrigoDornelles',
        description='extremely generic game about zombies and mafia to demonstrate gly engine.',
        version='1.0.0'
    },
    config = {
        require = 'math.random'
    },
    assets = assets,
    callbacks={
        init=init,
        loop=loop,
        draw=draw,
        exit=exit
    }
}

return P;
