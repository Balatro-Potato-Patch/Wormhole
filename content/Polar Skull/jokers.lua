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
    ppu_artist = {"jade"},
    ppu_coder = { "cloudzxiii" },
    ppu_team = { "polar_skull" },

    config = {
        extra = {
            x_mult = 1,
            xmult_gain = 0.2
        }
    },

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "polarskull_rocket" and context.consumeable.ability.extra.hand ~= context.consumeable.ability.extra.previous_hand then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "x_mult",
                scalar_value = "xmult_gain",
                operation = '+',
                message_key = 'a_xmult',
            })
        end
    end,
}

SMODS.Joker {
    key = 'polarskull_olimar',

    loc_vars = function(self, info_queue, card)
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
    --ppu_artist = {"placeholder"},
    ppu_coder = { "cloudzxiii" },
    ppu_team = { "polar_skull" },

    config = {},

    add_to_deck = function(self, card, from_debuff)
        G.GAME.polarskull_rockets_stack = true
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

--[[
local smods_showman_ref = SMODS.showman
function SMODS.showman(card_key)
    if next(SMODS.find_card('j_worm_polarskull_olimar')) then
        local center = G.P_CENTERS[card_key]
        if center and center.set == "polarskull_rocket" then
            return true
        end
    end
    return smods_showman_ref(card_key)
end
--]]
