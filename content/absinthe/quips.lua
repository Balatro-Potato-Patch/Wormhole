-- Astra Quips
SMODS.JimboQuip {
    key = 'lq_abs_astra',
    type = 'loss',
    extra = { ppu_dev = 'worm_theAstra' },
    filter = function(self, type)
        return true, {weight = 100}
    end
}

SMODS.JimboQuip {
    key = 'wq_abs_astra',
    type = 'win',
    extra = { ppu_dev = 'worm_theAstra' },
    filter = function(self, type)
        return true, {weight = 100}
    end
}
