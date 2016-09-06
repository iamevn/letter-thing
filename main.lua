-- main.lua
-- To have dispatch start up love for you:
-- :set makeprg=love\ .
-- :autocmd BufWritePost *.lua Make!
res = {}
function love.load()
    res.font = love.graphics.newFont("mentone-semibold.otf", 60)
    love.graphics.setFont(res.font)
end

function love.draw()
    love.graphics.printf("Hello world!", 20, 250, 760, "center")
end
