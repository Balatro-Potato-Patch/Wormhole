SMODS.Joker {
	ppu_team = {'Mrrp Mew Meow :3'},
    ppu_coder = {'Minty'},
	key = 'out_of_space',
	atlas = "mrrp", pos = {x=4, y=5},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	config = {
        extra = {
            slots = 1,
            size = 1.25,
        },
        immutable = {
            slots = nil --Set when acquiring card to avoid desyncing from value manip shenanigans
        }
    },
	loc_vars = function (self, info_queue, card)
		return {
            vars = {
                card.ability.immutable.slots or card.ability.extra.slots,
                card.ability.extra.size,
            }
        }
	end,

    add_to_deck = function (self, card, from_debuff)
        local amt = card.ability.extra.slots
        G.jokers:change_size(amt)
        G.consumeables:change_size(amt)
        G.hand:change_size(amt)

        card.ability.immutable.slots = amt
    end,
    remove_from_deck = function (self, card, from_debuff)
        local amt = card.ability.immutable.slots
        G.jokers:change_size(-amt)
        G.consumeables:change_size(-amt)
        G.hand:change_size(-amt)

        card.ability.immutable.slots = nil
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