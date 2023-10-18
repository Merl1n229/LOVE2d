HarmonicWave = {}
HarmonicWave.__index = HarmonicWave

function HarmonicWave:create(A, vel, angle, x_min, x_max, width, height, color1, color2)
    local self = setmetatable({
        A = A,
        vel = vel,
        angle = angle,
        x_min = x_min,
        x_max = x_max,
        height = height,
        width = width,
        x = x_min,
        color1 = color1,
        color2 = color2,
    }, HarmonicWave)
    return self
end

function HarmonicWave:update(dt)
    self.x = self.x + self.vel * dt
    if self.x > self.x_max then
        self.x = self.x_min
    end
end

function HarmonicWave:draw()
    for x = self.x, self.x + self.width, 8 do
        local y = self.A * math.sin((self.angle + x / 150) * 4)
        y = y + self.A * math.sin((self.angle + x / 240) * 7)
        love.graphics.setColor(self.color1)
        love.graphics.circle("line", x, y + self.height / 2, 10)
        love.graphics.setColor(self.color2)
        love.graphics.circle("fill", x, y + self.height / 2, 10)
    end
    self.angle = self.angle + self.vel
end

local wave1, wave2

function love.load()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    wave1 = HarmonicWave:create(20, 0.003, 0, 0, width, width, height, {1, 1, 1}, {0.2, 0.8, 0.2, 0.5})
    wave2 = HarmonicWave:create(30, 0.004, 0, 0, width, width, height, {1, 0, 0}, {0.2, 0.2, 0.8, 0.5})
end

function love.update(dt)
    wave1:update(dt)
    wave2:update(dt)
end

function love.draw()
    wave1:draw()
    wave2:draw()
end

