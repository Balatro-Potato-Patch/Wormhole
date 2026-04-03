SMODS.Voucher {
    key = 'tlr_stargazing',
	set = 'Voucher',
	pos = { x = 0, y = 0 },
	cost = 10,
    config = { extra = { rate = 8 } }, --Variables: rate = power card shop rate

    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.worm_tlr_constellation_rate = card.ability.extra.rate
                return true
            end
        }))
    end
}
