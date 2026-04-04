if not to_number then to_number = function(x) return x end end

SMODS.Joker {
    key = "dum_gleebleglorp",
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    rarity = 1,
    atlas = 'DummiesJokers',
    pos = { x = 1, y = 0 },
    wormhole_pos_extra = { x = 4, y = 0 },
    wormhole_anim = {
        { xrange = { first = 1, last = 3 }, y = 0, t = 0.15 },
    },
    wormhole_anim_extra = {
        { x = 4,                            y = 0, t = 1.5 },
        { xrange = { first = 5, last = 6 }, y = 0, t = 0.075 }, { x = 5, y = 0, t = 0.075 },
        { x = 4,                            y = 0, t = 1.3 },
        { xrange = { first = 5, last = 6 }, y = 0, t = 0.075 }, { x = 5, y = 0, t = 0.075 },
        { x = 4,                            y = 0, t = 0.8 },
        { xrange = { first = 5, last = 6 }, y = 0, t = 0.075 }, { x = 5, y = 0, t = 0.075 },
        { x = 4,                            y = 0, t = 2.1 },
        { xrange = { first = 5, last = 6 }, y = 0, t = 0.075 }, { x = 5, y = 0, t = 0.075 },
        { x = 4, y = 0, t = 0.2 },
    },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            for handname, _ in pairs(G.GAME.hands) do
                if handname ~= context.scoring_name and SMODS.is_poker_hand_visible(handname) and to_number(G.GAME.hands[handname].level) >= to_number(G.GAME.hands[context.scoring_name].level) then
                    return { xmult = card.ability.extra.xmult }
                end
            end
        end
    end,
    pronouns = "worm_dum_xe_xem",

    ppu_team = { "dummies" },
    ppu_artist = { "ghostsalt" },
    ppu_coder = { "ghostsalt" }
}

if next(SMODS.find_mod("cardpronouns")) then
    CardPronouns.Pronoun {
        colour = G.C.SECONDARY_SET.Planet,
        text_colour = G.C.WHITE,
        pronoun_table = { "Xe", "Xem" },
        in_pool = function() return false end,
        key = "worm_dum_xe_xem"
    }
    CardPronouns.classifications["neutral"].pronouns[#CardPronouns.classifications["neutral"].pronouns] = "worm_dum_xe_xem"
end
