SMODS.Atlas({
    key = "meow_jokers",
    path = "TeamMeow/jokers.png",
    px = 71,
    py = 95
})

SMODS.Joker({
	key = "meow_nyan_cat",
	rarity = 2,
    atlas = "meow_jokers",
    blueprint_compat = false,
    config = {
        extra = {
            max_foil = 3
        }
    },
    loc_vars = function(self,info_queue,card)
        return{vars={card.ability.extra.max_foil}}
    end,
    add_to_deck = function(self,card,from_debuff)
        local cae = card.ability.extra
        G.GAME.max_foil_slots = G.GAME.max_foil_slots + cae.max_foil
    end,
    remove_from_deck = function(self,card,from_debuff)
        local cae = card.ability.extra
        G.GAME.max_foil_slots = G.GAME.max_foil_slots - cae.max_foil
    end
})

SMODS.Joker({
	key = "meow_cotobo_box",
	rarity = 2,
    atlas = "meow_jokers",
    blueprint_compat = false,
    loc_vars = function(self,info_queue,card)
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            local card_set = pseudorandom_element({"worm_meow_Zodicat", "worm_meow_Spacetart"})
            if G.consumeables.config.card_limit>#G.consumeables.cards then
                SMODS.add_card{
                    set = card_set
                }
            else
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_no_room_ex')})
            end
        end
    end
})