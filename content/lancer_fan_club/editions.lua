SMODS.Edition {
    key = "lfc_starry",

    -- THIS IS TEMPORARY
    shader = "foil",
    prefix_config = {
        -- This allows using the vanilla shader
        -- Not needed when using your own
        shader = false
    },

    in_shop = true,
    weight = 15, -- due to the lack of ways to obtain this edition
    extra_cost = 2,

    config = {
        extra = {
            chips_mod = 5,
            mult_mod = 1,
        }
    },

    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,

    loc_vars = function(self, info_queue, card)
        return {
			vars = {
                card.edition and card.edition.extra.chips_mod or 5,
                card.edition and card.edition.extra.mult_mod or 1,
			},
        }
	end,

    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                func = function()
                    SMODS.upgrade_poker_hands({
                        hands = context.scoring_name,
                        parameters = {"chips", "mult"},
                        func = function(current_val, hand, parameter, level_up)
                            if parameter == "chips" then
                                return current_val + card.edition.extra.chips_mod
                            elseif parameter == "mult" then
                                return current_val + card.edition.extra.mult_mod
                            end
                        end,
                    })
                end,
            }
        end
    end,

    ppu_coder = { "InvalidOS" }
}