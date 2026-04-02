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
			worm_tlr_func = function(self, other_obj, ms, mr, mx, my)
				love.graphics.push()
				local scale = (other_obj.scale_mag or other_obj.VT.scale)
				love.graphics.scale(scale)
				love.graphics.translate(other_obj.T.w/2, other_obj.T.h/2)
				love.graphics.scale(1/scale)
				love.graphics.stencil(function()
					love.graphics.circle("fill", 0, 0, 25)
				end, "replace", 1)
				love.graphics.setStencilTest("greater", 0)
				love.graphics.push()
				love.graphics.origin()
				local shader = love.graphics.getShader()
				love.graphics.setShader()
				local x, y = love.mouse.getPosition()
				local img = SMODS.Atlases.worm_tlr_starmap.image
				--love.graphics.scale(scale)
				--love.graphics.translate(other_obj.T.x, other_obj.T.y)
				love.graphics.translate(img:getWidth() / 2, img:getHeight() / 2)
    		prep_draw(other_obj, (1 + (ms or 0)), (mr or 0), self.ARGS.draw_from_offset, true)
				love.graphics.scale(1/scale)
				love.graphics.translate((x) / 10, (y) / 10)
				love.graphics.translate(-img:getWidth() / 2, -img:getHeight() / 2)
				love.graphics.draw(img, 0, 0)
				love.graphics.setShader(shader)
				love.graphics.pop()
				love.graphics.pop()
				love.graphics.setStencilTest()
				love.graphics.pop()
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