if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

Wormhole.COLON_THREE.C.JunkSet = HEX("ff5e25")
loc_colour()
G.ARGS.LOC_COLOURS.worm_c3_junkset = Wormhole.COLON_THREE.C.JunkSet 

SMODS.Atlas {
    path = "colon_three/derelict.png",
    key = "ct_derelict",
    px = 71, py = 95
}

SMODS.ConsumableType {
    key = "JunkSet",
    primary_colour = Wormhole.COLON_THREE.C.JunkSet,
    secondary_colour = Wormhole.COLON_THREE.C.JunkSet,
    collection_rows = { 4, 4 },
    shop_rate = 0.0,
    default = "c_worm_ct_asteroid_harvester"
}

local start_run = Game.start_run
function Game:start_run(args)
    start_run(self, args)

    if not self.GAME.worm_c3_junk_stats then
        self.GAME.worm_c3_junk_stats = {
            chips = 1,
            mult = 0,
            retriggers = 1,
            x_hand_stats = 1.5,
            x_mult = 0,
            money = 0,
        }
    end
end

SMODS.Atlas {
    path = "colon_three/junk_card.png",
    key = "ct_junk_card",
    px = 71, py = 95
}

SMODS.Enhancement {
    key = "ct_junk_card",
    ppu_coder = {"lordruby"},
    ppu_artist = { "notmario", "lordruby", "nxkoo", "ophelia", "meta" },
    replace_base_card = true,
    pos = { x = 1, y = 0 },
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { extra = { junk_mult = 1, } },
    loc_vars = function(self, q, card)
        local key_append = ""
        if ((G.GAME.worm_c3_junk_stats or {}).mult or 0) ~= 0 then
            key_append = key_append.."_mult"
        end
        if ((G.GAME.worm_c3_junk_stats or {}).x_mult or 0) ~= 0 then
            key_append = key_append.."_ringularity"
        end
        return {
            key = (key_append ~= "") and "m_worm_ct_junk_card"..key_append or nil,
            vars = {
                ((G.GAME.worm_c3_junk_stats or {}).chips or 1) * card.ability.extra.junk_mult,
                ((G.GAME.worm_c3_junk_stats or {}).mult or 0) * card.ability.extra.junk_mult,
                (G.GAME.worm_c3_junk_stats or {}).retriggers or 1,
                ((G.GAME.worm_c3_junk_stats or {}).retriggers or 1) == 1 and "" or "s",
                ((G.GAME.worm_c3_junk_stats or {}).x_mult or 0) * card.ability.extra.junk_mult + 1,
                ((G.GAME.worm_c3_junk_stats or {}).money or 0) * card.ability.extra.junk_mult,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = (G.GAME.worm_c3_junk_stats or {}).retriggers or 1
            }
        end
        if context.main_scoring and context.cardarea == G.play then
            local rets = {}
            rets["chips"] = ((G.GAME.worm_c3_junk_stats or {}).chips or 1) * card.ability.extra.junk_mult
            if ((G.GAME.worm_c3_junk_stats or {}).mult or 0) ~= 0 then
                rets["mult"] = ((G.GAME.worm_c3_junk_stats or {}).mult or 0) * card.ability.extra.junk_mult
            end
            if ((G.GAME.worm_c3_junk_stats or {}).x_mult or 0) ~= 0 then
                rets["xmult"] = ((G.GAME.worm_c3_junk_stats or {}).x_mult or 0) * card.ability.extra.junk_mult + 1
            end
            if ((G.GAME.worm_c3_junk_stats or {}).money or 0) ~= 0 then
                rets["dollars"] = ((G.GAME.worm_c3_junk_stats or {}).money or 0) * card.ability.extra.junk_mult
            end
            return rets
        end
        -- if context.initial_scoring_step and context.cardarea == G.play then
        --     hand_chips = mod_chips(hand_chips * (G.GAME.worm_c3_junk_stats or {}).x_hand_stats or 1.5)
        --     mult = mod_mult(mult * (G.GAME.worm_c3_junk_stats or {}).x_hand_stats or 1.5)
        --     return {
        --         message = "Junked!"
        --     }
        -- end
    end
}

SMODS.DrawStep {
    key = 'worm_c3_junk_card',
    order = 1,
    func = function(self, layer)
        if not (self.config and self.config.center and self.config.center.key == "m_worm_ct_junk_card") then return nil end
        --Draw the main part of the card
        if self.children.front then
            if (self.edition and self.edition.negative and (not self.delay_edition or self.delay_edition.negative)) then
                self.children.front:draw_shader('negative', nil, self.ARGS.send_to_shader)
            elseif not self.greyed then
                self.children.front:draw_shader('dissolve')
            end
        end
        if not Wormhole.COLON_THREE.shared_junk_card then
            Wormhole.COLON_THREE.shared_junk_card = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["worm_ct_junk_card"], {x = 0, y = 0})
        end
        Wormhole.COLON_THREE.shared_junk_card:set_sprite_pos({ x = not not self.children.front and 0 or 1, y = 0 })
        Wormhole.COLON_THREE.shared_junk_card.role.draw_major = self
        Wormhole.COLON_THREE.shared_junk_card:draw_shader('dissolve', nil, nil, nil, self.children.center)
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.DrawStep {
    key = 'worm_c3_junk_card_edition',
    order = 21,
    func = function(self, layer)
        if not (self.config and self.config.center and self.config.center.key == "m_worm_ct_junk_card") then return nil end
        local edition = self.delay_edition or self.edition
        if edition then
            for k, v in pairs(G.P_CENTER_POOLS.Edition) do
                if edition[v.key:sub(3)] and v.shader then
                    if type(v.draw) == 'function' then
                        v:draw(self, layer)
                    else
                        if self.children.front then
                            self.children.front:draw_shader(v.shader, nil, self.ARGS.send_to_shader)
                        end
                        if not Wormhole.COLON_THREE.shared_junk_card then
                            Wormhole.COLON_THREE.shared_junk_card = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["worm_ct_junk_card"], {x = 0, y = 0})
                        end
                        Wormhole.COLON_THREE.shared_junk_card:set_sprite_pos({ x = not not self.children.front and 0 or 1, y = 0 })
                        Wormhole.COLON_THREE.shared_junk_card.role.draw_major = self
                        Wormhole.COLON_THREE.shared_junk_card:draw_shader(v.shader, nil, nil, nil, self.children.center)
                    end
                end
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

function Wormhole.COLON_THREE.junk_get_highlighted_cards(cards)
    local all_junk_selected = true
    local highlighted = {}
    for i, v in pairs(cards) do
        if v.highlighted then
            table.insert(highlighted, v) --t[#t+1] is marginally faster perf-wise, but this is cleaner
            if v.config.center.key ~= "m_worm_ct_junk_card" then all_junk_selected = false end
        end
    end
    return highlighted, all_junk_selected
end

function Wormhole.COLON_THREE.flip_cards_events(cards, sound, sound_pitch, sound_direction)
    for i, card in ipairs(cards) do
        local percent = (sound_pitch or 1) + (i - 0.999) / (#cards - 0.998) * 0.3 * (sound_direction or 1)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.25,
            func = function()
                if sound then play_sound(sound, percent) end
                card:flip()
                return true
            end
        }))
    end
end

function Wormhole.COLON_THREE.junk_can_use(func)
    return function(self, card)
        local junk_num = card.ability.extra.junk_num or 1
        local cleanup_num = card.ability.extra.cleanup_num or 1
        local junk = 0
        for i, v in pairs(G.hand.highlighted) do
            if v.config.center.key == "m_worm_ct_junk_card" then junk = junk + 1 end
        end

        local cleanup_vals = { [cleanup_num] = true }
        -- for i = 1, math.min ( #SMODS.find_card("j_worm_wall_e"), cleanup_num - 1 ) do
        --     cleanup_vals[cleanup_num-i] = true
        -- end
        SMODS.calculate_context { worm_c3_cleanup_cost = true, valid_costs = cleanup_vals }

        local will_cleanup = G.hand and cleanup_vals[#G.hand.highlighted] and #G.hand.highlighted == junk
        local will_convert = G.hand and #G.hand.highlighted == junk_num and junk == 0
        return (not func or func(self, card)) and (will_convert or will_cleanup)
    end
end

local empty_function = function() end

function Wormhole.COLON_THREE.junk_use(config)
    --[[
    used config values:
        config.junk_func | Function | Called with parameters (self, card, cards) while playing cards are flipped. Called during junking
        config.clean_func | Function | Same as config.junk_func but called during cleaning.
        config.individual | Function |  Called with parameters (self, card, playing_card, clean_up) on each individual
            playing card while flipped. Only called if cleaning up.
    ]]

    config.junk_func = config.junk_func or empty_function
    config.clean_func = config.clean_func or empty_function
    config.individual = config.individual or empty_function
    -- Avoids checks later

    return function(self, card)
        local hand, clean_up = Wormhole.COLON_THREE.junk_get_highlighted_cards(G.hand.cards)
        Wormhole.COLON_THREE.flip_cards_events(hand, "card1", 1.15, -1)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.25,
            func = function()
                if clean_up then
                    config.clean_func(self, card, hand)
                else
                    config.junk_func(self, card, hand)
                end
                return true
            end
        }))
        for _, playing_card in ipairs(hand) do
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.25,
                func = function()
                    if clean_up then
                        config.individual(self, card, playing_card, clean_up)
                        if not playing_card.stay_junk then
                            playing_card:set_ability("c_base")
                        end
                        playing_card.stay_junk = nil
                    else
                        playing_card:set_ability("m_worm_ct_junk_card")
                    end
                    return true
                end
            }))
        end
        Wormhole.COLON_THREE.flip_cards_events(hand, "tarot2", 0.85, 1)

        if clean_up then
            SMODS.calculate_context { worm_c3_cleanup = true, cards = hand }
        end

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.25,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
end
