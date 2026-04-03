if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Consumable {
    set = "JunkSet",
    key = "asteroid_harvester",
    config = {
        extra = {
            junk_num = 2,
            cleanup_num = 2,
            dollars_earn = 15
        }
    },
    loc_vars = function(_,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_worm_junk_card
        return {
            vars = {
                card.ability.extra.junk_num,
                card.ability.extra.cleanup_num,
                card.ability.extra.dollars_earn
            }
        }
    end,
    use = Wormhole.COLON_THREE.junk_use(function(self, card)
        ease_dollars(card.ability.extra.dollars_earn)
    end, true),
    can_use = Wormhole.COLON_THREE.junk_can_use(),
    ppu_coder = {"lordruby"}
}