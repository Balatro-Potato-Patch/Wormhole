Wormhole.LancerFanClub.levels_all_hands = {
	c_black_hole = true,
}

SMODS.Joker({
	key = "lfc_astronaut_food",
	pos = { x = 1, y = 2 },
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	demicoloncompat = false,
	atlas = "lfc_jokers",
	ppu_coder = { "ellestuff.", "InvalidOS" },
	ppu_artist = { "J8-Bit" },
	ppu_team = { "Lancer Fan Club" },
	config = {
		extra = {
			count = 5,
			remaining = 5,
			chips = 20,
			mult = 2,
		}
	},
	attributes = {
		"space",
		"food",
		"planet",
		"joker"
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.remaining,
			card.ability.extra.chips,
			card.ability.extra.mult
		} }
	end,
	calculate = function(self, card, context)
		if context.poker_hand_changed and context.card.config.center.key ~= "j_worm_lfc_astronaut_food" then
			local count = math.min(context.new_level-context.old_level,card.ability.extra.remaining)
			SMODS.upgrade_poker_hands {
				hands = context.scoring_name,
				func = function(base, hand, parameter, level_up)
					level_up = level_up or 1

					if parameter == "chips" then
						return base+card.ability.extra.chips*level_up*count
					end
					if parameter == "mult" then
						return base+card.ability.extra.mult*level_up*count
					end
				end,
				from = card,
				instant = context.instant
			}
			
			if context.blueprint or Wormhole.LancerFanClub.levels_all_hands[context.card.config.center.key] then return end
			if card.ability.extra.remaining <= count then
				SMODS.destroy_cards(card, nil, nil, false)

				return {
					message = localize('k_eaten_ex')
				}
			else
				card.ability.extra.remaining = card.ability.extra.remaining-count
			end
		end
	end
})

-- make black hole count as only leveling up one hand
local suph = SMODS.upgrade_poker_hands
function SMODS.upgrade_poker_hands(args, ...)
	suph(args, ...)
	if args.from and ((not args.hands) or #args.hands > 1) and Wormhole.LancerFanClub.levels_all_hands[args.from.config.center.key] then
		for _, card in ipairs(SMODS.find_card("j_worm_lfc_astronaut_food")) do
			local count = math.min(args.level_up or 0, card.ability.extra.remaining)
			if card.ability.extra.remaining <= count then
				SMODS.destroy_cards(card, nil, nil, false)
				SMODS.calculate_effect({message = localize('k_eaten_ex')}, card)
			else
				card.ability.extra.remaining = card.ability.extra.remaining-count
			end
		end
	end
end