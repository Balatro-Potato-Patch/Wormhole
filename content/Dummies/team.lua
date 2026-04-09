-- Team: Dummies
PotatoPatchUtils.Team({
    name = "dummies",
    colour = HEX("FFFF00"),
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
PotatoPatchUtils.Developer{
    name = "ghostsalt",
    colour = HEX("FFDDDD"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 0, y = 0 },
    loc = true,
}
-- vissa
PotatoPatchUtils.Developer{
    name = "vissa",
    colour = HEX("B00B1E"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 1, y = 0 },
    loc = true,
}
-- bakersdozenbagels
PotatoPatchUtils.Developer{
    name = "bakersdozenbagels",
    colour = HEX("FFFF00"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 2, y = 0 },
    loc = true,
}
-- TheOneGoofAli
PotatoPatchUtils.Developer{
    name = "theonegoofali",
    colour = HEX("FD9712"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 3, y = 0 },
    loc = true,
	calculate = function(self, context)
		if (context.modify_shop_card or context.modify_booster_card or context.card_added) and context.card and context.card.config and context.card.config.center
		and context.card.config.center.key and context.card.config.center.key == 'j_space' and not (context.retrigger_joker or context.blueprint) then
			if G.hellocommander then return end
			
			local tc = SMODS.find_card('j_worm_dum_timcurry', true)
			if tc and tc[1] then
				G.hellocommander = true
				return {
					message = localize('worm_tim_curry_space'),
					message_card = tc[1] or G.deck,
					sound = "worm_dum_timcurryspace",
					pitch = 1,
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
	end
}
-- baltdev
PotatoPatchUtils.Developer{
    name = "baltdev",
    colour = HEX("707880"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 4, y = 0 },
    loc = true,
}
-- Flowire
PotatoPatchUtils.Developer{
    name = "flowire",
    colour = HEX("FF8FA9"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 5, y = 0} ,
    loc = true,
}
