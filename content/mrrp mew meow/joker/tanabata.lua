SMODS.Joker {
	ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'SarcPot'},
    ppu_coder = {'Minty'},
	key = 'mrrp_tanabata',
	atlas = "mrrp",
	pos = {
		x=0,
		y=2
	},
	rarity = 1,
	cost = 3,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = {'space'},

	config = {
		extra = {
			rank1 = "Jack",
            rank2 = "Queen",
		}
	},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				localize(card.ability.extra.rank1, "ranks"),
                localize(card.ability.extra.rank2, "ranks"),
                localize("planet", "labels"),
			}
		}
	end,

	calculate = function(self, card, context)
		if context.before and #G.consumeables.cards + (G.GAME.consumeable_buffer or 0) < G.consumeables.config.card_limit then
            local jack, queen
            for i,v in ipairs(context.scoring_hand) do
                if v:get_id() == SMODS.Ranks[card.ability.extra.rank1].id then jack = true end
                if v:get_id() == SMODS.Ranks[card.ability.extra.rank2].id then queen = true end
                if jack and queen then break end
            end

            if jack and queen then
                return {
                    message = localize("k_plus_planet"),
                    func = function ()
                        G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                        G.E_MANAGER:add_event(Event{
                            func = function ()
                                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                                SMODS.add_card{
                                    set = "Planet"
                                }
                                return true
                            end
                        })
                    end
                }
            end
        end
	end
}