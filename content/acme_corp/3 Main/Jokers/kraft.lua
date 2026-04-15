SMODS.Joker{
	key = 'acme_kraft_e_jackal',
	atlas = 'ACME_jokers',
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	pos = {x = 2, y = 1},
	ppu_coder = {'Youh', 'Opal'},
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
		card.ability.extra.kraft_e_id = math.random(-10000, 10000)
		local unique = true
		if G.jokers and G.jokers.cards then
			for k, v in ipairs(G.jokers.cards) do
				if v.ability.extra.kraft_e_id and v.ability.extra.kraft_e_id == card.ability.extra.kraft_e_id and not v == card then
					unique = false
				end
			end
		end
		while unique == false do
			card.ability.extra.kraft_e_id = math.random(-10000, 10000)
			if G.jokers and G.jokers.cards then
				for k, v in ipairs(G.jokers.cards) do
					if v.ability.extra.kraft_e_id and v.ability.extra.kraft_e_id == card.ability.extra.kraft_e_id and not v == card then
						unique = false
					end
				end
			end
		end
	end,
	calculate = function(self,card,context)
		if context.end_of_round and #G.consumeables.cards + 1 <= G.consumeables.config.card_limit and context.main_eval then
			local existing_gadget = false
			for k, v in ipairs(G.consumeables.cards) do
				if (v.ability and v.ability.kraft_e_creator and v.ability.kraft_e_creator == card.ability.extra.kraft_e_id) then
					existing_gadget = true
				end
			end
			if not existing_gadget then
			G.E_MANAGER:add_event(Event({
				func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local _card = SMODS.add_card{key = card.ability.extra.gadget, area = G.consumeables,set = 'ACME_Gadgets',}
							_card.ability.kraft_e_creator = card.ability.extra.kraft_e_id
                	        return true
                        end
                    }))
                    SMODS.calculate_effect({message = "+1 Gadget", colour = HEX('5B9BAA')}, context.blueprint_card or card)
                    return true
                end
            }))
			card.ability.extra.gadget = pseudorandom_element(
				G.P_CENTER_POOLS["ACME_Gadget"],"acme_kraft_e_jackal").key
            		return nil, true
			else
				return{
					message = 'You already have one!',
					colour = G.C.RED
				}
			end
		end
	end
}
