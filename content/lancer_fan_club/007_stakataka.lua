local function emplace_stone_cards()
    if #SMODS.find_card("j_worm_lfc_stakataka") > 0 then
        for _, other_card in ipairs(G.playing_cards or {}) do
            if
                other_card.area == G.hand                                                                                                -- fucking awful hack
                and SMODS.has_enhancement(other_card, "m_stone")
                and not (other_card.ability and (other_card.ability.entr_marked_bypass or other_card.ability.worm_lfc_stakataka_bypass)) -- this shouldn't really be needed here but just in case
                and not other_card.highlighted
            then
                G.hand:remove_card(other_card)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        other_card:highlight()
                        return true
                    end
                }))
                G.play:emplace(other_card)
            end
        end
    end
end

if not (SMODS.Mods.Amulet or {}).can_load then
    local epi = evaluate_play_intro
    function evaluate_play_intro(...)
        emplace_stone_cards()
        return epi(...)
    end
else
    local ep = G.FUNCS.evaluate_play
    function G.FUNCS.evaluate_play(e, ...)
        emplace_stone_cards()
        return ep(e, ...)
    end
end

SMODS.Joker {
    key = "lfc_stakataka",
    atlas = "lfc_jokers",
    pos = { x = 3, y = 0 },

    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    demicoloncompat = false,

    attributes = {
        "enhancements",
        "hands",
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return {
            vars = {
                localize({ type = 'name_text', set = "Enhanced", key = "m_stone" }) or "Stone Card"
            }
        }
    end,

    in_pool = function(self, args)
        for _, card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(card, "m_stone") then
                return true
            end
        end
    end,

    dex_entry_key = "lfc_dex_stakataka",
    generate_ui = Wormhole.LFC_Util.generate_pokedex_entry_ui,

    ppu_coder = { "InvalidOS" }
}
