PotatoPatchUtils.Team{
	name = "TheLastResort",
	colour = HEX("ffcc33"),
	loc = "PotatoPatchTeam_TLR"
}

PotatoPatchUtils.Developer({
	name = "Foo54",
	loc = true,
	team = "TheLastResort",
	pos = {x=0,y=0},
	atlas = "worm_tlr_foo54",
	soul_pos = {x=1, y=0}
})

PotatoPatchUtils.Developer({
	name = "Jolga",
	loc = true,
	team = "TheLastResort",
})

PotatoPatchUtils.Developer({
	name = "Breuhh",
	loc = true,
	team = "TheLastResort",
	pos = {x=0,y=0},
	atlas = "worm_tlr_breh"
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
			card_self:set_sprites(card_card)
			return true
		end
	}))
end

function WORM_TLR.ease_background_colour_pack (self)
	ease_colour(G.C.DYN_UI.MAIN, SMODS.ConsumableTypes.worm_tlr_constellation.primary_colour)
	ease_background_colour{new_colour = SMODS.ConsumableTypes.worm_tlr_constellation.secondary_colour, contrast = 3}
end
function WORM_TLR.particles (self)
	G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
		timer = 0.015,
		scale = 0.1,
		initialize = true,
		lifespan = 3,
		speed = 0.2,
		padding = -1,
		attach = G.ROOM_ATTACH,
		colours = { G.C.WHITE, SMODS.ConsumableTypes.worm_tlr_constellation.primary_colour },
		fill = true
	})
	G.booster_pack_sparkles.fade_alpha = 1
	G.booster_pack_sparkles:fade(1, 0)
end