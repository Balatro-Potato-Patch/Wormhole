SMODS.Atlas {
  key = "dum_worm",
  path = "Dummies/worm.png",
  px = 71,
  py = 95
}

SMODS.Sound{
    key = "dum_sfx_worm_gulp",
    path = "Dummies/sfx_worm_gulp.ogg",
    pitch = 1.0,
    volume = 1.0
}

SMODS.Joker{
    key = "dum_worm",
    attributes = {"booster", "economy", "alien"},
    config = { extra = {  } },
    atlas = 'dum_worm',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    -- unlocked = true,
    -- discovered = true,
    ppu_artist = { "vissa" },
    ppu_coder = { "vissa" },
    ppu_team = { "dummies" },

    pronouns = "he_him",

    wormhole_pos_extra = { x = 1, y = 0 },
    wormhole_anim_extra = {
        { x = 1, y = 0, t = 16 },
        { xrange = { first = 2, last = 4 }, y = 0, t = 0.1 },
        { xrange = { first = 0, last = 4 }, y = 1, t = 0.1 },
        { xrange = { first = 2, last = 4 }, y = 0, t = 0.1 },
        { xrange = { first = 0, last = 4 }, y = 1, t = 0.1 },
        { xrange = { first = 2, last = 4 }, y = 0, t = 0.1 },
        { xrange = { first = 0, last = 4 }, y = 1, t = 0.1 },
        { xrange = { first = 2, last = 4 }, y = 0, t = 0.1 },
        { xrange = { first = 0, last = 4 }, y = 1, t = 0.1 },
        { x = 1, y = 0, t = 0.1 },
        { xrange = { first = 2, last = 4 }, y = 0, t = 0.1 },
        { xrange = { first = 0, last = 4 }, y = 1, t = 0.1 },
        { x = 1, y = 0, t = 0.2 },
        { xrange = { first = 2, last = 4 }, y = 0, t = 0.1 },
        { xrange = { first = 0, last = 4 }, y = 1, t = 0.1 },
        { xrange = { first = 2, last = 4 }, y = 0, t = 0.1 },
        { xrange = { first = 0, last = 4 }, y = 1, t = 0.1 },
    },


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
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        deleted_booster:start_dissolve(nil, true)
                        play_sound('worm_dum_sfx_worm_gulp', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))

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