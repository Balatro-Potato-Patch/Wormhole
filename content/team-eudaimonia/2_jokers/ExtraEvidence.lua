SMODS.Atlas {
    key = 'euda_extraevidenceatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/ExtraEvidence.png', --Update with actual art
}

SMODS.Joker {
    key = "euda_extraevidence",
    atlas = 'euda_extraevidenceatlas',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    discovered = true,
    ppu_coder = {'M0xes'},
    ppu_artist = {'Hunter'},
    ppu_team = {"TeamEudaimonia"},
    calculate = function(self, card, context)
        if context.before then
            for i, playing_card in ipairs(context.scoring_hand) do
                if (i ~= 1) then
                    playing_card:set_debuff(true)
                    G.E_MANAGER:add_event(Event({
				        trigger = 'before',
    			        func = function()
        		        playing_card:set_debuff(true)
        		        return true
    			        end
			        }))
                end
            end
            
        end
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
			local repeats = 0
			local ranks_used = {}
			if not SMODS.has_no_rank(context.scoring_hand[1]) then
				ranks_used[context.scoring_hand[1].base.value] = true
			end
			for _, playing_card in ipairs(context.scoring_hand) do
                if not SMODS.has_no_rank(playing_card) and not ranks_used[playing_card.base.value] then
					ranks_used[playing_card.base.value] = true
					repeats = repeats + 1
				end
            end
            if repeats > 0 then
                return {
                    repetitions = repeats
                }
            end
        end
        if context.after then
            for i, playing_card in ipairs(context.scoring_hand) do
                if (i ~= 1) then
                    playing_card:set_debuff(false)
                    G.E_MANAGER:add_event(Event({
				        trigger = 'after',
    			        func = function()
        		        playing_card:set_debuff(false)
        		        return true
    			        end
			        }))
                end
            end
        end
    end,
}
