SMODS.Atlas {
    key = 'thorn_cards',
    path = 'thorn/thorn_cards.png',
    px = 71,
    py = 95
}

SMODS.Joker {
	key = 'thorn_jimbo',
	rarity = 1,
    atlas = "thorn_cards",
	pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y = 1}, --I don't want to rearange the atlas :з
	cost = 5,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    jand_gemini_compat = false, -- Me making our Jokers compatible with my shit... Hehehehe :Þ
    attributes = {'space', 'planet'},
    loc_vars = function(self, info_queue, card)
        return { vars = {G.PROFILES[G.SETTINGS.profile].name}}
    end,
	calculate = function(self, card, context)
        if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            SMODS.add_card{set = "Planet"}
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card:add_sticker("perishable", true)
    end,
    ppu_artist = {"hatstack"},
    ppu_coder = {"evgast"},
    ppu_team = {"thorn"},
}

SMODS.Joker {
	key = 'thorn_binary',
	rarity = 1,
    atlas = "thorn_cards",
	pos = { x = 1, y = 0 },
	cost = 5,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
    jand_gemini_compat = false,
    attributes = {'space', 'planet', 'chance'},
    config = { extra = { odds = 2, times = 2 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'thorn_binary')
		return { vars = { numerator, denominator} }
    end,
    ppu_artist = {"willow"},
    ppu_coder = {"evgast"},
    ppu_team = {"thorn"},
}

--Not sure if I should like make a file for this stuff but
Wormhole.suits_dark = {Spades = true, Clubs = true}
Wormhole.suits_light = {Hearts = true, Diamonds = true}

function suit_count(suit)
    local count = 0
    for k, v in pairs(G.playing_cards) do
        if v.base and v.base.suit == suit then
            count = count + 1
        end
        if suit == "dark" then
            if v.base and Wormhole.suits_dark[v.base.suit] then
                count = count + 1
            end
        elseif suit == "light" then
            if v.base and Wormhole.suits_light[v.base.suit] then
                count = count + 1
            end
        end
    end
    return count
end

SMODS.Joker {
	key = 'thorn_derse',
	rarity = 2,
    atlas = "thorn_cards",
	pos = { x = 2, y = 0 },
	cost = 7,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    jand_gemini_compat = true,
    attributes = {'space', 'xmult', 'spades', 'clubs'},
    config = { extra = { xmult_base = 1, xmult_gain = 0.1, xmult = 1, percentage_floor = 45 } },
    loc_vars = function(self, info_queue, card)
        if card.area.config.type == "Joker" then
            local percentage = math.floor(((suit_count("dark")/#G.playing_cards)*100)+0.5)
            if percentage >= card.ability.extra.percentage_floor then
                card.ability.extra.xmult = card.ability.extra.xmult_base + ((percentage - card.ability.extra.percentage_floor) * card.ability.extra.xmult_gain)
            else
                card.ability.extra.xmult = card.ability.extra.xmult_base
            end
            return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult, card.ability.extra.percentage_floor, percentage }, key = self.key }
        else
            return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult, card.ability.extra.percentage_floor }, key = self.key .. "_collection" }
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local percentage = math.floor(((suit_count("dark")/#G.playing_cards)*100)+0.5)
            if percentage >= card.ability.extra.percentage_floor then
                card.ability.extra.xmult = card.ability.extra.xmult_base + ((percentage - card.ability.extra.percentage_floor) * card.ability.extra.xmult_gain)
            else
                card.ability.extra.xmult = card.ability.extra.xmult_base
            end
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    ppu_artist = {"hatstack"},
    ppu_coder = {"evgast"},
    ppu_team = {"thorn"},
}

SMODS.Joker { --Moved here for the sake of them being close on atlas
	key = 'thorn_prospit',
	rarity = 2,
    atlas = "thorn_cards",
	pos = { x = 1, y = 1 },
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
    jand_gemini_compat = false,
    config = { extra = { chips = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local percentage = ((suit_count("dark")/#G.playing_cards)*100)
            if percentage >= card.ability.extra.percentage_floor then
                card.ability.extra.xmult = card.ability.extra.xmult_base + ((percentage - card.ability.extra.percentage_floor) * card.ability.extra.xmult_gain)
            else
                card.ability.extra.xmult = card.ability.extra.xmult_base
            end
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    ppu_artist = {"hatstack"},
    ppu_coder = {"sophie"},
    ppu_team = {"thorn"},
}

SMODS.Joker {
	key = 'thorn_mars_face',
	rarity = 2,
    atlas = "thorn_cards",
	pos = { x = 3, y = 0 },
	cost = 6,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    jand_gemini_compat = false,
    attributes = {'space', 'hand_type', 'generation'},
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
    end,
    calculate = function(self, card, context) --Most of this is vremade code for DNA :Þ
        if context.individual and context.cardarea == "unscored" and next(context.poker_hands["Four of a Kind"]) then
            if context.other_card:is_face() then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local card_copied = copy_card(context.other_card, nil, nil, G.playing_card)
                card_copied:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, card_copied)
                G.hand:emplace(card_copied)
                card_copied.states.visible = nil

                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_copied:start_materialize()
                        return true
                    end
                }))
                return {
                    message = localize('k_copied_ex'),
                    colour = G.C.CHIPS,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end,
    set_sprites = function(self, card, front)
        if math.random() > 1/2 then
            card.children.center:set_sprite_pos({x = 4, y = 0})
        end
    end,
    ppu_artist = {"hatstack"},
    ppu_coder = {"evgast"},
    ppu_team = {"thorn"},
}

SMODS.Joker {
	key = 'thorn_piss',
	rarity = 2,
    atlas = "thorn_cards",
	pos = { x = 0, y = 1 },
	cost = 6,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    jand_gemini_compat = false,
    attributes = {"space", "clubs"}, --I'm not sure of this should have 'diamonds' attribute because of the way SMODS wiki describes these
    config = { extra = { suit_old = "Clubs", suit_new = "Diamonds", chips = 20 } },
    loc_vars = function(self, info_queue, card)
        local loc = {}
	    local quip = {}
	    localize{type = "descriptions", key = "thorn_piss_rant", set = "Joker", default_col = G.C.UI.TEXT_DARK, nodes = loc, vars = {}, scale = 0.7}
	    quip = {transparent_multiline_text(loc)}
        return { vars = { localize(card.ability.extra.suit_old, 'suits_plural'), localize(card.ability.extra.suit_new, 'suits_plural'), card.ability.extra.chips }, main_end = {
            {n=G.UIT.C, config = {align = "cm", minh = 1, minw = 5, r = 0.3, padding = 0.07, colour = G.C.JOKER_GREY, shadow = true}, nodes={
				{n=G.UIT.R, config={align = "cm" , r = 0.2, padding = 0.1, colour = G.C.WHITE}, nodes=
					quip
				}
			}},
        } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local Card = context.other_card
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if Card:is_suit(card.ability.extra.suit_old) then --Check for suit happens here because of retriggers
                                Card:juice_up()
                                SMODS.change_base(Card, card.ability.extra.suit_new)
                                Card.ability.perma_bonus = (Card.ability.perma_bonus or 0) + card.ability.extra.chips
                            end
                            return true
                        end
                    }))
                end
            }
        end
    end,
    ppu_artist = {"hatstack"},
    ppu_coder = {"evgast"},
    ppu_team = {"thorn"},
}

SMODS.Joker {
	key = 'thorn_devils_machine',
	rarity = 3,
    atlas = "thorn_cards",
	pos = { x = 3, y = 1 },
	cost = 7,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    jand_gemini_compat = true,
    config = { extra = { stop = false, odds = 4 } },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'devils_machine')
        return {vars = {new_numerator, new_denominator}}
    end,
    calculate = function(self, card, context, effect)
        if (not card.ability.extra.stop) and context.individual and context.cardarea == G.play then
            if context.other_card == context.scoring_hand[#context.scoring_hand] then
                return {
                    func = function()
                        SMODS.calculate_effect({message = localize('k_again_ex')}, card)
                        for i=#context.scoring_hand, 1, -1 do
                            local passed_context = context
                            card.ability.extra.stop = true
                            SMODS.score_card(context.scoring_hand[i], passed_context)
                        end
                        card.ability.extra.stop = false
                    end
                }
            end
        elseif context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if SMODS.pseudorandom_probability(card, 'devils_machine', 1, card.ability.extra.odds, 'devils_machine') then
                SMODS.destroy_cards(card, nil, nil, true)
                SMODS.add_card { set = 'Joker', key = 'j_worm_thorn_giygas' }
                return {
                    message = localize('k_thorn_giygas_reveal')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
    end,
    ppu_artist = {"hatstack"},
    ppu_coder = {"sophie"},
    ppu_team = {"mtw"},
}

SMODS.Joker {
	key = 'thorn_giygas',
	rarity = 3,
    atlas = "thorn_cards",
	pos = { x = 4, y = 1 },
	cost = 7,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    jand_gemini_compat = true,
    no_collection = true,
    in_pool = function(self)
        return false
    end,
    config = { extra = { stop = false, odds = 4 } },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'giygas')
        return {vars = {new_numerator, new_denominator}}
    end,
    calculate = function(self, card, context, effect)
        if (not card.ability.extra.stop) and context.individual and context.cardarea == G.play then
            if context.other_card == context.scoring_hand[#context.scoring_hand] then
                return {
                    func = function()
                        SMODS.calculate_effect({message = localize('k_again_ex')}, card)
                        local scoring_hand_giygas = {}
                        for i, v in ipairs(context.scoring_hand) do
                            scoring_hand_giygas[i] = v
                        end
                        pseudoshuffle(scoring_hand_giygas, 'giygas')
                        for i=1, #scoring_hand_giygas do
                            local passed_context = context
                            card.ability.extra.stop = true
                            SMODS.score_card(scoring_hand_giygas[i], passed_context)
                        end
                        card.ability.extra.stop = false
                    end
                }
            end
        elseif context.before and not context.blueprint then
            local triggered = false
            for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.pseudorandom_probability(card, 'giygas', 1, card.ability.extra.odds, 'giygas') then
                    triggered = true
                    scored_card:set_ability(SMODS.poll_enhancement{key = "giygas", guaranteed = true}, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
                if triggered then
                    return {
                        message = localize('k_thorn_giygas_enhanced')
                    }
                end
            end
        end
    end,
    ppu_artist = {"hatstack"},
    ppu_coder = {"sophie"},
    ppu_team = {"mtw"},
}
