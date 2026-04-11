SMODS.Joker {
	ppu_team = {'Mrrp Mew Meow :3'},
    ppu_coder = {'Minty'},
	key = 'tanabata',
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
			
		}
	},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				
			}
		}
	end,

	calculate = function(self, card, context)
		if context.before and #G.consumeables.cards + (G.GAME.consumeable_buffer or 0) < G.consumeables.config.card_limit then
            local jack, queen
            for i,v in ipairs(context.scoring_hand) do
                if v:get_id() == SMODS.Ranks.Jack.id then jack = true end
                if v:get_id() == SMODS.Ranks.Queen.id then queen = true end
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