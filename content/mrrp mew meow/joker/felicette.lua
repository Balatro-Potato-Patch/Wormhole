--[[ Scaling version ] ]
SMODS.Joker {
    key = 'felicette',
    atlas = "mrrp",
    pos = {
        x = 4,
        y = 1
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = {'cat'},
    config = {
        extra = {
            mult = 0,
            mult_mod = 3,
            hands = {}
        }
    },
    loc_vars = function(self, info_queue, card)
        local mult = card.ability.extra.mult
        local upgrades = 0
        local scalar = card.ability.extra.mult_mod
        local indeck = false
        for _, v in pairs(SMODS.get_card_areas('jokers')) do
            if card.area == v then
                indeck = true
            end
        end
        if not indeck then
            for _, v in pairs(G.GAME.hands) do
                if v.level and v.level > 1 then
                    upgrades = upgrades + 1
                end
            end
        end
        local total = not indeck and upgrades * scalar or mult
        return {
            vars = {
                (scalar < 0 and "-" or "+") .. scalar,
                (total < 0 and "-" or "+") .. total
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.hands) do
            if v.level and v.level > 1 then
                card.ability.extra.hands[k] = true
                SMODS.scale_card(card, {
                    ref_value = "mult",
                    scalar_value = "mult_mod",
                    no_message = true
                })
            end
        end
    end,

    calculate = function(self, card, context)
        if context.poker_hand_changed and context.new_level and not context.blueprint then
            if context.new_level > 1 and not card.ability.extra.hands[context.scoring_name] then
                card.ability.extra.hands[context.scoring_name] = true
                SMODS.scale_card(card, {
                    ref_value = "mult",
                    scalar_value = "mult_mod",
                    no_message = true,
                })
            elseif context.new_level <= 1 and card.ability.extra.hands[context.scoring_name] then
                card.ability.extra.hands[context.scoring_name] = nil
                SMODS.scale_card(card, {
                    ref_value = "mult",
                    scalar_value = "mult_mod",
                    operation = '-',
                    no_message = true,
                })
            end
        end
        if context.joker_main and card.ability.extra.mult ~= 0 then
            return {
                mult = card.ability.extra.mult,
                card = context.blueprint and context.blueprint_card or card,
                message_card = context.blueprint and context.blueprint_card or card
            }
        end
    end
}
--[[ Simple version ]]
SMODS.Joker {
    ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'Cyan'},
    ppu_coder = {'Cyan'},
    key = 'mrrp_felicette',
    atlas = "mrrp",
    pos = {
        x = 4,
        y = 1
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = {'cat'},
    config = {
        extra = {
            mult_mod = 3,
        }
    },
    loc_vars = function(self, info_queue, card)
        local scalar = card.ability.extra.mult_mod
        local upgrades = 0
        for _, v in pairs(G.GAME.hands) do
            if v.level and v.level > 1 then
                upgrades = upgrades + 1
            end
        end
        local total = scalar * upgrades
        return {
            vars = {
                Wormhole.mrrp_signed(scalar),
                Wormhole.mrrp_signed(total)
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.mult ~= 0 then
            local upgrades = 0
            for _, v in pairs(G.GAME.hands) do
                if v.level and v.level > 1 then
                    upgrades = upgrades + 1
                end
            end
            return {
                mult = card.ability.extra.mult_mod * upgrades,
                card = context.blueprint and context.blueprint_card or card,
                message_card = context.blueprint and context.blueprint_card or card
            }
        end
    end
}