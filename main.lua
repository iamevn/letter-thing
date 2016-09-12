--[[ main.lua
     To have dispatch start up love for you:
     :set makeprg=love\ .
     :autocmd BufWritePost *.lua Make!
  ]]

local res = {}
local s = "Hello world!"
local spos = { x = 250, y = 300 }
local mouseinfo = {
    pressed = false,
    dragged = { x = 0, y = 0 },
    mag = 0
}
local fonts = {}

-- run once at init time
function love.load()
    math.randomseed(os.time())
    -- try to create ./fonts/ if we need to, error out if it doesn't exist and we can't create it
    if not love.filesystem.isDirectory("fonts") then
        print("couldn't find fonts/\n creating ./fonts/")
        if not love.filesystem.createDirectory("fonts") then
            print("ERROR: couldn't create ./fonts/")
            love.event.quit()
        end
    end
    -- load random font from ./fonts/ if it exists. if it is empty load default font
    local fontfiles = love.filesystem.getDirectoryItems("fonts")
    for i,font in pairs(fontfiles) do
        print("loading "..font)
        fonts[i] = font
    end
    if #fonts > 0 then
        local n = math.random(#fonts)
        print("using ./fonts/"..fonts[n])
        res.font = love.graphics.newFont("fonts/"..fonts[n], 100)
    else
        print("./fonts/ empty, using default (Vera Sans)")
        res.font = love.graphics.newFont(100)
    end
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
