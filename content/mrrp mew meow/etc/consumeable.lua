SMODS.Consumable {
    ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'Cyan'},
    ppu_coder = {'Minty'},
    key = "mrrp_reentry",
    set = "Tarot",
    atlas = "mrrp",
    pos = {
        x = 1,
        y = 1
    },
    config = {
        extra = {
            dollars = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                SMODS.signed_dollars(card.ability.extra.dollars)
            }
        }
    end,
    cost = 3,
    can_use = function(self, card)
        for i, v in ipairs(G.hand.highlighted) do
            if v.config.center.key ~= "c_base"
                or v.edition
                or v.seal
            then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        for i, v in ipairs(G.hand.highlighted) do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event {
                func = function()
                    v:flip()
                    play_sound('card1', percent)
                    return true
                end, delay = 0.15, trigger = "after"
            })
        end

        for i, v in ipairs(G.hand.highlighted) do
            if v.config.center.key ~= "c_base" then
                G.E_MANAGER:add_event(Event {
                    func = function()
                        v:set_ability("c_base")
                        v:juice_up()
                        ease_dollars(card.ability.extra.dollars, true)
                        return true
                    end, delay = 0.5, trigger = "after"
                })
            end
        end

        for i, v in ipairs(G.hand.highlighted) do
            if v.edition then
                G.E_MANAGER:add_event(Event {
                    func = function()
                        v:set_edition(nil, nil, true)
                        v:juice_up()
                        ease_dollars(card.ability.extra.dollars, true)
                        return true
                    end, delay = 0.5, trigger = "after"
                })
            end
        end

        for i, v in ipairs(G.hand.highlighted) do
            if v.seal then
                G.E_MANAGER:add_event(Event {
                    func = function()
                        v:set_seal(nil, true)
                        v:juice_up()
                        ease_dollars(card.ability.extra.dollars, true)
                        return true
                    end, delay = 0.5, trigger = "after"
                })
            end
        end

        for i, v in ipairs(G.hand.highlighted) do
            local percent = 0.85 + ( i - 0.999 ) / ( #G.hand.highlighted - 0.998 ) * 0.3
            G.E_MANAGER:add_event(Event {
                func = function()
                    v:flip()
                    play_sound('tarot2', percent, 0.6)
                    return true
                end, delay = 0.15, trigger = "after"
            })
        end

        G.E_MANAGER:add_event(Event {
            func = function()
                G.hand:unhighlight_all()
                return true
            end, delay = 0.5, trigger = "after"
        })
    end
}
