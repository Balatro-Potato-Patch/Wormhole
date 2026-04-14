SMODS.ConsumableType {
    key = 'ACME_Gadget',
    primary_colour = HEX('5B9BAA'),
    secondary_colour = HEX('FE5F55'),
    collection_rows = {5, 5},
    shop_rate = 1
}

-- hook for vouher 2 type shit
local acme_orig_start_dissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time, no_juice)
    if self.config.center.set == 'ACME_Gadget'
        and G.GAME.used_vouchers.v_worm_ACME_voucher_2
        and not self._acme_survival_checked then
        self._acme_survival_checked = true
        if pseudorandom('acme_gadget_survive') < G.GAME.probabilities.normal / 3 then
            card_eval_status_text(self, 'extra', nil, nil, nil, {
                message = localize('k_saved_ex'),
                colour = G.C.GREEN
            })
            return
        end
    end
    return acme_orig_start_dissolve(self, dissolve_colours, silent, dissolve_time, no_juice)
end
