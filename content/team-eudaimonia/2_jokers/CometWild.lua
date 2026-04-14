SMODS.Atlas {
    key = 'euda_cometwildatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/CometWild.png', --Update with actual art
}

SMODS.Joker {
    key = "euda_cometwild",
    atlas = 'euda_cometwildatlas',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    discovered = true,
    ppu_team = {"TeamEudaimonia"},
    ppu_coder = {'M0xes'},
    ppu_artist = {'M0xes'},
    config = { extra= {xmult = 1.5} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return { vars = {card.ability.extra.xmult} }
    end,
    add_to_deck = function(self, card, from_debuff)
        for _, playing_card in ipairs(G.hand and G.hand.cards or {}) do
            SMODS.recalc_debuff(playing_card)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for _, playing_card in ipairs(G.hand and G.hand.cards or {}) do
            SMODS.recalc_debuff(playing_card)
        end
    end,
    calculate = function(self, card, context)
        if context.individual
        and context.cardarea == G.play
        and SMODS.has_enhancement(context.other_card, 'm_wild') then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}


local set_debuff_ref = Card.set_debuff
function Card:set_debuff(val)
    if SMODS.has_enhancement(self, 'm_wild') and next(SMODS.find_card("j_worm_euda_cometwild")) and val then
		return set_debuff_ref(self, false)
    end
    return set_debuff_ref(self, val)
end
