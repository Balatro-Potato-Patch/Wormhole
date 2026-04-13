SMODS.Atlas {
  key = "dummies_home",
  path = "Dummies/home.png",
  px = 71,
  py = 95
}

SMODS.Joker{
	key = "dum_farfromhome",
    atlas = 'worm_dummies_home',
    pos = { x = 0, y = 0 },
    wormhole_pos_extra = { stars = { x = 0, y = 1 }, hand = { x = 3, y = 0 }, earth = { x = 6, y = 1 } },
    wormhole_anim_extra = {
        stars = {
            { xrange = { first = 1, last = 2 }, y = 0, t = 0.3 },
        },
        hand = {
            { x = 3, y = 0, t = 4.00 },
            { xrange = { first = 3, last = 6 }, y = 0, t = 1.0 },
            { x = 6, y = 0, t = 4.00 },
            { xrange = { first = 6, last = 3 }, y = 0, t = 1.0 },
        },
        earth = {
            { xrange = { first = 0, last = 7 }, yrange = { first = 1, last = 2 }, t = 2.2 },
        },
    },
    ppu_team = { "dummies" },
    ppu_artist = { "flowire" },
    ppu_coder = { "flowire" },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 2,
	cost = 6,
	config = {
		extra = {
            xchips = 1.0,
            xchips_gain = 0.3,
            xchips_loss = 0.1,
            xchips_stored = 0.0,
            --target = "c_earth"
		}
	},
    attributes = { "planet", "home", "joker" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "c_earth", set = "Planet", config = G.P_CENTERS.c_earth.config }
		return { vars = {
            card.ability.extra.xchips_gain,
            card.ability.extra.xchips_stored,
            card.ability.extra.xchips_loss,
            card.ability.extra.xchips
        } }
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			return { xchips = card.ability.extra.xchips }
		end
        if context.after and not (context.blueprint or card.ability.extra.xchips <= 1.0) then
            card.ability.extra.xchips = math.max(1.0, card.ability.extra.xchips - card.ability.extra.xchips_loss)
            return {
                message = localize { type = 'variable', key = 'a_xchips_minus', vars = { card.ability.extra.xchips_loss } },
                colour = G.C.CHIPS
            }
        end
        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            -- Store Value
            card.ability.extra.xchips_stored = card.ability.extra.xchips_stored + card.ability.extra.xchips_gain
            if context.consumeable.config.center.key == "c_earth" then
                -- Apply Value
                card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_stored
				return {
				    message = localize{type = 'variable', key = 'worm_dum_apply', vars = { card.ability.extra.xchips_stored }},
					colour = G.C.CHIPS,
				    func = function()
                        -- Reset Value
                        card.ability.extra.xchips_stored = 0.0
				    	return true
				    end
				}
            else
				return {
				    message = localize{type = 'variable', key = 'worm_dum_store', vars = { card.ability.extra.xchips_gain }},
					colour = G.C.CHIPS
				}
            end
        end
    end,
	pronouns = "she_her"
}
