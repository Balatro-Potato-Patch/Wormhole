SMODS.Atlas {
  key = "dum_worm",
  path = "Dummies/worm.png",
  px = 71,
  py = 95
}

SMODS.Joker{
    key = "dum_worm",
    config = { extra = {  } },
    atlas = 'dum_worm',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    -- unlocked = true,
    -- discovered = true,
    
    ppu_coder = { "worm_vissa" },
    ppu_team = { "worm_dummies" },

    pronouns = "he_him",

    calculate = function(self, card, context)
        if context.blueprint then
            return
        end

        if context.starting_shop  then -- also on pickup
            if G.shop_booster and G.shop_booster.cards then
                for index, booster in ipairs(G.shop_booster.cards) do
                    booster.ability.couponed = true
                    booster:set_cost()
                end

                return { 
                    card = card,
                    colour = G.C.GREEN,
                    message = localize('k_worm_dum_worm_free'),
                }
            end
        end

        if context.open_booster then
            if G.shop_booster and G.shop_booster.cards and next(G.shop_booster.cards) then
                local deleted_booster = pseudorandom_element(G.shop_booster.cards, 'worm_dum_worm')
                
                deleted_booster:start_dissolve(nil, true)

                return { 
                    card = card,
                    colour = G.C.RED,
                    message = localize('k_worm_dum_worm_eat'),
                }
            end

        end

    end,

    add_to_deck = function(self, card, from_debuff)
        if G.shop_booster and G.shop_booster.cards then
            for index, booster in ipairs(G.shop_booster.cards) do
                booster.ability.couponed = true
                booster:set_cost()
            end
        end
        
    end,

    remove_from_deck = function (self, card, from_debuff)
        if G.shop_booster and G.shop_booster.cards then
            for index, booster in ipairs(G.shop_booster.cards) do
                booster.ability.couponed = false
                booster:set_cost()
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {  }, key = self.key }
    end
}