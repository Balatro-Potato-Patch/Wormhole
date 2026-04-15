SMODS.Joker {
    key = "riverboat_roche",
    config = {
        extra = {
            percentage = 125
        }
    },
    rarity = 2,
    cost = 8,
    atlas = "worm_jokers",
    pos = { x = 8, y = 0 },
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    ppu_coder = { "blamperer" },
    ppu_artist = { "blamperer" },
    ppu_team = { "riverboat" },
    attributes = { "planet", "destroy_card", "space" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.percentage
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            local score_pct = (G.GAME.chips / G.GAME.blind.chips) * 100
            if score_pct > card.ability.extra.percentage then
                -- print("nice job")
                local planece = {}
                for _, v in ipairs(G.consumeables.cards) do
                    if v.ability.set == "Planet" then planece[#planece + 1] = v end
                end
                if #planece > 0 then
                    local chosen, _ = pseudorandom_element(planece, "worm_riverboat_roche")
                    local chips, mult = Wormhole.Riverboat.level_params_for_planet(chosen)
                    SMODS.destroy_cards(chosen)
                    SMODS.calculate_effect({
                        message = localize("k_disintegrated_ex"),
                        message_colour = G.C.SECONDARY_SET.Planet
                    }, card)
                    Wormhole.Riverboat.upgrade_hands({ G.GAME.last_hand_played }, { chips = chips, mult = mult }, card)
                    delay(1.3) -- vanilla delay
                end
            end
        end
    end
}
