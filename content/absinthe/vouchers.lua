SMODS.Voucher {
    key = 'abs_star_tap',
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    redeem = function(self, card)
        G.GAME.abs_drinks_rate = 2
    end
}

SMODS.Voucher {
    key = 'abs_on_the_house',
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    requires = {'v_worm_abs_star_tap'},
    calculate = function(self, card, context)
        if context.modify_shop_card and context.card.ability.set == 'abs_drinks' then
            context.card.cost = 0
        end
    end
}
