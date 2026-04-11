SMODS.Joker {
    ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'SarcPot'},
    ppu_coder = {'Cyan'},
	key = 'countdown',
	atlas = "mrrp", pos = {x=2, y=1},
	rarity = 2,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

    attributes = {
        "space",
        "joker"
    },

	config = {extra = {hand="Straight"}},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				localize(card.ability.extra.hand, "poker_hands")
			}
		}
	end,

	calculate = function(self, card, context)
		if context.before and context.poker_hands and next(context.poker_hands[card.ability.extra.hand]) then
			local onewithoutfaces = true
			for num,combo in ipairs(context.poker_hands[card.ability.extra.hand]) do
				onewithoutfaces = true
				for _,pcard in ipairs(combo) do
					if pcard.base and pcard.base.id then
						for k,v in pairs(SMODS.Ranks) do
							if v.id == pcard.base.id then
								if v.face then onewithoutfaces = false end
								break
							end
						end
					end
					if not onewithoutfaces then break end
				end
				if onewithoutfaces then break end
			end
			if onewithoutfaces then
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.SECONDARY_SET.Planet,
					level_up = 1,
				}
			end
		end
	end
}