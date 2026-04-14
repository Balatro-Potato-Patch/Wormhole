SMODS.Atlas({
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    key = "dum_dummy_blind_atlas",
    path = "Dummies/dummy_blind.png",
    px = 34,
    py = 34
})

loc_colour()
G.ARGS.LOC_COLOURS.worm_dum_brown = HEX('DB9D51')

local function DummyAnnounce(message, Yoffset, scale)
    -- Announce Custom Message
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		func = function()
			attention_text({
				text = localize{ type = 'variable', key = 'worm_dum_percent', vars = { (message or 'ERROR') } },
				backdrop_colour = HEX('DB9D51'), colour = G.C.WHITE, scale = 1.2 * (scale or 1.0), hold = 2.0,
                major = G.play, align = 'cm', offset = { x = 0, y = (Yoffset or 0) }
			})
			return true
		end
	}))
    -- Wiggle Blind-Sprite (Corrected Timing)
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		func = function()
            -- START: Wiggle Blind-Sprite
			play_sound('tarot2', 1, 0.4)
			G.GAME.blind.children.animatedSprite:juice_up(0.3)
            -- Update Reward-Text
            local reward_len = string.len((G.GAME.current_round.dollars_to_be_earned or ''))
            if reward_len < 7 then
                G.GAME.current_round.dollars_to_be_earned = (G.GAME.current_round.dollars_to_be_earned or '')..'$'
            elseif reward_len == 7 then
                G.GAME.current_round.dollars_to_be_earned = (G.GAME.current_round.dollars_to_be_earned or '')..'+'
            end
			return true
		end
	}))
    -- Wiggle Blind-Sprite (Corrected Timing)
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.06*G.SETTINGS.GAMESPEED,
		func = function()
            -- END: Wiggle Blind-Sprite
			play_sound('tarot2', 0.76, 0.4)
			return true
		end
	}))
    delay(0.2)
end

local function DummyCalculateLevel(coefficient, animate)
    coefficient = math.min(100, (coefficient or 0)) --> Level 398 ×0.25+0.5 = 100  -->  10.000%
    if coefficient and coefficient >= 0.5 then
        local ret_level = coefficient >= 1.0 and math.floor(coefficient / 0.25 - 2) or 1
        if animate and ret_level > (G.GAME.dum_dummy_level or -1) then
            local next_step, completed; local offset = 1.0
            -- Main Animation
            for i = 1, 25 do
                next_step = ((G.GAME.dum_dummy_level or -1) + i) * 0.25 + 0.5
                if coefficient >= next_step then
                    offset = (offset + 1.0) % 5
                    DummyAnnounce(next_step*100, -offset, 1.0)
                else
                    completed = true
                    break;
                end
            end
            -- Overflow Bonus; Bigger Text and Sound
            if not completed then
                next_step = coefficient - (coefficient % 0.25)
                offset = (offset + 1.0) % 5
	            G.E_MANAGER:add_event(Event({
	            	trigger = 'after',
	            	func = function()
	            		play_sound('xchips', 0.9, 0.8)
	            		return true
	            	end
	            }))
                DummyAnnounce(next_step*100, -offset, 2.0)
            end
        end
        G.GAME.dum_dummy_level = ret_level
        return ret_level
    end
    return -1 --> Blind wasn't beaten, not even 50%
end

local function DummyAddRewardTag(tag_id)
    local reward_tag = Tag(tag_id)
    --reward_tag.ability.dummy_no_double = true --> Makes sure that Double-Tag won't trigger
    --Flowire: I removed this because it actually breaks the Jam-Rules, oopsie :)
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.2,
		func = function()
            add_tag(reward_tag)
            play_sound('highlight1', 1.2 + math.random() * 0.1, 0.6)
			return true
		end
	}))
end

SMODS.Blind {
    key = "dum_dummy_blind",
    atlas = "dum_dummy_blind_atlas",
    ppu_coder = { "vissa", "flowire" },
    ppu_team = { "dummies" },
    dollars = 0,
    mult = 4,
    pos = { x = 0, y = 0 },
    boss = { min = 2 },
    boss_colour = HEX("EFC03C"),
    dummy_unkillable = true, --> lovely patched!
    calc_dollar_bonus = function (self, blind)
        -- Level Math: X ×0.25+0.5
        local coefficient = G.GAME.chips / blind.chips
        local reward_level = DummyCalculateLevel(coefficient, false) --> Validates final level, level is capped!
        G.GAME.dum_dummy_level = nil
        --print("Coefficient: "..coefficient)
        --print("Reward-Level: "..reward_level)
        if reward_level ~= -1 then
            -- Ordered such that Double-Tag always duplicates the best Tag first:
            -- Normal Rewards
            if reward_level >= 7 then DummyAddRewardTag('tag_ethereal') end -- 225%+
            if reward_level >= 5 then DummyAddRewardTag('tag_charm') end -- 175%+
            if reward_level >= 3 then DummyAddRewardTag('tag_meteor') end -- 125%+
            -- Extra High Rewards
            if reward_level >= 13 then DummyAddRewardTag('tag_ethereal') end -- 375%+
            if reward_level >= 11 then DummyAddRewardTag('tag_charm') end -- 325%+
            if reward_level >= 9 then DummyAddRewardTag('tag_meteor') end -- 275%+
            -- You did it!
            if reward_level >= 398 then -- 10.000% / Max.
	            G.E_MANAGER:add_event(Event({
	            	trigger = 'after',
	            	func = function()
                        SMODS.add_card({ key = 'j_ticket', edition = 'e_negative' })
	            		return true
	            	end
	            }))
		        check_for_unlock({ type = 'dum_hyperlight', level = reward_level }) --> Grants Achievement.
            end 
            -- Money-Cap
            return math.min(100, reward_level * 2 - 1)
        else return -5 end --> Penalty for not reaching 50%
    end,
    calculate = function(self, blind, context)
        if context.end_of_round and context.game_over and context.main_eval then
            return { saved = 'k_worm_dum_dummy_blind_saved' }
        end
        if context.after then
	        G.E_MANAGER:add_event(Event({
	        	trigger = 'after',
	        	func = function()
                    DummyCalculateLevel(G.GAME.chips / math.max(1.0, G.GAME.blind.chips), true)
	        		return true
	        	end
	        }))
            return
        end
    end,
}
