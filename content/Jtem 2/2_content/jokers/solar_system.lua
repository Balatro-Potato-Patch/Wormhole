-- planets definition & render

local planets = {
	c_mercury = {
		speedfactor = 1 / 0.241,
		radius = 0.6,
		size = 0.7,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 3 },
		collection = true,
	},
	c_venus = {
		speedfactor = 1 / 0.615,
		radius = 1,
		size = 0.85,

		angle = 150,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 4 },
		collection = true,
	},
	c_earth = {
		speedfactor = 1,
		radius = 1.4,
		size = 1,

		angle = 80,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 5 },
		collection = true,
	},
	c_mars = {
		colour = G.C.CHIPS,
		speedfactor = 1 / 1.881,
		radius = 1.8,
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
		radius = 2.1,
		size = 0.8,

		angle = 15,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 1 },
	},
	c_jupiter = {
		speedfactor = 1 / 11.86,
		radius = 2.4,
		size = 1.35,

		angle = 300,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 7 },
	},
	c_saturn = {
		speedfactor = 1 / 29.46,
		radius = 3,
		size = 2,
		angle = 180,
		planet_angle = 26.73,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 8 },
		collection = true,
	},
	c_uranus = {
		speedfactor = 1 / 84.01,
		radius = 3.4,
		size = 1.8,
		angle = 35,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 9 },
	},
	c_neptune = {
		speedfactor = 1 / 164.8,
		radius = 3.8,
		size = 1.8,
		angle = 265,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 10 },
	},
	c_pluto = {
		speedfactor = 1 / 247.7,
		radius = 4.2,
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
		radius = 5,
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

local function get_planet_dims(planet)
	local center = planet.center or {}
	local current_angle = (planet.angle or 0) + G.TIMERS.REAL * 30 * math.sqrt(planet.speedfactor or 1)
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

	love.graphics.setLineWidth(3 / G.TILESIZE / G.TILESCALE)
	local current_opacity = 0.15
	love.graphics.setColor(1, 1, 1, current_opacity)
	local current_angle = dims.angle
	love.graphics.arc("line", "open", 0, 0, dims.radius, math.rad(current_angle), math.rad(current_angle - 6), 25)
	current_angle = current_angle - 6
	local opacity_step = 0.015
	local angle_step = 2
	while current_opacity > 0 do
		current_opacity = math.max(0, current_opacity - opacity_step)
		if current_opacity == 0 then
			break
		end
		love.graphics.setColor(1, 1, 1, current_opacity)
		love.graphics.arc(
			"line",
			"open",
			0,
			0,
			dims.radius,
			math.rad(current_angle),
			math.rad(current_angle - angle_step),
			25
		)
		current_angle = current_angle - angle_step
	end

	love.graphics.pop()
end
local function update_system_render(center, card, dt)
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
			if can_show and not system.children[k] then
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

SMODS.Joker({
	key = "jtem2_solar_system",

	config = {
		extra = {
			planets = {},
		},
	},

	can_use = function()
		return true
	end,
	use = function(self, card)
		self.worm_jtem2_hide_solar_system = not self.worm_jtem2_hide_solar_system
	end,
	calculate = function(self, card, context)
		if
			context.using_consumeable
			and context.consumeable.ability.set == "Planet"
			and planets[context.consumeable.config.center_key]
			and not card.ability.extra.planets[context.consumeable.config.center_key]
		then
			card.ability.extra.planets[context.consumeable.config.center_key] = true
			return {
				message = localize({ type = "name_text", set = "Planet", key = context.consumeable.config.center_key }),
				colour = G.C.SECONDARY_SET.Planet,
			}
		end
	end,
	update = function(self, card, dt)
		update_system_render(self, card, dt)
	end,

	ppu_team = { "jtem2" },
	ppu_coder = { "sleepyg11" },
})

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
