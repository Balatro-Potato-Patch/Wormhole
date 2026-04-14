SMODS.Joker {
    ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'Shinku'},
    ppu_coder = {'Cyan'},
    key = 'mrrp_alien_cat',
    atlas = "mrrp",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = {'cat', 'space'},
    config = {
        extra = {
            odds = 3,
            rank = "3"
        }
    },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'worm_mrrp_aliencat')
        return {
            vars = {numerator, denominator, localize(card.ability.extra.rank, "ranks"), localize("planet", "labels")}
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            local function is_rank(card, rank)
                if rank=="3" then
                    return card:is_3()
                else   
                    if card:get_id() == SMODS.Ranks[rank].id then
                        return 1
                    else
                        return false
                    end
                end
            end
            if is_rank(context.other_card, card.ability.extra.rank) then
                local triggered
                for i = 1, is_rank(context.other_card, card.ability.extra.rank) do
                    if SMODS.pseudorandom_probability(card, 'worm_mrrp_aliencat_' .. i, 1, card.ability.extra.odds) and
                        #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        triggered = true
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.add_card({
                                    set = "Planet"
                                })
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                        SMODS.calculate_effect({
                            message = localize('k_plus_planet'),
                            colour = G.C.SECONDARY_SET.Planet,
                            effect = true
                        }, context.blueprint and context.blueprint_card or card)
                    end
                end
                return nil, triggered
            end
        end
    end
}
