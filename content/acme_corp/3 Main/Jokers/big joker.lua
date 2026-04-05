SMODS.Joker{
	key = 'ACME_big_brother',
	loc_txt = {
		name = "Big Joker",
		text = {
			'Draw {C:attention}#1#{} cards at the',
			'start of the {C:attention}blind{}',
			'Set {C:blue}hand size{} to {C:attention}0{}', 'after a hand is played'
		},	
	},
	atlas = 'ACME_jokers',
	rarity = 3,
	cost = 8,
	in_pool = function(self,wawa,wawa2)
		allow_duplicates = false
		return true
    end,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	pos = {x = 1, y = 0},
	config = { 
		extra = {
			cards = 20,
			remainder = 0},
		handbuf = 0,
		activated = false,
		},
	loc_vars = function(self,info_queue,center)
		return{vars = {center.ability.extra.cards,center.ability.extra.remainder}}
	end,
	add_to_deck = function(self,card,from_debuff)
		card.ability.handbuf = G.hand.config.card_limit
	end,
	remove_from_deck = function(self,card,from_debuff)
		G.hand:change_size(-G.hand.config.card_limit + card.ability.handbuf)
	end,
	calculate = function(self,card,context)
		if not context.blueprint then
			if context.setting_blind and not card.ability.activated == true then
				G.hand:change_size(card.ability.extra.cards - card.ability.handbuf)
				card.ability.activated = true
			end
			if context.after then
				G.hand:change_size(-G.hand.config.card_limit)
			end
			if context.end_of_round and context.main_eval then
				G.hand:change_size(card.ability.handbuf)
				card.ability.activated = false
			end
		end
	end,
}
