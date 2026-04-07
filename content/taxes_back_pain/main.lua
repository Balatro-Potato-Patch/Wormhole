Wormhole.tbp = {}

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
                    local vars = G.P_CENTERS[card.ability.extra.modules[v].key]:loc_vars({}, {ability = {extra = card.ability.extra.modules[v]}}).vars
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
                    local ret = G.P_CENTERS[card.ability.extra.modules[module].key]:calculate(card.ability.extra.modules[module], context)
                    if ret and next(ret) then
                        module_calcs[#module_calcs + 1] = ret
                    end
                end
            end
            if context.after then
                local stabilizer_protected = false
                if card.ability.extra.modules.core.protects_other_modules and card.ability.extra.modules.core.durability_protection_odds then
                    local seed = 'stabilizer_' .. G.GAME.round_resets.ante
                    if SMODS.pseudorandom_probability(card, seed, 1, card.ability.extra.modules.core.durability_protection_odds, 'stabilizer_protection') then
                        stabilizer_protected = true
                        SMODS.calculate_effect({
                            message = 'Protected!',
                            colour = G.C.GREEN
                        }, card)
                    end
                end
                if stabilizer_protected then
                    self:modify_module_durability(card, -1, {'core'})
                else
                    self:modify_module_durability(card, -1)
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

SMODS.ConsumableType {
    key = 'tbp_module',
    collection_rows = { 5, 6 },
    primary_colour = G.C.SET.Spectral, -- TODO: Change color?
    secondary_colour = G.C.SECONDARY_SET.Spectral,
    default = "c_worm_tbp_laser",
}

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

Wormhole.tbp.Module({
	key = "laser",
    slot = 'weapons',
    durability = 3,
	-- pos = { x = 0, y = 0 },
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
	key = "missile_pod",
    slot = 'weapons',
    durability = 4,
	-- pos = { x = 0, y = 0 },
	config = {
		extra = {
			retriggers = 1
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.retriggers } }
	end,
    calculate = function(self, card, context)
		if not card.retriggers then return end
		if context.before and not context.blueprint then
			card.target_joker_id = nil
			local eligible_jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.set == 'Joker' and G.jokers.cards[i] ~= context.blueprint_card then
					table.insert(eligible_jokers, i)
				end
			end
			if #eligible_jokers > 0 then
				card.target_joker_id = pseudorandom_element(eligible_jokers, pseudoseed('missile_pod'))
			end
		end
        if context.retrigger_joker and context.other_card and card.target_joker_id then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == context.other_card and i == card.target_joker_id then
					return {
						message = localize('k_again_ex'),
						repetitions = card.retriggers,
						card = context.other_card
					}
				end
			end
        end
    end,
})

Wormhole.tbp.Module({
	key = "core",
    slot = 'core',
    durability = 3,
	-- pos = { x = 0, y = 0 },
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

Wormhole.tbp.Module({
	key = "salvage_core",
    slot = 'core',
    durability = 5,
	-- pos = { x = 0, y = 0 },
	config = {
		extra = {
			money_per_destruction = 8
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money_per_destruction } }
	end,
    calculate = function(self, card, context)
		return nil
    end,
})

Wormhole.tbp.Module({
	key = "stabilizer",
    slot = 'core',
    durability = 5,
	-- pos = { x = 0, y = 0 },
	config = {
		extra = {
			durability_protection_odds = 3,
			protects_other_modules = true
		},
	},
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.durability_protection_odds, 'stabilizer_protection')
		return { vars = { n .. ' in ' .. d } }
	end,
    calculate = function(self, card, context)
		return nil
    end,
})

Wormhole.tbp.Module({
	key = "deflector",
    slot = 'shields',
    durability = 5,
	-- pos = { x = 0, y = 0 },
	config = {
		extra = {
			blind_reduction = 10,
			durability_loss_odds = 3,
			deflector_applied = false,
		},
	},
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.durability_loss_odds, 'deflector_durability_loss')
		return { vars = { card.ability.extra.blind_reduction, n, d } }
	end,
    calculate = function(self, card, context)
        if not card.durability_loss_odds then return end
        if (context.setting_blind or context.press_play) and not context.blueprint and not self.debuff then
            if G.GAME.blind and G.GAME.blind.chips and not card.deflector_applied then
                G.GAME.blind.chips = G.GAME.blind.chips * 0.9
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                card.deflector_applied = true
                if SMODS.pseudorandom_probability(card, 'deflector_durability_loss', 1, card.durability_loss_odds, 'shields_durability_loss') then
                    card.durability = card.durability - 1
                    if card.durability <= 0 then
                        local spaceship = SMODS.find_card("j_worm_tbp_spaceship")
                        if next(spaceship) then
                            spaceship[1].ability.extra.modules.shields = {}
                            SMODS.calculate_effect({
                                message = localize({type='name_text', set='tbp_module', key='c_worm_tbp_deflector'}) .. ' lost!',
                                colour = G.C.RED
                            }, spaceship[1])
                        end
                    end
                end
            end
        end
        if context.end_of_round and not context.blueprint and not context.repetition then
            card.deflector_applied = false
        end
    end,
})

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