if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Consumable {
    set = "JunkSet",
    key = "ct_asteroid_harvester",
    atlas = "ct_derelict",
    pos = { x = 3, y = 0 },
    config = {
        extra = {
            junk_num = 2,
            cleanup_num = 2,
            dollars_earn = 15
        }
    },
    loc_vars = function(_,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_worm_ct_junk_card
        info_queue[#info_queue+1] = { key = "worm_clean_up_keyword", set="Other", specific_vars = { card.ability.extra.cleanup_num } }
        return {
            vars = {
                card.ability.extra.junk_num,
                card.ability.extra.cleanup_num,
                card.ability.extra.dollars_earn
            }
        }
    end,
    use = Wormhole.COLON_THREE.junk_use {
        clean_func = function(self, card, cards, clean_up)
            ease_dollars(card.ability.extra.dollars_earn)
        end,
    },
    can_use = Wormhole.COLON_THREE.junk_can_use(),
    ppu_coder = {"lordruby"},
    ppu_artist = {"notmario"},
    ppu_team = {":3"}
}
