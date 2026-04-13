
SMODS.Joker {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "Wingcap" },
    ppu_coder = { "PLagger" },

    key = 'stew_impact_crater',
    config = {extra = {odds = 2}},
    rarity = 2,
    cost = 6,
    atlas = 'stewjokers',
    pos = {x=2, y=0},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_meteor', set = 'Tag' }
        info_queue[#info_queue + 1] = G.P_CENTERS.p_celestial_mega_1
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'worm_stew_impact_crater')
        return{
            vars = {localize {type = 'name_text', key = 'tag_meteor', set = 'Tag'}, numerator, denominator}
        }
    end,

    calculate = function (self, card, context)
        if context.ending_shop and SMODS.pseudorandom_probability(card, 'worm_stew_impact_crater', 1, card.ability.extra.odds) then
            card:juice_up() --maybe we can add more flair to creating the tag?
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag('tag_meteor'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        end
    end
}
