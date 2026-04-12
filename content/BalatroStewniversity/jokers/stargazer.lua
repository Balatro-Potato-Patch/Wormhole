SMODS.Joker {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "dottykitty" },
    ppu_coder = { "PLagger" },

    key = 'stew_stargazer',
    config = {extra = {xmult = 1}},
    rarity = 2,
    cost = 6,
    atlas = 'stewjokers',
    pos = {x=2, y=1},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function (self, info_queue, card)
       info_queue[#info_queue+1] = G.P_CENTERS.c_star
            local planet_count = 0
            local star_count = #SMODS.find_card('c_star')
            if G.consumeables then
            for _, planets in ipairs(G.consumeables.cards) do
                if planets.ability.set == 'Planet' then
                    planet_count = planet_count + 1
                end
            end
            end 
            
        return{
            vars = {card.ability.extra.xmult, 
                    1 + card.ability.extra.xmult * (planet_count + star_count)}
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            local star_count = #SMODS.find_card('c_star')
            local planet_count = 0
            for _, planets in ipairs(G.consumeables.cards) do
                if planets.ability.set == 'Planet' then
                    planet_count = planet_count + 1
                end
            end
            return{
                xmult = 1 + card.ability.extra.xmult * (planet_count + star_count)
            }
        end
    end

}