Wormhole.COLON_THREE = {C = {}}

SMODS.Atlas {
    path = "colon_three/jokers.png",
    key = "ct_jokers",
    px = 71, py = 95
}

PotatoPatchUtils.Team{
    name = ":3",
    colour = HEX("b52961"),
    loc = "PotatoPatchTeam_colon_three"
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

Wormhole.COLON_THREE.loaded = true
for i, v in pairs({
    "laika",
    "dyson_sphere",
    "wall_e",
    "nyan_cat",

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
})  do
    assert(SMODS.load_file("content/colon_three/"..v..".lua"))()
end
