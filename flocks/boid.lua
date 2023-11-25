Boid = {}
Boid.__index = Boid

function Boid:create(x, y)
    local boid = {}
    setmetatable(boid, Boid)
    boid.position = Vector:create(x, y)
    boid.velocity = Vector:create(math.random(-10, 10) / 10, math.random(-10, 10) / 10)
    boid.acceleration = Vector:create(0, 0)
    boid.r = 5
    boid.vertices = {0, -boid.r * 2, -boid.r, boid.r * 2, boid.r, 2 * boid.r}
    boid.maxSpeed = 4
    boid.maxForce = 0.1
    boid.color = {
        r = 1,
        g = 0,
        b = 1
    }
    return boid
end

function Boid:update(boids)
    self:setColor(boids)

    if isSep then
        local sep = self:separate(boids)
        self:applyForce(sep)
    end
    if isAlign then
        local align = self:align(boids)
        self:applyForce(align)
    end

    if isCoh then
        local cohesion = self:cohesion(boids)
        self:applyForce(cohesion)
    end

    self.velocity:add(self.acceleration)
    self.velocity:limit(self.maxSpeed)
    self.position:add(self.velocity)
    self.acceleration:mul(0)
    self:borders()
end

function Boid:applyForce(force)
    self.acceleration:add(force)
end

function Boid:seek(target)
    local desired = target - self.position
    desired:norm()
    desired:mul(self.maxSpeed)
    local steer = desired - self.velocity
    steer:limit(self.maxForce)
    return steer
end

function Boid:separate(boids)
    local separation = 25.
    local steer = Vector:create(0, 0)
    local count = 0
    for i = 0, #boids do
        local boid = boids[i]
        local d = self.position:distTo(boid.position)
        if d > 0 and d < separation then
            local diff = self.position - boid.position
            diff:norm()
            diff:div(d)
            steer:add(diff)
            count = count + 1
        end
    end

    if count > 0 then
        steer:div(count)
    end

    if steer:mag() > 0 then
        steer:norm()
        steer:mul(self.maxSpeed)
        steer:sub(self.velocity)
        steer:limit(self.maxForce)
    end

    return steer
end

function Boid:align(boids)
    local align = 50.
    local steer = Vector:create(0, 0)
    local count = 0
    for i = 0, #boids do
        local boid = boids[i]
        local d = self.position:distTo(boid.position)
        if d > 0 and d < align then
            steer:add(boid.velocity)
            count = count + 1
        end
    end

    if count > 0 then
        steer:div(count)
    end

    if steer:mag() > 0 then
        steer:norm()
        steer:mul(self.maxSpeed)
        steer:sub(self.velocity)
        steer:limit(self.maxForce)
    end

    return steer
end

function Boid:cohesion(boids)
    local cohesion = 50.
    local steer = Vector:create(0, 0)
    local count = 0

    for i = 0, #boids do
        local boid = boids[i]
        local d = self.position:distTo(boid.position)
        if d > 0 and d < cohesion then
            local diff = boid.position - self.position
            diff:norm()
            diff:div(d)
            steer:add(diff)
            count = count + 1
        end
    end

    if count > 0 then
        steer:div(count)
    end

    if steer:mag() > 0 then
        steer:norm()
        steer:mul(self.maxSpeed)
        steer:sub(self.velocity)
        steer:limit(self.maxForce)
    end

    return steer
end

function Boid:setColor(boids)
    local colorRadius = 50.
    local count = 0

    for i = 0, #boids do
        local boid = boids[i]
        local d = self.position:distTo(boid.position)
        if d > 0 and d < colorRadius then
            count = count + 1
        end
    end

    local hue = (count / colorRadius) * 360

    local r, g, b = hsvToRgb(hue, 1, 1)

    self.color = {
        r = r,
        g = g,
        b = b
    }

    love.graphics.setColor(r, g, b, 1)
end

function hsvToRgb(h, s, v)
    local c = v * s
    local x = c * (1 - math.abs((h / 60) % 2 - 1))
    local m = v - c

    local r, g, b

    if h < 60 then
        r, g, b = c, x, 0
    elseif h < 120 then
        r, g, b = x, c, 0
    elseif h < 180 then
        r, g, b = 0, c, x
    elseif h < 240 then
        r, g, b = 0, x, c
    elseif h < 300 then
        r, g, b = x, 0, c
    else
        r, g, b = c, 0, x
    end

    return (r + m), (g + m), (b + m)
end


function Boid:borders()
    if self.position.x < -self.r then
        self.position.x = width - self.r
    end
    if self.position.x > width + self.r then
        self.position.x = self.r
    end

    if self.position.y < -self.r then
        self.position.y = height - self.r
    end
    if self.position.y > height + self.r then
        self.position.y = self.r
    end
end

function Boid:draw()
    local r, g, b, a = love.graphics.getColor()

    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    local theta = self.velocity:heading() + math.pi / 2
    love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)
    love.graphics.rotate(theta)
    love.graphics.polygon('fill', self.vertices)
    love.graphics.pop()

    love.graphics.setColor(r, g, b, a)
end