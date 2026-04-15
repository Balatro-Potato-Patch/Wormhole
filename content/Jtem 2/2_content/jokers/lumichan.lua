SMODS.Atlas({
	key = "jtem2_lumichan",
	path = "Jtem 2/jokers/lumichan.png",
	px = 71,
	py = 95,
})

SMODS.Joker({
	key = "jtem2_lumichan",

	ppu_team = { "jtem2" },
	ppu_coder = { "lexi" },
	ppu_artist = { "missingnumber" },

	rarity = 3,
	cost = 10,

	blueprint_compat = false,
	eternal_compat = true,
	rental_compat = true,
	perishable_compat = false,

	atlas = "jtem2_lumichan",
	attributes = {
		"space",
		"scaling",
	},
	config = {
		extra = {
			req = 15,
			used = 0,
			gain = 1,
			slots = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.req,
				card.ability.extra.used,
				SMODS.signed(card.ability.extra.gain),
				(card.ability.extra.slots < 0 and "-" or "+") .. card.ability.extra.slots,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.using_consumeable then
			card.ability.extra.used = card.ability.extra.used + 1
			if card.ability.extra.used >= card.ability.extra.req then
				G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.gain
				card.ability.extra.slots = card.ability.extra.slots + card.ability.extra.gain
				card.ability.extra.used = 0
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff) -- safeguard incase it gets debuffed from a boss or something
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
	end,
})
