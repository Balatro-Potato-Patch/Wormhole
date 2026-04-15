SMODS.Atlas {
    key = 'euda_wowsignalatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/wowsignal.png',
}

SMODS.Atlas {
    key = 'euda_8tpatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/8TP.png',
}

SMODS.Atlas {
    key = 'euda_littlelightatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/LittleLight.png',
}

SMODS.Atlas {
    key = 'euda_bitflipatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/bitflip.png',
}

SMODS.Atlas {
    key = 'evilatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/evil.png',
}

SMODS.Joker {
    key = "euda_wowsignal",
    atlas = 'euda_wowsignalatlas',
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 2,
    discovered = true,
    config = {extra = {numerator = 1, denominator = 6, chipsmin = 20, chipsmax = 50, wowmin = 2, wowmax = 5}},
    ppu_coder = {'Typ0'},
    ppu_artist = {'LasagnaFelidae'},
    ppu_team = {"TeamEudaimonia"},
    attributes = {"chance","xchips", "chips", "space",},
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { num, denom, card.ability.extra.wowmin, card.ability.extra.wowmax, card.ability.extra.chipsmin, card.ability.extra.chipsmax} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'wowsignalprob', card.ability.extra.numerator, card.ability.extra.denominator) then
                return {
                    colour = G.C.RED,
                    message = 'Wow!',
                    xchips = pseudorandom('wowsignalchips', card.ability.extra.wowmin, card.ability.extra.wowmax),
                }
            else
                return {
                    chips = pseudorandom('wowsignalchips', card.ability.extra.chipsmin, card.ability.extra.chipsmax),
                }
            end
        end
    end
}




SMODS.Joker {
    key = "euda_bitflip",
    atlas = 'euda_bitflipatlas',
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 2,
    discovered = true,
    config = {extra = {numerator = 1, denominator = 8, bitflipped = false, chips = 32, multmin = 1, multmax = 16}},
    ppu_coder = {'Typ0'},
    ppu_artist = {'Typ0','Hunter'},
    ppu_team = {"TeamEudaimonia"},
    attributes = {"chance","chips", "mult", "space",},
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { num, denom, card.ability.extra.bitflipped, card.ability.extra.chips, card.ability.extra.multmin, card.ability.extra.multmax} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'bitflipprob', card.ability.extra.numerator, card.ability.extra.denominator) then
                SMODS.calculate_effect({message = 'Bit Flipped!'}, card)
                if card.ability.extra.bitflipped == true then
                    card:flip()
                    card.children.center:set_sprite_pos({ x = 0, y = 0 })
                    card.ability.extra.bitflipped = false
                    card:flip()
                else
                    card:flip()
                    card.children.center:set_sprite_pos({ x = 1, y = 0 })
                    card.ability.extra.bitflipped = true
                    card:flip()
                end
            end

            if card.ability.extra.bitflipped == true then
                return {
                    mult = pseudorandom('bitflipmult', card.ability.extra.multmin, card.ability.extra.multmax),
                }
            else
                return {
                    chips = card.ability.extra.chips,
                }
            end
        end
    end
}


--from cryptid

function suit_level_up(card, copier, number, poker_hands, message)
	local used_consumable = copier or card
	if not number then
		number = 1
	end
	if not poker_hands then
		poker_hands = { "Two Pair", "Straight Flush" }
	end
	if message then
		SMODS.calculate_effect({
			message = localize("k_level_up_ex"),
		}, card)
	end
	for _, v in pairs(poker_hands) do
		SMODS.smart_level_up_hand(used_consumable, v, nil, number)
	end
	update_hand_text(
		{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
		{ mult = 0, chips = 0, handname = "", level = "" }
	)
end



SMODS.Joker {
    key = "evil",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 3,
    cost = 5,
    atlas = "evilatlas",
    pos = { x = 0, y = 0 },
    config = { extra = { xmult_gain = 6, xmult = 3 } },
    ppu_team = {"TeamEudaimonia"},
    ppu_coder = {'Typ0'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint  then
            if context.beat_boss then
                local destructable_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced then
                        destructable_jokers[#destructable_jokers + 1] =
                            G.jokers.cards[i]
                    end
                end
                local joker_to_destroy = pseudorandom_element(destructable_jokers, 'vremade_madness')

                if joker_to_destroy then
                    joker_to_destroy.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            (context.blueprint_card or card):juice_up(0.8, 0.8)
                            joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                            return true
                        end
                    }))
                end
                -- See note about SMODS Scaling Manipulation on the wiki
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.xmult_gain
                card:set_cost()
                return {
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

SMODS.Joker {
    key = "LittleLight",
    atlas = "euda_littlelightatlas",
    blueprint_compat = false,
    eternal_compat = false,
    rarity = 3,
    cost = 5,
    pos = { x = 0, y = 0 },
    config = { extra = { deaths_used = 0, xmult = 1, xmult_gain = 0.2} }, --deaths used is useless so
    ppu_coder = {'Typ0'},
    ppu_artist = {'TigerTHawk'},
    ppu_team = {"TeamEudaimonia"},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval then
            if G.GAME.chips / G.GAME.blind.chips >= 0.25 then -- See note about Talisman compatibility on the wiki
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        SMODS.destroy_cards(card, nil, true)
                        return true
                    end
                }))
                return {
                    message = localize('k_saved_ex'),
                    saved = 'ph_mr_bones',
                    colour = G.C.RED
                }
            end
        end
        if context.using_consumeable and context.consumeable.config.center.key == 'c_death' then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain 
        end

        if context.joker_main then 
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
   

}


SMODS.Consumable {
    key = "euda_81p",
    set = "Planet",
    atlas = "euda_8tpatlas",
    cost = 3,
    ppu_coder = {'Typ0', 'M0xes'},
    ppu_artist = {'LasagnaFelidae'},
    ppu_team = {"TeamEudaimonia"},
    pos = { x = 0, y = 0 },
    config = { hand_type = 'worm_pkr_euda_nova', softlock = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.hands[card.ability.hand_type].level,
                localize(card.ability.hand_type, 'poker_hands'),
                G.GAME.hands[card.ability.hand_type].l_mult,
                G.GAME.hands[card.ability.hand_type].l_chips,
                colours = { (G.GAME.hands[card.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
            }
        }
    end,
    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_worm_euda_cometplanet'),
        get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Planet.text_colour, 1.2)
    end
}

--ripped from yahimod
SMODS.PokerHand({
	key = "pkr_euda_nova",
	visible = false,
	chips = 100,
	mult = 10,
	l_chips = 40,
	l_mult = 3,
	example = {
		{ "S_A", true, enhancement = "m_wild" },
		{ "H_K", true, enhancement = "m_wild" },
		{ "C_3", true, enhancement = "m_wild" },
		{ "D_4", true, enhancement = "m_wild" },
		{ "S_9", true, enhancement = "m_wild" },
	},
	evaluate = function(parts, hand)
        local wilds = {}
        for i, card in ipairs(hand) do
            if card.config.center and card.config.center.key == "m_wild" then
                wilds[#wilds + 1] = card
            end
        end
        return #wilds >= 5 and { wilds } or {}
    end,
})
