local function count_score_digits(score)
    if not score then return 1 end
    local s = tostring(score)
    local _, exp = s:match("([%d%.]+)[eE]%+?(%d+)")
    if exp then return tonumber(exp) + 1 end
    s = s:match("^%-?(%d+)") or "0"
    if s == "0" then return 1 end
    return #s
end

SMODS.Consumable {
    key = 'acme_printer',
    set = 'ACME_Gadget',
    atlas = 'ACME_gadgets',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },
    ppu_coder = { 'Basil_Squared' },
    ppu_artist = { 'RadiationV2' },
    config = {

        extra = { best_hand = 0, active = false, }
    },
    loc_vars = function(self, info_queue, card)
        local digits = count_score_digits(card.ability.extra.best_hand)
        if not card.ability.extra.active then
            return { vars = { digits } }
        else
            return { key = self.key .. '_alt', vars = { digits } }
        end
    end,
    can_use = function(self, card)
        return card.ability.extra.active
    end,

    calculate = function(self, card, context)
        if context.final_scoring_step then
            print("Hit final scoring")


            local final_chips, final_mult = hand_chips, mult
            local nu_chips, nu_mult = G.GAME.selected_back:trigger_effect({
                context = 'final_scoring_step',
                chips = hand_chips,
                mult = mult
            })
            if nu_chips then final_chips = nu_chips end
            if nu_mult then final_mult = nu_mult end
            local score = final_chips * final_mult


            if score > (card.ability.extra.best_hand or 0) then
                print('set best_hand to ' .. score)
                card.ability.extra.best_hand = score
            end


            if score >= G.GAME.blind.chips and not card.ability.extra.active then
                print('active!')
                card.ability.extra.active = true
                return {
                    message = localize('k_active_ex'),
                    colour = G.C.RED
                }
            end
        end

        -- reset each blind
        if context.setting_blind then
            print("reset")
            card.ability.extra.active = false
        end
    end,

    use = function(self, card, area, copier)
        local digits = count_score_digits(card.ability.extra.best_hand)
        local payout = digits * 5

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for i = 1, digits do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.08,
                func = function()
                    play_sound('coin3', 0.7 + i * 0.03)
                    return true
                end
            }))
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                ease_dollars(payout)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('$') .. payout,
                    colour = G.C.MONEY,
                })
                return true
            end
        }))

        delay(0.5)
    end,
}
