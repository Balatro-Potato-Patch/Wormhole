--  ##  SPACE SUIT VOUCHER
--INFO: Uses 2 Hooks & 1 Lovely Patch
-- - "start_run(args)"
-- - "update(dt)"
-- - "defeated_by.toml"

SMODS.Atlas {
	key = "dummies_spacesuit",
	path = "Dummies/spacesuit.png",
	px = 71,
	py = 95
}

local HOOK_start_run = Game.start_run
function Game:start_run(args)
    local ret = HOOK_start_run(self, args)
    DUMMY_Oxygen_UI(self)
    return ret
end

local HOOK_update = Game.update
function Game:update(dt)
    local ret = HOOK_update(self, dt)
    DUMMY_Oxygen_Update(dt)
    return ret
end

function DUMMY_FormatMinute(time)
	local secondTime = time % 60
	local minuteTime = (time - secondTime) / 60
	return string.format("%02d:%02d", minuteTime, secondTime)
end

function DUMMY_Oxygen_Strings()
	G.GAME.dummy_oxygen_string_time = DUMMY_FormatMinute(G.GAME.dummy_oxygen_time)
	if G.GAME.dummy_oxygen_adding then
		-- Shows Progress
		local charging = ' '
		for i = 1, math.min(10, G.GAME.dummy_oxygen_adding_steps) do
			charging = charging..'+'
		end
		G.GAME.dummy_oxygen_string_mult = charging
	elseif G.GAME.dummy_oxygen_low then
		-- Challenge Specific:
		if G.GAME.dummy_oxygen_time % 2 == 0 then
			G.GAME.dummy_oxygen_string_mult = ' '
		else
			G.GAME.dummy_oxygen_string_mult = localize('k_worm_dum_low_oxygen')
		end
	else
		-- Shows Multiplier
		local calcTime = math.floor(G.GAME.dummy_oxygen_time / 2 + 0.5)
		local secondTime = calcTime % 60
		local minuteTime = (calcTime - secondTime) / 60
		G.GAME.dummy_oxygen_string_mult = minuteTime >= 1 and string.format("X%01d.%02d", minuteTime, math.floor(secondTime)) or 'X1.00'
	end
end

function DUMMY_Oxygen_Update(dt)
	-- Simple check if unpaused:
	if G.GAME.dummy_oxygen_active and not G.SETTINGS.paused then
		if G.GAME.dummy_oxygen_adding then
			G.GAME.dummy_oxygen_realtime = G.GAME.dummy_oxygen_realtime + G.real_dt --dt
			if G.GAME.dummy_oxygen_realtime >= 0.1 then
				G.GAME.dummy_oxygen_realtime = G.GAME.dummy_oxygen_realtime - 0.1
				-- Add Time:
				G.GAME.dummy_oxygen_time = G.GAME.dummy_oxygen_time + G.GAME.dummy_oxygen_adding_time
            	play_sound('other1', 1.5, 0.5) -- rumble
				G.deck:juice_up(0.03)
				-- Check Limit:
				if G.GAME.dummy_oxygen_time > G.GAME.dummy_oxygen_maxtime then
					G.GAME.dummy_oxygen_time = G.GAME.dummy_oxygen_maxtime
					G.GAME.dummy_oxygen_adding_steps = 0
				else
					G.GAME.dummy_oxygen_adding_steps = G.GAME.dummy_oxygen_adding_steps - 1
				end
				-- Stop Adding:
				if G.GAME.dummy_oxygen_adding_steps <= 0 then
					G.GAME.dummy_oxygen_adding_time = 0
					G.GAME.dummy_oxygen_adding_steps = 0
					G.GAME.dummy_oxygen_adding = false
					G.GAME.dummy_oxygen_realtime = -0.5 --Small delay
				end
				DUMMY_Oxygen_Strings()
			end
		elseif (G.GAME.STOP_USE or 0) == 0 then
			G.GAME.dummy_oxygen_realtime = G.GAME.dummy_oxygen_realtime + G.real_dt --dt
			if G.GAME.dummy_oxygen_realtime >= 1.0 then
				G.GAME.dummy_oxygen_realtime = G.GAME.dummy_oxygen_realtime - 1.0
				-- Decrease Time:
				G.GAME.dummy_oxygen_time = G.GAME.dummy_oxygen_time - 1.0
				-- Ticking for last 30 seconds:
				if G.GAME.dummy_oxygen_time <= 30 then
					local volume = math.floor(math.min(3.0, 15 / math.max(1.0, G.GAME.dummy_oxygen_time)) * 100) / 100
					if G.GAME.dummy_oxygen_time % 2 == 0 then
            			play_sound('paper1', 1.5, volume) -- tick
					else
            			play_sound('paper1', 1.0, volume) -- tack
					end
					G.deck:juice_up(0.02)
				end
				-- Display Time (or Die trying):
				if G.GAME.dummy_oxygen_time < 0 then
					G.GAME.dummy_oxygen_string_time = '--:--'
					G.GAME.dummy_oxygen_string_mult = ''
					G.GAME.dummy_oxygen_active = false
					G.GAME.dummy_defeated_by = true
					-- GAME OVER
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.25,
						blocking = false,
						func = function()
							-- Getting saved *literally* last second:
							if G.GAME.dummy_oxygen_adding then
								G.GAME.dummy_oxygen_active = true
								G.GAME.dummy_defeated_by = false
								return true
							end
							-- Clear String (in case the run somehow continues)
	    					G.E_MANAGER:add_event(Event({
	    						trigger = 'after', delay = 1.0, blocking = false,
	    						func = function() G.GAME.dummy_oxygen_string_time = ''; return true; end
	    					}))
							-- GAME OVER (Shows "Defeated by ERROR" in Shop & Blind-Select)
							--> Would need a patch in: "UI_definitions.lua" -> "if score == 'defeated_by' then" -> ...
							G.STATE = G.STATES.GAME_OVER
							if not G.GAME.seeded and not G.GAME.challenge then 
    							G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
							end
							G:save_settings()
							G.FILE_HANDLER.force = true
							G.STATE_COMPLETE = false
							return true
						end
					}))
				else -- Display Time:
					DUMMY_Oxygen_Strings()
				end
			end
		end
	end
end

function DUMMY_Oxygen_Time_Add(time, steps)
	if time and time >= 1 then
		local adding_steps = (steps or 10)
		if G.GAME.dummy_oxygen_active then
			time = time + (G.GAME.dummy_oxygen_adding_time * G.GAME.dummy_oxygen_adding_steps)
		end
		time = math.floor(time)
		G.GAME.dummy_oxygen_adding_time = time / adding_steps
		G.GAME.dummy_oxygen_adding_steps = adding_steps
		G.GAME.dummy_oxygen_realtime = 0
		-- Activate Adding:
		G.GAME.dummy_oxygen_adding = true
	end
end

function DUMMY_Oxygen_Time_Increase(time, steps)
	if time and time >= 1 then
		time = math.floor(time)
		if G.GAME.dummy_oxygen_active then
			G.GAME.dummy_oxygen_maxtime = G.GAME.dummy_oxygen_maxtime + time
			DUMMY_Oxygen_Time_Add(time, (steps or 10))
		else -- Setup Variables:
			G.GAME.dummy_oxygen_time = 0
			G.GAME.dummy_oxygen_realtime = 0
			G.GAME.dummy_oxygen_maxtime = time
			DUMMY_Oxygen_Time_Add(time, (steps or 10))
			-- Activate Mechanic:
			G.GAME.dummy_oxygen_active = true
			DUMMY_Oxygen_Strings()
		end
	end
end

function DUMMY_Oxygen_UIBox()
	local dyna_time = DynaText {
		string = {{ ref_table = G.GAME, ref_value = "dummy_oxygen_string_time" }},
		colours = { G.C.UI.TEXT_LIGHT }, shadow = true, scale = 1.0,
	}
	local dyna_mult = DynaText {
		string = {{ ref_table = G.GAME, ref_value = "dummy_oxygen_string_mult" }},
		colours = { HEX("eeeeee99") }, shadow = true, scale = 0.42,
	}
	return {
		n = G.UIT.ROOT, config = { align = "cm", colour = G.C.CLEAR }, nodes = {{
            n = G.UIT.C, config={ align = "cm" }, nodes = {
				{n=G.UIT.R, config={ align = "rc", padding = 0.01 }, nodes={
					{n=G.UIT.O, config = { object = dyna_mult, id = "mult_container" }},
				}},
				{n=G.UIT.R, config={ align = "rc" }, nodes={
					{n=G.UIT.O, config = { object = dyna_time, id = "time_container" }},
				}},
            },
	    }}
	}
end

function DUMMY_Oxygen_UI(game_obj)
	if G.GAME.dummy_oxygen_active then
		DUMMY_Oxygen_Strings()
	else
		G.GAME.dummy_oxygen_string_time = ''
		G.GAME.dummy_oxygen_string_mult = ''
	end
	if game_obj.worm_dummy_oxygen_ui then
	    game_obj.worm_dummy_oxygen_ui:remove()
		game_obj.worm_dummy_oxygen_ui = nil
	end
	game_obj.worm_dummy_oxygen_ui = UIBox {
	    definition = DUMMY_Oxygen_UIBox(),
	    config = { align = "mb", offset = { x = 0.0, y = -4.18 }, major = G.deck, bond = 'Weak' }
	}
end

local function DUMMY_Voucher_Queue(info_queue, card)
	info_queue[#info_queue+1] = { key = 'worm_dum_spacesuit_warning', set = 'Other' }
	if G.GAME.dummy_oxygen_active and card.area == (G.shop_vouchers or {}) then
		info_queue[#info_queue+1] = { key = 'worm_dum_spacesuit_upgrade', set = 'Other', vars = {
			DUMMY_FormatMinute(G.GAME.dummy_oxygen_maxtime),
			DUMMY_FormatMinute(G.GAME.dummy_oxygen_maxtime + card.ability.extra.oxygen_increase),
			DUMMY_FormatMinute(G.GAME.dummy_oxygen_replenish),
			DUMMY_FormatMinute(G.GAME.dummy_oxygen_replenish + card.ability.extra.oxygen_replenish),
		} }
	end
end

local function DUMMY_Voucher_Redeem(card)
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		func = function()
			DUMMY_Oxygen_Time_Increase(card.ability.extra.oxygen_increase)
			G.GAME.dummy_oxygen_replenish = (G.GAME.dummy_oxygen_replenish or 0) + card.ability.extra.oxygen_replenish
			return true
		end
	}))
end

SMODS.Voucher {
	key = "dum_spacesuit",
	atlas = "worm_dummies_spacesuit",
    pos = { x = 0, y = 0 },
    ppu_team = { "dummies" },
    ppu_artist = { "vissa", "flowire" },
    ppu_coder = { "flowire" },
	config = { extra = {
		oxygen_increase = 240, --> Slightly Higher = *Much* Stronger
		oxygen_replenish = 40,
	} },
    loc_vars = function(self, info_queue, card)
		DUMMY_Voucher_Queue(info_queue, card)
        return { vars = {
			DUMMY_FormatMinute(card.ability.extra.oxygen_increase),
			card.ability.extra.oxygen_replenish,
		} }
    end,
    redeem = function(self, card)
		DUMMY_Voucher_Redeem(card)
    end,
    calculate = function(self, card, context)
		if G.GAME.dummy_oxygen_active and context.final_scoring_step then
			local calcTime = math.floor(G.GAME.dummy_oxygen_time / 2 + 0.5)
			local secondTime = calcTime % 60
			local minuteTime = (calcTime - secondTime) / 60
			if minuteTime >= 1.0 then
				-- Custom Message...
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					--delay = 0.2,
					func = function()
						G.deck:juice_up(0.1)
						play_sound('xblindsize', 1.2, 0.8)
						attention_text({
							text = localize{ type = 'variable', key = 'worm_dum_xgeneric',
								vars = { string.format("%01d.%02d", minuteTime, secondTime) }
							}, backdrop_colour = G.C.PURPLE, scale = 1.2, hold = 1.2,
							major = G.deck, align = 'mb', offset = { x = 0, y = -4.13 }
						})
						return true
					end
				}))
				-- ...normal Message(s) are too high.
				local multiplier = minuteTime + math.floor(secondTime) / 100
				return {
					xmult = multiplier,
					xchips = multiplier,
					remove_default_message = true
				}
			end
		end
    end,
	calc_dollar_bonus = function(self, card)
		if G.GAME.dummy_oxygen_active and not G.GAME.dummy_oxygen_adding then --> Duplicate-Safe
			DUMMY_Oxygen_Time_Add(G.GAME.dummy_oxygen_replenish)
		end
	end,
}

SMODS.Voucher {
	key = "dum_oxygentank",
    requires = { 'v_worm_dum_spacesuit' },
	atlas = "worm_dummies_spacesuit",
    pos = { x = 1, y = 0 },
    ppu_team = { "dummies" },
    ppu_artist = { "flowire", "vissa" },
    ppu_coder = { "flowire" },
	config = { extra = {
		oxygen_increase = 90, --> Slightly Higher = *Much* Stronger
		oxygen_replenish = -10,
	} },
    loc_vars = function(self, info_queue, card)
		DUMMY_Voucher_Queue(info_queue, card)
        return { vars = {
			DUMMY_FormatMinute(card.ability.extra.oxygen_increase),
			-card.ability.extra.oxygen_replenish,
		} }
    end,
    redeem = function(self, card)
		DUMMY_Voucher_Redeem(card)
    end,
}
