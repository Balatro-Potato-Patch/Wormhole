Wormhole.tbp = {}
Wormhole.tbp.config = SMODS.current_mod.config

function Wormhole.tbp.get_resuited_thruster_suit()
    if G.GAME and G.GAME.current_round and G.GAME.current_round.tbp_resuited_thruster_suit then
        return G.GAME.current_round.tbp_resuited_thruster_suit
    end

    if not Wormhole.tbp.resuited_thruster_preview_suit then
        Wormhole.tbp.resuited_thruster_preview_suit = pseudorandom_element(
            {'Spades', 'Hearts', 'Diamonds', 'Clubs'},
            pseudoseed('tbp_resuited_thruster_preview')
        )
    end

    return Wormhole.tbp.resuited_thruster_preview_suit
end

function Wormhole.tbp.reset_resuited_thruster_suit()
    local suits = {'Spades', 'Hearts', 'Diamonds', 'Clubs'}
    local previous_suit = Wormhole.tbp.get_resuited_thruster_suit()
    if previous_suit then
        for i = #suits, 1, -1 do
            if suits[i] == previous_suit then
                table.remove(suits, i)
                break
            end
        end
    end

    local next_suit = pseudorandom_element(suits, pseudoseed('tbp_resuited_thruster_' .. G.GAME.round_resets.ante))
    G.GAME.current_round.tbp_resuited_thruster_suit = next_suit
    Wormhole.tbp.resuited_thruster_preview_suit = next_suit
end

function Wormhole.tbp.get_dellinger_pokerhand()
    if G.GAME and G.GAME.current_round and G.GAME.current_round.tbp_dellinger_pokerhand then
        return G.GAME.current_round.tbp_dellinger_pokerhand
    end

    local _poker_hands = {}
    for k, v in pairs(G.GAME.hands or { "High Card" }) do
        if SMODS.is_poker_hand_visible(k) and k ~= G.GAME.current_round.tbp_dellinger_pokerhand then
            _poker_hands[#_poker_hands + 1] = k
        end
    end

    local ret, _ = pseudorandom_element(_poker_hands, 'tbp_dellinger')

    return ret
end

function Wormhole.tbp.reset_dellinger_pokerhand()
    local _poker_hands = {}
    for k, v in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(k) and k ~= G.GAME.current_round.tbp_dellinger_pokerhand then
            _poker_hands[#_poker_hands + 1] = k
        end
    end
    G.GAME.current_round.tbp_dellinger_pokerhand, _ = pseudorandom_element(_poker_hands, 'tbp_dellinger')
end

local reset_game_globals_ref = Wormhole.reset_game_globals
function Wormhole.reset_game_globals(run_start)
    if Wormhole.tbp then
        --Wormhole.tbp.reset_resuited_thruster_suit()
        Wormhole.tbp.reset_dellinger_pokerhand()
    end
    return reset_game_globals_ref(run_start)
end

SMODS.Atlas {
    key = "tbp_devs",
    path = "taxes_back_pain/portraits.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "tbp_small_ship",
    atlas_table = 'ANIMATION_ATLAS',
    path = "taxes_back_pain/small_ship.png",
    px = 121,
    py = 95,
    frames = 64,
}

SMODS.Atlas {
    key = "tbp_launchdeck",
    path = "taxes_back_pain/launchdeck.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "tbp_ship",
    path = "taxes_back_pain/spaceship_joker.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "tbp_ship_soul",
    path = "taxes_back_pain/spaceship.png",
    px = 75,
    py = 95
}

SMODS.Atlas {
    key = "tbp_module_sprite_only",
    path = "taxes_back_pain/modules_sprite_only_2.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "tbp_module",
    path = "taxes_back_pain/modules.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "tbp_module_frame",
    path = "taxes_back_pain/separated_module_card.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "tbp_boosters",
    path = "taxes_back_pain/module_boosters.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "tbp_icons_cards",
    path = "taxes_back_pain/icons_cardsized.png",
    px = 71,
    py = 95
}


SMODS.Atlas {
    key = "tbp_icons",
    path = "taxes_back_pain/icons_no_bg.png",
    px = 24,
    py = 15
}

SMODS.Atlas {
    key = "tbp_tag",
    path = "taxes_back_pain/tag.png",
    px = 34,
    py = 34
}


SMODS.Atlas {
    key = "tbp_cyclone",
    path = "taxes_back_pain/cyclone.png",
    px = 620,
    py = 491
}

PotatoPatchUtils.Team({
    name = 'tbp',
    loc = true,
    colour = HEX('99acad'),
    credit_rows = {4, 3},
    short_credit = true

})

SMODS.Gradient({
    key = 'tbp_spaceship_badge',
    colours = {
        HEX('8677AF'), HEX('6499A4')
    },
})

SMODS.Gradient({
    key = 'eremel',
    colours = {
        HEX('a756f9'), HEX('4ee8d3'), HEX('a756f9'), HEX('e8c81b')
    },
    cycle = 6
})

SMODS.Gradient({
    key = 'mythie',
    colours = {
        HEX('c4524b'), HEX('fc7067'), HEX('ffe463'), HEX('48a881'), HEX('007ee2')
    },
    cycle = 6
})

SMODS.Gradient({
    key = 'sdm',
    colours = {
        HEX('EDC001'), HEX('FF6E00'), HEX('D30000'), HEX('FF6E00')
    },
})

SMODS.Gradient({
    key = 'dilly',
    colours = {
        HEX('00FF7F'), HEX('8A2BE2')
    },
    cycle = 12,
    interpolation = 'trig'
})

SMODS.Gradient({
    key = 'rsnow',
    colours = {
        HEX('1a1a1a'), HEX('c0c0c0'), HEX('1a1a1a')
    },
    cycle = 10,
})

SMODS.Gradient({
    key = "ice",
    colours = { 
        HEX("ff992f"), HEX("a445db")
    },
    cycle = 2.5,
})

PotatoPatchUtils.Developer({
    name = 'eremel',
    team = 'tbp',
    loc = true,
    colour = SMODS.Gradients.worm_eremel,
    atlas = 'worm_tbp_devs',
    pos = { x = 1, y = 1 },
})

PotatoPatchUtils.Developer({
    name = 'n',
    team = 'tbp',
    loc = true,
    colour = HEX("F4A6C7"),
    atlas = 'worm_tbp_devs',
    pos = { x = 6, y = 1 },
})

PotatoPatchUtils.Developer({
    name = 'sdm',
    team = 'tbp',
    loc = true,
    colour = SMODS.Gradients.worm_sdm,
    atlas = 'worm_tbp_devs',
    pos = { x = 5, y = 1 },
})

PotatoPatchUtils.Developer({
    name = 'dilly',
    team = 'tbp',
    loc = true,
    colour = SMODS.Gradients.worm_dilly,
    atlas = 'worm_tbp_devs',
    pos = { x = 2, y = 1 },
})

PotatoPatchUtils.Developer({
    name = 'ice',
    team = 'tbp',
    loc = true,
    colour = SMODS.Gradients.worm_ice,
    atlas = 'worm_tbp_devs',
    pos = { x = 3, y = 1 },
})

PotatoPatchUtils.Developer({
    name = 'rsnow',
    team = 'tbp',
    loc = true,
    colour = SMODS.Gradients.worm_rsnow,
    atlas = 'worm_tbp_devs',
    pos = { x = 4, y = 1 },
})

PotatoPatchUtils.Developer({
    name = 'mythie',
    team = 'tbp',
    loc = true,
    atlas = 'worm_tbp_devs',
    colour = SMODS.Gradients.worm_mythie,
    pos = { x = 0, y = 1 },
})

SMODS.DrawStep{
    key = 'credit_space',
    order = 5,
    func = function(self, layer)
        if self.children.center.atlas.name == "worm_tbp_devs" then
            self.children.center:draw_shader("worm_torn", nil, self.ARGS.send_to_shader)
            if self.children.front and not self:should_hide_front() then
                self.children.front:draw_shader("worm_torn", nil, self.ARGS.send_to_shader)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.DrawStep{
    key = 'small_ship',
    order = 21,
    func = function(self, layer)
        if not SMODS.find_card("j_worm_tbp_spaceship")[1] then
            if self.config.center.kind == "worm_tbp_module" and G.worm_tbp_sprites then
                G.worm_tbp_sprites['small_ship'].role.draw_major = self
                -- Current offset may look werid sometimes
                G.worm_tbp_sprites['small_ship']:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, -0.9) 
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.Back{
    key = "spaceship_deck",
    atlas = "worm_tbp_launchdeck",
    discovered = true,
    pos = {x = 0, y = 0},
    config = {jokers = {'j_worm_tbp_spaceship'} },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize { type = 'name_text', key = "j_worm_tbp_spaceship", set = 'Joker' } } }
    end,
    apply = function(self, back)
        G.GAME.starting_params.tbp_booster_always_spawn = true
    end,
}

---

Wormhole.tbp.module_colours = {
    weapons = HEX('fd5f55'),
    core = HEX('5559fd'),
    thrusters = HEX('06b48b'),
    utility = HEX('db4bda')
}

SMODS.Joker({
	key = "tbp_spaceship",
    atlas = "tbp_ship",
    pos = {x=1, y=0},
	rarity = 4,
	cost = 1,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
    attributes = {"generation", "space"},
    ppu_team = {'tbp'},
    ppu_artist = {'ice'},
    module_types = {'core', 'weapons', 'utility', 'thrusters'},
    config = {
        extra_slots_used = -1,
        extra = {
            ship_name = "Spaceship",
            modules = {
                core = {},
                weapons = {},
                thrusters = {},
                utility = {}
            }
        },
    },
	loc_vars = function(self, info_queue, card)
        if not card.fake_card then
            info_queue[#info_queue + 1] = G.P_CENTERS["p_worm_module_jumbo_1"]
            for _, v in ipairs(self.module_types) do
                if card.ability.extra.modules[v].key and (G.P_CENTERS[card.ability.extra.modules[v].key] or {}).loc_vars then
                    local vars = G.P_CENTERS[card.ability.extra.modules[v].key]:loc_vars(info_queue, {ability = { extra = card.ability.extra.modules[v] } }, card).vars
                    vars.colours = vars.colours or {}
                    table.insert(vars.colours, 1, darken(Wormhole.tbp.module_colours[v], 0.3))
                    info_queue[#info_queue+1] = {set = 'tbp_module', key = card.ability.extra.modules[v].key, vars = vars, module_type = v, module_info = card.ability.extra.modules[v]}
                else
                    info_queue[#info_queue+1] = {set = 'tbp_module', key = 'c_worm_tbp_module_missing', module_type = v, vars = {colours = {mix_colours(G.ARGS.LOC_COLOURS.inactive, Wormhole.tbp.module_colours[v], 0.5)}}}
                end
            end
        end
        local key = self.key
        if G.GAME.selected_back and G.GAME.selected_back.effect.center.key == "b_worm_spaceship_deck" then
            key = self.key .. "_back"
        end
        local modules = self:modules_equipped(card)
        return {
            key = key,
            vars = {
                colours = {modules and G.ARGS.LOC_COLOURS.inactive or G.C.UI.TEXT_DARK, modules and mix_colours(G.ARGS.LOC_COLOURS.inactive, G.ARGS.LOC_COLOURS.attention, 0.65) or G.ARGS.LOC_COLOURS.attention},
                localize{type = 'name_text', set = 'Other', key = 'p_worm_module_jumbo_1'},
                localize("k_tbp_name_".. card.ability.extra.ship_name)
            }
        }
    end,
    modules_equipped = function(self, card)
        return next(card.ability.extra.modules.core) or next(card.ability.extra.modules.weapons) or next(card.ability.extra.modules.thrusters) or next(card.ability.extra.modules.utility)
    end,
    modify_module_durability = function(self, card, change, modules)
        -- temporary code to test module destruction
        if not modules then modules = self.module_types end
        for _, module in ipairs(modules) do
            local module_data = card.ability.extra.modules[module]
            local current_durability = module_data and tonumber(module_data.durability)
            if current_durability and not module_data.durability_loss_odds then
                module_data.durability = current_durability + (tonumber(change) or 0)
                if module_data.durability <= 0 then
                    local lost_key = module_data.key
                    if card.ability.extra.modules.core.key == 'c_worm_tbp_salvage_core' and card.ability.extra.modules.core.money_per_destruction then
                        ease_dollars(card.ability.extra.modules.core.money_per_destruction)
                        SMODS.calculate_effect({
                            message = localize('$') .. card.ability.extra.modules.core.money_per_destruction,
                            colour = G.C.MONEY
                        }, card)
                    end
                    card.ability.extra.modules[module] = {}
                    SMODS.calculate_effect({
                        message = localize({type='name_text', set='tbp_module', key=lost_key}) .. ' lost!',
                        colour = G.C.RED
                    }, card)
                end
            end
        end
    end,
	calculate = function(self, card, context)
		if not context.blueprint then
            if context.starting_shop and (not self:modules_equipped(card) or G.GAME.starting_params.tbp_booster_always_spawn) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.3, 0.5)
                        SMODS.add_booster_to_shop("p_worm_module_jumbo_1")
                    return true
                    end
                }))
            end
            local module_calcs = {}
            for _, module in ipairs(self.module_types) do
                if card.ability.extra.modules[module].key and (G.P_CENTERS[card.ability.extra.modules[module].key] or {}).module_calculate then
                    local ret = G.P_CENTERS[card.ability.extra.modules[module].key]:module_calculate(card.ability.extra.modules[module], context, card)
                    if ret and next(ret) then
                        module_calcs[#module_calcs + 1] = ret
                    end
                end
            end
            return next(module_calcs) and SMODS.merge_effects(module_calcs)
        end
	end,
    add_to_deck = function(self, card, from_debuff)
        local _list_of_ship_names = {
           "Vaianu",
           "Explorer",
           "Artemis",
           "Galactica",
           "Sealab",
           "Eremillenium",
        }
        card.ability.extra.ship_name = pseudorandom_element(_list_of_ship_names, pseudoseed("shipname"))

		if next(SMODS.find_card("j_worm_tbp_spaceship")) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        SMODS.add_card{ set = "tbp_module" }
                    end
                    card:remove()
                    return true
                end
            }))
        end
	end,
	in_pool = function(self, args)
		return false
    end,
    set_card_type_badge = function (self, card, badges)
        badges[#badges + 1] = create_badge(localize("k_tbp_spaceship"), SMODS.Gradients["worm_tbp_spaceship_badge"], nil, 1.2)
    end
})

---- Module Functionality ----

---Changes current module durability and handles tracking of game globals for durability changes
---@param module_type any
---@param change any
---@param abs any
---@param silent any
function Wormhole.tbp.change_durability(ship, module_type, change, abs, silent)
    ship = ship or SMODS.find_card("j_worm_tbp_spaceship")[1]
    local module_data = ship and ship.ability and ship.ability.extra and ship.ability.extra.modules and ship.ability.extra.modules[module_type]
    local current_durability = module_data and tonumber(module_data.durability)
    if current_durability then
        local flags = SMODS.calculate_context({ wormhome_tbp_module_change_durability = true, amount = change, module = module_type, card = ship, during_uninstall = G.GAME.tbp_during_uninstall })
        change = tonumber(flags.modify ~= nil and flags.modify or change) or 0
        module_data = ship and ship.ability and ship.ability.extra and ship.ability.extra.modules and ship.ability.extra.modules[module_type]
        current_durability = module_data and tonumber(module_data.durability)
        if not current_durability then
            return
        end
        module_data.durability = abs and change or (current_durability + change)
        if change < 0 then
            G.GAME.tbp.run.durability_lost.total = G.GAME.tbp.run.durability_lost.total + change
            G.GAME.tbp.run.durability_lost[module_type] = G.GAME.tbp.run.durability_lost[module_type] and G.GAME.tbp.run.durability_lost[module_type] + 1 or change
        end
        if module_data.durability <= 0 then
            Wormhole.tbp.uninstall_module(ship, module_type, "failed", silent)
        elseif not silent then
            SMODS.calculate_effect({
                message = change .. ' Durability!',
                colour = G.C.PURPLE
            }, ship)
        end
    end
end

local smods_update_context_flags_ref = SMODS.update_context_flags
function SMODS.update_context_flags(context, flags, ...)
    if flags.modify then
        if context.wormhome_tbp_module_change_durability then context.amount = flags.modify end
    end
    return smods_update_context_flags_ref(context, flags, ...)
end

--- Add module to ship and log changes. Trigger effects based on install type
---@param module Card Module Object.
---@param card Card Module Consumable card
---@param install_type string Type of install. Currently only 'Default'
---@param silent boolean disable notifications, tracking and events
function Wormhole.tbp.install_module(ship, module, card, install_type, silent)
    ship = ship or SMODS.find_card("j_worm_tbp_spaceship")[1]
    if ship then
        local old_module_key = ship[1].ability.extra.modules[module.slot].key or nil

        if not silent then
            G.GAME.tbp.run.modules_installed.total = G.GAME.tbp.run.modules_installed.total + 1
            G.GAME.tbp.run.modules_installed[module.slot] = G.GAME.tbp.run.modules_installed[module.slot] and G.GAME.tbp.run.modules_installed[self.slot] + 1 or 1
            G.GAME.tbp.run.last_module_installed = module.key
        end

        if old_module_key ~= nil then
            Wormhole.tbp.uninstall_module(ship, module.slot, 'override', silent)
        end

        G.FUNCS.show_module_replace_confirm(card, ship[1])
        return {}
    end
end

---Remove a module and log the change. Trigger effects based on uninstall type
---@param module any
---@param uninstall_type any
---@param silent any
function Wormhole.tbp.uninstall_module(ship, module, uninstall_type, silent)
    ship = ship or SMODS.find_card("j_worm_tbp_spaceship")[1]
    local module_key = ship.ability.extra.modules[module].key or nil
    if ship.ability.extra.modules[module] then

        if not silent then
            G.GAME.tbp_during_uninstall = true
            SMODS.calculate_context({wormhome_tbp_module_uninstall = true, card = ship, module = module, type = uninstall_type})
            G.GAME.tbp_during_uninstall = false
        end

        if uninstall_type == 'failed' then
            if not silent then
                G.GAME.tbp.run.modules_failed.total = G.GAME.tbp.run.modules_failed.total + 1
                G.GAME.tbp.run.modules_failed[module] = G.GAME.tbp.run.modules_failed[module] and G.GAME.tbp.run.modules_failed[module] + 1 or 1
                G.GAME.tbp.run.last_module_failed = module_key
            end

            ship.ability.extra.modules[module] = {}
            
            if not silent then
                SMODS.calculate_effect({
                    message = localize({type='name_text', set='tbp_module', key=module_key}) .. ' lost!',
                    colour = G.C.RED
                }, ship)
            end
        elseif uninstall_type ~= 'override' then

        end
        

    else
        return nil
    end
end

---- MODULE TYPE ----

SMODS.ConsumableType {
    key = 'tbp_module',
    collection_rows = { 4, 4 },
    primary_colour = HEX("7ca3cc"),
    secondary_colour = HEX("7ca3cc"),
    default = "c_worm_tbp_laser",
}

-- This is here because I want LSP defs but we can remove it later - N'
---@class Wormhole.tbp.Module: SMODS.Consumable
---@field module_calculate? fun(self: Wormhole.tbp.Module|table, module: table, context: CalcContext|table, card?: Card|table): table?, boolean?
---@field loc_vars? fun(self: Wormhole.tbp.Module|table, info_queue: table, module: table, card?: Card|table): table?
---@field durability number
---@field slot 'core'|'weapons'|'utility'|'thrusters'
---@overload fun(self: Wormhole.tbp.Module): Wormhole.tbp.Module
Wormhole.tbp.Module = setmetatable({}, {
    __call = function(self)
        return self
    end
})

for _, key in ipairs({'core', 'weapons', 'thrusters', 'utility'}) do
    SMODS.Attribute {
        key = "worm_tbp_"..key,
    }
end

Wormhole.tbp.Module = SMODS.Consumable:extend{
    required_params = {
        'key',
        'slot',
        'durability'
    },
    set = "tbp_module",
    atlas = 'centers',
    pos = {x=1, y=0},
    config = {
		extra = {},
	},
    cooldown = false,
    pre_inject_class = function(self, func)
        for _, obj in pairs(self.obj_table) do
            if obj.set == 'tbp_module' then
                obj.ppu_team = obj.ppu_team or { 'tbp' }
                obj.ppu_artist = obj.ppu_artist or {'mythie'}
                obj.attributes = obj.attributes or {}
                if obj.slot then table.insert(obj.attributes, "worm_tbp_".. obj.slot) end
            end
        end
    end,
    inject = function(self)
        SMODS.Consumable.inject(self)
        G.tbp.module_sprites[self.key] = Sprite(0, 0, G.CARD_W, G.CARD_H,
            G.ASSET_ATLAS['worm_tbp_module'], self.module_pos or {x=9, y=1})
    end,
    can_use = function(self, card)
		return next(SMODS.find_card("j_worm_tbp_spaceship"))
	end,
    use = function(self, card, area, copier)
		local spaceship = SMODS.find_card("j_worm_tbp_spaceship")
        if next(spaceship) then         
            G.FUNCS.show_module_replace_confirm(card, spaceship[1])
            return {}
        end
	end
}

-- Autmoatically prefix modules with '_tbp_'
-- TODO: modify this if we ever extend past the event
local smods_add_prefixes = SMODS.add_prefixes
function SMODS.add_prefixes(cls, obj, from_take_ownership)
    if cls == Wormhole.tbp.Module then
        SMODS.modify_key(obj, 'tbp', nil, 'key')
    end
    smods_add_prefixes(cls, obj, from_take_ownership)
end

---- MODULES ----

-- CORES --

Wormhole.tbp.Module({
	key = "nebula",
    slot = 'core',
    durability = 5,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 7, y = 5},
	config = {
		extra = {
			amount = 1,
		},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.amount } }
    end,
    module_calculate = function (self, module, context, card)
        if context.wormhome_tbp_module_uninstall and context.card == card and context.module ~= self.slot and context.type == 'failed' then
            Wormhole.tbp.change_durability(card, self.slot, -1)
            return {
                func = function()
                    local visible_hands = {}
                    for _, hand in ipairs(G.handlist) do
                        if SMODS.is_poker_hand_visible(hand) then
                            visible_hands[#visible_hands + 1] = hand
                        end
                    end
                    local _hand = pseudorandom_element(visible_hands, pseudoseed('tbp_nebula_core'))
                    SMODS.smart_level_up_hand(card, _hand, nil, module.amount)
                end
            }
        end
    end
})

Wormhole.tbp.Module({
	key = "astrophage",
    slot = 'core',
    durability = 5,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 6, y = 4},
	config = {
		extra = {
			amount = 1,
		},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.amount } }
    end,
    module_calculate = function (self, module, context, card)
        if context.using_consumeable and context.consumeable and context.consumeable.config.center.set == "Planet" then
            return {
                func = function()
                    local modules = Wormhole.tbp.get_equipped_modules(card)
                    local used_modules = {}
                    for key, module in pairs(modules) do
                        if key ~= self.slot and module.durability < module.total_durability then
                            used_modules[#used_modules+1] = key
                        end
                    end
                    if next(used_modules) then
                        local rand_module = pseudorandom_element(used_modules, pseudoseed('tbp_astrophage'))
                        Wormhole.tbp.change_durability(card, rand_module, module.amount)
                        Wormhole.tbp.change_durability(card, self.slot, -1)
                    end
                end
            }
        end
    end
})

Wormhole.tbp.Module({
    key = "dellinger",
    slot = 'core',
    durability = 3,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 6, y = 5},
    config = {
        extra = {
            amount = 1,
            poker_hand = 'High Card'
        },
    },
    loc_vars = function(self, info_queue, module, card)
        return { vars = { module.ability.extra.amount, localize(Wormhole.tbp.get_dellinger_pokerhand() or "High Card", 'poker_hands') } }
    end,
    module_calculate = function(self, module, context, card)
        if context.before and context.main_eval and context.scoring_name == Wormhole.tbp.get_dellinger_pokerhand() then
            return {
                func = function()
                    local modules = Wormhole.tbp.get_equipped_modules(card)
                    for key, module_data in pairs(modules) do
                        if key ~= self.slot and module_data.durability < module_data.total_durability then
                            Wormhole.tbp.change_durability(card, key, module.amount)
                        end
                    end
                end
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            Wormhole.tbp.change_durability(card, self.slot, -1)
        end
    end
})

Wormhole.tbp.Module({
	key = "black_hole_generator",
    slot = 'core',
    durability = 5,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 0, y = 5},
	config = {
		extra = {
			amount = 2,
		},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.amount } }
    end,
    module_calculate = function (self, module, context, card)
        if context.wormhome_tbp_module_uninstall and context.module ~= self.slot and context.type == 'failed' then
            Wormhole.tbp.change_durability(card, self.slot, -1)
            local modules = Wormhole.tbp.get_equipped_modules(card)
            local restore_amount = module.amount
            for key, module_data in pairs(modules) do
                if key ~= self.slot and key ~= context.module then
                    module_data.total_durability = module_data.total_durability + restore_amount
                    Wormhole.tbp.change_durability(card, key, restore_amount)
                end
            end
        end
    end
})

-- WEAPONS --

Wormhole.tbp.Module({
	key = "void",
    slot = 'weapons',
    durability = 12,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 2, y = 5},
	config = {
		extra = {
			percent = 0.05,
		},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.percent * 100 } }
    end,
    module_calculate = function (self, module, context, card)
        if context.before and G.GAME.current_round.hands_played == 0 then
            local destroyed = pseudorandom(self.key.."_amount", 1, #context.full_hand)
            local hand = SMODS.shallow_copy(context.full_hand)
            for i = 1, destroyed do
                local chosen, index = pseudorandom_element(hand, self.key .. "_destroy")
                SMODS.destroy_cards(chosen)
                table.remove(hand, index)
            end
            Wormhole.tbp.change_durability(card, self.slot, -destroyed)
            return {
                score = math.ceil((G.GAME.blind.chips * module.percent) * destroyed)
            }
        end
    end
})

Wormhole.tbp.Module({
	key = "ballistics",
    slot = 'weapons',
    durability = 25,
	atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 7, y = 4},
	config = {
		extra = {
			perma_bonus = 20,
		},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.perma_bonus } }
    end,
    module_calculate = function (self, module, context, card)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + module.perma_bonus
            Wormhole.tbp.change_durability(card, self.slot, -1)
            return { message = localize('k_upgrade_ex'), colour = G.C.CHIPS }
        end
    end
})

Wormhole.tbp.Module({
	key = "waste",
    slot = 'weapons',
    durability = 5,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 3, y = 4},
	config = {
		extra = {
			mult = 15,
		},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.mult, module.ability.extra.mult * (((G.GAME.tbp or {}).run.modules_failed or {}).total or 0)} }
    end,
    module_calculate = function (self, module, context, card)
        if context.joker_main then
            Wormhole.tbp.change_durability(card, self.slot, -1)
            if (G.GAME.tbp.run.modules_failed.total or 0) > 0 then
                return {
                    mult = G.GAME.tbp.run.modules_failed.total * module.mult
                }
            end
        end
    end
})

Wormhole.tbp.Module({
	key = "salvo",
    slot = 'weapons',
    durability = 4,
	atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 4, y = 5},
	config = {
		extra = {
			xmult = 2,
		},
    },
	loc_vars = function(self, info_queue, module, card)
        local amount = 0
        if card then
            local modules = Wormhole.tbp.get_equipped_modules(card)
            if modules then
                for key, _ in pairs(modules) do
                    amount = amount + 1
                end
            end
        end
		return { vars = { module.ability.extra.xmult, module.ability.extra.xmult ^ amount } }
    end,
    module_calculate = function (self, module, context, card)
        if context.joker_main and #context.scoring_hand == 5 then
            local amount = 0
            local modules = Wormhole.tbp.get_equipped_modules(card)
            if modules then
                for key, _ in pairs(modules) do
                    amount = amount + 1
                    Wormhole.tbp.change_durability(card, key, -1)
                end
            end
            if amount > 0 then -- should always be at least 1 but...
                return {
                    xmult = module.xmult ^ amount
                }
            end
        end
    end
})

-- UTILITY --

Wormhole.tbp.Module({
	key = "hardlight",
    slot = 'utility', 
    durability = 5,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 0, y = 4},
	config = {
		extra = {
			percent = 0.2,
		},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.percent * 100 } }
    end,
    module_calculate = function (self, module, context, card)
        if context.setting_blind or (context.wormhole_tbp_module_install and G.GAME.blind and G.GAME.blind.in_blind) then
            if not module.fired_this_blind then
                module.fired_this_blind = true
                Wormhole.tbp.change_durability(card, self.slot, -1)
                return {
                    xblindsize = 1 - module.percent,
                }
            end
        end
        if context.end_of_round and not context.blueprint and not context.repetition then
            module.fired_this_blind = nil
        end
    end
})

Wormhole.tbp.Module({
	key = "quantum",
    slot = 'utility', 
    durability = 5,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 1, y = 4},
	config = {
		extra = {
			money = 3,
            odds = 2
		},
    },
    loc_vars = function(self, info_queue, module, card)
        local numerator, denominator = SMODS.get_probability_vars(card or module, 1, module.ability.extra.odds, self.key)
		return { vars = { module.ability.extra.money, numerator, denominator } }
    end,
    module_calculate = function (self, module, context, card)
        if context.pseudorandom_result and context.result and context.identifier ~= self.key then
            if SMODS.pseudorandom_probability(card, self.key, 1, module.odds) then
                Wormhole.tbp.change_durability(card, self.slot, -1)
            end
            return {
                dollars = module.money
            }
        end
    end
})

Wormhole.tbp.Module({
	key = "interference",
    slot = 'utility', 
    durability = 1,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 3, y = 5},
	config = {
		extra = {
		},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { } }
    end,
    module_calculate = function (self, module, context, card)
        if context.setting_blind or context.wormhole_tbp_module_install then
            if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.boss then
                Wormhole.tbp.change_durability(card, self.slot, -1)
                return {
                    message = localize('ph_boss_disabled'),
                    func = function()
                        G.GAME.blind:disable()
                    end
                }
            end
        end
    end
})

Wormhole.tbp.Module({
	key = "redundancy",
    slot = 'utility', 
    durability = 5,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 4, y = 4},
	config = {
        extra = {
            depletes = 1
		},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.depletes } }
    end,
    module_calculate = function (self, module, context, card)
        if context.wormhome_tbp_module_change_durability and context.card == card and context.module ~= self.slot then
            if not context.during_uninstall then
                if context.amount < 0 then
                    Wormhole.tbp.change_durability(card, self.slot, -module.depletes)
                    return {
                        modify = 0
                    }
                end
            end
        end
    end
})

-- THRUSTERS --


-- Warp Drive
Wormhole.tbp.Module({
	key = "warp_drive",
    slot = 'thrusters',
    durability = 5,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 1, y = 5},
	config = {
		extra = {
            xmult_gain = 0.75,
            current_xmult = 1
        },
    },
	loc_vars = function(self, info_queue, module, card)
		local xmult_gain = module.xmult_gain or (module.ability and module.ability.extra and module.ability.extra.xmult_gain) or 0.75
		local current_xmult = module.current_xmult or (module.ability and module.ability.extra and module.ability.extra.current_xmult) or 1
		return { vars = { xmult_gain, current_xmult } }
    end,
    module_calculate = function(self, module, context, card)
        module.xmult_gain = module.xmult_gain or 0.75
        module.current_xmult = module.current_xmult or 1

        if context.skip_blind then
            module.current_xmult = module.current_xmult + module.xmult_gain
            return {
                message = localize{type='variable', key='a_xmult', vars={module.current_xmult}},
                colour = G.C.MULT,
                card = card
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            Wormhole.tbp.change_durability(card, self.slot, -1)
        end
        if context.joker_main and module.current_xmult and module.current_xmult > 1 then
            return {
				xmult = module.current_xmult,
                colour = G.C.MULT,
                card = card
            }
        end
    end
})

-- Temporal Jump Thrusters
Wormhole.tbp.Module({
	key = "temporal_jump",
    slot = 'thrusters',
    durability = 5,
	atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 5, y = 5},
	config = {
		extra = {
            tags = 2
        },
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.tags } }
    end,
    module_calculate = function(self, module, context, card)
        if context.skip_blind then
            Wormhole.tbp.change_durability(card, self.slot, -1)
            return {
                func = function()
                    for i = 1, module.tags do
                        add_tag(Tag(get_next_tag_key('tag_skip')))
                    end
                end
            }
        end
    end
})

-- Repeater Engine
Wormhole.tbp.Module({
	key = "repeater",
    slot = 'thrusters',
    durability = 10,
	atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 5, y = 4},
	config = {
		extra = {
			repetitions = 2,
		},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.repetitions } }
    end,
    module_calculate = function (self, module, context, card)
        if context.repetition and context.cardarea == G.play and context.other_card and next(SMODS.get_enhancements(context.other_card)) then
            return {
                repetitions = module.repetitions
            }
        end
        if context.after then
            Wormhole.tbp.change_durability(card, self.slot, -1)
        end
    end
})

-- Anti-Matter Thrusters
Wormhole.tbp.Module({
	key = "antimatter",
    slot = 'thrusters',
    durability = 4,
    atlas = "tbp_module_frame",
	pos = { x = 3, y = 1 },
    module_pos = { x = 2, y = 4},
	config = {
		extra = {},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = {} }
    end,
    module_calculate = function (self, module, context, card)
        if context.after then
            local planet
            for _, center in pairs(G.P_CENTER_POOLS.Planet) do
                if center.config.hand_type == context.scoring_name then
                    planet = center.key
                    if planet then break end
                end
            end

            if planet then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{key = planet, edition = 'e_negative'}              
                        return true
                    end
                }))
                Wormhole.tbp.change_durability(card, self.slot, -1)
            end
        end
    end
})

-- -- Hyperlight Rotors
-- Wormhole.tbp.Module({
-- 	key = "hyperlight_rotors",
--     slot = 'thrusters',
--     durability = 10,
-- 	-- pos = { x = 0, y = 0 },
-- 	config = {
-- 		extra = {
--             xmult_per_slot = 1
--         },
--     },
-- 	loc_vars = function(self, info_queue, module, card)
-- 		local empty_slots = G.jokers and (G.jokers.config.card_limit - #G.jokers.cards) or 0
-- 		local current_xmult = 1 + (empty_slots * module.ability.extra.xmult_per_slot)
-- 		return { vars = { module.ability.extra.xmult_per_slot, current_xmult } }
--     end,
--     module_calculate = function(self, module, context, card)
--         if context.joker_main then
--             local empty_slots = G.jokers and (G.jokers.config.card_limit - #G.jokers.cards) or 0
--             if empty_slots > 0 then
--                 return {
-- 					xmult = 1 + (empty_slots * module.xmult_per_slot),
--                     colour = G.C.MULT,
--                     message = localize{type='variable',key='a_xmult',vars={1 + (empty_slots * module.xmult_per_slot)}},
--                     card = card
--                 }
--             end
--         end
--     end
-- })

-- -- Resuited Thruster
-- Wormhole.tbp.Module({
-- 	key = "resuited_thruster",
--     slot = 'thrusters',
--     durability = 25,
-- 	config = {
-- 		extra = {
--             chips = 10
--         },
--     },
-- 	loc_vars = function(self, info_queue, module, card)
--         local suit_name = Wormhole.tbp.get_resuited_thruster_suit()
-- 		local suit_plural = localize(suit_name, 'suits_plural')
-- 		local suit_color = G.C.SUITS[suit_name]
		
-- 		return { vars = { module.ability.extra.chips, suit_plural, colours = { suit_color } } }
--     end,
--     module_calculate = function(self, module, context, card)
--         local current_suit = Wormhole.tbp.get_resuited_thruster_suit()
        
--         if context.individual and context.cardarea == G.play and context.other_card:is_suit(current_suit) then
--             Wormhole.tbp.change_durability(card, self.slot, -1)
--             return {
--                 chips = module.chips,
--                 card = card
--             }
--         end
--     end
-- })

-- UNCATEGORIZED --

-- -- Uncategorized 3
-- Wormhole.tbp.Module({
-- 	key = "uncat3", 
--     slot = 'weapons',
--     durability = 100,
-- 	-- pos = { x = 0, y = 0 },
-- 	config = {
--         extra = {
--             perma_mult = 1
--         },
--     },
-- 	loc_vars = function(self, info_queue, module, card)
-- 		return { vars = { module.ability.extra.perma_mult } }
--     end,
--     module_calculate = function (self, module, context, card)
--         if context.individual and context.cardarea == G.play then
--             context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + module.perma_mult
--             Wormhole.tbp.change_durability(card, self.slot, -1)
--             return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
--         end
--     end
-- })

-- -- Uncategorized 4
-- Wormhole.tbp.Module({
-- 	key = "uncat4", 
--     slot = 'utility',
--     durability = 4,
-- 	-- pos = { x = 0, y = 0 },
-- 	config = {
-- 		extra = {
--             money = 3
--         },
--     },
-- 	loc_vars = function(self, info_queue, module, card)
-- 		return { vars = { module.ability.extra.money } }
--     end,
--     module_calculate = function(self, module, context, card)
--         if context.wormhome_tbp_module_uninstall and context.card == card and context.module ~= self.slot and 
--         context.type == 'failed' then
--             Wormhole.tbp.change_durability(card, self.slot, -1)
--             return {
--                 dollars = module.money
--             }
--         end
--     end
-- })

---- BOOSTERS ----

local booster_module_create_card = function(self, booster, i)
    booster.ability.tbp_current_modules = booster.ability.tbp_current_modules or {
        core = true,
        weapons = true,
        thrusters = true,
        utility = true
    }
    if i == 1 then
        if not next(SMODS.find_card("j_worm_tbp_spaceship")) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card { key = "j_worm_tbp_spaceship" }
                    return true
                end
            }))
        else
            local ship = SMODS.find_card("j_worm_tbp_spaceship")[1]
            local equipped = Wormhole.tbp.get_equipped_modules(ship)
            for mtype, _ in pairs(equipped or {}) do
                booster.ability.tbp_current_modules[mtype] = nil
            end
        end
    end
    
    local attributes = {}
    for mtype, _ in pairs(booster.ability.tbp_current_modules) do
        attributes[#attributes + 1] = "worm_tbp_" .. mtype
    end
    attributes = #attributes > 0 and #attributes < 4 and attributes or nil

    local created_card = SMODS.create_card({
        set = "tbp_module",
        skip_materialize = true,
        key_append = "worm_tbp_module_booster",
        attributes = attributes,
        union = true
    })

    if created_card.config.center.slot then booster.ability.tbp_current_modules[created_card.config.center.slot] = nil end

    return created_card
end

local booster_loc_vars = function(self, info_queue, card)
    if not card.fake_card then info_queue[#info_queue+1] = G.P_CENTERS.j_worm_tbp_spaceship end
    return { vars = { card.ability.choose, card.ability.extra } }
end

tbp_booster_weight_base = 0.5
-- Module boosters
SMODS.Booster({
	key = "module_normal_1",
    config = { extra = 3, choose = 1 },
    atlas = "tbp_boosters",
    pos = { x = 1, y = 0},
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
    weight = tbp_booster_weight_base,
	cost = 4,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
    ppu_team = {'tbp'},
    ppu_artist = {'mythie'}
})

SMODS.Booster({
	key = "module_normal_2",
	config = { extra = 3, choose = 1 },
    atlas = "tbp_boosters",
    pos = { x = 0, y = 0},
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
    weight = tbp_booster_weight_base,
	cost = 4,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
    ppu_team = {'tbp'},
    ppu_artist = {'mythie'}
})

SMODS.Booster({
	key = "module_normal_3",
    config = { extra = 3, choose = 1 },
    atlas = "tbp_boosters",
    pos = { x = 0, y = 1},
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
    weight = tbp_booster_weight_base,
	cost = 4,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
    ppu_team = {'tbp'},
    ppu_artist = {'mythie'}
})

SMODS.Booster({
	key = "module_normal_4",
	config = { extra = 3, choose = 1 },
    atlas = "tbp_boosters",
    pos = { x = 1, y = 1},
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
    weight = tbp_booster_weight_base,
	cost = 4,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
    ppu_team = {'tbp'},
    ppu_artist = {'mythie'}
})

SMODS.Booster({
	key = "module_jumbo_1",
	config = { extra = 5, choose = 1 },
    atlas = "tbp_boosters",
    pos = { x = 2, y = 0},
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
    weight = tbp_booster_weight_base,
	cost = 6,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
    ppu_team = {'tbp'},
    ppu_artist = {'mythie'}
})

SMODS.Booster({
	key = "module_jumbo_2",
	config = { extra = 5, choose = 1 },
    atlas = "tbp_boosters",
    pos = { x = 2, y = 1},
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
    weight = tbp_booster_weight_base,
	cost = 6,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
    ppu_team = {'tbp'},
    ppu_artist = {'mythie'}
})

SMODS.Booster({
	key = "module_mega_1",
	config = { extra = 5, choose = 2 },
    atlas = "tbp_boosters",
    pos = { x = 3, y = 0},
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
    weight = tbp_booster_weight_base / 4,
	cost = 8,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
    ppu_team = {'tbp'},
    ppu_artist = {'mythie'}
})

SMODS.Booster({
	key = "module_mega_2",
	config = { extra = 5, choose = 2 },
    atlas = "tbp_boosters",
    pos = { x = 3, y = 1},
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
    weight = tbp_booster_weight_base / 4,
	cost = 8,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
    ppu_team = {'tbp'},
    ppu_artist = {'mythie'}
})

-- Tag (Added this to use up the final slot)
SMODS.Tag {
    key = "tbp_rocketry",
    min_ante = 1,
    atlas = "worm_tbp_tag",
    ppu_team = {'tbp'},
    ppu_artist = {'ice'},
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_worm_module_mega_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Planet, function()
                local booster = SMODS.create_card { key = 'p_worm_module_mega_1', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}