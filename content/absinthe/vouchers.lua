

SMODS.Atlas {
    key = 'abs_vouchers',
    path = 'absinthe/abs_vouchers.png',
    px = 71,
    py = 95
}


SMODS.Voucher {
    key = 'abs_happy_hour',
    atlas = 'abs_vouchers',
    pos = {x = 0, y = 0},
    ppu_artist = { 'nixthatoneartist' },
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    redeem = function(self, card)
        G.GAME.abs_drinks_rate = 2
    end
}

SMODS.Voucher {
    key = 'abs_on_the_house',
    atlas = 'abs_vouchers',
    pos = {x = 1, y = 0},
    ppu_artist = { 'pangaea47' },
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    requires = {'v_worm_abs_happy_hour'}
}
