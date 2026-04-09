SMODS.Atlas {
    key = 'euda_cometwildatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/LunarCheese.png', --Update with actual art
}

SMODS.Joker {
    key = "euda_cometwild",
    atlas = 'euda_cometwildatlas',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    discovered = true,
    ppu_coder = {'M0xes'},
    ppu_artist = {'Jewel'},
    config = { extra= {xmult = 1.5} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return { vars = {card.ability.extra.xmult} }
    end,
    calculate = function(self, card, context)
        if context.press_play then
            for _, playing_card in ipairs(G.hand and G.hand.highlighted or {}) do
                if SMODS.has_enhancement(playing_card, 'm_wild')
                and playing_card.debuff then
                    playing_card:set_debuff(false)
                    playing_card.ability.worm_euda_was_debuffed = true
                end
            end
        end
        if context.individual
        and context.cardarea == G.play
        and SMODS.has_enhancement(context.other_card, 'm_wild')
        and context.other_card.ability.worm_euda_was_debuffed then
            context.other_card.ability.worm_euda_was_debuffed = nil
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

local can_calculate_ref = Card.can_calculate
function Card:can_calculate()
    local ret = can_calculate_ref(self)
    if (next(SMODS.find_card("j_worm_euda_cometwild")))
    and SMODS.has_enhancement(self, 'm_wild')
	and self.debuff then
		return true
    end
    return ret
end
