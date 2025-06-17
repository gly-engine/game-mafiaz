local assets = require('src/shared/assets')
local Player = require('src/entity/Player')

local function init(std, game)
    game.player = Player()
end

local function loop(std, game)
    game.player:update(std)
end

local function draw(std, game)
    game.player:draw(std)
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
