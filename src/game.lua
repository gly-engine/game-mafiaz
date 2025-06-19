local assets = require('src/shared/assets')
local Player = require('src/entity/Player')
local Zombie = require('src/entity/Zombie')
local World = require('src/entity/World')

local function init(std, game)
    game.zombie = Zombie()
    game.player = Player()
    game.world = World()
end

local function loop(std, game)
    game.world.parallax:rotate(std.key.axis.x)
    game.world:update(std)
    game.player:update(std)
    game.zombie:update(std)
end

local function draw(std, game)
    game.world:draw(std)
    game.player:draw(std)
    game.zombie:draw(std)
end

local function exit(std, game)
end

local P = {
    meta={
        title='MafiaZ',
        author='RodrigoDornelles',
        description='extremely generic game about zombies and mafia to demonstrate gly engine.',
        version='1.0.0'
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
