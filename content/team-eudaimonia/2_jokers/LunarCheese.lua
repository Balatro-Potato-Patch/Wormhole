SMODS.Atlas {
    key = 'euda_lunarcheeseatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/LunarCheese.png', --Update with actual art
}
SMODS.Joker {
    key = "euda_lunarcheese",
    atlas = 'euda_lunarcheeseatlas',
    pos = { x = 0, y = 0 },
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    cost = 8,
    discovered = true,
    config = {extra= {research_length = 3, retriggers = 1} },
    ppu_coder = {'M0xes'},
    ppu_team = {"TeamEudaimonia"},
    ppu_artist = {'Jewel'},
    attributes = {"debuff", "retrigger", "space",},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.research_length, card.ability.extra.retriggers} }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            if not other_joker then
                return
            end
            other_joker.ability.worm_euda_researchprogress = card.ability.extra.research_length
            other_joker.ability.worm_euda_researched_retriggers = (other_joker.ability.worm_euda_researched_retriggers or 0) + card.ability.extra.retriggers
            SMODS.debuff_card(other_joker, true, "worm_euda_research")
            return {
                message = localize("k_worm_euda_lunarcheese_message")
            }
        end
    end
}

local calc_ref = SMODS.current_mod.calculate or function(self, context) return nil end
SMODS.current_mod.calculate = function(self, context)
    if context.retrigger_joker_check then
        local joker = context.other_card
        if (joker.ability.worm_euda_researched_retriggers) then
            local other_return = calc_ref(self, context)
            local other_repititions = other_return and other_return.repetitions or 0
            local tot_repititions = joker.ability.worm_euda_researched_retriggers + other_repititions
            return {
                repetitions = tot_repititions,
                message_card = context.other_card
            }
        end
    end
    if context.end_of_round and not context.game_over  and context.main_eval then
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if (joker.ability.worm_euda_researchprogress and joker.ability.worm_euda_researchprogress > 0) then
                joker.ability.worm_euda_researchprogress = joker.ability.worm_euda_researchprogress - 1
                if (joker.ability.worm_euda_researchprogress <= 0) then
                    joker.ability.worm_euda_researchprogress = nil
                    SMODS.debuff_card(joker, nil, "worm_euda_research")
                end
                SMODS.calculate_effect({message = tostring(joker.ability.worm_euda_researchprogress or 0)}, joker)
            end
        end
    end
    return calc_ref(self, context)
end

local op_features_ref = SMODS.current_mod.optional_features or function() return {} end
SMODS.current_mod.optional_features = function()
    local other_options = op_features_ref()
    other_options.retrigger_joker = true
    return other_options
end
