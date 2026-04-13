-- Team: Dummies
PotatoPatchUtils.Team({
    name = "dummies",
    colour = HEX("FFFF00"),
    credit_rows = { 3, 3 },
    short_credit = true,
    loc = true,
})
-- Members (In Join-Order)
SMODS.Atlas {
    key = "dummies_team",
    path = "Dummies/team.png",
    px = 71,
    py = 95
}
-- GhostSalt
PotatoPatchUtils.Developer {
    name = "ghostsalt",
    colour = HEX("FFDDDD"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 0, y = 0 },
    loc = true,
}
-- vissa
PotatoPatchUtils.Developer {
    name = "vissa",
    colour = HEX("B00B1E"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 1, y = 0 },
    loc = true,
}
-- bakersdozenbagels
PotatoPatchUtils.Developer {
    name = "bagels",
    colour = HEX "EDD198",
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 2, y = 0 },
    loc = true,
}
-- TheOneGoofAli
PotatoPatchUtils.Developer {
    name = "theonegoofali",
    colour = HEX("FD9712"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 3, y = 0 },
    loc = true,
	calculate = function(self, context)
		if context.end_of_round and context.main_eval then G.goodluckgentlemen = false end
		
		if G.hellocommander then return end
		
		local context = context
		
		if context.first_hand_drawn and (G.GAME.blind and G.GAME.blind.boss and G.GAME.blind.in_blind) and not G.goodluckgentlemen then
			G.goodluckgentlemen = true
			local tc = SMODS.find_card('j_worm_dum_timcurry', true)
			if tc and tc[1] then
				G.hellocommander = true
				return {
					message = '!',
					message_card = tc[1] or G.deck,
					sound = "worm_dum_timcurry_goodluckgentlemen",
					pitch = 1,
					volume = 0.85,
					extra = {
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									G.hellocommander = false
									return true
								end
							}))
						end
					}
				}
			end
		end
		
		if context.card and context.card.config and context.card.config.center and context.card.config.center.key and not (context.retrigger_joker or context.blueprint) then
			if context.card.config.center.key == 'j_space' and (context.modify_shop_card or context.modify_booster_card or context.card_added) then
				local tc = SMODS.find_card('j_worm_dum_timcurry', true)
				if tc and tc[1] then
					G.hellocommander = true
					return {
						message = localize('worm_tim_curry_space'),
						message_card = tc[1] or G.deck,
						sound = "worm_dum_timcurry_space",
						pitch = 1,
						volume = 0.85,
						extra = {
							func = function()
								G.E_MANAGER:add_event(Event({
									func = function()
										G.hellocommander = false
										return true
									end
								}))
							end
						}
					}
				end
			elseif context.card.config.center.key == 'j_worm_dum_timcurry' then
				if context.card_added or context.joker_type_destroyed or context.selling_card then
					G.hellocommander = true
					return {
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									play_sound(context.card_added and 'worm_dum_timcurry_commander' or 'worm_dum_timcurry_treachery', 1, 0.85)
									G.hellocommander = false
									return true
								end
							}))
						end
					}
				end
			end
		end
	end
}
-- baltdev
PotatoPatchUtils.Developer {
    name = "baltdev",
    colour = HEX("707880"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 4, y = 0 },
    loc = true,
}
-- Flowire
PotatoPatchUtils.Developer {
    name = "flowire",
    colour = HEX("FF8FA9"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 5, y = 0},
    loc = true,
}
