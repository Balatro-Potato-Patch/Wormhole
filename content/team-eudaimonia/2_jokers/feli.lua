SMODS.Sound({key = "worm_euda_cd_5", path = "team-eudaimonia/countdown-5.ogg"})
SMODS.Sound({key = "worm_euda_cd_4", path = "team-eudaimonia/countdown-4.ogg"})
SMODS.Sound({key = "worm_euda_cd_3", path = "team-eudaimonia/countdown-3.ogg"})
SMODS.Sound({key = "worm_euda_cd_2", path = "team-eudaimonia/countdown-2.ogg"})
SMODS.Sound({key = "worm_euda_cd_1", path = "team-eudaimonia/countdown-1.ogg"})
SMODS.Sound({key = "worm_euda_blastoff", path = "team-eudaimonia/blastoff.ogg"})

SMODS.Atlas {
    key = "euda_blastoff_feli",
    path = "team-eudaimonia/blastoff.png",
    px = 71,
    py = 95,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 12,
}
local getMPHand = function()
	local _handname, _played = 'High Card', -1
	for hand_key, hand in pairs(G.GAME.hands) do
		if hand.played > _played then
			_played = hand.played
			_handname = hand_key
		end
	end
	local most_played = _handname
	return most_played
end

SMODS.Joker {
	atlas = 'euda_blastoff_feli',
	pos = { x = 0, y = 0},
	soul_pos = {
		x = 0, y = 1,
	},
	pools = {["FelisJokeria"] = true,},
	key = "euda_rocket",
	rarity = 1,
	cost = 8,
    pronouns = "it_its",
	blueprint_compat = true,
	eternal_compat = true,
	ppu_team = {"TeamEudaimonia"},
	ppu_artist = {"LasagnaFelidae"},
	ppu_coder = {"LasagnaFelidae"},
    attributes = {"scaling", "mult", "space"},
	config = {
		extra = { mult = 5, mult_mod = 5, count = 0, max_c = 5, ascended = false, set = true},
	},	
	loc_vars = function(self, info_queue, card)
		local key = self.key
		if card.ability.extra.ascended == true then
			key = self.key .. "_a"
		end
		return { vars = {card.ability.extra.mult, card.ability.extra.mult_mod, math.min(5,((card.ability.extra.max_c + 1 ) - card.ability.extra.count)), }, key = key }
	end,
	calculate = function(self, card, context)
		if context.before then
			local mph = getMPHand()
			if context.scoring_hand ~= mph and card.ability.extra.ascended == true then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.GOLD,
					no_juice = false
				}
			elseif context.scoring_hand == mph and card.ability.extra.ascended == true then
				SMODS.destroy_cards(card)
				return {
					message = localize('k_reset'),
					colour = G.C.RED,
					no_juice = false
				}
			end
			if context.scoring_hand ~= mph and card.ability.extra.count < card.ability.extra.max_c then
				card.ability.extra.count = card.ability.extra.count + 1
                play_sound('worm_euda_cd_'..((card.ability.extra.max_c - card.ability.extra.count) + 1), 1)
                card.ability.extra.set = false
			elseif card.ability.extra.ascended == false and card.ability.extra.count >= card.ability.extra.max_c then
				play_sound('worm_euda_blastoff', 1)
				card.ability.extra.ascended = true
				card.ability.extra.mult = 10
                return {
					message = "Blast Off!",
					colour = G.C.GOLD,
					no_juice = false
				}
			end
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end,
}
