--[[ Notes
	- Timing minigame before scoring, kinda like It's TV Time
	- Hit spacebar while thingy's over the things
	- 
]]

local w = 200 		-- Width of bar
local len = 2 		-- Duration of minigame
local count = 5 	-- Amount of hits
local window = 0.08 -- Timing window in seconds

Wormhole.LancerFanClub.spacebar = {
	active = false,
	enqueue = function(self, card)
		card:juice_up()
		self.active = true
		self.pre_timer = 1  -- Timer for before the minigame
		self.timer = len    -- Timer for the minigame itself
		self.canvas = love.graphics.newCanvas(w+15,12)
		self.card = card

		local t = {}
		for i = 1, count, 1 do
			t[(pseudorandom("lfc_spacebar_hit")+i-1)/count*len] = true -- Makes them spawn in random positions within sections, so they're spread out
		end
		self.hitmarkers = t
		print(t)

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
		if context.worm_lfc_on_play_press then
			Wormhole.LancerFanClub.spacebar:enqueue(card)
		end
		--[[if context.individual and context.cardarea == G.play then
			context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 1) + card.ability.extra.max_xmult_mod
			return { 
				message = localize('k_upgrade_ex'),
				colour = G.C.MULT
			}
		end]]
	end,

	ppu_artist = { "J8-Bit" },
	ppu_coder = { "ellestuff." },
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
		end
	end
end

if not love.keypressed then function love.keypressed(key, scancode, isrepeat) end end
local keypressed_hook = love.keypressed
function love.keypressed( key, scancode, isrepeat )
	-- Do the gameplay stuff
	local space = Wormhole.LancerFanClub.spacebar
	if space.active and space.pre_timer<0 and key == "space" then
		local t = len-space.timer
		local ht = nil
		-- Get nearest hitmarker
		for k, v in pairs(space.hitmarkers) do
			if v and (not ht or math.abs(t-k)<math.abs(t-ht)) then
				ht = k
			end
		end

		if ht and math.abs(t-ht)<window then
			space.hitmarkers[ht] = false
			space.card:juice_up()
			space.timingoffset = t-ht
			play_sound("paper1",1,8)
		else
			play_sound("paper1",2,8)
		end
	else
		keypressed_hook(key, scancode, isrepeat)
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
	
		quad:setViewport(24,2, 3, 10, sx, sy)
		for k, v in pairs(space.hitmarkers) do
			if v and (space.pre_timer<0 or 1-space.pre_timer>k/len) then
				love.graphics.draw(spr,quad,12+k*w/len,1)
			end
		end

		quad:setViewport(20,1, 3, 12, sx, sy)
		if targettimer == "timer" then
			love.graphics.draw(spr,quad,12+(len-space.timer)*w/len,0)
		end

		quad:setViewport(1,1, 12, 12, sx, sy)
		love.graphics.draw(spr,quad,0,0)

		love.graphics.setCanvas(c)
		local x, y = love.graphics.getDimensions()
		local w,h = space.canvas:getDimensions()
		love.graphics.draw(space.canvas,x/2,y/2,0,2,2,w/2,h/2)
		if space.timingoffset then
			love.graphics.printf(math.floor(space.timingoffset*1000).."ms",x/2-88,y/2+12,200,"center")
		end
	end
end

-- Just copypasted this from my Tenna code lol
local hook = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
	SMODS.calculate_context { worm_lfc_on_play_press = true }
	hook(e)
end