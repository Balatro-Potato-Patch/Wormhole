SMODS.Consumable{
    key = "tlr_const_orion",
    set = 'worm_tlr_constellation',
    atlas = "tlr_const",
    pos = {x=0, y=0},
    config = {rerolls = {0, 0, 1, 2}},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.rerolls[card.ability.tier]}}
    end,
    can_use = function (self, card)
        return G.STATE == G.STATES.BLIND_SELECT
    end,
    use = function (self, card, area, copier)
        if card.ability.tier == 1 then
            G.from_boss_tag = true
            G.FUNCS.reroll_boss()
        else
            G.FUNCS.Wormhole_TLR_orion{
                rerolls_left = card.ability.rerolls[card.ability.tier],
                allow = {
                    non_boss = card.ability.tier == 4,
                    standard = card.ability.tier == 4 or not ((G.GAME.round_resets.ante)%G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2),
                    showdown = card.ability.tier == 4 or ((G.GAME.round_resets.ante)%G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2)
                }
            }
        end
    end
}