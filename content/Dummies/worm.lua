SMODS.Atlas {
  key = "DummiesWorm",
  path = "Dummies/worm.png",
  px = 71,
  py = 95
}

SMODS.Joker{
    key = "worm",
    config = { extra = {  } },
    atlas = 'DummiesWorm',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    -- unlocked = true,
    -- discovered = true,
    
    ppu_coder = { "vissa" },
    ppu_team = { "dum" },

    pronouns = "he_him",

    calculate = function(self, card, context)
        if context.blueprint then
            return
        end
        if context.open_booster then
            --print(G.shop_booster.cards)
            --G.shop_booster.cards
            return { 
                card = card,
                --colour = G.C.PURPLE,
                --message = localize('k_bigger_map'),
            }
        end

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {  }, key = self.key }
    end
}