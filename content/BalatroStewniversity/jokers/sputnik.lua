SMODS.Joker {

    ppu_team = {'Balatro Stewniversity'},
    ppu_artist = {'Wingcap'},
    ppu_coder = {'stupxd'},

    key = 'worm_stew_sputnik',
    config = {extra = {xmult_min = 0.8, xmult_max = 5}},
    rarity = "Rare",
    cost = 8,
    atlas = 'stewjokers',
    pos = {x=3, y=2},
    blueprint_compat = true,
    eternal_compat = true, 
    perishable_compat = true,

    update_mult = function (self, card)
        card.ability.extra.mult = card.ability.extra.mult_mod * math.max(0, card.ability.extra.dollars - (G.GAME.dollars + (G.GAME.dollar_buffer or 0)))
    end,

    loc_vars = function (self, info_queue, card)
        local r_mults = {}
        -- Add some xmult options (every X0.2 just so custom options show up more often)
        for i = card.ability.extra.xmult_min, card.ability.extra.xmult_max, 0.1 do
            r_mults[#r_mults + 1] = string.format("X%.1f", i)
        end
        -- Fake mult but funny number go brr
        r_mults[#r_mults+1] = "X6.7"
        r_mults[#r_mults+1] = "X6.9"
        local loc_mult = ' ' .. (localize('k_mult')) .. '      '
        local main_start = {
            { n = G.UIT.T, config = { text = '      ', colour = G.C.WHITE, scale = 0.32 } },
            {n=G.UIT.C, config={align = "m", colour = G.C.RED, r = 0.05, padding = 0.03, res = 0.15}, nodes={
                { n = G.UIT.O, config = { object = DynaText({ string = r_mults, colours = { G.C.WHITE }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
            }},
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            -- rare strings
                            { string = "stew()    ", colour = HEX('bb6528') },
                            { string = "cat()     ", colour = G.C.ORANGE },
                            { string = "meat()    ", colour = G.C.RED },
                            { string = "pants()   ", colour = G.C.BLUE },
                            { string = "tomato()  ", colour = G.C.RED },
                            { string = "snail()   ", colour = G.C.MONEY },
                            { string = "turtle()  ", colour = G.C.GREEN },
                            { string = "sushi()   ", colour = lighten(G.C.RED, 0.85) },
                            -- make mult show up more often
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011, -- shout out 2011 @localthunk
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },
        }
        return { main_end = main_start }
    end,

    calculate = function (self, card, context)
        if context.joker_main then
            local xmult_mod = pseudorandom("stew_misprint")

            local xmult = card.ability.extra.xmult_min + (card.ability.extra.xmult_max - card.ability.extra.xmult_min) * xmult_mod
            
            return {
                xmult = math.floor(xmult * 100) / 100
            }
        end

    end

}