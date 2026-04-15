SMODS.ConsumableType {
    key = 'ACME_Gadget',
    primary_colour = HEX('5B9BAA'),
    secondary_colour = HEX('FE5F55'),
    collection_rows = { 5, 5 },
    shop_rate = 1
}


local _acme_orig_use_card = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
    local card = e.config.ref_table
    local injected = false

    if card
        and card.config and card.config.center
        and card.config.center.set == 'ACME_Gadget'
        and G.GAME and G.GAME.used_vouchers
        and G.GAME.used_vouchers.v_worm_ACME_voucher_2
        and not card.config.center.keep_on_use then
        if SMODS.pseudorandom_probability(card, 'acme_gadget_survive', 1, 2) then
            card.config.center.keep_on_use = function() return true end
            injected = true
        end
    end

    _acme_orig_use_card(e, mute, nosave)

    if injected then
        card.config.center.keep_on_use = nil

        card.ability.extra = copy_table(card.config.center.config.extra)

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_saved_ex'),
                    colour = G.C.GREEN
                })
                return true
            end
        }))
    end
end
