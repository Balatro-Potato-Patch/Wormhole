SMODS.Joker {
    key = "riverboat_alien_blood",
    config = {
        extra = {
            xmult = 1.5,
            kills = 2
        }
    },
    rarity = 3,
    cost = 9,
    atlas = "worm_jokers",
    pos = { x = 6, y = 1 },
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    ppu_artist = { "snipey" },
    ppu_coder = { "blamperer" },
    ppy_team = { "riverboat" },
    attributes = { "xmult", "suit", "spades", "destroy_card" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.kills
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Spades", nil, nil) then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end

        if context.selling_self and not context.blueprint then
            local destroyable_cards = {}
            for _, v in ipairs(G.jokers.cards) do
                if v ~= card and not v.ability.eternal then
                    destroyable_cards[#destroyable_cards + 1] = v
                end
            end
            if #destroyable_cards > 0 then
                local destroyed = {}
                for i = 1, card.ability.extra.kills do
                    if #destroyable_cards == 0 then break end
                    local x, ix = pseudorandom_element(destroyable_cards)
                    destroyed[#destroyed + 1] = x
                    table.remove(destroyable_cards, ix)
                end
                SMODS.destroy_cards(destroyed)
            end
        end
    end
}
