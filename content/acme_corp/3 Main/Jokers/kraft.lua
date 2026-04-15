SMODS.Joker{
	key = 'acme_kraft_e_jackal',
	atlas = 'ACME_jokers',
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	pos = {x = 2, y = 1},
	ppu_coder = {'Youh'},
	ppu_artist = {'FlameThrowerFIM'},
	config = {
		extra = {
			gadget = 'c_worm_acme_ball'
		},
	},
	loc_vars = function(self,info_queue,center)
		return{vars = {localize{type = 'name_text',set = 'ACME_Gadgets',
		key = center.ability.extra.gadget}}}
	end,
	add_to_deck = function(self,card,from_debuff)
		card.ability.extra.gadget = pseudorandom_element(
		G.P_CENTER_POOLS["ACME_Gadget"],"acme_kraft_e_jackal").key

	end,
	calculate = function(self,card,context)
		if context.end_of_round and #G.consumeables.cards + 1 < G.consumeables.config.card_limit and
		G.GAME.blind.boss and context.main_eval then
			G.E_MANAGER:add_event(Event({
				func = (function()
                    			G.E_MANAGER:add_event(Event({
                        			func = function()
                            			SMODS.add_card{
							key = card.ability.extra.gadget,
							area = G.consumeables,
							set = ACME_Gadgets,
						}
                	            		return true
                        		end
                    		}))
                    	SMODS.calculate_effect({message = "+1 Gadget", colour = HEX('5B9BAA')},
                        	context.blueprint_card or card)
                    	return true
                	end)
            		}))
			card.ability.extra.gadget = pseudorandom_element(
				G.P_CENTER_POOLS["ACME_Gadget"],"acme_kraft_e_jackal").key
            		return nil, true
		end
	end
}
