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
    config = {consumables = {'c_worm_laser'}, jokers = {'j_worm_spaceship'}, consumable_slot = 100},
}

---

SMODS.Joker({
	key = "spaceship",
	rarity = 4, -- TODO: Does it need its own rarity?
	cost = 1,
	unlocked = true,
	discovered = false,
    --no_collection = true, -- TODO: Does it have to show up in collection?
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
    config = { extra = { modules = {} } },
	loc_vars = function(self, info_queue, center)
        for _, v in ipairs(center.ability.extra.modules) do
            info_queue[#info_queue+1] = G.P_CENTERS[v[1]]
        end
        return { vars = { } }
    end,
	calculate = function(self, card, context)
		if not context.blueprint then
            if context.starting_shop and #card.ability.extra.modules == 0 then
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
            if context.joker_main and card:tbp_has_module("c_worm_laser") then
                return {
                    mult = card.ability.extra.mult,
                }
            end
        end
	end,
    add_to_deck = function(self, card, from_debuff)
		if next(SMODS.find_card("j_worm_spaceship")) then
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
    key = 'module',
    collection_rows = { 5, 6 },
    primary_colour = G.C.SET.Spectral, -- TODO: Change color?
    secondary_colour = G.C.SECONDARY_SET.Spectral,
}

SMODS.Module = SMODS.Consumable:extend{
    set = "module",
    config = {
		extra = {},
	},
    cooldown = false,
    can_use = function(self, card)
		return next(SMODS.find_card("j_worm_spaceship"))
	end,
    use = function(self, card, area, copier)
		local spaceship = SMODS.find_card("j_worm_spaceship")
        if next(spaceship) then
            spaceship[1].ability.extra.modules[#spaceship[1].ability.extra.modules+1] = {self.key, self.cooldown}
            for k, v in pairs(self.config.extra) do
                spaceship[1].ability.extra[k] = v
            end
        end
	end,
}

SMODS.Module({
	key = "laser",
	pos = { x = 0, y = 0 },
	config = {
		extra = {
			mult = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
})