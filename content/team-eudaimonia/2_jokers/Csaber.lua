if ( SMODS.Mods["MyDreamJournal"] or {} ).can_load then
    if not MyDreamJournal then
        MyDreamJournal = {}
    end
    syndiejournal = MyDreamJournal
else
    syndiejournal = {}
    syndiejournal.multmodkeys = {
        ['mult'] = 'add', ['h_mult'] = 'add', ['mult_mod'] = 'add',
        ['x_mult'] = 'mult', ['xmult'] = 'mult', ['Xmult'] = 'mult', ['x_mult_mod'] = 'mult', ['Xmult_mod'] = 'mult',
        ['e_mult'] = 'expo', ['emult'] = 'expo', ['Emult_mod'] = 'expo',
        ['ee_mult'] = 'tetra', ['eemult'] = 'tetra', ['EEmult_mod'] = 'tetra',
        ['eee_mult'] = 'penta', ['eeemult'] = 'penta', ['EEEmult_mod'] = 'penta',
        ['hypermult'] = 'hyper', ['hyper_mult'] = 'hyper', ['hypermult_mod'] = 'hyper',
        -- Other mods can add their custom operations to this table.
    }
    syndiejournal.chipmodkeys = {
        ['chips'] = 'add', ['h_chips'] = 'add', ['chip_mod'] = 'add',
        ['x_chips'] = 'mult', ['xchips'] = 'mult', ['Xchip_mod'] = 'mult',
        ['e_chips'] = 'expo', ['echips'] = 'expo', ['Echip_mod'] = 'expo',
        ['ee_chips'] = 'tetra', ['eechips'] = 'tetra', ['EEchip_mod'] = 'tetra',
        ['eee_chips'] = 'penta', ['eeechips'] = 'penta', ['EEEchip_mod'] = 'penta',
        ['hyperchips'] = 'hyper', ['hyper_chips'] = 'hyper', ['hyperchip_mod'] = 'hyper',
        -- Other mods can add their custom operations to this table.
    }
    syndiejournal.keystonumbers = {
        ["add"] = -1, ["mult"] = 0, ["expo"] = 1, ["tetra"] = 2, ["penta"] = 3, ["hyper"] = 4
    }
    -- slop
    local slop_key = {
        'MDJ_amount',
        'MDJ_key',
    }
    for _, v in ipairs(slop_key) do
        table.insert(SMODS.other_calculation_keys or SMODS.calculation_keys or {}, v)
        if SMODS.silent_calculation then
            SMODS.silent_calculation[v] = true
        end
    end
    local sslopcalc = SMODS.update_context_flags
    SMODS.update_context_flags = function(context, flags)
        if flags.MDJ_key then context.MDJ_key = flags.MDJ_key end
        if flags.MDJ_amount then context.MDJ_amount = flags.MDJ_amount end
        if flags.MDJ_og_key then context.MDJ_og_key = flags.MDJ_og_key end
        return sslopcalc(context, flags)
    end
    local vanilla_jank_fixer = Card.calculate_joker
    function Card.calculate_joker(self, context)
        local ret = vanilla_jank_fixer(self, context)
        if not (self.config.center.mod or self.config.original_mod) and type(ret) == "table" then
            if ret.Xmult_mod then
                ret.x_mult = ret.Xmult_mod
                ret.Xmult_mod = nil
                ret.message = nil
            end
            if ret.mult_mod then
                ret.mult = ret.mult_mod
                ret.mult_mod = nil
                ret.message = nil
            end
            if ret.chip_mod then
                ret.chips = ret.chip_mod
                ret.chip_mod = nil
                ret.message = nil
            end
        end
        return ret
    end
    local calcindiveffectref = SMODS.calculate_individual_effect
    SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
        local is_demicolon = nil
        -- a scored_card could SOMEHOW not have a center, therefor crashing the game without these checks >:(
        if scored_card and scored_card.config and scored_card.config.center then
            is_demicolon = (scored_card.config.center.key == "j_cry_demicolon")
        end
        if key and amount and key ~= 'MDJ_key' and key ~= 'MDJ_amount' and not effect.no_alter then
            local alter = SMODS.calculate_context({MDJ_mod_key_and_amount = true, MDJ_amount = amount, MDJ_key = key, demicolon_racism = is_demicolon})
            key = (alter and alter.MDJ_key) or key
            amount = (alter and alter.MDJ_amount) or amount
        end
        -- slop
        if key == 'MDJ_key' or key == 'MDJ_amount' or key == 'MDJ_og_key' or key == 'MDJ_og_amount' or key == 'from_mindware_lol' then
            return { [key] = amount }
        end
        local ret = calcindiveffectref(effect, scored_card, key, amount, from_edition)
	    if ret then return ret end
    end
end
SMODS.Atlas {
    key = 'euda_csaberatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/CSaber.png', --Update with actual art
}
SMODS.Joker {
    key = "euda_csaber",
    atlas = 'euda_csaberatlas',
    rarity = 2,
    blueprint_compat = true,
    demicolon_compat = true,
    cost = 4,
    discovered = false,
    config = { extra = { chance = 6, add = 60 }, },
    ppu_team = {"TeamEudaimonia"},
    ppu_coder = {'soulware'},
    ppu_artist = {'LasagnaFelidae'},
    pronouns = "he_him",
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
        return { vars = { num, denom, card.ability.extra.add } }
    end,
    calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				chips = card.ability.extra.add
			}
		end
		if context.MDJ_mod_key_and_amount then
            local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
            if not SMODS.pseudorandom_probability(card, 'syndie', num, denom) then
                return
            end
			local key = context.MDJ_key
			local amount = context.MDJ_amount
			if not context.demicolon_racism then
				local operation = syndiejournal.chipmodkeys[key]
				local op_number = syndiejournal.keystonumbers[operation]
				if operation and op_number == -1 then
                    amount = amount+card.ability.extra.add
				end
			end
			return {
				MDJ_amount = amount,
				MDJ_key = key
			}
		end
    end
}