SMODS.Joker {
	key = 'gofish',
	atlas = "mrrp_j", pos = {x=3, y=0},
	rarity = 2,
	cost = 8,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	
	attributes = {
        "space",
		"hand_type",
		"destroy_card",
		"generation"
    },

	config = {extra = {hand = "Four of a Kind", tag = "tag_rare"}},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				localize(card.ability.extra.hand, "poker_hands"),
				localize({type="name_text", set="Tag", key=card.ability.extra.tag})
			}
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands[card.ability.extra.hand]) then
			local books = get_X_same(4, context.scoring_hand, true)
			G.lolpiscesdebugtime = books

			for _,book in ipairs(books) do
				SMODS.destroy_cards(book)
				G.E_MANAGER:add_event(Event{
					func = function ()
						add_tag(Tag("tag_rare"))
						return true
					end
				})
				if _ ~= #books then delay(1) end
			end

			SMODS.destroy_cards(card)
		end
	end
}