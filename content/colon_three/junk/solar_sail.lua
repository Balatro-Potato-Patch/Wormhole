if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Consumable {
    set = "JunkSet",
    key = "ct_solar_sail",
    atlas = "ct_derelict",
    pos = { x = 1, y = 1 },
    config = {
        extra = {
            junk_num = 2,
            cleanup_num = 4,
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
        clean_func = function(self, card, cards, clean_up)
            for i = 1, math.min(2, #cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local edition = SMODS.poll_edition { key = "solar_sail", no_negative = true, guaranteed = true, }
                        cards[i]:set_edition(edition, true)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        end
    },
    can_use = Wormhole.COLON_THREE.junk_can_use(),
    ppu_coder = {"notmario"},
    ppu_artist = {"notmario"},
    ppu_team = {":3"}
}
