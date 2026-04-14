Wormhole = SMODS.current_mod

if PotatoPatchUtils then
    local file_blacklist = {
        -- Format entries as `['filename.txt'] = true`
    }

    PotatoPatchUtils.load_files(Wormhole.path .. '/content', file_blacklist)
    SMODS.handle_loc_file(Wormhole.path)
    PotatoPatchUtils.LOC.init()

    SMODS.current_mod.extra_tabs = PotatoPatchUtils.CREDITS.register_page(SMODS.current_mod)

    -- Reset Game Globals func to hook
    function Wormhole.reset_game_globals(run_start)
    end
end

Card.is_3 = Card.is_3 or function(self, bypass_debuff)
    if self.debuff and not bypass_debuff then
        return false
    elseif self:get_id() == 3 then
        return 1
    end
end

Wormhole.mrrp_signed = function(val, invert, signlesszero)
    local sign = ""
    if not val then
        return
    end
    if next(SMODS.find_mod("Talisman")) then
        -- temporary
        return val
    else
        if val > 0 then
            sign = invert and "-" or "+"
        elseif val < 0 then
            sign = invert and "+" or "-"
        elseif val == 0 and not signlesszero then
            sign = invert and "-" or "+"
        end
    end
    return sign .. math.abs(val)
end

to_big = to_big or function(x, y)
    return x 
end
to_number = to_number or function(x)
    return x 
end

SMODS.Atlas {
    key = "mrrp",
    path = "mrrp mew meow/mrrp-cards.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "mrrp_stake",
    path = "mrrp mew meow/mrrp-stakes.png",
    px = 29,
    py = 29
}
