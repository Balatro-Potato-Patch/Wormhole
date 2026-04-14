local manager = {
    active = false,
    transparency = 0.0,
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
        return
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
    elseif self.last_hovered or self.target then
        self.last_hovered = nil
        self.target = nil
        self:recalc_overlay()
    end

    self:run(dt)
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

function manager:reset()
    self.active = false
    self.transparency = 0
    self.last_hovered = nil
    self.target = nil
    self.curr = nil
    self.seed = nil
    self.conf = nil
    self.overlay = nil
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
