-- Joker's Guide to the Galaxy
SMODS.Joker {
    key = "lfc_hitchhiker",
    blueprint_compat = true,
    demicoloncompat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 13,
    atlas = "lfc_jokers",
    ppu_coder = { "J8-Bit" },
    ppu_artist = { "J8-Bit" },
    ppu_team = { "Lancer Fan Club" },
    pos = { x = 2, y = 2 },
    discovered = false,
    config = { extra = { ranks = { "4", "2" } } },
    attributes = {

    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                SMODS.Mods["Wormhole"].name,
                localize(card.ability.extra.ranks[1], 'ranks'),
                localize(card.ability.extra.ranks[2], 'ranks'),
                colours = {
                    SMODS.Mods["Wormhole"].badge_colour,
                    SMODS.Mods["Wormhole"].badge_text_colour,
                }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local two_check = false
            local four_check = false
            for i = 1, #context.scoring_hand do
                if not context.scoring_hand[i].debuff then
                    if context.scoring_hand[i]:get_id() == SMODS.Ranks[card.ability.extra.ranks[2]].id then
                        two_check = true
                    elseif context.scoring_hand[i]:get_id() == SMODS.Ranks[card.ability.extra.ranks[1]].id then
                        four_check = true
                    end
                end
            end
            if two_check and four_check then
                local jokers_to_create = math.min(1,
                    G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                if jokers_to_create > 0 then
                    local my_rarity = "Common"
                    G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_key = SMODS.poll_object {
                                type = "Joker",
                                filter = function(pool)
                                    local empty_pool = true
                                    for i, v in ipairs(pool) do
                                        if not (G.P_CENTERS[v.key] and (G.P_CENTERS[v.key].original_mod or {}).id == "Wormhole") then
                                            v.key = "UNAVAILABLE"
                                        end
                                        if v.key ~= "UNAVAILABLE" then
                                            empty_pool = false
                                        end
                                    end
                                    if empty_pool then
                                        pool[#pool + 1] = { type = "Joker", key = "j_joker" }
                                    end
                                    return pool
                                end
                            }
                            if joker_key ~= nil then
                                SMODS.add_card {
                                    key = joker_key
                                }
                                my_rarity = joker_key.rarity
                            end
                            G.GAME.joker_buffer = 0
                            return true
                        end
                    }))
                    return {
                        message = localize('k_plus_joker'),
                        colour = G.C.RARITY[my_rarity],
                    }
                end
            end
        end
    end,
}
