SMODS.Atlas({
	key = "jtem2_enhancements",
	path = "Jtem 2/enhancements/enhancements.png",
	px = 71,
	py = 95,
})

SMODS.Enhancement {
    atlas = "jtem2_enhancements",
    pos = { x = 0, y = 0},
    key = "jtem2_strange_card",
    badge_colour = HEX("3dd755"),
    config = {
        h_x_mult = 1,
        extras = {
            xmult_min = 0.6,
            xmult_max = 2.5,
        }
    },
	ppu_team = { "jtem2" },
	ppu_coder = { "aikoyori" },
	ppu_artist = { "aikoyori" },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.h_x_mult,
                card.ability.extras.xmult_min,
                card.ability.extras.xmult_max,
            }
        }
    end,
    calculate = function (self, card, context)
        if context.hand_drawn then
            return {
                func = function ()
                    card.ability.h_x_mult = pseudorandom("worm_jtem_xmult") * (card.ability.extras.xmult_max - card.ability.extras.xmult_min) + card.ability.extras.xmult_min
                end
            }
        end
    end
}

SMODS.Enhancement {
    atlas = "jtem2_enhancements",
    pos = { x = 1, y = 0},
    key = "jtem2_gravacard",
    badge_colour = HEX("544bdf"),
    config = {
        extras = {
            xblind = 1.25
        }
    },
	ppu_team = { "jtem2" },
	ppu_coder = { "aikoyori" },
	ppu_artist = { "aikoyori" },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.xblind
            }
        }
    end,
    calculate = function (self, card, context)
        if context.stay_flipped and context.to_area == G.hand and context.other_card == card then
            return {
                xblindsize = card.ability.extras.xblind
            }
        end
        if context.main_scoring and context.cardarea == G.hand then
            local index = 1
            for i, k in ipairs(G.hand.cards) do
                if k == card then
                    index = i
                    break
                end
            end
            return {
                dollars = #G.hand.cards - index
            }
        end
    end
}

SMODS.Enhancement {
    atlas = "jtem2_enhancements",
    pos = { x = 2, y = 0},
    key = "jtem2_neutron_card",
    badge_colour = HEX("5641ff"),
	ppu_team = { "jtem2" },
	ppu_coder = { "aikoyori" },
	ppu_artist = { "aikoyori" },
    config = {
        extras = {
            xmult_fire = 0.1,
            xscore_no_fire = 2.7,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.xmult_fire,
                card.ability.extras.xscore_no_fire,
            }
        }
    end,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if SMODS.last_hand_oneshot then
                return {
                    xmult = card.ability.extras.xmult_fire
                }
            else
                return {
                    xscore = card.ability.extras.xscore_no_fire
                }
            end
        end
    end
}