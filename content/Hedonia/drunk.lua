---@diagnostic disable: undefined-field

local function drunk_change_chance(card, probability_numerator, probaility_denominator, next_edition, seed)
    if SMODS.pseudorandom_probability(card, seed or "hedonia_drunk", probability_numerator, probaility_denominator) then
        card:set_edition(next_edition, true) --TODO add timer call so the return text happens at the same time
        return true
    end
    return false
end

SMODS.Edition {
    key = "hedonia_tipsy",
    shader = "hedonia_shader_drunk", -- TODO actually write the shader
    -- shader = false,
    loc_txt = { name = 'Tipsy', text = { 'This is example text' }, label = 'Tipsy' },
    in_shop = false,            -- TODO discuss adding to shop if a bartender is owned as a hidden mechanic, see in_pool()
    extra_cost = -1,
    disable_base_shader = true, -- shader will modify card shape when implimented so this should be true

    on_apply = function(card)
        card.edition.drunk_wobble_strength = 0.6
    end,

    config = { extra = { sober_base = 1, sober_chance = 4, rank_range = 1 } },
    loc_vars = function(self, info_queue, card)
        local sober_base, sober_chance = SMODS.get_probability_vars(card, self.config.extra.sober_base,
            self.config.extra.sober_chance)
        return { vars = { sober_base, sober_chance, self.config.extra.rank_range } }
    end,


    calculate = function(self, card, context)
        -- if held in hand
        -- rng check for chance to sober up
        -- actually sober up
        if context.main_scoring and context.cardarea == G.hand then
            if SMODS.pseudorandom_probability(card, 'tipsy_sober_prob', self.config.extra.sober_base, self.config.extra.sober_chance) then
                card:set_edition(nil, true) --TODO add timer call so the return text happens at the same time
                return { message = "Sobered up!" }
            end
        end
        if context.main_scoring and context.cardarea == G.play then
            -- TODO integrations for bartender manipulation of drunk effect
            if SMODS.pseudorandom_probability(card, "drunk_change", 1, 2, "", true) then
                assert(SMODS.modify_rank(card, 1))
                return { message = "One more can't hurt." }
            end
            assert(SMODS.modify_rank(card, -1))
            return { message = "Beer!" }
        end
    end
}

SMODS.Edition {
    key = "hedonia_drunk",
    shader = "hedonia_shader_drunk", -- TODO actually write the shader
    -- shader = false,
    loc_txt = { name = 'Drunk', text = { 'This is example text' }, label = 'Drunk' },
    in_shop = false,            -- TODO discuss adding to shop if a bartender is owned as a hidden mechanic, see in_pool()
    extra_cost = -1,
    disable_base_shader = true, -- shader will modify card shape when implimented so this should be true

    on_apply = function(card)
        card.edition.drunk_wobble_strength = 1.0
    end,

    config = { extra = { sober_base = 1, sober_chance = 4, drunker_base = 1, drunker_chance = 4, rank_range = 3 } },
    loc_vars = function(self, info_queue, card)
        local sober_base, sober_chance = SMODS.get_probability_vars(card, self.config.extra.sober_base,
            self.config.extra.sober_chance)
        local drunker_base, drunker_chance = SMODS.get_probability_vars(card, self.config.extra.drunker_base,
            self.config.extra.drunker_chance)
        return { vars = { sober_base, sober_chance, self.config.extra.rank_range, drunker_base, drunker_chance } }
    end,


    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.hand then
            if drunk_change_chance(card, self.config.sober_base, self.config.sober_chance, "worm_hedonia_tipsy") then
                return { message = "Sobered up" }
            end
            if drunk_change_chance(card, self.config.drunker_base, self.config.drunker_chance, "worm_hedonia_very_drunk") then
                return { message = "Kept going" }
            end
        end

        if context.main_scoring and context.cardarea == G.play then
            -- TODO integrations for bartender manipulation of drunk effect

            local amount = pseudorandom("drunk_range", -self.config.extra.rank_range, self.config.extra.rank_range +
                0.999)
            amount = math.floor(amount)
            print(amount)
            if SMODS.pseudorandom_probability(card, "drunk_change", 1, 2, "", true) then
                assert(SMODS.modify_rank(card, amount))
                return { message = "ANOTHER!" }
            end
            assert(SMODS.modify_rank(card, amount))
            return { message = "I'm feeling it!" }
        end
    end
}




SMODS.Edition {
    key = "hedonia_very_drunk",
    shader = "hedonia_shader_drunk", -- TODO actually write the shader
    -- shader = false,
    loc_txt = { name = 'Very Drunk', text = { 'This is example text' }, label = 'Very Drunk' },
    in_shop = false,            -- TODO discuss adding to shop if a bartender is owned as a hidden mechanic, see in_pool()
    extra_cost = -1,
    disable_base_shader = true, -- shader will modify card shape when implimented so this should be true

    on_apply = function(card)
        card.edition.drunk_wobble_strength = 1.5
    end,
}

SMODS.Edition {
    key = "hedonia_blackout",
    shader = "hedonia_shader_drunk",
    -- shader = false,
    loc_txt = { name = 'Blackout', text = { 'This is example text' }, label = 'Blackout' },
    in_shop = false,            -- TODO discuss adding to shop if a bartender is owned as a hidden mechanic, see in_pool()
    extra_cost = -1,
    disable_base_shader = true, -- shader will modify card shape when implimented so this should be true

    on_apply = function(card)
        card.edition.drunk_wobble_strength = 20.0
    end,
}



SMODS.Shader {
    key = "hedonia_shader_drunk",
    path = "Hedonia/drunk.fs", -- TODO write the shader
    send_vars = function(sprite, card)
        return {
            wobble_strength = card.edition.drunk_wobble_strength,
            time = love.timer.getTime(),
        }
    end,
}
