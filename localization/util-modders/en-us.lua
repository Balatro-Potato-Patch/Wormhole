local depleted = {
    "Depleted after {C:attention}#3#{} uses",
}
local pods = {
    mult = {
	{
	    "When a {C:attention}#1#{} is played",
	    "{C:mult}+#2#{} mult"
	},
	depleted
    },
    chips = {
	{
	    "When a {C:attention}#1#{} is played",
	    "{C:chips}+#2#{} chips"
	},
	depleted
    },
    money = {
	{
	    "When a {C:attention}#1#{} is played",
	    "earn {C:money}$#2#{}"
	},
	depleted
    },
}

return {
    descriptions = {
	PotatoPatch = {
	    t_util_modders = {
		name = "https://shorty.systems/util-modders.webp",
	    },
	    d_wilson = {
		name = "WilsontheWolf",
		text = {
		    {
			"{C:attention}Uncoventional Game Crasher{},",
			"{C:attention}Resident Corn Lover{} and",
			"{C:attention}Occasional Fish Poster",
		    },
		    {
			"Also Checkout:",
			"{C:attention}Metal Pipe Crashing Noise",
		    },
		}
	    },
	    d_cg = {
		name = "cg",
		text = {
		    "hi"
		}
	    },
	    d_frost = {
		name = "frost",
		text = {
		    "hi"
		}
	    },
	    d_metherul = {
		name = "metherul",
		text = {
		    "hi"
		}
	    },
	},
	util_Spaces = {
	    c_worm_util_spaces_basic_mult = {
		name = "Basic Mult Pod",
		text = pods.mult,
	    },
	    c_worm_util_spaces_advanced_mult = {
		name = "Advanced Mult Pod",
		text = pods.mult,
	    },
	    c_worm_util_spaces_pro_mult = {
		name = "Pro Mult Pod",
		text = pods.mult,
	    },
	    c_worm_util_spaces_luxury_mult = {
		name = "Luxury Mult Pod",
		text = pods.mult,
	    },
	    c_worm_util_spaces_basic_chips = {
		name = "Basic Chips Pod",
		text = pods.chips,
	    },
	    c_worm_util_spaces_advanced_chips = {
		name = "Advanced Chips Pod",
		text = pods.chips,
	    },
	    c_worm_util_spaces_pro_chips = {
		name = "Pro Chips Pod",
		text = pods.chips,
	    },
	    c_worm_util_spaces_luxury_chips = {
		name = "Luxury Chips Pod",
		text = pods.chips,
	    },
	    c_worm_util_spaces_basic_money = {
		name = "Basic Money Pod",
		text = pods.money,
	    },
	    c_worm_util_spaces_advanced_money = {
		name = "Advanced Money Pod",
		text = pods.money,
	    },
	    c_worm_util_spaces_pro_money = {
		name = "Pro Money Pod",
		text = pods.money,
	    },
	    c_worm_util_spaces_luxury_money = {
		name = "Luxury Money Pod",
		text = pods.money,
	    },
	},
	Other = {
	    p_worm_util_spaces_normal = {
		name = "Space Pod Pack",
		text = {
		    "Choose {C:attention}#1#{} of up to",
		    "{C:attention}#2#{C:util_spaces} Space Pods",
		},
	    },
	    p_worm_util_spaces_jumbo = {
		name = "Jumbo Space Pod Pack",
		text = {
		    "Choose {C:attention}#1#{} of up to",
		    "{C:attention}#2#{C:util_spaces} Space Pods",
		},
	    },
	    p_worm_util_spaces_mega = {
		name = "Mega Space Pod Pack",
		text = {
		    "Choose {C:attention}#1#{} of up to",
		    "{C:attention}#2#{C:util_spaces} Space Pods",
		},
	    },
	},
	Joker = {
	    j_worm_util_cargo_space = {
		name = "Cargo Space",
		text = {
		    "{C:util_spaces}Space Pods{} take up no space.",
		    " ",
		    "{C:inactive,s:0.8}No, car go road!",
		}
	    },
	}
    },
    misc = {
	dictionary = {
	    b_util_spaces_cards = "Space Pods",
	    k_util_spaces = "Space Pod",
	    k_util_spaces_group = "Space Pod Pack",
	    k_depleted = "Depleted!",
	},
    }
}
