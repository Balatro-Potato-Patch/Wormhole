SMODS.Joker {
    ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'SarcPot'},
    ppu_coder = {'Cyan'},
    key = 'mrrp_cookie_cat',
    atlas = "mrrp",
    pos = {
        x = 0,
        y = 1
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    attributes = {'cat', 'food'},
    config = {
        extra = {
            level = 3,
            level_mod = 1
        }
    },
    loc_vars = function(self, info_queue, card)
    --  info_queue[#info_queue+1] = { key="worm_mrrp_cookie_cat_song", set="Other" }
        return {
            vars = {Wormhole.mrrp_signed(card.ability.extra.level),
                    Wormhole.mrrp_signed(card.ability.extra.level_mod, true)}
        }
    end,

    calculate = function(self, card, context)
        if context.before then
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.SECONDARY_SET.Planet,
                func = function()
                    SMODS.upgrade_poker_hands({
                        hands = context.scoring_name,
                        level_up = card.ability.extra.level,
                        from = context.blueprint and context.blueprint_card or card
                    })
                end
            }
        end
        if context.after then
            SMODS.upgrade_poker_hands({
                hands = context.scoring_name,
                level_up = -card.ability.extra.level,
                from = context.blueprint and context.blueprint_card or card
            })
            return nil, true
        end
        if context.end_of_round and context.main_eval then
            if card.ability.extra.level - card.ability.extra.level_mod <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                SMODS.scale_card(card, {
                    ref_value = "level",
                    scalar_value = "level_mod",
                    operation = '-',
                    message_key = "a_level_minus",
                    message_colour = G.C.SECONDARY_SET.Planet
                })
                return nil, true
            end
        end
    end
}
