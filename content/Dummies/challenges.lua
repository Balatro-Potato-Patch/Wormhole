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
            { id = 'v_worm_dum_oxygentank' },
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
	button_colour = G.C.SECONDARY_SET.Spectral
}

SMODS.Challenge {
    key = 'dum_buff_spacesuit', -- Buff Space Suit
    rules = {
        custom = {
            { id = 'worm_dum_buff_spacesuit_1' },
            { id = 'worm_dum_space' },
            { id = 'worm_dum_buff_spacesuit_2' },
            { id = 'worm_dum_buff_spacesuit_3' },
            { id = 'worm_dum_space' },
            { id = 'worm_dum_gold_stake' },
        }
    },
    vouchers = {
        { id = 'v_worm_dum_spacesuit' },
        --{ id = 'v_worm_dum_oxygentank' },
    },
	apply = function(self)
        -- Gold Stake
		SMODS.setup_stake(SMODS.Stakes["stake_gold"].order)
		G.GAME.stake = SMODS.Stakes["stake_gold"].order
        -- Apply Oxygen Buffs (Imitates Setup):
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				-- Replenish:
				G.GAME.dummy_oxygen_replenish = (G.GAME.dummy_oxygen_replenish or 0) + 20
				-- Max Time:
				G.GAME.dummy_oxygen_maxtime = 60
				G.GAME.dummy_oxygen_time = 0
				-- Adding Time:
				G.GAME.dummy_oxygen_adding_time = 6
				G.GAME.dummy_oxygen_adding_steps = 10
				-- Delay Start:
				G.GAME.dummy_oxygen_realtime = -5
				-- Activate Oxygen:
				G.GAME.dummy_oxygen_adding = true
				G.GAME.dummy_oxygen_active = true
				DUMMY_Oxygen_Strings()
				--> Then applies the Voucher-Stats ontop
				return true
			end
		}))
	end,
	button_colour = G.C.SECONDARY_SET.Spectral
}
