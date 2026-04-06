SMODS.Challenge {
    key = 'dum_low_oxygen',
    rules = {
        custom = {
            { id = 'worm_dum_low_oxygen_1' },
            { id = 'worm_dum_low_oxygen_2' },
            { id = 'worm_dum_space' },
            { id = 'worm_dum_gold_stake' },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'v_worm_dum_spacesuit' },
        },
    },
	apply = function(self)
        -- Gold Stake
		SMODS.setup_stake(SMODS.Stakes["stake_gold"].order)
		G.GAME.stake = SMODS.Stakes["stake_gold"].order
        -- Activate "Low Oxygen"
		G.GAME.dummy_oxygen_low = true
        -- Apply Oxygen:
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				DUMMY_Oxygen_Time_Increase(1800, 30)
				return true
			end
		}))
	end,
    calculate = function(self, context)
		if G.GAME.dummy_oxygen_active then
		    if context.press_play then
		    	G.GAME.dummy_oxygen_paused = true --> Pause Timer
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
	button_colour = G.C.RED
}
