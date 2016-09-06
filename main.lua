--[[ main.lua

     To have dispatch start up love for you:
     :set makeprg=love\ .
     :autocmd BufWritePost *.lua Make!
  ]]

local res = {}
s = "Hello world!"
spos = { x = 250, y = 300 }
center = { x = 300, y = 400 }
mouseinfo = {
    pressed = false,
    dragged = { x = 0, y = 0 }
}

-- run once at init time
function love.load()
    res.font = love.graphics.newFont("mentone-semibold.otf", 60)
    love.graphics.setFont(res.font)
    love.graphics.setColor(255, 255, 255, 255)
end

-- run once each frame
function love.update(dt)
end

-- run after love.update() each frame
function love.draw()
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.circle("fill", center.x, center.y, 1, 5)
    local x, y = spos.x, spos.y
    -- love.graphics.printf( text, x, y, limit, align )

    local mx, my = love.mouse.getPosition()
    local foo, bar = 0, 0
    if mx > center.x then
        foo = 1
    elseif mx < center.x then
        foo = -1
    end
    if my > center.y then
        bar = 1
    elseif my < center.y then
        bar = -1
    end

    for step = 10, 1, -1 do
        love.graphics.setColor(255 - step * 20, 255 - step * 20, 255 - step * 20, 255)
        love.graphics.printf(
            s,
            x + step * mouseinfo.dragged.x,
            y + step * mouseinfo.dragged.y,
            600 - x,
            "left"
        )
    end

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(s, x, y, 600 - x, "left")
end

-- https://love2d.org/wiki/KeyConstant
function love.keypressed(key)
    -- printables and space
    if key:len() == 1 or key == "space" then
        s = s .. key
    elseif key == "backspace" then
        s = s:sub(1, -2)
    elseif key == "return" then
        s = s .. "\n"
    elseif key == "up" then
        spos.y = spos.y - 5
    elseif key == "down" then
        spos.y = spos.y + 5
    elseif key == "left" then
        spos.x = spos.x - 5
    elseif key == "right" then
        spos.x = spos.x + 5
    end
end

function love.mousepressed(x, y, button)
    mouseinfo.pressed = true
    mouseinfo.dragged = { x = 0, y = 0 }
end

function love.mousereleased(x, y, button)
    mouseinfo.pressed = false
end

function love.mousemoved(x, y, dx, dy)
    local mi = mouseinfo
    if mi.pressed then
        mi.dragged = {
            x = mi.dragged.x + dx,
            y = mi.dragged.y + dy
        }
    end
end
