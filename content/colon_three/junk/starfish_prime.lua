if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Consumable {
    set = "JunkSet",
    key = "ct_starfish_prime",
    atlas = "ct_derelict",
    pos = { x = 4, y = 0 },
    config = {
        extra = {
            junk_num = 2,
            cleanup_num = 5,
            destroy = 2,
            increase_xvals = 0.25
        }
    },
    loc_vars = function(_,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_worm_ct_junk_card
        info_queue[#info_queue+1] = { key = "worm_clean_up_keyword", set="Other", specific_vars = { card.ability.extra.cleanup_num } }
        return {
            vars = {
                card.ability.extra.junk_num,
                card.ability.extra.cleanup_num,
                card.ability.extra.increase_xvals,
                card.ability.extra.destroy,
            }
        }
    end,
    use = Wormhole.COLON_THREE.junk_use {
        clean_func = function(self, card, cards, clean_up)
            (G.GAME.worm_c3_junk_stats or {}).x_hand_stats = (G.GAME.worm_c3_junk_stats or {}).x_hand_stats + card.ability.extra.increase_xvals
            
            local destroyed_cards = {}
            local temp_hand = {}

            for _, playing_card in ipairs(cards) do temp_hand[#temp_hand + 1] = playing_card end
            table.sort(temp_hand,
                function(a, b)
                    return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
                end
            )

            pseudoshuffle(temp_hand, 'starfish_prime')

            for i = 1, card.ability.extra.destroy do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            SMODS.destroy_cards(destroyed_cards)
        end,
    },
    can_use = Wormhole.COLON_THREE.junk_can_use(),
    ppu_coder = {"meta", "notmario"},
    ppu_artist = {"notmario"},
    ppu_team = {":3"}
}
