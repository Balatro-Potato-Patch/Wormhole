SMODS.Achievement{ --Spaced Joker
    key = 'stew_spaced_joker',
    bypass_all_unlocked = true,
    hidden_name = false,
    hidden_text = true,
    reset_on_startup = true, --set false after finsihign debugging
    unlock_condition = function (self, args)
        return args.type == 'stew_spaced_joker'
    end
}

SMODS.Achievement{
    key = 'stew_extinction_event',
    bypass_all_unlocked = true,
    hidden_name = false,
    hidden_text = false,
    reset_on_startup = true, --set false after finsihign debugging
    unlock_condition = function (self, args)
        return args.type == 'stew_extinction_event'   
    end
}