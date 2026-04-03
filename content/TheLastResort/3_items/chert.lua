SMODS.Joker {
    key = 'tlr_chert',
    set = 'Joker',
	pos = { x = 0, y = 0 },
    rarity = 2,
	cost = 6,
    blueprint_compat = true,

    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    local const = create_card('worl_tlr_consteallation', G.consumeables, nil, nil, nil, nil, nil, 'tlr_chert')
                    const:add_to_deck()
                    G.consumeables:emplace(const)
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot')})
        end
    end,
    ppu_team = {"TheLastResort"},
	ppu_coder = {"Amphiapple"}
}