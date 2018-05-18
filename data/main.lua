--[[
TODO

]]

require 'player'
require 'utils'
require 'block'
require 'collision'
scene = require 'scene'
camera = require 'camera'

function love.load()
    love.window.setTitle('Super Polygon')

    local player1 = Player:new()
    player1.key_left = 'left'
    player1.key_right = 'right'
    player1.color = {1, 0, 1}

    local player2 = Player:new()
    player2.key_left = 'q'
    player2.key_right = 'd'
    player2.color = {0, 1, 1}

    --players = {player1, player2}
    players = {player1}

    -- first pattern
    local group, segments = get_random_group()
    block_sequence:add_group(group, segments)

end

function love.update(dt)
    scene:update(dt)
    camera:update(dt)
    block_sequence:update(dt)

    -- camera

    -- seconds timer
    if scene.base_time > 1 then
        camera.angle_timer = camera.angle_timer - 1
    end

    -- player
    for i, player in pairs(players) do
        player:update(dt)
    end

    -- check collisions
    check_collision()

    -- force console output
    io.flush()
end

function love.draw()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    love.graphics.translate(width/2, height/2)

    -- camera
    love.graphics.rotate(camera.angle)
    love.graphics.scale(camera.scale)

    -- blocks
    for i, block in pairs(block_sequence.blocks) do
        block:draw()
    end

    -- circle
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", 0, 0, 40, scene.segments)

    -- center
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('line', -5, -5, 10, 10)

    -- player
    for i, player in pairs(players) do
        player:draw()
    end

    -- ||test|| draw impact to debug wrong collision
    local check, x, y = check_collision()
    if check then
        love.graphics.circle('fill', x, y, 10)
    end

    -- text overlay
    love.graphics.reset()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('Timer: ' .. scene.seconds, 0, 0)
    for i, p in pairs(players) do
        local y = 20
        love.graphics.print(
            'Player' .. i .. ' - Failure ' .. p.failure, 0, y+(i*50))
    end
end

function love.keypressed(key)
--     if key == 'left' then
--         print('left')
--     end
-- 
--     if key == 'right' then
--         print('right')
--     end

    if key == 'f' then
        if love.window.getFullscreen() then
            love.window.setFullscreen(false, "desktop")
        else
            love.window.setFullscreen(true, "desktop")
        end
    end

    if key == 'escape' then
        love.event.quit()
    end
end
