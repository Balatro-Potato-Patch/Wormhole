SMODS.ConsumableType {
    key = 'util_Spaces',
    default = 'c_worm_util_spaces_basic',
    primary_colour = G.C.SET.Tarot, -- TODO: Fix me
    secondary_colour = G.C.SECONDARY_SET.Tarot, -- TODO: Fix me
    collection_rows = { 5, 6 }, -- TODO: Set this to something approprate
    shop_rate = 0,
}

SMODS.Booster {
    key = "util_spaces_normal_1",
    kind = 'util_Spaces',
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = 3, choose = 1 },
    group_key = "k_util_spaces",
    loc_vars = function(self, info_queue, card)
	local cfg = (card and card.ability) or self.config
	return {
	    vars = { cfg.choose, cfg.extra },
	    key = self.key:sub(1, -3),
	}
    end,
    create_card = function(self, card, i)
	return {
	    set = "util_Spaces",
	    area = G.pack_cards,
	    skip_materialize = true,
	    key_append = "util_spaces_pack"
	}
    end,
}

SMODS.Consumable {
    key = 'util_spaces_basic',
    set = 'util_Spaces',
    pos = { x = 0, y = 0 },
    set_ability = function(self, card, initial, delay_sprites)
	card.ability.seed = pseudorandom("worm_util_spaces_speed")
    end,
}
