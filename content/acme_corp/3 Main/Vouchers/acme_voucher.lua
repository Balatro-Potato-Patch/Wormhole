SMODS.Voucher {
    key = 'ACME_voucher',
    atlas = Atlas_AcmeVouchers.key,
    pos = { x = 0, y = 0 },
    config = { extra = { rate_increase = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rate_increase } }
    end,


}
