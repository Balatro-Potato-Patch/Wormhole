PotatoPatchUtils.Team{
	name = "TheLastResort",
	colour = HEX("FFFFFF"),
	loc = "PotatoPatchTeam_TLR"
}

PotatoPatchUtils.Developer({
	name = "Foo54",
	loc = true,
	team = "TheLastResort",
	pos = {x=0,y=0},
	atlas = "worm_tlr_foo54"
})

PotatoPatchUtils.Developer({
	name = "Jolga",
	loc = true,
	team = "TheLastResort"
})

PotatoPatchUtils.Developer({
	name = "Breuh",
	loc = true,
	team = "TheLastResort"
})

PotatoPatchUtils.Developer({
	name = "Amphiapple",
	loc = true,
	team = "TheLastResort"
})

PotatoPatchUtils.Developer({
	name = "Aura2247",
	loc = true,
	team = "TheLastResort"
})

PotatoPatchUtils.Developer({
	name = "Quinn",
	loc = true,
	team = "TheLastResort"
})

WORM_TLR = WORM_TLR or {}

function WORM_TLR.const_info_queue(info_queue, tier)
	if tier < 3 then
		info_queue[#info_queue+1] = {set = "Other", key = "worm_tlr_const_info"}
	elseif tier < 4 then
		info_queue[#info_queue+1] = {set = "Other", key = "worm_tlr_const_max_level"}
	else
		info_queue[#info_queue+1] = {set = "Other", key = "worm_tlr_const_max_real"}
	end
end

function WORM_TLR.update_const_sprite(card_self, card_card)
	G.E_MANAGER:add_event(Event({
		func = function()
			card_self:set_sprites(card_card, card_card.config.center)
			return true
		end
	}))
end