Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle:create(location, w, h)
    local rectangle = setmetatable({}, Rectangle)
    rectangle.location = location
    rectangle.w = w
    rectangle.h = h
    return rectangle
end

function Rectangle:clicked(ps, x, y)
    if x >= self.location.x and x <= self.location.x + self.w and y >= self.location.y and y <= self.location.y + self.h then
        local topLeft = Vector:create(self.location.x, self.location.y)
        local topRight = Vector:create(self.location.x + self.w, self.location.y)
        local bottomRight = Vector:create(self.location.x + self.w, self.location.y + self.h)
        local bottomLeft = Vector:create(self.location.x, self.location.y + self.h)

        ps:addParticle(topLeft:copy(), topRight:copy())
        ps:addParticle(topRight:copy(), bottomRight:copy())
        ps:addParticle(bottomRight:copy(), bottomLeft:copy())
        ps:addParticle(bottomLeft:copy(), topLeft:copy())
        return true
    end
    return false
end

function Rectangle:draw()
    love.graphics.rectangle('line', self.location.x, self.location.y, self.w, self.h)
end

function Rectangle:contains(x, y)
    return x >= self.location.x and x <= self.location.x + self.w and y >= self.location.y and y <= self.location.y + self.h
end

return Rectangle

