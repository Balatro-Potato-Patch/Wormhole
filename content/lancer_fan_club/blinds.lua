SMODS.Blind {
    key = "lfc_fleet",
    atlas = "lfc_blinds",
    pos = {x = 0, y = 0},

    dollars = 5,
    boss = {
        min = 3,
    },
    boss_colour = HEX("54b2c0"),

    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.setting_blind then
            G.hand:change_size(1)
        end

        if context.hand_drawn and #G.hand.cards > 0 then
            local target = pseudorandom_element(G.hand.cards, "worm_lfc_fleet", {
                in_pool = function(card)
                    return not SMODS.is_eternal(card, {destroy_cards = true})
                end
            })
            if target then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.destroy_cards(target)

                        -- fix for an SMODS bug that results in card destruction sfx not playing when a single card is destroyed
                        G.E_MANAGER:add_event(Event({
                            blockable = false,
                            func = function()
                                play_sound('whoosh2', math.random()*0.2 + 0.9,0.5)
                                play_sound('crumple'..math.random(1, 5), math.random()*0.2 + 0.9,0.5)
                                return true
                            end
                        }))

                        SMODS.juice_up_blind()
                        return true
                    end
                }))
            end
        end
    end,

    disable = function(self)
        G.hand:change_size(-1)
    end,
    defeat = function(self)
        if not G.GAME.blind.disabled then
            G.hand:change_size(-1)
        end
    end,

    ppu_artist = { "InvalidOS" },
    ppu_coder = { "InvalidOS" },
    ppu_team = { "Lancer Fan Club" },
}

local csd = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    print(silent) return csd(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end