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
	key = "meow_feli",
    rarity = 1,
    cost = 4,
    config = {
        extra = {
            mult = 6
        }
    },
    atlas = "meow_jokers",
    pos = {x = 4, y = 0},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    blueprint_compat = false,
    attributes = {"cat", "mult", "space"},
    calculate = function(self, card, context)
        if context.other_joker and (context.other_joker:has_attribute("cat")) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    ppu_team = {"meow"},
	ppu_coder = { "silverautumn" },
	ppu_artist = { "gappie" }
})