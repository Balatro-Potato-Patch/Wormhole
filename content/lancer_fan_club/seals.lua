SMODS.Seal {
	key = 'lfc_meteor',
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				localize("$"),
				card.ability.seal.extra.dollars,
			}
		}
	end,
	config = { extra = { dollars = 5 } },
	ppu_coder = { "ellestuff." },
	ppu_artist = {"J8-Bit"},
	ppu_team = { "Lancer Fan Club" },
	attributes = { "economy" },
    atlas = "lfc_jokers",
    pos = {x=3,y=2},
    calculate = function (self, card, context)
        if context.main_scoring then
            G.E_MANAGER.add_event(Event({func = function ()
                Wormhole.LancerFanClub.create_meteor(card.ability.seal.extra.dollars)
            return true end}))
        end
    end
    -- Still needs a few things but someone else can do that
}