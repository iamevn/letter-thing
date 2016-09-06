--[[ main.lua
     To have dispatch start up love for you:
     :set makeprg=love\ .
     :autocmd BufWritePost *.lua Make!
  ]]

local res = {}
s = "Hello world!"
spos = { x = 250, y = 300 }
mouseinfo = {
    pressed = false,
    dragged = { x = 0, y = 0 },
    mag = 0
}

fonts = {
    "mentone-semibold.otf",
    "Armyd.TTF",
    "3Dumb.ttf",
    "23.ttf",
    "BradBunR.ttf",
    "Bubblegum.ttf",
}
-- run once at init time
function love.load()
    res.font = love.graphics.newFont(fonts[#fonts], 100)
    love.graphics.setFont(res.font)
    love.graphics.setColor(255, 255, 255, 255)
end

-- run once each frame
function love.update(dt)
end

-- run after love.update() each frame
function love.draw()
    love.graphics.clear(65, 173, 246, 255)

    local x, y = spos.x, spos.y
    love.graphics.setColor(248, 138, 65, 255)
    for step = 0.5, 0.01, -1 / mouseinfo.mag do
        -- love.graphics.setColor(255 - step * 20, 255 - step * 20, 255 - step * 20, 255)
        love.graphics.printf(
            s,
            x + step * mouseinfo.dragged.x,
            y + step * mouseinfo.dragged.y,
            800 - x,
            "left"
        )
    end

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(s, x, y, 800 - x, "left")
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
        mi.mag = math.sqrt(mi.dragged.x * mi.dragged.x + mi.dragged.y * mi.dragged.y)
    end
end
