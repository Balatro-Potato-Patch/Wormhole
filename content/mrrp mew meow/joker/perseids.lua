SMODS.Joker {
	ppu_team = {'Mrrp Mew Meow :3'},
	ppu_artist = {'SarcPot'},
    ppu_coder = {'Minty'},
	key = 'mrrp_perseids',
	atlas = "mrrp",
	pos = {
		x=1,
		y=2
	},
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = {'space'},

	config = {
		extra = {
			impacts = {}
		}
	},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				
			}
		}
	end,

	calculate = function(self, card, context)
		if context.initial_scoring_step then
            for i=1,#context.scoring_hand do
                local target = pseudorandom("mrrp_meteor_impact", 1, #context.scoring_hand)
                card.ability.extra.impacts[target] = (card.ability.extra.impacts[target] or 0) + 1
            end

            return {
                message = localize("k_make_a_wish_ex")
            }
        end

        if context.repetition and context.cardarea == G.play then
            local pos
            for i=1,#context.scoring_hand do
                if context.scoring_hand[i] == context.other_card then pos = i break end
            end

            if (card.ability.extra.impacts[pos] or 0) > 0 then
                return {
                    repetitions = card.ability.extra.impacts[pos]
                }
            end
        end

        if context.after then
            card.ability.extra.impacts = {}
        end
	end
}