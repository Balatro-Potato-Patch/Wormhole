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
    select_card = "consumeables",
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

local function newDrawSelf(self, overlay)
    if self.FRAME.DRAW < G.FRAMES.DRAW and not G.OVERLAY_TUTORIAL then
	self.FRAME.DRAW = G.FRAMES.DRAW
	local canvas = self.canvas
	love.graphics.push("all")

	love.graphics.reset()
	love.graphics.setCanvas(canvas)
	local s = self.center_ref
	local width = canvas:getWidth()
	local scale = width/s.atlas.px

	love.graphics.clear(0, 0, 0, 0)

	local shader = G.SHADERS.worm_util_space
	local conf = self.parent.ability.space_conf
	shader:send("screen_scale", scale / .75)
	shader:send("time", G.TIMERS.REAL)
	shader:send("transparency", 1)
	shader:send("seed", conf.seed)
	shader:send("nebula_color1", conf.nebula1)
	shader:send("nebula_color2", conf.nebula2)
	shader:send("nebula_color3", conf.nebula3)
	shader:send("shooting", conf.shooting)
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
    end
    return self:ds_ref(overlay)
end

local options = { "shooting", "nebula", "nebula", "nebula", "miss", "miss" }
local nebulaColors = {
    G.C.SECONDARY_SET.Spectral,
    G.C.YELLOW,
    G.C.CHANCE,
    G.C.BOOSTER,
    G.C.SET.Default,
    G.C.ETERNAL,
}
local function calcCard(self, card)
    local seed = card.ability.seed
    local opts = copy_table(options)
    local conf = {
	seed = seed,
	nebula1 = G.C.CLEAR,
	nebula2 = G.C.CLEAR,
	nebula3 = G.C.CLEAR,
	shooting = false,
    }
    local nebula = 1
    pseudoshuffle(opts, seed)

    for i = 1, self.space_conf.options do
	local opt = opts[i]
	if opt == "shooting" then
	    conf.shooting = true
	elseif opt == "nebula" then
	    conf["nebula" .. nebula] = pseudorandom_element(nebulaColors, seed + nebula)
	    nebula = nebula + 1
	end
    end
    return conf
end

SMODS.Consumable {
    key = 'util_spaces_basic',
    set = 'util_Spaces',
    atlas = "util_spaces",
    pos = { x = 0, y = 0 },
    space_conf = {
	options = 2,
    },
    set_ability = function(self, card, initial, delay_sprites)
	card.ability.seed = pseudorandom("worm_util_spaces_seed")
	card.ability.space_conf = calcCard(self, card)
	local cs = SMODS.CanvasSprite {
	    canvasScale = 2,
	}
	cs.center_ref = card.children.center
	card.children.center = cs
	card.children.center:set_role({major = card, role_type = 'Glued', draw_major = card})
	cs.ds_ref = cs.draw_self
	cs.draw_self = newDrawSelf
    end,
}
