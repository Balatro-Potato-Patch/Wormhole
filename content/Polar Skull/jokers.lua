SMODS.Atlas {
    key = "polarskull_jokers",
    path = "Polar Skull/jokers.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = 'polarskull_launchpad',

    rarity = 2,
    atlas = 'polarskull_jokers',
    pos = { x = 2, y = 0 },
    cost = 5,
    discovered = false,
    blueprint_compat = true,
    --ppu_artist = {"placeholder"},
    ppu_coder = { "cloudzxiii" },
    ppu_team = { "polar_skull" },

    config = {},

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and context.beat_boss then
            if G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
    --ppu_artist = {"placeholder"},
    ppu_coder = { "cloudzxiii" },
    ppu_team = { "polar_skull" },

    config = {
        extra = {
            x_mult = 1,
            xmult_gain = 0.2
        }
    },

    calculate = function(self, card, context)
        if context.using_consumeable then
            if context.consumeable.ability.extra.hand ~= context.consumeable.ability.extra.previous_hand then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "x_mult",
                    scalar_value = "xmult_gain",
                    operation = '+',
                    message_key = 'a_xmult',
                })
            end
        end
    end,
}
