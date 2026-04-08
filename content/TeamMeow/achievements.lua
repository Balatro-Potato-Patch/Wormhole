SMODS.Achievement {
    key = 'rainbow',
    bypass_all_unlocked = true,
    hidden_name = false,
    hidden_text = false,
    unlock_condition = function(self, args)
        return args.type == 'rainbow'
    end
}