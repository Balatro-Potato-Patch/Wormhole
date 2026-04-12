---@diagnostic disable: undefined-field

local function drunk_level_chance(card, probability_numerator, probaility_denominator, next_edition, seed)
    if SMODS.pseudorandom_probability(card, seed or "hedonia_drunk", probability_numerator, probaility_denominator) then
        card:set_edition(next_edition, true) --TODO add timer call so the return text happens at the same time
        return true
    end
    return false
end

local function drunk_change_rank(card, rank_range, msg_increase, msg_decrease)
    local amount = pseudorandom("drunk_range", -rank_range, rank_range + 0.999)
    amount = math.floor(amount)
    if SMODS.pseudorandom_probability(card, "drunk_change", 1, 2, "", true) then
        assert(SMODS.modify_rank(card, amount))
        return msg_increase
    end
    assert(SMODS.modify_rank(card, amount))
    return msg_decrease
end

local function drunk_behaviour(self, card, context)
    if context.main_scoring and context.cardarea == G.hand then
        if drunk_level_chance(card, self.config.extra.sober_base, self.config.extra.sober_chance, self.config.extra.edition_soberer) then
            return { message = "Sobered Up!" }
        end
    end

    if context.main_scoring and context.cardarea == G.play then
        return { message = drunk_change_rank(card, self.config.extra.rank_range, self.config.extra.msg_increase, self.config.extra.msg_decrease)}
    end

    if context.destroy_card and context.cardarea == G.play then -- level here so we don't double trigger
        if drunk_level_chance(card, self.config.extra.drunker_base, self.config.extra.drunker_chance, self.config.extra.edition_drunker) then
            return { message = "Kept Going!" }
        end
    end
end


SMODS.Edition {
    key = "hedonia_tipsy",
    shader = "hedonia_shader_drunk", -- TODO actually write the shader
    -- shader = false,
    loc_txt = { name = 'Tipsy', text = { '{C:green}#1# in #2#{} chance', 'to sober up', '{C:green}#3# in #4#{} chance', 'to get drunker', 'Cards played have a random rank', '{s:0.8}{C:inactive}(max variance: #5#)'}, label = 'Tipsy' },
    in_shop = false,            -- TODO discuss adding to shop if a bartender is owned as a hidden mechanic, see in_pool()
    extra_cost = -1,
    pools = {
        ["Drunk"] = true
    },
    disable_base_shader = true, -- shader will modify card shape when implimented so this should be true

    on_apply = function(card)
        card.edition.drunk_wobble_strength = 0.6
    end,
    on_remove = function(card)
        card.edition.drunk_wobble_strength = nil
    end,
    on_load = function(card)
        card.edition.drunk_wobble_strength = 0.6
    end,
    config = { extra = { 
            sober_base = 1, -- sober_base in sober_chance chance to sober up  (when held in hand)
            sober_chance = 2,
            drunker_base = 1, -- sober_base in sober_chance chance to get drunker (when played)
            drunker_chance = 4, 
            rank_range = 1, -- how far the rank of the card will swing when played
            edition_drunker = "e_worm_hedonia_drunk", -- the more drunk edition
            edition_soberer = nil, -- the more sober edition
            msg_increase = "I like beer :)", -- message when the rank of the card increases
            msg_decrease = "Too much for me..." -- message when the rank of the card decreases
        } },
    loc_vars = function(self, info_queue, card)
        local sober_base, sober_chance = SMODS.get_probability_vars(card, self.config.extra.sober_base,
            self.config.extra.sober_chance)
        local drunker_base, drunker_chance = SMODS.get_probability_vars(card, self.config.extra.drunker_base,
            self.config.extra.drunker_chance)
        return { vars = { sober_base, sober_chance, drunker_base, drunker_chance, self.config.extra.rank_range } }
    end,

    calculate = function(self, card, context)
        return drunk_behaviour(self, card, context)
    end
}

SMODS.Edition {
    key = "hedonia_drunk",
    shader = "hedonia_shader_drunk", -- TODO actually write the shader
    -- shader = false,
    loc_txt = { name = 'Drunk', text = { '{C:green}#1# in #2#{} chance', 'to sober up', '{C:green}#3# in #4#{} chance', 'to get drunker', 'Cards played have a random rank', '{s:0.8}{C:inactive}(max variance: #5#)'}, label = 'Drunk' },
    in_shop = false,            -- TODO discuss adding to shop if a bartender is owned as a hidden mechanic, see in_pool()
    extra_cost = -1,
    pools = {
        ["Drunk"] = true
    },
    disable_base_shader = true, -- shader will modify card shape when implimented so this should be true

    on_apply = function(card)
        card.edition.drunk_wobble_strength = 1.0
    end,
    on_remove = function(card)
        card.edition.drunk_wobble_strength = nil
    end,
    on_load = function(card)
        card.edition.drunk_wobble_strength = 1.0
    end,
    config = { extra = { 
            sober_base = 1, -- sober_base in sober_chance chance to sober up  (when held in hand)
            sober_chance = 4,
            drunker_base = 1, -- sober_base in sober_chance chance to get drunker (when played)
            drunker_chance = 4, 
            rank_range = 3, -- how far the rank of the card will swing when played
            edition_drunker = "e_worm_hedonia_very_drunk", -- the more drunk edition
            edition_soberer = "e_worm_hedonia_tipsy", -- the more sober edition
            msg_increase = "ANOTHER!", -- message when the rank of the card increases
            msg_decrease = "I'm Feelin' It" -- message when the rank of the card decreases
        } },
    loc_vars = function(self, info_queue, card)
        local sober_base, sober_chance = SMODS.get_probability_vars(card, self.config.extra.sober_base,
            self.config.extra.sober_chance)
        local drunker_base, drunker_chance = SMODS.get_probability_vars(card, self.config.extra.drunker_base,
            self.config.extra.drunker_chance)
        return { vars = { sober_base, sober_chance, drunker_base, drunker_chance, self.config.extra.rank_range } }
    end,

    calculate = function(self, card, context)
        return drunk_behaviour(self, card, context)
    end
}




SMODS.Edition {
    key = "hedonia_very_drunk",
    shader = "hedonia_shader_drunk", -- TODO actually write the shader
    -- shader = false,
    loc_txt = { name = 'Very Drunk', text = {'{C:green}#1# in #2#{} chance', 'to sober up', '{C:green}#3# in #4#{} chance', 'to get drunker', 'Cards played have a random rank', '{s:0.8}{C:inactive}(max variance: #5#)'}, label = 'Very Drunk' },
    in_shop = false,            -- TODO discuss adding to shop if a bartender is owned as a hidden mechanic, see in_pool()
    extra_cost = -1,
    pools = {
        ["Drunk"] = true
    },
    disable_base_shader = true, -- shader will modify card shape when implimented so this should be true

    on_apply = function(card)
        card.edition.drunk_wobble_strength = 1.5
    end,
    on_remove = function(card)
        card.edition.drunk_wobble_strength = nil
    end,
    on_load = function(card)
        card.edition.drunk_wobble_strength = 1.5
    end,
    config = { extra = { 
        sober_base = 1, -- sober_base in sober_chance chance to sober up  (when held in hand)
        sober_chance = 4,
        drunker_base = 1, -- sober_base in sober_chance chance to get drunker (when played)
        drunker_chance = 2, 
        rank_range = 12, -- how far the rank of the card will swing when played
        edition_drunker = "e_worm_hedonia_blackout", -- the more drunk edition
        edition_soberer = "e_worm_hedonia_drunk", -- the more sober edition
        msg_increase = "WAGRBNASBRANJDKW", -- message when the rank of the card increases
        msg_decrease = "Where is the bathroom?" -- message when the rank of the card decreases
    } },
    loc_vars = function(self, info_queue, card)
        local sober_base, sober_chance = SMODS.get_probability_vars(card, self.config.extra.sober_base,
            self.config.extra.sober_chance)
        local drunker_base, drunker_chance = SMODS.get_probability_vars(card, self.config.extra.drunker_base,
            self.config.extra.drunker_chance)
        return { vars = { sober_base, sober_chance, drunker_base, drunker_chance, self.config.extra.rank_range } }
    end,

    calculate = function(self, card, context)
        return drunk_behaviour(self, card, context)
    end
}

SMODS.Edition {
    key = "hedonia_blackout",
    shader = "hedonia_shader_drunk",
    -- shader = false,
    loc_txt = { name = 'Blackout', text = {'{C:green}#1# in #2#{} chance', 'to sober up', '{C:green}#3# in #4#{} chance', 'to {C:red,E:2}self destruct{}' }, label = 'Blackout' },
    in_shop = false,            -- TODO discuss adding to shop if a bartender is owned as a hidden mechanic, see in_pool()
    extra_cost = -1,
    pools = {
        ["Drunk"] = true
    },
    disable_base_shader = true, -- shader will modify card shape when implimented so this should be true

    on_apply = function(card)
        card.edition.drunk_wobble_strength = 20.0
    end,
    on_remove = function(card)
        card.edition.drunk_wobble_strength = nil
    end,
    on_load = function(card)
        card.edition.drunk_wobble_strength = 20.0
    end,
    config = { extra = { 
        sober_base = 1, -- sober_base in sober_chance chance to sober up (when held in hand)
        sober_chance = 2,
        destroy_base = 1, -- destroy_base in destroy_chance chance to be destroyed (when played)
        destroy_chance = 2, 
    } },
    loc_vars = function(self, info_queue, card)
        local sober_base, sober_chance = SMODS.get_probability_vars(card, self.config.extra.sober_base,
            self.config.extra.sober_chance)
        local destroy_base, destroy_chance = SMODS.get_probability_vars(card, self.config.extra.destroy_base,
            self.config.extra.destroy_chance)
        return { vars = { sober_base, sober_chance, destroy_base, destroy_chance } }
    end,

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.hand then
            if drunk_level_chance(card, self.config.extra.sober_base, self.config.extra.sober_chance, nil) then
                return { message = "Sobered up!" }
            end
        end
        if context.destroy_card and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, "hedonia_blackout",self.config.extra.destroy_base, self.config.extra.destroy_chance) then
                return { message = "Banned for life...",
                remove = true
                }
            end
        end
    end
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
