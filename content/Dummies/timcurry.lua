-- SPAAACE!

for k, v in ipairs({ "space", "anothervictory", "commander", "excellentjob", "excellentwork", "goodluckgentlemen", "niceworkcomrade", "suchashame", "suchashamefull", "treachery"}) do
	SMODS.Sound({ key = "dum_timcurry_"..v, path = "Dummies/TimCurry/"..v..".ogg" })
end

SMODS.Atlas({
	key = "DummiesTCTag",
	path = "Dummies/timcurrytag.png",
	px = 34,
	py = 34
})

SMODS.Atlas({
	key = "DummiesTCJoker",
	path = "Dummies/timcurryjoker.png",
	px = 129,
	py = 95
})

SMODS.Joker({
	key = 'dum_timcurry',
	config = { extra = { ml = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.ml } }
	end,
	unlocked = true,
	in_pool = function()
		return not G.GAME.commandandconquer, {allow_duplicates = false}
	end,
	rarity = 3,
	atlas = 'DummiesTCJoker',
	pos = { x = 2, y = 18 },
	wormhole_anim = {
		{ xrange = { first = 0, last = 2 }, yrange = { first = 0, last = 18 }, t = 0.1 }
	},
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before and context.poker_hands and next(context.poker_hands) and next(context.poker_hands['Pair']) then
			local qc, hc = 0, false
			for _, t in ipairs(context.poker_hands['Pair'] or {}) do
				if not hc then qc = 0 end
				for k, v in ipairs(t) do
					if v:get_id() == 12 then qc = qc + 1 end
					if qc >= 2 then hc = true; break end
				end
			end
			if hc then
				local names = {}
				for k, v in ipairs(G.handlist) do
					if G.GAME.hands[v] and SMODS.is_poker_hand_visible(v) then names[#names+1] = v end
				end
				local effects = {}
				if next(names) then
					local hand = pseudorandom_element(names, pseudoseed('escapingtooneplacenotcorruptedbycapitalism'))
					table.insert(effects, { level_up = card.ability.extra.ml, level_up_hand = hand or G.GAME.last_hand_played })
					if not (context.retrigger_joker or context.blueprint) then
						for c, s in ipairs(SMODS.find_card('j_space', true)) do
							local extrahand = pseudorandom_element(names, pseudoseed('escapingtooneplacenotcorruptedbycapitalism'))
							table.insert(effects, { message = localize('k_again_ex'), message_card = s, extra = { level_up = card.ability.extra.ml*0.5, level_up_hand = extrahand or G.GAME.last_hand_played, message_card = s }})
						end
					end
					return SMODS.merge_effects(effects)
				end
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.commandandconquer = true
	end,
	display_size = { w = 71 * 1.82, h = 95 },
	pixel_size = { w = 71, h = 95 },
	ppu_coder = { "theonegoofali" },
	ppu_artist = { "theonegoofali", "ghostsalt" },
	ppu_team = { "dummies" },
	attributes = { "hand_type", "rank", "queen", "joker" },
	pronouns = "he_him"
})

SMODS.Tag({
	key = "dum_timcurry",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_worm_dum_timcurry
	end,
	in_pool = function()
		return not G.GAME.commandandconquer
	end,
	atlas = "DummiesTCTag",
	pos = { x = 0, y = 0 },
	config = { type = "store_joker_create" },
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = SMODS.create_card({ key = "j_worm_dum_timcurry" })
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.RED, function()
				card:start_materialize()
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
	end,
	ppu_coder = { "theonegoofali" },
	ppu_artist = { "theonegoofali" },
	ppu_team = { "dummies" },
})

local ccasbref = Card_Character.add_speech_bubble
function Card_Character:add_speech_bubble(text_key, align, loc_vars, quip_args)
	if self.config.args.center == 'j_worm_dum_timcurry' then aeiou = self; self.wormhole_pos_extra = { x = 2, y = 18 } end
	ccasbref(self, text_key, align, loc_vars, quip_args)
end