SMODS.Blind {
    key = "lfc_fleet",
    atlas = "lfc_blinds",
    pos = {x = 0, y = 0},

    dollars = 5,
    boss = {
        min = 4,
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

SMODS.Shader {
    key = "lfc_eigengrau_bg",
    path = "lfc_eigengrau_bg.fs"
}

local gsr = Game.start_run
function Game:start_run(...)
    local ret = gsr(self, ...)
    if not G.LFC_EIGENGRAU_BG then
        G.LFC_EIGENGRAU_BG = Sprite(-30, -6, G.ROOM.T.w+60, G.ROOM.T.h+12, G.ASSET_ATLAS["ui_1"], {x = 2, y = 0})
        G.LFC_EIGENGRAU_BG:set_alignment({
            major = G.SPLASH_BACK,
            type = 'cm',
            bond = 'Strong',
            offset = {x=0,y=0}
        })
        G.ARGS.eigengrau_alpha = 0
        G.LFC_EIGENGRAU_BG:define_draw_steps({{
            shader = 'worm_lfc_eigengrau_bg',
            send = {
                {name = 'time', ref_table = G.TIMERS, ref_value = 'REAL_SHADER'},
                {name = 'alpha', ref_table = G.ARGS, ref_value = 'eigengrau_alpha'},
                -- add other shader args here
            }
        }})
    end

    return ret
end