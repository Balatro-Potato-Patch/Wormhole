SMODS.Atlas {
	key = "eud_teamFeli",
	path = "team-eudaimonia/teamcards/feli.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "eud_teamArta",
	path = "team-eudaimonia/teamcards/arta.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "eud_teamM0xes",
	path = "team-eudaimonia/teamcards/M0xes.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "eud_teamTiger",
	path = "team-eudaimonia/teamcards/tiger.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "eud_teamTyp0",
	path = "team-eudaimonia/teamcards/Typ0.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "eud_teamCosmeggo",
	path = "team-eudaimonia/teamcards/cosmeggo.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "eud_teamJewel",
	path = "team-eudaimonia/teamcards/jewel.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "eud_teamSoul",
	path = "team-eudaimonia/teamcards/soulware.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "eud_teamSillyz",
	path = "team-eudaimonia/teamcards/sillyz.png",
	px = 71,
	py = 95,
}
SMODS.Atlas {
	key = "eud_teamHunter",
	path = "team-eudaimonia/teamcards/hunter.png",
	px = 71,
	py = 95,
}

PotatoPatchUtils.Team({
    name = "TeamEudaimonia",
    colour = HEX('757bc8'),
    loc = true,
    short_credit = true,
}) 

PotatoPatchUtils.Developer({
    name = "LasagnaFelidae",
    colour = G.C.EDITION,
    loc = true,
    team = "TeamEudaimonia",
    atlas = "worm_eud_teamFeli",
    pos = {x=0,y=0},
})

PotatoPatchUtils.Developer({
    name = "cosmeggo",
    colour = HEX('baa1db'),
    loc = true,
    team = "TeamEudaimonia",
    atlas = "worm_eud_teamCosmeggo",
    pos = {x=0,y=0}
})

PotatoPatchUtils.Developer({
    name = "soulware",
    colour = HEX('00ff00'),
    loc = true,
    team = "TeamEudaimonia",
    atlas = "worm_eud_teamSoul",
    pos = {x=0,y=0}
})
PotatoPatchUtils.Developer({
    name = "TigerTHawk",
    colour = HEX('FF00D0'),
    loc = true,
    team = "TeamEudaimonia",
    atlas = "worm_eud_teamTiger",
    pos = {x=0,y=0}
})

PotatoPatchUtils.Developer({
    name = "iamarta",
    colour = HEX('FFBC57'),
    loc = true,
    team = "TeamEudaimonia",
    atlas = "worm_eud_teamArta",
    pos = {x=0,y=0}
})
PotatoPatchUtils.Developer({
    name = "M0xes",
    colour = HEX('9d39c4'),
    loc = true,
    team = "TeamEudaimonia",
    atlas = "worm_eud_teamM0xes",
    pos = {x=0,y=0}
})
PotatoPatchUtils.Developer({
    name = "Sillyz",
    colour = G.C.PURPLE,
    loc = true,
    team = "TeamEudaimonia",
    atlas = "worm_eud_teamSillyz",
    pos = {x=0,y=0}
})
PotatoPatchUtils.Developer({
    name = "Hunter",
    colour = G.C.SECONDARY_SET.Planet,
    loc = true,
    team = "TeamEudaimonia",
    atlas = "worm_eud_teamHunter",
    pos = {x=0,y=0}
})

PotatoPatchUtils.Developer({
    name = "Typ0",
    colour = SMODS.Gradient{key = "Typ0", colours = {HEX('A4C2F4'), HEX('a4eaf4')},cycle = 8},
    loc = true,
    team = "TeamEudaimonia",
    atlas = "worm_eud_teamTyp0",
    pos = {x=0,y=0},
})

PotatoPatchUtils.Developer({
    name = "Jewel",
    colour = HEX('F399FF'),
    loc = true,
    team = "TeamEudaimonia",
    atlas = "worm_eud_teamJewel",
    pos = {x=0,y=0}
})

