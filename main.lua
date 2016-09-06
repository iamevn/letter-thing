-- main.lua
-- To have dispatch start up love for you:
-- :set makeprg=love\ .
-- :autocmd BufWritePost *.lua Make!

res = {}

-- run once at init time
function love.load()
    res.font = love.graphics.newFont("mentone-semibold.otf", 60)
    love.graphics.setFont(res.font)
    love.graphics.setColor(255, 255, 255, 255)
end

function love.draw()
    love.graphics.printf("Hello world!", 20, 250, 760, "center")
end
