SMODS.Voucher {
    key = 'ACME_voucher_1',
    atlas = Atlas_AcmeVouchers.key,
    pos = { x = 0, y = 0 },
    ppu_coder = { 'Basil_Squared' },
	ppu_artist = { 'RadiationV2' },
    config = { extra = {} },
    redeem = function(self, card)
        SMODS.ConsumableTypes['ACME_Gadget'].shop_rate = 2
    end
}

SMODS.Voucher {
    key = 'ACME_voucher_2',
    atlas = Atlas_AcmeVouchers.key,
    requires = { 'v_worm_ACME_voucher_1' },
    pos = { x = 1, y = 0 },
    ppu_coder = { 'Basil_Squared' },
	ppu_artist = { 'RadiationV2' },
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME and G.GAME.probabilities.normal or 1, 2 } }
    end,
    redeem = function(self, card)
        --SMODS.ConsumableTypes['ACME_Gadget'].shop_rate = 4
    end
}
