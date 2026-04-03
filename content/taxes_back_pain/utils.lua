function Card:tbp_has_module(m)
    if self and self.config and self.config.center and self.config.center.key == "j_worm_spaceship" then
        for k, v in ipairs(self.ability.extra.modules) do
            if v[1] == m then return true end
        end
    end
    return false
end