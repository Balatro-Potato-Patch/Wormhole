SMODS.Seal {
    key = 'tlr_star',
    atlas = 'tlr_seal',
    pos = { x = 0, y = 0 },
    badge_colour = SMODS.ConsumableTypes.worm_tlr_constellation.secondary_colour,
    text_colour = SMODS.ConsumableTypes.worm_tlr_constellation.text_colour,
    config = { extra = { percent = 150 } },

    loc_vars = function(self, info_queue, card)
		return {
            vars = {
                self.config.extra.percent
            }
        }
	end,
    calculate = function(self, card, context)
		if context.cardarea == G.play and context.cardarea ~= 'unscoring' and context.after and
                (hand_chips*mult + G.GAME.chips)/G.GAME.blind.chips >= card.ability.seal.extra.percent / 100.0 and
                #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    local const = create_card('worm_tlr_constellation', G.consumeables, nil, nil, nil, nil, nil, 'tlr_star')
                    const.ability.tier = const.ability.tier + 1
                    WORM_TLR.update_const_sprite(const.config.center, const)
                    const:add_to_deck()
                    G.consumeables:emplace(const)
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
            return { message = localize('k_plus_constellation'), colour = SMODS.ConsumableTypes.worm_tlr_constellation.secondary_colour }
		end
	end,
}