sendDebugMessage("BalatrosAPalindrome loading!")

PotatoPatchUtils.Team({name="BalatrosAPalindrome", colour=G.C.BLUE})
PotatoPatchUtils.Developer({team="BalatrosAPalindrome",name="Nogardagem"})
PotatoPatchUtils.Developer({team="BalatrosAPalindrome",name="NerdyBread42"})
PotatoPatchUtils.Developer({team="BalatrosAPalindrome",name="IzzyWizz"})
PotatoPatchUtils.Developer({team="BalatrosAPalindrome",name="Knightingale0"})


-- sendDebugMessage("MOD LOADED")

-- SMODS.Consumable {
--     key = 'bap_test',
--     set = 'Tarot',
--     loc_txt = {
--         name = 'Test',
--         text = {'Works'}
--     },
--     pos = {x=0,y=0}
-- }

-- G.E_MANAGER:add_event(Event({
--     trigger = 'after',
--     delay = 0.1,
--     func = function()
--         sendDebugMessage("POST INIT CENTER:", tostring(G.P_CENTERS["c_bap_test"]))
--         return true
--     end
-- }))

-- G.E_MANAGER:add_event(Event({
--     trigger = 'after',
--     delay = 0.5,
--     func = function()
--         for k, v in pairs(G.P_CENTERS) do
--             if string.find(k, "bap") then
--                 sendDebugMessage("FOUND CENTER:", k)
--             end
--         end
--         return true
--     end
-- }))



SMODS.Atlas {
	-- Key for code to find it with
	key = "Palindrome",
	-- The name of the file, for the code to pull the atlas from
	path = "BalatrosAPalindrome/Palindrome.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}


-- OLD ENHANCEMENT
-- SMODS.Enhancement {
--     key = 'bap_void',
--     loc_txt = {
--         name = 'Void',
-- 		text = {
-- 			"{C:chips}#1#{} chips when",
-- 			"{C:attention}held{} or {C:attention}scored{}"
-- 		}
--     },
--     atlas = 'Palindrome',
--     pos = { x = 1, y = 0 },
--     config = { bonus = -25, h_chips = -25 },
-- 	--always_scores = true,
-- 	loc_vars = function(self, info_queue, card)
--         local ability = card and card.ability or self.config
--     	return { vars = { ability.bonus, ability.h_chips } }
--     end,
-- 	-- update= function(self, card, dt)
-- 	-- 	self.edition = "e_negative"
-- 	-- end
-- 	--set_ability = function(self, card, initial, delay_sprites) end
-- }

SMODS.Shader {
    key = 'bap_shader_void',
    path = 'bap_shader_void.fs',
    -- card can be nil if sprite.role.major is not Card
    send_vars = function (sprite, card)
        return {
            lines_offset = card and card.edition.example_gold_seed or 0
        }
    end,
}
SMODS.Edition {
    key = 'bap_void',
    shader = 'worm_bap_shader_void',
	loc_txt = {
		name = 'Void',
		label = 'Void',
		text = {
			"{C:chips}#1#{} chips when {C:attention}held{}",
			"Never scores"
		}
	},
    config = { chips = -25 },
    in_shop = false,
    weight = 0,
    extra_cost = 5,
	never_scores = true,
    sound = { sound = "negative", per = 1.5, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.edition.chips } }
    end,
    get_weight = function(self)
        return self.weight
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' and (card.config.center.discovered or card.bypass_discovery_center) then
            card.children.center:draw_shader('worm_bap_shader_void', nil, card.ARGS.send_to_shader)
            if card.children.front then
                card.children.front:draw_shader('worm_bap_shader_void', nil, card.ARGS.send_to_shader)
            end
            --card.children.center:draw_shader('negative_shine', nil, card.ARGS.send_to_shader)
        end
    end,
	calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.hand then
            return {
				chips = math.abs(card.edition.chips),
				sign = -1
			}
        end
    end
}


--sendDebugMessage("before abyss")

-- The Abyss
SMODS.Consumable {
	key = 'bap_abyss',
	loc_txt = {
		name = 'The Abyss',
		text = {
			"Gives {C:money}$#1#{} and",
			"creates {C:attention}#2#{} random {C:attention}Void cards{}",
		}
	},
	set = 'Tarot',
	atlas = 'Palindrome',
	pos = { x = 2, y = 0 },
	config = { extra = { money = 15, cards = 5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		-- give money
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('timpani')
				card:juice_up(0.3, 0.5)
				ease_dollars(card.ability.extra.money, true)
				return true
			end
		}))

		--add cards
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.7,
			func = function()
				local cards = {}
				for i = 1, card.ability.extra.cards do
					local _rank = pseudorandom_element(SMODS.Ranks, 'abyss_create').card_key
					local _suit = pseudorandom_element(SMODS.Suits, 'abyss_create').key

					cards[i] = SMODS.add_card({
						--area = G.hand,
						suit = _suit,
						rank = _rank,
						--enhancement = "m_worm_bap_void",
						edition = "e_worm_bap_void"
					})
				end
				SMODS.calculate_context({ playing_card_added = true, cards = cards })
				return true
			end
		}))

		delay(0.3)
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.cards > 1
	end
}


--sendDebugMessage("Registered Abyss:", G.P_CENTERS["c_worm_bap_abyss"])

-- Debug tarot
SMODS.Consumable {
    key = "bap_debug",
    loc_txt = {
		name = 'Debug',
		text = {
			"UNFINISHED",
		}
	},
    set = 'Tarot',
    cost = 3,
    pos = { x = 0, y = 0 },
    config = { anim_time = 0 },
    can_use = function(self, card) return true end,
    keep_on_use = function(self, card) return true end,
    use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function()
				if #G.consumeables.cards < G.consumeables.config.card_limit then
					SMODS.add_card({
						area = G.consumeables,
						key = "c_worm_bap_abyss"
					})
				end
				return true
			end
		}))
	end,
    update = function(self, card, dt)
        card.ability.anim_time = (card.ability.anim_time or 0) + dt
        self.pos.x = math.sin(card.ability.anim_time) * 0.5 + 0.5
		self.pos.y = math.cos(card.ability.anim_time) * 0.5 + 0.5
    end
}


-- Flush Five
SMODS.PokerHand {
    key = "bap_void",
    visible = true,
    mult = 7,
    chips = 200,
    l_mult = 2,
    l_chips = 25,
	loc_txt={ description = {
		"5 cards with the void enhancement",
	},
	name = "Void"
	},
    example = {
        { 'S_A', true, edition="e_worm_bap_void" },
        { 'D_Q', true, edition="e_worm_bap_void" },
        { 'D_9', true, edition="e_worm_bap_void" },
        { 'C_4', true, edition="e_worm_bap_void" },
        { 'D_3', true, edition="e_worm_bap_void" }
    },
    evaluate = function(parts, hand)
		if #hand ~= 5 then return {} end
		for i = 1, #hand do
			if not hand.edition then return {} end
			if hand[i].edition.key ~= "e_worm_bap_void" then return {} end
		end

        return { hand }
    end
}

-- Nothing planet card
SMODS.Consumable {
    key = "bap_nothing",
    loc_txt = {
		name = 'Nothing',
		text = {
			"Does nothing (real)",
		}
	},
    set = 'Planet',
    cost = 3,
	atlas = 'Palindrome',
    pos = { x = 0, y = 0 },
    config = { anim_time = 0, hand_type = "worm_bap_void" },
    can_use = function(self, card) return true end,
    -- use = function(self, card, area, copier)
	-- 	G.E_MANAGER:add_event(Event({
	-- 		trigger = 'after',
	-- 		delay = 0.4,
	-- 		func = function()
	-- 			return true
	-- 		end
	-- 	}))
	-- end
}




-- Milky Way
SMODS.Joker {
    key = "bap_milky_way",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 2,
    cost = 5,
	atlas = 'Palindrome',
    pos = { x = 1, y = 1 },
    config = { extra = { hands_left = 10 } },
	loc_txt = {
		name = 'Milky Way',
		text = {
			"Creates a random {C:planet}Planet{} card",
			"at end of round",
        	"{C:inactive}({C:attention}#1#{C:inactive} remaining)",
			"{C:inactive}(Must have room)",
		}
	},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands_left } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
			G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Planet' })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))

			if context.blueprint then return end

            if card.ability.extra.hands_left - 1 <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
				G.GAME.pool_flags.bap_milky_drank = true;
                return {
                    message = "Drank!",
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.hands_left = card.ability.extra.hands_left - 1
                return {
                    message = card.ability.extra.hands_left .. '',
                    colour = G.C.FILTER
                }
            end
        end
    end,
    in_pool = function(self, args) -- equivalent to `no_pool_flag = 'vremade_gros_michel_extinct'`
        return not G.GAME.pool_flags.bap_milky_drank
    end
}

-- Andromeda
SMODS.Joker {
    key = "bap_andromeda",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 0,
	atlas = 'Palindrome',
    pos = { x = 1, y = 2 },
    config = {  },
	loc_txt = {
		name = 'Andromeda',
		text = {
			"Gives {C:money}money{} equal ",
			"to level of first",
			"{C:attention}poker hand{} played"
		},
	},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
		if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.final_scoring_step and G.GAME.current_round.hands_played == 0 then			
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + G.GAME.hands[context.scoring_name].level -- ripped from business card
            return {
				    dollars = G.GAME.hands[context.scoring_name].level,
				    func = function() -- This is for timing purposes, this goes after the dollar modification
				        G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
		end
	end,
    in_pool = function(self, args) -- equivalent to `yes_pool_flag = 'vremade_gros_michel_extinct'`
        return G.GAME.pool_flags.bap_milky_drank
	end

}
