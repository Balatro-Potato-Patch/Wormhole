SMODS.Consumable {
    set = "Planet",
    key = "dum_moony",
    atlas = "DummiesPlanets",
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
        extra = {
            amount = 2,
            levels = 1,
        },
    },
    set_ability = function(self, card, initial, delay)
        -- Changes amount when there's more Poker-Hands:
        if G.GAME and G.GAME.hands then
            local total_hands = 0
            for handname, _ in pairs(G.GAME.hands) do total_hands = total_hands + 1 end
            card.ability.extra.amount = math.min(5.0, math.max(2.0, math.ceil((total_hands) / 6)))
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.amount,
                card.ability.extra.levels
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                delay(0.4)
                G.FUNCS.worm_run_moony_menu(card.ability.extra.amount)
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
                    SMODS.upgrade_poker_hands({
                        hands = G.GAME.worm_moony_selection.selection,
                        level_up = (card.ability.extra.levels or 1),
                        from = card
                    })
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

G.FUNCS.worm_run_moony_menu = function(amount)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
        definition = worm_create_moony_menu(amount)
    }
end

G.FUNCS.worm_can_moony_menu = function(e) end -- Obsolete.

function worm_create_moony_menu(amount)
    local poker_hands = {}
    for handname, _ in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(handname) then
            poker_hands[#poker_hands + 1] = handname
        end
    end

    -- Get randomly selected IDs:
    local list_ids = SEMBY_ranbinary_index(#poker_hands, (amount or 2), 'MOONY')

    -- Build UI-Tree
    local ui_buttons = {}
    for i = 1, #list_ids do
        local selected_hand = poker_hands[list_ids[i]] or "High Card"
        local uibutton = UIBox_button({
            button = "worm_moony_upgrade_hand",
            func = "worm_moony_can_upgrade_hand",
            ref_table = { selection = selected_hand },
            label = { localize(selected_hand, "poker_hands") },
            minw = 5,
            focus_args = { snap_to = true }
        })
        ui_buttons[#ui_buttons + 1] = uibutton
    end

    local t = create_UIBox_generic_options({
        infotip = localize("worm_moony_menu_tooltip"),
        contents = ui_buttons,
        back_label = localize('b_skip')
    })
    return t
end

G.FUNCS.worm_moony_upgrade_hand = function(e)
    G.GAME.worm_moony_selection = e.config.ref_table
    if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
    G.SETTINGS.paused = false
end

G.FUNCS.worm_moony_can_upgrade_hand = function(e) end

-- From Flowires Shimmerberry Mod: Quickly get unique Table IDs (using only one "Random")
function SEMBY_ranbinary_index(max_amount, intend, seed)
    local s = {}
    local r, n, k, v
    r = pseudorandom("SEMBY_ranbinary_" .. (seed or 'BASE'))
    n = intend
    k = max_amount
    for i = 1, max_amount do
        v = n / k
        if v >= r then
            r = r / (n / k)
            s[#s + 1] = i
            n = n - 1
        else
            r = r - (n / k)
            r = r / ((k - n) / k)
        end
        k = k - 1
        if n == 0 then break; end
    end
    if #s ~= intend then
        print('MISMATCH! "SEMBY_ranbinary_index()" expected ' .. intend .. ', got ' .. #s .. '!')
    end
    return s
end
