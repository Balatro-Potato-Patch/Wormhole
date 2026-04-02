SMODS.Consumable {
    set = "Planet",
    key = "dum_moony",
    pos = { x = 0, y = 0 },
    wormhole_pos_extra = { x = 0, y = 2 },
    wormhole_anim = {
        { x = 0,                            y = 0, t = 5 },
        { xrange = { first = 1, last = 5 }, y = 0, t = 0.1 },
        { x = 0,                            y = 1, t = 0.1 },
        { x = 1,                            y = 1, t = 1 },
        { x = 2,                            y = 1, t = 0.1 },
        { x = 3,                            y = 1, t = 1 },
        { x = 2,                            y = 1, t = 0.1 },
        { x = 1,                            y = 1, t = 1 },
        { xrange = { first = 4, last = 5 }, y = 1, t = 0.1 },
        { xrange = { first = 4, last = 5 }, y = 1, t = 0.1 },
        { xrange = { first = 4, last = 5 }, y = 1, t = 0.1 },
        { x = 0,                            y = 0, t = 5 },
    },
    wormhole_anim_extra = {
        { xrange = { first = 0, last = 4 }, y = 2, t = 0.2 }
    },
    wormhole_extra_wiggle = true,
    config = {
        extra = { levels = 1 },
    },
    atlas = "DummiesPlanets",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels } }
    end,

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                delay(0.4)
                G.FUNCS.worm_run_moony_menu()
                return true
            end
        }))

        delay(0.4)
        G.E_MANAGER:add_event(Event({
            func = function()
                if not G.GAME.worm_moony_selection then
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Planet,
                        align = (G.STATE == G.STATES.PLANET_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.PLANET_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            delay(0.6)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                else
                    SMODS.upgrade_poker_hands({ hands = G.GAME.worm_moony_selection.selection, level_up = 1, from = card })
                    delay(0.6)
                end
                G.GAME.worm_moony_selection = nil
                return true
            end
        }))
    end,
    pronouns = "she_her",

    ppu_team = { "dummies" },
    ppu_artist = { "ghostsalt" },
    ppu_coder = { "ghostsalt" }
}

G.FUNCS.worm_run_moony_menu = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
        definition = worm_create_moony_menu()
    }
end

G.FUNCS.worm_can_moony_menu = function(e)

end

function worm_create_moony_menu()
    local poker_hands = {}
    for handname, _ in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(handname) then
            poker_hands[#poker_hands + 1] = handname
        end
    end

    local first_hand = pseudorandom_element(poker_hands, pseudoseed("moonyhandone")) or "High Card"
    local first_hand_button = UIBox_button({
        button = "worm_moony_upgrade_hand",
        func = "worm_moony_can_upgrade_hand",
        ref_table = { selection = first_hand },
        label = { localize(first_hand, "poker_hands") },
        minw = 5,
        focus_args = { snap_to = true }
    })

    poker_hands = {}
    for handname, _ in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(handname) and first_hand ~= handname then
            poker_hands[#poker_hands + 1] = handname
        end
    end

    local second_hand = pseudorandom_element(poker_hands, pseudoseed("moonyhandtwo")) or "High Card"
    local second_hand_button = UIBox_button({
        button = "worm_moony_upgrade_hand",
        func = "worm_moony_can_upgrade_hand",
        ref_table = { selection = second_hand },
        label = { localize(second_hand, "poker_hands") },
        minw = 5,
        focus_args = { snap_to = true }
    })

    local t = create_UIBox_generic_options({
        infotip = localize("worm_moony_menu_tooltip"),
        contents = {
            first_hand_button,
            second_hand_button
        }
    })
    return t
end

G.FUNCS.worm_moony_upgrade_hand = function(e)
    G.GAME.worm_moony_selection = e.config.ref_table

    if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
    G.SETTINGS.paused = false
end

G.FUNCS.worm_moony_can_upgrade_hand = function(e)

end
