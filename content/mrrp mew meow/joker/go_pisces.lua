SMODS.Joker {
	ppu_team = {'Mrrp Mew Meow :3'},
	ppu_artist = {'Cyan'},
    ppu_coder = {'Minty'},
	key = 'mrrp_go_pisces',
	rarity = 2,
	cost = 8,
	atlas = "mrrp", pos = {x=4, y=2},
	blueprint_compat = true,
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
		info_queue[#info_queue+1] = {key = 'tag_rare', set = 'Tag'}
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

			for _,book in ipairs(books) do
				SMODS.destroy_cards(book)
				G.E_MANAGER:add_event(Event{
					func = function ()
						add_tag(Tag("tag_rare"))
						return true
					end
				})
				if _ ~= #books then delay(0.6) end
			end

			SMODS.destroy_cards(context.blueprint and context.blueprint_card or card)
			return { no_retrigger = true }
		end
	end
}