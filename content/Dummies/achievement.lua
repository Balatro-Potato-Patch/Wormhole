SMODS.Achievement({
	key = 'dum_timcurry',
	bypass_all_unlocked = true,
	hidden_text = true,
	unlock_condition = function(self, args)
		return args and (type(args.tim) == 'table' and type(args.space) == 'table') and (next(args.tim) and next(args.space))
	end,
})

SMODS.Achievement({
	key = 'dum_seriouscredit',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		return args and args.type == 'dum_clickyclick' and args.amt >= 1000
	end,
})

SMODS.Achievement({
	key = 'dum_unstoppable',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		return args and args.type == 'dum_hyperlight' and (args.level or 0) >= 398
	end,
})
