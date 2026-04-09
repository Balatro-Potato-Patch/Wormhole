Wormhole.tbp = {}
Wormhole.tbp.config = SMODS.current_mod.config

if Wormhole.tbp.config.swap_buttons == nil then
    Wormhole.tbp.config.swap_buttons = false
end
SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = {
            align = "cm",
            padding = 0.05,
            colour = G.C.CLEAR,
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle({
                                label = "Swap Module Button Layout",
                                ref_table = Wormhole.tbp.config,
                                ref_value = "swap_buttons",
                                info = {"Swaps Yes/No button positions", "in module confirmation dialogs"}
                            }),
                        }
                    }
                }
            }
        }
    }
end

PotatoPatchUtils.Team({
    name = 'tbp',
    loc = true,
    colour = HEX('99acad'),
    credit_rows = {4, 3}
})

PotatoPatchUtils.Developer({
    name = 'eremel',
    team = 'tbp',
    loc = true,
})

PotatoPatchUtils.Developer({
    name = 'n',
    team = 'tbp',
    loc = true,
})

PotatoPatchUtils.Developer({
    name = 'sdm',
    team = 'tbp',
    loc = true,
})

PotatoPatchUtils.Developer({
    name = 'dilly',
    team = 'tbp',
    loc = true,
})

PotatoPatchUtils.Developer({
    name = 'ice',
    team = 'tbp',
    loc = true,
})

PotatoPatchUtils.Developer({
    name = 'rsnow',
    team = 'tbp',
    loc = true,
})

PotatoPatchUtils.Developer({
    name = 'mythie',
    team = 'tbp',
    loc = true,
})

--- DEBUG PURPOSE ONLY
--- DON'T FORGET TO REMOVE BEFORE SUBMITTING ---

SMODS.Back{
    key = "spaceship_deck",
    pos = {x = 0, y = 0},
    config = {consumables = {}, jokers = {'j_worm_tbp_spaceship'}, consumable_slot = 100},
}

---

-- TODO: add actual module slots and colours here
Wormhole.tbp.module_colours = {
    weapons = G.C.PURPLE,
    core = G.C.BLUE,
    thrusters = G.C.GREEN,
    shields = G.C.YELLOW
}

SMODS.Joker({
	key = "tbp_spaceship",
	rarity = 4, -- TODO: Does it need its own rarity?
	cost = 1,
	unlocked = true,
	discovered = false,
    --no_collection = true, -- TODO: Does it have to show up in collection?
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
    ppu_team = {'tbp'},
    module_types = {'core', 'weapons', 'shields', 'thrusters'}, -- TODO: add actual module slots here
    config = {
        card_limit = 1,
        extra = {
            modules = { -- TODO: add actual module slots here
                core = {},
                weapons = {},
                thrusters = {},
                shields = {}
            }
        },
    },
	loc_vars = function(self, info_queue, card)
        if not card.fake_card then
            info_queue[#info_queue + 1] = G.P_CENTERS["p_worm_module_normal_1"] -- TODO: Change to poll winner
            for _, v in ipairs(self.module_types) do
                if card.ability.extra.modules[v].key then
                    local vars = G.P_CENTERS[card.ability.extra.modules[v].key]:loc_vars(info_queue, {ability = { extra = card.ability.extra.modules[v] } }, card).vars
                    vars.colours = {darken(Wormhole.tbp.module_colours[v], 0.3)}
                    info_queue[#info_queue+1] = {set = 'tbp_module', key = card.ability.extra.modules[v].key .. '_equipped', vars = vars, module_type = v, module_info = card.ability.extra.modules[v]}
                else
                    info_queue[#info_queue+1] = {set = 'tbp_module', key = 'c_worm_tbp_module_missing', module_type = v, vars = {colours = {mix_colours(G.ARGS.LOC_COLOURS.inactive, Wormhole.tbp.module_colours[v], 0.5)}}}
                end
            end
        end
        local modules = self:modules_equipped(card)
        return {
            vars = {
                colours = {modules and G.ARGS.LOC_COLOURS.inactive or G.C.UI.TEXT_DARK, modules and mix_colours(G.ARGS.LOC_COLOURS.inactive, G.ARGS.LOC_COLOURS.attention, 0.65) or G.ARGS.LOC_COLOURS.attention},
                localize{type = 'name_text', set = 'Other', key = 'p_worm_module_normal_1'} -- TODO: Change to poll winner
            }
        }
    end,
    modules_equipped = function(self, card)
        return next(card.ability.extra.modules.core) or next(card.ability.extra.modules.weapons) or next(card.ability.extra.modules.thrusters)
    end,
    modify_module_durability = function(self, card, change, modules)
        -- temporary code to test module destruction
        if not modules then modules = self.module_types end
        for _, module in ipairs(modules) do
            if card.ability.extra.modules[module].durability and not card.ability.extra.modules[module].durability_loss_odds then
                card.ability.extra.modules[module].durability = card.ability.extra.modules[module].durability + change
                if card.ability.extra.modules[module].durability <= 0 then
                    if card.ability.extra.modules.core.key == 'c_worm_tbp_salvage_core' and card.ability.extra.modules.core.money_per_destruction then
                        ease_dollars(card.ability.extra.modules.core.money_per_destruction)
                        SMODS.calculate_effect({
                            message = localize('$') .. card.ability.extra.modules.core.money_per_destruction,
                            colour = G.C.MONEY
                        }, card)
                    end
                    card.ability.extra.modules[module] = {}
                    SMODS.calculate_effect({
                        message = localize({type='name_text', set='tbp_module', key=card.ability.extra.modules[module].key}) .. ' lost!',
                        colour = G.C.RED
                    }, card)
                end
            end
        end
    end,
	calculate = function(self, card, context)
		if not context.blueprint then
            if context.starting_shop and not self:modules_equipped(card) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.3, 0.5)
                        SMODS.add_booster_to_shop("p_worm_module_normal_" .. (math.random(1,2)))
                    return true
                    end
                }))
            end
            local module_calcs = {}
            for _, module in ipairs(self.module_types) do -- TODO: add actual module slots here
                if card.ability.extra.modules[module].key then
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
		if next(SMODS.find_card("j_worm_tbp_spaceship")) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:remove()
                    return true
                end
            }))
        end
	end,
	in_pool = function(self, args)
		return false
	end,
})

---- Module Functionality ----

---Changes current module durability and handles tracking of game globals for durability changes
---@param module_type any
---@param change any
---@param abs any
---@param silent any
function Wormhole.tbp.change_durability(module_type, change, abs, silent)
    local ship = SMODS.find_card("j_worm_tbp_spaceship")[1]
    if ship and ship.ability.extra.modules[module_type] and ship.ability.extra.modules[module_type].durability then
        ship.ability.extra.modules[module_type].durability = ship.ability.extra.modules[module_type].durability + change
        if change < 0 then
            G.GAME.tbp.run.durability_lost.total = G.GAME.tbp.run.durability_lost.total + change
            G.GAME.tbp.run.durability_lost[module_type] = G.GAME.tbp.run.durability_lost[module_type] and G.GAME.tbp.run.durability_lost[module_type] + 1 or change
        end

        if ship.ability.extra.modules[module_type].durability <= 0 then
            Wormhole.tbp.uninstall_module(module_type, "failed", silent)
        end
    end
end

--- Add module to ship and log changes. Trigger effects based on install type
---@param module Card Module Object.
---@param card Card Module Consumable card
---@param install_type string Type of install. Currently only 'Default'
---@param silent boolean disable notifications, tracking and events
function Wormhole.tbp.install_module(module, card, install_type, silent)
    local ship = SMODS.find_card("j_worm_tbp_spaceship")[1]
    if ship then
        local old_module_key = ship[1].ability.extra.modules[module.slot].key or nil

        if not silent then
            G.GAME.tbp.run.modules_installed.total = G.GAME.tbp.run.modules_installed.total + 1
            G.GAME.tbp.run.modules_installed[module.slot] = G.GAME.tbp.run.modules_installed[module.slot] and G.GAME.tbp.run.modules_installed[self.slot] + 1 or 1
            G.GAME.tbp.run.last_module_installed = module.key

            SMODS.calculate_context({wormhome_tbp_module_install = true, card = ship, module = module, type = install_type})
        end

        if old_module_key ~= nil then
            Wormhole.tbp.uninstall_module(module.slot, 'override', silent)
        end

        G.FUNCS.show_module_replace_confirm(
            old_module_key,
            module.key,
            card,
            module,
            module.slot,
            ship[1]
        )
        return {}
    end
end

---Remove a module and log the change. Trigger effects based on uninstall type
---@param module any
---@param uninstall_type any
---@param silent any
function Wormhole.tbp.uninstall_module(module, uninstall_type, silent)
    local ship = SMODS.find_card("j_worm_tbp_spaceship")[1]
    local module_key = ship.ability.extra.modules[module].key or nil
    if ship.ability.extra.modules[module] then

        if not silent then
            SMODS.calculate_context({wormhome_tbp_module_uninstall = true, card = ship, module = module, type = uninstall_type})
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
    collection_rows = { 5, 6 },
    primary_colour = G.C.SET.Spectral, -- TODO: Change color?
    secondary_colour = G.C.SECONDARY_SET.Spectral,
    default = "c_worm_tbp_laser",
}

-- This is here because I want LSP defs but we can remove it later - N'
---@class Wormhole.tbp.Module: SMODS.Consumable
---@field module_calculate? fun(self: Wormhole.tbp.Module|table, module: table, context: CalcContext|table, card?: Card|table): table?, boolean?
---@field loc_vars? fun(self: Wormhole.tbp.Module|table, info_queue: table, module: table, card?: Card|table): table?
---@field durability? number
---@field slot? 'core'|'weapons'|'shields'|'thrusters'
---@overload fun(self: Wormhole.tbp.Module): Wormhole.tbp.Module
Wormhole.tbp.Module = setmetatable({}, {
    __call = function(self)
        return self
    end
})


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
                obj.ppu_team = obj.ppu_team or {'tbp'}
            end
        end
    end,
    can_use = function(self, card)
		return next(SMODS.find_card("j_worm_tbp_spaceship"))
	end,
    use = function(self, card, area, copier)
		local spaceship = SMODS.find_card("j_worm_tbp_spaceship")
        if next(spaceship) then
            local old_module_key = spaceship[1].ability.extra.modules[self.slot].key or nil
            
            G.FUNCS.show_module_replace_confirm(
                old_module_key,
                self.key,
                card,
                self,
                self.slot,
                spaceship[1]
            )
            return {}
        end
	end,
    set_ability = function(self, card) -- TODO: remove when art is complete
        if self.atlas == 'centers' then
            card.canvas_text = {
                SMODS.CanvasSprite({
                    text_colour = G.C.RED,
                    text = localize('tbp_module_'..self.slot),
                    text_offset = {x = 36, y = 20},
                    text_width = 26,
                    text_height = 20,
                }),
                SMODS.CanvasSprite({
                    text_colour = G.C.BLUE,
                    text = localize({type = 'name_text', set = 'tbp_module', key = self.key}),
                    text_offset = {x = 36, y = 60},
                    text_width = 60,
                    text_height = 20,
                })
            }
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

-- WEAPONS --

-- Uncategorized 1
Wormhole.tbp.Module({
	key = "uncat1", -- TODO: Replace name
    slot = 'weapons',
    durability = 10,
	-- pos = { x = 0, y = 0 },
	config = {
		extra = {
			repetitions = 2,
		},
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.repetitions } }
    end,
    module_calculate = function (self, module, context, card)
        if context.repetition and context.cardarea == G.play and next(SMODS.get_enhancements(context.other_card)) then
            return {
                repetitions = module.repetitions
            }
        end
        if context.after then
            Wormhole.tbp.change_durability(self.slot, -1)
        end
    end
})

-- Uncategorized 2
Wormhole.tbp.Module({
	key = "uncat2", -- TODO: Replace name
    slot = 'weapons',
    durability = 4,
	-- pos = { x = 0, y = 0 },
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
                Wormhole.tbp.change_durability(self.slot, -1)
            end
        end
    end
})

-- Uncategorized 3
Wormhole.tbp.Module({
	key = "uncat3", -- TODO: Replace name
    slot = 'weapons',
    durability = 100,
	-- pos = { x = 0, y = 0 },
	config = {
        extra = {
            perma_mult = 1
        },
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.perma_mult } }
    end,
    module_calculate = function (self, module, context, card)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + module.perma_mult
            Wormhole.tbp.change_durability(self.slot, -1)
            return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
        end
    end
})

-- Uncategorized 4
Wormhole.tbp.Module({
	key = "uncat4", -- TODO: Replace name
    slot = 'shields',
    durability = 4,
	-- pos = { x = 0, y = 0 },
	config = {
		extra = {
            money = 3
        },
    },
	loc_vars = function(self, info_queue, module, card)
		return { vars = { module.ability.extra.money } }
    end,
    module_calculate = function(self, module, context, card)
        if context.wormhome_tbp_module_uninstall and context.card == card and context.module ~= self.slot and 
        context.type == 'failed' then
            Wormhole.tbp.change_durability(self.slot, -1)
            return {
                dollars = module.money
            }
        end
    end
})

-- UTILITY --

-- THRUSTERS --

---- BOOSTERS ----

local booster_module_create_card = function(self, card, i)
    if i == 1 and not next(SMODS.find_card("j_worm_tbp_spaceship")) then
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.add_card { key = "j_worm_tbp_spaceship" }
                return true
            end
        }))
    end
    return SMODS.create_card({
        set = "tbp_module",
        skip_materialize = true,
        key_append = "worm_tbp_module_booster"
    })
end

local booster_loc_vars = function(self, info_queue, card)
    if not card.fake_card then info_queue[#info_queue+1] = G.P_CENTERS.j_worm_tbp_spaceship end
    return { vars = { card.ability.choose, card.ability.extra } }
end

-- Module boosters
SMODS.Booster({
	key = "module_normal_1",
    config = { extra = 3, choose = 1 },
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
	cost = 4,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
})

SMODS.Booster({
	key = "module_normal_2",
	config = { extra = 3, choose = 1 },
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
	cost = 4,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
})

SMODS.Booster({
	key = "module_jumbo_1",
	config = { extra = 5, choose = 1 },
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
	cost = 6,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
})

SMODS.Booster({
	key = "module_mega_1",
	config = { extra = 5, choose = 2 },
    loc_vars = booster_loc_vars,
	group_key = "k_worm_tbp_module",
	cost = 8,
    kind = "worm_tbp_module",
	create_card = booster_module_create_card,
})