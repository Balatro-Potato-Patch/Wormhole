--  ##  SPACE SUIT VOUCHER
--INFO: Uses 2 Hooks
-- - 'start_run(args)'
-- - 'update(dt)'

local OXYGEN_INCREASE = 300
local OXYGEN_REPLENISH = 40
local VOUCHER_REPLENISH = 5

function DUMMY_FormatMinute(time)
	local secondTime = time % 60
	local minuteTime = (time - secondTime) / 60
	return string.format("%02d:%02d", minuteTime, secondTime)
end

function DUMMY_Oxygen_Strings()
	G.GAME.dummy_oxygen_string_time = DUMMY_FormatMinute(G.GAME.dummy_oxygen_time)
	if G.GAME.dummy_oxygen_adding then
		local charging = ' '
		for i = 1, math.min(10, G.GAME.dummy_oxygen_adding_steps) do
			charging = charging..'+'
		end
		G.GAME.dummy_oxygen_string_mult = charging
	else
		local calcTime = math.floor(G.GAME.dummy_oxygen_time / 2 + 0.5)
		local secondTime = calcTime % 60
		local minuteTime = (calcTime - secondTime) / 60
		G.GAME.dummy_oxygen_string_mult = minuteTime >= 1 and string.format("X%01d.%02d", minuteTime, math.floor(secondTime)) or 'X1.00'
	end
end

function DUMMY_Oxygen_Update(dt)
	-- Simple check if unpaused:
	if G.GAME.dummy_oxygen_active and not G.GAME.dummy_oxygen_paused and not G.SETTINGS.paused then
		G.GAME.dummy_oxygen_realtime = G.GAME.dummy_oxygen_realtime + G.real_dt
		if G.GAME.dummy_oxygen_adding then
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
		else -- decreasing:
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
					-- GAME OVER
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.25,
						blocking = false,
						func = function()
							-- Getting saved *literally* last second:
							if G.GAME.dummy_oxygen_adding then
								G.GAME.dummy_oxygen_active = true
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

function DUMMY_Oxygen_Time_Increase(time)
	if time and time >= 1 then
		time = math.floor(time)
		if G.GAME.dummy_oxygen_active then
			G.GAME.dummy_oxygen_maxtime = G.GAME.dummy_oxygen_maxtime + time
			DUMMY_Oxygen_Time_Add(time, 10)
		else -- Setup Variables:
			G.GAME.dummy_oxygen_time = 0
			G.GAME.dummy_oxygen_realtime = 0
			G.GAME.dummy_oxygen_maxtime = time
			DUMMY_Oxygen_Time_Add(time, 10)
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

SMODS.Voucher {
	key = "dum_spacesuit",
	atlas = "worm_DummiesJokers_Flowire", --!! WRONG ATLAS; CURRENTLY NO TEXTURE
    pos = { x = 0, y = 0 },
    ppu_team = { "dummies" },
    ppu_artist = { "flowire" }, -- vissa
    ppu_coder = { "flowire" },
	--config = { extra = { oxygen_increase = 300, oxygen_replenish = 5, } },
    loc_vars = function(self, info_queue, card)
		local replenish = OXYGEN_REPLENISH + VOUCHER_REPLENISH 
		info_queue[#info_queue+1] = { key = 'worm_dum_spacesuit_warning', set = 'Other' }
		if G.GAME.dummy_oxygen_active and card.area == (G.shop_vouchers or {}) then
			replenish = '+'..VOUCHER_REPLENISH
			info_queue[#info_queue+1] = { key = 'worm_dum_spacesuit_upgrade', set = 'Other', vars = {
				DUMMY_FormatMinute(G.GAME.dummy_oxygen_maxtime),
				DUMMY_FormatMinute(G.GAME.dummy_oxygen_maxtime + OXYGEN_INCREASE),
				DUMMY_FormatMinute(OXYGEN_REPLENISH + VOUCHER_REPLENISH * G.GAME.dummy_oxygen_vouchers),
				DUMMY_FormatMinute(OXYGEN_REPLENISH + VOUCHER_REPLENISH * (G.GAME.dummy_oxygen_vouchers + 1)),
			} }
		end
        return { vars = {
			math.floor(OXYGEN_INCREASE / 60),
			replenish,
		} }
    end,
    redeem = function(self, card)
	    G.E_MANAGER:add_event(Event({
	    	trigger = 'after',
	    	func = function()
				DUMMY_Oxygen_Time_Increase(OXYGEN_INCREASE)
				G.GAME.dummy_oxygen_vouchers = (G.GAME.dummy_oxygen_vouchers or 0) + 1
	    		return true
	    	end
	    }))
    end,
    calculate = function(self, card, context)
		if G.GAME.dummy_oxygen_active then
			-- Stop the Timer when playing a Hand
			if context.press_play then
				G.GAME.dummy_oxygen_paused = true --> Pause Timer
				G.GAME.dummy_oxygen_scoring = true --> Limit Bonus
			end
			if context.final_scoring_step and G.GAME.dummy_oxygen_scoring then
				G.GAME.dummy_oxygen_scoring = false --> Bonus Limited
				-- Actual Bonus:
				local calcTime = math.floor(G.GAME.dummy_oxygen_time / 2 + 0.5)
				local secondTime = calcTime % 60
				local minuteTime = (calcTime - secondTime) / 60
				if minuteTime >= 1.0 then
					-- Custom Message...
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
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
			if context.after then
	    		G.E_MANAGER:add_event(Event({
	    			trigger = 'after',
	    			func = function()
						G.GAME.dummy_oxygen_paused = false --> Continue Timer
	    				return true
	    			end
	    		}))
			end
		end
    end,
	calc_dollar_bonus = function(self, card)
		if G.GAME.dummy_oxygen_active and not G.GAME.dummy_oxygen_adding then
			DUMMY_Oxygen_Time_Add(OXYGEN_REPLENISH + VOUCHER_REPLENISH * G.GAME.dummy_oxygen_vouchers)
		end
	end,
    in_pool = function(self, args)
		return ((G.GAME.dummy_oxygen_vouchers or 0) < 4), { allow_duplicates = true }
		--NOTE: "allow_duplicates" doesn't work for Vouchers ("1531zeebee" and below)
	end,
}
