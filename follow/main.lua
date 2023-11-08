require("vector")
require("vehicle")
require("path")

function love.load()
    roadPaths = {}

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    table.insert(roadPaths, Path:create(Vector:create(25, 0), Vector:create(200, 200)))
    table.insert(roadPaths, Path:create(Vector:create(200, 200), Vector:create(600, 400)))
    table.insert(roadPaths, Path:create(Vector:create(600, 400), Vector:create(800, 600)))
    vehicle1 = Vehicle:create(100, 0)
end

function love.update(dt)
    x, y = love.mouse.getPosition()
    mouse = Vector:create(x, y)
    for _,i in pairs(roadPaths) do
        vehicle1:followPath(i)
        vehicle1:update()
        vehicle1:borders()
    end
end

function love.draw()
    for _,i in pairs(roadPaths) do
        i:draw()
    end
    vehicle1:draw()
end
