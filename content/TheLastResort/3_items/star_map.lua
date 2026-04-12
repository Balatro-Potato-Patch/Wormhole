SMODS.Consumable{
	key = "tlr_starmap",
	set = "Spectral",
	atlas = "tlr_spectrals",
	pos = {x = 1, y = 0},
	can_use = function() return true end,
	soul_set = "worm_tlr_constellation",
	select_card = function (self, card, pack)
		if #G.consumeables.cards < G.consumeables.config.card_limit then
			return "consumeables"
		end
	end,
	hidden = true,
	loc_vars = function(self, info_queue, card)
		return {vars = {colours = {SMODS.ConsumableTypes.worm_tlr_constellation.secondary_colour}}}
	end,
	set_sprites = function (self, card, front)
		card.worm_tlr_canvas_text = SMODS.CanvasSprite{
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
				love.graphics.draw(img, 0, 0, 0, 0.8, 0.8) -- arbitrary scaling values
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
		for _, _card in ipairs(G.consumeables.cards) do
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
		for _, _card in ipairs(G.consumeables.cards) do
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
		for _, _card in ipairs(G.consumeables.cards) do
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
	ppu_coder = {"Foo54"},
	ppu_artist = {"Foo54", "Aura2247", "Jogla"}
}

SMODS.DrawStep {
	key = 'behind_canvas_text',
	order = -25,
	func = function(self, layer)
		if self.worm_tlr_canvas_text and (self.config.center.discovered or self.bypass_discovery_center) then
			for _, sprite in ipairs(self.worm_tlr_canvas_text[1] and self.worm_tlr_canvas_text or {self.worm_tlr_canvas_text}) do
				love.graphics.push()
				love.graphics.origin()
				sprite.canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
				local text = love.graphics.newText(sprite.font, {sprite.text_colour or G.C.UI.TEXT_LIGHT, sprite.ref_table and sprite.ref_table[sprite.ref_value] or sprite.text})
				local scale_fac = math.min((sprite.text_width or sprite.canvasW)/text:getWidth(), (sprite.text_height or sprite.canvasH)/text:getHeight()) * sprite.canvasScale
				love.graphics.pop()
				sprite.role.draw_major = self
				sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
			end
		end
	end,
	conditions = { vortex = false, facing = 'front' },
}