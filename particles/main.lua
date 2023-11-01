require('vector')
require('particle')
require('particle-system')
require('repeller')
require('rectangle')

local width, height
local repeller
local ps
local rectangles = {}

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    repeller = Repeller:create(width / 2 + 100, height / 2 + 150)
    
    rectangles = {
        Rectangle:create(Vector:create(150, 200), 50, 100),
        Rectangle:create(Vector:create(300, 250), 25, 75),
        Rectangle:create(Vector:create(400, 300), 100, 25)
    }
    
    ps = ParticleSystem:create(Particle)
end

function love.draw()
    ps:draw()
    
    for _, r in pairs(rectangles) do
        r:draw()
    end
end

function love.update()
    ps:update(repeller)
end

function love.mousepressed(x, y, button, istouch, presses)
    for i, r in pairs(rectangles) do
        if r:clicked(ps, x, y) then
            table.remove(rectangles, i)
        end
    end
end

