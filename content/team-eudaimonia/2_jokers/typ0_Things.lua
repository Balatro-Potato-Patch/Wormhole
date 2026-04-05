SMODS.Atlas {
    key = 'euda_wow',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/wowsignal.png',
}

SMODS.Joker {
    key = "euda_wowsignal",
    atlas = 'euda_wow',
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 2,
    discovered = true,
    attributes = {"chance","xchips", "chips", "space"},
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
                    xchips = pseudorandom('7rands', card.ability.extra.wowmin, card.ability.extra.wowmax),
                }
            else
                return {
                    chips = pseudorandom('7rands', card.ability.extra.chipsmin, card.ability.extra.chipsmax),
                }
            end
        end
    end
}


--ripped from yahimod
SMODS.PokerHand({
    key = "euda_pkr_wow",
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
    visible = true,

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
    key = "euda_pkr_wow_f",
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
    visible = true,

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