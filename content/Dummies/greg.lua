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

SMODS.Joker{
    key = "dum_greg",
    config = { extra = {  } },
    atlas = 'dum_greg',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    -- unlocked = true,
    -- discovered = true,
    
    ppu_coder = { "vissa" },
    ppu_team = { "dummies" },

    pronouns = "no_pronouns",

    unsellable = true,

    calculate = function(self, card, context)
        if context.after then

            local eaten_card = G.play.cards[#G.play.cards]
                    
            if eaten_card then
                SMODS.destroy_cards(eaten_card)
            end

            local enhanced_card = G.play.cards[1]

            if enhanced_card then
                local edition = SMODS.poll_edition { key = "worm_dum_greg", guaranteed = true, no_negative = true }
                enhanced_card:set_edition(edition, false, false, true)
            end

            return { 
                card = card,
                colour = G.C.RED,
                message = localize('k_worm_dum_worm_eat'),
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
                
    end,

    remove_from_deck = function (self, card, from_debuff)
        print("DEAD")
    end,

    loc_vars = function(self, info_queue, card)
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