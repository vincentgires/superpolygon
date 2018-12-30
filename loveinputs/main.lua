inputengine = require 'inputengine'
serialize = require 'serialize'

function love.load()
    input = inputengine:new()
    local jump_control = {device='joystick', number=2, event='button', value=1}
    local left_control = {device='joystick', number=2, event='hat', index=1, value='l'}
    local right_control = {device='joystick', number=2, event='hat', index=1, value='r'}
    local click_control = {device='mouse', event='button', value=1}
    local key_control = {device='keybord', value='space'}
    local axe_control = {device='joystick', number=2, event='axis', index=2, value=1}
    local trigger_control = {device='joystick', number=2, event='axis', index='triggerleft', value=1}
    local axis_left_control = {device='joystick', number=2, event='axis', index='leftx', value=-1}
    local axis_right_control = {device='joystick', number=2, event='axis', index='leftx', value=1}
    local axis2_left_control = {device='joystick', number=2, event='axis', index='rightx', value=-1}
    local axis2_right_control = {device='joystick', number=2, event='axis', index='rightx', value=1}
    -- ??? local axis2_right_control = {device='joystick', number=2, event='axis', index='rightx', value='+'} ???
    -- ??? local axis2_right_control = {device='joystick', number=2, event='axis', index='rightx', value='-'} ???
    input:bind_action('jump', jump_control)
    input:bind_action('left', left_control)
    input:bind_action('right', right_control)
    input:bind_action('click', click_control)
    input:bind_action('key', key_control)
    input:bind_action('axe', axe_control)
    input:bind_action('trigger', trigger_control)
    input:bind_action('left axis', axis_left_control)
    input:bind_action('right axis', axis_right_control)
    input:bind_action('left axis2', axis2_left_control)
    input:bind_action('right axis2', axis2_right_control)
end

function love.update(dt)
    if #input.active_actions > 0 then
        serialize.print_table(input.active_actions) end

    -- needed to detect pressed/released actions
    input:update(dt)

    if input:is_pressed('jump') then
        print(input:is_pressed('jump'))
    end

    if input:is_released('jump') then
        print(input:is_released('jump'))
    end

    -- force console output
    io.flush()
end

function love.draw()

end
