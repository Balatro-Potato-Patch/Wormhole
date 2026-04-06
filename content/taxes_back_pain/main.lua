Wormhole.tbp = {}

PotatoPatchUtils.Team({
    name = 'tbp',
    loc = true,
    colour = HEX('99acad'),
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
    config = {consumables = {'c_worm_tbp_laser'}, jokers = {'j_worm_tbp_spaceship'}, consumable_slot = 100},
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
    config = { extra = { modules = { -- TODO: add actual module slots here
        core = {},
        weapons = {},
        thrusters = {},
        shields = {}
    } } },
	loc_vars = function(self, info_queue, card)
        for _, v in ipairs(self.module_types) do
            if card.ability.extra.modules[v].key then
                local vars = G.P_CENTERS[card.ability.extra.modules[v].key]:loc_vars({}, {ability = {extra = card.ability.extra.modules[v]}}).vars
                vars.colours = {darken(Wormhole.tbp.module_colours[v], 0.3)}
                info_queue[#info_queue+1] = {set = 'tbp_module', key = card.ability.extra.modules[v].key .. '_equipped', vars = vars, module_type = v, module_info = card.ability.extra.modules[v]}
            else
                info_queue[#info_queue+1] = {set = 'tbp_module', key = 'c_worm_tbp_module_missing', module_type = v, vars = {colours = {mix_colours(G.ARGS.LOC_COLOURS.inactive, Wormhole.tbp.module_colours[v], 0.5)}}}
            end
        end
        return {vars = {
            self:modules_equipped(card) and 'yes' or 'no',
            'Core: '..(card.ability.extra.modules.core.durability or 'None'), 
            'Weapons: '..(card.ability.extra.modules.weapons.durability or 'None'),
            'Thrusters: '..(card.ability.extra.modules.thrusters.durability or 'None')
        }}
    end,
    modules_equipped = function(self, card)
        return next(card.ability.extra.modules.core) or next(card.ability.extra.modules.weapons) or next(card.ability.extra.modules.thrusters)
    end,
    modify_module_durability = function(self, card, change, modules)
        -- temporary code to test module destruction
        if not modules then modules = self.module_types end
        for _, module in ipairs(modules) do
            if card.ability.extra.modules[module].durability then
                card.ability.extra.modules[module].durability = card.ability.extra.modules[module].durability + change
                if card.ability.extra.modules[module].durability <= 0 then
                    card.ability.extra.modules[module] = {}
                    SMODS.calculate_effect({
                        message = module .. ' lost!',
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
                        SMODS.add_booster_to_shop('p_arcana_normal_1') -- TODO: Replace booster with module one
                        -- TODO: Should it be forced to be open? Tried using
                        -- card:open() but the game doesn't like it
                    return true
                    end
                }))
            end
            local module_calcs = {}
            for _, module in ipairs(self.module_types) do -- TODO: add actual module slots here
                if card.ability.extra.modules[module].key then
                    local ret = G.P_CENTERS[card.ability.extra.modules[module].key]:calculate(card.ability.extra.modules[module], context)
                    if ret and next(ret) then
                        module_calcs[#module_calcs + 1] = ret
                    end
                end
            end
            if context.after then
                self:modify_module_durability(card, -1)
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

SMODS.ConsumableType {
    key = 'tbp_module',
    collection_rows = { 5, 6 },
    primary_colour = G.C.SET.Spectral, -- TODO: Change color?
    secondary_colour = G.C.SECONDARY_SET.Spectral,
}

Wormhole.tbp.Module = SMODS.Consumable:extend{
    required_params = {
        'key',
        'slot',
        'durability'
    },
    set = "tbp_module",
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
            spaceship[1].ability.extra.modules[self.slot] = {
                key = self.key,
                durability = self.durability,
                total_durability = self.durability
            }
            -- spaceship[1].ability.extra.modules[#spaceship[1].ability.extra.modules+1] = {self.key, self.cooldown}
            for k, v in pairs(self.config.extra) do
                spaceship[1].ability.extra.modules[self.slot][k] = v
            end
            SMODS.calculate_effect({
                message = self.slot .. ' equipped!',
                colour = G.C.GREEN
            }, spaceship[1])
        end
	end,
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

Wormhole.tbp.Module({
	key = "laser",
    slot = 'weapons',
    durability = 3,
	pos = { x = 0, y = 0 },
	config = {
		extra = {
			mult = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.mult
            }
        end
    end,
})

Wormhole.tbp.Module({
	key = "core",
    slot = 'core',
    durability = 3,
	pos = { x = 0, y = 0 },
	config = {
		extra = {
			chips = 10,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.chips
            }
        end
    end,
})