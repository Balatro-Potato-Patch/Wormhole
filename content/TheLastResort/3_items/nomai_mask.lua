SMODS.Joker{
	key = "tlr_nomaimask",
  pos = { x = 0, y = 13 },
	rarity = 3,
	cost = 8,
	loc_vars = function (self, info_queue, card)
		return {vars = {colours = {SMODS.ConsumableTypes.worm_tlr_constellation.secondary_colour}}}
	end,
	ppu_team = {"TheLastResort"},
	ppu_coder = {"Foo54"}
}