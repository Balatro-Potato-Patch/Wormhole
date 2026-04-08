SMODS.Joker{
    key = 'acme_test_dummy',
    atlas = 'ACME_jokers',
    pos = {x=2, y=0},
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    perishable_compat = true,
    eternal_compat = true,
    ppu_coder = {'Opal'},
    ppu_artist = {'FlameThrowerFIM'},
    calculate = function(self, card, context)
        if (context.card_added or context.modify_shop_card) and (context.card and context.card.ability and context.card.ability.set and context.card.ability.set == 'ACME_Gadget' and not (context.card.edition and context.card.edition.negative)) then
            context.card:set_edition('e_negative')

            local quip_num = math.ceil(3.03*pseudorandom(pseudoseed('acme_test_dummy')))
            local colours = {G.C.RED, G.C.ORANGE, G.C.BLUE, G.C.BLACK}
            return{
                message = localize('k_acme_test_dummy_'..quip_num),
                colour = colours[quip_num],
                sound = quip_num == 4 and 'worm_acme_hello' or nil
            }
        end
    end
}