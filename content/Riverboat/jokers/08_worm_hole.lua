SMODS.Joker {
    key = "riverboat_worm_hole",
    config = {
        extra = {
            odds = 2,
            chips = 0,
            chip_gain = 4
        }
    },
    rarity = 1,
    cost = 5,
    atlas = "worm_jokers",
    pos = { x = 7, y = 0 },
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    ppu_coder = { "blamperer" },
    ppu_artist = { "fooping" },
    ppu_team = { "riverboat" },
    attributes = { "chips", "chance", "unscored", "destroy_card" },
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "worm_riverboat_worm_hole")
        return {
            vars = {
                num, denom,
                card.ability.extra.chip_gain,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { chips = card.ability.extra.chips }
        end

        if context.after then
            local modified = {}
            local destroyed = {}
            for i, v in ipairs(context.full_hand) do
                if not SMODS.in_scoring(v, context.scoring_hand) then
                    if SMODS.pseudorandom_probability(card, "worm_hole", 1, card.ability.extra.odds, "worm_riverboat_worm_hole") then
                        if v:get_id() == 2 then destroyed[#destroyed + 1] = v else modified[#modified + 1] = v end
                    end
                end
            end
            local either = SMODS.merge_lists { modified, destroyed }
            local cards_affected = #either
            if #either > 0 then
                Wormhole.Riverboat.flip_cards(either, "f2b")
                delay(0.2)
                for i = 1, #modified do
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            assert(SMODS.modify_rank(modified[i], -1))
                            return true
                        end
                    }))
                end
                Wormhole.Riverboat.flip_cards(either, "b2f")
                if #destroyed > 0 then
                    SMODS.destroy_cards(destroyed)
                end
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chip_gain",
                    operation = function(ref_table, ref_value, initial, change)
                        ref_table[ref_value] = initial + (cards_affected * change)
                    end,
                    scaling_message = {
                        message = localize("k_eaten_ex"),
                        colour = G.C.CHIPS
                    }
                })
                delay(0.5)
            end
        end
    end
}
