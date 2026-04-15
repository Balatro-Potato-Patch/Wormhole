SMODS.Achievement{ --Spaced Joker
    key = 'stew_spaced_joker',
    bypass_all_unlocked = true,
    hidden_name = false,
    hidden_text = true,
    unlock_condition = function (self, args)
        return args.type == 'stew_spaced_joker'
    end
}

SMODS.Achievement{ --Extinction Event
    key = 'stew_extinction_event',
    bypass_all_unlocked = true,
    hidden_name = false,
    hidden_text = false,
    unlock_condition = function (self, args)
        return args.type == 'stew_extinction_event'
    end
}

SMODS.Achievement{ --True Communist
    key = 'stew_true_communist',
    bypass_all_unlocked = true,
    hidden_text = false,
    hidden_name = false,
    unlock_condition = function (self, args)
        return args.type == 'stew_true_communist'
    end
}

SMODS.Achievement{ --Perpetual Stew
    key = 'stew_perpetual_stew',
    bypass_all_unlocked = true,
    hidden_text = false,
    hidden_name = false,
    unlock_condition = function (self, args)
        return args.type == 'stew_stew' and args.value >= 10
    end
}