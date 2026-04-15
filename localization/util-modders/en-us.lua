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
	    d_frost = {
			name = "frost",
			text = {
				{"i do {E:1,C:blue,s:2}stuff{}"},
				not Talisman and {
					"check out {E:1,C:blue}amulet{}",
					"{s:0.8,C:inactive}https://github.com/frostice482/amulet{}"
				}
				or not Talisman.Amulet and {
					"what? u stil use {C:red}talisman{}??",
					"use {E:1,C:blue}amulet{} instead!!!!!",
					"{s:0.8,C:inactive}https://github.com/frostice482/amulet{}"
				}
				or {
					"thx for using {E:1,C:blue}amulet{} :)"
				}
			},
		},
	    d_metherul = {
		name = "ethangreen-dev",
		text = {
		    {
			" /\\_/\\",
			" ( o.o )",
			" > ^ <",
		    },
		    {
			"Try out",
			"{C:attention}lovely-injector{}",
		    },
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
	},
	Voucher = {
	    v_worm_util_better_craftmanship = {
		name = "Better Craftmanship",
		text = {
		    "{C:util_spaces}Space Pods{} start with",
		    "twice as many uses",
		}
	    },
	    v_worm_util_dealer_contact = {
		name = "Dealer Contact",
		text = {
		    "{C:attention}Space Pod Packs{} always",
		    "contain a {C:util_spaces}Space Pod",
		    "for your most",
		    "played {C:attention}poker hand",
		}
	    },
	},
	Back = {
		b_worm_util_black_hole = {
			name = "Black Hole Deck",
			text = {
				"{C:attention}Hand levelups{} gains",
				"additional {C:blue}+#1# level{}"
			}
		}
	},
	Stake = {
		stake_worm_util_void = {
			name = "Void Stake",
			text = {
				"{C:blue}Planet Cards{} and {C:blue}Celestial Boosters{}",
				"{C:attention}do not appear{} in the shop",
				"{s:0.8}Applies all previous Stakes"
			}
		}
	},
	Tag = {
		tag_worm_util_pod_pack = {
			name = "Pod Pack",
			text = {
				"Gives a free",
				"{C:attention}Space Pod Pack{}",
			}
		}
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
