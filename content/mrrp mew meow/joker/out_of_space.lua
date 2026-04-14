SMODS.Joker {
	ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'Cyan'},
    ppu_coder = {'Minty'},
	key = 'mrrp_out_of_space',
	atlas = "mrrp", pos = {x=3, y=3},
	rarity = 3,
	cost = 8,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
    attributes = {'cat', 'space','joker_slot'},

	config = {
        card_limit = 1,
        extra = {
            size = 1.25,
        },
    },
	loc_vars = function (self, info_queue, card)
        local slots = card.ability.card_limit
        local size = card.ability.extra.size
		return {
            vars = {
                Wormhole.mrrp_signed(slots),
                size,
            }
        }
	end,

    add_to_deck = function (self, card, from_debuff)
        local amt = card.ability.card_limit
        G.consumeables:change_size(amt)
        G.hand:change_size(amt)
    end,
    remove_from_deck = function (self, card, from_debuff)
        local amt = card.ability.card_limit
        G.consumeables:change_size(-amt)
        G.hand:change_size(-amt)
    end,

	calculate = function(self, card, context)
		if context.setting_blind then
            local space = 0
            local areas = {
                "jokers",
                "consumeables"
            }
            for _,area in ipairs(areas) do
                space = space + (G[area].config.card_limit - #G[area].cards)
            end
            
            if space > 0 then
                return {
                    x_blind_size = card.ability.extra.size ^ space
                }
            end
        end
	end
}