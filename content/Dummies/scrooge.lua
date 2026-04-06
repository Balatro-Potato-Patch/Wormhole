-- Absolutely Space Quackers.

SMODS.Joker {
	key = 'dum_scrooge',
	config = { extra = { money = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.signed_dollars(card.ability.extra.money) } }
	end,
	unlocked = true,
	rarity = 1,
	atlas = 'DummiesJokers',
	pos = { x = 9, y = 1 },
	cost = 4,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before and context.poker_hands then
			local chp = {}
			for k, v in pairs((G.consumeables or {}).cards) do
				if v and v.ability.set == 'Planet' and tostring(v.ability.consumeable.hand_type) and not chp[v.ability.consumeable.hand_type] then
					chp[v.ability.consumeable.hand_type] = true
				end
			end
			
			local pamt = 0
			for k, v in pairs(context.poker_hands) do
				if k and v and next(v) and chp[k] then pamt = pamt + 1 end
			end
			
			if pamt > 0 then return { dollars = card.ability.extra.money*pamt } end
		end
	end,
	ppu_coder = { "theonegoofali" },
	ppu_artist = { "theonegoofali" },
	ppu_team = { "dummies" },
	attributes = { "space", "hand_type", "planet", "economy" }
}