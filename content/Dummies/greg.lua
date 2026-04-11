SMODS.Atlas {
  key = "dum_greg",
  path = "Dummies/greg.png",
  px = 71,
  py = 95
}

local old_sell = Card.can_sell_card

function Card.can_sell_card(self, context)
    if self.config.center.unsellable then
        return false
    end
    return old_sell(self, context)
end

SMODS.Sound{
    key = "dum_sfx_greg_nom",
    path = "Dummies/sfx_greg_nom.ogg",
    pitch = 1.0,
    volume = 0.9
}

SMODS.Sound{
    key = "dum_sfx_greg_goodbye",
    path = "Dummies/sfx_greg_goodbye.ogg",
    pitch = 1.0,
    volume = 0.9
}


SMODS.Joker{
    key = "dum_greg",
    attributes = {"destroy_card","enhancements", "alien", "fish"},
    config = { extra = {  } },
    atlas = 'dum_greg',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,

    wormhole_pos_extra = { x = 0, y = 1 },
    wormhole_anim = {
        { x = 0, y = 0, t = 10.0-0.15 },
        { xrange = { first = 0, last = 4 }, y = 0, t = 0.15 },
    },
    wormhole_anim_extra = {
        { x = 0, y = 1, t = 2.3 }, { x = 1, y = 1, t = 0.075 },
        { x = 0, y = 1, t = 2.6 }, { x = 1, y = 1, t = 0.075 },
        { x = 0, y = 1, t = 0.8 }, { x = 1, y = 1, t = 0.075 },
        { x = 0, y = 1, t = 3.1 }, { x = 1, y = 1, t = 0.075 },
        { x = 2, y = 1, t = 0.3 }, { x = 3, y = 1, t = 2.0 },
        { xrange = { first = 2, last = 3 }, y = 1, t = 0.05 },
        { xrange = { first = 2, last = 3 }, y = 1, t = 0.05 },
        { xrange = { first = 2, last = 3 }, y = 1, t = 0.05 },
    },

    -- unlocked = true,
    -- discovered = true,
    
    ppu_artist = { "vissa" },
    ppu_coder = { "vissa" },
    ppu_team = { "dummies" },

    pronouns = "no_pronouns",

    unsellable = true,

    calculate = function(self, card, context)
        if context.after then

            local eaten_card = G.play.cards[#G.play.cards]
                    
            if eaten_card then
                SMODS.destroy_cards(eaten_card)
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        play_sound('worm_dum_sfx_greg_nom', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
            end

            local enhanced_card = G.play.cards[1]

            if enhanced_card then
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local edition = "e_worm_dum_Celestial"
                        enhanced_card:set_edition(edition, true, false, false)
                        return true
                    end
                }))
            end

            return { 
                card = card,
                colour = G.C.RED,
                message = localize('k_worm_dum_greg_eat'),
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
                
    end,

    remove_from_deck = function (self, card, from_debuff)
        play_sound('worm_dum_sfx_greg_goodbye', 0.96 + math.random() * 0.08)
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_worm_dum_Celestial
        return { vars = {  }, key = self.key }
    end

}


if CardPronouns and CardPronouns.Pronoun then
    CardPronouns.Pronoun {
        colour = HEX("000000"),
        text_colour = G.C.GREY,
        pronoun_table = { "No", "Pronouns" },
        in_pool = function()
            return false
        end,
        key = "no_pronouns"
    }
end