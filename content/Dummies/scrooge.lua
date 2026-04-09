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
			local cph = {}
			for k, v in pairs(context.poker_hands) do
				if next(v) then cph[k] = true end
			end
			
			local effects = {}
			for k, v in ipairs((G.consumeables or {}).cards) do
				if v and v.ability.set == 'Planet' and tostring(v.ability.consumeable.hand_type) and cph[v.ability.consumeable.hand_type] then
					table.insert(effects, { dollars = card.ability.extra.money, message_card = v, juice_card = context.blueprint_card or card })
				end
			end
			
			if next(effects) then return SMODS.merge_effects(effects) end
		end
	end,
	ppu_coder = { "theonegoofali" },
	ppu_artist = { "theonegoofali" },
	ppu_team = { "dummies" },
	attributes = { "space", "hand_type", "planet", "economy" }
}