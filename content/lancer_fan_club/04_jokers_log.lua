SMODS.Joker({
    key = "lfc_log",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    atlas = "lfc_jokers",
    pos = { x = 0, y = 1 },
    ppu_coder = { "ProdByProto" },
    config = {
        extra = {
            mult = 0,
            scalar = 2,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.scalar, card.ability.extra.mult, G.GAME and G.GAME.round or 1 } }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.card_added and not context.repetition then
            if context.card.ability.set == "Joker" then
                cae.mult = cae.mult + cae.scalar
                juice_card(card)
            end
        end

        if context.joker_main then
            return { mult = cae.mult }
        end
    end

})

--[[
NOTE FROM J8-BIT:

Hi Proto! Thanks for taking initiative making this Joker!

I wanted to specify something with the Joker effect since
I tried it out and it wasn't quite what I was looking for;
I had it in mind that it would scale with each unique
Joker obtained over the run; there would probably need to
be some kind of table that keeps track of every Joker the
player had at any point, and it'd count the number of
unique Jokers the player owned. It'd be like a Joker that
scaled with the number of Pokemon you owned in your
Pokedex, you know?

Hope that helps!
]]
