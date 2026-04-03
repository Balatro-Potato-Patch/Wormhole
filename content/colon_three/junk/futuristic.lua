if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Consumable {
    set = "JunkSet",
    key = "futuristic",
    config = {
        extra = {
            junk_num = 3,
            cleanup_num = 3,
            chips_mod = 10
        }
    },
    loc_vars = function(_,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_worm_junk_card
        return {
            vars = {
                card.ability.extra.junk_num,
                card.ability.extra.cleanup_num,
                card.ability.extra.chips_mod
            }
        }
    end,
    use = Wormhole.COLON_THREE.junk_use {
        clean_func = function(self, card, cards, clean_up)
            (G.GAME.worm_c3_junk_stats or {}).chips = (G.GAME.worm_c3_junk_stats or {}).chips + card.ability.extra.chips_mod
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.4,
                func = function()
                    play_sound("xchips", 0.9)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end,
    },
    can_use = Wormhole.COLON_THREE.junk_can_use(),
    ppu_coder = {"notmario"}
}