local function emplace_stone_cards()
    if #SMODS.find_card("j_worm_lfc_stakataka") > 0 then
        local stones = {}
        -- has to be done with pairs because ipairs fails to iterate properly here, thanks localthunk
        for i, other_card in pairs(G.hand and G.hand.cards or {}) do
            if
                SMODS.has_enhancement(other_card, "m_stone")
                and not (other_card.ability and (other_card.ability.entr_marked_bypass or other_card.ability.worm_lfc_stakataka_bypass)) -- this shouldn't really be needed here but just in case
                and not other_card.highlighted
            then
                stones[#stones+1] = {idx = i, card = other_card}
            end
        end
        -- ensure the order is the same as the hand order
        table.sort(stones, function(a, b) return a.idx < b.idx end)
        -- emplace everything
        for _, stone in ipairs(stones) do
            G.hand:remove_card(stone.card)
            G.E_MANAGER:add_event(Event({
                func = function()
                    stone.card:highlight()
                    return true
                end,
            }))
            G.play:emplace(stone.card)
        end
    end
end

-- hooks amulet's evaluate_play_info if amulet is installed, else hooks G.FUNCS.evaluate_play
if (SMODS.Mods.Amulet or {}).can_load then
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
    pos = { x = 4, y = 0 },

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
    config = {extra={shiny=false}},
    set_ability = function(self, card, initial, delay_sprites) card.ability.extra.shiny = pseudorandom("lfc_stakataka_shiny", 1, 16) <= 1 end,
    update = function(self, card, dt) if not Wormhole.LFC_Util.card_obscured(card) then card.children.center:set_sprite_pos({x = card.ability.extra.shiny and 5 or 4, y = 0}) end end,
    dex_entry_key = "lfc_dex_stakataka",
    generate_ui = Wormhole.LFC_Util.generate_pokedex_entry_ui,

    ppu_coder = { "InvalidOS" },
    ppu_artist = {"J8-Bit"},
    ppu_team = { "Lancer Fan Club" },
}
