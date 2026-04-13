if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Consumable {
    set = "JunkSet",
    key = "ct_trash_compactor",
    atlas = "ct_derelict",
    pos = { x = 3, y = 1 },
    config = {
        extra = {
            junk_num = 2,
            cleanup_num = 2
        }
    },
    loc_vars = function(_,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_worm_ct_junk_card
        info_queue[#info_queue+1] = { key = "worm_clean_up_keyword", set="Other", specific_vars = { card.ability.extra.cleanup_num } }
        return {
            vars = {
                card.ability.extra.junk_num,
                card.ability.extra.cleanup_num
            }
        }
    end,
    use = Wormhole.COLON_THREE.junk_use {
        clean_func = function(self, card, cards)
            local last_card = cards[#cards]
            last_card.stay_junk = true
            -- we have to do this first
            -- because if we dont then it gets converted too early
            local junk_mult_count = 0
            for _, card in ipairs(cards) do
                -- if you use this on a q. enhanced junk card uhh
                -- fuck you i guess
                junk_mult_count = junk_mult_count + card.ability.extra.junk_mult
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.25,
                func = function()
                    -- based on the morefluff farm merge valley joker

                    local new_stats = {
                        perma_bonus = 0,
                        perma_mult = 0,
                        perma_x_chips = 0,
                        perma_x_mult = 0,

                        perma_h_chips = 0,
                        perma_h_mult = 0,
                        perma_h_x_chips = 0,
                        perma_h_x_mult = 0,

                        perma_p_dollars = 0,
                        perma_h_dollars = 0,
                        
                        perma_repetitions = 0,
                        perma_score = 0,
                        perma_h_score = 0,
                        perma_x_score = 0,
                        perma_h_x_score = 0,
                        perma_blind_size = 0,
                        perma_h_blind_size = 0,
                        perma_x_blind_size = 0,
                        perma_h_x_blind_size = 0,

                        -- slib compat
                        slib_perma_xlog_chips = 0,
                        slib_perma_h_xlog_chips = 0,
                        slib_perma_xlog_mult = 0,
                        slib_perma_h_xlog_mult = 0,
                        slib_perma_plus_asc = 0,
                        slib_perma_h_plus_asc = 0,
                        slib_perma_x_asc = 0,
                        slib_perma_h_x_asc = 0,
                        slib_perma_exp_asc = 0,
                        slib_perma_h_exp_asc = 0,
                        slib_perma_e_chips = 0,
                        slib_perma_h_e_chips = 0,
                        slib_perma_e_mult = 0,
                        slib_perma_h_e_mult = 0,
                    }

                    local edition = nil
                    local seal = nil

                    for _, v in ipairs(cards) do
                        for k, _ in pairs(new_stats) do -- the devious reverse iterator?
                            new_stats[k] = new_stats[k] + (v.ability[k] or 0)
                        end

                        if v.seal then
                            seal = v.seal
                        end
                        if v.edition then
                            edition = v.edition
                        end
                    end

                    -- last_card:set_ability("m_worm_junk_card")
                    if edition and edition ~= last_card.edition then
                        last_card:set_edition(edition)
                    end
                    if seal and seal ~= last_card.seal then
                        last_card:set_seal(seal)
                    end
                    for k, _ in pairs(new_stats) do
                        last_card.ability[k] = new_stats[k]
                    end

                    local destroyed_cards = {}

                    for _, v in ipairs(cards) do
                        if v ~= last_card then
                            destroyed_cards[#destroyed_cards + 1] = v
                        end
                    end

                    last_card.ability.extra.junk_mult = junk_mult_count

                    SMODS.destroy_cards(destroyed_cards, nil, true, true)
                    return true
                end
            }))
        end,
    },
    can_use = Wormhole.COLON_THREE.junk_can_use(),
    ppu_coder = {"notmario"},
    ppu_artist = {"notmario"},
    ppu_team = {":3"}
}
