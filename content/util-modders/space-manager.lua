local manager = {
    active = false,
    transparency = 0.0,
}
Wormhole.util_space_manager = manager

function manager:update(dt)
    -- Manage State
    if G.STAGE ~= G.STAGES.RUN then
        self.active = false
        if self.last_state then -- TODO: UselesS?
            self:reset()
        end
        return
    end

    if G.STATE == G.STATES.SMODS_BOOSTER_OPENED then
        local hovered = G.CONTROLLER.hovering.target
        if hovered ~= self.last_hovered then
            self.last_hovered = hovered
            if hovered and Card.is(hovered, Card) and hovered.ability.set == "util_Spaces" and not hovered.area.config.collection then
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
        self.seed = self.target.ability.seed
        self:recalc_overlay()
        self:run(dt) -- That's two frames per frame
    end
end

function manager:reset()
    -- TODO: Me, also hook delete run or whatever to call me
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
        return {
            screen_scale = G.TILESCALE*G.TILESIZE*G.CANV_SCALE,
            time = G.TIMERS.REAL,
            transparency = manager.transparency,
            seed = manager.seed,
        }
    end
}
