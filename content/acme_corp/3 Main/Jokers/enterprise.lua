SMODS.Joker {
	key = 'ACME_enterprise',
	atlas = 'ACME_jokers',
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	ppu_coder = {'Youh', 'RadiationV2'},
	ppu_artist = {'FlameThrowerFIM'},
	pos = { x = 3, y = 0 },
	config = {
		extra = {
			chip_gain = 20
		},
		lastUsedConsumables = {},
	},
	loc_vars = function(self, info_queue, center)
		local planets_used = 0
		for k, v in pairs(G.GAME.consumeable_usage) do
			if v.set == "Planet" then
				planets_used = planets_used + 1
			end
		end
		return {
			vars = {
				center.ability.extra.chip_gain, center.ability.extra.chip_gain * planets_used
			}
		}
	end,
	calculate = function(self, card, context)
		local planets_used = 0
		for k, v in pairs(G.GAME.consumeable_usage) do
			if v.set == "Planet" then
				planets_used = planets_used + 1
			end
		end

		if context.using_consumeable then
			local collected = false
			if (card.ability.lastUsedConsumables) then
				for key, _ in pairs(card.ability.lastUsedConsumables) do
					if key == context.consumeable.config.center.key then
						collected = true
					end
				end
			end

			card.ability.lastUsedConsumables = {}
			for k, v in pairs(G.GAME.consumeable_usage) do
				card.ability.lastUsedConsumables[k] = v
			end

			if not collected and context.consumeable.config.center.set == 'Planet' then
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS
				}
			end
		end

		if context.joker_main then
			return {
				chips = card.ability.extra.chip_gain * planets_used,
			}
		end
	end,

	add_to_deck = function(self, card, from_debuff)
		card.ability.lastUsedConsumables = {}
		for k, v in pairs(G.GAME.consumeable_usage) do
			card.ability.lastUsedConsumables[k] = v
		end
	end,
}