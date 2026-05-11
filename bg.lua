local manager = { lag_scale = 1 }
local effects = {"lfc", "tbp", "util"}
Wormhole.bg_manager = manager
local conf = Wormhole.config
local cooldown = 1.1
local target = 0.016
local lw, lh

function manager:smart_scale(shader)
    if not self.lag_scale then
        self.lag_scale = 1
    end
    if not self.canvas then
        self.canvas_scale = self.lag_scale
        self.canvas_w = math.ceil(lw / self.canvas_scale)
        self.canvas_h = math.ceil(lh / self.canvas_scale)
        self.canvas = love.graphics.newCanvas(self.canvas_w, self.canvas_h)
    end
    love.graphics.push("all")
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear()
    love.graphics.setShader(shader)
    love.graphics.rectangle("fill", 0, 0, self.canvas_w, self.canvas_h)
    love.graphics.setCanvas()
    love.graphics.pop()
    love.graphics.draw(self.canvas, 0, 0, 0, self.canvas_scale, self.canvas_scale)
    if cooldown <= 0 and self.lag_scale < 6 then
        local time = love.timer.getAverageDelta()
        if time > target and time < 3 then -- Big time like this is likely we got backgrounded
            local difference = time - target
            local times = (difference / target)
            if times > 0.2 then
                self.lag_scale = self.lag_scale + math.min((times / 3), 1)
                self.canvas = nil
            end
        end
        cooldown = 1.2
    end
    cooldown = cooldown - love.timer.getDelta()
end

function manager:draw()
    if G.STAGE ~= G.STAGES.MAIN_MENU then return end
    if not conf.menu then return end
    if not self.chosen then manager:reset() end

    if self.chosen == "util" then
        Wormhole.util_space_manager:draw_background(true)
    elseif self.chosen == "tbp" then
        local shader = G.SHADERS.worm_tbp_space_warp
        shader:send("time", G.TIMERS.REAL)
        shader:send("transparency", 1)
        self:smart_scale(shader)
    elseif self.chosen == "lfc" then
        local shader = G.SHADERS.worm_lfc_eigengrau_bg
        shader:send("time", G.TIMERS.REAL_SHADER)
        shader:send("alpha", 1)
        self:smart_scale(shader)
    end

    if self.splash_args then
        if not self.splash_args.mid_flash or self.splash_args.mid_flash == 0 then
            self.splash_args = nil
        else
            local opacity = self.splash_args.mid_flash / 1.6
            love.graphics.setColor({1, 1, 1, opacity})

            love.graphics.rectangle("fill", 0, 0, lw, lh)
            love.graphics.setColor(G.C.WHITE)
        end
    end
end

function manager:reset()
    if self.chosen == "util" then
        Wormhole.util_space_manager:reset()
    end
    self.chosen = pseudorandom_element(effects)
    self.lag_scale = 1
end

local game_delete_run = Game.delete_run
function Game:delete_run()
    if G.STAGE ~= G.STAGES.MAIN_MENU then
        manager:reset()
    end
    game_delete_run(self)
end

local love_resize_ref = love.resize
function love.resize(w, h)
    if love_resize_ref then love_resize_ref(w, h) end
    if lw == w and lh == h then return end
    lw = w
    lh = h
    manager.lag_scale = 1
    manager.canvas = nil
end
