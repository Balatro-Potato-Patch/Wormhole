-- planets definition & render

local start_angle = os.time()

SMODS.Atlas({
	key = "jtem2_artificial_sun",
	path = "Jtem 2/jokers/artificial_sun.png",
	px = 71,
	py = 95,
})

local planets = {
	c_mercury = {
		speedfactor = 1 / 0.241,
		radius = 0.8,
		size = 0.7,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 3 },
		collection = true,
	},
	c_venus = {
		speedfactor = 1 / 0.615,
		radius = 1.2,
		size = 0.85,

		angle = 150,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 4 },
		collection = true,
	},
	c_earth = {
		speedfactor = 1,
		radius = 1.6,
		size = 1,

		angle = 80,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 5 },
		collection = true,
	},
	c_mars = {
		colour = G.C.CHIPS,
		speedfactor = 1 / 1.881,
		radius = 2.0,
		size = 1.25,

		angle = 225,

		center = {
			dx = -0.4,
			dy = -0.2,
		},

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 6 },
	},
	c_ceres = {
		colour = G.C.CHIPS,
		speedfactor = 1 / 4.6,
		radius = 2.3,
		size = 0.8,

		angle = 15,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 1 },
	},
	c_jupiter = {
		speedfactor = 1 / 11.86,
		radius = 2.6,
		size = 1.35,

		angle = 300,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 7 },
	},
	c_saturn = {
		speedfactor = 1 / 29.46,
		radius = 3.2,
		size = 2,
		angle = 180,
		planet_angle = 26.73,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 8 },
		collection = true,
	},
	c_uranus = {
		speedfactor = 1 / 84.01,
		radius = 3.6,
		size = 1.8,
		angle = 35,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 9 },
	},
	c_neptune = {
		speedfactor = 1 / 164.8,
		radius = 4.0,
		size = 1.8,
		angle = 265,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 10 },
	},
	c_pluto = {
		speedfactor = 1 / 247.7,
		radius = 4.4,
		size = 0.5,
		angle = 180,

		center = {
			dx = 0.4,
			dy = 0.1,
		},

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 11 },
		collection = true,
	},
	c_eris = {
		speedfactor = 1 / 561,
		radius = 5.2,
		size = 0.5,
		angle = 180,

		center = {
			dx = 2.5,
			dy = 2.5,
		},

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 0 },
	},
}
local planets_order = {
	"c_mercury",
	"c_venus",
	"c_earth",
	"c_mars",
	"c_ceres",
	"c_jupiter",
	"c_saturn",
	"c_uranus",
	"c_neptune",
	"c_pluto",
	"c_eris",
}

local function get_planet_dims(planet)
	local center = planet.center or {}
	local current_angle = (planet.angle or 0)
		- G.TIMERS.REAL * 30 * math.sqrt(planet.speedfactor or 1)
		+ (start_angle % 360)
	local current_radius = planet.radius * 1.5
	local x = math.cos(math.rad(current_angle)) * current_radius + (center.dx or 0)
	local y = math.sin(math.rad(current_angle)) * current_radius + (center.dy or 0)

	return {
		angle = current_angle,
		x = x,
		y = y,
		radius = current_radius,
	}
end
local function draw_planet_arc(planet, system_uibox, planet_uibox)
	local dims = get_planet_dims(planet)

	love.graphics.push()
	love.graphics.scale(G.TILESCALE * G.TILESIZE)
	love.graphics.translate(system_uibox.VT.x + system_uibox.VT.w / 2, system_uibox.VT.y + system_uibox.VT.h / 2)
	love.graphics.translate(
		system_uibox.VT.w * system_uibox.VT.scale / 2,
		system_uibox.VT.h * system_uibox.VT.scale / 2
	)
	love.graphics.translate(planet.center and planet.center.dx or 0, planet.center and planet.center.dy or 0)

	local current_opacity = 0.15
	local current_angle = dims.angle
	love.graphics.setLineWidth(3 / G.TILESIZE / G.TILESCALE)
	love.graphics.setColor(1, 1, 1, current_opacity)
	love.graphics.arc("line", "open", 0, 0, dims.radius, math.rad(current_angle), math.rad(current_angle + 6), 25)
	current_angle = current_angle + 6

	local opacity_step = 0.015
	local angle_step = 2
	current_opacity = current_opacity - opacity_step

	while current_opacity > 0 do
		love.graphics.setColor(1, 1, 1, current_opacity)
		love.graphics.arc(
			"line",
			"open",
			0,
			0,
			dims.radius,
			math.rad(current_angle),
			math.rad(current_angle + angle_step),
			25
		)
		current_angle = current_angle + angle_step
		current_opacity = current_opacity - opacity_step
	end

	love.graphics.pop()
end
local function update_system_render(card)
	if
		card.config.center_key == "j_worm_jtem2_solar_system"
		and not card.worm_jtem2_hide_solar_system
		and card.config.center.discovered
		and card.sprite_facing == "front"
	then
		card.ability.extra = card.ability.extra or {}
		if not card.children.worm_jtem2_solar_system then
			local system = UIBox({
				definition = {
					n = G.UIT.ROOT,
					config = { colour = G.C.CLEAR },
				},
				config = {
					align = "cm",
					offset = { x = 0, y = 0 },
					major = card,
					parent = card,
					instance_type = "CARD",
				},
			})
			system.states.collide.can = false
			card.children.worm_jtem2_solar_system = system
		end
		local system = card.children.worm_jtem2_solar_system
		for k, v in pairs(planets) do
			local can_show = (card.ability.extra.planets[k] or card.ability.extra.show_all)
				or (card.area and card.area.config.collection and v.collection)
			if can_show and not system.children[k] and not card.worm_solar_system_delay_update then
				local dims = get_planet_dims(v)

				local old_paused = G.SETTINGS.paused
				G.SETTINGS.paused = true
				local planet = UIBox({
					definition = {
						n = G.UIT.ROOT,
						config = {
							colour = G.C.CLEAR,
							func = "worm_solar_system_rotate",
							ref_table = v,
						},
						nodes = {
							{
								n = G.UIT.O,
								config = {
									object = SMODS.create_sprite(0, 0, v.size, v.size, v.atlas, v.pos),
								},
							},
						},
					},
					config = {
						major = system,
						parent = system,
						align = "cm",
						offset = {
							x = dims.x,
							y = dims.y,
						},
						instance_type = "CARD",
					},
				})
				G.SETTINGS.paused = old_paused

				planet.role.r_bond = "Weak"
				planet.T.r = math.rad(v.planet_angle or 0)
				planet.states.collide.can = false
				system.children[k] = planet

				local old_draw_self = planet.UIRoot.draw_self
				function planet.UIRoot:draw_self()
					draw_planet_arc(v, system, self.UIBox)
					old_draw_self(self)
				end
			elseif not can_show and system.children[k] then
				system.children[k]:remove()
				system.children[k] = nil
			end
		end
	else
		if card.children.worm_jtem2_solar_system then
			card.children.worm_jtem2_solar_system:remove()
			card.children.worm_jtem2_solar_system = nil
		end
	end
end

-- ui functions & rendering toggle

G.FUNCS.worm_solar_system_rotate = function(e)
	local dims = get_planet_dims(e.config.ref_table)
	e.UIBox.config.offset.x, e.UIBox.config.offset.y = dims.x, dims.y
end
G.FUNCS.worm_toggle_solar_system_render = function(e)
	local card = e.config.ref_table
	card.worm_jtem2_hide_solar_system = not card.worm_jtem2_hide_solar_system
end

local function create_use_button_ui(card)
	return UIBox({
		definition = {
			n = G.UIT.ROOT,
			config = {
				colour = G.C.CLEAR,
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						align = "cm",
						padding = 0.15,
						r = 0.08,
						hover = true,
						shadow = true,
						colour = G.C.MULT,
						button = "worm_toggle_solar_system_render",
						ref_table = card,
					},
					nodes = {
						{
							n = G.UIT.R,
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = localize("b_use"),
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.4,
									},
								},
								{
									n = G.UIT.B,
									config = {
										w = 0.1,
										h = 0.4,
									},
								},
							},
						},
					},
				},
			},
		},
		config = {
			align = "cl",
			major = card,
			parent = card,
			offset = { x = 0.2, y = 0 },
		},
	})
end
local highlight_ref = Card.highlight
function Card:highlight(is_highlighted)
	if
		is_highlighted
		and self.ability.set == "Joker"
		and self.area == G.jokers
		and self.config.center_key == "j_worm_jtem2_solar_system"
	then
		if not self.children.worm_toggle_solar_system_button then
			self.children.worm_toggle_solar_system_button = create_use_button_ui(self)
		end
	elseif self.children.worm_toggle_solar_system_button then
		self.children.worm_toggle_solar_system_button:remove()
		self.children.worm_toggle_solar_system_button = nil
	end

	return highlight_ref(self, is_highlighted)
end

-- smods slop

SMODS.Atlas({
	key = "jtem2_solar_system_planets",
	path = "Jtem 2/solar_system_planets.png",
	px = 71,
	py = 71,
})

local planets_loc_vars = {
	c_mercury = function(card)
		return {
			SMODS.signed(card.ability.extra.c_mercury.mult),
			SMODS.signed(card.ability.extra.c_mercury.chips),
		}
	end,
	c_venus = function(card)
		return {}
	end,
	c_earth = function(card)
		return { card.ability.extra.c_earth.discount }
	end,
	c_ceres = function(card)
		return {
			localize("Two Pair", "poker_hands"),
			localize("Full House", "poker_hands"),
			localize("Flush House", "poker_hands"),
		}
	end,
	c_mars = function()
		return { localize({ type = "name_text", key = "j_splash", set = "Joker" }) }
	end,
	c_jupiter = function(card)
		return { card.ability.extra.c_jupiter.xmult }
	end,
	c_saturn = function(card)
		return { card.ability.extra.c_saturn.stones }
	end,
	c_uranus = function(card)
		return { card.ability.extra.c_uranus.xchips }
	end,
	c_neptune = function(card)
		local neptune_play_n, neptune_play_d = SMODS.get_probability_vars(
			card,
			1,
			card.ability.extra.c_neptune.play_odds,
			"worm_solar_system_neptune_play"
		)
		local neptune_hand_n, neptune_hand_d = SMODS.get_probability_vars(
			card,
			1,
			card.ability.extra.c_neptune.hand_odds,
			"worm_solar_system_neptune_hand"
		)
		return {
			localize("Diamonds", "suits_singular"),
			card.ability.extra.c_neptune.money,
			neptune_play_n,
			neptune_play_d,
			neptune_hand_n,
			neptune_hand_d,
		}
	end,
	c_pluto = function(card)
		local pluto_levelup_n, pluto_levelup_d = SMODS.get_probability_vars(
			card,
			1,
			card.ability.extra.c_pluto.level_up_odds,
			"worm_solar_system_pluto_lvlup"
		)
		local pluto_leveldown_n, pluto_leveldown_d = SMODS.get_probability_vars(
			card,
			1,
			card.ability.extra.c_pluto.level_down_odds,
			"worm_solar_system_pluto_lvldown"
		)
		return { pluto_levelup_n, pluto_levelup_d, pluto_leveldown_n, pluto_leveldown_d }
	end,
	c_eris = function(card)
		return {
			localize("Four of a Kind", "poker_hands"),
			localize("Five of a Kind", "poker_hands"),
			localize("Flush Five", "poker_hands"),
		}
	end,
}

local is_flush_in_hand = function(hand, amount)
	local suits = SMODS.Suit.obj_buffer
	if #hand >= amount then
		for j = 1, #suits do
			local suit = suits[j]
			local flush_count = 0
			for i = 1, #hand do
				if hand[i]:is_suit(suit, nil, true) then
					flush_count = flush_count + 1
				end
			end
			if flush_count >= amount then
				return true
			end
		end
	end
	return false
end

SMODS.Joker({
	key = "jtem2_solar_system",
	atlas = "jtem2_artificial_sun",
	attributes = {
		"space",
		"mult",
		"chips",
		"xmult",
		"xchips",
		"diamonds",
		"economy",
		"generation",
		"chance",
		"joker",
		"tarot",
		"enhancements",
	},

	blueprint_compat = true,
	eternal_compat = false,
	rental_compat = true,

	config = {
		extra = {
			planets = {},

			c_mercury = {
				chips = 50,
				mult = 12,
			},
			c_earth = {
				discount = 1,
			},
			c_jupiter = {
				xmult = 1.5,
			},

			c_saturn = {
				stones = 12,
			},
			c_uranus = {
				xchips = 1.5,
			},
			c_neptune = {
				hand_odds = 4,
				play_odds = 2,
				money = 1,
			},
			c_pluto = {
				level_up_odds = 4,
				level_down_odds = 4,
			},
		},
	},

	rarity = 3,
	cost = 10,

	loc_vars = function(self, info_queue, card)
		for _, k in pairs(planets_order) do
			if card.ability.extra.planets[k] then
				info_queue[#info_queue + 1] =
					{ set = "Other", key = "worm_jtem2_solar_system_effect_" .. k, vars = planets_loc_vars[k](card) }
			end
		end
	end,

	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then
						v:set_cost()
					end
				end
				return true
			end,
		}))
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then
						v:set_cost()
					end
				end
				return true
			end,
		}))
	end,

	calculate = function(self, card, context)
		-- + mercury: +12 mult or +50 chips
		---- (extreme temperature changes)
		--
		-- + venus: create tarot if score is on fire
		---- (hottest planet in solar system)
		--
		-- + earth: planets & celestial packs cost 1 less
		---- (that's our home, come on)
		--
		-- + mars: create splash when blind is selected
		---- (all knows there's a lot of water on in right)
		--
		-- ceres: Two Pair counts as Full House, single-suit Two Pair = Flush House
		---- (dwarf planet in main asteroid belt)
		--
		-- + jupiter: X1.5 Mult
		---- (biggest planet, red dot)
		--
		-- + saturn: adds 12 6 of diamonds as rocks
		---- (famous circles, hexagon on top, diamond rains, 285 moons WHAT A HELL)
		--
		-- uranus: x1.5 Chips
		---- (it is big actually)
		--
		-- + neptune: each played or held in hand diamond 1 in 2 chance to give 1 dollar
		---- (diamond rains)
		--
		-- + pluto: 1 in 4 level up random hand, 1 in 4 decrease level
		---- (so it's planet or dwarf planet?)
		--
		-- + eris: Four of a Kind counts as Five of a Kind, single-suit Four of a Kind = Flush Five
		---- (orbit significantly shifted from Sun, very bright)

		if context.evaluate_poker_hand then
			if card.ability.extra.planets.c_ceres then
				if context.scoring_name == "Two Pair" then
					local hand = (context.poker_hands["Two Pair"] or {})[1] or context.scoring_hand
					local new_hand = is_flush_in_hand(hand, 4) and "Flush House" or "Full House"
					if not context.poker_hands[new_hand] then
						context.poker_hands[new_hand] = { hand }
					end
					return {
						replace_scoring_name = new_hand,
					}
				end
			end
			if card.ability.extra.planets.c_eris then
				if context.scoring_name == "Four of a Kind" then
					local hand = (context.poker_hands["Four of a Kind"] or {})[1] or context.scoring_hand
					local new_hand = is_flush_in_hand(hand, 4) and "Flush Five" or "Five of a Kind"
					if not context.poker_hands[new_hand] then
						context.poker_hands[new_hand] = { hand }
					end
					return {
						replace_scoring_name = new_hand,
					}
				end
			end
		end

		if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Planet" then
			-- I'm not sure that Planet X is a real planet.
			if
				context.consumeable.config.center_key == "c_planet_x"
				and not card.ability.extra.planets.exception_planet_x
			then
				card.ability.extra.planets.exception_planet_x = true
				return {
					message = localize("k_planet_q"),
					colour = G.C.SECONDARY_SET.Planet,
				}
			end

			if
				planets[context.consumeable.config.center_key]
				and not card.ability.extra.planets[context.consumeable.config.center_key]
			then
				card.ability.extra.planets[context.consumeable.config.center_key] = true
				card.worm_solar_system_delay_update = true

				if context.consumeable.config.center_key == "c_saturn" then
					local amount_of_stones = math.floor(card.ability.extra.c_saturn.stones)
					if amount_of_stones > 0 then
						G.E_MANAGER:add_event(Event({
							func = function()
								local center_x, center_y = context.consumeable.T.x, context.consumeable.T.y
								local radius = G.CARD_H * 1.1
								for i = 1, amount_of_stones do
									local circle_part = 2 * math.pi / amount_of_stones
									local card_x, card_y =
										math.cos(circle_part * i) * radius + center_x,
										math.sin(circle_part * i) * radius + center_y
									local playing_card = Card(
										card_x,
										card_y,
										G.CARD_W,
										G.CARD_H,
										G.P_CARDS.D_6,
										G.P_CENTERS.m_stone,
										{ bypass_discovery_center = true }
									)
									playing_card:start_materialize()
									local old_drag = playing_card.states.drag.can
									playing_card.states.drag.can = false
									G.E_MANAGER:add_event(Event({
										trigger = "after",
										delay = 0.1,
										func = function()
											playing_card.states.drag.can = old_drag
											G.playing_card = (G.playing_card and G.playing_card + 1) or 1
											playing_card:add_to_deck()
											G.deck.config.card_limit = G.deck.config.card_limit + 1
											table.insert(G.playing_cards, playing_card)
											G.deck:emplace(playing_card)
											return true
										end,
									}))
								end
								return true
							end,
						}))
					end
				end

				if context.consumeable.config.center_key == "c_earth" then
					G.E_MANAGER:add_event(Event({
						func = function()
							for k, v in pairs(G.I.CARD) do
								if v.set_cost then
									v:set_cost()
								end
							end
							return true
						end,
					}))
				end

				G.E_MANAGER:add_event(Event({
					blocking = false,
					func = function()
						card.worm_solar_system_delay_update = nil
						return true
					end,
				}))

				return {
					message = localize({
						type = "name_text",
						set = "Planet",
						key = context.consumeable.config.center_key,
					}),
					colour = G.C.SECONDARY_SET.Planet,
				}
			end
		end

		if context.joker_main then
			local effects = {}
			if card.ability.extra.planets.c_mercury then
				if pseudorandom("worm_solar_system_mercury") < 0.5 then
					table.insert(effects, {
						chips = card.ability.extra.c_mercury.chips,
					})
				else
					table.insert(effects, {
						mult = card.ability.extra.c_mercury.mult,
					})
				end
			end
			if card.ability.extra.planets.c_jupiter then
				table.insert(effects, {
					xmult = card.ability.extra.c_jupiter.xmult,
				})
			end
			if card.ability.extra.planets.c_uranus then
				table.insert(effects, {
					xchips = card.ability.extra.c_uranus.xchips,
				})
			end
			return SMODS.merge_effects(effects)
		end
		if
			card.ability.extra.planets.c_neptune
			and context.individual
			and context.cardarea == G.hand
			and not context.end_of_round
		then
			if
				context.other_card:is_suit("Diamonds", nil, true)
				and SMODS.pseudorandom_probability(
					card,
					"worm_solar_system_neptune_hand",
					1,
					card.ability.extra.c_neptune.hand_odds
				)
			then
				if context.other_card.debuff then
					return {
						message = localize("k_debuffed"),
						colour = G.C.RED,
					}
				else
					return {
						dollars = card.ability.extra.c_neptune.money,
					}
				end
			end
		end
		if card.ability.extra.planets.c_neptune and context.individual and context.cardarea == G.play then
			if
				context.other_card:is_suit("Diamonds", nil, true)
				and SMODS.pseudorandom_probability(
					card,
					"worm_solar_system_neptune_play",
					1,
					card.ability.extra.c_neptune.play_odds
				)
			then
				return {
					dollars = card.ability.extra.c_neptune.money,
				}
			end
		end
		if
			card.ability.extra.planets.c_mars
			and context.setting_blind
			and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
		then
			G.GAME.joker_buffer = G.GAME.joker_buffer + 1
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.add_card({
								key = "j_splash",
							})
							G.GAME.joker_buffer = 0
							return true
						end,
					}))
					SMODS.calculate_effect(
						{ message = localize("k_plus_joker"), colour = G.C.BLUE },
						context.blueprint_card or card
					)
					return true
				end,
			}))
			return nil, true
		end

		if
			card.ability.extra.planets.c_venus
			and context.after
			and SMODS.last_hand_oneshot
			and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
		then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.add_card({
								set = "Tarot",
								key_append = "worm_solay_system_venus",
							})
							G.GAME.consumeable_buffer = 0
							return true
						end,
					}))
					SMODS.calculate_effect(
						{ message = localize("k_plus_tarot"), colour = G.C.PURPLE },
						context.blueprint_card or card
					)
					return true
				end,
			}))
			return nil, true
		end

		if context.before then
			if card.ability.extra.planets.c_pluto then
				local _poker_hands = {}
				for handname, _ in pairs(G.GAME.hands) do
					if SMODS.is_poker_hand_visible(handname) then
						_poker_hands[#_poker_hands + 1] = handname
					end
				end
				local effects = {}
				if
					SMODS.pseudorandom_probability(
						card,
						"worm_solar_system_pluto_lvlup",
						1,
						card.ability.extra.c_pluto.level_up_odds
					)
				then
					local pokerhand, key = pseudorandom_element(_poker_hands, "worm_solar_system_pluto_lvlup_hand")
					if pokerhand then
						table.remove(_poker_hands, key)
						table.insert(effects, {
							message = localize("k_upgrade_ex"),
							colour = G.C.ORANGE,
							level_up = 1,
							level_up_hand = pokerhand,
						})
					end
				end
				if
					SMODS.pseudorandom_probability(
						card,
						"worm_solar_system_pluto_lvldown",
						1,
						card.ability.extra.c_pluto.level_down_odds
					)
				then
					local _down_poker_hands = {}
					for _, handname in ipairs(_poker_hands) do
						if G.GAME.hands[handname].level >= 1 then
							_down_poker_hands[#_down_poker_hands + 1] = handname
						end
					end
					local pokerhand, key =
						pseudorandom_element(_down_poker_hands, "worm_solar_system_pluto_lvldown_hand")
					if pokerhand then
						table.remove(_poker_hands, key)
						table.insert(effects, {
							message = localize("k_worm_downgrade_ex"),
							colour = G.C.RED,
							level_up = -1,
							level_up_hand = pokerhand,
						})
					end
				end

				return SMODS.merge_effects(effects or {})
			end
		end
	end,

	ppu_team = { "jtem2" },
	ppu_coder = { "sleepyg11" },
	ppu_artist = { "aikoyori" },
})

local card_set_cost_ref = Card.set_cost
function Card:set_cost()
	card_set_cost_ref(self)
	for _, card in ipairs(SMODS.find_card("j_worm_jtem2_solar_system")) do
		if card.ability.extra.planets.c_earth then
			if
				self.ability.set == "Planet"
				or (self.ability.set == "Booster" and self.config.center.kind == "Celestial")
			then
				self.cost = math.max(0, self.cost - card.ability.extra.c_earth.discount)
			end
		end
	end
end

-- local old_get_poker_hand_info = G.FUNCS.get_poker_hand_info
-- function G.FUNCS.get_poker_hand_info(_cards, ...)
--     local
-- end

SMODS.draw_ignore_keys.worm_toggle_solar_system_button = true
SMODS.DrawStep({
	key = "jtem2_toggle_solar_system",
	order = -30,
	func = function(card, layer)
		if card.children.worm_toggle_solar_system_button then
			card.children.worm_toggle_solar_system_button:draw()
		end
	end,
})

local shadow_step_func = SMODS.DrawSteps.shadow.func
SMODS.DrawSteps.shadow.func = function(self, ...)
	if self.config.center_key == "j_worm_jtem2_solar_system" then
		return
	end
	return shadow_step_func(self, ...)
end

SMODS.DrawStep({
	key = "jtem2_solar_system_render",
	order = 85,
	func = function(self, layer)
		update_system_render(self)
	end,
	conditions = { vortex = false },
})
