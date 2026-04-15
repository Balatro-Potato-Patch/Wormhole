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
    config = {extra= {xmult=2} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xmult} }
    end,
    ppu_coder = {'M0xes'},
    ppu_team = {"TeamEudaimonia"},
    ppu_artist = {'LasagnaFelidae'},
    calculate = function(self, card, context)
        if context.joker_main then
            local tot_enchanted = 0
            for _, p_card in ipairs(context.scoring_hand or {}) do
                if next(SMODS.get_enhancements(p_card)) then
                    tot_enchanted = tot_enchanted + 1
                end
            end
            if tot_enchanted then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
        if context.destroy_card and context.cardarea == G.play then
            if not next(SMODS.get_enhancements(context.destroy_card)) then return end
            local tot_enchanted = 0
            for _, p_card in ipairs(context.scoring_hand or {}) do
                if next(SMODS.get_enhancements(p_card)) then
                    tot_enchanted = tot_enchanted + 1
                end
            end
            if tot_enchanted then
                return {
                    remove = true
                }
            end
        end
    end
}