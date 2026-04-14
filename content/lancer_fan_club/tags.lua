-- Tags

-- Laser Tag
SMODS.Tag {

    key = "lfc_laser",
    atlas = "lfc_tags",
    pos = { x = 0, y = 0 },
    min_ante = 3,
    config = {
        rank = nil
    },
    loc_vars = function(self, info_queue, tag)
        return {
            vars = {
                tag.ability.rank and localize(tag.ability.rank.key, 'ranks') or localize('k_lfc_brackets_rank')
            }
        }
    end,
    set_ability = function(self, tag)
        local new_rank = pseudorandom_element(SMODS.Ranks, pseudoseed('lfc_laser'), {
            in_pool = function(v, args)
                for i, v2 in ipairs(G.playing_cards) do
                    if v2:get_id() == v.id then return true end
                end
                return false
            end
        }) or SMODS.Ranks.Ace
        tag.ability.rank = new_rank
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' or context.type == 'round_start_bonus' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            -- go nuts
            tag:yep('+',
                G.C.RED,
                function()
                    G.CONTROLLER.locks[lock] = nil
                    -- actual behavior
                    local cards_to_destroy = {}
                    if G.playing_cards then
                        for _, playing_card in ipairs(G.playing_cards) do
                            if playing_card:get_id() == tag.ability.rank.id then
                                table.insert(cards_to_destroy, playing_card)
                            end
                        end
                    end
                    if #cards_to_destroy > 0 then
                        SMODS.destroy_cards(cards_to_destroy, true, true, false)
                    end
                    return true
                end
            )
            -- trigger
            tag.triggered = true
            return true
        end
    end,
    ppu_artist = { "J8-Bit" },
    ppu_coder = { "J8-Bit" },
    ppu_team = { "Lancer Fan Club" },

}
