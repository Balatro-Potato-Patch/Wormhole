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
            }
        }})
    else
        G.ARGS.eigengrau_alpha = SMODS.is_active_blind("bl_worm_lfc_eigengrau", true) and 1 or 0
    end

    return ret
end

SMODS.Sound {
    key = "lfc_music_eigengrau",
    path = "lfc_eigengrau.wav",
    pitch = 1,
    select_music_track = function (self)
        if G.GAME and SMODS.is_active_blind("bl_worm_lfc_eigengrau", true) then
            return 1.7e306
        end
    end,
}

SMODS.Sound {
    key = "lfc_music_eigengrau_lo",
    path = "lfc_eigengrau_lopass.wav",
    pitch = 1,
    select_music_track = function (self)
        if G.GAME and SMODS.is_active_blind("bl_worm_lfc_eigengrau", true) and G.GAME.lfc_eigengrau_lo then
            return 1.7e307
        end
    end,
    sync = {
        ["lfc_music_eigengrau"] = "yes"
    }
}

-- TODO: ADD PROPER SPRITE
SMODS.Blind {
    key = "lfc_eigengrau",
    atlas = "lfc_blinds",
    pos = { x = 0, y = 1 },

    dollars = 8,
    boss = { showdown = true },
    boss_colour = HEX("111216"),

    loc_vars = function(self)
        local numerator, denominator = SMODS.get_probability_vars(self, 1, 2, "eigengrau")
        return { vars = { numerator, denominator } }
    end,
    collection_loc_vars = function(self)
        return { vars = { "1","2" } }
    end,

    defeat = function(self)
        Wormhole.LFC_Util.ease_eigengrau_bg_alpha(0)
    end,

    calculate = function(self, blind, context)
        if context.setting_blind then
            Wormhole.LFC_Util.ease_eigengrau_bg_alpha(1)
        end

        if blind.disabled then return end

        if context.hand_drawn and not blind.disabled then
            for id, card in ipairs(context.hand_drawn) do
                if Wormhole.LFC_Util.is_card_modified(card) and SMODS.pseudorandom_probability(self,"turn to stone (electric lights orchestra reference)",1,2,"lfc_cardmod_check") then
                    card:set_ability('m_stone', nil, true)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = (function()
                            SMODS.juice_up_blind()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    card:juice_up()
                                    return true
                                end
                            }))
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.06 * G.SETTINGS.GAMESPEED,
                                blockable = false,
                                blocking = false,
                                func = function()
                                    play_sound('tarot2', 0.76, 0.4); return true
                                end
                            }))
                            play_sound('tarot2', 1, 0.4)
                            return true
                        end)
                    }))
                end
            end
            local stones = 0
            for _, card in ipairs(G.hand.cards) do
                if SMODS.get_enhancements(card)["m_stone"] then stones = stones + 1 end
            end
            G.GAME.lfc_eigengrau_lo = stones > (#G.hand.cards / 2)
        end
    end,

    ppu_coder = { "ProdByProto", "InvalidOS" },
    ppu_artist = { "ellestuff.", "InvalidOS" },
    ppu_team = { "Lancer Fan Club" },
}