PotatoPatchUtils.Team {
  name = 'util-modders',
  colour = HEX"a3988a",
  loc = "t_util_modders",
}

local wilson_colour = SMODS.Gradient{
    key = "wilson_colour",
    cycle = 60,
    colours = {
        G.C.GOLD,
        lighten(G.C.PURPLE, 0.2),
    }
}

PotatoPatchUtils.Developer {
    name = 'wilson',
    colour = wilson_colour,
    loc = "d_wilson",
    team = 'util-modders',
}

PotatoPatchUtils.Developer {
    name = 'frost',
    colour = G.C.WHITE,
    loc = "d_frost",
    team = 'util-modders',
}

PotatoPatchUtils.Developer {
    name = 'ethangreen-dev',
    colour = G.C.WHITE,
    loc = "d_metherul",
    team = 'util-modders',
}
