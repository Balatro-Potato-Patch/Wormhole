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
    cost = 6,
    blueprint_compat = false,
    config = {
        extra = {
            max_foil = 3
        }
    },
    attributes = { "cat", "space", "spacetart" },
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
    end,
    ppu_team = {"meow"},
	ppu_coder = { "revo" },
	ppu_artist = { "incognito" },
})

SMODS.Joker({
	key = "meow_cotobo_box",
	rarity = 2,
    atlas = "meow_jokers",
    pos = {x = 2, y = 0},
    soul_pos = {x = 2, y = 1},
    blueprint_compat = false,
    cost = 5,
    attributes = { "cat", "generation" },
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
    end,
    ppu_team = {"meow"},
    ppu_coder = { "revo" },
    ppu_artist = { "silverautumn" },
})

SMODS.Joker({
	key = "meow_catelite",
    rarity = 3,
    config = {
        extra = {
            level = 1
        }
    },
    atlas = "meow_jokers",
    pos = {x = 3, y = 0},
    cost = 7,
    attributes = {"cat", "space", "spacetart"},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.level } }
    end,
    blueprint_compat = false,
    ppu_team = {"meow"},
	ppu_coder = { "silverautumn" },
	ppu_artist = { "gappie" },
})
SMODS.Joker({
	key = "meow_golden_tart",
    rarity = 2,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return { vars = { #card.tarts } }
    end,
    blueprint_compat = false,
    attributes = {"cat", "scaling", "economy", "space", "spacetart"},
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and #card.tarts > 0 then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra_value = card.ability.extra_value + #card.tarts
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end,
    ppu_team = {"meow"},
	ppu_coder = { "silverautumn" },
})