-- Team Dummies JokerQuips

-- [Generic] WIN Quips:
local EXPECTED_WINS = 11; for i=1, EXPECTED_WINS do SMODS.JimboQuip({key='dummies_win_'..tostring(i), type='win'}) end
-- [Generic] LOSS Quips:
local EXPECTED_LOSS = 11; for i=1, EXPECTED_LOSS do SMODS.JimboQuip({key='dummies_loss_'..tostring(i), type='loss'}) end

-- [Custom] Quips:

-- Flowire Trolling Potato Devs:
for i = 1, 3 do
	SMODS.JimboQuip({ key = 'dummies_flowire_'..tostring(i), type = math.random() > 0.5 and 'win' or 'loss' })
end

-- Tim Curry:
for i, winquip in ipairs({ "anothervictory", "excellentjob", "excellentwork", "niceworkcomrade" }) do
	SMODS.JimboQuip({
		key = 'dum_timcurry_win'..i,
		extra = {
			center = 'j_worm_dum_timcurry',
			text_key = 'worm_dummies_timcurry_win_'..i,
			times = 1,
			pitch = 1,
			sound = "worm_dum_timcurry_"..winquip,
			juice = {0, 0},
		},
		filter = function(self, type)
			if next(SMODS.find_card('j_worm_dum_timcurry')) and type == 'win' then return true end
		end
	})
end

local to_number = to_number or function(a) return a end
SMODS.JimboQuip({
	key = 'dum_timcurry_lose_normal',
	extra = {
		center = 'j_worm_dum_timcurry',
		text_key = 'worm_dummies_timcurry_lose_normal',
		times = 1,
		pitch = 1,
		sound = "worm_dum_timcurry_suchashame",
		juice = {0, 0},
	},
	filter = function(self, type)
		if next(SMODS.find_card('j_worm_dum_timcurry')) and type == 'loss' then
			if to_number(G.GAME.round) < to_number(8) or not (G.GAME.blind and G.GAME.blind.boss and G.GAME.blind.boss.showdown) then return true end
		end
	end
})

SMODS.JimboQuip({
	key = 'dum_timcurry_lose_full',
	extra = {
		center = 'j_worm_dum_timcurry',
		text_key = 'worm_dummies_timcurry_lose_full',
		times = 1,
		pitch = 1,
		sound = "worm_dum_timcurry_suchashamefull",
		juice = {0, 0},
	},
	filter = function(self, type)
		if next(SMODS.find_card('j_worm_dum_timcurry')) and type == 'loss' then
			if to_number(G.GAME.round) >= to_number(8) or (G.GAME.blind and G.GAME.blind.boss and G.GAME.blind.boss.showdown) then return true end
		end
	end
})

SMODS.Sound({ key = "dum_bummer", path = "Dummies/worm_dum_bummer.ogg" })
SMODS.Sound({ key = "dum_tada95special", path = "Dummies/worm_dum_tada95special.ogg" })

SMODS.JimboQuip({
	key = 'dum_toga_loss',
	extra = {
		ppu_dev = 'worm_theonegoofali',
		times = 1,
		pitch = 1,
		sound = "worm_dum_bummer",
		juice = {0.5, 0.5},
	},
	type = 'loss'
})

SMODS.JimboQuip({
	key = 'dum_toga_win',
	extra = {
		ppu_dev = 'worm_theonegoofali',
		times = 1,
		pitch = 1,
		sound = "worm_dum_tada95special",
		juice = {0.5, 0.5},
	},
	type = 'win'
})

-- Itsy hook to prevent speech bubble.
local cardcharaddspeechbubbleref = Card_Character.add_speech_bubble
function Card_Character:add_speech_bubble(text_key, align, loc_vars, quip_args)
	if quip_args and quip_args.ppu_dev and quip_args.ppu_dev == 'worm_theonegoofali' then return end
	cardcharaddspeechbubbleref(self, text_key, align, loc_vars, quip_args)
end