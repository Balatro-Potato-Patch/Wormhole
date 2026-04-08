SMODS.Atlas {
    key = 'euda_wowsignalatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/wowsignal.png',
}

SMODS.Atlas {
    key = 'euda_bigearatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/bigear.png',
}

SMODS.Atlas {
    key = 'euda_bitflipatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/bitflip.png',
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
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { num, denom, card.ability.extra.chipsmin, card.ability.extra.chipsmax, card.ability.extra.wowmin, card.ability.extra.wowmax} }
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


--ripped from yahimod
SMODS.PokerHand({
    key = "pkr_euda_wow",
    mult = 5,
    chips = 30,
    l_mult = 2,
    l_chips = 30,
    example = {
        { 'H_6', true }, 
        { 'D_3', true },
        { 'H_Q', true }, 
        { 'S_J', true },
        { 'C_5', true } 
    },
    visible = false,

    evaluate = function(parts, hand)
        if #hand >= 3 then
            local _has6 = false
            local _has3 = false
            local _has5 = false
            local _hasQ = false
            local _hasJ = false
            local eligible_cards = {}
            local other_hands = next(parts._flush) or next(parts._straight) or next(parts._all_pairs)

            for i, card in ipairs(hand) do
                if card:get_id() == 6 and _has6 == false then
                    _has6 = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 3 and _has3 == false then
                    _has3 = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 5 and _has5 == false then
                    _has5 = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 12 and _hasQ == false then
                    _hasQ = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 11 and _hasJ == false then
                    _hasJ = true
                    eligible_cards[#eligible_cards + 1] = card
                end
            end


            if _has6 and _has3 and _has5 and _hasQ and _hasJ and not other_hands then
                return{eligible_cards}
            end
        end


    end,


})

SMODS.PokerHand({
    key = "pkr_euda_wow_f",
    mult = 10,
    chips = 30,
    l_mult = 5,
    l_chips = 30,
    example = {
        { 'H_6', true},
        { 'H_3', true},
        { 'H_Q', true},
        { 'H_J', true},
        { 'H_5', true}
    },
    visible = false,

    evaluate = function(parts, hand)
        if #hand >= 5 then
            local _has6 = false
            local _has3 = false
            local _has5 = false
            local _hasQ = false
            local _hasJ = false
            local eligible_cards = {}
            local other_hands =next(parts._straight) or next(parts._all_pairs)

            if not next(parts._flush) then return end
            for i, card in ipairs(hand) do
                if card:get_id() == 6 and _has6 == false then
                    _has6 = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 3 and _has3 == false then
                    _has3 = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 5 and _has5 == false then
                    _has5 = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 11 and _hasJ == false then
                    _hasJ = true
                    eligible_cards[#eligible_cards + 1] = card
                elseif card:get_id() == 12 and _hasQ == false then
                    _hasQ = true
                    eligible_cards[#eligible_cards + 1] = card
                end
            end


            if _has3 and _has5 and _has6 and _hasJ and _hasQ and not other_hands then
                return{eligible_cards, SMODS.merge_lists(parts._flush)}
            end
        end
    end,
})

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

SMODS.Consumable {
    key = "euda_bigear",
    set = "Planet",
    cost = 3,
    atlas = "euda_bigearatlas",
    pos = { x = 0, y = 0 },
    config = { hand_types = {'worm_pkr_wow','worm_pkr_wow_f'} },
    ppu_coder = {'Typ0', 'LasagnaFelidae'},
    ppu_artist = {'LasagnaFelidae'},
    hidden = true,
    config = {softlock = true},
    use = function(self, card, area, copier)
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('k_worm_wow_hands'), chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
        delay(1.3)
        SMODS.upgrade_poker_hands({hands = {"worm_pkr_euda_wow","worm_pkr_euda_wow_f"}, instant = true, from = "c_worm_euda_bigear"})
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
    end,
    can_use = function(self, card)
        return true
    end,
}
