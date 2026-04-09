Wormhole.COLON_THREE = {C = {}}

SMODS.Atlas {
    path = "colon_three/jokers.png",
    key = "ct_jokers",
    px = 71, py = 95
}

PotatoPatchUtils.Team{
    name = ":3",
    colour = HEX("b52961"),
    loc = "PotatoPatchTeam_colon_three",
    credit_rows = {3,2}
}

SMODS.Atlas {
    path = "colon_three/credits.png",
    key = "ct_credits",
    px = 71, py = 95
}

PotatoPatchUtils.Developer{
    name = "lordruby",
    loc = true,
    team = ":3",
    colour = SMODS.Gradient{
        key = "colon_three_ruby_gradient",
        colours = {
            HEX("FF0000"),
            HEX("f61e8e")
        }
    },
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
    atlas = "worm_ct_credits",
    pos = { x = 3, y = 0 }
}

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
    "wall_e",
    "nyan_cat",
    "event_horizon",
    "tesla_in_space",
    "quantum_tunneling",

    "decrepit_deck",

    "junk/main",
    "junk/junk_hands",
    "junk/packs",

    "junk/asteroid_harvester",
    "junk/solar_sail",
    "junk/abandoned_wrench",
    "junk/lost_pliers",
    "junk/manhole_cover",
    "junk/starfish_prime",
    "junk/busted_3d_printer",
    "junk/trash_compactor",
    "junk/accretion_disk",
    "junk/vouchers",

    "challenges",
})  do
    assert(SMODS.load_file("content/colon_three/"..v..".lua"))()
end
