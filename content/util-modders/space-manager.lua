local manager = {
    active = false,
    bg_active = false,
    transparency = 0.0,
    bg_transparency = 0,
}
Wormhole.util_space_manager = manager

function manager:update(dt)
    -- Manage State
    if G.STAGE ~= G.STAGES.RUN then
        if self.active then
            self:reset()
        end
        return
    end

    if self.active and (G.OVERLAY_MENU or G.screenwipe) then
        self:reset()
    end

    if G.STATE == G.STATES.SMODS_BOOSTER_OPENED then
        local hovered = G.CONTROLLER.hovering.target
        if hovered ~= self.last_hovered then
            self.last_hovered = hovered
            if hovered and Card.is(hovered, Card) and hovered.ability.set == "util_Spaces" and hovered.area == G.pack_cards then
                self.target = hovered
            else
                self.target = nil
            end
            self:recalc_overlay()
        end
    else
        if self.last_hovered or self.target then
            self.last_hovered = nil
            self.target = nil
            self:recalc_overlay()
        end
        local hand = G.GAME.current_round.current_hand.handname
        if hand ~= self.handname then
            self.targetHand = hand
        end
    end

    self:run(dt)
    self:run_bg(dt)
end

function manager:run(dt)
    local target = 1.0
    local rate = 1

    if self.target and self.curr and self.target ~= self.curr then
        rate = 3
    end

    if self.target ~= self.curr or not self.target then
        target = 0.0
    end

    if self.transparency ~= target then
        local dir = target > self.transparency and 1 or -1
        self.transparency = math.max(math.min(self.transparency + dir * (rate * dt), 1.0), 0.0)
    end

    self.active = self.transparency ~= 0.0

    if not self.active and self.target then
        self.curr = self.target
        self.seed = self.target.ability.extra.seed
        self.conf = self.target.ability.extra.space_conf
        self:recalc_overlay()
        self:run(dt) -- That's two frames per frame
    end
end

function manager:run_bg(dt)
    local target = 1.0
    local rate = 3

    if self.targetHand ~= self.handname or not self.targetHand then
        target = 0.0
    end

    if self.bg_transparency ~= target then
        local dir = target > self.bg_transparency and 1 or -1
        self.bg_transparency = math.max(math.min(self.bg_transparency + dir * (rate * dt), 1.0), 0.0)
    end

    self.bg_active = self.bg_transparency ~= 0.0

    if not self.bg_active and self.targetHand then
        self.handname = self.targetHand
        self.bg_conf = self:calc_bg()
        if self.bg_conf then
            self:run_bg(dt) -- That's two frames per frame
        else
            self.bg_transparency = 0
            self.bg_active = false
            self.handname = nil
        end
    end
end

function manager:calc_bg()
    if not self.handname then return end
    local conf = {
        seed = 0,
        nebula1 = G.C.CLEAR,
        nebula2 = G.C.CLEAR,
        nebula3 = G.C.CLEAR,
        shooting = false,
    }
    local some = false
    for _, c in ipairs((G.consumeables or {}).cards or {}) do
        local cc = type(c.ability.extra) == "table" and c.ability.extra.space_conf
        local hand = type(c.ability.extra) == "table" and c.ability.extra.poker_hand
        if cc and hand == self.handname then
            some = true
            conf.seed = conf.seed + cc.seed
            if cc.shooting then conf.shooting = true end
            for i = 1, 3 do
                local n = cc["nebula" .. i]
                if n and n ~= G.C.CLEAR then
                    local on = conf["nebula" .. i]
                    if on == G.C.CLEAR then
                        conf["nebula" .. i] = n
                    else
                        conf["nebula" .. i] = mix_colours(n, on, .5)
                    end
                else
                    break
                end
            end
        end
    end
    if not some then return end
    return conf
end

function manager:draw_background()
    if not self.bg_active then return end

    local conf = self.bg_conf

    if not conf then return sendWarnMessage("BG Shader active but no conf??", "SpaceManager") end
    local shader = self.manualSend(conf, nil, self.bg_transparency)
    if self.bg_transparency == 1 then
        local w, h = love.graphics.getDimensions()
        love.graphics.setShader(shader)
        love.graphics.rectangle("fill", 0, 0, w, h)
        love.graphics.setShader()
    else
        love.graphics.push("all")
        local canvas = love.graphics.getCanvas()
        local tempCanvas = love.graphics.newCanvas(canvas:getWidth(), canvas:getHeight())
        love.graphics.reset()
        love.graphics.setCanvas(tempCanvas)
        love.graphics.setShader(shader)
        love.graphics.draw(canvas, 0, 0)
        love.graphics.setShader()
        love.graphics.setCanvas(canvas)
        love.graphics.draw(tempCanvas, 0, 0)
        love.graphics.pop()
    end

end

function manager:reset()
    self.active = false
    self.bg_active = false
    self.transparency = 0
    self.bg_transparency = 0
    self.last_hovered = nil
    self.target = nil
    self.curr = nil
    self.seed = nil
    self.conf = nil
    self.overlay = nil
    self.handname = nil
    self.targtHand = nil
    self.bg_conf = nil
end

function manager.manualSend(conf, scale, transparency)
    local shader = G.SHADERS.worm_util_space
    scale = scale or G.TILESCALE*G.TILESIZE*G.CANV_SCALE / 15
    transparency = transparency or 1.0
    shader:send("screen_scale", scale)
    shader:send("time", G.TIMERS.REAL)
    shader:send("transparency", transparency)
    shader:send("seed", conf.seed)
    shader:send("nebula_color1", conf.nebula1)
    shader:send("nebula_color2", conf.nebula2)
    shader:send("nebula_color3", conf.nebula3)
    shader:send("shooting", conf.shooting)
    return shader
end

local game_delete_run = Game.delete_run
function Game:delete_run()
    game_delete_run(self)
    manager:reset()
end

function manager:recalc_overlay()
    if not self.curr then
        self.overlay = nil
        return
    end
    local overlay = {self.curr}
    if self.curr.children.h_popup then
        table.insert(overlay, self.curr.children.h_popup)
    end
    self.overlay = overlay
end

local game_update_ref = Game.update
function Game:update(dt)
    game_update_ref(self, dt)
    manager:update(dt)
end

SMODS.ScreenShader {
    key = "util_space",
    path = "util-modders/space.fs",
    order = -1,
    should_apply = function()
        return manager.active
    end,
    send_vars = function()
        local conf = manager.conf
        return {
            screen_scale = G.TILESCALE*G.TILESIZE*G.CANV_SCALE / 15,
            time = G.TIMERS.REAL,
            transparency = manager.transparency,
            seed = manager.seed,
            nebula_color1 = conf.nebula1,
            nebula_color2 = conf.nebula2,
            nebula_color3 = conf.nebula3,
            shooting = conf.shooting,
        }
    end
}
