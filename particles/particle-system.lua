ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(cls)
    local system = {}
    setmetatable(system, ParticleSystem)
    
    system.cls = cls or Particle

    system.particles = {}
    system.index = 0

    return system
end

function ParticleSystem:draw()
    for _, p in pairs(self.particles) do
        p:draw()
    end
end

function ParticleSystem:update(repeller)
    for _, p in pairs(self.particles) do
        p:update()
    end
    self:applyRepeller(repeller)
end

function ParticleSystem:addParticle(start, _end)
    self.particles[self.index] = self.cls:create(start, _end)
    self.index = self.index + 1
end

function ParticleSystem:applyRepeller(repeller)
    for _, p in pairs(self.particles) do
        local force = repeller:repel(p)
        p:applyForce(force)
    end
end

return ParticleSystem


