SMODS.Atlas {
    key = "polarskull_jokers",
    path = "Polar Skull/jokers.png",
    px = 71,
    py = 95,
}

SMODS.Joker({
    key = "polarskull_martian",
    rarity = 3,
    atlas = "polarskull_jokers",
    pos = { x = 0, y = 0 },
    cost = 5,
    discovered = false,
    blueprint_compat = true,
    ppu_artist = {"comykel"},
    ppu_coder = { "mariofan" },
    ppu_team = { "polar_skull" },
    config = { extra = { poker_hand = "High Card", cards_created = 2, still_successful = true } },
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            localize(card.ability.extra.poker_hand, 'poker_hands'), 
            card.ability.extra.cards_created,
            localize {  type = 'variable', key = ((card.ability.extra.still_successful == true and 'k_polarskull_martian_active') or 'k_polarskull_martian_inactive'), vars = { card.ability.extra.still_successful } },
            colours = {
                card.ability.extra.still_successful and G.C.GREEN or G.C.RED,
            },
        } }
    end,

    calculate = function(self, card, context)
        if context.before and (context.scoring_name ~= card.ability.extra.poker_hand) and card.ability.extra.still_successful == true and not context.blueprint then
            card.ability.extra.still_successful = false
            return {
                message = localize("k_nope_ex"),
            }
        end
        if context.ante_change and context.ante_end then
            local cards_made = 0
            for i = 1, card.ability.extra.cards_created do
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and card.ability.extra.still_successful then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = 'Spectral',
                                key_append = 'FNM' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    cards_made = cards_made + 1
                end
            end
            if not context.blueprint then
                
            end
            if cards_made > 0 then
                SMODS.calculate_effect(
                        { message = "+" .. cards_made .. " " .. localize('k_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral},
                        context.blueprint_card or card)
            elseif not card.ability.extra.still_successful and not context.blueprint then
                SMODS.calculate_effect(
                        { message = localize('k_reset'),
                        colour = G.C.SECONDARY_SET.Spectral},
                        card)
            elseif card.ability.extra.still_successful then
                SMODS.calculate_effect(
                        { message = localize('k_no_room_ex'),
                        colour = G.C.SECONDARY_SET.Spectral},
                        context.blueprint_card or card)
            end
        end
        if context.ante_change and context.ante_end and not context.blueprint then
            card.ability.extra.still_successful = true
            --Taken from Vanilla Remade's to-do list
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, "vremade_to_do")
        end
    end,
    set_ability = function(self, card, initial, delay_sprites) --Taken from Vanilla Remade's to-do list
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, "polarskull_martian")
    end
})

SMODS.Joker {
    key = 'polarskull_launchpad',

    rarity = 2,
    atlas = 'polarskull_jokers',
    pos = { x = 2, y = 0 },
    cost = 5,
    discovered = false,
    blueprint_compat = true,
    ppu_artist = {"mariofan"},
    ppu_coder = { "cloudzxiii" },
    ppu_team = { "polar_skull" },

    config = {},

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and context.beat_boss then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                if G.GAME.last_hand_played then
                                    local _rocket = 0
                                    for k, v in pairs(G.P_CENTER_POOLS.polarskull_rocket) do
                                        if v.config.extra.hand == G.GAME.last_hand_played then
                                            _rocket = v.key
                                        end
                                    end
                                    SMODS.add_card({ key = _rocket, set = "polarskull_rocket" })
                                    G.GAME.consumeable_buffer = 0
                                end
                                return true
                            end
                        }))
                        SMODS.calculate_effect(
                            { message = localize('k_polarskull_plus_rocket'), colour = G.C.BLUE },
                            context.blueprint_card or card)
                        return true
                    end)
                }))
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            end
        end
    end,
}

SMODS.Joker {
    key = 'polarskull_rocket_science',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.xmult_gain
            }
        }
    end,
    rarity = 2,
    atlas = 'polarskull_jokers',
    pos = { x = 1, y = 0 },
    cost = 6,
    discovered = false,
    blueprint_compat = true,
    ppu_artist = {"comykel", "jade"},
    ppu_coder = { "cloudzxiii", "noodlemire" },
    ppu_team = { "polar_skull" },

    config = {
        extra = {
            x_mult = 1,
            xmult_gain = 0.2
        }
    },

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "polarskull_rocket" and not context.blueprint then
			local found = false
			for _, other_card in ipairs(G.consumeables.cards) do
				if other_card ~= context.consumeable and other_card.ability.set == "polarskull_rocket" and (other_card.ability.extra.active or other_card.ability.extra.was_activated) then
					if other_card.ability.extra.hand == context.consumeable.ability.extra.hand then
						return
					else
						found = true
					end
				end
			end
			if found then
		        SMODS.scale_card(card, {
		            ref_table = card.ability.extra,
		            ref_value = "x_mult",
		            scalar_value = "xmult_gain",
		            operation = '+',
		            message_key = 'a_xmult',
		        })
			end
		elseif context.joker_main then
			return {x_mult = card.ability.extra.x_mult}
        end
    end,
}

SMODS.Joker {
    key = 'polarskull_olimar',

    loc_vars = function(self, info_queue, card)
         info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        return {
            vars = {
                localize({ type = 'name_text', key = "e_negative", set = "Edition" })
            }
        }
    end,

    rarity = 4,
    atlas = 'polarskull_jokers',
    pos = { x = 1, y = 1 },
    soul_pos = { x = 2, y = 1 },
    cost = 20,
    discovered = false,
    blueprint_compat = false,
    ppu_artist = {"mariofan","comykel"},
    ppu_coder = { "cloudzxiii" },
    ppu_team = { "polar_skull" },

    config = {},

    add_to_deck = function(self, card, from_debuff)
        G.GAME.polarskull_rockets_stack = true
		if not from_debuff then check_for_unlock({type = "j_worm_polarskull_olimar"}) end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not next(SMODS.find_card("j_worm_polarskull_olimar")) then
            G.GAME.polarskull_rockets_stack = false
        end
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "polarskull_rocket" then
            context.consumeable:set_edition("e_negative", true)
        end
    end,
}
