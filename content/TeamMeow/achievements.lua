SMODS.Achievement {
    key = 'meow_rainbow',
    bypass_all_unlocked = true,
    hidden_name = false,
    hidden_text = false,
    unlock_condition = function(self, args)
        return args.type == 'rainbow'
    end
}
SMODS.Achievement {
    key = 'meow_feli',
    bypass_all_unlocked = true,
    hidden_name = false,
    hidden_text = false,
    unlock_condition = function(self, args)
        return args.type == 'feli'
    end
}