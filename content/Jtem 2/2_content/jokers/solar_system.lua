SMODS.Atlas({
	key = "jtem2_solar_system_planets",
	path = "Jtem 2/solar_system_planets.png",
	px = 71,
	py = 71,
})

local planets = {
	c_mercury = {
		speedfactor = 1 / 0.241,
		radius = 0.6,
		size = 0.7,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 3 },
	},
	c_venus = {
		speedfactor = 1 / 0.615,
		radius = 1,
		size = 0.85,

		angle = 150,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 4 },
	},
	c_earth = {
		speedfactor = 1,
		radius = 1.4,
		size = 1,

		angle = 80,

		atlas = "worm_jtem2_solar_system_planets",
		pos = { y = 0, x = 5 },
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

	ppu_team = { "jtem2" },
	ppu_coder = { "sleepyg11" },
})

G.FUNCS.worm_solar_system_rotate = function(e)
	local radius = e.config.worm_radius
	local center = e.config.worm_center or {}
	local center_dx, center_dy = center.dx or 0, center.dy or 0
	e.config.worm_current_angle = e.config.worm_angle + G.TIMERS.REAL * 30 * (e.config.worm_speedfactor or 1)
	e.UIBox.config.offset.x, e.UIBox.config.offset.y =
		math.cos(math.rad(e.config.worm_current_angle)) * radius + center_dx,
		math.sin(math.rad(e.config.worm_current_angle)) * radius + center_dy
end

SMODS.DrawStep({
	key = "jtem2_solar_system",
	order = 86,
	func = function(self)
		if
			self.config.center_key == "j_worm_jtem2_solar_system"
			and not self.worm_jtem2_hide_solar_system
			and self.config.center.discovered
			and self.sprite_facing == "front"
		then
			if not self.children.worm_jtem2_solar_system then
				local system = UIBox({
					definition = {
						n = G.UIT.ROOT,
						config = { colour = G.C.CLEAR },
					},
					config = {
						align = "cm",
						offset = { x = 0, y = 0 },
						major = self,
						parent = self,
						instance_type = "CARD",
					},
				})
				system.states.collide.can = false
				self.children.worm_jtem2_solar_system = system
			end
			local system = self.children.worm_jtem2_solar_system
			for k, v in pairs(planets) do
				self.ability.extra = self.ability.extra or {}
				if self.ability.extra.planets[k] and not system.children[k] then
					local start_angle = (v.angle or 0) + G.TIMERS.REAL * 30 * (v.speedfactor or 1)
					local old_paused = G.SETTINGS.paused
					G.SETTINGS.paused = true
					local planet = UIBox({
						definition = {
							n = G.UIT.ROOT,
							config = {
								colour = G.C.CLEAR,
								func = "worm_solar_system_rotate",
								worm_radius = v.radius * 1.5,
								worm_angle = (v.angle or 0),
								worm_speedfactor = math.sqrt(v.speedfactor),
								worm_center = v.center,
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
								x = math.cos(math.rad(start_angle)) * v.radius * 1.5 + (v.center and v.center.dx or 0),
								y = math.sin(math.rad(start_angle)) * v.radius * 1.5 + (v.center and v.center.dy or 0),
							},
							instance_type = "CARD",
						},
					})
					G.SETTINGS.paused = old_paused
					planet.role.r_bond = "Weak"
					planet.T.r = math.rad(v.planet_angle or 0)
					local old_draw_self = planet.UIRoot.draw_self
					function planet.UIRoot:draw_self()
						local moveable = system

						love.graphics.push()
						love.graphics.scale(G.TILESCALE * G.TILESIZE)
						love.graphics.translate(moveable.VT.x + moveable.VT.w / 2, moveable.VT.y + moveable.VT.h / 2)
						love.graphics.translate(
							moveable.VT.w * moveable.VT.scale / 2,
							moveable.VT.h * moveable.VT.scale / 2
						)
						love.graphics.translate(v.center and v.center.dx or 0, v.center and v.center.dy or 0)

						love.graphics.setLineWidth(3 / G.TILESIZE / G.TILESCALE)
						local current_opacity = 0.15
						love.graphics.setColor(1, 1, 1, current_opacity)
						local current_angle = self.config.worm_current_angle or 0
						love.graphics.arc(
							"line",
							"open",
							0,
							0,
							v.radius * 1.5,
							math.rad(current_angle),
							math.rad(current_angle - 6),
							25
						)
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
								v.radius * 1.5,
								math.rad(current_angle),
								math.rad(current_angle - angle_step),
								25
							)
							current_angle = current_angle - angle_step
						end

						love.graphics.pop()
						old_draw_self(self)
					end
					planet.states.collide.can = false
					system.children[k] = planet
				elseif not self.ability.extra.planets[k] and system.children[k] then
					system.children[k]:remove()
					system.children[k] = nil
				end
			end
		else
			if self.children.worm_jtem2_solar_system then
				self.children.worm_jtem2_solar_system:remove()
				self.children.worm_jtem2_solar_system = nil
			end
		end
	end,
	conditions = { vortex = false },
})
