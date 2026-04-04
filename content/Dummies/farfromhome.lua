SMODS.Joker{
	key = "dum_farfromhome",
    atlas = 'worm_DummiesJokers_Flowire',
    pos = { x = 1, y = 0 },
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
            xchips_gain = 0.25,
            xchips_loss = 0.1,
            xchips_stored = 0.0,
            --target = "c_earth"
		}
	},
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
    end
}
