require "vector"
require "mover"
require "liquid"

movers = {}

function love.load()
    love.window.setTitle("Acceleration")
    love.window.setMode(800, 600, {resizable=true})
    love.graphics.setBackgroundColor(34/255, 49/255, 63/255)

    table.insert(movers, Mover:create(Vector:create(250, 150), Vector:create(0, 0), 100, 30, 1))
    table.insert(movers, Mover:create(Vector:create(550, 150), Vector:create(0, 0), 40, 40, 2))

    water = Liquid:create(0, 300, 800, 300, 0.02)
    gravity = Vector:create(0, 0.1)
end

function love.update(dt)
    for _, mover in ipairs(movers) do
        mover:applyForce(gravity)

    friction = (mover.velocity * -1):norm()
    if friction then
        friction:mul(0.03)
        mover:applyForce(friction)
    end
        
    if water:isInside(mover) then
        local pixel_to_reality_coef = 10000000
        local V = mover.width * mover.height * (water.y + water.h - mover.location.y) / (pixel_to_reality_coef * 2)
        local g = 9.81
        local Fa = g * V + 1.0 
        local mag = mover.velocity:mag()
        local drag = water.c * mag * mag * mag * Fa 
        local dragVec = mover.velocity:norm() * -dragя
        mover:applyForce(dragVec)
    end

        mover:checkBoundaries()
        mover:update()
    end
end

function love.draw()
    love.graphics.setColor(255/255, 255/255, 255/255)

    for _, mover in ipairs(movers) do
        mover:draw()
    end

    love.graphics.setColor(0/255, 128/255, 255/255)
    water:draw()
end