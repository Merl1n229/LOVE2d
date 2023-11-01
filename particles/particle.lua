Particle = {}
Particle.__index = Particle

function Particle:create(start, _end)
    local particle = setmetatable({}, Particle)
    particle.start = start
    particle._end = _end
    particle.acceleration = Vector:create(0, 0.05)
    particle.velocity = Vector:create(math.random(-4, 4), math.random(-1, 0))
    particle.lifespan = 200
    particle.decay = 1
    return particle
end

function Particle:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, self.lifespan / 100)
    love.graphics.line(self.start.x, self.start.y, self._end.x, self._end.y)
    love.graphics.setColor(r, g, b, a)
end

function Particle:update()
    if not self:isDead() then
        self.velocity:add(self.acceleration)
        self.start:add(self.velocity)
        self._end:add(self.velocity)
        self.acceleration:mul(0)
        self.lifespan = self.lifespan - self.decay
    end
end

function Particle:applyForce(force)
    if not self:isDead() then
        self.acceleration:add(force)
    end
end

function Particle:isDead()
    return self.lifespan <= 0
end


