if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Consumable {
    set = "Spectral",
    hidden = true,
    soul_set = "JunkSet",
    key = "ct_accretion_disk",
    atlas = "ct_derelict",
    pos = { x = 4, y = 1 },
    config = {
        extra = {
            xmult_mod = 0.3,
            dollars_mod = 1,
            increase_xvals = 0.5,
        }
    },
    loc_vars = function(_,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_worm_ct_junk_card
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.dollars_mod,
                card.ability.extra.increase_xvals,
            }
        }
    end,
    use = function(self, card)
        if G.GAME.worm_c3_junk_stats then
            G.GAME.worm_c3_junk_stats.x_mult = G.GAME.worm_c3_junk_stats.x_mult + card.ability.extra.xmult_mod
            G.GAME.worm_c3_junk_stats.money = G.GAME.worm_c3_junk_stats.money + card.ability.extra.dollars_mod
            G.GAME.worm_c3_junk_stats.x_hand_stats = G.GAME.worm_c3_junk_stats.x_hand_stats + card.ability.extra.increase_xvals
        end

        if #G.hand.cards > 0 then
            local nonjunks = {}
            for _, _card in ipairs(G.hand.cards) do
                if not SMODS.has_enhancement(_card, "m_worm_ct_junk_card") then
                    nonjunks[#nonjunks + 1] = _card
                end
            end
            Wormhole.COLON_THREE.flip_cards_events(nonjunks, "card1", 1.15, -1)
            for _, playing_card in ipairs(nonjunks) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        playing_card:set_ability("m_worm_ct_junk_card")
                        return true
                    end
                }))
            end
            Wormhole.COLON_THREE.flip_cards_events(nonjunks, "tarot2", 0.85, 1)
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.4,
            func = function()
                play_sound("multhit2", 1.4)
                play_sound("multhit2", 0.7)
                play_sound("multhit2", 0.35)
                play_sound("multhit2", 0.175)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(...) return true end,
    ppu_coder = {"notmario"},
    ppu_artist = {"notmario"},
    ppu_team = {":3"}
}