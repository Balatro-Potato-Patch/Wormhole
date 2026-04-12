SMODS.Voucher {
	key = 'tlr_stargazing',
	atlas = 'tlr_voucher',
	pos = { x = 1, y = 0 },
	ppu_coder = {"Amphiapple"},
	ppu_artist = {"Aura2247"},
	ppu_team = {"TheLastResort"},
	cost = 10,

	calculate = function(self, card, context)
		if context.modify_shop_card and context.card.ability.set == 'worm_tlr_constellation' then
			if pseudorandom('tlr_stargazing') > 0.67 then
				context.card.ability.tier = context.card.ability.tier + 1
				WORM_TLR.update_const_sprite(context.card.config.center, context.card)
			end
		end
	end
}
