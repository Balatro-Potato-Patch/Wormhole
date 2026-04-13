SMODS.Joker {
    ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'SarcPot'},
    ppu_coder = {'Cyan'},
    key = 'mrrp_pallasite',
    atlas = "mrrp",
    pos = {
        x = 4,
        y = 0
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = {},
    config = {
        extra = {
            money = 1,
            hands = {}
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.money}
        }
    end,

    calculate = function(self, card, context)
        if (not context.blueprint) and context.poker_hand_changed and context.old_level and context.new_level and
            context.scoring_name and not card.ability.extra.hands[context.scoring_name] then
            card.ability.extra.hands[context.scoring_name] = true
            return {
                message = localize("k_active_ex"),
                colour = G.C.SECONDARY_SET.Planet
            }
        end
        if context.individual and context.cardarea == G.play and context.scoring_name and
            card.ability.extra.hands[context.scoring_name] then
            return {
                dollars = card.ability.extra.money,
                colour = G.C.MONEY,
                card = context.blueprint and context.blueprint_card or card,
                message_card = context.blueprint and context.blueprint_card or card
            }
        end
        if (not context.blueprint) and context.end_of_round and context.main_eval and not context.game_over then
            card.ability.extra.hands = {}
            return {
                message = localize('k_reset'),
                colour = G.C.SECONDARY_SET.Planet
            }
        end
    end
}
