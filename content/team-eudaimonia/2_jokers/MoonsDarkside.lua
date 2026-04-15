SMODS.Atlas {
    key = 'euda_darksideatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/DarkSideOfTheMoon.png', --Update with actual art
}
SMODS.Joker {
    key = "euda_darkside",
	atlas = 'euda_darksideatlas',
	pos = { x = 0, y = 0},
    soul_pos = { x=1, y=0},
	rarity = 2,
	cost = 6,
	blueprint_compat = false,
    discovered = true,
    ppu_coder = {'M0xes'},
    ppu_artist = {'M0xes'},
    ppu_team = {"TeamEudaimonia"},
    attributes = {"passive", "space",},
    loc_vars = function(self, info_queue, card)
        return { vars = { localize('Spades', 'suits_plural'), localize('Clubs', 'suits_plural') } }
    end
}

local calc_ref = SMODS.current_mod.calculate or function(self, context) return end
SMODS.current_mod.calculate = function(self, context)
    if context.drawing_cards and next(SMODS.find_card("j_worm_euda_darkside")) then
        local black_cards = 0
        for i = #G.deck.cards, 1, -1 do
            if context.amount <= black_cards then
                return
            end
            local playing_card = G.deck.cards[i]
            if playing_card:is_suit('Clubs', nil, true) or playing_card:is_suit('Spades', nil, true) then
                table.remove(G.deck.cards, i)
                table.insert(G.deck.cards, playing_card)
                black_cards = black_cards + 1
                i = i + 1
            end
        end
    end
    return calc_ref(self, context)
end
