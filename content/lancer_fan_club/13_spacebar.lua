--[[ Notes
	- Timing minigame before scoring, kinda like It's TV Time
	- Hit spacebar while thingy's over the things
	- 
]]

local w = 200

Wormhole.LancerFanClub.spacebar = {
	active = false,
	enqueue = function(self, card)
		card:juice_up()
		self.active = true
		self.pre_timer = 1  -- Timer for before the minigame
		self.timer = 1      -- Timer for the minigame itself
		self.canvas = love.graphics.newCanvas(w+15,12)
		G.E_MANAGER:add_event(Event({func = function() return not self.active end}))
		
		G.E_MANAGER:add_event(Event({func = function()
			card:juice_up()
		return true end}))
	end
}

SMODS.Joker {
	key = "lfc_spacebar",
	atlas = "lfc_spacebar",
	pos = { x = 0, y = 0 },
	--pixel_size = { w = 95, h = 23 },
	display_size = { w = 95, h = 23 },

	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = false,

	config = {
		extra = {
			max_xmult_mod = 0.2,
		}
	},
	attributes = {
		"xmult",
		"space", -- literally!
	},

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.max_xmult_mod
			}
		}
	end,

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 1) + card.ability.extra.max_xmult_mod
			return { 
				message = localize('k_upgrade_ex'),
				colour = G.C.MULT
			}
		end
	end,

	ppu_artist = { "J8-Bit" },
	ppu_team = { "Lancer Fan Club" },
	
	update = function(self, card, dt) if not Wormhole.LFC_Util.card_obscured(card) then card.children.center:set_sprite_pos({x = 0, y = love.keyboard.isDown("space")and 1 or 0}) end end
}

if not love.update then function love.update(dt) end end
local update_hook = love.update
function love.update(dt)
	update_hook(dt)

	local space = Wormhole.LancerFanClub.spacebar
	if space.active then
		targettimer = space.pre_timer>0 and "pre_timer" or "timer"
		space[targettimer] = space[targettimer] - dt

		-- End when timer runs out
		if space.timer<0 then
			space.active = false
			space.canvas = nil
			return
		end

		-- Do the gameplay stuff
		if targettimer == "timer" then
			
		end
	end
end

local spr = love.graphics.newImage(love.image.newImageData(SMODS.NFS.newFileData(SMODS.current_mod.path ..
	"assets/lancer_fan_club/spacebar.png")))
local quad = love.graphics.newQuad(0, 0, 1, 1, 1, 1)
local sx,sy = spr:getDimensions()

if not love.draw then function love.draw() end end
local draw_hook = love.draw
function love.draw()
	draw_hook()

	local space = Wormhole.LancerFanClub.spacebar
	if space.active and space.canvas then
		targettimer = space.pre_timer>0 and "pre_timer" or "timer"
		love.graphics.print(targettimer..": "..space[targettimer],10,50) -- Debug line
		
		-- Minigame drawing :3
		local c = love.graphics.getCanvas()
		love.graphics.setCanvas(space.canvas)
		love.graphics.clear()
		love.graphics.setColor(1,1,1,1)


		-- Draw bar
		quad:setViewport(14,3, 1, 8, sx, sy)
		love.graphics.draw(spr,quad,12,2,0,w,1)

		quad:setViewport(16,3, 3, 8, sx, sy)
		love.graphics.draw(spr,quad,12+w,2)
		
		quad:setViewport(1,1, 12, 12, sx, sy)
		love.graphics.draw(spr,quad,0,0)

		love.graphics.setCanvas(c)
		local x, y = love.graphics.getDimensions()
		x, y = x/2, y/2
		local w,h = space.canvas:getDimensions()
		love.graphics.draw(space.canvas,x,y,0,2,2,w/2,h/2)
	end
end
