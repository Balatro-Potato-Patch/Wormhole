if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Consumable {
    set = "JunkSet",
    key = "ct_manhole_cover",
    atlas = "ct_derelict",
    pos = { x = 0, y = 1 },
    config = {
        extra = {
            junk_num = 3,
            cleanup_num = 5,
            retrigger_mod = 1
        }
    },
    loc_vars = function(_,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_worm_ct_junk_card
        info_queue[#info_queue+1] = { key = "worm_clean_up_keyword", set="Other", specific_vars = { card.ability.extra.cleanup_num } }
        return {
            vars = {
                card.ability.extra.junk_num,
                card.ability.extra.cleanup_num,
                card.ability.extra.retrigger_mod
            }
        }
    end,
    use = Wormhole.COLON_THREE.junk_use {
        clean_func = function(self, card, cards, clean_up)
            (G.GAME.worm_c3_junk_stats or {}).retriggers = (G.GAME.worm_c3_junk_stats or {}).retriggers + card.ability.extra.retrigger_mod
            G.GAME.worm_c3_force_skips = (G.GAME.worm_c3_force_skips or 0) + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.4,
                func = function()
                    play_sound("multhit2", 0.5)
                    card:juice_up(0.3, 0.5)
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

-- based on Ortalab
local gfbch = G.FUNCS.blind_choice_handler
G.FUNCS.blind_choice_handler = function(e)
    gfbch(e)
    local _blind_choice_box = e.UIBox:get_UIE_by_ID('select_blind_button')
    if e.config.id ~= 'Boss' and _blind_choice_box and G.GAME.round_resets.blind_states[e.config.id] == 'Select' and G.GAME.worm_c3_force_skips and G.GAME.worm_c3_force_skips > 0 then
        _blind_choice_box.config.colour = G.C.UI.BACKGROUND_INACTIVE
        _blind_choice_box.config.button = nil
    end
end

local gfsb = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e, ...)
    gfsb(e, ...)
    G.GAME.worm_c3_force_skips = math.max((G.GAME.worm_c3_force_skips or 0) - 1, 0)
end
