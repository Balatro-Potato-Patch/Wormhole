SMODS.Seal {
	key = 'lfc_meteor',
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.seal.extra.dollars,
			}
		}
	end,
	config = { extra = { dollars = 5 } },
	ppu_coder = { "ellestuff." },
	--ppu_artist = {"J8-Bit"},
	ppu_team = { "Lancer Fan Club" },
	attributes = { "economy" },
    atlas = "lfc_seals",
    pos = {x=0,y=0},
    calculate = function (self, card, context)
        if context.main_scoring then
            G.E_MANAGER:add_event(Event({func = function ()
                Wormhole.LancerFanClub.create_meteor(card.ability.seal.extra.dollars,1)
            return true end}))
        end
    end,
	badge_colour = G.ARGS.LOC_COLOURS.lfc_meteor
    -- Still needs a few things but someone else can do that
}