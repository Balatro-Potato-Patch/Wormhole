-- WHO TOUCHA MY SPAGHET!?

SMODS.Joker {
	key = 'dum_spaghet',
	config = { extra = { chips = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.signed(card.ability.extra.chips) } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'DummiesJokers',
	pos = { x = 10, y = 1 },
	soul_pos = { x = 11, y = 1 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then return { chips = card.ability.extra.chips } end
		
		if context.blueprint or context.retrigger_joker then return end
		
		if context.pre_discard and context.full_hand then
			local _, _, ph = G.FUNCS.get_poker_hand_info(context.full_hand)
			
			local fph
			for _, p in ipairs(G.handlist) do
				if next(ph[p]) then
					fph = p
					break
				end
			end
			
			local planet
			for i, v in ipairs((G.consumeables or {}).cards) do
				if v and v.ability.set == 'Planet' and v.ability.consumeable.hand_type == fph then planet = v; break end
			end
			
			if planet and not planet.spaghettified then
				planet.spaghettified = true
				SMODS.destroy_cards(planet)
			end
		end
		
		if context.joker_type_destroyed and context.card and context.card.ability.set == 'Planet' and context.card.spaghettified then
			local fph = context.card.ability and context.card.ability.consumeable and context.card.ability.consumeable.hand_type
			if fph and G.GAME.hands[fph] and G.GAME.hands[fph].l_chips then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_table = G.GAME.hands[fph],
					scalar_value = "l_chips"
				})
			end
		end
	end,
	ppu_coder = { "theonegoofali" },
	ppu_artist = { "theonegoofali" },
	ppu_team = { "dummies" },
	attributes = { "space", "planet", "discard", "scaling", "chips" }
}