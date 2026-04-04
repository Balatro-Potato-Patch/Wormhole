SMODS.Consumable{
	key = "tlr_starmap",
	set = "Spectral",
	pos = {x=0,y=0},
	can_use = function() return true end,
	soul_set = "worm_tlr_constellation",
	select_card = function (self, card, pack)
		if #G.consumeables.cards < G.consumeables.config.card_limit then
			return "consumeables"
		end
	end,
	hidden = true,
	loc_vars = function(self, info_queue, card)
		return {vars = {colours = {SMODS.ConsumableTypes.worm_tlr_constellation.primary_colour}}}
	end,
	set_sprites = function (self, card, front)
		card.canvas_text = SMODS.CanvasSprite{
			worm_tlr_func = function(other_obj, ms, mr, mx, my)
				local scale = G.TILESIZE * G.TILESCALE / 2
				love.graphics.stencil(function()
					love.graphics.circle("fill", other_obj.VT.w/2 * scale,  other_obj.VT.h/2 * scale, 25)
				end, "replace", 1)
				love.graphics.setStencilTest("greater", 0)
				local x, y = love.mouse.getPosition()
				local gx, gy = love.graphics.transformPoint(other_obj.VT.w/2 * scale, other_obj.VT.h/2 * scale)
				local img = SMODS.Atlases.worm_tlr_starmap.image
				local map_scale = 0.75
				local tx, ty = -img:getWidth() / 2 + (x - gx) / 10, -img:getHeight() / 2 + other_obj.VT.h/2 + (y - gy) / 10
				love.graphics.draw(
					img,
					math.min(math.max(tx, -img:getWidth() * map_scale),
					img:getWidth() * map_scale), math.min(math.max(ty, -img:getHeight() * map_scale), img:getHeight() * map_scale),
					0, map_scale, map_scale
				)
				love.graphics.setStencilTest()
			end
		}
	end,
	use = function (self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		for _, _card in ipairs(G.consumeables) do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					_card:flip()
					play_sound('card1')
					_card:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.2)
		for _, _card in ipairs(G.consumeables) do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					_card.ability.tier = 4
					_card.config.center:update_sprites(_card) -- we don't use the helper function here so the event runs at the right time
					return true
				end
			}))
		end
		for _, _card in ipairs(G.consumeables) do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					_card:flip()
					play_sound('tarot2', 1, 0.6)
					_card:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				G.consumeables:unhighlight_all()
				card:juice_up(0.3, 0.3)
				return true
			end
		}))
		delay(0.5)
	end,
	ppu_team = {"TheLastResort"},
	ppu_coder = {"Foo54"}
}
--[[
SMODS.DrawStep{
	order = 41,
	key = "tlr_starmap",
	conditions = { vortex = false, facing = 'front' },
	func = function (card, layer)
		if false and card.config and card.config.center and card.config.center.key == "c_worm_tlr_starmap" then
			love.graphics.push()
			love.graphics.origin()
			prep_draw(card, 1)
			--love.graphics.scale(1/(1/card.VT.w), 1/(1/card.VT.h))
			love.graphics.scale(1/(G.TILESIZE*G.TILESCALE))
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.stencil(function()
				love.graphics.circle("fill", 0, 0, 50)
			end, "replace", 1)
			love.graphics.setStencilTest("greater", 0)
			love.graphics.push()
			love.graphics.origin()
			local x, y = love.mouse.getPosition()
			local img = SMODS.Atlases.worm_tlr_starmap.image
			prep_draw(card, 1, 0, card.ARGS.draw_from_offset)
			--love.graphics.translate((x) / 10, (y) / 10)
			love.graphics.translate(-img:getWidth() / 2, -img:getHeight() / 2)
			--love.graphics.draw(img, 0, 0)
			love.graphics.rectangle("fill", 0, 0, 600, 600)
			love.graphics.pop()
			love.graphics.pop()
			love.graphics.pop()
			love.graphics.setStencilTest()
			love.graphics.pop()
		end
	end
}
]]