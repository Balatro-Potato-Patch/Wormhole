SMODS.Atlas({
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    key = "dum_dummy_blind",
    path = "Dummies/dummy_blind.png",
    px = 34,
    py = 34
})

--- Credits to Eremel <3

-- In your code
loc_colour()
G.ARGS.LOC_COLOURS.worm_dum_brown = HEX('DB9D51')


local function SEMBY_Blind_Wiggle()
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		func = function()
			play_sound('tarot2', 1, 0.4)
			G.GAME.blind.children.animatedSprite:juice_up(0.3)
			return true
		end
	}))
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.06*G.SETTINGS.GAMESPEED,
		func = function()
			play_sound('tarot2', 0.76, 0.4)
			return true
		end
	}))
end


SMODS.Blind {
    key = "dum_dummy_blind",
    atlas = "dum_dummy_blind",
    dollars = 0,
    mult = 2,
    pos = { x = 0, y = 0 },
    boss = { min = 2 },
    boss_colour = HEX("EFC03C"),

    ppu_coder = { "vissa" },
    ppu_team = { "dummies" },

    unkillable = true,

    calc_dollar_bonus = function (self, blind)
        local coefficient = G.GAME.chips / blind.chips

        print("Coefficient: "..coefficient)

        SEMBY_Blind_Wiggle()

        -- Put some actually cool effect here
        -- like spawning consumeables, jokers, giving tags, whatever.

        if coefficient < 0.4 then
            print("Really bad")
            if not blind.disabled then
                -- do curse
            end
            return 0
        elseif coefficient < 0.8 then
            print("Bad")
            if not blind.disabled then
                -- do curse
            end
            return 0
        elseif coefficient < 1 then
            print("A bit bad")
            return 0
        elseif coefficient < 1.2 then
            print("Good")
            return 3
        elseif coefficient < 1.6 then
            print("Better")
        elseif coefficient < 2 then
            print("Really Very Good")
            return 6
        else
            print("Insanely good")
            return 9
        end

        return 0
    end,
    calculate = function(self, blind, context)     
    
        if context.end_of_round and context.game_over and context.main_eval then
            return {
                saved = 'k_worm_dum_dummy_blind_saved',
            }
        end
    end,
}