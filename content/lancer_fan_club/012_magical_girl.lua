-- Blacephalon
SMODS.Joker {
    key = "lfc_magical_girl",
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 1,
    cost = 6,
    atlas = "lfc_jokers",
    ppu_coder = { "J8-Bit" },
    pos = { x = 1, y = 2 },
    discovered = false,
    config = { extra = { chips = 0, chips_inc = 15 } },
    attributes = {
        "chips",
        "scaling",
        "enhancements"
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_inc,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_ability and not context.blueprint then
            if (context.other_card.ability.set == "Default" or context.other_card.ability.set == "Enhanced") and context.new ~= "c_base" and (context.old ~= context.new) then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra, -- the table that has the value you are changing in
                    ref_value = "chips",            -- the key to the value in the ref_table
                    scalar_value = "chips_inc",     -- the key to the value to scale by, in the ref_table by default
                    scaling_message = {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.CHIPS
                    }
                })
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    in_pool = function(self, args)
        for _, card in ipairs(G.playing_cards or {}) do
            if next(SMODS.get_enhancements(card)) then
                return true
            end
        end
    end,
}
