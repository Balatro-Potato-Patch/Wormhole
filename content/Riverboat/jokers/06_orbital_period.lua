SMODS.Joker {
    key = "riverboat_orbital",
    config = {
        extra = {
            hand_idx = 1
        }
    },
    rarity = 2,
    cost = 6,
    atlas = "worm_jokers",
    pos = { x = 5, y = 0 },
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    ppu_coder = { "blamperer" },
    ppu_artist = { "camo" },
    ppu_team = { "riverboat" },
    attributes = { "planets", "generation", "space" },
    loc_vars = function(self, info_queue, card)
        local suffix = "th"
        local idx_str = tostring(card.ability.extra.hand_idx)
        if idx_str:sub(-2, -2) ~= '1' then -- Second to last character (or nil is length of string is 1)
            local last = idx_str:sub(-1)   -- Last character
            suffix = (last == '1' and "st") or (last == '2' and "nd") or (last == '3' and "rd") or "th"
        end
        return {
            vars = {
                card.ability.extra.hand_idx,
                suffix
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and G.GAME.current_round.hands_played == (card.ability.extra.hand_idx - 1) then
            local planet = Wormhole.Riverboat.get_planet_for_hand(context.scoring_name)
            if planet and (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            key = planet
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_planet"),
                    colour = G.C.SECONDARY_SET.Planet
                }
            end
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.hand_idx = card.ability.extra.hand_idx + 1
            if card.ability.extra.hand_idx > G.GAME.round_resets.hands then
                card.ability.extra.hand_idx = 1
            end
            return {
                message = localize("k_revolve_ex")
            }
        end
    end
}
