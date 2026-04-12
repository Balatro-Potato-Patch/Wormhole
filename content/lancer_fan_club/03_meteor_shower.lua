local joker = SMODS.Joker {
	key = 'lfc_meteor_shower',
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				localize("$"),
				card.ability.extra.dollars,
			}
		}
	end,
	config = { extra = { dollars = 3 } },
	rarity = 2,
	cost = 6,
	ppu_coder = { "ellestuff." },
	ppu_artist = {"J8-Bit"},
	ppu_team = { "Lancer Fan Club" },
	atlas = "lfc_jokers",
	pos = { x = 1, y = 0 },
	attributes = { "economy" }
}

local meteor_sprite = love.graphics.newImage(love.image.newImageData(SMODS.NFS.newFileData(SMODS.current_mod.path ..
	"assets/lancer_fan_club/meteors.png")))
local explosion_sprite = love.graphics.newImage(love.image.newImageData(SMODS.NFS.newFileData(SMODS.current_mod.path ..
	"assets/lancer_fan_club/explosion.png")))

local mx, my = meteor_sprite:getDimensions()
local ex, ey = explosion_sprite:getDimensions()

local meteor_click = function(meteor)
	play_sound("worm_lfc_explosion")
	ease_dollars(meteor.dollars, true)
	meteor.clicked = 0
end

local meteors = {}
local meteor_quad = love.graphics.newQuad(0, 0, 1, 1, 1, 1)

function Wormhole.LancerFanClub.create_meteor(value,spry)
	local meteor = {
		spr = {
			x = pseudorandom("worm_lfc_meteorsprite", 0, math.ceil(mx / 64)-1),
			y = spry or 0
		},
		vel = {
			x = pseudorandom("worm_lfc_meteor_velx") * 4, -- random float in range 0  to 40
			y = pseudorandom("worm_lfc_meteor_vely") * 4 + 4, -- random float in range 40 to 80
			rot = pseudorandom("worm_lfc_meteor_velrot") * 2
		},
		pos = {
			x = pseudorandom("worm_lfc_meteor_x") * (love.graphics.getWidth() - 128) - 64,
			y = -64,
			rot = pseudorandom("worm_lfc_meteor_rot") * math.pi * 2
		},
		dollars = value
	}

	meteors[#meteors + 1] = meteor
end

joker.calculate = function(self, card, context)
	if (context.individual and not context.end_of_round and context.cardarea == G.play) or context.forcetrigger then
		G.E_MANAGER:add_event(Event({
			func = function()
				Wormhole.LancerFanClub.create_meteor(card.ability.extra.dollars)
				card:juice_up(0.4,0.4)
				return true
			end
		}))
		return nil, true -- makes joker-retriggering effects work
	end
end

local vel_mult = 150             -- Multiplier for meteor velocity

-- Update hook to move and destroy offscreen meteors
if not love.update then function love.update(dt) end end
local update_hook = love.update
function love.update(dt)
	update_hook(dt)

	for i, v in ipairs(meteors) do
		if v.clicked then
			if v.clicked > 1 then table.remove(meteors, i) end
			v.clicked = v.clicked + dt
		else
			v.pos.x = v.pos.x + v.vel.x * dt * vel_mult
			v.pos.y = v.pos.y + v.vel.y * dt * vel_mult
			v.pos.rot = (v.pos.rot + v.vel.rot * dt * 5) % (math.pi * 2)

			if v.pos.y > love.graphics.getHeight() + 64 then table.remove(meteors, i) end
		end
	end
end

-- Update hook to click and destroy meteors
if not love.mousepressed then function love.mousepressed(x, y, button, istouch, presses) end end
local click_hook = love.mousepressed
function love.mousepressed(x, y, button, istouch, presses)
	for i, v in ipairs(meteors) do
		local dist = math.sqrt(math.abs(x - v.pos.x) ^ 2 + math.abs(y - v.pos.y) ^ 2)
		if dist < 64 and not v.clicked then
			meteor_click(v)
			return
		end
	end

	click_hook(x, y, button, istouch, presses)
end

-- Draw hook to place meteors onscreen
if not love.draw then function love.draw() end end
local draw_hook = love.draw
function love.draw()
	draw_hook()

	love.graphics.setColor(1, 1, 1, 1)
	--love.graphics.print("Meteor Count: "..#meteors,10,50) -- Debug line
	for i, v in ipairs(meteors) do
		if v.clicked then
			local f = math.floor(v.clicked * 17)
			meteor_quad:setViewport(f * 71, 0, 71, 100, ex, ey) -- Reposition quad to use the correct frame
			love.graphics.draw(explosion_sprite, meteor_quad, v.pos.x, v.pos.y, 0, 2, 2, 35, 55)
		else
			meteor_quad:setViewport(v.spr.x * 64, v.spr.y * 64, 64, 64, mx, my) -- Reposition quad to use the correct frame
			love.graphics.draw(meteor_sprite, meteor_quad, v.pos.x, v.pos.y, v.pos.rot, 2, 2, 32, 32)
		end
	end
end
