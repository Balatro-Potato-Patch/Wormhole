SMODS.Atlas {
    key = 'euda_roadsidepicnicatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/RoadsidePicnic.png', --Update with actual art
}

SMODS.Joker {
    key = "euda_roadsidepicnic",
    atlas = 'euda_roadsidepicnicatlas',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    discovered = true,
    ppu_team = {"TeamEudaimonia"},
    ppu_coder = {'M0xes'},
    ppu_artist = {'Jewel'},
    blueprint_compat = false,
    config = { extra= { currval = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.currval } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + card.ability.extra.currval
        G.GAME.current_round.reroll_cost = G.GAME.current_round.reroll_cost + card.ability.extra.currval
        for _, shop_card in ipairs(G.shop_jokers and G.shop_jokers.cards or {}) do
            if (shop_card.cost < card.ability.extra.currval) then
                shop_card.ability.worm_euda_deficit = shop_card.ability.worm_euda_deficit or 0
                shop_card.ability.worm_euda_deficit = shop_card.ability.worm_euda_deficit + (context.card.cost - card.ability.extra.currval)
            end
            shop_card.cost = math.max(0, shop_card.cost - card.ability.extra.currval)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - card.ability.extra.currval
        G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost - card.ability.extra.currval)
        for _, shop_card in ipairs(G.shop_jokers and G.shop_jokers.cards or {}) do
            if shop_card.ability.worm_euda_deficit then
                shop_card.ability.worm_euda_deficit = shop_card.ability.worm_euda_deficit + card.ability.extra.currval
                if shop_card.ability.worm_euda_deficit >= 0 then
                    shop_card.cost = shop_card.ability.worm_euda_deficit
                    shop_card.ability.worm_euda_deficit = nil
                end
            else
                shop_card.cost = shop_card.cost + card.ability.extra.currval
            end
        end
    end,
    calculate = function(self, card, context)
        if context.reroll_shop then
            card.ability.extra.currval = card.ability.extra.currval + 1
            G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + 1
            G.GAME.current_round.reroll_cost = G.GAME.current_round.reroll_cost + 1
            for _, shop_card in ipairs(G.shop_jokers and G.shop_jokers.cards or {}) do
                if (shop_card.cost < 1) then
                    shop_card.ability.worm_euda_deficit = shop_card.ability.worm_euda_deficit or 0
                    shop_card.ability.worm_euda_deficit = shop_card.ability.worm_euda_deficit + (shop_card.cost - 1)
                end
                shop_card.cost = math.max(0, shop_card.cost - 1)
            end
            save_run()
        end
        if context.modify_shop_card then
            if (context.card.cost < card.ability.extra.currval) then
                context.card.ability.worm_euda_deficit = context.card.ability.worm_euda_deficit or 0
                context.card.ability.worm_euda_deficit = context.card.ability.worm_euda_deficit + (context.card.cost - card.ability.extra.currval)
            end
            context.card.cost = math.max(0, context.card.cost - card.ability.extra.currval)
        end
    end,
}
