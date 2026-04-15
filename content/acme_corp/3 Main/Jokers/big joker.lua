SMODS.Joker{
	key = 'ACME_big_brother',
	atlas = 'ACME_jokers',
	rarity = 3,
	cost = 8,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	pos = {x = 1, y = 0},
	ppu_coder = {'Youh'},
	ppu_artist = {'FlameThrowerFIM'},
	config = {
		extra = {
			defaultSize = 0,
			cards = 20,
			remainder = 0
		},
		handbuf = 0,
		activated = false
		},
	loc_vars = function(self,info_queue,center)
		return{vars = {center.ability.extra.cards,center.ability.extra.remainder}}
	end,
	remove_from_deck = function(self,card,from_debuff)
		if card.ability.extra.activated then
			G.hand:change_size(card.ability.handbuf)
		end
	end,
	calculate = function(self,card,context)
		if not context.blueprint then
			if context.setting_blind and
				SMODS.find_card("j_worm_ACME_big_brother")[1] == card then
				card.ability.handbuf = G.hand.config.card_limit
				G.hand:change_size(card.ability.extra.cards - card.ability.handbuf)
			end
			if context.first_hand_drawn and
				SMODS.find_card("j_worm_ACME_big_brother")[1] == card then
				G.hand:change_size(-G.hand.config.card_limit)
				card.ability.extra.activated = true
			end
			if context.end_of_round and context.main_eval and
				SMODS.find_card("j_worm_ACME_big_brother")[1] == card then
				G.hand:change_size(card.ability.handbuf)
				card.ability.extra.activated = false
			end
		end
	end
}
