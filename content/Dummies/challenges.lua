SMODS.Challenge {
    key = 'dum_all_star_champion',
    rules = {
        custom = {
            { id = 'worm_dum_all_star_champion_1' },
            { id = 'worm_dum_space' },
            { id = 'worm_dum_all_star_champion_2' },
            { id = 'worm_dum_gold_stake' },
        },
        modifiers = {
            { id = 'consumable_slots', value = 5 },
        }
    },
    jokers = {
        { id = 'j_oops', eternal = true, edition = "worm_dum_Celestial" },
    },
    vouchers = {
        { id = 'v_planet_merchant' },
    },
    consumeables = {
        { id = 'c_planet_x' },
    },
	apply = function(self)
        -- Gold Stake
		SMODS.setup_stake(SMODS.Stakes["stake_gold"].order)
		G.GAME.stake = SMODS.Stakes["stake_gold"].order
		-- Winning Ante
		G.GAME.win_ante = (G.GAME.win_ante or 8) + 4
	end,
    calculate = function(self, context)
        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
			if context.consumeable.ability.trinary and context.consumeable.ability.trinary <= 0 then
				return
			end
			if G.GAME.consumeable_buffer + #G.consumeables.cards < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
			    		local trinary_planet = SMODS.add_card{ set = 'Planet', soulable = true, key_append = 'dum_trinary_planet' }
			    		trinary_planet.ability.trinary = (context.consumeable.ability.trinary or 2) - 1
			    		play_sound('tarot'..math.random(1, 2), math.random() + 0.8, 0.5)
			    		G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true
                    end
                }))
            end
        end
    end,
	button_colour = G.C.SECONDARY_SET.Planet
}

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
				DUMMY_Oxygen_Time_Increase(1200, 30)
				return true
			end
		}))
	end,
	button_colour = G.C.SECONDARY_SET.Spectral
}

SMODS.Challenge {
    key = 'dum_buff_spacesuit',
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
