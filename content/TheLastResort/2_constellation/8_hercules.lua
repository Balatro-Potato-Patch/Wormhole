SMODS.Consumable{
	set = "worm_tlr_constellation",
	key = "tlr_const_hercules",
	atlas = "tlr_const",
	pos = {x = 0, y = 6},
	ppu_coder = {"Foo54"},
    ppu_artist = {"Aura2247"},
	config = {
		blind = nil
	},
	loc_vars = function(self, info_queue, card)
		if card.ability.blind then
			info_queue[#info_queue+1] = {set = "Blind", key = card.ability.blind, vars = G.P_BLINDS[card.ability.blind].vars}
		elseif card.ability.tier == 4 then
			self:reset_blind(card)
			info_queue[#info_queue+1] = {set = "Blind", key = card.ability.blind, vars = G.P_BLINDS[card.ability.blind].vars}
		end
		return {vars = {localize{set = "Blind", type = "name_text", key = card.ability.blind}}}
	end,
	reset_blind = function(self, card)
		local choices = {}
		for key, blind in pairs(G.P_BLINDS) do
			if blind.boss and not blind.boss.showdown then
				choices[#choices+1] = key
			end
		end
		card.ability.blind = pseudorandom_element(choices, "tlr_const_hercules")
		card:juice_up()
	end,
	set_ability = function (self, card, initial, delay_sprites)
		if card.ability.tier == 4 then
			self:reset_blind(card)
		end
	end,
	calculate = function (self, card, context)
		if context.end_of_round and context.main_eval then
			if card.ability.tier == 4 then
				self:reset_blind(card)
				return {
					message = localize("k_reset")
				}
			end
		end
	end,
	can_use = function (self, card)
		return G.STATE == G.STATES.SHOP
	end,
	use = function (self, card, area, copier)
		if card.ability.tier == 4 and not card.ability.blind then
			self:reset_blind(card)
		end
		G.GAME.worm_tlr_hercules_blind = true
		G.GAME.worm_tlr_hercules_tier = card.ability.tier
		stop_use()
    G.CONTROLLER.locks.toggle_shop = true
    if G.shop then 
      SMODS.calculate_context({ending_shop = true})
      G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          G.shop.alignment.offset.y = G.ROOM.T.y + 29
          G.SHOP_SIGN.alignment.offset.y = -15
          return true
        end
      })) 
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
          G.shop:remove()
          G.shop = nil
          G.SHOP_SIGN:remove()
          G.SHOP_SIGN = nil
          G.CONTROLLER.locks.toggle_shop = nil
          return true
        end
      }))
    end
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			func = function ()
				ease_round(1)
				inc_career_stat('c_rounds', 1)
				local blind = {"bl_small", "bl_big", "bl_big", card.ability.blind}
				local ondeck = {"Small", "Big", "Big", "Boss"}
				G.GAME.round_resets.blind_tag = nil
				G.GAME.round_resets.blind = G.P_BLINDS[blind[card.ability.tier]]
				--G.GAME.round_resets.blind_states[ondeck[card.ability.tier]] = 'Current'
				delay(0.2)
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			func = function()
				new_round()
				return true
			end
		}))
	end,
}