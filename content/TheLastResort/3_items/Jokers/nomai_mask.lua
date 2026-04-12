SMODS.Joker{
	key = "tlr_nomaimask",
	atlas = 'tlr_joker',
	pos = { x = 1, y = 0 },
	rarity = 3,
	cost = 8,
	blueprint_compat = false,
	perishable_compat = false,
	loc_vars = function (self, info_queue, card)
		return {vars = {colours = {SMODS.ConsumableTypes.worm_tlr_constellation.secondary_colour}}}
	end,
	ppu_team = {"TheLastResort"},
	ppu_coder = {"Foo54"},
	ppu_artist = {"Aura2247"}
}