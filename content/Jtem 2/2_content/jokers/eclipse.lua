SMODS.Atlas({
	key = "jtem2_eclipse_bg",
	path = "Jtem 2/jokers/eclipse_bg.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "jtem2_eclipse_planets",
	path = "Jtem 2/jokers/eclipse_planets.png",
	px = 71,
	py = 95,
})

function G.FUNCS.worm_jtem2_can_use_eclipse(e)
	local card = e.config.ref_table
	local can_use = card.ability.extras.eclipse_done and #G.hand.cards
	if can_use then
		e.config.colour = G.C.RED
		e.config.button = "worm_jtem2_use_eclipse"
	else
		e.config.colour = G.C.GREY
		e.config.button = nil
	end
end

function G.FUNCS.worm_jtem2_use_eclipse(e)
	---@type Card
	local card = e.config.ref_table
	local eclipse = card.ability.extras.eclipse
	WORM_JTEM.do_things_to_card(G.hand.cards, function(cx, index)
		if eclipse == "solar" then
			if math.fmod(G.GAME.current_round.discards_left, 2) == 1 then
				SMODS.change_base(cx, "Hearts")
			else
				SMODS.change_base(cx, "Diamonds")
			end
		end
		if eclipse == "lunar" then
			if math.fmod(G.GAME.current_round.hands_left, 2) == 1 then
				SMODS.change_base(cx, "Clubs")
			else
				SMODS.change_base(cx, "Spades")
			end
		end
	end, { stagger = 0.2, finish_flipped_delay = 0.2 })
	card.ability.extras.eclipse_done = false
	card.ability.extras.eclipse = "?"
	card.ability.extras.has_sun = false
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
						func = "worm_jtem2_can_use_eclipse",
						button = "worm_jtem2_use_eclipse",
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
		and self.config.center_key == "j_worm_jtem2_eclipse"
	then
		if not self.children.worm_jtem_eclipse_use_btn then
			self.children.worm_jtem_eclipse_use_btn = create_use_button_ui(self)
		end
	elseif self.children.worm_jtem_eclipse_use_btn then
		self.children.worm_jtem_eclipse_use_btn:remove()
		self.children.worm_jtem_eclipse_use_btn = nil
	end

	return highlight_ref(self, is_highlighted)
end

local function get_col_eclipse(eclipse)
	if eclipse == "solar" then
		return G.C.RED
	end
	if eclipse == "lunar" then
		return G.C.BLUE
	end
	return G.C.GREY
end

SMODS.Joker({
	key = "jtem2_eclipse",
	atlas = "jtem2_eclipse_bg",

	ppu_team = { "jtem2" },
	ppu_coder = { "aikoyori" },
	ppu_artist = { "ari", "aikoyori" },

	rarity = 3,
	cost = 6,

	blueprint_compat = false,
	eternal_compat = true,
	rental_compat = true,
	perishable_compat = false,

	config = {
		extras = {
			has_sun = false,
			eclipse = "?", -- can be "solar" or "lunar" or "?" in case it is undecided
			eclipse_done = false,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extras.eclipse ~= "?" and localize("k_worm_jtem2_eclipse_" .. card.ability.extras.eclipse)
					or "???",
				colours = {
					get_col_eclipse(card.ability.extras.eclipse),
				},
			},
		}
	end,
	calculate = function(self, card, context)
		if context.using_consumeable then
			if context.consumeable then
				local key = (context.consumeable or { config = { center = {} } }).config.center.key
				if key == "c_sun" then
					return {
						message = localize("k_upgrade_ex"),
						func = function()
							card.ability.extras.has_sun = true
						end,
					}
				end
				if key == "c_earth" and card.ability.extras.has_sun and not card.ability.extras.eclipse_done then
					return {
						message = localize("k_upgrade_ex"),
						func = function()
							if card.ability.extras.eclipse == "?" then
								card.ability.extras.eclipse = "lunar"
							else
								card.ability.extras.eclipse_done = true
							end
						end,
					}
				end
				if key == "c_moon" and card.ability.extras.has_sun and not card.ability.extras.eclipse_done then
					return {
						message = localize("k_upgrade_ex"),
						func = function()
							if card.ability.extras.eclipse == "?" then
								card.ability.extras.eclipse = "solar"
							else
								card.ability.extras.eclipse_done = true
							end
						end,
					}
				end
			end
		end
	end,
})

SMODS.draw_ignore_keys.worm_jtem_eclipse_use_btn = true
SMODS.DrawStep({
	key = "jtem2_use_eclipse_btn",
	order = -30,
	func = function(card, layer)
		if card.children.worm_jtem_eclipse_use_btn then
			card.children.worm_jtem_eclipse_use_btn:draw()
		end
	end,
})
SMODS.DrawStep({
	key = "jtem2_eclipse_planets",
	order = 85,
	func = function(self, layer)
		if self.config.center.key == "j_worm_jtem2_eclipse" then
			if (not self.children.worm_jtem2_sun) and self.ability.extras.has_sun then
				self.children.worm_jtem2_sun =
					SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, "worm_jtem2_eclipse_planets", { x = 0, y = 0 })
				self.children.worm_jtem2_sun:set_role({ major = self, role_type = "Minor", draw_major = self })
			end
			if self.children.worm_jtem2_sun and not self.ability.extras.has_sun then
				self.children.worm_jtem2_sun:remove()
				self.children.worm_jtem2_sun = nil
			end
			if (not self.children.worm_jtem2_moon_solar_eclipse) and (self.ability.extras.eclipse == "solar") then
				self.children.worm_jtem2_moon_solar_eclipse =
					SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, "worm_jtem2_eclipse_planets", { x = 1, y = 0 })
				self.children.worm_jtem2_moon_solar_eclipse:set_role({
					major = self,
					role_type = "Minor",
					draw_major = self,
				})
			end
			if self.children.worm_jtem2_moon_solar_eclipse and not (self.ability.extras.eclipse == "solar") then
				self.children.worm_jtem2_moon_solar_eclipse:remove()
				self.children.worm_jtem2_moon_solar_eclipse = nil
			end
			if
				not self.children.worm_jtem2_earth_solar_eclipse
				and ((self.ability.extras.eclipse == "solar") and self.ability.extras.eclipse_done)
			then
				self.children.worm_jtem2_earth_solar_eclipse =
					SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, "worm_jtem2_eclipse_planets", { x = 2, y = 0 })
				self.children.worm_jtem2_earth_solar_eclipse:set_role({
					major = self,
					role_type = "Minor",
					draw_major = self,
				})
			end
			if
				self.children.worm_jtem2_earth_solar_eclipse
				and not ((self.ability.extras.eclipse == "solar") and self.ability.extras.eclipse_done)
			then
				self.children.worm_jtem2_earth_solar_eclipse:remove()
				self.children.worm_jtem2_earth_solar_eclipse = nil
			end
			if (not self.children.worm_jtem2_earth_lunar_eclipse) and (self.ability.extras.eclipse == "lunar") then
				self.children.worm_jtem2_earth_lunar_eclipse =
					SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, "worm_jtem2_eclipse_planets", { x = 1, y = 1 })
				self.children.worm_jtem2_earth_lunar_eclipse:set_role({
					major = self,
					role_type = "Minor",
					draw_major = self,
				})
			end
			if self.children.worm_jtem2_earth_lunar_eclipse and not (self.ability.extras.eclipse == "lunar") then
				self.children.worm_jtem2_earth_lunar_eclipse:remove()
				self.children.worm_jtem2_earth_lunar_eclipse = nil
			end
			if
				not self.children.worm_jtem2_moon_lunar_eclipse
				and ((self.ability.extras.eclipse == "lunar") and self.ability.extras.eclipse_done)
			then
				self.children.worm_jtem2_moon_lunar_eclipse =
					SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, "worm_jtem2_eclipse_planets", { x = 2, y = 1 })
				self.children.worm_jtem2_moon_lunar_eclipse:set_role({
					major = self,
					role_type = "Minor",
					draw_major = self,
				})
			end
			if
				self.children.worm_jtem2_moon_lunar_eclipse
				and not ((self.ability.extras.eclipse == "lunar") and self.ability.extras.eclipse_done)
			then
				self.children.worm_jtem2_moon_lunar_eclipse:remove()
				self.children.worm_jtem2_moon_lunar_eclipse = nil
			end
		end
	end,
	conditions = { vortex = false, facing = "front" },
})
