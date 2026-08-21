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
        if self.active or self.bg_active then
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
        local hand = nil
        if G.STATE == G.STATES.SELECTING_HAND then
            self.in_hand = false
            self.targetHand = nil
            self.had_flipped = false
            if G.hand and G.hand.highlighted and #G.hand.highlighted > 0 then
                local any_flipped = false
                for _, card in ipairs(G.hand.highlighted) do
                    if card.facing == "back" then
                        any_flipped = true
                        self.had_flipped = true
                        break
                    end
                end
                if not any_flipped then
                    hand = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
                    if hand and G.GAME.hands[hand] and (G.GAME.hands[hand].visible or SMODS.is_poker_hand_visible(hand)) then
                        self.targetHand = hand
                    end
                end
            end
        elseif G.STATE == G.STATES.HAND_PLAYED then
            self.in_hand = true
            if self.had_flipped and G.play and G.play.cards and #G.play.cards > 0 then
                hand = G.FUNCS.get_poker_hand_info(G.play.cards)
                if hand and hand ~= '' and G.GAME.hands[hand] and (G.GAME.hands[hand].visible or SMODS.is_poker_hand_visible(hand)) then
                    self.targetHand = hand
                end
            end
        elseif self.in_hand then
            self.targetHand = nil
            self.had_flipped = false
            self.in_hand = false
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
    if SMODS.is_active_blind("bl_worm_lfc_eigengrau", true) then return end
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

function manager:draw_background(title)
    if not self.bg_active and not title then return end

    local conf = self.bg_conf
    if title then
        if not self.title_conf then
            self.title_conf = Wormhole.util_calc_space({ options = pseudorandom(math.random(), 1, 5) }, math.random())
        end
        conf = self.title_conf
    end

    if not conf then return sendWarnMessage("BG Shader active but no conf??", "SpaceManager") end
    local shader = self.manualSend(conf, 1)
    local w, h = love.graphics.getDimensions()
    local scale = love.window.toPixels(G.TILESCALE*G.TILESIZE*G.CANV_SCALE / 15)
    local cw = math.ceil(w / scale)
    local ch = math.ceil(h / scale)
    if not manager.canvas then
        manager.canvas = love.graphics.newCanvas(cw, ch)
        manager.canvas:setFilter("nearest", "nearest")
    end
    love.graphics.push("all")
    love.graphics.setCanvas(manager.canvas)
    love.graphics.setShader(shader)
    love.graphics.rectangle("fill", 0, 0, cw, ch)
    love.graphics.pop()
    love.graphics.push()
    love.graphics.setColor(1, 1, 1, title and 1 or self.bg_transparency)
    love.graphics.draw(manager.canvas, 0, 0, 0, scale)
    love.graphics.pop()

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
    self.title_conf = nil
end

function manager.manualSend(conf, scale)
    local shader = G.SHADERS.worm_util_space
    scale = scale or G.TILESCALE*G.TILESIZE*G.CANV_SCALE / 15
    shader:send("screen_scale", scale)
    shader:send("time", G.TIMERS.REAL)
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
    if G.STATES == G.STATES.SPLASH then -- Don't reset title screen
        manager:reset()
    end
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
    draw = function(self, shader, canvas)
        local w, h = love.graphics.getDimensions()
        local scale = G.TILESCALE*G.TILESIZE*G.CANV_SCALE / 15
        local cw = math.ceil(w / scale)
        local ch = math.ceil(h / scale)
        if not manager.canvas then
            manager.canvas = love.graphics.newCanvas(cw, ch)
        end
        love.graphics.push("all")
        love.graphics.setCanvas(manager.canvas)
        love.graphics.setShader(shader)
        love.graphics.rectangle("fill", 0, 0, cw, ch)
        love.graphics.pop()
        love.graphics.setShader()
        love.graphics.push("all")
        if manager.transparency ~= 1 then
            love.graphics.draw(canvas)
            love.graphics.setColor(1, 1, 1, manager.transparency)
        end
        love.graphics.draw(manager.canvas, 0, 0, 0, scale)
        love.graphics.pop()

        if manager.overlay then
            love.graphics.setCanvas({love.graphics.getCanvas(), stencil = true})
            for k,v in ipairs(Wormhole.util_space_manager.overlay) do
                love.graphics.push("all")
                love.graphics.setShader()
                G.OVERLAY_TUTORIAL = true
                v:translate_container()
                v:draw()
                G.OVERLAY_TUTORIAL = nil
                love.graphics.pop()
            end
        end
    end,
    send_vars = function()
        local conf = manager.conf
        return {
            screen_scale = 1,
            time = G.TIMERS.REAL,
            seed = conf.seed,
            nebula_color1 = conf.nebula1,
            nebula_color2 = conf.nebula2,
            nebula_color3 = conf.nebula3,
            shooting = conf.shooting,
        }
    end
}

local love_resize_ref = love.resize
function love.resize(w, h)
    love_resize_ref(w, h)
    manager.canvas = nil
end
