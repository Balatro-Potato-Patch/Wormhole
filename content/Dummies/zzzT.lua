--!! WHEN YOU SEE THIS JOKER: DELETE IT !!--
--!! WHEN YOU SEE THIS JOKER: DELETE IT !!--
--!! WHEN YOU SEE THIS JOKER: DELETE IT !!--
SMODS.Joker{
	key = "dum_debugtest",
	loc_txt = {
		name = "DEBUG{X:purple,C:white}TEST",
		text = {{
			"{C:red}Will Crash your Game!",
			"{C:inactive}Current Test/Function:",
		}, {
			"{C:inactive}#1#",
		}}
	},
    atlas = 'worm_dummies_team', pos = { x = 5, y = 0 },
	draw = function(self, card, layer)
		card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
	end,
    ppu_team = { "dummies" }, ppu_artist = { "flowire" }, ppu_coder = { "flowire" },
    unlocked = true, discovered = true, rarity = 1, cost = 1242,
    eternal_compat = false, perishable_compat = false, blueprint_compat = false,
	in_pool = function(self, args) return false end,
	config = {
		extra = {
            debug = 'ERROR',
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.debug, } }
	end,
	load = function(self, card, card_table, other_card)
		-- none
	end,
	set_ability = function(self, card, initial, delay_sprites)
		-- none
	end,
	add_to_deck = function(self, card, from_debuff)
		-- none
	end,
	remove_from_deck = function(self, card, from_debuff)
		-- none
	end,
    calculate = function(self, card, context)
		-- none
    end,
	update = function(self, card, dt)
		-- none
	end,
}
