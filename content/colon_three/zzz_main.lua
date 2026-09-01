Wormhole.COLON_THREE = {C = {}}

Wormhole.COLON_THREE.entropy = SMODS.Gradient {
    key = "entropy",
    colours = {
        G.C.RED,
        G.C.ORANGE,
        G.C.GREEN,
        G.C.BLUE,
        G.C.PURPLE,
    }
}

Wormhole.COLON_THREE.ruby = SMODS.Gradient {
    key = "ruby",
    colours = {
        HEX("FF0000"),
        HEX("F61E8E")
    }
}

SMODS.Atlas {
    path = "colon_three/jokers.png",
    key = "ct_jokers",
    px = 71, py = 95
}

SMODS.Atlas {
    path = "colon_three/nyan_cat.png",
    key = "ct_nyan_cat",
    px = 71, py = 95,
    frames = 2,
    atlas_table = "ANIMATION_ATLAS",
    fps = 4
}

SMODS.Atlas {
    path = "colon_three/disintegration_loop.png",
    key = "ct_event_horizon",
    px = 71, py = 95,
    atlas_table = "STATE_ATLAS",
}

PotatoPatchUtils.Team{
    name = ":3",
    colour = HEX("b52961"),
    loc = "PotatoPatchTeam_colon_three",
    credit_rows = {1,4}
}

SMODS.Atlas {
    path = "colon_three/credits.png",
    key = "ct_credits",
    px = 71, py = 95
}

-- stupid that i have to do this
loc_colour()
G.ARGS.LOC_COLOURS.pure_black = HEX("000000ff")

SMODS.DynaTextEffect {
	key = "mf_credits",
	func = function(dynatext, index, letter)
		letter.offset.y = math.sin((G.TIMERS.REAL + index * 0.1) * 2) * 16
	end,
}

local mf_click_count = 0
local mf_dev_rotation = 0

PotatoPatchUtils.Developer {
    name = "notmario",
    loc = true,
    team = ":3",
    colour = SMODS.Gradient {
        key = "colon_three_notmario_gradient",
        colours = {
            HEX("c34242"),
            HEX("ff6868")
        }
    },
    text_effect = "worm_mf_credits",
    atlas = "worm_ct_credits",
    pos = { x = 3, y = 0 },
    click = function(self)
        mf_click_count = mf_click_count + 1
    end,
}

local lu = love.update
function love.update(dt)
    lu(dt)
    local mix_fac = 0.1 ^ dt
    mf_dev_rotation = mix_fac * (mf_dev_rotation or 0) + (1 - mix_fac) * mf_click_count * math.pi * 2
end

-- mf credits drawstep for polychrome stars
SMODS.DrawStep {
    key = 'ct_credits_polychrome',
    order = 21,
    func = function(self, layer)
        if (((self.children or {}).center or {}).atlas or {}).name ~= "worm_ct_credits" then
            return nil
        end
        if self.children.center.sprite_pos.x ~= 3 then return nil end
        self.children.center:set_sprite_pos({ x = 3, y = 1 })
        self.children.center:draw_shader("polychrome", nil, self.ARGS.send_to_shader)
        self.children.center:draw_shader("polychrome", nil, self.ARGS.send_to_shader)
        self.children.center:draw_shader("polychrome", nil, self.ARGS.send_to_shader)
        self.children.center:draw_shader("polychrome", nil, self.ARGS.send_to_shader)
        self.children.center:draw_shader("polychrome", nil, self.ARGS.send_to_shader)
        self.children.center:set_sprite_pos({ x = 3, y = 0 })
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- rotate hook
local card_draw = Card.draw
function Card:draw(layer, ...)
    local should_hit = false
    if (((self.children or {}).center or {}).atlas or {}).name == "worm_ct_credits" then
        if self.children.center.sprite_pos.x == 3 then should_hit = true end
    end

	if should_hit then
		self.VT.r = self.VT.r + mf_dev_rotation
		for k, v in pairs(self.children) do
			v.VT.r = v.VT.r + mf_dev_rotation
		end
	end

	card_draw(self, layer, ...)

	if should_hit then
		self.VT.r = self.VT.r - mf_dev_rotation
		for k, v in pairs(self.children) do
			v.VT.r = v.VT.r - mf_dev_rotation
		end
	end
end

PotatoPatchUtils.Developer{
    name = "lordruby",
    loc = true,
    team = ":3",
    colour = Wormhole.COLON_THREE.ruby,
    atlas = "worm_ct_credits",
    pos = {x=0,y=0}
}

PotatoPatchUtils.Developer {
    name = "meta",
    loc = true,
    team = ":3",
    colour = SMODS.Gradient {
        key = "colon_three_meta_gradient",
        colours = {
            HEX("FA69EB"),
            HEX("6970FA")
        }
    },
    atlas = "worm_ct_credits",
    pos = { x = 1, y = 0 },
    calculate = function(self, context) return end -- empty for hookability elsewhere
}

PotatoPatchUtils.Developer {
    name = "ophelia",
    loc = true,
    team = ":3",
    colour = SMODS.Gradient {
        key = "colon_three_ophelia_gradient",
        colours = {
            HEX("FFA24A"),
            HEX("FAEB69")
        }
    },
    atlas = "worm_ct_credits",
    pos = { x = 2, y = 0 }
}

PotatoPatchUtils.Developer{ -- im sorry
    name = "nxkoo",
    loc = true,
    team = ":3",
    colour = SMODS.Gradient{
        key = "colon_three_nxkoo_gradient",
        colours = {
            HEX("FF0000"),
        }
    },
    atlas = "worm_ct_credits",
    pos = {x=4,y=0}
}

--[[
> Lack of Empathy
> Lack of Remorse or Guilt
> Impulsivity
> Superficial Charm
> Shallow Emotions
> Grandiose sense of self-worth
> Irresponsibility
> Manipulative Behavior
> Early Behavioral problems
> Highly theatrical 
> Volatile
> Inconsiderate
> Excitable
> Demanding
< Egocentric
> Dependent
> Erratic
> Self-Indulgent
> Sexually provocative
> Unstable Relationships with other People

I AM THE ARCHITECT OF MY OWN DESTRUCTION.
]]

Wormhole.COLON_THREE.loaded = true
for i, v in pairs({
    "laika",
    "dyson_sphere",
    "grabberhand",
    "nyan_cat",
    "event_horizon",
    "tesla_in_space",
    "quantum_tunneling",

    "decrepit_deck",

    "junk/main",
    "junk/junk_hands",
    "junk/packs",

    "junk/asteroid_harvester",
    "junk/starfish_prime",
    "junk/abandoned_wrench",
    "junk/lost_pliers",
    "junk/busted_3d_printer",
    "junk/manhole_cover",
    "junk/solar_sail",
    "junk/trash_compactor",
    "junk/accretion_disk",
    -- "junk/vouchers", -- commented out, do not include in count
    "junk/tag",

    "challenges",
    "ts_quipping_me",
})  do
    assert(SMODS.load_file("content/colon_three/"..v..".lua"))()
end
