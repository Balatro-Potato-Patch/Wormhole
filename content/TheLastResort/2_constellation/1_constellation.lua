SMODS.ConsumableType{
    key = 'worm_tlr_constellation',
    secondary_colour = HEX("75008f"),
    primary_colour = HEX("7FB768"),
    text_colour = HEX("aFf7a8"),
    collection_rows = {5, 5},
    shop_rate = 0,
    select_card = "consumeables",
    default = "c_worm_tlr_const_orion",
    inject_card = function(self, card)
        card.config = card.config or {}
        card.config.tier = 1
        local mem_loc_vars = card.loc_vars or function() return {} end
		card.loc_vars = function(_self, info_queue, _card)
			local main_end = nil
            WORM_TLR.const_info_queue(info_queue, _card.ability.tier)
			local ret = mem_loc_vars(_self, info_queue, _card)
			if main_end then ret.main_end = ret.main_end or {main_end} end
            if not ret.vars then ret.vars = {} end
            if not ret.vars.colours then ret.vars.colours = {} end
            table.insert(ret.vars.colours, 1, SMODS.ConsumableTypes.worm_tlr_constellation.primary_colour)
            ret.key = _self.key .. "_t" .. _card.ability.tier
			return ret
		end
        local mem_calculate = card.calculate or function() end
        card.calculate = function(_self, _card, context)
            if context.end_of_round and context.main_eval and context.beat_boss then
                if _card.ability.tier < 3 then
                    SMODS.scale_card(_card, {
                        ref_table = _card.ability,
                        ref_value = "tier",
                        scalar_table = {1},
                        scalar_value = 1
                    })
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _self:set_sprites(_card, _card.config.center)
                            return true
                        end
                    }))
                end
            end
            return mem_calculate(_self, _card, context)
        end
        card.set_sprites = function(_self, _card, front)
            if _card.ability and _card.ability.tier then
                _card.children.center:set_sprite_pos({x = card.pos.x - 1 + _card.ability.tier, y = card.pos.y})
            end
        end
        local mem_use = card.use or function() end
        card.use = function(_self, _card, area, copier)
            mem_use(_self, _card, area, copier)
            G.GAME.worm_tlr_last_const_used = _self.key ~= "c_worm_tlr_const_canis_minor" and _self.key or nil
        end
    end,
}

--[[

INFORMATION

all constellations should be prefixed with `const_`

en-us localization for each consumable must have 4 entries, one for each tier
see orion for example
please maintain formatting on the title

when defining each individual consumeable, a few things are automaticly done for you

confg.tier is set to 1
tier will upgrade when boss blind is defeated
texture will also change

loc_vars must still be defined as normal, however all values except vars will be ignored
if you want to change this let me (foo) know and i'll add what you want
do not generate info_queues for the tiering information, thats already done
{V:1} will always be the constellation primary colour
If you introduce other custom colours, their index starts at 2 instead of 1

if a card changes its tier, call WORM_TLR.update_const_sprite(self, card) to update the sprites


]]