SMODS.Atlas {
    key = 'euda_ton618atlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/Ton618.png', --Update with actual art
}
SMODS.Joker {
    key = "euda_ton618",
    atlas = 'euda_ton618atlas',
    pos = { x = 0, y = 0 },
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    cost = 8,
    discovered = true,
    config = {extra= {xmult=2, enhanced = 0} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xmult} }
    end,
    ppu_coder = {'M0xes'},
    ppu_team = {"TeamEudaimonia"},
    ppu_artist = {'LasagnaFelidae'},
    attributes = {"enhancements", "xmult", "destroy_card", "space"},
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and next(SMODS.get_enhancements(context.other_card)) then
            context.other_card.worm_marked_by_ton = true
            card.ability.extra.enhanced = card.ability.extra.enhanced + 1
        end

        if context.joker_main and card.ability.extra.enhanced >= 2 then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.destroy_card and context.destroy_card.worm_marked_by_ton and context.cardarea == G.play then
            if card.ability.extra.enhanced >= 2 then
                return {
                    remove = true
                }
            else
                context.destroy_card.worm_marked_by_ton = nil
            end
        end

        if context.after then
            card.ability.extra.enhanced = 0
        end
    end
}