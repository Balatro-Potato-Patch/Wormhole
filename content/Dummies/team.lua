-- Team: Dummies
PotatoPatchUtils.Team({
    name = "dummies",
    colour = HEX("FFFF00"),
    credit_rows = { 3, 3 },
    short_credit = true,
    loc = true,
})
-- Members (In Join-Order)
SMODS.Atlas {
    key = "dummies_team",
    path = "Dummies/team.png",
    px = 71,
    py = 95
}

SMODS.Sound({ key = "dum_ghostclicked", path = "Dummies/worm_dum_ghostclicked.ogg" })

-- GhostSalt
PotatoPatchUtils.Developer {
    name = "ghostsalt",
    colour = HEX("FFDDDD"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 0, y = 0 },
    loc = true,
	dum_sfx_click = "worm_dum_ghostclicked",
	dum_sfx_pitch = { lower_bound = 0.95, upper_bound = 1.1 },
	dum_sfx_volume = 0.8
}
-- vissa
PotatoPatchUtils.Developer {
    name = "vissa",
    colour = HEX("B00B1E"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 1, y = 0 },
    loc = true,
	dum_sfx_click = {"worm_dum_sfx_worm_gulp",
					"worm_dum_sfx_greg_nom",
					"worm_dum_sfx_greg_goodbye",
					"worm_dum_sfx_carnivore_chomp",},
	dum_sfx_volume = 1,
	dum_sfx_pitch = { lower_bound = 1, upper_bound = 1.3 },
}

SMODS.Sound({ key = "dum_bagelsclicked", path = "Dummies/worm_dum_bagelsclicked.ogg" })
-- bakersdozenbagels
PotatoPatchUtils.Developer {
    name = "bagels",
    colour = HEX "EDD198",
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 2, y = 0 },
    loc = true,
	dum_sfx_click = "worm_dum_bagelsclicked",
	dum_sfx_pitch = { lower_bound = 0.95, upper_bound = 1.05 },
	dum_sfx_volume = 0.85
}

-- TheOneGoofAli
local sfx_toga_thing = {}
PotatoPatchUtils.Developer {
    name = "theonegoofali",
    colour = HEX("FD9712"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 3, y = 0 },
    loc = true,
	calculate = function(self, context)
		if context.end_of_round and context.main_eval then G.goodluckgentlemen = false end
		
		if G.hellocommander then return end
		
		local context = context
		
		if context.first_hand_drawn and (G.GAME.blind and G.GAME.blind.boss and G.GAME.blind.in_blind) and not G.goodluckgentlemen then
			G.goodluckgentlemen = true
			local tc = SMODS.find_card('j_worm_dum_timcurry', true)
			if tc and tc[1] then
				G.hellocommander = true
				return {
					message = '!',
					message_card = tc[1] or G.deck,
					sound = "worm_dum_timcurry_goodluckgentlemen",
					pitch = 1,
					volume = 0.85,
					extra = {
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									G.hellocommander = false
									return true
								end
							}))
						end
					}
				}
			end
		end
		
		if context.card and context.card.config and context.card.config.center and context.card.config.center.key and not (context.retrigger_joker or context.blueprint) then
			if context.card.config.center.key == 'j_space' and (context.modify_shop_card or context.modify_booster_card or context.card_added) then
				local tc = SMODS.find_card('j_worm_dum_timcurry', true)
				if tc and tc[1] then
					if context.card_added then check_for_unlock({ tim = tc, space = { context.card } }) end
					G.hellocommander = true
					return {
						message = localize('worm_tim_curry_space'),
						message_card = tc[1] or G.deck,
						sound = "worm_dum_timcurry_space",
						pitch = 1,
						volume = 0.85,
						extra = {
							func = function()
								G.E_MANAGER:add_event(Event({
									func = function()
										G.hellocommander = false
										return true
									end
								}))
							end
						}
					}
				end
			elseif context.card.config.center.key == 'j_worm_dum_timcurry' then
				if context.card_added or context.joker_type_destroyed or context.selling_card then
					G.hellocommander = true
					return {
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									play_sound(context.card_added and 'worm_dum_timcurry_commander' or 'worm_dum_timcurry_treachery', 1, 0.85)
									G.hellocommander = false
									return true
								end
							}))
						end
					}
				end
			end
		end
	end,
	dum_sfx_click = sfx_toga_thing,
	dum_sfx_volume = 0.35
}
for _, v in ipairs({ "chimes", "chord", "comedy", "dialog-error", "dialog-question", "dialog-warning", "ding", "Indigo", "Laugh", "Wild-Eep" }) do
	local k = string.lower(v)
	SMODS.Sound({ key = "dum_"..k, path = "Dummies/TOGAClick/worm_dum_"..v..".ogg" })
	table.insert(sfx_toga_thing, "worm_dum_"..k)
end

SMODS.Sound({ key = "dum_waw", path = "Dummies/worm_dum_waw.ogg" })

-- baltdev
PotatoPatchUtils.Developer {
    name = "baltdev",
    colour = HEX("707880"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 4, y = 0 },
    loc = true,
	dum_sfx_click = "worm_dum_waw",
	dum_sfx_pitch = { lower_bound = 0.95, upper_bound = 1.05 },
	dum_sfx_volume = 0.45
}

SMODS.Sound({ key = "dum_flowireclicked", path = "Dummies/worm_dum_flowireclicked.ogg" })

-- Flowire
PotatoPatchUtils.Developer {
    name = "flowire",
    colour = HEX("FF8FA9"),
    team = "dummies",
    atlas = "worm_dummies_team",
    pos = { x = 5, y = 0},
    loc = true,
	dum_sfx_click = "worm_dum_flowireclicked",
	dum_sfx_pitch = { lower_bound = 0.95, upper_bound = 1.1 },
	dum_sfx_volume = 1.5
}

-- Member SFX click funnies
local cardclickref, clickcount = Card.click, 0
function Card:click()
	if self and self.ppu_member then
		if self.ppu_member.dum_sfx_click then
			local pitch = 1
			if type(self.ppu_member.dum_sfx_pitch) == "table" then
				if self.ppu_member.dum_sfx_pitch.lower_bound and type(self.ppu_member.dum_sfx_pitch.lower_bound) == "number"
				and self.ppu_member.dum_sfx_pitch.upper_bound and type(self.ppu_member.dum_sfx_pitch.upper_bound) == "number" then
					math.randomseed(os.time() + math.floor(os.clock() * 1000000))
					pitch = self.ppu_member.dum_sfx_pitch.lower_bound + (math.random() * (self.ppu_member.dum_sfx_pitch.upper_bound - self.ppu_member.dum_sfx_pitch.lower_bound))
				end
			elseif type(self.ppu_member.dum_sfx_pitch) == "number" then
				pitch = self.ppu_member.dum_sfx_pitch
			end

			local volume = 1
			if type(self.ppu_member.dum_sfx_volume) == "table" then
				if self.ppu_member.dum_sfx_volume.lower_bound and type(self.ppu_member.dum_sfx_volume.lower_bound) == "number"
				and self.ppu_member.dum_sfx_volume.upper_bound and type(self.ppu_member.dum_sfx_volume.upper_bound) == "number" then
					math.randomseed(os.time() + math.floor(os.clock() * 1000000))
					volume = self.ppu_member.dum_sfx_volume.lower_bound + (math.random() * (self.ppu_member.dum_sfx_volume.upper_bound - self.ppu_member.dum_sfx_volume.lower_bound))
				end
			elseif type(self.ppu_member.dum_sfx_volume) == "number" then
				volume = self.ppu_member.dum_sfx_volume
			end

			if type(self.ppu_member.dum_sfx_click) == 'string' and SMODS.Sounds[self.ppu_member.dum_sfx_click] then
				play_sound(self.ppu_member.dum_sfx_click, pitch, volume)
			elseif type(self.ppu_member.dum_sfx_click) == 'table' and next(self.ppu_member.dum_sfx_click) then
				local dum_sfx = self.ppu_member.dum_sfx_click[math.random(1, #self.ppu_member.dum_sfx_click)]
				if SMODS.Sounds[dum_sfx] then play_sound(dum_sfx, pitch, volume) end
			elseif type(self.ppu_member.dum_sfx_click) == 'function' then
				self.ppu_member.dum_sfx_click(self, pitch, volume)
			end
		end
		clickcount = (clickcount or 0) + 1
		check_for_unlock({ type = 'dum_clickyclick', amt = clickcount })
	end
	return cardclickref(self)
end