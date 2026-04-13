SMODS.ConsumableType {
    key = 'util_Spaces',
    default = 'c_worm_util_spaces_basic',
    primary_colour = G.C.SET.Tarot, -- TODO: Fix me
    secondary_colour = G.C.SECONDARY_SET.Tarot, -- TODO: Fix me
    collection_rows = { 5, 6 }, -- TODO: Set this to something approprate
    shop_rate = 0,
}

SMODS.Booster {
    key = "util_spaces_normal_1",
    kind = 'util_Spaces',
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = 3, choose = 1 },
    group_key = "k_util_spaces",
    loc_vars = function(self, info_queue, card)
	local cfg = (card and card.ability) or self.config
	return {
	    vars = { cfg.choose, cfg.extra },
	    key = self.key:sub(1, -3),
	}
    end,
    create_card = function(self, card, i)
	return {
	    set = "util_Spaces",
	    area = G.pack_cards,
	    skip_materialize = true,
	    key_append = "util_spaces_pack"
	}
    end,
}

SMODS.Atlas {
    key = "util_spaces",
    path = "util-modders/spaces.png",
    px = 71,
    py = 95
}

-- SMODS.DrawStep {
--     key = "util_spaces_space",
--     order = 45,
--     func = function(card, layer)
-- 	local conf = card.util_space_conf
-- 	if conf then
-- 	    love.graphics.push()
-- 	    love.graphics.origin()
-- 	    conf.cs.canvas:renderTo(love.graphics.clear, 0, 0, 0, 1.0)
-- 	    love.graphics.pop()
-- 	    conf.cs:draw_shader('dissolve', nil, nil, nil, card.children.center)
-- 	end
--     end,
--     conditions = { facing = "front" },
-- }
test = 3
local function newDrawSelf(self, overlay)
    local canvas = self.canvas
    love.graphics.push("all")

    love.graphics.reset()
    love.graphics.setCanvas(canvas)
    local s = self.center_ref
    local width = canvas:getWidth()
    local scale = width/s.atlas.px

    love.graphics.clear(0, 0, 0, 0)

    local shader = G.SHADERS.worm_util_space
    shader:send("screen_scale", G.TILESCALE*G.TILESIZE*scale/test)
    shader:send("time", G.TIMERS.REAL)
    shader:send("transparency", G.TIMERS.REAL)
    shader:send("transparency", 1)
    shader:send("seed", 1)
    love.graphics.setShader(shader)
    love.graphics.rectangle("fill", 2 * scale, 2 * scale, (s.atlas.px - 4) * scale, (s.atlas.py - 4) * scale)
    love.graphics.setShader()

    love.graphics.draw(
	s.atlas.image,
	s.sprite,
	0,0,
	0,
	scale,
	scale
    )
    love.graphics.pop()
    return self:ds_ref(overlay)
end

SMODS.Consumable {
    key = 'util_spaces_basic',
    set = 'util_Spaces',
    atlas = "util_spaces",
    pos = { x = 0, y = 0 },
    set_ability = function(self, card, initial, delay_sprites)
	card.ability.seed = pseudorandom("worm_util_spaces_seed")
	local cs = SMODS.CanvasSprite {}
	card.util_space_conf = {
	    cs = cs,
	}
	cs.center_ref = card.children.center
	card.children.center = cs
	card.children.center:set_role({major = card, role_type = 'Glued', draw_major = card})
	cs.ds_ref = cs.draw_self
	cs.draw_self = newDrawSelf

	-- card.children.center:set_role({major = card, role_type = 'Glued', draw_major = card})
    end,
}
